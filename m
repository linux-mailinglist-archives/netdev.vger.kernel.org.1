Return-Path: <netdev+bounces-248200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B90AFD04F70
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C16743058A76
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530633254B2;
	Thu,  8 Jan 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="TRb3mIOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AC2DB7BC
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892565; cv=none; b=KkV1tigyVVnSQkqQo9tiJYfJHM/m5vzeuh9Fy6by5H3aM0E0uN30k8JAvi55qNtr/jyp1rQjYUm+9xoW6yVCjKRIs3bl0eejY02fMO9HSyVTGUM/3eYSPO074/QEtSPf5XFuk5eCghbSOeW45LQwfkMfNLAPKtXRu/mupfXNsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892565; c=relaxed/simple;
	bh=iVn7YA8nn01ehzj/XTgcwn2kQO76KBY0zuM655UBDEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5ujIpP1mScJ2gV7ZY4EQSK2fjadxQCEfN/mGbI7h1Am4iCV6zZd1wzbGpRRM3krt4t4+C0ac2MmWC+00B1HO2OIqgso3Nb06fWYIZGNQjbZl17nAdibUMnDimQAkoLqf3LP195R52D2tGs67Kw99a5qowlKudoplrr7mQd1idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=TRb3mIOD; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-11b992954d4so3201914c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1767892563; x=1768497363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymnZ12ZVg5d56UvSdMCpk88bIArGImL4sE/PnHSiNIQ=;
        b=TRb3mIOD02aXwh683WoTy8T7VvvxXeqOawpzQQen9Czcw1a3m/NFVuON4oAR6wlpL6
         NXFk4bu5ipX2kk90NVraMyL5wYDYTxmacAM3xDr5XlcbKzzqG8QSP7K/mRl01lGyyxYE
         Iu84WSyx4n41oVMr1DajtbuLxtHIXIBAyepSIP4/yzjdX60RYLOQQpcKGXXeUUVE1iFJ
         Ai+EQ6iaEReBdYjpNo5hvfjBkbivRa+OxNNTFunr1HUeGdEMeylx9Ts+dm8HlBdutfyI
         sYsH/ldFt7XmEbRpz4oKHpx3DcDB9JbnuMplc3iklpE9LhdrkVVRYLRcNl041ET698bL
         Zhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892563; x=1768497363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ymnZ12ZVg5d56UvSdMCpk88bIArGImL4sE/PnHSiNIQ=;
        b=RORHTv6xYll6m/S/0u2/EBqjbHsYFe9NV8HmflcJxK8Jy74Xn6coJwWHmZLANksgiz
         xStDujFXfH5kSxWkAh50VKov6ICfHI/sADcUmGy9Qz3SCUHHQYLT1UIKBq4gcXwxgLC7
         LHO1rcWWR990PAUu4+6ZfaV8kHtcykzAwH/1qcLFu+6nGfWziow7vhtZrngjSgD3LrdV
         dU3VnJRrVvd/vD8JaQZbLOuZak0JRTo9PCjEMlIPTQT+Loi7RyhVOcOq8kFgTL8C3BJo
         BeptVPOss5QWZcIAmvOidVm6uXR3hFXsgqwL/Uq8qPdvGwOC0bSelwgoDWZP7xrcjfAa
         Mxag==
X-Forwarded-Encrypted: i=1; AJvYcCXLf5t0IyCWBnvU1kDzuyJLtOk4yg+b/ozu8yjNYaLqZDfxycsSqTC1ZJqtvYNEq01Y7lnDFUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4YD+X259RnI5O/ikt3gHmpsyukpg/UsdfN/wT93nxG95pRfc
	8DbvPPHlTrF8lWci9SW0fYH5bWTH+9vFhJueZSRWD8d52bwJkA1o6jthjatbUklJxRkAmc5+DlG
	0+ZJ8pw==
