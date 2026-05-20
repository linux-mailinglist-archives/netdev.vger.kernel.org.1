Return-Path: <netdev+bounces-289878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMNmFIeNDWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389158BC78
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B5693032650
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDA03559F8;
	Wed, 20 May 2026 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4kw9SHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CC3A3E9A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273050; cv=none; b=MYWF0PXMsXaz7bcTMu/wJJ0/aC6OLEPfjQqN5G/t0Ny2gK2DFqANJPw95xpYbplcTmr4diaO6tUUN27VMuy6UCCI4VpZvPeHB4znpBmYWRx6dd8SHTolNItCbSodTpA+XW0nyIfVj4cpqia2R5yPsxe2nkXCPQI4zZlLXAwwWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273050; c=relaxed/simple;
	bh=upNpFlueSbswk4/LyjzG9gRYu6Lh+62LkNXclwONq/0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NfMF0U9VNYQ90ZrsaMyM8V2GWbuWshQdC+6obQ7KQPvNZYm82pELShEtlubyul1TdpnIGRwjl/knYbEAmq/JlII2c9ypIxT3tKggD1h2f3rPCHqTyok1xqKFCvKnvNix4kCVcSGyGcJnqq1xPVBaJZqrfvpxSMYu9MyP3IW7lkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4kw9SHq; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d9a6a853bso133633421cf.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779273045; x=1779877845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dW85YWydDMvWX9AFz2nhsSdKmKbjBZgKpuCpn+ixBrE=;
        b=S4kw9SHq7KukPsgGlm4VXi8mpRGsWaD6FgWRChiVOCRfUUPs94RO/Nx7j/ka7OBXND
         HhPxJ7oXt05hQ376UyxnWB0FgNHhEpgbxUmN8YrdcCyp2OhfYJEM6NaGKFXsOAoOCo3B
         23tvRtllG3G05B7ZyzQrqo1hGaSQ4IwDbTlhoUNYLSO6gufG2jttzTuXwYmknsNlVCd8
         Dp7FDTvmvJeoKMackvBM8cn2MvtRQbRJktZh5ZVVwrkU20800KEXV6zZolQNInVyp9Oi
         FQkOXsdRpDzw8z347wHCYPsUb4b3hLJJkSJtq79wmFeLfnMrfPQtC2RL7Xdaas6m3WF9
         vjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273045; x=1779877845;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dW85YWydDMvWX9AFz2nhsSdKmKbjBZgKpuCpn+ixBrE=;
        b=kw8HOpmRXC0BexU0jM7a8QScatpzhLxTK+f3e/y05SJc9hQKS4kdv4wxCcaQsHQ7AZ
         yOtiNbP8+I0dmV+VYOXt3ZT6vdpOMp9fS7ylJIWXfIIyTcuLBUGCUsoyLycJ1J3zlvsK
         aRJPUP3Dk1miRmzOC2yCWw/Eq8Vqm3QtGSEZJ0rxJRSW5GreL/zooNFfmTq22ndHcpl5
         QnMxXtICJNqrjkp7emqM3UtQTdm4dy+uok9D3/Xy80P6r8JvKcdwDNJKWiqs7At15moI
         eJ5z28vMTcWZN1JRFhVV++48eKVkBkcVnRoIGyIaRz9IJBCf4EInuH1HNfJ3w0jdRG+w
         qUgA==
X-Forwarded-Encrypted: i=1; AFNElJ88kQXJnhCjCMFo7n9uOC1XzAnTjboofmCWBuiCw4Ja+jYtKkTrUuy35+kzkX5ptEjDMSwbohU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8AAEOSxumGhGTLkK+imspW9KvEOT76txkwyJuO+ptE7kaUvJ
	rEEPYx1TgIiOXsZfQZ/MxEke8ETz1hJcCUUEZjFcLvbKIW8zJbvqZbLw/Eb6yVRxbAxfKPW/wp+
	tRD3s1pPH4A2hVg==
X-Received: from qtnt19.prod.google.com ([2002:ac8:5313:0:b0:50d:bd2c:6acb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:9012:b0:50e:a1ab:114c with SMTP id d75a77b69052e-5165a1eb7e4mr289212761cf.32.1779273045258;
 Wed, 20 May 2026 03:30:45 -0700 (PDT)
Date: Wed, 20 May 2026 10:30:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520103043.1131213-1-edumazet@google.com>
Subject: [PATCH iproute2-next] ll_map: add RTEXT_FILTER_NAME_ONLY to
 ll_link_get() and ll_init_map()
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289878-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7389158BC78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iproute2 can spend considerable amount of time in ll_init_map()
or ll_link_get() to dump verbose netdev attributes, contributing
to RTNL pressure.

Add RTEXT_FILTER_NAME_ONLY new flag so that rtnl_fill_ifinfo()
limits its output to:

    - struct nlmsghdr
    - IFLA_IFNAME
    - IFLA_PROP_LIST (alternate names)

This is supported in linux 7.2+ (and ignored in old kernels).

RTNL avoidance should be automatically provided in upcoming
kernel patches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 lib/ll_map.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ll_map.c b/lib/ll_map.c
index 07937e27d4f6fb5506a3da6e9318270635224364..21dd124960a604b0cd8912a11e1808c0eec5dc3e 100644
--- a/lib/ll_map.c
+++ b/lib/ll_map.c
@@ -273,7 +273,8 @@ static int ll_link_get(const char *name, int index)
 		.n.nlmsg_type = RTM_GETLINK,
 		.ifm.ifi_index = index,
 	};
-	__u32 filt_mask = RTEXT_FILTER_VF | RTEXT_FILTER_SKIP_STATS;
+	__u32 filt_mask = RTEXT_FILTER_VF | RTEXT_FILTER_SKIP_STATS |
+			  RTEXT_FILTER_NAME_ONLY;
 	struct rtnl_handle rth = {};
 	struct nlmsghdr *answer;
 	int rc = 0;
@@ -393,7 +394,8 @@ void ll_init_map(struct rtnl_handle *rth)
 
 	if (rtnl_linkdump_req_filter(rth, AF_UNSPEC,
 				     RTEXT_FILTER_VF |
-				     RTEXT_FILTER_SKIP_STATS) < 0) {
+				     RTEXT_FILTER_SKIP_STATS |
+				     RTEXT_FILTER_NAME_ONLY) < 0) {
 		perror("Cannot send dump request");
 		exit(1);
 	}
-- 
2.54.0.631.ge1b05301d1-goog


