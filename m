Return-Path: <netdev+bounces-305330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLtrIIq3TGpwogEAu9opvQ
	(envelope-from <netdev+bounces-305330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:23:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D389719090
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SsqbQ9eH;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305330-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305330-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49FA6301D743
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174853264FC;
	Tue,  7 Jul 2026 08:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066131D381
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:23:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412612; cv=none; b=HkSBBJM7ng8bN1wf5BJXj+phFIpk0skUzmxFXLsUmuyobNNAuvswx5VjlaOecdZ3lvL1ed5YS30cAVuhMditgg+qOm/rOb9MmaOj3Aqs3OVNuEwlsMTvd8xwbM3TPSLVszo1qA7+CdBJmogZUo/VCLElbNLnFUmkQ9l0T2eaESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412612; c=relaxed/simple;
	bh=HQgdLCdm7zLQxOAeI2KzFpaJMzKhabZvUHvnPoqlDsQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=prm4k4gy8j8WuQ40ZXJskt9iRBKBKWzmCgEx9PN5hmUxfM1TPDUnBbnDR9O+Sz8vX61I77cxcqYr4WNFwLBtRNeIsNIjtUqWfi1SKo4PJPvWrBn41kwHSusXS5vFpLL93IHMgSWpec0zD2YeZkgLWdtyBXXhRrUJJH0d14Rgetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsqbQ9eH; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51c26012cd0so49568781cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783412608; x=1784017408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=edpuzPNlqLkIiVe8hDiwbrsEC4+WRFM9TrLPB0rzqfk=;
        b=SsqbQ9eHwzvMYS2C+i9GPhTCrihTNCLR1sGL4pn+9VnwwaV/n3IFlJ827LABL5sA5J
         uedUWi2isLJOBxeF4YCQNF9wyFDQWxIxn23TtZD3GtcVir6P0YlmjKvXDz1q3J5+FPmu
         l7QCGC5ZTn1AaZfAVhoE7cQUYOIR2xHTnsQQG1RMi/NgvnPPvxOWnH9phfj2oRX8BzMa
         ZD7yaC6We9Clt+rGbdgktAyyf+LEQ2JevUvkyBDIx5enRygmNDQYfcmPQbrH89PbTBp1
         +ivOPAMio3u7aNezrC/t9lVaOPW2GwF3LqnQIrJkwdd0JoxUN6sBUTzeqW2i1qvNbNAC
         rX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783412608; x=1784017408;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edpuzPNlqLkIiVe8hDiwbrsEC4+WRFM9TrLPB0rzqfk=;
        b=ZA0bmTJhf763W2QnWWHA5LNeW0onqrPc7iI3pX7cqGz01svgU3W3emm/lKHb0wKcYH
         gA0SO0wbXS73cSW4gaWtV4L/oBEKydzzrqQQTcr3x8FAbh0csSoQTCGvY2NShGskadyC
         zTlOBaFsLrXpq0oDoWgmsdpxeRm57v+2hMJT1+idKrLqrKnCE/uJBt9jNutS4sLz6xi4
         th7GhKfaMCenbf8XJ6QxcwnjvYmewatkTS8brDswysYRSdh6Dd49b/xe+NnNVIr+bcZV
         TCK5yE+WnbJlPGzrZMSG5lgAOjdhcvGVNkJXWia973nQFN8FGmmAEtJqEoVmZKopc/RC
         CclA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9N67wYtt0wv7FPEl0tYPGbkwpJ0HNkgjloKZlL4p38QOXzPBqR/dM7nM3A+xlsm2HZJ9yPsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwPC8jRp7P+i6CmQjDFLcDJmpvzbTqcyuH8ch2ds6lLiH7Qnz
	m+I4Ru6yd/QgMo4820sXzNh4Sn4+d0cTKxEZUhdSYIAuGo18U6rKlzuzCc2BUwMXcAv5ICh10Mw
	w+wCmCNqhSFJOwQ==
X-Received: from qtrr15-n2.prod.google.com ([2002:a05:622a:a98f:20b0:51c:f5f:5d2c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3cf:b0:50d:900e:c1c1 with SMTP id d75a77b69052e-51c747ca072mr45429201cf.7.1783412607802;
 Tue, 07 Jul 2026 01:23:27 -0700 (PDT)
Date: Tue,  7 Jul 2026 08:23:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707082327.3238690-1-edumazet@google.com>
Subject: [PATCH net] net: hsr: fix memory leak on slave unregistration by
 removing synced VLANs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+456957213f32970c0762@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+456957213f32970c0762@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,456957213f32970c0762];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D389719090

When an HSR master device is brought UP, it auto-adds VLAN 0 via
vlan_vid0_add(), which propagates VID 0 to its slave devices.

If a slave device is later unregistered while HSR is active (e.g., during
netns cleanup or interface destruction), hsr_del_port() is called to
detach the slave port from the HSR master. However, hsr_del_port() currently
does not delete the VLAN IDs that were synced to the slave device by HSR.

As a result, the slave device retains a refcount on VID 0 (and any other
synced VLANs). When the slave device is destroyed, its vlan_info /
vlan_vid_info structure remains allocated, leading to a memory leak.

Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
hsr_del_port() before unlinking the slave device, matching the cleanup
behavior in bonding and team drivers.

Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/hsr/hsr_slave.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72f07b1997b80c85db16d812fbda488..2d1e3ea72088e35d5d870b4cc86dd2f789670394 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -242,6 +242,7 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_rx_handler_unregister(port->dev);
 		if (!port->hsr->fwd_offloaded)
 			dev_set_promiscuity(port->dev, -1);
+		vlan_vids_del_by_dev(port->dev, master->dev);
 		netdev_upper_dev_unlink(port->dev, master->dev);
 		if (hsr->prot_version == PRP_V1 &&
 		    port->type == HSR_PT_SLAVE_B) {
-- 
2.55.0.795.g602f6c329a-goog


