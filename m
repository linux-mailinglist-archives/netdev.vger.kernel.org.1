Return-Path: <netdev+bounces-254422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAE4Nq9cemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:59:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51901A8022
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63EF93063B81
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38EA37472C;
	Wed, 28 Jan 2026 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="evPyzJ+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363037419A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626664; cv=none; b=Mw+ijkac53EGm1EJjoMkcl7jNysd+Oaj2qXkFTyS9uw9azfw73cQE4Y7/sPIWkFG7BUggATIxzw3ISHL6sBL+deXFP7UGT3TaDQQ/hagJni/BNLx5ScJAd7MD1ldVBVjQZ1zJI11uyFygufJ0SXbx5Z5ldmAGbx0wHT3aC3AYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626664; c=relaxed/simple;
	bh=RoFwxFwcRgKqK5MfM5Pd5Vjz2fP33MrjdoC4G1ylSgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etnwa4gPZPxd6TxPM5hXXeP9UVLv/VUlkOvW7S6l0oIfKDsWfnOiGS+dNpB3Lqw0lNl+x0BwvUBrROMpW7e3ClIcKGpK9DhJPJS8O0IPYKHOwvuB1T0jn9dvKe8UFRist1A90NQ4mtuvnTZbJFNAiNnjt/rK5owkE89/sMIbzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=evPyzJ+D; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0d67f1877so666665ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626662; x=1770231462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN4ga1V933N+rwZHw+ZSjLOfhHgFBM1zTkoYk3jFSgk=;
        b=gDNlrmEMdEOvZDNTl60gD8Xj7bKa6o5D/ka4MABdM6lNSHj2AIYEvSwo0NWyvo/mN2
         j+RU435Cu6U82vNneGODGhBRgCB3GQ29LfWkO03IsFuyakuvtuSgr88q+BWSYWTK8jvQ
         0/ucgFbx0wrcbFfo9zHoNgrLD7Gvg9TWNpmWh8LGzjZ1oUqZYvKso6liU4Xxf25sqMzb
         AacEY6SyuP9jFiQunIWQfx5GIIae2kvm0sO6OHNGUM2rK+O94krDMY9bjuCjXa3TFZxN
         q2rvT32iya2Rwv329bD4AAwgX7Vei/sV8rIwACCxop2mJoWdF6ubEwWXoG2kVY7cz0bn
         TN/w==
X-Gm-Message-State: AOJu0YywdBjHQ04zfVu+SqOdBHnaNFr0H+xEC31IdEJyHpFeopu5Wjq2
	twjaOL9ZIlSxtyCFk47TEcPudDr7/Ujfp3iBuevT4ZfbjfYzDKdcnedcEoveguqQpWVBIGdi2HQ
	wn3UOBOECAG6NKfSFYxnyk0nePt3guVjcW2AXAesiNlezNPHGXaV9v104m2+zJS1xUxaw4YPhUy
	AvC9Lx9mCeUltBwAfw4mCoQwVNb2ju+yHGgZhJqN0cAnP3LXHlEyPZDQKd4I0d1CVahwhQV1GQ6
	C925g2PYmsnmsdGTw==
X-Gm-Gg: AZuq6aJ8I+OEjGH0HqNPs3D/RzKpaPQP/hbvsWGcuBMji2YP6Khrs6dXmoH1sjR0CnC
	unqGlUH7hcq36A84ikH9/ygWn3OOND+rXDBzGvZqc/tndiI90K6kFe6u88a/mvePWty3PYag1dR
	A1Sjj/G+9QVMEy87J2i2QN61DZh8UmmbBRhqvNZ0mktq142RPnomkdSdnp/b//TBeBMQiBP3SEF
	nd38+tTWqKuOcnCMtx2qhZLLM5gOhqXdYHQNse1t3ZY39EKpTG1AL/5psh3aXVptmt+Ya9PIUe8
	upNUPLriebUILa0LotunH8E3vvQaVIAD/ncVJhFUp1PbLoXzV9w9uqNVLZ7kZa7sAhImu08tR3M
	3Ans7I9Hgey8QOzXK+sLAzVFbchdNPfIcnWCafShZ5nOUxXTYRZATE7lcq57iUhdpM8DiiZMW4I
	gcA1uMMrU5Wh6m64djPorRsKG7I7w0dD0D0G6vqpHtOFvw7GiTG0E=
