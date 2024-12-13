Return-Path: <netdev+bounces-151906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28F9F19A1
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239AA165E69
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE751AF0B8;
	Fri, 13 Dec 2024 23:09:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522D1AC8AE
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131366; cv=none; b=sjiyFaoF6f7z9G24NYQTyVI/pMV3AQZ3eTktNbIFeJfKOMPEH2xcKBHXVVkjl5o+0YD/fg5BZ+A1YZ28VtTcO4EKcKF/s6Qm4Q03R2hpHNSUZ9i1x5J/B8w0q9eQ6RtBsfRqq5YGjttWc0B3ajhYcc5vYypNIQpmimYhBWjir7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131366; c=relaxed/simple;
	bh=574geqgrCvxBHE53U1Huo+MbTMWwGYYgbCRZYx76LBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jV/DsGs+U/Xbgmu0SmQNxLCWfyW0HY7zvipTbWZ0rxKWKj/H7dwKY/gMm9W3GEwr/W4BpA1sniq0zysUNIm/ZlmMz0kCjycueKsqV5OuYIvoXv4rIKe3pXB2qP63ipbCEDU8g55DCcZuk/MVSsOI5EtmyfYk27iY2AjAfCu3IKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.238])
	by sina.com (10.185.250.23) with ESMTP
	id 675CBE6E00003624; Fri, 14 Dec 2024 07:08:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 512638913054
X-SMAIL-UIID: 3BE65FF4A60141BE9018ABCAC0CE0B48-20241214-070836-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
Cc: edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
Date: Sat, 14 Dec 2024 07:08:20 +0800
Message-Id: <20241213230820.1957-1-hdanton@sina.com>
In-Reply-To: <675b61aa.050a0220.599f4.00bb.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Dec 2024 14:20:26 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117844f8580000

Test fix (https://patchwork.kernel.org/project/netdevbpf/patch/20241212222247.724674-1-edumazet@google.com/ )

#syz test

--- x/drivers/net/tun.c
+++ y/drivers/net/tun.c
@@ -1485,7 +1485,7 @@ static struct sk_buff *tun_napi_alloc_fr
 	skb->truesize += skb->data_len;
 
 	for (i = 1; i < it->nr_segs; i++) {
-		const struct iovec *iov = iter_iov(it);
+		const struct iovec *iov = iter_iov(it) + i;
 		size_t fragsz = iov->iov_len;
 		struct page *page;
 		void *frag;
--

