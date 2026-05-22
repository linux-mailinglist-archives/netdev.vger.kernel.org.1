Return-Path: <netdev+bounces-290755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PAKJTkqEGpQUQYAu9opvQ
	(envelope-from <netdev+bounces-290755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:04:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC555B1A4A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A139130640B4
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05733AFAE3;
	Fri, 22 May 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqjpioQF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WMosYht3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB42E7623
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444077; cv=none; b=fiHoCkYMXVlN6vl3091isMbrGc9uG1Su7Eyol5bRKGHJBDmMxdXUSjN2qTgY6X/JGmHNX35Y1TvwdQudJzk6uNW+Dz22rB88NPw3j4eKV5W49869FuTKo3zSDkFU1ArE64AavcVwuF8lRTTuxBVj0VjXKAg/vehfLWi49/bv5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444077; c=relaxed/simple;
	bh=y3Md+/LJdRoPfa8fSBTst//7iA3QrqSh3tsJRClRwKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMgjTbGfEd+oBizhGYGI22CXuIGS9v/H/xMwzRY/An9BsbXw80Ii3iYaDGHxwdpSOCExgGXEHclhHZTPiRVObAvBpoUKShjg6NNYBU/mab8KBVBQ3pozeLBEi8Q8NI2BAym9J7yhR6c/TgoTf+M4/zeUVcS93vfB1R3tXZG5eDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqjpioQF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WMosYht3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8d9K63673893
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=; b=jqjpioQFFAri1m2v
	HbJL84xCVFhlIq0d2UiQ47xNCEwDEpYfl4QL2066E9UNWXygtvKtJX6KVopUig/B
	DNCs1cdIbKI7+ComLVYO15cK90mYoNtvznOcMR7Pw8RmqruWrK/FwqkO21zVgCBK
	BGtMJPVA+o5ViB3j7kd4mCSt1nju/CF1aR0HxDv8B2oJFbuE0NkFGMdP0EDG41PL
	2EARo6n8CCNkcRm9atfIEi0uo7M3xl0W6uCWvjaXHbMUrrZvkd43nV+sABOxFnxR
	QFVHmfwgpIAYWljVCxKScvyUUXS3b4Wc3qsYtvf0yKf+zVnB4cPFQ+LMUzoQGMTs
	inJCFg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea4dc46yt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:01:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso3272778a12.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444075; x=1780048875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=;
        b=WMosYht3MVMArPKL0lwi1xACPiyEN2Ockb3Yf2/a/yzCha+jqneKvO1Tfsx8pYHWjE
         PvCO+WHPT5p3cwPbfeN8MvemJBKQFrfYkQaaIARbL586NayjWQ2sGct1tcR+Q9e2BnSr
         3XIwKvInmRRBqelq74pEvIOPtZrFdUnR3PNaSWjB7r2J0Pel3rN4lyxxPeXDia4Z1sgQ
         i74eg3J2DYQmvBKDzpmbpJK1OE8dUB5hX2yqK6WkCyqqZnwOr/yIAxQv+lP+VA75agyw
         Pxja88xcWsUXsPPHeqhSSP+fOqXhMqNkx/9gyqVxHbtSvRJCXoQPbZ0OZ87vVCZCv06A
         8YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444075; x=1780048875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=;
        b=lqyPhZE3Istd/JcBDEV6Q1Ki+1r1iMZRAOnJeoKWRKZBMlpvfS1IOjIerEyuN0486w
         4zCABakigAq7G86EeDoUoz6LrjL34dFF/0gaK2HSgc0vSsMkm+R3l0/G+vI77a06nZ3B
         Gg8Can6VDBFEZMf1c8t0CWHnKRUDWcZm17HTnzZO4jgaT2Q/yqWvVZKvYFQrwbEgNyBV
         nkq+m5wXR2AWA6olAfE4ZU/1y07qvJFxFiKqZyUu0NfyOpnxuVZOBDVcnsLRsQR6nSoO
         +77imbeFeoFebmTPSLDGZ50YTlnSa0xPr85TpKqCFBDBgDjockH/AH+BKrDek3pmy5in
         1WAg==
X-Forwarded-Encrypted: i=1; AFNElJ/jAt079Rhq9AUrodajzyK5W/QcgKPEQbQwp3FrrllycLTxxef2O5k+x39OlJ9tmuzSW+EWscI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvNBmTxrNNT6yAAyB6fFA3mkOyy2riy1sTr/PuhHmYQNBMCPu
	Az/FOIEo4CX9DCPpv5kPYKvCeJT4yZRWeOFEc3lzCir9/qhwApdzQV7AjlumoyAXbTyU56CxKpQ
	2S3nmogJMLIse96Dt2QQIZmSOQUPaAIwEtbXEQ7jZvr3pxMXGyvU4yUMzI1o=
X-Gm-Gg: Acq92OGYvV7JWakIZe2nidZqdx2P3EcLd1t9p1CTq1FfPVZ4ZaDYs4maoHZ7B4/JatC
	DhlojQ6ZY6YqBry3VKRucXWhWNqscSSaBdNoYVtQysjJaNnW7ZXlEeTA2gqhvkZoE74+MyyOLKs
	dLshde2ZJmWFR/wA9O0JFyHFOvuypEpdKC8v+Hi2byAydH0/THjXKE0w+PEeGobmUeiNbRTOXnT
	BePR+LgLNThy21mkBdvFGew9zTlXbiuC4ZCrETWtTgNP5IcnoHBRCqWZMFGsPCMba9GS28V0MxM
	UCK0iRdd/CObG+nkbVLqDndh4sR5RkvvWIUjWfReSjsw/rIjEmaXMXnhtD3tD3Cm5SB83sBNucY
	Vl5atK7DfrgJqAAnR2U+0dMxlAo8S2i7mfGiiBdKy/JLj+Amnm5WBNey6
X-Received: by 2002:a05:6a00:1807:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-8415f330494mr3326892b3a.25.1779444074807;
        Fri, 22 May 2026 03:01:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:1807:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-8415f330494mr3326808b3a.25.1779444074141;
        Fri, 22 May 2026 03:01:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:01:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:34 +0530
Subject: [PATCH v2 3/6] net: mhi_net: Hold runtime PM during active data
 path operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=4173;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=y3Md+/LJdRoPfa8fSBTst//7iA3QrqSh3tsJRClRwKA=;
 b=s+sHbgZoUcbrkhk1NuhJt9uKCZYJuw6T6gtb1ZC0H9M7hSgDCA1Etn58jrZgjHnvT0SCRG62Q
 V7oqxMJp/lHBjYl/lZQf2obhPMwRXspe8hoAXlE3MFihEsy0yCkGb4V
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a10296b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-cKO2LIWXEwUer3o84gA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: qdNkiZNOL0GC5GSn6n-JaTFVHHUlUUJS
X-Proofpoint-ORIG-GUID: qdNkiZNOL0GC5GSn6n-JaTFVHHUlUUJS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfXz2yD/3ZFokNm
 OO23hrCB87boqrAv56N3U4EtXYheSVXZ5IjPtVEd0Iff/bOHJq3LEAiJ8i2C77nx0IWeJg2Ivvs
 lGkylyeHunKJIJXu+xN/jIxKP6pU0O8OIY9971BXk0B7cBtJwK5XET+fi8/tw63Zu7il7Oh4k7k
 9ZiqYkfEV2zFoihijw57RNkJGZQqBeNrowhX6sufXRy5aYTVlDjKk9gzn4PB1mYo8wNQt2CYkcM
 o5mlaTj5ezgRQ5f97yDTmwi5+MqhFMSPjK05KjK8jIxByfQVkxHKl5DCRvpeaRhnn3xn+X2tkn+
 y0342oT/IxxRzzPY/nG4TxBY/KpizilTeYfbzFfz6xG+XgH09MGRGULo5KMTuCy5UcpGdm5lfZ7
 AeW/qOVMml90OolikP3pikaIlHwkpnA+WqfphZEfOKzVmXBtZa2cx2WtSJ76if33lEl+E0YrvkW
 RzCZc9pzfZTSU0M6VGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290755-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2BC555B1A4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mhi_net driver does not coordinate with runtime PM, which allows the
underlying MHI controller to be runtime-suspended while transmit, receive,
or RX buffer refill operations are in progress. This can lead to stalled
transfers or failed queueing once runtime PM is enabled in the MHI core.

Add runtime PM reference counting to the mhi_net data path to keep the
controller active for the duration of TX, RX, and buffer management
operations. Enable runtime PM during probe and take/release references
explicitly around these critical paths.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8..5d7f9ccdb17b 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 
@@ -76,11 +77,19 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct mhi_device *mdev = mhi_netdev->mdev;
 	int err;
 
+	err = pm_runtime_get(&mdev->dev);
+	if (err < 0 && err != -EINPROGRESS) {
+		dev_err(&mdev->dev, "pm_runtime_get failed %d\n", err);
+		pm_runtime_put_noidle(&mdev->dev);
+		goto exit_drop;
+	}
+
 	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
 	if (unlikely(err)) {
 		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
 				    ndev->name, err);
 		dev_kfree_skb_any(skb);
+		pm_runtime_put(&mdev->dev);
 		goto exit_drop;
 	}
 