X-Received: by 2002:a17:903:3204:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a870e87673mr60066165ad.50.1769626662219;
        Wed, 28 Jan 2026 10:57:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b80e705sm3800025ad.58.2026.01.28.10.57.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:57:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f42368322so85265b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769626660; x=1770231460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN4ga1V933N+rwZHw+ZSjLOfhHgFBM1zTkoYk3jFSgk=;
        b=evPyzJ+DXUKLM9gN5wRdHlJLIcKsJBkI8G1r9NPJlOfpVoNigYi2XjiR8t8qiaDKDQ
         EIfDs51XisrWnqL5Pigd7X915Ahp/73QumPI5l2qAOUbTYwR9bEDStScY8RsTcE3Oo9K
         oQs8UY5aeBQeRN71Do0rOAhjBBWmWjT3e9Kcw=
X-Received: by 2002:a05:6a00:1391:b0:81f:5127:5d48 with SMTP id d2e1a72fcca58-8236919d5bfmr5541436b3a.30.1769626660129;
        Wed, 28 Jan 2026 10:57:40 -0800 (PST)
X-Received: by 2002:a05:6a00:1391:b0:81f:5127:5d48 with SMTP id d2e1a72fcca58-8236919d5bfmr5541421b3a.30.1769626659593;
        Wed, 28 Jan 2026 10:57:39 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22466sm3263536b3a.50.2026.01.28.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:57:39 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v7, net-next 7/8] bng_en: Add TPA related functions
Date: Thu, 29 Jan 2026 00:26:22 +0530
Message-ID: <20260128185623.26559-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
References: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254422-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 51901A8022
X-Rspamd-Action: no action

Add the functions to handle TPA events in RX path.
This helps the next patch enable TPA functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  | 237 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 124 +++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  46 ++++
 3 files changed, 407 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
