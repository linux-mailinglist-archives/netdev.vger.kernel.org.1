Return-Path: <netdev+bounces-304514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t2o+LVKdR2oxcQAAu9opvQ
	(envelope-from <netdev+bounces-304514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:30:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AFC701DA4
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=NlP8WBuN;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304514-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304514-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507243085A8D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E043C7DE1;
	Fri,  3 Jul 2026 11:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA93C4565
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:24:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077889; cv=none; b=Zg4/4xnS/XsR1HkEwFpa/yCFBSm8W9eVxDbDCOGPq2S6AvI4MKI6CNkQGnqWeuOwcJ4ll+aUPkRtg5Eq8Tzmoe4h3H7Nlr2rlZjX1DNTGqnCVMqtNfjPyXpW3G/yqdHnSRfYiAsUs04fTd7eYnKFXVo+SDTL3mvRYNkzRlyD8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077889; c=relaxed/simple;
	bh=3ldA4M0ZTPsb3yz4u1wjM4GAhweNrsJXz2su1RdMmZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrCBYFU0e7EYbDcGVxYbdgkt5rZeA5Hqt57Ji1WgiZvUlMKZq13xLQ8UqWt1w0MyD5bXTwdbI3bKcMEAyLTKMjN/fZbKolapTGGY+s6lTNX4UA9lDLgvoHSolG2lVfe0HU+28GtWraTSAhPJMl8LPwMbsziBGl98GOtToXZu3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NlP8WBuN; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so4091695ad.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 04:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077881; x=1783682681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmNFWGnLyAB8YGdW9Dzd3teB761dU5G/TuuiXhJ4Ikc=;
        b=kdZkcg8G3dqSJLeHPMGAhbh82h74Cvdhpd7qLA1ot/B7Zsk5D/Qqh1WkoWsmWcQJuR
         0HAwxkTLXhgl0IAJLrPja6FM+d/Eqvegd6QWqq9Hkvk0Cfg+bgkllTCQQeuRXfK/oRR8
         yq5bgJ7nQictyXrATjcsmqHOMH07Yu/7VqspvxKW4pl2c1dLqrjSV2ckGaLYPujiS60R
         HOePWJIvvt225JOsGiTejhzBRs5ItLHT7UKMUDmTqI+r8SOhh2v3GJsD/fe6pfj4I6+A
         8U8hsFgMxEGpo1nWZTIdC5ubagXhbaoOPRpwXQRjhLtnjRcfap/ukk7U3FzsMnbWnnRR
         LqUw==
X-Forwarded-Encrypted: i=1; AHgh+Rp10Gno+HhEvcXsH9X9briNNPhkeOdvP1HfrXB081zVjk++4eAiiGMn0OQgPfYrz8ans1qIZus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8zPCi6zQlbdM4dSfNNGi8JTnqQySVwJ8I9T3EGGt2hv4B7yOm
	HEqB8912mqLjVL4lg2X08aDzfJ7UTuHEyEwU/z63umaTFj3FXQhe0wxrdJV88Ja0/Y+WsUVRUVz
	EKvewCcwTJN4GXdtgaHwllNl40frz75er32RuQXZ0S8mnBR25k0BGujCPHhP1iwlEnTD9YxTH+y
	erQfguk/dvib+647A4zcObM1CHOZmOzHwd2/axgy5Osbm4uFlWQ2d/BZwcdWsgFVHsviVZHsbY1
	gJwtytJ7ndt
X-Gm-Gg: AfdE7cnOmrchRZ2bD2Bvp9Uty81M7KJ+w6fPjFYTCtMPwx9A8Ic92zaPzXCl20YVhl3
	/rW42bZ3L6rSc6Z+xqHg7En4nMEaqs6HkbS0boX/Mh8pMIjfBpY9RlxqmFr4jib+TOD3ZDgdMrG
	HdLYJcrFXAErSzwwWFmuBOV1Vj87JdqOkLHGkWbt0hGC+DDRmXKCsl+Z2IoTilGDM49H3aKxAw/
	PQKun80H51ND/Ldo/VBROv1gjlmdzDoZEqtx1NAZJAVkgqYicxz+pu1Z/5jecpHzd+koh4O2tXf
	3IAtEsBso9tbG+zK7o63TFl1DsyGCKafboU9bW6jO4IuCmjJtyEDhBfMI417kSx42ps5SXXJQIU
	gUHulIZMsyETm0ch1NrRl26Nt5/H+DLz9ETse1qhljv6Nyw4T/m+gCCOwuLMoAawdkqEeIh+6N9
	7670wSlLMC0cIkGEb+3r2ZqDocRk0E5iAMel/FtbZN+iVQDvU=
X-Received: by 2002:a17:902:d48b:b0:2c6:beeb:d7db with SMTP id d9443c01a7336-2ca7e73acc1mr109894975ad.16.1783077880433;
        Fri, 03 Jul 2026 04:24:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cad76ed27esm1227445ad.51.2026.07.03.04.24.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2026 04:24:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92d1cae5939so50517985a.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783077879; x=1783682679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TmNFWGnLyAB8YGdW9Dzd3teB761dU5G/TuuiXhJ4Ikc=;
        b=NlP8WBuNnlF2e+yHmu+4WsBg+KnRzUcaQBFzMt8m8v/Le2KxkGnSFX/EfOtCdPfFME
         dWqIn3XLi2gcZE70D/hNxTUhR6rCva7nzEjsjDPuD5HWtDJzUymVzKuT6vojqZdUnaQQ
         hWMhyXaaXDz7WrydWwMvEWX93b1Nl2URiH0qU=
X-Forwarded-Encrypted: i=1; AFNElJ/DjQjWVo5O88Qe0Qnm++2o/tS9PMQO8nnfi/Vy5KgpOvWf5RFYRTKEBJYbb6/1AGFXtf5zibA=@vger.kernel.org
X-Received: by 2002:a05:620a:4892:b0:92b:67e6:8ab2 with SMTP id af79cd13be357-92e7850600cmr1377207285a.60.1783077878955;
        Fri, 03 Jul 2026 04:24:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4892:b0:92b:67e6:8ab2 with SMTP id af79cd13be357-92e7850600cmr1377203285a.60.1783077878469;
        Fri, 03 Jul 2026 04:24:38 -0700 (PDT)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cfdefasm138100285a.47.2026.07.03.04.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:24:37 -0700 (PDT)
From: Kiran Kella <kiran.kella@broadcom.com>
To: daniel.zahka@gmail.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	weibunny@fb.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net] psp: fix NULL genl_sock deref race with concurrent netns teardown
Date: Fri,  3 Jul 2026 04:24:31 -0700
Message-ID: <20260703112431.2860506-1-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304514-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:daniel.zahka@gmail.com,m:kuba@kernel.org,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jayakrishnan.udayavarma@broadcom.com,m:ajit.khaparde@broadcom.com,m:akhilesh.samineni@broadcom.com,m:kiran.kella@broadcom.com,m:vikas.gupta@broadcom.com,m:bhargava.marreddy@broadcom.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18AFC701DA4