@@ -251,6 +260,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
 		/* MHI layer stopping/resetting the UL channel */
 		if (mhi_res->transaction_status == -ENOTCONN) {
 			u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
+			pm_runtime_put(&mdev->dev);
 			return;
 		}
 
@@ -261,6 +271,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
 	}
 	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
 
+	pm_runtime_put(&mdev->dev);
 	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
 		netif_wake_queue(ndev);
 }
@@ -277,6 +288,12 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 
 	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
 
+	err = pm_runtime_resume_and_get(&mdev->dev);
+	if (err) {
+		dev_err(&mdev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		return;
+	}
+
 	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
 		skb = netdev_alloc_skb(ndev, size);
 		if (unlikely(!skb))
@@ -296,6 +313,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		cond_resched();
 	}
 
+	pm_runtime_put(&mdev->dev);
 	/* If we're still starved of rx buffers, reschedule later */
 	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
@@ -362,20 +380,41 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	err = devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		return err;
+	}
+
 	err = mhi_net_newlink(mhi_dev, ndev);
 	if (err) {
 		free_netdev(ndev);
+		pm_runtime_put(&mhi_dev->dev);
 		return err;
 	}
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 }
 
 static void mhi_net_remove(struct mhi_device *mhi_dev)
 {
 	struct mhi_net_dev *mhi_netdev = dev_get_drvdata(&mhi_dev->dev);
+	int err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err)
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
 
 	mhi_net_dellink(mhi_dev, mhi_netdev->ndev);
+
+	if (!err)
+		pm_runtime_put(&mhi_dev->dev);
 }
 
 static const struct mhi_device_info mhi_hwip0 = {

-- 
2.34.1


