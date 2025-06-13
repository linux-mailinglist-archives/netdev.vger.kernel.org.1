Return-Path: <netdev+bounces-197329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92127AD8211
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E863A0E73
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3EA1DE3D9;
	Fri, 13 Jun 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO8Kuiio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1972605;
	Fri, 13 Jun 2025 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788658; cv=none; b=nUmiEMh0/fWjp2fwZ5e9dhCE0jiRUP0pgKaX7AzIJgKk0csdOOdjeOksZSXJ7UwQqQVy0NPrqtwBOcYTR6rzvQtkWEit+AEmAUJ6etPSJHlqSOMnjWBYyRIjO1dxtqXwmlugSJ2uvStR/KYrjGBu6xKDYn/AzPRKAHyg+WUi8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788658; c=relaxed/simple;
	bh=9WfR27PwQnnXFP0cPMqpa5aEzd+47IfBL2wvlAkX/IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naIlN1JQTbq2BESvjUzPBZN67QZRxOvJapEb/O8u5skXJ8OKYv23+Hyd4KKD9XLA1/3qSu7OpBZiMGI3j4bOzgFVGSGcxH6Uj+m9SVS3C/4Hq47DFfZ+slKA6igEsbjmk21QUPqiWgEPKO/4EytoS/ddUqkn/jY5v21wXx+OHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO8Kuiio; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so1393893a91.3;
        Thu, 12 Jun 2025 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749788654; x=1750393454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imtkOhXyjmYAYZR+a3OOwzV/+KOk0zq21faxkUA/aSY=;
        b=cO8KuiioeZLtYvIyGX+w8la/uWtSBKIVlQHkqABfYxvlpoTcYWs6jAvq4HSWC5Huqx
         NyyiZZKRJnIdJRYyGJ0se5SbTnkO/fBSDuHwPUMBY8q33HFveYiGRr9jGG7h5qXCC95z
         Duusje20R1TYFmozGXwLkQDDezIWof8CKe85rwahrTvyBdcdUKP/z6bOav6GWg4bTYgC
         D8NC1LMv1s54UWxy/AlQFtv4Qip4HXSBNIfE5Lo/xv56be8STzh5qt3xdpogJYGZrI8q
         WZUIMDog19lO+eUnjUJTRu+vtcdXT1nmWMfepa2Y4VPZmhBYaNOCb5QTdJwaj40/xxzE
         STzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788654; x=1750393454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imtkOhXyjmYAYZR+a3OOwzV/+KOk0zq21faxkUA/aSY=;
        b=beCuB3a/YuLFNRwr6KRENBl6qNoBuBrqd+mWlS+4TV4dDkkKhZvn76Klk9MSnKmXm6
         tcnNBGZfugy8VhfsvSvApwTVKRIzfwQ/ckjUZ6i3wvMLI/Nq9Yu09xiXuz/VRdEphMJ7
         F8cT20U+zy0sUQQFmxPh8I4fFpaE6GyZB6OplBH0ao8Y7gKHZVm3tOao2k9F+z6GW+2P
         X+bPq/pgxSXHCNroqDhwEzZrSR0C0rFaMhZZHyc87Jg1qcccua6lVP4Euu8YMUxfJxSS
         RAIggVrNaN54raPpMyiUTJKNlWImxf6d2HBLyU3HQSirmJAIgkhzXc/aRHN7+TLFcEab
         9deg==
X-Forwarded-Encrypted: i=1; AJvYcCU02aagDTPKiN9APJ4A/UBpJ/ndO9+1z809OCqY9iRbqp/yPI7YeLGrcNbxuWxuRow1ld5oJVrk@vger.kernel.org, AJvYcCXKjMYCJxl93AMc11UVLTkKqr3OjcoRaHxduFmpk/pgPCVVM7b6Lo60OzXd8eTa8LDZwe7KDsRWM5mWgWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN56tQU5GJgvx19+8sVORsxWxgLwMkC8UThRCT74iTAHN0V0dv
	JMZhkGN6cYiTr5qqrEl4QLw7Mcrs5ioXcgE9hXsrZW9UhBN/Tsel7Vo=
X-Gm-Gg: ASbGncuUtnGHcQ6lquU8EtiLsfpGF5MFWhDgiqy5hnFwDoeFo1oz9+hRDNYLByxIVsu
	KlWT9DwyAvoj/0XPM5pVpE1UlE7m2pzljz5xQnE3hTp1fk9V+WaO3wwm6luJcLf4YnBtJjeU5bx
	g5sEvYhE4ETdOpcRpQUGxrTkORcj953PuD+k9kmwL98J8bIKa4+mUYiS2rxTtK+eOfBwVJX448r
	O6nUWc8X6ZWZk4EDidxKimVYvQyzEPafJnD18sA/34E87zeWMwbLyw5q4ni9G5JjmNiOIuq67/a
	YYIHnXdOaPMrhkfoJIGZPjHiU0pySkciPmzIypU=
X-Google-Smtp-Source: AGHT+IGfIFGuftnbo6YE/G05mz2as9KbzI6XKO8kk2mOX3osESTMXnIHtE/Tmbn44RJoL5k4PFj2Sw==
X-Received: by 2002:a17:90a:d2ce:b0:313:20d2:c99b with SMTP id 98e67ed59e1d1-313d9c271a6mr2662448a91.9.1749788653754;
        Thu, 12 Jun 2025 21:24:13 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1972sm5580895ad.55.2025.06.12.21.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 21:24:13 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Cc: 3chas3@gmail.com,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [atm?] KMSAN: uninit-value in atmtcp_c_send
Date: Thu, 12 Jun 2025 21:24:05 -0700
Message-ID: <20250613042412.328342-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <684b9f72.050a0220.be214.0299.GAE@google.com>
References: <684b9f72.050a0220.be214.0299.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: syzbot <syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com>
Date: Thu, 12 Jun 2025 20:48:02 -0700
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
> Tested-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         27605c8c Merge tag 'net-6.16-rc2' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d17682580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=42d51b7b9f9e61d
> dashboard link: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=129e7682580000
> 
> Note: testing is done by a robot and is best-effort only.

I noticed the original code didn't call dev_kfree_skb() and leaked
sk_buff_head.

Also, most of the ATM drivers don't call atm_return() to revert
the memory accounting by atm_account_tx() in vcc_sendmsg(), but
that's another bug...

#syz test

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index d4aa0f353b6c..5ce3c6c066e1 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,11 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (skb->len < sizeof(struct atmtcp_hdr)) {
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {

