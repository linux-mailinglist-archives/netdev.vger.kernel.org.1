Return-Path: <netdev+bounces-305576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1jVgIF5QTWoAyQEAu9opvQ
	(envelope-from <netdev+bounces-305576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:15:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D971F17D
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:15:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=C0Qa+k8G;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305576-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305576-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E71D33040C76
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497C442135;
	Tue,  7 Jul 2026 19:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B43A453F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:07:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451252; cv=none; b=IkwQoNMGy7mQrDo7klL8fopAz3Cd8rV1GS+10wVmvlvjgJa6L3JR29IJi5+PZb0XycRsD6TLahLUfod/R8rTRvp605RsDAi/fNmFlxEH62AaKXlI/GMe5J7NRZ6F9/0QyUSc8Fy4u/8Abjp9+5gZL/8TWx1SkUpc90FB5orMlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451252; c=relaxed/simple;
	bh=9vcQe+lqkSUhO/hqEL7euMzw+Ylhy7Jrd0ckhEu+kjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkVsLcof+0fPO4+6cuHX4SBAD/MCrcchoryLIFarZSA5vIzycEXVPgOA7ctB8ZeQekXIELb33PifC2oNQGyeo3QT2BWvrKxcmBHq9uTCjM7bzidy1H4Tv/H95rVX0iJ6NcLHNS+fAhRu3UK0Dr2hjGMCLagompzX5iiuMhfRoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C0Qa+k8G; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cc891373e0so28009595ad.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783451240; x=1784056040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xkh6iulIg4hP5C8wk35n/uewfJIZaPdnzakI+h7ndnA=;
        b=M/22BEt5meoK+O3//BNaMIibVvXGv+cFDGKoYG/tgV19c+XueY/4anVye0Az+77WGl
         6KYg8hbe7qrpeBgpsDhczyVE/pMKa/EPOZT+cP79MzPEnh5IiLl9zPk67bYYmN83ioOh
         P+TARkcq50vSMCJvwrFaKi9v/fA0jeC86QweMeEs3llSdFgN0xX9ANtoExCZiSrLtc53
         axcwsxpOn+PsUQ7OGyXlN4dZEYRJ3xvKWlmqiH7eSC9JMczmQb3/80HZvj3tUP1Nu346
         JzNmnQ0E37PTZ88y2kJkvgPdt/dqGLw22aIWyqBtRpGeCx2xSkKXbErJqyJiWJL87pNz
         UGcg==
X-Forwarded-Encrypted: i=1; AHgh+RqfZxy4+ijI6wpUdo4GPD9tfD6+195eoBA9iQoFTa0jmhpcGSlAmO0xz4tPIYO/2e98uXh78Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAjOdK0+cBlUdazqzwQlbHWEy7PlhPAkUTtRkFI9MLDM/2Nh/
	LXk2AqrwPXmXL8dTd7+ALLbZUC/wIWitu+UYA543CTSBsNOArC/Y9VqFgqtW+Qv6D/JR2uvV4R+
	rb9Y5yt9hjC7t6vVaP5iyJSvI7pjsup41GywzCOC80OzuAXmN71frKpPC3lwrBNh3CKX9jP0LcM
	DZ8Jxg+ESXLncLRQy8/8X9inaVYWOA86PHOSWrZoOJnHzbv4vWqXM6MNxToc851KWsgpoLQqU1g
	I324p28cNnx
X-Gm-Gg: AfdE7cmkmDriaGEo8PRS3IfGoOVUO0OMkGo/15yTb/MMQxEbrQdkASd8Pw5nXvykQJx
	fq+zIcz+Hwj7m2d6pwqtCb8Spy2mbQliB7B38wrh/MrRQCXz+ufeyDvz041PLmWD58tsnkeVQ5y
	oYf7XSR0+rtqpTxv+ujXGaRQKzvlnq1RoAWFNogsMx2+6heFK7DRMc5f8I/EP3u68ryLH+A78pe
	uWr10t2sB2NEfmkRmUtjSsM5fJHBIljyQbYZRLDobp//15j1NQ78yxk+WmKHxV71/UE7LGgemkw
	Hd36fdW7zEW1bkwhW4dueXvuci7a+fnyhDa+HtLsjFN/1dje8wwa3Prnx2dBRzPxLFMoITzhQVt
	jpRztVgDqaAFwW/oA76mj2FFSokY/YJMNgrzqkToJ9ch8fGX8nQ74ASVTgB7athr5rfiqs+u8Mk
	jAD7pRdrq7Zt1gUdcbC0ofg4oF/M6emOtS6QrTsNIc9EhsFag=
X-Received: by 2002:a17:903:3886:b0:2c9:960c:f73b with SMTP id d9443c01a7336-2ccbed29117mr67970675ad.24.1783451240250;
        Tue, 07 Jul 2026 12:07:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9bdd3b7sm3128155ad.16.2026.07.07.12.07.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2026 12:07:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5a787be4ee9so6662007e0c.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783451239; x=1784056039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xkh6iulIg4hP5C8wk35n/uewfJIZaPdnzakI+h7ndnA=;
        b=C0Qa+k8GjT0ksKSVThSDGp18wywA3lGwxtP2/EhtfCN1xfMU+41CX2MZy014bF2G1o
         JJoSzUNse+pRGzL/q1mSjBof7GG6CC2HCPhjCaau8AwvNnzLxuq6ilgwF8mOlrJ0n+tm
         /6t3At5PhqebGOnBZeiQdSMt+YNFGGQctHG8s=
X-Forwarded-Encrypted: i=1; AHgh+Rp1jmTRa3Uc9ibM4QQW8790upHVdx1i240Va8vX0RF6c6y0TRzZZVd0uq0PV8A/ilfUWnQPQIk=@vger.kernel.org
X-Received: by 2002:a05:620a:408d:b0:92e:675e:8ede with SMTP id af79cd13be357-92ebb4b40ffmr711531385a.13.1783450830716;
        Tue, 07 Jul 2026 12:00:30 -0700 (PDT)
X-Received: by 2002:a05:620a:408d:b0:92e:675e:8ede with SMTP id af79cd13be357-92ebb4b40ffmr711515485a.13.1783450829742;
        Tue, 07 Jul 2026 12:00:29 -0700 (PDT)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbd6c9sm1237044185a.33.2026.07.07.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:00:29 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Daniel Zahka <daniel.zahka@broadcom.com>
Subject: [PATCH net v2] psp: fix NULL genl_sock deref race with concurrent netns teardown
Date: Tue,  7 Jul 2026 11:59:37 -0700
Message-ID: <20260707185937.3177211-1-kiran.kella@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305576-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:daniel.zahka@gmail.com,m:kuba@kernel.org,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jayakrishnan.udayavarma@broadcom.com,m:ajit.khaparde@broadcom.com,m:akhilesh.samineni@broadcom.com,m:kiran.kella@broadcom.com,m:vikas.gupta@broadcom.com,m:bhargava.marreddy@broadcom.com,m:daniel.zahka@broadcom.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B9D971F17D

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
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Reviewed-by: Daniel Zahka <daniel.zahka@broadcom.com>
Tested-by: Daniel Zahka <daniel.zahka@broadcom.com>
Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
---
v2:
 - get rid of the extra struct net *net, by doing
(!maybe_get_net(assoc_net)) directly (as suggested by Daniel Zahka)

v1: https://lore.kernel.org/all/20260703112431.2860506-1-kiran.kella@broadcom.com/

 net/psp/psp_nl.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 9610d8c456ff..1438dbb07949 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -62,7 +62,10 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
 	struct net *main_net;
 	struct sk_buff *ntf;
 
-	main_net = dev_net(psd->main_netdev);
+	main_net = maybe_get_net(dev_net(psd->main_netdev));
+	if (!main_net)
+		return;
+
 	xa_init(&sent_nets);
 
 	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
@@ -77,21 +80,23 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
 		if (ret == -EBUSY)
 			continue;
 
-		ntf = build_ntf(psd, assoc_net, ctx);
-		if (!ntf)
+		if (!maybe_get_net(assoc_net))
 			continue;
 
-		genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
-					group, GFP_KERNEL);
+		ntf = build_ntf(psd, assoc_net, ctx);
+		if (ntf)
+			genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf,
+						0, group, GFP_KERNEL);
+		put_net(assoc_net);
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


