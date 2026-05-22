Return-Path: <netdev+bounces-290752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hl/CGUpEGpQUQYAu9opvQ
	(envelope-from <netdev+bounces-290752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:01:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8C5B1943
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8116F3011C56
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD193C5528;
	Fri, 22 May 2026 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/ENIXqk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aaTYag30"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22734E760
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444052; cv=none; b=OKTk+P/Ri8AGLNZy1/Ef3tjMGoZt4/0TniDbRyBZ7buXwolCKIf/DjK+8RevVq/7DmrFrQQ/dsy1yU4afTzK791MKWxZlRfQ0TG0JGJmJOR/o3FcPjISurK1UOAsO5KVmP25SAUmbxoKuG9w+sHa7bF1L2EUL9njSG0LVGdbE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444052; c=relaxed/simple;
	bh=+1xqvOBtTjhR467f4KD24eV71y2gTMox1bK7uo2F8/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZLnSUrykPz6KXUIpM07sEAMGlkprTRzcVleExD6R1jm3Dkf8a8kaw5V9KwZKXAc7/IE02bnwUmTK/QuDHFOZYfqnDxSa134wFaIdeg+vg/hhU1sRAcxpClV/EFw/z0bPa/RyamoNkCxLUh7Hhdo+I6M13liFxCnEfWNLOgbkp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l/ENIXqk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aaTYag30; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7ULNh778735
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iuCxH5D+n2gNFhyOX5Y2of
	7w5Zcuoea+gH2Rlo6K2Go=; b=l/ENIXqkelqIqqwXddP6me3HQDLOS3HeQ6XeQX
	LwNoPTpsDBSv5zrl2ik0fG6gITJ4e+6ClFp+6iaJWWX4u6U4ii/68Z2rW9B7WZ22
	DFV/3IE1SXnSCUPZr3wiPDyH6bTDoVwEP7BjuW9mvpDpX8eLVcQ0ea/75QxDWDyn
	y19PwfJPx3RnVZvQxlxqFVCmDKC8VyrwzrytSsASaY+XKk7VtX8m6VjM1/lLT9rp
	c0pRLs7bh7cboj4U11RSyJOAIzkKgsD+x5KmXnN3deEvJkr7+5ZiNC8/L+R/nLlZ
	Uksb8TOeK7tqFoBFRRjmEs6rgmX5aNIiu3Jo+2/oKV+ddFbg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7at5qw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:00:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so11011349b3a.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444049; x=1780048849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iuCxH5D+n2gNFhyOX5Y2of7w5Zcuoea+gH2Rlo6K2Go=;
        b=aaTYag30dPYuIpl2NOyGZLGtjt4qJ6VWLYxRa9JF2EXU1WWrKWzZBV9oN+CX4cuh3z
         TBA675nMC52WjZcam+Yj7V6W1i6SurCR57p6xUh6AqbHAmSITcNdV/WSB0EbV9f0sKem
         r+Gt13SQh5sSO0FNZeh/VctCr8Cfr4/2et29z0B5XRv+eKhUKo9uZLiK7sCuOul2STAj
         9ImjAV/8kdF3/SfxRTQcBOuM5vnE8lOQCEzHWZ+lBets/fNqujXzK3w9pkj37bu/zfBp
         uoQ8Qs2o2k0ZSqDrGMUtNhLnt3eFStGiMhiXJt+T007t2ylL9kHb1/6SqRlf99SEXAik
         Amkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444049; x=1780048849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuCxH5D+n2gNFhyOX5Y2of7w5Zcuoea+gH2Rlo6K2Go=;
        b=B78RV2Cl0n9NZP2BezeWSjkmA9u4ugFHALHJcwxwXR9gvw3GHSmEA9XPRWJtx5uZVV
         actXm4t2rDusHjN5gPY2lLnkOJKTiz6XoAms5LqOhUHAXiM4yGZMF0qeNI4zA/Ojox37
         UsL5geD6btCjFGdVmF0v2qczoI9TNazc6X+61AGljqk1AkEIB7xvgMBolCL931TMewU7
         l8AsKuBjxe+uqGuAlWO+2fSN2v5/7pnD3n7mjB8tj99VRpduaEQo7ixIh6hpOiUEKpwM
         rOqrqE++FmMNYataTr8SdYZ8umBdgYPdK51dhhlUU3YCNk96dgVbElq+K5iAByDTAM3w
         dWjA==
X-Forwarded-Encrypted: i=1; AFNElJ9bzZXsSB+ogEhfhblINsliqgMTHRrrRNov2pRK78XK6SuwreVPI7Fd3+hVhNQisNk4GlwnHUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVW8dcN1skBIxFHzFog8FvhbacDWPye9kjKuYytbLequ9ILKUL
	jDWtqju+XoVPR6dJc9SUxuscQSs4NwefnIMfitXYLDJ8xfjA2wNVhtlEMT+PmzfEJl11sch2lDr
	c48Jd1prqAIGSLZWzb97zbOFfNvMPFCZ8pQTe4QE0zsDDwp+qvp1EArX1Qh0=
X-Gm-Gg: Acq92OEtBGvTXVGcfWZj2oZ6yWYtpLh2aHWwxkyllNOT228rYf92vufkADzXoqKj63Q
	qboXjhc4fuOovnCX7TZykodii9DUndNtjCUx1kq37dQPa5IxtHHiM/J+ZW7WxbYINjc+/3TZOaM
	XmfLHFBuj0/zo8KgxDf80uA3QIFzaaCeCkiduqVBqbZTKa76sPN/2AnX3XeSc+U0ZZDFw1dkWe9
	3b8qVbVP+VCHB0a+IfD3wHnvqxjBjcHAM6mHMoIlc+rb5fTRPncj6iu0ZNOI2G9SmjQKtctmimD
	wikt6mx7h11QuADe4jSkmZmurn0tjQla1iZOyNVCw8CJyTsMdjn4192+6mlJBGjSWtt4APUmBT5
	lA+7zSPH3KEqNsAVYlzdTDvfm5mZi9ZV0GlIqxYyhxSm1nqNJKD6K8OuX
X-Received: by 2002:a05:6a00:3e01:b0:82f:1369:7268 with SMTP id d2e1a72fcca58-8415f5dcf42mr2983263b3a.30.1779444048738;
        Fri, 22 May 2026 03:00:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e01:b0:82f:1369:7268 with SMTP id d2e1a72fcca58-8415f5dcf42mr2983208b3a.30.1779444048116;
        Fri, 22 May 2026 03:00:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:00:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/6] bus: mhi: Fix broken runtime PM design
