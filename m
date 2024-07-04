Return-Path: <netdev+bounces-109197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76379274DC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B0C1C21186
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4FC1AC256;
	Thu,  4 Jul 2024 11:23:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA814A0A3
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092205; cv=none; b=V616IQxtF5hJR0FoZnoWJs1+xEGzg/CAaRglXia+9A+Ito9nl0eKz6PC9ufnN9N6jIp3QF8AmNaZ7rbO803wrYtP1/T1b+ypPJv/cOoP7sttO3Rt3P5qNefxStlBjD06hedxtA+j3yRf6iAgHPbSJFZs2bALMJvnDm4oSLpmvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092205; c=relaxed/simple;
	bh=pVSCAJoecPX1458nCdejVlCMmEZ2e1cX1fQ1zBgWE84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+vcMsyli5wLt9aqBtwxtixRUi3IfZ9ZdNudm2xDv+3Rto+xCbCv9+s2IX4/D6RspeIDKePcrxfSrtijGdeM9jY1TirkGr3B7tUqPZVEs+Xg4f4AJnZy5bE91n9r0xLIAlAIYQxCnXkcpy/f8XwjicmlB0cRQviz4/VUyF2lOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.201])
	by sina.com (10.185.250.23) with ESMTP
	id 6686862100003C11; Thu, 4 Jul 2024 19:23:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6514678913393
X-SMAIL-UIID: DD3994290EBD43A886A3B9D93EBC3288-20240704-192315-1
From: Hillf Danton <hdanton@sina.com>
To: Tom Parkin <tparkin@katalix.com>
Cc: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
Date: Thu,  4 Jul 2024 19:23:03 +0800
Message-Id: <20240704112303.3092-1-hdanton@sina.com>
In-Reply-To: <ZoVGfR6Gx7PLbnn1@katalix.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 13:39:25 +0100 Tom Parkin <tparkin@katalix.com>
> 
> The specific UAF that syzbot hits is due to the list node that the
> list_for_each_safe temporary variable points to being modified while
> the list_for_each_safe walk is in process.
> 
> This is possible due to l2tp_tunnel_closeall dropping the spin lock
> that protects the list mid way through the list_for_each_safe loop.
> This opens the door for another thread to call list_del_init on the
> node that list_for_each_safe is planning to process next, causing
> l2tp_tunnel_closeall to repeatedly iterate on that node forever.
> 
Yeah the next node could race with other thread because of the door.

> In the context of l2tp_ppp, this eventually leads to UAF because the
> session structure itself is freed when the pppol2tp socket is
> destroyed and the pppol2tp sk_destruct handler unrefs the session
> structure to zero.
> 
> So to avoid the UAF, the list can safely be processed using a loop
> which accesses the first entry in the tunnel session list under
> spin lock protection, removing that entry, then dropping the lock
> to call l2tp_session_delete.

Race exists after your patch.

	cpu1				cpu2
	---				---
					pppol2tp_release()

	spin_lock_bh(&tunnel->list_lock);
	while (!list_empty(&tunnel->session_list)) {
		session = list_first_entry(&tunnel->session_list,
					struct l2tp_session, list);
 		list_del_init(&session->list);
 		spin_unlock_bh(&tunnel->list_lock);

 					l2tp_session_delete(session);

 		l2tp_session_delete(session);
 		spin_lock_bh(&tunnel->list_lock);
 	}
 	spin_unlock_bh(&tunnel->list_lock);

