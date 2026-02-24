Return-Path: <netdev+bounces-260502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDltEuSZnWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:30:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A242B186FAC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B16307457A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE69396D21;
	Tue, 24 Feb 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A35fU+sp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HGzJrxhj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF138E124
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936149; cv=none; b=fwbmJZG0d0VEVXDUMwcMuqjm6TtIjIiykk+mbq95Uu0TCy5BoU8EFOaBUvOBSGner7xB14Af0GtNRIPjk5PHKpfjsmhU8isCS5Mv5ObygUQ5/Yg8kK6qbr7Pvg2bVhm3mieKz4/SbkDKXp39mBeHJhOMqqJS4n+I+XZSf/XOtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936149; c=relaxed/simple;
	bh=8RsaU3/B5fb2quHCDoVeS1dPgopldxdyklh+QihXc+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ivGVp+yp1OISyPd/wYfG1/3vfeMrWCFiGnXAZR9XbPdgqFxT7NygcRc3Ya0IKCJzIJKX2nXLt24v4pXtRZjOESHZm2C9/XQNjKDhTHsKmXxWWQpdaUghd68SHmknv/1z4Nyi+2UosH8Ip2Dtua0aypiXspyLIVKWCY5m/vhYCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A35fU+sp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HGzJrxhj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFduM2512900
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EtWL5kEKqebQO+ye3tOlSI
	IdbDWLjDqXwNvEGkrFCb4=; b=A35fU+sptSXCvq0lHDF+5yQZYgEJpoOGup4A3/
	nymcQ4pcTrcufDUnTJY0u/OweTCyO0Ym9bycdpJ0OcqAMEoiVTuAP5qc5I0gUHw6
	Ll/zI8GRxsyBJd2+oZObCJHP5Nsy9JhIOqDdnUVPFUx54kqVQDwMSKi1zL6q1czw
	UM+cidlF/M9YCu+RzzLBE8M9CXqMU6L8D+hDMr+/z7DiL3XtcL3a/KH1Jm+v3uBa
	oUTgHoWI7pv7VuFFU8HIwvffv63n1ksyNxJfwTB3oGu/L/uAC4NvBXTxjN9Tcy/O
	cxe0s+7mBiRlyV8FZmlYAttqsvAA7QLN6XDTO33T3EFZVJ0Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn81c6rs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:29:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a75ed2f89dso51597235ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771936146; x=1772540946; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtWL5kEKqebQO+ye3tOlSIIdbDWLjDqXwNvEGkrFCb4=;
        b=HGzJrxhjwpIgivuO0sn6p8NbzqXUW+gu8NtNku4U5kHJBYOrfyNmvohi27zVz4qwKw
         Ug/KlbnWIcpqUTPChLB9byS7YwK+uIz19cC49krvBzhMWD0rNbzkbF//TmcZt1DSSR1O
         toaX5I6MdphgqBm10cD2mPDbyX2KnX+1CcWuObJmRHNLz3q7GPQwIeXyUA6sOXgtSzlU
         MXc8UkaIaHaU6l9T7p0aabfA9e4NsFU8THvA1EzwmL4OBjVK+qHFS0/Rde46n7hObd/t
         BE4FJuSCUX621wivAinJoU87q4n3zOs4kPs9QthNrTOyuzL7r+7f4mAoJlwSQbhHMumN
         A2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771936146; x=1772540946;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtWL5kEKqebQO+ye3tOlSIIdbDWLjDqXwNvEGkrFCb4=;
        b=LP0iAHTWKqacDOsXu9P7ftaW6GTQnWotJTjkAHF3B32lUw+9R1kEYCeHzRaKct8JSk
         4/NTnn1JWcIfllL1C7bSSYXo3LiQAAHJpE/NRPdBQKvNrEh5FpYFt7tiECpoyuFbT94C
         pfW82KE2ylnCd2muPY4t9BJgS33Jp/l2lbt5cHX8ZGFCfZHhKH/vLdvXln6WbgmZu8wQ
         mC3z6uE08T80rKsvotTS5FJnycqi7ron94Xe3jwtiEBcxENU0nwEYPgBCma0f1QLr31m
         +p/c1gUTFA0RuSkWMKPVO+fUn5vU6cVVpMrUCTCzTwJbhHtsl5j54CxPLIQ5S+LJ2wfg
         x5OA==
X-Gm-Message-State: AOJu0Yz/0AnrYW6RLstsxaH3GDL8rAajw4UIRFJb7hy9yFVSFEZ+cdnF
	i2z3jQd4Yp4cl25+U2sT8Kh5nDjo9SB/To8rHNuOYVTNqiQHPUSPz3ozZevHrgeYZ4N5ESc6mqy
	ec1b6GYShQJ97EmBCNm/Pf/Ng04pAEhtA9Hq+ud4EYvkaH0DuU8zWiPNqtryYGCFideI=