index 7ca273f2e54f..49828dc05514 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -206,4 +206,241 @@ struct rx_agg_cmp {
 
 #define RX_CMP_HASH_VALID(rxcmp)				\
 	((rxcmp)->rx_cmp_len_flags_type & cpu_to_le32(RX_CMP_FLAGS_RSS_VALID))
+
+#define TPA_AGG_AGG_ID(rx_agg)				\
+	((le32_to_cpu((rx_agg)->rx_agg_cmp_v) &		\
+	 RX_AGG_CMP_AGG_ID) >> RX_AGG_CMP_AGG_ID_SHIFT)
+
+#define RX_TPA_START_CMP_TYPE				GENMASK(5, 0)
+#define RX_TPA_START_CMP_FLAGS				GENMASK(15, 6)
+#define RX_TPA_START_CMP_FLAGS_SHIFT			6
+#define RX_TPA_START_CMP_FLAGS_ERROR			BIT(6)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT		GENMASK(9, 7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_SHIFT		7
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_JUMBO		BIT(7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_HDS		(0x2 << 7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_JUMBO	(0x5 << 7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_HDS	(0x6 << 7)
+#define RX_TPA_START_CMP_FLAGS_RSS_VALID		BIT(10)
+#define RX_TPA_START_CMP_FLAGS_TIMESTAMP		BIT(11)
+#define RX_TPA_START_CMP_FLAGS_ITYPES			GENMASK(15, 12)
+#define RX_TPA_START_CMP_FLAGS_ITYPES_SHIFT		12
+#define RX_TPA_START_CMP_FLAGS_ITYPE_TCP		(0x2 << 12)
+#define RX_TPA_START_CMP_LEN				GENMASK(31, 16)
+#define RX_TPA_START_CMP_LEN_SHIFT			16
+#define RX_TPA_START_CMP_V1				BIT(0)
+#define RX_TPA_START_CMP_RSS_HASH_TYPE			GENMASK(15, 9)
+#define RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT		9
+#define RX_TPA_START_CMP_V3_RSS_HASH_TYPE		GENMASK(15, 7)
+#define RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT		7
+#define RX_TPA_START_CMP_AGG_ID				GENMASK(25, 16)
+#define RX_TPA_START_CMP_AGG_ID_SHIFT			16
+#define RX_TPA_START_CMP_METADATA1			GENMASK(31, 28)
+#define RX_TPA_START_CMP_METADATA1_SHIFT		28
+#define RX_TPA_START_METADATA1_TPID_SEL			GENMASK(30, 28)
+#define RX_TPA_START_METADATA1_TPID_8021Q		BIT(28)
+#define RX_TPA_START_METADATA1_TPID_8021AD		(0x0 << 28)
+#define RX_TPA_START_METADATA1_VALID			BIT(31)
+
+struct rx_tpa_start_cmp {
+	__le32 rx_tpa_start_cmp_len_flags_type;
+	u32 rx_tpa_start_cmp_opaque;
+	__le32 rx_tpa_start_cmp_misc_v1;
+	__le32 rx_tpa_start_cmp_rss_hash;
+};
+
+#define TPA_START_HASH_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_RSS_VALID))
+
+#define TPA_START_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_RSS_HASH_TYPE) >>				\
+	  RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_V3_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_V3_RSS_HASH_TYPE) >>			\
+	  RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_AGG_ID(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_CMP_AGG_ID) >> RX_TPA_START_CMP_AGG_ID_SHIFT)
+
+#define TPA_START_ERROR(rx_tpa_start)					\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_ERROR))
+
+#define TPA_START_VLAN_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_misc_v1 &			\
+	 cpu_to_le32(RX_TPA_START_METADATA1_VALID))
+
+#define TPA_START_VLAN_TPID_SEL(rx_tpa_start)				\
+	(le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_METADATA1_TPID_SEL)
+
+#define RX_TPA_START_CMP_FLAGS2_IP_CS_CALC		BIT(0)
+#define RX_TPA_START_CMP_FLAGS2_L4_CS_CALC		BIT(1)
+#define RX_TPA_START_CMP_FLAGS2_T_IP_CS_CALC		BIT(2)
+#define RX_TPA_START_CMP_FLAGS2_T_L4_CS_CALC		BIT(3)
+#define RX_TPA_START_CMP_FLAGS2_IP_TYPE			BIT(8)
+#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_VALID		BIT(9)
+#define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT		GENMASK(11, 10)
+#define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT_SHIFT	10
+#define RX_TPA_START_CMP_V3_FLAGS2_T_IP_TYPE		BIT(10)
+#define RX_TPA_START_CMP_V3_FLAGS2_AGG_GRO		BIT(11)
+#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL		GENMASK(31, 16)
+#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_SHIFT		16
+#define RX_TPA_START_CMP_V2				BIT(0)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK	GENMASK(3, 1)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT	1
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	(0x0 << 1)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT	(0x3 << 1)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_FLUSH	(0x5 << 1)
+#define RX_TPA_START_CMP_CFA_CODE			GENMASK(31, 16)
+#define RX_TPA_START_CMPL_CFA_CODE_SHIFT		16
+#define RX_TPA_START_CMP_METADATA0_TCI_MASK		GENMASK(31, 16)
+#define RX_TPA_START_CMP_METADATA0_VID_MASK		GENMASK(27, 16)
+#define RX_TPA_START_CMP_METADATA0_SFT			16
+
+struct rx_tpa_start_cmp_ext {
+	__le32 rx_tpa_start_cmp_flags2;
+	__le32 rx_tpa_start_cmp_metadata;
+	__le32 rx_tpa_start_cmp_cfa_code_v2;
+	__le32 rx_tpa_start_cmp_hdr_info;
+};
+
+#define TPA_START_CFA_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	 RX_TPA_START_CMP_CFA_CODE) >> RX_TPA_START_CMPL_CFA_CODE_SHIFT)
+
+#define TPA_START_IS_IPV6(rx_tpa_start)				\
+	(!!((rx_tpa_start)->rx_tpa_start_cmp_flags2 &		\
+	    cpu_to_le32(RX_TPA_START_CMP_FLAGS2_IP_TYPE)))
+
+#define TPA_START_ERROR_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK) >>			\
+	 RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT)
+
+#define TPA_START_METADATA0_TCI(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_METADATA0_TCI_MASK) >>			\
+	 RX_TPA_START_CMP_METADATA0_SFT)
+
+#define RX_TPA_END_CMP_TYPE				GENMASK(5, 0)
+#define RX_TPA_END_CMP_FLAGS				GENMASK(15, 6)
+#define RX_TPA_END_CMP_FLAGS_SHIFT			6
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT			GENMASK(9, 7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_SHIFT		7
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_JUMBO		BIT(7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_HDS		(0x2 << 7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO	(0x5 << 7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS		(0x6 << 7)
+#define RX_TPA_END_CMP_FLAGS_RSS_VALID			BIT(10)
+#define RX_TPA_END_CMP_FLAGS_ITYPES			GENMASK(15, 12)
+#define RX_TPA_END_CMP_FLAGS_ITYPES_SHIFT		12
+#define RX_TPA_END_CMP_FLAGS_ITYPE_TCP			(0x2 << 12)
+#define RX_TPA_END_CMP_LEN				GENMASK(31, 16)
+#define RX_TPA_END_CMP_LEN_SHIFT			16
+#define RX_TPA_END_CMP_V1				BIT(0)
+#define RX_TPA_END_CMP_TPA_SEGS				GENMASK(15, 8)
+#define RX_TPA_END_CMP_TPA_SEGS_SHIFT			8
+#define RX_TPA_END_CMP_AGG_ID				GENMASK(25, 16)
+#define RX_TPA_END_CMP_AGG_ID_SHIFT			16
+#define RX_TPA_END_GRO_TS				BIT(31)
+
+struct rx_tpa_end_cmp {
+	__le32 rx_tpa_end_cmp_len_flags_type;
+	u32 rx_tpa_end_cmp_opaque;
+	__le32 rx_tpa_end_cmp_misc_v1;
+	__le32 rx_tpa_end_cmp_tsdelta;
+};
+
+#define TPA_END_AGG_ID(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_AGG_ID) >> RX_TPA_END_CMP_AGG_ID_SHIFT)
+
+#define TPA_END_TPA_SEGS(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_TPA_SEGS) >> RX_TPA_END_CMP_TPA_SEGS_SHIFT)
+
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO				\
+	cpu_to_le32(RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO &		\
+		    RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS)
+
+#define TPA_END_GRO(rx_tpa_end)						\
+	((rx_tpa_end)->rx_tpa_end_cmp_len_flags_type &			\
+	 RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO)
+
+#define TPA_END_GRO_TS(rx_tpa_end)					\
+	(!!((rx_tpa_end)->rx_tpa_end_cmp_tsdelta &			\
+	    cpu_to_le32(RX_TPA_END_GRO_TS)))
+
+#define RX_TPA_END_CMP_TPA_DUP_ACKS			GENMASK(3, 0)
+#define RX_TPA_END_CMP_PAYLOAD_OFFSET			GENMASK(23, 16)
+#define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT		16
+#define RX_TPA_END_CMP_AGG_BUFS				GENMASK(31, 24)
+#define RX_TPA_END_CMP_AGG_BUFS_SHIFT			24
+#define RX_TPA_END_CMP_TPA_SEG_LEN			GENMASK(15, 0)
+#define RX_TPA_END_CMP_V2				BIT(0)
+#define RX_TPA_END_CMP_ERRORS				GENMASK(2, 1)
+#define RX_TPA_END_CMPL_ERRORS_SHIFT			1
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	(0x0 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NOT_ON_CHIP	(0x2 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT	(0x3 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_RSV_ERROR	(0x4 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_FLUSH	(0x5 << 1)
+
+struct rx_tpa_end_cmp_ext {
+	__le32 rx_tpa_end_cmp_dup_acks;
+	__le32 rx_tpa_end_cmp_seg_len;
+	__le32 rx_tpa_end_cmp_errors_v2;
+	u32 rx_tpa_end_cmp_start_opaque;
+};
+
+#define TPA_END_ERRORS(rx_tpa_end_ext)					\
+	((rx_tpa_end_ext)->rx_tpa_end_cmp_errors_v2 &			\
+	 cpu_to_le32(RX_TPA_END_CMP_ERRORS))
+
+#define TPA_END_PAYLOAD_OFF(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_PAYLOAD_OFFSET) >>				\
+	RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT)
+
+#define TPA_END_AGG_BUFS(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_AGG_BUFS) >> RX_TPA_END_CMP_AGG_BUFS_SHIFT)
+
+#define EVENT_DATA1_RESET_NOTIFY_FATAL(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	 ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_EXCEPTION_FATAL)
+
+#define EVENT_DATA1_RESET_NOTIFY_FW_ACTIVATION(data1)			\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_ACTIVATION)
+
+#define EVENT_DATA2_RESET_NOTIFY_FW_STATUS_CODE(data2)			\
+	((data2) &							\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA2_FW_STATUS_CODE_MASK)
+
+#define EVENT_DATA1_RECOVERY_MASTER_FUNC(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_MASTER_FUNC))
+
+#define EVENT_DATA1_RECOVERY_ENABLED(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_RECOVERY_ENABLED))
+
+#define BNGE_EVENT_ERROR_REPORT_TYPE(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_SFT)
+
+#define BNGE_EVENT_INVALID_SIGNAL_DATA(data2)				\
+	(((data2) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_SFT)
 #endif /* _BNGE_HW_DEF_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a8e036d666df..9717065a2f20 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -377,11 +377,37 @@ static void bnge_free_one_agg_ring_bufs(struct bnge_net *bn,
 	}
 }
 
+static void bnge_free_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		struct bnge_tpa_info *tpa_info = &rxr->rx_tpa[i];
+		u8 *data = tpa_info->data;
+
+		if (!data)
+			continue;
+
+		tpa_info->data = NULL;
+		page_pool_free_va(rxr->head_pool, data, false);
+	}
+}
+
 static void bnge_free_one_rx_ring_pair_bufs(struct bnge_net *bn,
 					    struct bnge_rx_ring_info *rxr)
 {
+	struct bnge_tpa_idx_map *map;
+
+	if (rxr->rx_tpa)
+		bnge_free_one_tpa_info_data(bn, rxr);
+
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	bnge_free_one_agg_ring_bufs(bn, rxr);
+
+	map = rxr->rx_tpa_idx_map;
+	if (map)
+		memset(map->agg_idx_bmap, 0, sizeof(map->agg_idx_bmap));
 }
 
 static void bnge_free_rx_ring_pair_bufs(struct bnge_net *bn)
@@ -452,11 +478,70 @@ static void bnge_free_all_rings_bufs(struct bnge_net *bn)
 	bnge_free_tx_skbs(bn);
 }
 
+static void bnge_free_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		kfree(rxr->rx_tpa_idx_map);
+		rxr->rx_tpa_idx_map = NULL;
+		if (rxr->rx_tpa) {
+			for (j = 0; j < bn->max_tpa; j++) {
+				kfree(rxr->rx_tpa[j].agg_arr);
+				rxr->rx_tpa[j].agg_arr = NULL;
+			}
+		}
+		kfree(rxr->rx_tpa);
+		rxr->rx_tpa = NULL;
+	}
+}
+
+static int bnge_alloc_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	if (!bd->max_tpa_v2)
+		return 0;
+
+	bn->max_tpa = max_t(u16, bd->max_tpa_v2, MAX_TPA);
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		rxr->rx_tpa = kcalloc(bn->max_tpa, sizeof(struct bnge_tpa_info),
+				      GFP_KERNEL);
+		if (!rxr->rx_tpa)
+			goto err_free_tpa_info;
+
+		for (j = 0; j < bn->max_tpa; j++) {
+			struct rx_agg_cmp *agg;
+
+			agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
+			if (!agg)
+				goto err_free_tpa_info;
+			rxr->rx_tpa[j].agg_arr = agg;
+		}
+		rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
+					      GFP_KERNEL);
+		if (!rxr->rx_tpa_idx_map)
+			goto err_free_tpa_info;
+	}
+	return 0;
+
+err_free_tpa_info:
+	bnge_free_tpa_info(bn);
+	return -ENOMEM;
+}
+
 static void bnge_free_rx_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	bnge_free_tpa_info(bn);
 	for (i = 0; i < bd->rx_nr_rings; i++) {
 		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
 		struct bnge_ring_struct *ring;
@@ -581,6 +666,12 @@ static int bnge_alloc_rx_rings(struct bnge_net *bn)
 				goto err_free_rx_rings;
 		}
 	}
