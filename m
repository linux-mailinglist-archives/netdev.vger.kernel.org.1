Return-Path: <netdev+bounces-277678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEI9OSwD2mlJxwgAu9opvQ
	(envelope-from <netdev+bounces-277678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C843DEEDA
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DAA23079C25
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D33264CD;
	Sat, 11 Apr 2026 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sqehe7xt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="itxTqQFT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33A336894
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895149; cv=none; b=ANKStUBzhU5hlpVOZgNY3/5f4st3FtE8RadGStVyRKxbe6P5cLxr2CknV6hvDJluC5pSbWeNnysamSuc3VVcQRQnCdKA5EeLicB7MgOgFOl/+DbswTTeILaMOlRzXO2NWRDG9Tu6aZMPP0xzOuDLr5uhoBYrPTNy8si+kSam6IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895149; c=relaxed/simple;
	bh=bNm4FHJN/H7CAep6Q4VeTzZQ9jW7ATrrShBqTZTmcd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNPVhVoD8Eka7H2vQTejD5kuu8S1d7gCO0iiwDAI8kjA4pj+Is8/8r/oVRDoDJBWOrnpzEPmEVCnJVmZUtr/4bD68B63ptdKwOW/WZq3f6ScXE98JNe+kBNR+jV632PUWr6Ij8h3QcLDl1AKdRLuhop/MBRi8h7EPj3xlvE1Iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sqehe7xt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=itxTqQFT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B48m0l1203142
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SqnBZH3Vk86Qatjz2YHaFg4xbKbquw6POFYBokCnei0=; b=Sqehe7xt2O5emA44
	X7/NvqJ47XykNDRqG0DpDHPFCMdeBZ6fZPmqjeWlB+ZUr3/3vnZbC0o0aZHwnwOI
	AYVqLbpVjojA5ajS/6eBsGsqGYfTNswIuOci7wFnZnNIsIRlGOzy9McrAEwI54oC
	20QJqUWpt0xnQcro5rIEe2ALgl7quSh4GgJ/xyiImZ/4smB/yXw6vi15EpZL3vTu
	b+ofDbFMJEG9FPBXV+CyYfgI4+QfnxFMTpBpo+a67I7RRXOAKrravYdb1W+TRuIn
	yLwEXyt5IRsnN2u5aQ6G6m/wwkrmZbok7rkv/TcT8Vtu1ryovVwGQWOFwU8b12cU
	L1z4Xw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jrbvr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c4664f75fso1964515b3a.3
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775895144; x=1776499944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqnBZH3Vk86Qatjz2YHaFg4xbKbquw6POFYBokCnei0=;
        b=itxTqQFTzhQW92CFiC2PYzCUsZSnrdLndTYYayuI1xJTEmSkq0thwdXKGEokyXARfM
         m1vBBVcKu+HGfR8w5YIK2W52YuN7kt95C+VFgvmCOX1RKZ8QL8duljv4LfItGkBnSB5i
         blgn4ptjCEPhLHzqVG027CNWdbXcIfiES5cilK/bXoUIXwiuIwB+S5WQqeC1YMmEIsDa
         zazP0iRiHexVTsPhJj7379UjBgJS43Or78V/49vM2KB681yVPP8B5v42mdS0tGpIgoZF
         taOBpF4Jrs6iBoqaF/qz5K4LP1TG5o4w+6jh5AbFj2XshpFOVLU3wPfWiWhks8UeiIYV
         2dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895144; x=1776499944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SqnBZH3Vk86Qatjz2YHaFg4xbKbquw6POFYBokCnei0=;
        b=I2bws/eHM4mXPT4nJzA0isb6vKB9/8tVKGH5GZdqL6fWEoycATLCrwmoJRjh38SIAF
         powcLwKgPiydeEUGQSHWTyZpniIvBuTk/X/MSdAQoEsp9K7cyA8xlI00vorX2ITk71ar
         bSJVW+eVkAM33kE0A+G0jMc7G+bIwS3VMzOESGDxnCQk6oxaruylVizwjyw40OFIKr88
         0YUTjCvDYs8FGsxW5ymQNo+hq6k1pWXlL4Ih3WnmBuaDRdteFGGaQemA7GhUuxaWeikC
         1RcqB65yE377uaZ+CMQv213WZDju7wRTUQ8eHIZ+rXNd7vvz4pbs3hkoqlNZT/4LIVZ0
         O9gA==
X-Forwarded-Encrypted: i=1; AJvYcCURV3M+F0Sw5Bj//rLm64O2y0Th4AtyyIic5hZwmwdZ0tcdKc7Dk9YFINhIFn9uzTrD+OALTXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/BSh5P0UlN5ZsvDfIjwge/psdwhz93b0KsoEAHnh5rsiY8r5
	R+8q+iDNnTxVgrB8TbimWnQ6IFnSocg+36WHMkRhUV50IXsUK0g9+vXGw7quhojfdvs82oZYS5h
	nDW2g99e45NN1rIQNNtHid2K+zST/ODVhk6p0Bccn/3xiLQYRXABLXdV2+Rc=
X-Gm-Gg: AeBDiev9LtLnAWCuXrp/oOU/m+cnozyAZqFjU9Erx2v90oc3/+LQssR2ywZQ+HV3im1
	IUO2rlWHwjozWWAzFxRV04khKPz/+c7kbyq5X0oWDKT7wQf66Gz3ulrEiBJczcjNO+9tOQJ8FGU
	1m+zs/sNNZMWohFF1ifoB5OfWZqQF9twSP6L/Ac7M394VlnFPXRf8xBQMcviM4R+AUzwrAxwhij
	M8RB2aLJXk/ouloUORukHNEl9mBgCKYuBTW2sYTyPrRAyqAhunHPN5NpvvSxGwLTKGD1a6m7UGd
	nJ/B49tIbX/jJOTehPr2NlrHdXsn7IjWiMnkOWPYTr+7ONwbUt5lkd/O5Ym6PVQ21qc+wVAgWkX
	0g7bZu5F0wyNpGSysGgMfDBLUGMEjMPcg3JGWNtfecEgikC0R4MsXDmeZ
X-Received: by 2002:aa7:9e9a:0:b0:82f:1f49:dfde with SMTP id d2e1a72fcca58-82f1f49e255mr1381768b3a.37.1775895143688;
        Sat, 11 Apr 2026 01:12:23 -0700 (PDT)
X-Received: by 2002:aa7:9e9a:0:b0:82f:1f49:dfde with SMTP id d2e1a72fcca58-82f1f49e255mr1381752b3a.37.1775895143172;
        Sat, 11 Apr 2026 01:12:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee4bsm5410996b3a.2.2026.04.11.01.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:12:22 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 13:42:04 +0530
Subject: [PATCH v2 4/6] bus: mhi: pci_generic: Add support for 64 bit
 register read & write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-tsc_timesync-v2-4-6f25f72987b3@oss.qualcomm.com>
References: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
In-Reply-To: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775895126; l=1575;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=bNm4FHJN/H7CAep6Q4VeTzZQ9jW7ATrrShBqTZTmcd4=;
 b=lHGF/AOsZKqrQwdWZ666QbhuwoZM1jYW/xq9sKJYFmvB3YcRlxXeE/Jgko5De/O6vbkTF7H8q
 rx+F5WuZDtCAyoCAVbNpUS0Rpd4PiKpRGWFn7bnRUbKzu2uXYVBtn5b
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDA2MiBTYWx0ZWRfXzNlYnxAUerRw
 hXdKQlC8uQaNTUDW2y5VBN5V+b9NSEES8STNpDu84cuWRNBO6jg6yfrTjbC7a1ZK5s8P2MgHDeG
 Ph9WGFI5mI5jNmo5RJeBMIOJYyAPkE/tdYPsAK5N2orP4I1MptnZDKGwZBrhA/ankKee7CYt3s9
 7pbKIF2HtQix1Eu/6RuiVxexak0xflaODL3GgT6L/tqpIOo1x0paAGBRGM4yIgJ2UfvfMslnwGJ
 VairbsyACxmsdpZKkml/+elnx3ciEYYDbF5aTgEj6zSUJAA7bz1aBZh1DW4rj8tTlTKdXFKY/fi
 ZOj8RM0cGxyYG8JHrsGcRPUXjimhIoLtWnAhEQVgq9Bbf/vU+eLoYFZBZAxOUEjgHGEnCTtiNkd
 TgRjZhfbelUh05CI2cjhfmwZ4m/RAyPaRPK3feU8Lo2arKQm7sjGQ4dIVRK3vaYFJnofphydCrb
 oBdP+47M6hv0RSX5JSg==
X-Proofpoint-ORIG-GUID: xx9qp7Ug2d5WeQ7cV4717EBRfjVlixMQ
X-Proofpoint-GUID: xx9qp7Ug2d5WeQ7cV4717EBRfjVlixMQ
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69da0268 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=MXGvhfJtNsboA4ndukAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110062
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-277678-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63C843DEEDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add functions which does read and write on 64 bit registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0884a384b77fc3f56fa62a12351933132ffc9293..b1122c7224bdd469406d96af6d3df342040e1002 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1046,6 +1046,27 @@ struct mhi_pci_device {
 	bool reset_on_remove;
 };
 
+#ifdef readq
+static int mhi_pci_read_reg64(struct mhi_controller *mhi_cntrl,
+			      void __iomem *addr, u64 *out)
+{
+	*out = readq(addr);
+	return 0;
+}
+#else
+#define mhi_pci_read_reg64 NULL
+#endif
+
+#ifdef writeq
+static void mhi_pci_write_reg64(struct mhi_controller *mhi_cntrl,
+				void __iomem *addr, u64 val)
+{
+	writeq(val, addr);
+}
+#else
+#define mhi_pci_write_reg64 NULL
+#endif
+
 static int mhi_pci_read_reg(struct mhi_controller *mhi_cntrl,
 			    void __iomem *addr, u32 *out)
 {
@@ -1347,6 +1368,8 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	mhi_cntrl->read_reg = mhi_pci_read_reg;
 	mhi_cntrl->write_reg = mhi_pci_write_reg;
+	mhi_cntrl->read_reg64 = mhi_pci_read_reg64;
+	mhi_cntrl->write_reg64 = mhi_pci_write_reg64;
 	mhi_cntrl->status_cb = mhi_pci_status_cb;
 	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
 	mhi_cntrl->runtime_put = mhi_pci_runtime_put;

-- 
2.34.1


