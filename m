Return-Path: <netdev+bounces-289262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOV4LrbcC2ryPQUAu9opvQ
	(envelope-from <netdev+bounces-289262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61666576F99
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2218A3050277
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC82D0605;
	Tue, 19 May 2026 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyNbka0z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d7Jfq7zY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE22D7D47
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162125; cv=none; b=MHBoycO+A0vcCtbIMp+Cbr7O8qoSc7AEf4y47NbI1DYtJjy5LrqyzxCQs+2X6V6KBKTzkfOwaYYr3oObnVS6myhG5A394zobbvpsXMD+E0OhCcp6T1BCqAq0T/oyvWKIhuR5trUsmUAC1Ns1wTMyJWROIIj1UkcrxHc1kWhWdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162125; c=relaxed/simple;
	bh=MOv2tn2x1NuXg0Y6xnRSgPmwSeSv7r7VCbbKpMClqFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHkDoHbptbksJ9lS+ZWxU8ocsK93M6RQAUx+bp6oFkIXx8QmNp0by0Q1nol94IIpLwf1kOVnObWu4+DrtC/Mmp10NEFVoV54aZANb6USNE0w0DA7lGC6IddgCXVsKAnUTXLiGHHHetXRX7rmx+QN9YTWq8sRXdkZFLOVBG3k53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TyNbka0z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d7Jfq7zY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IJHVeC1890528
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zBNwpNDZIot
	kEtr/5J7Vifxmg8mJxXJV17KSCpHHGAs=; b=TyNbka0zIGC6oC+HE8wC+PhQO7O
	A/Bg16Q7edrU1GDjfhdXHCFeuxH+zCo8RLC4p0XGbjMxjilTipZ0dTvN38KGArQL
	7QyuJAXSmmxriBY8O1nLoPHoL67HZTjHRGZanvTSGY8I5dhoXW4jRudj75TsEo7i
	eW/qwFY0gKtfE/4xXZdyRMnWzgqaQPLKA70sUJ7F/bNbNnLulmFz+km4NWklWhvc
	jsl68ZdH0BZKBVCmrcPJskqq84/QTmkwzaZ1+awbzXusjbpFKdEKytM01pjbdI9O
	EgTL4rSCnJhq6OeqUiGUjc8YXRvScFYu9P31p1pMX+ogOfSQJySD3id4rzg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82pw301m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:42:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2fdc19ce995so2209282eec.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779162122; x=1779766922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBNwpNDZIotkEtr/5J7Vifxmg8mJxXJV17KSCpHHGAs=;
        b=d7Jfq7zYzf2h8qgo30ouJG6oSVmvWnQnecTzA4tZe43EzPfVEym/hkQ8dAY68WORhq
         WHqQKbf+nsX0eETkv1dQJC6qICp7QhYDIBGEdKNwf48E6ExA4JdwD6CDkcBaQOPxT4uj
         Czl8k7rqmJ60c4Ixn1SfifGHxByYDappAfwb8yZAmjIz3FVjdmmKEMw5ddUR4K52fQm9
         EJMqK4haDHOurccsl8SJY9BDm9qoiJ4LtfP6Vx5ZCdJmE6u4c4PrcfWm8PcHgvEW6iSI
         0+SBnLU7tpOPXW46SpwRxz3Q4TT45xrNlLNHKK9YqMg0csE8utfihGl86zYUuyJj6Vp6
         Bvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779162122; x=1779766922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBNwpNDZIotkEtr/5J7Vifxmg8mJxXJV17KSCpHHGAs=;
        b=krZTVgfx2CISSVY/UAxvKhpw0NdO5B2iD0MeDOuLLaa2Lt99QtRZDeBIGkZjlwYrKI
         /RvsOe+Zvcll43ldyn3Btnw+EPYtqtfKwRGOht7PD1fiPxhMyJutRL/CK0ip1j3cNzck
         q2YkXJRR/a1K1RHVwZCm7qMEAoh9qtSSETyl/o1nbLbCoFI4df9KiPEfvDyTbCZ/vDKV
         Ohh7odmmwdG2WNpXpgQCrP8ljiMG7BZR9Fo+3nDfDiI9If4+w9fVINKtx2tpl81ZMqvK
         9XxtAqOig24FoFnWxKOu6GjNoLWeHKL9l2K3KWaOgZomK8CW1TxKJX5xsueejkDYmP3c
         C/JA==
X-Gm-Message-State: AOJu0YxaM9WH2PU9+28bmDj1GHtXgs0tsnYHj7fvaBDyEYxfYIsKYGka
	8cW5B4TPTls8X+UIs2D7F6TWr3LQ+4WoD6MNAQmojwHxwY8cVfkm9CP5iI103yPbgPba/cG+4fT
	0ABW6P9tBmVmS7NNDcgZD5AeiyMH6wMs5rO41v4GAkQPBS/cZv/E3pe0vtCnOV43St0E=
X-Gm-Gg: Acq92OGhA4YhP5DneS6f8+yTvIguy2as4x2pFFeCyrY+W5i+eLASRHE863fMlKgclcE
	2R0caI5sG9onrn2p4Ygj2EGFa3Ghhe/mvBr8x5w5IvQ5RdAxSeQzpwdlUowhJY5qC2I0OAlsrLv
	hTna59eNFx3yJ17iuoCsTusqpI6aEItzRHjlx1saj3UTGaHUpXkaFticgSdT+Mr+0ryRa3pv483
	dtEwfnFJgebtgMPceAhNXQqWAtaDihc2CScyCMZdQWdAhg7F0KB8i14oDqXsRZzkE1paS6NYdU7
	kb4kDvsJxnrqMtGM0RxRrWTKEJnC5MjVOcyx/yHwYEzlQi/g9UnNGaAXFPkFqD7QmsxT7jNy/gF
	H456CKARTPaIaVhlYP+7epZ4+Ebv7b/3/5DB5G90rr8ILPvbGrvQ7z94E0HEVa9ysoswFF9bnVS
	CLGt6Oy4rpXg==
X-Received: by 2002:a05:7022:f8c:b0:12c:aae:7b43 with SMTP id a92af1059eb24-134c8d4f504mr9078745c88.24.1779162122338;
        Mon, 18 May 2026 20:42:02 -0700 (PDT)
X-Received: by 2002:a05:7022:f8c:b0:12c:aae:7b43 with SMTP id a92af1059eb24-134c8d4f504mr9078732c88.24.1779162121742;
        Mon, 18 May 2026 20:42:01 -0700 (PDT)
Received: from WOSSA.na.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm23423345c88.9.2026.05.18.20.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 20:42:01 -0700 (PDT)
From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
        jiri@resnulli.us, yimingqian591@gmail.com, keenanat2000@gmail.com,
        2045gemini@gmail.com, rollkingzzc@gmail.com,
        Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: [PATCH net] net/sched: fix pedit partial COW leading to page cache corruption
Date: Mon, 18 May 2026 20:39:50 -0700
Message-ID: <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a6AAM0SF c=1 sm=1 tr=0 ts=6a0bdc0b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=A7XncKjpAAAA:8 a=pxxjg2x1fI-G0sRxPlwA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=R9rPLQDAdC6-Ub70kJmZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAzMiBTYWx0ZWRfX/cv/76rC0M+y
 qjE91KIgiQGWpSHrNBLuuvVuRsmLj8CsKIi68jni7vkW0pX4VHTY1RWlZUCPMw9Pm05navOyQ5x
 DgJU6zA7e1nvbRsEHZ5lQu4of8krU9PE20U6KpzBuYyuHI76R21IxVIjCZ4VreQYqH12JttpmxI
 Ep6DN6xdbxFbOC6IOkw3QVwGIwn7HCWqIC9gSWLIv5QPBjjKuxblEijwQJszAIvH59gesy/NAQ4
 A4m0AcWdz5ddIaWYHX1TpJ7e6uH+wtuSEMilDCYjIBwV8NW4E0sJiuRLS+caWElbTR+lnqIMECw
 kEjOwja8535IMQ81BGYsJuIs6d6bKOaduoK5E+qC9MNM9cYfZdeiFPAydP89mlhU0ldBD2sfTvu
 TbnGxgH70Vw/9Od2lxyZuzqGBr2DOHqpyl/M2kynzcgwkyNTI/jAg3bC1Z86I/9kcKKUH8TUg71
 9470krWtIaBGd1oC/UQ==
X-Proofpoint-GUID: LOczw0Byu29pJ951oGtNhikwVZQwy1ty
X-Proofpoint-ORIG-GUID: LOczw0Byu29pJ951oGtNhikwVZQwy1ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190032
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,gmail.com,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289262-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rajat.gupta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mojatatu.com:email,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 61666576F99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcf_pedit_act() computes the COW range for skb_ensure_writable()
once before the key loop using tcfp_off_max_hint, but the hint does
not account for the runtime header offset added by typed keys. This
can leave part of the write region un-COW'd.

Fix by moving skb_ensure_writable() inside the per-key loop where
the actual write offset is known, and add overflow checking on the
offset arithmetic. For negative offsets (e.g. Ethernet header edits
at ingress), use skb_cow() to COW the headroom instead. Guard
offset_valid() against INT_MIN, where negation is undefined.

Additionally, linearize skbs with shared frags upfront to prevent
silent data corruption when pedit operates on zero-copy pages
(e.g. from sendfile).

Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Reported-by: Han Guidong <2045gemini@gmail.com>
Reported-by: Zhang Cen <rollkingzzc@gmail.com>
Tested-by: Han Guidong <2045gemini@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
---
 net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2..79921b8d8 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -16,6 +16,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	if (offset > 0 && offset > skb->len)
 		return false;
 
-	if  (offset < 0 && -offset > skb_headroom(skb))
-		return false;
+	if (offset < 0) {
+		if (offset == INT_MIN || -offset > skb_headroom(skb))
+			return false;
+	}
 
 	return true;
 }
