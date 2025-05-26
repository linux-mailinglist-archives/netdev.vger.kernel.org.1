Return-Path: <netdev+bounces-193446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29269AC40F9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA32F7A4F89
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B5192D6B;
	Mon, 26 May 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdrvAqEp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DEC3C465
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268415; cv=none; b=UBqowUPYR4lHSVm8NJgXUj3wrbKu3q1YXzCZ90ep0lnU64wjxsGFSFLpqror2VHmCm77Kexu1wpDsFR7781ZnRnTC4GC8ch5FVZtywsDAlaN4MpPhzsXF2wPjpJj4i9bNdbJAZHFkZgsta8wLxvMkoQXVYlBfkPOhIYGDtrpWJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268415; c=relaxed/simple;
	bh=qGTp0UHyfTMgcQ+KuObGkrJPDMheL2EtIN6i9hfGfio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=govbv6TzMmV93NemLqGNLxoCI1dsJlXkypkedsqbl/U+dZCNQHrIQ/jUXmuRaD95Gne4UV3Fo3F0uxKKyy/zLKQ6t0Pme1ldcMgsmOVmtWKUpGSc8id+z+RB8RkVSp3cv9Zf27iHrIooqbHuYUxux4LyAuwkcB8GBwnsZFtIbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdrvAqEp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QA4rfC023637
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGTp0UHyfTMgcQ+KuObGkrJPDMheL2EtIN6i9hfGfio=; b=QdrvAqEp3ZSusAU5
	YbOC+P/L6CDWQbcFwctevCZrzXXw9v+Rv3/cqErudbNs5s0P5n6biCl/Hx18SSCV
	FVgEDuBFPFXuY860HKdG8aq4hX7kcM74PEjhR8o+4spQzAzslMEfa2VwveT+KWH8
	T+5EiP6lm7Ksv5xLVh12LB8YE3uTxcliKLTxm4t/2BgoeILyPe3N8NrnRcaX0pVz
	v1SiwPbxYuOGsheJxRRabszvTayCH7Ww+Yk8ojxbnqVx8iPp+P0JvxPF7WdisLVa
	1Qud8b0uSG/i8GBv5ZT5ECuO8l1urQ3u2KatG0c4YCGdKU4Vh7Lx76uorSNjWrxv
	QIjPFA==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u79p4afr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:06:53 +0000 (GMT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b3b781313so448787439f.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 07:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268412; x=1748873212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGTp0UHyfTMgcQ+KuObGkrJPDMheL2EtIN6i9hfGfio=;
        b=TfxlxvS25ZzuO4GyqkcsLBVMvLspvp+SB+sE2E8LnPYnyJb4WihaGnMtn07d5rroWc
         t2YnapMEU+uautaMhXqR502Hn+AY39I4hitv5ddCs4wa4lgRTfZkkWvGg38ShWfgKQgo
         x9Sy8Hm3HPDYE5wiM2BEG1+5I6ENzlNTP5/jMQ1atjh3xr5BgZne6rXn9EBN6cY8TKXf
         IVd4wudWA1erTyOlaNyRMtZzPw0DRn4ai1WDP/oPpHWGL/vj1zCSJu6YYGKuJutsWRkD
         FYIxdLJNlJkSS6HpoqGcLddGWxXhkXub7w3Db3Sq2eRi3u4lqEttAHyyoLv1cXdUMih8
         Bmog==
X-Forwarded-Encrypted: i=1; AJvYcCVDAk9dRY7vHmXAf7I421Q2YJ6x/rEXWO85xfz5/xHbXmBPMeQO6JaSmFbtlkJ5KZBNvj4HUYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDmqrIVnKK8XKJMWn5sYu7Y+KrCjCPeWQQW/YLliGivuEbh1B
	TtNppt4YU4WYeY60A0P5eWSUFluTvXRX4XJkTstZlBX0fnVgnqY3NdIRg1xLlyswf/N27SXjDSc
	4ONXAQBMwai3/bO0jqxBJEGiBboJRNs/uYW27/mxwi/D+C6DYCYWEPXor3hmjOy/EOJAxTekvhG
	QVQqytya+JklwCYCn0eY9bu1HDR0Fhf0uV04atebKtVmCf
X-Gm-Gg: ASbGnctXoc7xKZ0eH3Yit8AjiLckyrIBl1M5K928isbPyvAznF9Y0Og8IA1BFRI8mvu
	oZyZ03oZ2m9tcZSiqLhoArDbzZVsDEGAcPWIwfvbpU6s605PwAQQghjKC051eSKPO2rmf9ro=
X-Received: by 2002:a05:6602:4741:b0:861:c758:ec35 with SMTP id ca18e2360f4ac-86cbb893f78mr806283639f.11.1748268412052;
        Mon, 26 May 2025 07:06:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH5Obxa3bfZjBKEXg0mVkbndSXFjYUBVhG8rBfcNn1Ifh2rBmHY5vicBI2fFJCR0MkXfiWoHRgPEy92MpFZTM=
X-Received: by 2002:ac8:5cca:0:b0:477:c04:b512 with SMTP id
 d75a77b69052e-49f46657f6dmr154531781cf.16.1748268400773; Mon, 26 May 2025
 07:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526130519.1604225-1-dnlplm@gmail.com>
In-Reply-To: <20250526130519.1604225-1-dnlplm@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 26 May 2025 16:06:29 +0200
X-Gm-Features: AX0GCFtP6_19YNJd_Z6Rhdjb3-NTx8jPH9eBW7d3hDCNVyoDxAFcqt8YWRjvxBA
Message-ID: <CAFEp6-06ATV_rh_KWvjgNoiw67WPvAE-gF_gU-DJdcycDiYVqA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Slark Xiao <slark_xiao@163.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: HlpPuLgbt6-Nua6BcAVWFL9vNox6FjH5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDExOSBTYWx0ZWRfXwdTZ+KsGwduT
 hvE9yTDTaVRzoH2K8Mz3WtiBGwPYCsP40WuE7j93Qus/seRsI2UjJnyQUWJ5zdehcyTUxHVIMEo
 i3Eyq6otFVlwjIsWHiwNGf27dcrkiRy/PZH8u/vL6okpdT1WHk7l6blZgZphumvjdf1qFS6wFQ/
 ijKl63GrUtuzmleYbOX2jN2ILtKj7poziWibm0HtOtxxGt3z8yTxuA3/6i7/QGASYgDqrlPETNK
 9CJXyAZxPzs2yFFBx6BQ4S9avCmEQIw0F7Bte6xeEwEiwTAGgw+D+sJTBmGyq33RYfYEpsJIzeS
 rz1cTFWFHv3pBUCBav0WVjkethTzx2DeHM9KDh1kqZ8HoBMNUqUXbLoT/05KM2pty7lFho2lZvh
 BaoffFK+vj9EwMbRnuJ+g6RalcL8nEa+Dfv47pMBpXEyw9EzdJUdiOWfs2uQ0OIzw0btLU8L
X-Authority-Analysis: v=2.4 cv=HNnDFptv c=1 sm=1 tr=0 ts=6834757d cx=c_pps
 a=uNfGY+tMOExK0qre0aeUgg==:117 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=pGLkceISAAAA:8 a=GM3u2P2812537teep8AA:9 a=QEXdDO2ut3YA:10
 a=61Ooq9ZcVZHF1UnRMGoz:22
X-Proofpoint-ORIG-GUID: HlpPuLgbt6-Nua6BcAVWFL9vNox6FjH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=916 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260119

Hi Daniele,

On Mon, May 26, 2025 at 3:19=E2=80=AFPM Daniele Palmas <dnlplm@gmail.com> w=
rote:
>
> When creating a multiplexed netdevice for modems requiring the WDS
> custom mux_id value, the mux_id improperly starts from 1, while it
> should start from WDS_BIND_MUX_DATA_PORT_MUX_ID + 1.
>
> Fix this by moving the session_id assignment logic to mhi_mbim_newlink.

Currently, the MBIM session ID is identical to the WWAN ID. This
change introduces a divergence by applying an offset to the WWAN ID
for certain devices.

Whether this is acceptable likely depends on how the MBIM control path
handles session addressing. For example, if mbimcli refers to
SessionID 1, does that actually control the data session with WWAN ID
113?

Regards,
Loic