Date: Fri, 22 May 2026 15:30:31 +0530
Message-Id: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8pEGoC/13MQQ7CIBCF4as0s5YGUFJx5T1MY5BOZRKBCm2ja
 Xp3se7cTPJP8r4FMibCDKdqgYQzZYqhhNxVYJ0Jd2TUlQbJpRJCHpl3dE1TGMnj4FnfGOyUtFa
 pBspmSNjTa/MubWlHeYzpvfGz+H5/kuTiT5oF46w3N33Ya21No84x5/o5mYeN3tflQLuu6wcpq
 3SisQAAAA==
X-Change-ID: 20251128-mhi_runtimepm-f7aed52cc557
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=3236;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=+1xqvOBtTjhR467f4KD24eV71y2gTMox1bK7uo2F8/c=;
 b=iacSYbanGsCgJO+FPf6WYlX9gd+HwgLu3fqlbeWGrFLEf8k83HR9i9JLXwUGXl1VNyUq9NpK0
 IN5Dw8Qus9yCJf1P0rKQA7/BzSTy5rzWWcg3vO/q5CYIoLB3Wz41hRb
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: xCOMaSkiwTcS3GQ34HLJXU1LOLdhTvbO
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a102952 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KH93JrovTcJc50lypuwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: xCOMaSkiwTcS3GQ34HLJXU1LOLdhTvbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfX7cFt9JcLb8h7
 uIft/egPcErwPfyIJFKVio6VgaR/VoqWDn+B3pge3uBu3Fk+uYvABVrrZEvGQ4Cpzmfxgt4400U
 pHVnTMiApuqQUe52mWa0I2Cf1OsMCJ+U3s8YMAiyCcUcwo4a9YpnHAg6uZ+V4uUHd/6TXHl8yGr
 RlTyZ/642D65JhX0a/jd/tKm0VwKgKHVpPh/te8QufddIb2hKZqGy8Q9O0hZZMgON+LEi6ZGmN7
 Dtge9EPa8iNgO5jjfxVwR5dtclUltXUAzCYDXDgAwWjkAiUgk7ecRCpa1FzrGwsOL+Bik2jAfTJ
 vZCvv4EdPq/jqEiezQwzEJmzx6BHFdrcQceUIvAGFSJO4hiUfjALTka0vj0A3p5K7FjojgjkLlc
 v8ey7O1RibVXZ1WNXIeFQ27D/uYtmRG93aKE9S9+L0oQZCTqIHVUVb+ZinpWJM48Q2qZpDonVfO
 P/dwdmE+t2XfUyuzbeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290752-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22F8C5B1943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current MHI runtime PM design is flawed, as the MHI core attempts to