The race occurs between network namespace removal and PSP device
unregistration.  When a netns is deleted while a PSP device associated
with that netns is concurrently being removed, psp_dev_unregister()
triggers psp_nl_notify_dev() to send a device change notification.
Concurrently, cleanup_net() running in the netns workqueue calls
genl_pernet_exit(), which sets net->genl_sock to NULL. If
genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns()
then dereference the NULL socket and crash:

CPU 0 (netns teardown)       CPU 1 (PSP device unregister)
======================       =============================
cleanup_net [workqueue]
  genl_pernet_exit()         psp_dev_unregister()
    net->genl_sock = NULL      psp_nl_notify_dev()
                                 psp_nl_multicast_per_ns()
                                   build_ntf()
                                     -> netlink_has_listeners(NULL)
                                     /* crash */
                                   genlmsg_multicast_netns()
                                     -> nlmsg_multicast_filtered(NULL)
                                     /* crash */

Both the main_net path (derived from psd->main_netdev) and each
assoc_net entry in psd->assoc_dev_list are affected.

Fix by replacing the bare dev_net() calls with maybe_get_net().
maybe_get_net() returns NULL if the namespace is already dying.
Holding the reference ensures genl_sock remains valid across both the
build_ntf() and genlmsg_multicast_netns() calls.

Fixes: 00c94ca2b99e ("psp: base PSP device support")
Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
---
 net/psp/psp_nl.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 9610d8c456ff..24ab626a9e8a 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -62,36 +62,45 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
 	struct net *main_net;
 	struct sk_buff *ntf;
 
-	main_net = dev_net(psd->main_netdev);
+	main_net = maybe_get_net(dev_net(psd->main_netdev));
+	if (!main_net)
+		return;
+
 	xa_init(&sent_nets);
 
 	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
 		struct net *assoc_net = dev_net(entry->assoc_dev);
+		struct net *net;
 		int ret;
 
 		if (net_eq(assoc_net, main_net))
 			continue;
 
-		ret = xa_insert(&sent_nets, (unsigned long)assoc_net, assoc_net,
-				GFP_KERNEL);
-		if (ret == -EBUSY)
+		net = maybe_get_net(assoc_net);
+		if (!net)
 			continue;
 
-		ntf = build_ntf(psd, assoc_net, ctx);
-		if (!ntf)
+		ret = xa_insert(&sent_nets, (unsigned long)assoc_net, assoc_net,
+				GFP_KERNEL);
+		if (ret == -EBUSY) {
+			put_net(net);
 			continue;
+		}
 
-		genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
-					group, GFP_KERNEL);
+		ntf = build_ntf(psd, net, ctx);
+		if (ntf)
+			genlmsg_multicast_netns(&psp_nl_family, net, ntf, 0,
+						group, GFP_KERNEL);
+		put_net(net);
 	}
 	xa_destroy(&sent_nets);
 
 	/* Send to main device netns */
 	ntf = build_ntf(psd, main_net, ctx);
-	if (!ntf)
-		return;
-	genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
-				GFP_KERNEL);
+	if (ntf)
+		genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
+					GFP_KERNEL);
+	put_net(main_net);
 }
 
 static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct net *net,
-- 
2.54.0


