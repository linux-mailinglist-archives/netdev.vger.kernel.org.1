Return-Path: <netdev+bounces-265538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN90LT/CrmmRIgIAu9opvQ
	(envelope-from <netdev+bounces-265538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:51:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF22392DD
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB3A830AA539
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580F3BED3D;
	Mon,  9 Mar 2026 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awEHbyIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF83BD64F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060355; cv=none; b=sTUlfsO4ZnloAKqA5KidUibS58Pq1Ro13+wBlWkb4464cy+AzAZ6rTAkRU7my0JcGNm/1YQZa+rtZC/FuhI6UPhHTH0tYXKCWZvIrYM4nfTVTIdopo4hqx/KUcSoSv+Qima8JIWAKBeYVqIerJ10K/gCH5ftrY1uIAIla1szfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060355; c=relaxed/simple;
	bh=msrA7wGjRRGTCwCsfx7ePt2yNBhyVAifse7Q2+9fCm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAy5emHHAmIc2Dp7LG/ctjPOS3f7JABD95KvMZTGK/qaielyoTQ7U/2SFCfH2XiboEXFjBFefDZawxZI2qZbSrnRYGDdWY1JWOLEGWx12Qj8xgmV+wSOR3DsEVcg4RvWRlwAfUEsJXZEJj5T/V0jc1tEVCDi5HP/MyaOSLSgZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awEHbyIp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7382731edfso3375494a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773060352; x=1773665152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQsAUyUgurtuYPOjOt9kS2ZoheMJQ/CgpVDQoe0FZmA=;
        b=awEHbyIphba0IKRzVQ8WeBRDsxVx+4o0gw7U+SZzzkV3PAs84V2TmVieNA0HmDckuI
         HfDrGy6HDaDSKmz+mD2kx3KfhKsE14/Vgi+CgYtOP/vblX1rWORcq20Pf4J0qD3fZy1w
         o03KtrtpSvVRL1NoWaabUwm/J9eO0yhrLwsOVdROU5I5pQO0zzsYsuUZYWvZAxKCI/yo
         u+EzgXRVqacbt1kmfN5zA02UJ9Xm8xcY/KRMr3YBqSxiiGl9zQM5uBzNDP6tDrm+uBk0
         ZK62u6PgxldMn2HZXQ6NDf33M6BiT154b9IVhUJjS/ldZR7/yj4HM5h/4PQ2u9Aj0740
         HA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060352; x=1773665152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQsAUyUgurtuYPOjOt9kS2ZoheMJQ/CgpVDQoe0FZmA=;
        b=X7RPHMtqiPIbSnuuQYjg/hqWKQNPOOha5ZDZbWhkgfgh1E9gIgBVFJlDH3WNGW2P65
         QwOdyceJQDHfs8S+25idjh0n0lvpILtkQS21OJP38GUtkWOtiWCbLzvUxnkr5tleoeH5
         MyBavxkgxyCNcc5o4tJqcraLEDVn3vaIuecVq/pej5IlSs+l5Z2Y0bpmdwID70+PByVH
         qhpXEuvjf8oYjNtPCIWtrVb0WYNsRCBLxdx+zrZkJSOSM0RPmNYOpQiWOtYGcXsVNmOg
         AN+4ur+81eUi8bowzaj5OpqXu1Ibrf1kQgvtFkux9FcTemilb3qyxWrzaN/eq2Gs78Bi
         HtNA==
X-Forwarded-Encrypted: i=1; AJvYcCWUiDKoQMkhjbcJqgundQT8nPAX9QQbLVvExgHveoZusmPnLeM4+6JlVUXagUrva593nOKmF7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGp5zNjuq3cngJb1ByvG3CpV5HM2a+kQcMlI3WfBb+m/3doz7G
	C/pTNP1809StSc7uvh6zLXqsZKytZuZPtioyj3ylTz8d0svzif1dxxF6
X-Gm-Gg: ATEYQzzUJScYWsrHp9/vx2hmFntmmhsKv4fSlX0S5vIv8NBu/AutMdef1r+J5Fu1OIJ
	Pdz7aC9LOZD8Cx8vLdGCItnjtm0kHFXCXesEgifKY0JwUph5WHpIcKaD5EIxRwlE7Hu5H3zsWB/
	JAc/ByVUkNlDFK4kFw7Ik/uM8N7ZkgYzXepSACA1JTAh1XUjExjs1KWpoj5jOrKUF6IgAqgUueO
	H/TvIJ7E7CRqHlCg8jgBpu5rGIOB6rrrUZFiirJvih0jSkMfrcBCZdSynhgk/5GeeyJwwz5pk7c
	rYv9dQKr8lNxMOeh5CzJm7wcWjLdvDVzqvIeXqK5aK5EU8TsXSBo/icdD7A3bbd54scxhcAsQjw
	ew+bWJYAlfVEGhQQ6hNSZEriiNY06Kynjm1LUwyv5XRU4KSXSBeb+pp+B4dl4b4rv84RGKG1gPG
	YLcbECf2+1vjB4dt6tXSliWv5IKsPsNKprp3qrSnMneQGViQPrlV/F5zsL72hx
X-Received: by 2002:a05:6a20:d807:b0:398:8546:c3e1 with SMTP id adf61e73a8af0-3988546ca4bmr4730270637.62.1773060352201;
        Mon, 09 Mar 2026 05:45:52 -0700 (PDT)
Received: from ubuntu24-04.. (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e183596sm9178830a12.27.2026.03.09.05.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:45:51 -0700 (PDT)
From: sawara04.o@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 net-next 2/2] net/smc: Add documentation for limit_smc_hs and hs_ctrl
Date: Mon,  9 Mar 2026 21:45:40 +0900
Message-ID: <20260309124541.22723-3-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309124541.22723-1-sawara04.o@gmail.com>
References: <20260309124541.22723-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CFF22392DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265538-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sawara04o@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Kyoji Ogasawara <sawara04.o@gmail.com>

Document missing SMC sysctl parameters limit_smc_hs and hs_ctrl

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 Documentation/networking/smc-sysctl.rst | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 17b8314c0e5e..3bbc5739f8ac 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -111,3 +111,30 @@ smcr_max_recv_wr - INTEGER
 	like before having this control.
 
 	Default: 48
+
+limit_smc_hs - INTEGER
+	Whether to limit SMC handshake for newly created sockets.
+
+	When enabled, SMC listen path applies handshake limitation based on
+	handshake worker congestion and queued SMC handshake load.
+
+	Possible values:
+
+	- 0 - Disable handshake limitation
+	- 1 - Enable handshake limitation
+
+	Default: 0 (disable)
+
+hs_ctrl - STRING
+	Select the SMC handshake control profile by name.
+
+	This string refers to the name of a user-implemented
+	BPF struct_ops instance of type smc_hs_ctrl.
+
+	The selected profile controls whether SMC options are advertised
+	during TCP SYN/SYN-ACK handshake.
+
+	Only available when CONFIG_SMC_HS_CTRL_BPF is enabled.
+	Write an empty string to clear the current profile.
+
+	Default: empty string
\ No newline at end of file
-- 
2.43.0