manage power references internally via mhi_queue() and related paths.
This is problematic because the controller drivers do not have the
knowledge of the client PM status due to the broken PM topology. So when
they runtime suspend the controller, the client drivers could no longer
function.

To address this, in the new design, the client drivers reports their own
runtime PM status now and the PM framework makes sure that the parent
(controller driver) and other components up in the chain remain active.
This leverages the standard parent-child PM relationship.

Since MHI creates a mhi_dev device without an associated driver, we
explicitly enable runtime PM on it and mark it with
pm_runtime_no_callbacks() to indicate the PM core that no callbacks
exist for this device. This is only needed for MHI controller, since
the controller driver uses the bus device just like PCI device.

NOTE: As we have dependecies with other subsystems, Mani can you take
these series through MHI tree if other maintainers give a ack for this
series. To all the maintainers please ack to this series after reviewing
so that Mani can take this through MHI branch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Rewrite commit messages (Bjorn Andersson)
- Remove autosuspend and use normal runtime get/put API's as there is
  already autosuspend in controller driver which waits significant time.
- Add pm_runtime_get()/get_sync() error handling.
- Add rumtime pm for wwan and qrtr.
- Link to v1: https://lore.kernel.org/r/20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com

---
Krishna Chaitanya Chundru (6):
      bus: mhi: Replace controller runtime_get/put callbacks with direct PM runtime APIs
      bus: mhi: Drop controller runtime PM callback indirection
      net: mhi_net: Hold runtime PM during active data path operations
      net: qrtr: Hold runtime PM during active data path operations
      net: wwan: Hold runtime PM during active data path operations
      bus: mhi: host: Fix runtime PM ownership between clients and controller

 drivers/accel/qaic/mhi_controller.c   | 11 -------
 drivers/bus/mhi/host/init.c           |  4 ++-
 drivers/bus/mhi/host/internal.h       |  7 ++--
 drivers/bus/mhi/host/main.c           | 21 ++----------
 drivers/bus/mhi/host/pci_generic.c    | 24 ++------------
 drivers/bus/mhi/host/pm.c             | 18 +++++------
 drivers/net/mhi_net.c                 | 39 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.c | 10 ------
 drivers/net/wireless/ath/ath12k/mhi.c | 11 -------
 drivers/net/wwan/mhi_wwan_ctrl.c      | 60 ++++++++++++++++++++++++++++++++++-
 drivers/net/wwan/mhi_wwan_mbim.c      | 44 ++++++++++++++++++++++++-
 include/linux/mhi.h                   |  4 ---
 net/qrtr/mhi.c                        | 57 +++++++++++++++++++++++++++++++--
 13 files changed, 216 insertions(+), 94 deletions(-)
---
base-commit: a293ec25d59dd96309058c70df5a4dd0f889a1e4
change-id: 20251128-mhi_runtimepm-f7aed52cc557

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


