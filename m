Return-Path: <netdev+bounces-271496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAYdN6K+w2kRtwQAu9opvQ
	(envelope-from <netdev+bounces-271496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:53:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFF32358A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE875314E52C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9543BED55;
	Wed, 25 Mar 2026 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaUEpGDP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J7QHEEMN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90820394794
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435488; cv=none; b=Bp+9+tGy7LeDzfz+xM45/Baw20zo81/tILyD0V7+7yShoo9oca1+3uzzl7eersbeHNgjF1nQt1l2VniTlW/gtVUA5gnusSqLMpiAfP6x26277a2Ke6YIJRMVLEWIOfDpYrokuByB4lY7FynXRF6Wl/4DJPHmMCFUtEmUUD7QIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435488; c=relaxed/simple;
	bh=VUckc1SdCNWURMt3QHIG/kYLSzYqTmALMFLTy9j3q9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Afq+OnadIOMlhKb5sDABf6wSH/uQcA1pp5XluFjn2rMeVOGNbC5Hwq37nnoJxfWE/HBAUMFnXvPsiFIoyooOOOeJvt44w4IfHGjQdUU2ls5+qMgW9Nu+Pv3MoLQq1dOHYyIyOfAQyPfbjyAKayWy3Mhc+JF8vnKoW4DeXBo3iKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaUEpGDP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J7QHEEMN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PA4DeP2931313
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ufmukem2JRe
	bh6l819czpXtmpvPfo+OtOsxaUsB7OdE=; b=SaUEpGDPQpb8ngfVjbGra2zTUk5
	FfKp4nIbTqWqPuh0ffH84bPugQq6YfCIMZSDK7cXxXYDZjH+4wFrUC9JlaCC5MAA
	04fQwRe3VaTJP0h4jhkG7cja0P5Of7SAuxlbxz0FDlCCgD0wFXzwrFPNqSuF99hf
	25U+j77Uszvhp0u9l9aGIZBG8Wwu+F4yA24P4h63N6NL7hcsLlLATQ0Lpuu3YZwd
	+SD+fHTtes2YVuiHPK3z/NxV3YtxEkbKQFO5WblaycEu8dzR7Cgmxn02cw8VrhGc
	Pt3O3ijGQVbNE3MUndZx/oAFqTrXmgCXIz2QetvgSOmtvdITX0CO1Njx51w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dmpr58t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:44:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358e425c261so8252513a91.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774435486; x=1775040286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufmukem2JRebh6l819czpXtmpvPfo+OtOsxaUsB7OdE=;
        b=J7QHEEMNmD8fI+e1elAZVwOn75WdQ7WmhTb5sUgfKyplH3dbGDdLe/yutxhBxyQXZP
         Rp8j3PVUNqNVSkHsZwYJsx3rH+5a9eTLsQ/V804LUlKMD2mz3KA5Iz4Mr9Z6S3bLrmMQ
         3haH5xtey9w3cXR+6LR0vgjIhkyLVjE8DmalUJ96ygxEhze1YcyigknvrhXVWkPQWXFA
         bxyBcJqc4ow4yhl+6MqwqQuorqCZIzSv21G2xo6bhQjJUbLY5jlAWMRCTkAMRzGiKj5Z
         8V35ghqfJWLwwXnTnYnV0qX+0Tc2sdV06it04AgWmggmnMBB2H1Nc5WznOmO2NaTl7ji
         QHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774435486; x=1775040286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ufmukem2JRebh6l819czpXtmpvPfo+OtOsxaUsB7OdE=;
        b=sMdOQb8zUVD3cBq/LAWKv8bxlQHlpulLEOChlbFvB8e1IC1Irvn5KNdOJBrBz5k80g
         QTcXGnHhTJoEeJGV1Pj1fcAQbyCHdnrV8cEdQ9Huo22Ei6YSyLFBlf/AlT3lhNkzE99G
         pD2CM4GhCnFO/JR+DTIspQFewMwVZcpToc8XmJIppAQWBvfVcVGFOwYJrN6HSXmXAz0A
         leOvRCKUam+ea0YcX7J7GDM8cs/1XfK/r+oc/sJA+ZkDyLuGtsZqhVgJUWsmRn0m2zUH
         shX8WYg9PV0FL+HDFi1/U/KJMaBWrLJR88CufLh4eMSWA4s6+pwo5BK73J7pX+AaCYw/
         pNjg==
X-Forwarded-Encrypted: i=1; AJvYcCWWTtaVYDfgUAWnIRwM5X29DhZmMZEDYwYHqPhvYveDaiEXgI7c8iqHefGmCf6iXIZ3VbPuPIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMS93TmKeoOvNYKrlYegPw9Zr7qmgcg7u6RAimoA6wWfQFCtJ
	/3gqxqD5o+EFLDrovQIrr3dhFtHO4/Ni3tW5Xp9FDPC701/Gxn7KQvr9xF1Jb+ul3RGSMWI3IIM
	Ap4/oGZ6PwONwYnryKcUXEOUeB+Jh0hjul8no+gtaiDMOjOhWtDIV+dxOqP8=
X-Gm-Gg: ATEYQzyzlGYGFIPbE6MoaEiSv523vJ0+1vJgzlI11w+izTnXDyXl6ou95hiZVnLRKBw
	MrOX9PpFWKqTke3r52qn/BDn66+4QZicqwLDZIr42/RyRGG/7XuFu6yTw2UOVvGEMXqA9n54SQB
	YbemKHWzvRxuhKcl7SalJLbVi411jT9p/3QtJVHPeZcWVqAKXCJoDsFP8shHXdSm2a5mi3DLi6h
	wso5vc1ci+iGZk5nN/yfAByshMhANlZZdS9LR5NtAGl0io2Lu608+nnyDYD18o/C/6zLq0U8Ilw
	+Pk5rYpi1BdNjSmtg7O+Acq889+CmM+nrhmHO7ui74GnOsIArTtfWEj6B3oXLUfpqo6kbFHalDV
	XUnWVyPqfssCmnHgXiRuYaqubZ+LOlGUK4cvA
X-Received: by 2002:a05:6a20:3d1c:b0:39b:c686:6306 with SMTP id adf61e73a8af0-39c4ace66aemr2930372637.30.1774435486256;
        Wed, 25 Mar 2026 03:44:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:39b:c686:6306 with SMTP id adf61e73a8af0-39c4ace66aemr2930342637.30.1774435485700;
        Wed, 25 Mar 2026 03:44:45 -0700 (PDT)
Received: from work ([120.60.74.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c6besm17867251b3a.32.2026.03.25.03.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:44:45 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        yimingqian591@gmail.com, chris.lew@oss.qualcomm.com, mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] net: qrtr: ns: Limit the maximum lookups per socket
Date: Wed, 25 Mar 2026 16:14:15 +0530
Message-ID: <20260325104415.104972-3-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325104415.104972-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260325104415.104972-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3NiBTYWx0ZWRfX0sVrxF7Mv7/n
 vR48Jgy7lzLBEazlMwkh4+7Dakiyy6sZBwYMrV+chdIiK0v8NoLYDuA1NyFRTYocCG2bj6fiX7g
 iHnUu3oKF+dwt7W6reL9ry2UdtjbtBFFh8MemWGFINIM3bE6Lyg+xQNxUSX9/uqJtNeVkOOezz5
 CdgqyVWN9wAY/UZFCyk+Tz0qA98JQCK9ZqgGIp9IcpttQuBGKt7BSYPmM2uknZzc6UuehlOI5uk
 vpc84HV8SpmebO3IqgtbX1huX7C9clAakEW6k7aI3ZXsLTFmTTXwG0yq43xrU41A0DhTCN+cuw7
 oEiw7JOzOlV90vUQDX3iPsyeSLRVYcpcbZJuUIkx+THlKKfr1RIjDFXBC6QD2BH9udLRu70WuGk
 G0adzGC0xKMu2iiVNInlQ+11sjeH7Wj4VcUT40CUNkZDJP3ii3ZfxWlvebQck9k1A+RuCVE9ibV
 GLFv+Tu9kkynHIHzH+A==
X-Proofpoint-GUID: WAqmIeiR4g8sPrVN8ICkwRX6qXDQUhPC
X-Proofpoint-ORIG-GUID: WAqmIeiR4g8sPrVN8ICkwRX6qXDQUhPC
X-Authority-Analysis: v=2.4 cv=O7w0fR9W c=1 sm=1 tr=0 ts=69c3bc9e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=DfnuZq+CPLWApegUcJV09w==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=X_qntSa0dJ9H4pJGHfIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250076
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-271496-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7ECFF32358A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Current code does no bound checking on the number of lookups a client can
perform per socket. Though the code restricts the lookups to local clients,
there is still a possibility of a malicious local client sending a flood of
NEW_LOOKUP messages over the same socket.

Fix this issue by limiting the maximum number of lookups to 64 per socket.
Note that, limit of 64 is chosen based on the current platform
requirements. If requirement changes in the future, this limit can be
increased.

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 net/qrtr/ns.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index fb4e8a2d370d..707fde809939 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -70,10 +70,11 @@ struct qrtr_node {
 	u32 server_count;
 };
 
-/* Max server limit is chosen based on the current platform requirements. If the
- * requirement changes in the future, this value can be increased.
+/* Max server, lookup limits are chosen based on the current platform requirements.
+ * If the requirement changes in the future, these values can be increased.
  */
 #define QRTR_NS_MAX_SERVERS 256
+#define QRTR_NS_MAX_LOOKUPS 64
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {
@@ -545,11 +546,24 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	struct qrtr_node *node;
 	unsigned long node_idx;
 	unsigned long srv_idx;
+	u8 count = 0;
 
 	/* Accept only local observers */
 	if (from->sq_node != qrtr_ns.local_node)
 		return -EINVAL;
 
+	/* Make sure the client performs only maximum allowed lookups */
+	list_for_each_entry(lookup, &qrtr_ns.lookups, li) {
+		if (lookup->sq.sq_node == from->sq_node &&
+		    lookup->sq.sq_port == from->sq_port)
+			count++;
+	}
+
+	if (count >= QRTR_NS_MAX_LOOKUPS) {
+		pr_err_ratelimited("QRTR client node exceeds max lookup limit!\n");
+		return -ENOSPC;
+	}
+
 	lookup = kzalloc_obj(*lookup);
 	if (!lookup)
 		return -ENOMEM;
-- 
2.51.0


