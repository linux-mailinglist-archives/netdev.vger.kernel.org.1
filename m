Return-Path: <netdev+bounces-232813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E55C090A8
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA184E29B2
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511692877FC;
	Sat, 25 Oct 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfOiZpf9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4113AA2D
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761397855; cv=none; b=R8/gBk6wwx9k5dKWbs4fjlBuTIbK30u4eWk8lLcqiLjtQN0VnTLeu6BSkmYpSUt1iHAyd8npsSE56iiYtyWQsvQ4DrDJyf56u5ZSmnNkmJL3GbH56xdmEHMFp6xtkq9upz3nl+FhTCLyHAyVPiriVN8SD/gjLEeeQ4I0+lghc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761397855; c=relaxed/simple;
	bh=OLghra6imCNWHy47dgXYDnt3npWlXZh3Fajt5u7q8K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DG5gs5QPWzDGiRkSOakkEwSjrIwkWDGCv3KZEYYNjcPXp3zJc7RnUIwhAxnb+hBgsawKBL3hTQevvJ0Py1TohJL0qGJetXf66vuQIjQHBRLPyZlOgDy6id8l8SbUOGXVZ7EsUJ6xiBda5BfUCNs88ju7/fGP0trJOlCshzut5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfOiZpf9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761397851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfnHEtILWETgTkXrR+8vZKONJFHmwrYlLtpgQi2+OKs=;
	b=EfOiZpf9Y80K8qt0HxzB+H0Uj24B7cMexaQaflQJgHvUPXgajVY/HeLaiXPzqo6CWT949n
	ZNozPLdjlQRvyIU+C//h08q0pscxKQBFit9Qpkn+y4hKZRAs8z5b0hNnYVtTk9yyHZqwam
	rmdkhB7Q+gpWuevGyxjYGcHTUje1UJ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-Nv5M3qb_Nmix5VNuaRZjUQ-1; Sat, 25 Oct 2025 09:10:50 -0400
X-MC-Unique: Nv5M3qb_Nmix5VNuaRZjUQ-1
X-Mimecast-MFC-AGG-ID: Nv5M3qb_Nmix5VNuaRZjUQ_1761397849
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso1595599f8f.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761397849; x=1762002649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfnHEtILWETgTkXrR+8vZKONJFHmwrYlLtpgQi2+OKs=;
        b=IazamEd7s/RvAKXcIbeJXaYSMacEbo86bZBTo9IYDa8jZo8YhzhOOc7u2zBWL1dlOT
         hU/QEtv8T4ijCkzLTnKAj2e5QN4A2wY+16UKrU0HHG5WnOLh7yo7hlFWYs7DWgAtZbIC
         K4F4BmMoovQdAFVVGqjFirNhpe+09f856IC+JS4NB91m4XpMzHZ7NU/wC0Psq0HrW+79
         jIhtInV5sWUFR+MNuVHA5towvYALwIQsMjOdeqPTtzFo1p4NUUhvTf4El2TRK1d2+A6q
         CRPw4vuNkFKJJ54+NyrYPmaWtvEneMws6VshX3PSXhuS+BxkrHM8y/jyiCT+o0eTo4lK
         yIdg==
X-Forwarded-Encrypted: i=1; AJvYcCXXcSHU9t4os58pJWpDjlLMmE4i8cdilWJhvRBdUaOcC/lnb8wzv+SWKYIoeJxc67AoUdvANjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5c5YfaQP5XucPqQW3VLxuk313qNYMaZXj4ce5bCZXiBauy/uw
	QgtYvQDRcc0cxrsEqsn0eILIav9wSK1JlvBB7hQgZrq4TDQJAMjzNyBGKztetkvRv5chTT2v89W
	opNO3isy0yKQHAy/DXCxxrClsK3P7jayuQ6xnLs6fiJnMn+NgLpVuANylcw==
X-Gm-Gg: ASbGnctpXs/OIJkbjZ/J/9d99LxbWJFBM08zbPh6ESyszGkNsCGpkcQE9UT+fYb3g+P
	KOYEc4rf2b5x7vBtM5bJ5KromTeaSdVUT6GEjivoRGyyBFyb1LJWE5oPhPdCyKGovqIEpKSiJ/+
	u5FRLX8zDETHyHaThZFGPP2mOIpPbeQUHuDRzVjaHvQTzXsGUywMWR5LDxXVtjSYMI5iq7tJDub
	Sr66ENORePAeRxsppHpImiyO4fRK5Z042MbIj5niygCPRz4n8kE0Qte/mhtwCQdd7P1lSj8vPGB
	JM8SsQM54pDEG/UvWnZhcajpuNlsWU+FBWyCdqYsBJmkiWztEQhonqgP26PkH+1eEC/079xLqL3
	SxRQr3wRdvz50xAbUbYWi/vpvL4N9+BcRJL4KmkoB
X-Received: by 2002:a05:600c:34d5:b0:46f:b42e:e394 with SMTP id 5b1f17b1804b1-4711793473fmr238467155e9.41.1761397849186;
        Sat, 25 Oct 2025 06:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPkt8yQMpMRn6w0dvSWtDDqZDTc71Iu+SqjZFzGg5lhihzYaP0MYTUi2cMh8B5RDLDLcauTA==
X-Received: by 2002:a05:600c:34d5:b0:46f:b42e:e394 with SMTP id 5b1f17b1804b1-4711793473fmr238467015e9.41.1761397848836;
        Sat, 25 Oct 2025 06:10:48 -0700 (PDT)
Received: from fedora.redhat.com (bzq-79-177-147-123.red.bezeqint.net. [79.177.147.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e4esm31935335e9.11.2025.10.25.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 06:10:48 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: kuba@kernel.org,
	przemyslawx.patynowski@intel.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net-next,v5,1/2] devlink: Add new "max_mac_per_vf" generic device param
Date: Sat, 25 Oct 2025 16:08:58 +0300
Message-ID: <20251025130859.144916-1-mheib@redhat.com>
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

For example, to limit a VF to 3 MAC addresses:
 $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
        value 3 \
        cmode runtime

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/devlink/devlink-params.rst | 4 ++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 0a9c20d70122..c0597d456641 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -151,3 +151,7 @@ own name.
    * - ``num_doorbells``
      - u32
      - Controls the number of doorbells used by the device.
+   * - ``max_mac_per_vf``
+     - u32
+     - Controls the maximum number of MAC address filters that can be assigned
+       to a Virtual Function (VF).
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9e824f61e40f..d01046ef0577 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -532,6 +532,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -602,6 +603,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME "num_doorbells"
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 70e69523412c..6b233b13b69a 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -112,6 +112,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME,
 		.type = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE,
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


