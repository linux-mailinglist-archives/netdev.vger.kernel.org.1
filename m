Return-Path: <netdev+bounces-295790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CikqKbiyImpGcQEAu9opvQ
	(envelope-from <netdev+bounces-295790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:27:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C075647B65
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:27:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LzExSNc+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FuguP8Eh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295790-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295790-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDFA301F4BD
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2084D8DA8;
	Fri,  5 Jun 2026 11:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002884D98E9
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 11:19:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658388; cv=none; b=hLffRMqzp8AOr2Tbego0zzAPOc01SvOXKozffFoYwv0D+pBz4HEmFUrFpuSZEhjTXHiCNohdksEJeaQ5uaDmH6PRWey0FpvQpCBtKZWbR2fzqXxB5rLSGtueZNhoVo1gC+L0d6vXH9nnI40dz+8/DJdeIj9Cc1b93t7fAOJDGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658388; c=relaxed/simple;
	bh=aXRQZElnRbpEtEVaDUl5up1XNmweAtvQg9gPf2/3Jqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efspO+azPMtykJFov7/6x4+HoQ5e5qUwdfs4Jt05aPPxdI08qZIcKDm9nsoidVb/gaamHD2uNIjwKcCYMj3e5yJV1yaodOgxBFplVlFJfanM1CHPRAOKtZxgxt6qDYWqcNObFqmUXYtRIbm4TiJyssqypAQOD9bTcyjsMZcejjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LzExSNc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FuguP8Eh; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6556bKAp3111628
	for <netdev@vger.kernel.org>; Fri, 5 Jun 2026 11:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FbGvS0zEQQggdhKiQXoet088MbZofNJ1U1XxEt0bKsI=; b=LzExSNc+Sfa7fOAq
	XQ/w5XwKHh71l8AC8eJXe5O8hwUs+5HjeVKq6b2tmJkzzQsk6SQF306uqfv/DSgO
	bfz2cEaJBw0iyNZoOYEIlFab5ffJ2Ljs9KMge2+drPbPO5LHJArkwfKo3OKMIIIl
	NylW6AEqWwRO3ZYCrl215N5r9Ai8pJS9OSqDqpu/e/DLyawXPumeDzvLT6LH2Ks3
	2tt4Zhm+9I+ge7qVaMBZGE2nx+iZbr94GNWrGM6sFiUhDdMDkJ5gqBn3bTBLfeB9
	UyCKFW+kf2WOxd73EXHque58scm+LrpPVTEQcCr/mdG/6fIrhp/So6/dmEe7XJag
	+s5w9g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekfv737qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:19:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c32faa62so33251025ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780658382; x=1781263182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbGvS0zEQQggdhKiQXoet088MbZofNJ1U1XxEt0bKsI=;
        b=FuguP8EhLyy4ggI4CjYF04E+G92kwiG36i7sn2iJwbtGBQtEtAsoc9XuwIEqy/M67y
         5jMSXGWaXu/NJnF73jleFGKjhtNCB+QmnyVeQvlgt69mOKoGgv9Y0PNAVvJLgreKgEwd
         qwXU+IbK2gMDI4sfWhdkfkw0CxE7sBXKkhkUJ19Azp4GEQ59ebMd/A7BF1dZJPsUWBS7
         x3x5nRkWQmC1QvW7iJKotfagmgwO/4REyzCpBsNx2hQ3vYL7E5B4gbGKelaboDUEqAcT
         jdXEHYyoBGD/dj7IjZTx+P2dnknVDz8IVoGF7PPi8ZMUwHN+UjAoQRhAtxYcACGkSuRM
         EeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780658382; x=1781263182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FbGvS0zEQQggdhKiQXoet088MbZofNJ1U1XxEt0bKsI=;
        b=T9B9Jgf9C3evEZxT5vvXW+NTqQ/Q5WyLnTsKnuyMuBqzTW8MooBvbf+lbB2lRsTUo7
         4AfGXkmX68g/lt5AvxJ5GbExRyXi89o6HXiQL+ZKUuVjfj97p/n6FyNtF+QVqgpjhUEg
         KeXmQeUg34+AzM6sapLqXCVsfueEVq84J6Iv9714d7if23bOzB81uUEUxDcLPT5s90eh
         Q4TjWbQMZd5vOUWgVOmunIlQgU7sjZUCptXZFvmdmBX7mYX7Y5WAvIERuMoyr6Sxs7GL
         j5brj7bdoZ3J/YUqzdqm/9hpnUr2DcBIL13VdR22IDgqXwdV2ODpd1cUxAJK0C/Ig/pd
         eyDA==
X-Forwarded-Encrypted: i=1; AFNElJ/KBJ1hwx+IXzhkD8mhmTl0KOHFm/7krC/CfvS7NT0Nykn/K8iOV89/I3kdCUiq4V0TAUzK0NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NUCTAP95PCinAeC7+EbUlk79ohXg2aUk6rqFZO8i2Yxrpmo3
	qhGYgcDHPD8aYjNOZ1tco2F3aL+q42IV8EpL72dzb/CWZYWrSoSVOh1xNfAlWm3xxkviN1M1ByS
	hvqF19dQ7i1jn4h+PYvixL68ocyhsTg2r2a5W5ga7UuER+dIVVe08E2gGxN8=
X-Gm-Gg: Acq92OGkI3O3Ybi84YX1LjWJ35mLwpoHTzHyVC8G4M1948sVq+QWvw2sNFawwalvGrY
	1+XrrkCF4tyCubJEZuyTZzG1rqJKjv/OzkusWWiXp0FMlLueiDvOIklziNQ0xmuWoumr+mX754Y
	ACWSjtwK+xMDI0jjwg88uSgyMd1Y0FEr2GD9W6gvGJjoyYny8ex+tYr6ULmvN3K5Zc5aYSGGX47
	Ko+ON0xvkejMSdviRy0Kf9vt6ZizOS2WLMH6kUjPWVcILlqq9OcM3bh3/jyu0EBiRSIFbRFiH6f
	QSYZ40WtEFoTT1TQq7zrSvQFcSt8GsvwSMkbH8nsHNEGyAiXfmtpAPlauVwGjyRa/d5BgtQ8EHf
	Jgb/jnmJlZYIbu47coKF1214Rgc2kV0PFCQdPWB0wxIPA/6ovLM5EzGqhxuw3ojk=
X-Received: by 2002:a17:902:ce92:b0:2c0:db23:4a4 with SMTP id d9443c01a7336-2c1e85d210amr33173265ad.36.1780658382385;
        Fri, 05 Jun 2026 04:19:42 -0700 (PDT)
X-Received: by 2002:a17:902:ce92:b0:2c0:db23:4a4 with SMTP id d9443c01a7336-2c1e85d210amr33172895ad.36.1780658381951;
        Fri, 05 Jun 2026 04:19:41 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm124551665ad.17.2026.06.05.04.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:19:41 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 16:49:13 +0530
Subject: [PATCH v4 3/4] clk: qcom: smd-rpm: Add support for RPM clocks on
 Qualcomm Shikra SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-gcc-rpmcc-clks-v4-3-a0a7bfb44455@oss.qualcomm.com>
References: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
In-Reply-To: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: tET_zuClHWextexjR3Hnp_ZVfFnU-KCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDExMCBTYWx0ZWRfX9i1qm0DDOYX/
 QVf/x3Zxl3FxBH3I4iA/h1/x+xNc5aSNzT94b42vFhfm9yUY9ppp9jK2YXS1V99mQJvbd7frXnC
 gtRRilzBx3EvozIWhL9n/ChfaBMPw8K8R7Jiav6j6ZKxKGjxJymHFAyjcGl0JkvPFSo2nKiROcL
 Ok3MwC1IMdFZ2t2IpsnHlolcaFLdimMBbbCHJuFTfzfCLLR9gJcTxv0gRyPjBCQ1iQhlIQY0JKE
 b+iJnK4o0KQX2PG1m8DH6lW5IfVCNDZqRnAtK5mxrCDYFENXrQOIcAbaIy+rVTCUDsCRfNU5dsR
 I+K3Y3klddBFwZoPFU8wpfAnmCgsTiykcdndmbjG7u93ePlfBRdsIoUnTG+apQVZ7xRUoNK+bs+
 yetrDCikCLe7eVzrPz/E88lZQ4y1FCsx1F/f2uIhdKeOuyFx5QMepfwlyIEvQVijdkLxF+G/5ms
 zN4hUX3CYsTZOHM3gxw==
X-Authority-Analysis: v=2.4 cv=JNULdcKb c=1 sm=1 tr=0 ts=6a22b0cf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=L5rjUTd7AGozPMB3QYUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: tET_zuClHWextexjR3Hnp_ZVfFnU-KCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050110
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:imran.shaik@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C075647B65

Add support for RPM-managed clocks on Qualcomm Shikra SoC. The icc_clks
list is same as QCM2290, hence reuse the same for Shikra.

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-smd-rpm.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 103db984a40b950bd33fba668a292be46af6326e..d0d19bf0616efd5f1bc2caa037ff36d830a3495c 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1289,6 +1289,44 @@ static const struct rpm_smd_clk_desc rpm_clk_qcm2290 = {
 	.num_icc_clks = ARRAY_SIZE(qcm2290_icc_clks)
 };
 
+static struct clk_smd_rpm *shikra_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
+	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
+	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_branch_qdss_clk,
+	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
+	[RPM_SMD_LN_BB_CLK2] = &clk_smd_rpm_ln_bb_clk2,
+	[RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
+	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
+	[RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,
+	[RPM_SMD_RF_CLK2] = &clk_smd_rpm_rf_clk2,
+	[RPM_SMD_RF_CLK2_A] = &clk_smd_rpm_rf_clk2_a,
+	[RPM_SMD_RF_CLK3] = &clk_smd_rpm_38m4_rf_clk3,
+	[RPM_SMD_RF_CLK3_A] = &clk_smd_rpm_38m4_rf_clk3_a,
+	[RPM_SMD_IPA_CLK] = &clk_smd_rpm_ipa_clk,
+	[RPM_SMD_IPA_A_CLK] = &clk_smd_rpm_ipa_a_clk,
+	[RPM_SMD_SNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_snoc_periph_clk,
+	[RPM_SMD_SNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_snoc_periph_a_clk,
+	[RPM_SMD_SNOC_LPASS_CLK] = &clk_smd_rpm_bus_5_snoc_lpass_clk,
+	[RPM_SMD_SNOC_LPASS_A_CLK] = &clk_smd_rpm_bus_5_snoc_lpass_a_clk,
+	[RPM_SMD_CE1_CLK] = &clk_smd_rpm_ce1_clk,
+	[RPM_SMD_CE1_A_CLK] = &clk_smd_rpm_ce1_a_clk,
+	[RPM_SMD_QPIC_CLK] = &clk_smd_rpm_qpic_clk,
+	[RPM_SMD_QPIC_CLK_A] = &clk_smd_rpm_qpic_a_clk,
+	[RPM_SMD_HWKM_CLK] = &clk_smd_rpm_hwkm_clk,
+	[RPM_SMD_HWKM_A_CLK] = &clk_smd_rpm_hwkm_a_clk,
+	[RPM_SMD_PKA_CLK] = &clk_smd_rpm_pka_clk,
+	[RPM_SMD_PKA_A_CLK] = &clk_smd_rpm_pka_a_clk,
+	[RPM_SMD_BIMC_GPU_CLK] = &clk_smd_rpm_bimc_gpu_clk,
+	[RPM_SMD_BIMC_GPU_A_CLK] = &clk_smd_rpm_bimc_gpu_a_clk,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_shikra = {
+	.clks = shikra_clks,
+	.num_clks = ARRAY_SIZE(shikra_clks),
+	.icc_clks = qcm2290_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(qcm2290_icc_clks)
+};
+
 static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-mdm9607", .data = &rpm_clk_mdm9607 },
 	{ .compatible = "qcom,rpmcc-msm8226", .data = &rpm_clk_msm8974 },
@@ -1309,6 +1347,7 @@ static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
 	{ .compatible = "qcom,rpmcc-sdm429",  .data = &rpm_clk_sdm429  },
 	{ .compatible = "qcom,rpmcc-sdm660",  .data = &rpm_clk_sdm660  },
+	{ .compatible = "qcom,rpmcc-shikra",  .data = &rpm_clk_shikra  },
 	{ .compatible = "qcom,rpmcc-sm6115",  .data = &rpm_clk_sm6115  },
 	{ .compatible = "qcom,rpmcc-sm6125",  .data = &rpm_clk_sm6125  },
 	{ .compatible = "qcom,rpmcc-sm6375",  .data = &rpm_clk_sm6375  },

-- 
2.34.1


