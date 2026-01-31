Return-Path: <netdev+bounces-255462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNweJ/AvfmlfWQIAu9opvQ
	(envelope-from <netdev+bounces-255462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:38:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD0C30B2
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8129D30137BE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5214318B86;
	Sat, 31 Jan 2026 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4++Jq9i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B9bA9OIX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CD2DEA95
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877485; cv=none; b=gUv1QrfXRVy/Uqy5CTDM6lIGPqVd6gAUNZL8UnprIIyHRuW1/uq/M7ZOBK3Xem+AAljZvN9iioYyfdumhFzH9EjINqWd0Xfu5Ew09MIJH/Ynq4jW+3XLm80bQSa25PrhMTLPzq6xmePkMJXe8/VHAKp4ybKGqnzVW0jK54TxJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877485; c=relaxed/simple;
	bh=wXfg3+mqB7jcLZ1IXZguZSxVQ4BFEDsjgexkeITu8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzIoK1L/HxZW4UhM85LpB9Sq1wbhjjLKEXIUJKnKsx2mb9H/Dt3QvloiWdYt90KazaVPQhmgX2Yj52Cv7LFCUKQ7qJbQKtBUwNYZNFCvva9cgPxtk6UeEKFR1WrAEEVpWgUOqJ35/iPC6+YR0h/tXeQ3W0JoGgmjptd3RqQkBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4++Jq9i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B9bA9OIX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4UGBh447662
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J50vAf4p6pBlGcfz7i0jIrGJ
	w+GAmstYwfRJL62C4qc=; b=g4++Jq9iWAPk3s6pcZPMglEaYIh5vVQ17pyXSuVJ
	nMytMkfzHNqJZFXZBl02yusZX//QuRM/j9X3gRWf0TL8etmKhWqVloCjgeXj1R82
	/Im9SfNapYLWXeS6zCo8kmW7SBNuJiovBMo/mCaN7MceJ+ciko9CudXzPez6t0Kw
	5Uoo1nVp+PUG2fu6YT4BFSOlhxn/ptIZ3mFfwlTiw3hcMsg5LPQ01dni4s4boNu/
	dZLmR18JlOu7X0kBs2D/FdFpXX/kvnFMpURN2E6QtC9wmnUdrYRuaZZZHiuRwvRD
	V842pUfJUr06E7OLLCsVTBHO9FMvJ5tisfW7M5vjswmAzg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrs52g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:38:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6133262e4eso1925289a12.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769877482; x=1770482282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J50vAf4p6pBlGcfz7i0jIrGJw+GAmstYwfRJL62C4qc=;
        b=B9bA9OIXwtki/bBjyHQg7NhLhFNbLUa3YhGnmlu3K763xlaxzyrKxGH3MKwFA9HCRF
         id8CwNRYH4uVzYr3GLq8JjiCUcCHGn9/ynUzeuuwgbUwKjpz+PPfLDja5KAmbH3g1syK
         aRaplJF7zhTGWO5szAFAnHwgBm3Vas4qunnk+V/vuj3hVukO8LW4oPvNTNje11UTABUO
         FSH3DrtjO0nUjQ+Q+jt9NFFE2kpt1V2yLNnP5JA1Msh2AkuQ9/lb/w8dQ6DqF1hbWG/f
         ghe798Un90awCMqUqCq09oxAkTJ6a+ODJrD00cG8EKJ/uqVQymcRkCr2mAZtm9oZ59vQ
         xW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769877482; x=1770482282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J50vAf4p6pBlGcfz7i0jIrGJw+GAmstYwfRJL62C4qc=;
        b=YhM7YxJ5LvhHgWQAu/pYlIfoZuklR9jgF2tRpubqV0cvLmWv+XEnHfFzkFDjNCyt8K
         x033142XfvmG8yV9fMpiN1cB1TgoAsqUqvvHNsQ9oq9oRJliQwRLIO03J38FxujIA0iG
         ueuP4Q8BjLX0nb6UZpATZSEVi7qQGReato3NxW3pTryDR1j8DvRNFJZ+eGZ8nAQNJHBj
         JC+ufIHDmsxSvugnf8B0/Ll4i9vQqAqFI5pRNBcDWnOhUUOo2gqRdSLF1cQGJkAUgny2
         NX/YgA/6v1KGIx9ta7RMCbfFEbotV/AM409DLqKgCKexms+Yl6KRBAKj99ZRYgHjdldh
         WRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY5HMZA4QSPtuYDSdKG/AUwUGfX/9xacdgl/d7GYCuCylaaANXUuZhHjRCiNJeNpXc8xM0Pfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/O5b+izo9twFN7eaVGwpL+Mzl0EHeBZE5J0sLY21RwL3FBKt
	0dodk+IthL8wkoFC2s68W/OUtu4o0s+aWzm15dYU08aqmwY0djXyyAFPuzN4pEy5hfDjjdQdiaO
	k9DFIUcyo914s666e81OI+nyRXUj5I7vSsrdo/VG5ZYXoqBxt7XK4r9qR+X8=
X-Gm-Gg: AZuq6aIKZm/5t4ezKEo4gS7bpEcBIgfho9zc1JPLsf2PdO4OfQA2QSBawIEsfBJavNV
	Lb9hvbR9hkbwshf2lC/ilCrI53mPXSVhE0mDWtVuZeGo/NZkWjDWIVAJo5AqAHsAfhOPhEG+I0P
	DJtOnA9xp03e9Ep1aKG4h4tu6AytbN2aFk8w/ypdxwnq/29s/DbA+GLVzRq0uFOpOuNoRKrKrwS
	9/oU/CT2DOzs9nQQtOCtT61/qpONkyF+4nlIVDny7r6kUCgbhYXqmvU/H8BZWNbeJnTAXsZLNQr
	IGiytXkB3R/6reC4hOdjelIYZOovYN04GBIG9s4N8e2HKw62yMw6ON+Dul4IwoulcIxNvVow6+E
	PBVLrgmtgUZAL42SH+a9D0z8=
X-Received: by 2002:a05:6a20:a11d:b0:38e:5535:bb4a with SMTP id adf61e73a8af0-392e0012363mr6614254637.11.1769877482159;
        Sat, 31 Jan 2026 08:38:02 -0800 (PST)
X-Received: by 2002:a05:6a20:a11d:b0:38e:5535:bb4a with SMTP id adf61e73a8af0-392e0012363mr6614233637.11.1769877481572;
        Sat, 31 Jan 2026 08:38:01 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64276ef9fcsm10392441a12.1.2026.01.31.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:38:01 -0800 (PST)
Date: Sat, 31 Jan 2026 22:07:55 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: pcs preparation
Message-ID: <aX4v499Zz0CymZI5@oss.qualcomm.com>
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
X-Proofpoint-ORIG-GUID: ovDdBujwVhurXa22SSVd7cyzAZbAMiPS
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=697e2feb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=TRWK8DKzUZuuTiZSCyoA:9
 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDEzOSBTYWx0ZWRfX0KalsJE+Q95o
 jGDyiVvoMXzSVJG21pzqkM4Q3OTSm8QpwsFsPjsfyfGO12uyaMlhWTfVuK1BH5OnwntZEyDkraK
 sd5UIr5T2xgoNg+X4EWA899abv9HR1LRmgoTizh90eB1waevfIVIvJ4OWlU1+mfhoH1vJs5nYLT
 x4nUb3RQ1i7mMObEG1nGmiIVBmYAj/Pyc7YojckU+ljZUibDXEpvpkrigvQscy2vhKIBPWgBcX5
 VUf9rFRHJbOCHMRu/haZH7OZyv0PsvbCumJZwgLjy1DFZau9MQpvsbdZQhH9Zmf113tDxNjXPld
 ReUkJE82VO3fki8u7z1+CYL5P4uDds8W6pFTN66TBwU5TVi2H3kC8cbHH1IfPidnTCQW3YSWa61
 lM9zkI7vjaL3dIGLIQYPXVHfti9NVSWNjYwlsLEpi3bJamm0lBs9LuA5RN0HaPB9Hsa2wkOFCT1
 niCfVur+51D6K/x1ubQ==
X-Proofpoint-GUID: ovDdBujwVhurXa22SSVd7cyzAZbAMiPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310139
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255462-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EFFD0C30B2
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 11:10:12AM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> These three patches prepare for the PCS changes, which, subject to
> Qualcomm testing, should be coming in the next cycle.
> 
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 --
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 31 +++++++++++++++++++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   | 24 ++---------------
>  4 files changed, 44 insertions(+), 31 deletions(-)
> 

No issues found on the QCS9100 Ride R3 board, so:

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

