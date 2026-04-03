Return-Path: <netdev+bounces-275206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP/UElUi0Gkp3wYAu9opvQ
	(envelope-from <netdev+bounces-275206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:25:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB151398240
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44B930CC618
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB26B3D6CD6;
	Fri,  3 Apr 2026 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kb7FcMLf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LlF5jqdn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC393D75DE
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247738; cv=none; b=KTspnAdVug5Xc5R7Ai9kmXzgpnsxy1cl9jTmnfiGFQKNSBSS75QXv71rFNlqNy7EHg0N6AbtEuofPGwKWI6cJ8SVytKV5Uv/b3/kcbv0Osfvi81Ast7W/LqeXwxPfYiKGQgcK2crD1DcCufM5h5nMsuqJbNF6Zb8GvWqmalcNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247738; c=relaxed/simple;
	bh=4SjnT6Ka2wPgrBFz/satFg1o7JiBbH1/BvKbL6v/5tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osqgbK3Km9eckSaTbeI02Z9LIAyga+rJ9b4zvUjJ5Ugh6zFyGAFOuDmUsHNf/z/f59vwHZZiAv3JGSizjg2ov7ZWSPwGVSNCJQUQ6rEN1oaAtVluW+mnp59imKE+3+ar/GkI+pIJCNAifnqJZtfUOrxW0WD9e333Wxb7eNJQwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kb7FcMLf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LlF5jqdn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633FCeAN947596
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 20:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RdZetGmgxCBZzPnCNsE/he42
	0KbIxYNkzQ/J2p11Wvs=; b=kb7FcMLfm6Z0YxFAGC8/WySRqSedf6PrhUWXfCjX
	Y5GkPDivUg7LZAul2osId+lHkeGMHz21xDa3U86IZFFewAudjmZ9yFyEl5Q3cph3
	2v6CvN1m1xsj5mocFD+EC9TUCS2AC3WTJ9cz+ivEMKaY7li6yH+QwUSCyF0gt6yf
	l3/jyAo5YrxMblLZSu444FwYvwscgi/T147sqU5KQdjb951Qr4qQUWdiKx2sgI9c
	ht52dNYgoIqA8jqGFgT2GY65GcUetxZoNsHZSVSTTlTp2jTIh/dxO0LLbjaFGiEv
	iqVriMrw6A9q+2QOSlnaxAlWsfOxs0ILyN2JnkXA9do4VQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9xwfku3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 20:22:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50925fed647so67804861cf.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775247735; x=1775852535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdZetGmgxCBZzPnCNsE/he420KbIxYNkzQ/J2p11Wvs=;
        b=LlF5jqdnbYXz2GROjMqlI61wvgshhk1ca+Z9Q6AYrvVhrGsEwMxJsg3/2LNqIwVhxR
         Cx14vQQ4xl9f2Rggpgej8FWi0v2Q/054AUrn7K6n189iJftocBK4VnkfjLyGppYwiMx/
         XpJcOz/y/n3TO7qp2GFnS8RmZVBInLI2ZYkijTNnO/JGAbx4lKwO+UsWmSLzXRRg9zeS
         jlv5zKVzJZCvaH7lWQD4aOXO71jcGK6nwzEst//SiBcfU/+cZCVQPnmO4ssjl/VDn3zK
         /JVp2hR0/5ZTWszwCPt5AJlkEjH0ZXgU0FXPmdmMZyAy2/aabGdhZQ1BbtNhsyL512jV
         +odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775247735; x=1775852535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdZetGmgxCBZzPnCNsE/he420KbIxYNkzQ/J2p11Wvs=;
        b=XOVW6206JW25jbwyCBBwhUKQWGi0arQPw+L6sA4ivqgWRZ5AJRV2kyt+nQH2zVsHEV
         cLIzMG5wt+ttLTImnoALvVGDrPuccv0tcvk5QDLKmPmbsXbBWpXvpqsP3bGLdOeexMNk
         /3UzgKKva6/DTxnONJOmCHyQawo1I2Nxyvvvcx3YPN3MKcukL5briToQbDyxoDXd6CCZ
         hZUY1e3yf7O/w3q5WQAIwuk9s443cD9JVs582rhzNvec5xiQwZb77Cg7XtY/SeEgLQ2H
         tT4KQ1WVl4hyrT5B+xz0p7pMn7cBnsbiwuTWc5uLemC3mA6btG+TGmQ84YNOhIb4D10Q
         pMFg==
X-Forwarded-Encrypted: i=1; AJvYcCVy7oUfJaIM0w4v/dejocD/jKjdIpDD56y1u05QovmbZwgx6uoZ9BDUH6ayqGGSe8jEiLi0XmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQa+KFDL0hZ8Rvl9S3Q8a+voVBGiI1EcBxsNiVm/UrAPDnGbsV
	aixv+2gF3AKMsNuXvWd59EYNQDM16PYpEs6LOHBmPyCUXl3U+G0qSPbPyQrwE7Ywhf1sLMMRItj
	Qn/PrYIdqX6aEnhwNS7hrvbVDE11NeDcC74bAAMrODHIn4gDw8VowUdzCMhs=
X-Gm-Gg: ATEYQzzVWubRHK0bNGypoyamIkOyCkEOtzoPC/i2IRzz0QO27nzz/q1BVGNFZx/rgVp
	4o+1wyb3xbDD5ILTRjMVj3fFdP/2FCQOokZIZS5h6gXeYalNRPt+rtZ23HwrBrIMnccx9pNBHo9
	RRw96o6fXyf/hW8wz3ZKeTSv8jNmHP/ktnAPwglQs9z30Slfml810rj8aZbtFIn+s1Yc2kRaXTk
	DL4D/hzn6+5iy6aA8BCj9Pmavj3JAuFr+SyLcItO6YOdnlxhaOtgvtUHoxbP3jgf4DLqy7eQfiF
	u/A1BitJVVwnzHGjU3n0Xf5uui51pjiicFHS+K4pJxEFRAI20VIA3il9zr3gKdOOa5pC107AsTl
	vvGGEgDckjQjmlLWikc8rYCPQRl0UIzHdkk3uqopcsTXKxdwPH4pgNGqtmDrHHy9vUMJvDjSUN7
	4Oh703tGUpqWAparBLGn2sqdU/XSzAonWJHuo=
X-Received: by 2002:a05:622a:1494:b0:50b:29a6:8696 with SMTP id d75a77b69052e-50d62b4fcb7mr70216111cf.7.1775247735586;
        Fri, 03 Apr 2026 13:22:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1494:b0:50b:29a6:8696 with SMTP id d75a77b69052e-50d62b4fcb7mr70215761cf.7.1775247735156;
        Fri, 03 Apr 2026 13:22:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cc8417sm1649043e87.41.2026.04.03.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:22:14 -0700 (PDT)
Date: Fri, 3 Apr 2026 23:22:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Prasanna Tolety <quic_ptolety@quicinc.com>
Subject: Re: [PATCH 5/7] clk: qcom: rpmh: Add support for Nord rpmh clocks
Message-ID: <hv4isa2c4tvbryofi7ahqvdcqmya4d4mujshqcj3z256mj5yvi@frjujwelis34>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
 <20260403-nord-clks-v1-5-018af14979fd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-nord-clks-v1-5-018af14979fd@oss.qualcomm.com>
X-Proofpoint-GUID: qrR6ZKSYSRHNSnA7f-7GpvRrjZ9spz96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE4MiBTYWx0ZWRfXzRPkFRiWSoCl
 lN6dIb7bjBGFMD3E/DkZzClC6nLVyM4Cv5BS3F3YIoSeNNXCJACv54coFxHqeXjeYm0pO1xh3wP
 tV5Oqv3vtdisP6TQp7oG2xr9O7so6txFK665S1WZ9sI6Qa2jmgXcKysxJu8lDgCJvC+CBRYZyY+
 JL0lSqDzjeHAXxBvAlX4aFAqZsq0Xbsuzv2fSCVpilOtNGJBU5FLqzbZw5jkrKOmz7+26ixHAdM
 cWbtqahWBRbNS1bNun3YXQ8c6LqwLZpH9hz2SBJ7h34Z/21iXjuyM51GbsjX5WoR+vzx0o2An0v
 kvL1UGT3k8YvedEE054qy18h+hUPZsR7yAbnO0PMa4HNHNjl3SFP++Ye0qWxTpYi49taZDKWXef
 iJGzLy8hVZEo6gC5xhukTCwmawUCS3QCUBJlT/AuL98DH8hmjGUwU/PNp4eK+OkRkLJ344kAz4a
 ufMURC8SimOJB3lsB8Q==
X-Proofpoint-ORIG-GUID: qrR6ZKSYSRHNSnA7f-7GpvRrjZ9spz96
X-Authority-Analysis: v=2.4 cv=fOo0HJae c=1 sm=1 tr=0 ts=69d02178 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=tInx7QPNiEBsNJQimq0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030182
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275206-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,oss.qualcomm.com,quicinc.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB151398240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:10:53PM +0200, Bartosz Golaszewski wrote:
> From: Prasanna Tolety <quic_ptolety@quicinc.com>
> 
> Add RPMH clock support for the Nord SoC to allow enable/disable of the
> clocks.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

