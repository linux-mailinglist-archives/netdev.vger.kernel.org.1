Return-Path: <netdev+bounces-275145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNjgNabvz2mt1wYAu9opvQ
	(envelope-from <netdev+bounces-275145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:49:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 395ED396995
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A1F3082F99
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783ED3CE49A;
	Fri,  3 Apr 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="mhVywkwu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0C34DCE0
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234645; cv=none; b=qVFEGodY7WVdw4BksTVfaJ5GWbBWS9BHgdjSTtuH2alZihu9ehztTkpVBP6BQHt1u1SjvSaVGt+XjTuk9NV2pIYR9J+xUiELLbvYMkxSqoeCxw2ahUFuTr4yn6dXP6VreiZUVqkJ1zBqfq/Q9dYMzQlb/O1W3opbfj+eULx236w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234645; c=relaxed/simple;
	bh=i4p562E6xl+MsawXqPrNM2npLjWfOncAEU+VEhgYYCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7kLEtaLs/2hTqZMEGCTppYe063liCqJ2CjTkbe1DyHu0v+9QLO+ai9QsashJb8M1aTHrvVVO1bDkhz6GzFMzz/ah5IeAEthjXldfERgf0Y4cKXGyRqVQ1JxqMhbNR/zFqkfYjqAyIgU5N5S5SDk0p+xoRywGamtbZdK8F9WQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=mhVywkwu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9b1ffbb9f5so231169866b.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775234642; x=1775839442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTjtCff7Q4DiiNPMLHxYW0+3ALVFBVM6wubHOseE9mU=;
        b=mhVywkwuJvhO3WlBYE1/OaMAZo+a//kPHAerR2H7xcZmilHNo1HFI1aL5wsGO1cqt1
         8nu3eZoHOYwNGej3Z/DTHBvDzqA9gU84/jq7TQyPD8/9QEuskruHPVbahFKHRQLyUBBG
         gZga5ZP+WLNa2rrwSKbJwso4fT/zcCC/+5jYvtx9TpETIsZ6gILSXNK2SZmDspAeKBLc
         H0bHMNLiY4rW1rIkFMw+blYwSUiIKhu0D9Fp3IxL4b0o4gbYg61bJKRNxjh90yR3Clw5
         JZBegqsnMrDZzgZJIM/H/KCCEPW7rmI01tc4kcCMHJgTNdWdDqKq6GnqSERy1Hmp5Is3
         qv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775234642; x=1775839442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CTjtCff7Q4DiiNPMLHxYW0+3ALVFBVM6wubHOseE9mU=;
        b=lRNdFRtbzgPa95wND6gld0uWXSQAREk3uScL7uYP2Jcw2OiYlAGMdmt0MZts7foguB
         gNdPPfCJM9uTzke0rB6eEoAq41kxqA2z2lV3EfPvj+pdxJU2QudD9FIpeuNzYSPU9WMf
         8HNZkmInA6jDHsHz2RmWCFNOiE1gnKKjG/iWq6fg6lFNJ11+GlqKZAG6dk2nGircMGuy
         yrDVZ7zJGy+T2EZSF3ARIEw80lPfN6rQXdiKsAagXI51KzDW2mOIWvNaL14n/jrbININ
         6PkaAyUQVwZcH6zQN7NfpkVaNWiLoWaamRpDbmcFYWTn3csB1Ha0VD2/RfxUXQZ5jJBM
         gt0w==
X-Forwarded-Encrypted: i=1; AJvYcCUx4jnFyf0pMMSU/bqn7hn82fg7famSWwpPzaJRYNeHSAigPaqgr+Drqo+osghSsnIW5Rx4PoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUP59ndwvNIg7LZo0f/ZA0w1YAr5ARrTCGJv+PfpK23uRfp4Z7
	3vTBn4Ne2AeTVR25j/Rt0x7BRVg4JAZSJQQkOq3kd6cwlPv/aI8CUk8dN9y5nk8l7bQ=
X-Gm-Gg: AeBDiesWYd35vB7FJoy36cRlN1/WynxfMsAnEli/EEwhVZFuAkPw+dj1jgL61WCsRaI
	BArgjpG+PXAxTW3grza44d1StQHDWU4wWyQk+tfmXtHQOnlvtoDVSCfVWFQ9lkULIA+aMJCllPb
	MDva4IULSPsO8PUWex2O2g36aJCzGprHCZaEqCGNyaY6BnH+USVeXxXmzRkALVtj3KjxEMYaleo
	YIcLWPwCmVdnqNDna9FESBo2U7mb3cMC1ScNy4C9YZe1iL1+kqy8/YmSXCva+x1S6X3SFC/hzMW
	RNXhDHNH3F/gPgcm7oZ4oFcZ2F47xUkvqNdUvK6gW+2BVoP6jOEuobv3xmoXbO02ZHOJfExAXKG
	N/DzpgCAi0Z+aCQHqF0NpYBH2fog6vwq5GzXa8+Xsu36h/fcuqQtIRCWBa7+md1Rswjp7woVlZ3
	7eeS57CcuGmX7Vq4kC4I4Q1BZqmHlUEvsKTllypnj6/kQ6AmC2X/Wyw5Y0ofEQG/keC0+HGc4tZ
	UvkX+gvFRxi/skfZxuqzZn62Bkj+sP51Tk0Lw==
X-Received: by 2002:a17:907:c002:b0:b97:a1ca:e100 with SMTP id a640c23a62f3a-b9c67951901mr190889766b.32.1775234642271;
        Fri, 03 Apr 2026 09:44:02 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3ca9a145sm213492566b.25.2026.04.03.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:44:01 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 18:43:47 +0200
Subject: [PATCH 1/6] net: ipa: fix GENERIC_CMD register field masks for IPA
 v5.0+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-ipa-v1-1-01e9e4e03d3e@fairphone.com>
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
In-Reply-To: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775234639; l=1275;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=wVWwdatovjkVmj3hE2xttOnjurwQ7/UkaxiXvhYrMnw=;
 b=6f7dlNEqx/WgDEZTogxKVUxQuHWi4Gkbilt5KzzC4a4NlQluDwn1CvyiwdceB4Yn7NRmtQsWP
 oYcEdeFiz8oClMj8bu54iIa6PvIYpJRVe8H7ObjLR1rRgq5uRxrnorj
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275145-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fairphone.com:dkim,fairphone.com:email,fairphone.com:mid,pm.me:email]
X-Rspamd-Queue-Id: 395ED396995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Koskovich <akoskovich@pm.me>

Fix the field masks to match the hardware layout documented in
downstream GSI (GSI_V3_0_EE_n_GSI_EE_GENERIC_CMD_*).

Notably this fixes a WARN I was seeing when I tried to send "stop"
to the MPSS remoteproc while IPA was up.

Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/reg/gsi_reg-v5.0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index 36d1e65df71b..3334d8e20ad2 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -156,9 +156,10 @@ REG_FIELDS(EV_CH_CMD, ev_ch_cmd, 0x00025010 + 0x12000 * GSI_EE_AP);
 
 static const u32 reg_generic_cmd_fmask[] = {
 	[GENERIC_OPCODE]				= GENMASK(4, 0),
-	[GENERIC_CHID]					= GENMASK(9, 5),
-	[GENERIC_EE]					= GENMASK(13, 10),
-						/* Bits 14-31 reserved */
+	[GENERIC_CHID]					= GENMASK(12, 5),
+	[GENERIC_EE]					= GENMASK(16, 13),
+						/* Bits 17-23 reserved */
+	[GENERIC_PARAMS]				= GENMASK(31, 24),
 };
 
 REG_FIELDS(GENERIC_CMD, generic_cmd, 0x00025018 + 0x12000 * GSI_EE_AP);

-- 
2.53.0