+
+	if (bn->priv_flags & BNGE_NET_EN_TPA) {
+		rc = bnge_alloc_tpa_info(bn);
+		if (rc)
+			goto err_free_rx_rings;
+	}
 	return rc;
 
 err_free_rx_rings:
@@ -1126,6 +1217,30 @@ static int bnge_alloc_one_agg_ring_bufs(struct bnge_net *bn,
 	return -ENOMEM;
 }
 
+static int bnge_alloc_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	dma_addr_t mapping;
+	u8 *data;
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		data = __bnge_alloc_rx_frag(bn, &mapping, rxr,
+					    GFP_KERNEL);
+		if (!data)
+			goto err_free_tpa_info_data;
+
+		rxr->rx_tpa[i].data = data;
+		rxr->rx_tpa[i].data_ptr = data + bn->rx_offset;
+		rxr->rx_tpa[i].mapping = mapping;
+	}
+	return 0;
+
+err_free_tpa_info_data:
+	bnge_free_one_tpa_info_data(bn, rxr);
+	return -ENOMEM;
+}
+
 static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 {
 	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
@@ -1140,8 +1255,17 @@ static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 		if (rc)
 			goto err_free_one_rx_ring_bufs;
 	}
+
+	if (rxr->rx_tpa) {
+		rc = bnge_alloc_one_tpa_info_data(bn, rxr);
+		if (rc)
+			goto err_free_one_agg_ring_bufs;
+	}
+
 	return 0;
 
