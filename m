Return-Path: <netdev+bounces-219476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69464B41781
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99441B271CC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251C32E92B7;
	Wed,  3 Sep 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGbyJmCO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB372E7F39
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886336; cv=none; b=KVAFIN5jL+zCtDHwfssAalsnFA35u3wNy6ueQuP7H5Ebakm242LA2ciZ6ndzY2Y+bRgt3vUOeHXRlyRmIib1sNhLzahkvpfQ+fj1bNA3dv85NH+k1TtOIHmOYcMrgz57crv4gt6jP2W2zMLZe7TtXrvY7bsTmpfXRAcZrkdnyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886336; c=relaxed/simple;
	bh=Otd9nfkT51QBtzFW7wdc8ekjqO20rNIC2LSzNPtDUe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qi+FVwMVw0OTkoS8ZdFh3eftDnOC1qquDjklOh/hSthIgT8uRzd5lLip0s7p68vktlz03sr7LUsneJACno+gl0vry2sSSEVJvSvU9fCmL9L2qq6ntLDLXyGTT9Fs0SvnPT8rqiS07+oGZd8bXYznwKph4o+CCkr0TLUjrIFIlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGbyJmCO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756886332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2s5qHy4+t8iYAHKFveMVUTLlJdHllZf5b+C396ty8oI=;
	b=iGbyJmCOnYz/3ptKYhxK8ZOYZvqPXik9pSjmh7taCGIZubd9r1hhCa/m7jzEP91U1YMjh4
	fuNKu7koFLmUM/MiuI69nVuCsKum0yagHLL/Lq/K8ky8TeHYAa0/R1oHIoOXfzyE3H4Dt9
	9T8TYLZhRIkI34kCtVHPCHnMWS80C6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-v6xDwj_gPhGBRqEVP1EFsw-1; Wed, 03 Sep 2025 03:58:51 -0400
X-MC-Unique: v6xDwj_gPhGBRqEVP1EFsw-1
X-Mimecast-MFC-AGG-ID: v6xDwj_gPhGBRqEVP1EFsw_1756886331
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3db89e4f443so656942f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 00:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886330; x=1757491130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s5qHy4+t8iYAHKFveMVUTLlJdHllZf5b+C396ty8oI=;
        b=a9klMU388XeqJz9e3jjd6jdPvzhzJjBgb19t0xbJ6VY76PvDNx4ZBa+zqJoAMrqea6
         LXWDZ23B8w494f8ZBwB9y2wQNMu7zK7X6Z3d8qxLZGgww9RzNyAf2TmOLePDqM6PNVR5
         Q/wfG+d1ymzUUS9ltWc1SImM/adIMxeXXecIfozXhZDhVIAgkhpNMfSQeygO8SbNsmig
         XkRe3xQk/x41tsEs9ZJpT+nQ2J9Bh/CKd6oJcIrKmvgKGQBaIZ9m1ek+2tMYyLRpcF0p
         lLcatfS3T/VpkMoLej06PYNZTg4m0JVh0i+axrfMS7WP2lOev8OhS/o1RrrpZ3LuDu1e
         w1zg==
X-Forwarded-Encrypted: i=1; AJvYcCXCF7beKrILA51NTDAdTGK926glV1/fPOwRY8U78b7KNBfzvWUW8LUtp1p+vfxn9JHC+kln4Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywlusa+cLTfAKBpOnkMrBQcDeOCAudwGSW8ENEuAWKjEUmpy2e
	7g1dx2EEOYaBMOADN0eobyD+Spk6FcNQC5RhZ7qKVPNYv9WriNazSlFerKWU7aS5MyxWaSuKSIE
	xTtQzZFozhWBSPm4gX2Vn3UmFW22mRX6yzjI12RvI0jM0/Qv03ORfHA/Bxw==
X-Gm-Gg: ASbGncuKl2RIYPKLwEJvoO0cpvZUPA2Fdx6iL51dXll1BxtkMNaS8WyWM6aYpt+UATc
	LE0jV9fQidAKLU0MsnElCuQUrDb9fFCg1nTp2EuqQJaP3Vea3EgeUAfKresbs7M3hRbF6buqdHM
	r3Nvecu/e6TRF7JggEm3N+wREobL+G1S7D+gisI/IVOJ2ymm5FRaVMyNAb6uG9J0Pq90qbmy3hZ
	Oo0lyQ173eXPf/5lVA/nCQlMGNl17qddPZ3RzakL2uivVU2A3aCDPASpjdLBt0f+m+bY8C/7+l0
	jajksUqqCbCRe+lkiAGR7x91pwHJGekouV3cg8KGQ28x
X-Received: by 2002:a05:6000:2281:b0:3c8:ffcf:e01d with SMTP id ffacd0b85a97d-3d1e08a3713mr11295707f8f.55.1756886330442;
        Wed, 03 Sep 2025 00:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzOmvaVi5j8uBLe8p/3Yc2U+5c8/5cLhrCsBtEm8GEbXn3pudCF85jQVdSvHelMn/Maoe04A==
X-Received: by 2002:a05:6000:2281:b0:3c8:ffcf:e01d with SMTP id ffacd0b85a97d-3d1e08a3713mr11295685f8f.55.1756886330035;
        Wed, 03 Sep 2025 00:58:50 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3decf936324sm1002477f8f.9.2025.09.03.00.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:58:49 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslawx.patynowski@intel.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net-next,1/2] devlink: Add new "max_mac_per_vf" generic device param
Date: Wed,  3 Sep 2025 10:58:09 +0300
Message-ID: <20250903075810.17149-1-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

Add a new device generic parameter to controls the maximum
number of MAC filters allowed per VF.

For example, to limit the number of mac filter per vf to 3 macs:
 $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
        value 3 \
        cmode runtime

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 Documentation/networking/devlink/devlink-params.rst | 4 ++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 211b58177e12..4b1f2d994254 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -143,3 +143,7 @@ own name.
    * - ``clock_id``
      - u64
      - Clock ID used by the device for registering DPLL devices and pins.
+   * - ``max_mac_per_vf``
+     - u32
+     - Controls the maximum number of MAC address filters a **trusted VF** can
+       use.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b32c9ceeb81d..dde5dcbca625 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -530,6 +530,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -594,6 +595,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME "clock_id"
 #define DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE DEVLINK_PARAM_TYPE_U64
 
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 41dcc86cfd94..62fd789ae01c 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -102,6 +102,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME,
 		.type = DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.50.1


