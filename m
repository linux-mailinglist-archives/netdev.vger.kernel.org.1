Return-Path: <netdev+bounces-258838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KodH4PYkmnKywEAu9opvQ
	(envelope-from <netdev+bounces-258838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:42:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6568141A41
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27BF23011F0B
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FDB3033C5;
	Mon, 16 Feb 2026 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBI0AAdG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRtaSqpr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44A1A9F88
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231351; cv=none; b=QqgxWUJV3qiEAmvHMXRbRQBfCXHEbpkh1cMjRg3Z2glajNpXUrUQlSH+obQyJ6uhdQRqh7hXC57HyuA1oth5T4Ajtq1b2TLKpd6T2JYsm5XHC+WSvNwbRTff+SLgcbcoblJ+CSVoy2z1ExknYkznGphPxCwy4aMsJU2MSg4ol7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231351; c=relaxed/simple;
	bh=273Nr0XHPQUdhTSvPzvzpZ8kis9AL4D8PVuXSP+lphc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ScYlGxNrlJIm02OlNu5YKsimXX5DhV6yqsHGw4/RzeYzlwma4Zt9tpzNExbgUyfYY5iqqDXe79Swupu2Mzrd3MjXzMC97ALA6vIXQ1YPkFHiw+hUzkMZGQIUX2Xnajk5hJ7thdOswoKRnNNHg5ZAJuIvhJ+0cJ1NWAaBI052ZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBI0AAdG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRtaSqpr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FMRigI2101896
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 08:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HbfJmlB0KWV5BpwREIlR5/
	MoGFpgyCdJTapgfLzoYKo=; b=jBI0AAdGgcft/R1tTN0PNdwXZqE1fj15enmJyF
	0fs7WiDben4hA7Tn/5fnpgiod1vv2s11HwewD1Fq9p7REQ+MmQWl4rOPvaQiFzFM
	OF4LdTT/FbVNcdRtPzExqecWW/ORgnEOdG2yIUVCwtWEWiY1GxBZnVVSk4E28TP9
	yy9D6cW29B629A7c70WeaFy8gJqv4PuuyCY0LxUoR0pBPOVkJWAJkyznvXTdx7+Y
	WRVeagvIqtEq8LKNDzSGLYZ4OcpiVlMuUCAl2G6af15BTXlLmREi1322yzwX7P3E
	0Vb+lSdkrHTLwfePiwJX8g8un/HFp7cQ5Lxj//iuLJU1Mw3A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cb6buj6t4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 08:42:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a755a780caso35136925ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771231348; x=1771836148; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbfJmlB0KWV5BpwREIlR5/MoGFpgyCdJTapgfLzoYKo=;
        b=NRtaSqprYlgZ9smI3JguWyREz14vTnyfDVvzBng9GANMG30OpAQ6n4KVm0QcG8Plg8
         MTA4S0q3+zdQmL4RL6yHAQJvN41+0rEX5vP9+IUfI5M6s8qWP5fPku86748AoGGkV3DW
         NJ0+lAwfp0OT62citrHpVOVPvQ0uuPFHOQvwd8FJluh5Oskix4SuTwEcY78J3XpBxsKd
         QtoqV9RvjzcNiogvSrIAxknnS3vPMa6AjJ+scssYeSf8HpRoZ9rP9vVu8O1+vOTXJSKu
         OsZlUoU/GIrD8NR/rFQ56Q4/RQqBvAsNaVmRsLEOiIMHF7N8M8kjbphq6842vvqYkOBE
         Xfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771231348; x=1771836148;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbfJmlB0KWV5BpwREIlR5/MoGFpgyCdJTapgfLzoYKo=;
        b=EnXSnDM2tG+jOie9R10p0ZKUrVPTKW7KPoWqBZlzfwd0O2+Na/ga5r/exV2Ibkq2h5
         K5vbhXAFOK9FWry3U1ACF8IcJg5/OSX/vBvD/j1N86Gqv3PZYV4pMS0IVCJYFqhg1TE/
         MVcn7Gbvhb5Lbg/XX7NhyYzk6W8BW7xQhodx7RwZzJgXPwZ4RoN38TDZljr02RVvmPo5
         x4Jmr3EcXXAFj7JThGAdLolWhZyeFO6tKa0KGip6J61O/yZ9XJ9lyy6EQWyWG3mJdSfT
         sA0EIa18G3adT+RS0jtNlo4FmgB6OXtee9FDlbQ5PUqRp8AzkC7cY4EFRi71daTRdyK1
         3D2g==
X-Forwarded-Encrypted: i=1; AJvYcCVOaMY2MELjj8u8vmdSOG7KbtYIZl6bsaLvtFWdDJ6dah+yqMuHEiBWAABnLRG2wp02PmJ3t9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEel1xl1kU1MnOFzgu/AuuwzB21BJ6VNVhBRGUZymCam1kmVHL
	Se30PF4NUFMn+fDJrOudOc6cEfEY9o1xi+Ua4ebcw5ScJwD1spE2gtwbnEJn7ap5eEUS+fuST1G
	favqX1Tiybksd09gxbYa5Jj73YmVJykhKjyS5H8HZfLM3DC3X6wJ2rhvZCZY=
X-Gm-Gg: AZuq6aK4/bSdCf5onUlJ+Q10Fe/AJ1GqOWy4y4tEv6bnofDIY3RY3f1WWzVhbI0okUy
	OCL6pqPbgXxVa8+0U2ig6qbrIshGx6QiL1Z0UvYqJWkUohCKvT7inwM0ikesZw8YYa6KlBTBhuC
	fxpD5O1VXZ6clDJaUOSFUdVc6jmUaPffQIAXp2rZfX2x0b24K3xgjinL+wJShAtVaf71LVMUxkU
	TZxdYe9o1SZYa/D5wRvyf0hAyuX9scX6ZnDHlpYKWBb/nCSUvbKSjxhYRr8nQb1balGAr7sM1Aj
	I4FeAqZyFgKwndGHEfHfrpQZvEhJAjtde574Ij8tvZQO7LOG8IGnQXsALbPNiLqvfhZL/arW8Z7
	m958jsMO1yh/xv0JBSAvuemrve/UGOSC705BNppuWoEEA9hKeHLplMYbjZQ==
X-Received: by 2002:a17:90a:dfc8:b0:352:d0cf:9d18 with SMTP id 98e67ed59e1d1-357b50c0548mr6265316a91.5.1771231347862;
        Mon, 16 Feb 2026 00:42:27 -0800 (PST)
X-Received: by 2002:a17:90a:dfc8:b0:352:d0cf:9d18 with SMTP id 98e67ed59e1d1-357b50c0548mr6265300a91.5.1771231347403;
        Mon, 16 Feb 2026 00:42:27 -0800 (PST)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a87f47f1sm5283488a91.8.2026.02.16.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:42:26 -0800 (PST)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 14:11:45 +0530
Subject: [PATCH v2] net: qrtr: Expand control port access to root
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-qrtr-control-port-access-permission-v2-1-71c15f2c5c7f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEjYkmkC/5WNQQ6CMBBFr2Jm7ZC2irGuvIdhUcsgTYDCTCUaw
 t0t3MDNT95P/vsLCHEggdthAaY5SIhDBnM8gG/d8CIMdWYwylyUUSVOnBh9HBLHDsfICZ33JII
 jcR9k2+OzIaettWdXXiGbRqYmfPaXR5W5DZIif/fTWW/tf/5Zo0aySqmTJWvq8h5FiuntOh/7v
 sgB1bquPxbkYuHdAAAA
X-Change-ID: 20260205-qrtr-control-port-access-permission-bfea19994a58
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771231343; l=2547;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=273Nr0XHPQUdhTSvPzvzpZ8kis9AL4D8PVuXSP+lphc=;
 b=hx6fAGzK1MFzjcNI3SjuYPU3vGWrpQ43d4p1twDzl8ow8coLtPyEzaRa+tdtBE7n2M0W+ut92
 F1vXB3UujeDCSTw18ESqzgyPFckg5TM0ceA+CcBG4ImMPy7xsXKBoCn
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-GUID: 1M1lUYnF-RuEmbj6fRUe-Upsf1t8A0l8
X-Proofpoint-ORIG-GUID: 1M1lUYnF-RuEmbj6fRUe-Upsf1t8A0l8
X-Authority-Analysis: v=2.4 cv=M8dA6iws c=1 sm=1 tr=0 ts=6992d874 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1Fy8072LN9Nq9XkES_AA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3MiBTYWx0ZWRfX8LQXER1EmfCz
 nfN6Apm7CFNoXaFeSqiMZrgdr/IAoT5Iuvgxu8KCD9foQVl+s5CnZHNEfRKc4mRD0UDRfVZQZfN
 EYxd3sXbsrEA1Z1Z3AJ0KKgboeYfK/TbKu6vSJ0ExL1mcuhvEMv8xe3a+JJjjfQ88J21cmOeBtM
 hw2j2T326zoqE3hIf6wfUxzt1BXck5NoVgLlBTBGg0aml9YFwg/WcRRLQAUpUQbYmHXwBuxybCX
 5VPXdSILsZwzOB/X2eZOPqENWJ8tPkucxoTfPRUAlbQbF4mWozEDpj6MWQ6GOLNq7IJ7eUEMOx7
 hBEcU6P7f2dHyQUtwTh6cg8v4EJa4N4b+hFJR+DzW8OYHsBUKNVGI61wYp3/BjWXoMEgBzwXyX7
 64mK9oVFZA2cA1MouxIsv2J2EDFq9jpUZfKNlt1rh4DStLMFHVwnWM4Mk7c2qPRdLIuG9L5d2qy
 ubdDiKogTsNpzqGEGVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258838-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6568141A41
X-Rspamd-Action: no action

When qrtr is loaded as module, QRTR NS runs from SELinux kmod_t
domain. On targets using upstream SELinux policies, this domain
does not receive CAP_NET_ADMIN, which prevents it from binding
control port even though QRTR NS is a trusted system component.

Granting kmod_t the CAP_NET_ADMIN capability in policy is possible,
but not desirable, as kmod_t is not expected to perform networking
operations and widening its capability set is discouraged.

To address this in a contained way within qrtr, extend the control
port permission check to allow binding when either:

  - the process has CAP_NET_ADMIN, or
  - the process belongs to GLOBAL_ROOT_GID (root-equivalent tasks)

This permits QRTR NS to successfully bind its control port in
kmod_t restricted environments without broadening SELinux capability
assignments.

Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
Changes in v2:
- Replaced "qrtr-ns" with "QRTR NS" in the commit message to avoid
  confusion with the deprecated userspace qrtr-ns tool and the NS
  implementation inside the QRTR driver.
- Link to v1: https://lore.kernel.org/r/20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com
---
 net/qrtr/af_qrtr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index dab839f61ee93b876021d904ae6b8dca8ed43745..b0e252c16f156c05973988fbdf317a149ad9840d 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -8,6 +8,7 @@
 #include <linux/qrtr.h>
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/spinlock.h>
+#include <linux/uidgid.h>
 #include <linux/wait.h>
 
 #include <net/sock.h>
@@ -738,7 +739,8 @@ static int qrtr_port_assign(struct qrtr_sock *ipc, int *port)
 	if (!*port) {
 		rc = xa_alloc(&qrtr_ports, port, ipc, QRTR_EPH_PORT_RANGE,
 				GFP_KERNEL);
-	} else if (*port < QRTR_MIN_EPH_SOCKET && !capable(CAP_NET_ADMIN)) {
+	} else if (*port < QRTR_MIN_EPH_SOCKET && !(capable(CAP_NET_ADMIN) ||
+						   in_egroup_p(GLOBAL_ROOT_GID))) {
 		rc = -EACCES;
 	} else if (*port == QRTR_PORT_CTRL) {
 		rc = xa_insert(&qrtr_ports, 0, ipc, GFP_KERNEL);

---
base-commit: 0f2acd3148e0ef42bdacbd477f90e8533f96b2ac
change-id: 20260205-qrtr-control-port-access-permission-bfea19994a58

Best regards,
-- 
Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>