+err_free_one_agg_ring_bufs:
+	bnge_free_one_agg_ring_bufs(bn, rxr);
 err_free_one_rx_ring_bufs:
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 69cc0442b456..1ab89febbef5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -153,6 +153,45 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+#define BNGE_NO_FW_ACCESS(bd)	(pci_channel_offline((bd)->pdev))
+
+#define MAX_TPA		256
+#define MAX_TPA_MASK	(MAX_TPA - 1)
+#define MAX_TPA_SEGS	0x3f
+
+#define BNGE_TPA_INNER_L3_OFF(hdr_info)	\
+	(((hdr_info) >> 18) & 0x1ff)
+
+#define BNGE_TPA_INNER_L2_OFF(hdr_info)	\
+	(((hdr_info) >> 9) & 0x1ff)
+
+#define BNGE_TPA_OUTER_L3_OFF(hdr_info)	\
+	((hdr_info) & 0x1ff)
+
+struct bnge_tpa_idx_map {
+	u16		agg_id_tbl[1024];
+	DECLARE_BITMAP(agg_idx_bmap, MAX_TPA);
+};
+
+struct bnge_tpa_info {
+	void			*data;
+	u8			*data_ptr;
+	dma_addr_t		mapping;
+	u16			len;
+	unsigned short		gso_type;
+	u32			flags2;
+	u32			metadata;
+	enum pkt_hash_types	hash_type;
+	u32			rss_hash;
+	u32			hdr_info;
+
+	u16			cfa_code; /* cfa_code in TPA start compl */
+	u8			agg_count;
+	bool			vlan_valid;
+	bool			cfa_code_valid;
+	struct rx_agg_cmp	*agg_arr;
+};
+
 /* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1. We need one extra
  * BD because the first TX BD is always a long BD.
  */
@@ -245,6 +284,10 @@ struct bnge_net {
 #define BNGE_STATE_NAPI_DISABLED	0
 
 	u32			msg_enable;
+	u16			max_tpa;
+	__be16			vxlan_port;
+	__be16			nge_port;
+	__be16			vxlan_gpe_port;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -390,6 +433,9 @@ struct bnge_rx_ring_info {
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
 
+	struct bnge_tpa_info	*rx_tpa;
+	struct bnge_tpa_idx_map *rx_tpa_idx_map;
+
 	struct bnge_ring_struct	rx_ring_struct;
 	struct bnge_ring_struct	rx_agg_ring_struct;
 	struct page_pool	*page_pool;
-- 
2.47.3


