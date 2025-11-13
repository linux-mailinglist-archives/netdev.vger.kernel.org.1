Return-Path: <netdev+bounces-238508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D9C5A3AD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6386C4F950A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E5E2F5A05;
	Thu, 13 Nov 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SzejrxMH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5735957
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069840; cv=none; b=gl0+JL0CDP3CjfIoggbb7krjtnr4p+WRQ6AIuILGnnqM84ZpIwtVggFvgBOqA1rwO2AUDM/naP9wuGdGTDmKJqIzZ9Jsur33bTbwS0rjwl7Vg3YqbjaNBrFf8E7jFrB48FR1h2kY+RyHc5P8ScYsdlMJ4r4+RFihI/BlbDcyTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069840; c=relaxed/simple;
	bh=qW11JUEojbvbLlVs9M7WXchyeXDRGME01cs3TXChmx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRDcg/pHDElF/KicGzcTAh2FStiqQyXYQ2Un/zr4ay0hx5tv05BY7BuaxZTOR3XodEjgjX2jFNlqNt9Y0ecJX+bHWQXpow4G9/GD2gJTpEW4cyQp4KxEbDMw6nM5ZpmxqIFcALwuq6Vpr1uIR3jKuT+4BFlY3b56Q1fQk+HX5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SzejrxMH; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5ADJYxll735443
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:37:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tBwEk7kuOCSNn1uFY8BH7VKpAmgwo5kIiumW/URoUGU=; b=SzejrxMHO6gu
	5ORwnxvLjNsVPBznXwtsBM2a3zI3uNX3BlVP8QQPYTtQPJXeTI64mT1BCsbpVSLv
	99D0T8+DU2fSKxA+d9vgRZSNdF05X164srEwBs2gFdMrU68ro/wmIEJr0aWxUlRe
	jkQv0VRvPNMkEJeeJvLsP83QCnzcDlm/1buigQ6vh6peDT27JGj0yUO99cYeSCOZ
	OLo+ftGldPxghCEuazsam0wTRvWFORs0pcrVyxgrtZNu9RizJLtxd2DNq7KrXyhk
	jwk2ux+h7BUMgihyUnFVC8Ji4OP9+FVdUCe3bwNzJEMj85+UrOP3rfJpjR5SDmNZ
	PZdToJCeoA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4adnm79117-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:37:17 -0800 (PST)
Received: from twshared24723.01.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 13 Nov 2025 21:37:16 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 4EA86C146749; Thu, 13 Nov 2025 13:37:14 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 1/2] Set steering-tag directly for PCIe P2P memory access
Date: Thu, 13 Nov 2025 13:37:11 -0800
Message-ID: <20251113213712.776234-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113213712.776234-1-zhipingz@meta.com>
References: <20251113213712.776234-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: f6VL-0TMUbvvw5IZ-gXWhm2Ud4RKedlF
X-Authority-Analysis: v=2.4 cv=dqXWylg4 c=1 sm=1 tr=0 ts=69164f8d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=S7gPgYD2AAAA:8 a=VabnemYjAAAA:8
 a=EILTAg3qfoMWCRUG53oA:9 a=1f8SinR9Uz0LDa1zYla5:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE2OSBTYWx0ZWRfX4najdDJ9RNkj
 s95FxLohgfvHAMgUrvlsMj46GdjvFHNEuIHfJ0UafbGWWxSP9W4bZItkgJwXfNarw1/lV1psv5b
 U1NxDyZpsNvI/ZUvqQYMbF4BtHxTIVm5ViHXRCplQhBtR9xb3tgI/wYNw4wiTIcm9xZboPrhOmh
 k73tgApmC+od5gtpI1KIb92+v+opZVEHEZg6Au4BvZZQpmOuEqfMBGyxwFhzJfjCO7KpXUkZAuG
 KdLRq95Oi9mmilBVle34tgX9ySaTgCzstxaDQYvxRLrsal27s9VVAmUNMt//ZIOiNs7UYBfSi2j
 4Z7hy0Y1xQGtkpmZT42NwYU73wqJ3Iq574iVVQy7SW8j/AwzruXXmFpxmiBE5Ly282Sga4S8ztX
 kuz/D5TGj+YYHYhaojQd3mITw4SflQ==
X-Proofpoint-ORIG-GUID: f6VL-0TMUbvvw5IZ-gXWhm2Ud4RKedlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01

PCIe: Add a memory type for P2P memory access

The current tph memory type definition applies for CPU use cases. For dev=
ice
memory accessed in the peer-to-peer (P2P) manner, we need another memory
type.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 4 ++++
 include/linux/pci-tph.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index cc64f93709a4..d983c9778c72 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -67,6 +67,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_type, =
u8 req_type,
 			if (info->pm_st_valid)
 				return info->pm_st;
 			break;
+		default:
+			return 0;
 		}
 		break;
 	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
@@ -79,6 +81,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_type, =
u8 req_type,
 			if (info->pm_xst_valid)
 				return info->pm_xst;
 			break;
+		default:
+			return 0;
 		}
 		break;
 	default:
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 9e4e331b1603..b989302b6755 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -14,10 +14,12 @@
  * depending on the memory type: Volatile Memory or Persistent Memory. W=
hen a
  * caller query about a target's Steering Tag, it must provide the targe=
t's
  * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/documen=
t/15470.
+ * Add a new tph type for PCI peer-to-peer access use case.
  */
 enum tph_mem_type {
 	TPH_MEM_TYPE_VM,	/* volatile memory */
-	TPH_MEM_TYPE_PM		/* persistent memory */
+	TPH_MEM_TYPE_PM,	/* persistent memory */
+	TPH_MEM_TYPE_P2P	/* peer-to-peer accessable memory */
 };
=20
 #ifdef CONFIG_PCIE_TPH
--=20
2.47.3