X-Gm-Gg: AY/fxX6LOPfSv4km5qSHYlJG9PCq1dMQxvUzhPrGrqdxKniz2/WLOZ/QDbqeqYVkQ3C
	gJKYUsTiAxmQGt24j5eQVL4EtRNBelfPTZYdfVUdTYa1tHlXsjsff3xBlASxgGK+WH+rFgT/Vsc
	ZFO3h1Vs6LmYgVqzx2xG6qSBdKULjV+HKyDtR3vKDt7RfLIWt++7ndBKSo9c15KDx1daDHmkop9
	qKfeFqAxYfjkGWeG3mpH67aedPDBcabq0nnH48UhAq6ImIpT6J5WgKcyDy9sbtcJB0j6nRSKBhg
	nKFfUIiAwnFxkArbI89ezxwuaYrgalXPwxhhXkIJybYGFds3W65pcWTlFMU+W81Z83EHE8lLGE6
	lLIuj6ppIJTT2HVMWUxu4Khcsn9tCnHVbMHtaqe/ozclboPVApErhxHu4blVSxjTVZgI/3ljsiC
	Hh5FP7X6FCSHXhhBdISGzoYkfv9IcGw97TPwOoJp7MaO1rQYnINuyyqnOm
X-Google-Smtp-Source: AGHT+IH/P63oPD2Zjgbk6vQ5uk1IV5bufCRAoon/NN+MlFYjFEMytYxxH8BoZy1vBED78EauWwhmdQ==
X-Received: by 2002:a05:7022:387:b0:119:e56c:189d with SMTP id a92af1059eb24-121f8afbcdfmr6181418c88.5.1767892562923;
        Thu, 08 Jan 2026 09:16:02 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:812d:d4cb:feac:3d09])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm14029259c88.12.2026.01.08.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:16:02 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 4/4] ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
Date: Thu,  8 Jan 2026 09:14:56 -0800
Message-ID: <20260108171456.47519-5-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108171456.47519-1-tom@herbertland.com>
References: <20260108171456.47519-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the descriptions of max_dst_opts_number and max_hbh_opts_number
sysctls add text about how a zero setting means that a packet with
any Destination or Hop-by-Hop options is dropped.

Report the default for max_dst_opts_number to be zero (i.e. packets
with Destination options are dropped by default), and add a
justification.

Report the default for max_hbh_opts_number to be one.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..de078f7f6a17 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2474,20 +2474,36 @@ mld_qrv - INTEGER
 	Minimum: 1 (as specified by RFC6636 4.5)
 
 max_dst_opts_number - INTEGER
-	Maximum number of non-padding TLVs allowed in a Destination
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
-
-	Default: 8
+        Maximum number of non-padding TLVs allowed in a Destination
+        options extension header. If this value is zero then receive
+        Destination Options processing is disabled in which case packets
+        with the Destination Options extension header are dropped. If
+        this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of
+        this number.
+
+        The default is zero which means the all received packets with
+        Destination Options extension header are dropped. The rationale is that
+        for the vast majority of hosts, Destination Options serve no purpose.
+        In the thirty years of IPv6 no broadly useful IPv6 Destination options
+        have been defined, they have no security or even checksum protection,
+        latest data shows the Destination have drop rates on the Internet
+        from ten percent to more than thirty percent (depending on the size of
+        the extension header). They also have the potential to be used as a
+        Denial of Service attack.
+
+        Default: 0
 
 max_hbh_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is less than zero
-	then unknown options are disallowed and the number of known
-	TLVs allowed is the absolute value of this number.
-
-	Default: 8
+	options extension header. If this value is zero then receive
+        Hop-by-Hop Options processing is disabled in which case packets
+        with the Hop-by-Hop Options extension header are dropped.
+        If this value is less than zero then unknown options are disallowed
+        and the number of known TLVs allowed is the absolute value of this
+        number.
+
+        Default: 1
 
 max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
-- 
2.43.0


