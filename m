Return-Path: <netdev+bounces-283001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOfUHDLK82mL7AEAu9opvQ
	(envelope-from <netdev+bounces-283001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:31:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F3E4A837C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A8FE3023DC9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4513BADA6;
	Thu, 30 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKvX8KXo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407353A8FE0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584645; cv=none; b=MIoaZpqSY6PGZsF4nZO7J1UY2NPwo1cu9uVMU+mTbjBB57Vq6aRREYifSPIZav65SUH8hG+FQCbNKTjM2J4RV5C7AlHaHrnxOryeJmsnj1k65sVtCCVcfZ5m9frTwNz/Pjbpto3CepieKwv9yp65fdUlCO4KZ9PREE6MN7b9UkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584645; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qGylEdWjGXvbaLZxU9J6VYSwiFQbIdnWKWwKWeZoDM/eapuZBEjSaDbreU6B6yALYytOX98Nm1JVUGh8+ijUu9Eghx60MrnviSjh/0Aea11UA4qTemYFRPNqmvngqsAPfXkfKbXk0VL/EvxXdOdYDZGhHGI0Y03daTyEKDd44/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PKvX8KXo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UIc7811953326
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvchk8n3u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so1448452eec.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584642; x=1778189442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=PKvX8KXoYGVEMonN2qNRrOp4lZ9McwgkAApHJKA1gvS5pdVJqyANhKAWkFzGi/X/DU
         cOeMIM46UFQofg8ujMuNWY472DUzvT92UwNZYJS4rKnx3N2pVNsWAfkU7tBuzcCwuHDP
         gNRL8yxu1CqniLtBrAvp3C6KF4qrijJ4uZff9brbEpWxPs0RI17t0pFcZlRGCE7KgTNR
         foX1DhZT8ShKRXoG7haVnby4b1EcBmpHUBJ7TQEU2awk29YabQhM3181MVAsxa3Mo0sr
         qfAqtIIAI5tPiTSyM8sYJEmRh4TnhyP1gWUsGQa6pdlKMZHN7s6JlQbjqdWi/b+ysimq
         64cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584642; x=1778189442;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=d1TKWWn3eo5pP6fDNUYgwNWsv7UHkUnZOkwqkxYnriFPLkr+uJFYdFtIWRPOe5YAUC
         TgySwxv4o5OZp3p+kxQORU901xp+fThS8arAriiEVy4aPC+VJJURY6LcYBMu02lp60/y
         QtssN4M9zXwxpe6VQf57zB6DKvgMsBPnHUxoSLsr+0q1Va7ttn5cFDM1py4Y0nc8hyYI
         Ew5yzknpLw5A1G8YmbTuRe0XZzQKTI/lCNxEZ30RpUdTndQiRkrAfvUAf3RkLTc+6IY4
         ffpFULVGrwdZyXwhWrTNd3YYPWybya2/A7gOAw2A1sARt4tVqzaBN5KVq2tzd3Ttb2rK
         gv1A==
X-Forwarded-Encrypted: i=1; AFNElJ+EaE1Mb6ldM5ptoor/MS80kmgA3KDSxxVks5Clny+AeAdFOSMeoYw4ruQeMl+BEJoFXaeXWuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkeKH85AHNDpUqaw1Upd8yVUFaNuuQzBOLepvb3xaDUpdwvll
	/xEoGJojrnexEPqi+f6FpQl4rysqahxLvJd+MFICQ0zbDr5J0wEoyC9LUtQ42FLJnqKfcLXu0ae
	3K4V6/U7+y5WA9VrM+GipyrRYdikucDRDvUfjOcYNZ5eFa3j3XqMqtAS6FDg=
X-Gm-Gg: AeBDievkxfXRx2W7YSIWrLkb2tjn/4FfsQExs8TfPtQhyJD+Z7fPYZnlNyC0A+JZJ8H
	ExP3wRsvK6np5nZ1Tlgq7ub0V4dDjSBPeRLOK7eTT4oQ5Tbip8UumUoTJBeCO1kZscdBNWBU++s
	agBu5/i0xnNJDupOmlNUugHkPPEq+wFZXcRQ3SOs5v1Z2keyiP3lt4IGS94j8wxgz8sFZlm71vl
	l0OcXOFTAtZiG0J0L1H5vbpqT+dDhQaqg9i6q4wk2PanGivMIEMe+0Hcrw3n/Wx0dx49HoMLAV7
	4kkjU04iBWTxlpSV+zI3Cq0dYC9L6i6eYVdcLJbyMOlutAjVL+xt8Xa7g3WReSBDnUCXe+yThH7
	p1ygngsOHhQAsEXUdV9Nd337J3JVL596513VEEKnAJM4LZxzMPPARTJ6iritgnUA2lSkVV5rQFT
	j5PAjgXw9KWi0=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496702eec.8.1777584641135;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX1G8Y7Z7p3HyZ
 UpSToFmt0GpgsHpRQ4/hjj+bd2wWDeHe/hz3G7SUV7kEzFRoApLGTjw72sm3WNmlMbL40zmjkh5
 Ik8GYpHPMqLv7v1nGj3VqPEg3KgRbVaNRtLBybutlP+yqHnj3g+wIxhHQJrYvPrO14W3rDlwaCP
 VTh/L5aUq39JPDo7GHHiybhSnhH3jry2Rkqxvt9Hs05xkdsdS9DLQ4duzpG4B2pjGSYyYOe2Swf
 iyLlZOKlW58H21Zk0eUGP0umdjosMPxBVpbrSGtbphRZSUGFLIImURmNM4ulSWAopZIPRhPpGb5
 uDhzJnLBATIzzOcXSnOuafm6WMyjdTli3/oe3niOCOqi2nc2TbNHd/pi9ZCn39NAAf7RsA8rgeu
 RHmjiIriD3XEPht+Dr0/7lou1GFIAevNP5WcXfQUPFQ74pZMb91ILWOWwnl2wASlQ0LlTyzLBHW
 6tt1Ru4WJRzcKc5epzA==
X-Authority-Analysis: v=2.4 cv=Zdkt8MVA c=1 sm=1 tr=0 ts=69f3ca03 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: M6aYDZD31m7oS5-a1v3DiJzLoeM6rDhQ
X-Proofpoint-GUID: M6aYDZD31m7oS5-a1v3DiJzLoeM6rDhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: 19F3E4A837C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283001-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,linux.intel.com,gmail.com,jvosburgh.net,linux.ibm.com,kvack.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,sina.com,kernel.org,vger.kernel.org,lists.linux.dev,kvack.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