@@ -393,17 +396,21 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
 	struct tc_pedit_key *tkey;
-	u32 max_offset;
 	int i;
 
 	parms = rcu_dereference_bh(p->parms);
 
-	max_offset = (skb_transport_header_was_set(skb) ?
-		      skb_transport_offset(skb) :
-		      skb_network_offset(skb)) +
-		     parms->tcfp_off_max_hint;
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
-		goto done;
+	/*
+	 * If the skb has shared frags the user is likely using zero-copy
+	 * (e.g. sendfile).  Those page frags may point to page-cache pages;
+	 * writing into them would silently corrupt the page cache.
+	 * Linearize so pedit operates on a private copy.
+	 * TL;DR: if you want zero-copy, don't use pedit.
+	 */
+	if (skb_has_shared_frag(skb)) {
+		if (__skb_linearize(skb))
+			goto bad;
+	}
 
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
@@ -412,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int write_offset, write_len;
 		int offset = tkey->off;
 		int hoffset = 0;
 		u32 *ptr, hdata;
@@ -451,12 +459,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		if (unlikely(check_add_overflow(hoffset, offset,
+						&write_offset))) {
+			pr_info_ratelimited("tc action pedit offset overflow\n");
+			goto bad;
+		}
+
+		if (!offset_valid(skb, write_offset)) {
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
+					    write_offset);
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
+		if (write_offset < 0) {
+			if (skb_cow(skb, -write_offset))
+				goto bad;
+		} else {
+			if (unlikely(check_add_overflow(write_offset,
+							(int)sizeof(hdata),
+							&write_len)))
+				goto bad;
+			if (skb_ensure_writable(skb, min_t(int, skb->len,
+							   write_len)))
+				goto bad;
+		}
+
+		ptr = skb_header_pointer(skb, write_offset,
 					 sizeof(hdata), &hdata);
 		if (!ptr)
 			goto bad;
@@ -475,7 +503,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 
 		*ptr = ((*ptr & tkey->mask) ^ val);
 		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
+			skb_store_bits(skb, write_offset, ptr, sizeof(hdata));
 	}
 
 	goto done;
-- 
2.51.2.windows.1