X-Gm-Gg: ATEYQzw14VIheJ5Txsp/er25YL5EAsyOD+QgL0teIVJUxXbzstCfooG8v2+QxeXL+7z
	vdmLEGfVZUja8Liaj3XHghw6U1KZsFrfHNUfNxy7+EOPoLlrR5Y8MdN9gCZQxwPA8/2M7uEIZrM
	yMRCVuBzk+cfouiKcXVPOlype4dP0tjMvvr6kBFBakOtQm7t4Fx7yVllU2LvlOXKUse77MoidmA
	p56Uf7fnfUXs6Cir1VEd5D1UbrowY4gQWIKD/hFlbQPuSS5T6DOo71KQYiSqKnbcVpU+YPF3ukG
	PLgf9IQNHEQTs/ZQpmUUkNF72FOn/mN2Cl2bO3BsaqzlhbgH/pVQP9ibwAZdUMwzuTDgrjOQze2
	0n0k9A4JmJWzjwzF2Wi14qjWJChl+QD6QXP/ywmk1ZYXUl+4CaHw=
X-Received: by 2002:a17:903:32cb:b0:2ad:6e26:abbb with SMTP id d9443c01a7336-2ad745aac7dmr95066315ad.54.1771936146365;
        Tue, 24 Feb 2026 04:29:06 -0800 (PST)
X-Received: by 2002:a17:903:32cb:b0:2ad:6e26:abbb with SMTP id d9443c01a7336-2ad745aac7dmr95065995ad.54.1771936145825;
        Tue, 24 Feb 2026 04:29:05 -0800 (PST)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7504394csm105763565ad.85.2026.02.24.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:29:05 -0800 (PST)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 17:58:47 +0530
Subject: [PATCH net-next] MAINTAINERS: Update maintainer entry for QUALCOMM
 ETHQOS ETHERNET DRIVER
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qcom_ethqos_maintainer-v1-1-24e02701ea52@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH6ZnWkC/x2MzQqDMBAGX0X23EDc4l9fpYhI/Fr34KYmoQiSd
 zd4mMMcZk6KCIJIr+qkgL9E8VqkflTk1lm/MLIUJ7bcWuan2Z3fJqR193HaZtFUQDBNvbh+6NA
 zM5X4F/CR4x6/SZGM4kg05nwB+UayF3IAAAA=
X-Change-ID: 20260223-qcom_ethqos_maintainer-51dc897e8222
To: Jakub Kicinski <kuba@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: netdev@vger.kernel.org, "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771936143; l=1070;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=8RsaU3/B5fb2quHCDoVeS1dPgopldxdyklh+QihXc+o=;
 b=fY3PGEOc/l2RdvZhTkV4m6hLWhNB0fSRhZDc4T+ikaVb85pwXln+m+rhH19LXDsM4dWq15Hi9
 0IR+FpIx8roCa1ELWpdfsGscQiO2aHvIwFszntPfdPptnQL8MTzd+NX
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-GUID: ZcpYDpxHw7sOu_NDKZdXhsSuP7ic5Gly
X-Proofpoint-ORIG-GUID: ZcpYDpxHw7sOu_NDKZdXhsSuP7ic5Gly
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699d9993 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=pRcBdwvvMpn0FxNT3swA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwMSBTYWx0ZWRfX/E6u2k5VlSKr
 PUF0IpS7Ae2O3LFRxyQbrooabY73Za6fqXRIVAhtgy+rNQfmUpCqJpXTOUoMII02PY24e4NgbWs
 G7/SKzc09WBaVn5B6EY7c4TShe221+f6dfD2Fj6066RId7l/DPRJnKIfK3cxn6346/LyOgkkIMQ
 GoTspNAL8VzD6J/jXAXnEqfnI84tqXFeosbDaeu79Qane1s4W4q98rHkN8jscypV+WlXi72ZMtd
 3WpXcK3FGpF11TOw+4nO702R1p2rJWZFw2BPUQMxj3PSdzQTQlo4rbzT73Sgj/dbdPWigD16xt9
 1ZLPUCC9x08Kf0a6X2uedWXi5RJCiWzZp8ppJCe6Olv+4H2OjX+t0n/+uU7Q/d1G53bftgwLaD0
 aVzO604loFKDgv2PbbL4r2Wh72L1U1orDrF5y8tf4vgisfXYHqO0Rzd6DpfLa53q81v4Z8AfU00
 t9Ntcw3/ID9Df0rJkCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240101
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260502-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A242B186FAC
X-Rspamd-Action: no action

Replace Vinod Koul with Mohd Ayaan Anwar as the maintainer of the
QUALCOMM ETHQOS ETHERNET DRIVER. Vinod confirmed he is no longer
active in this area and agreed to be removed.

Acked-by: Vinod Koul <vkoul@kernel.org>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8d8a5c415976a6239898f433484d391b444297d..2b84a64c1c26deea0927b6403ec023e6e00409f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21694,7 +21694,7 @@ S:	Maintained
 F:	drivers/net/ethernet/qualcomm/emac/
 
 QUALCOMM ETHQOS ETHERNET DRIVER
-M:	Vinod Koul <vkoul@kernel.org>
+M:	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
 L:	netdev@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained

---
base-commit: f77c7b96014471f2c39823ed9fcb42967e7d9ede
change-id: 20260223-qcom_ethqos_maintainer-51dc897e8222

Best regards,
-- 
Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>


