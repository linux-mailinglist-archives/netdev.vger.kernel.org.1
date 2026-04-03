Return-Path: <netdev+bounces-275205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFMwICgi0Gkp3wYAu9opvQ
	(envelope-from <netdev+bounces-275205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:25:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8572398222
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D6130B3748
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1F3D7D8C;
	Fri,  3 Apr 2026 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/1At8ZZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c0Jva4r1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E83D7D81
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247717; cv=none; b=Cgi5dvBV9k61JnZH0mYsOc/p2zX3B1VBXcmfwZT6v16MxHyOBCwzvcnbn8Tmajd6KDTGQ/Bt8wtNFDfZwXZ40S8zi4+q1xAfgv00lNFvSHn/4ox76utTvaFht53nuBbsf7Q8lpOv5SutKNE5W+KKxqh7QXFm9TzJT+NKDMw3Xzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247717; c=relaxed/simple;
	bh=nb8Kbg44hJ39/A055cwVAxiPWEhPh3mBd/A8GJFpz3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUYH/SlKRTTwSmrDzQ4WqkBfDdqJnj2watf9VYgeu0DdfbMf6ijsaKJ5BvZUingSQRjXzIBmGhm/dLtnJPVwQXy7+P+JvREzpYhjqSVXUP+9Yfyi2lnR0qE+4btZpSGdNDgBaiScrnodqU3uqifnh37OQk+5Tw4MjZ69ZFjnySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/1At8ZZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c0Jva4r1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633Bu4Pv823327
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 20:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Nka63p93CHyAXN8AJpLbagLI
	q4nnZW50CH63xXuqh0U=; b=K/1At8ZZ2LNsZ9zkXJAmc/ai3e2aT3L0iv3NvR3K
	OgMSc89nG0exb5BYXt2daylASwFAkdg7V6BjZMpk1Yvt85D+7iLdhZAYWBwBn++b
	bGrIJUCH4kgP1HaRTtS0Ksg1TGx+xGcmHMZ/KxR6EUq0lZlLH0XFcETa7XFH32G8
	t45bUDg7jVUty6buVJgxvLzGTOCDDd07duSCpty5hWAyjkliKA4F2J8NxZ39YgIf
	FxKXRMW0GzLuhtHQ/XnOgFEH6e0vMYd2b3jbaa/M41kTeqjpYyAlBDJBt1d2I6Ng
	3Sfckv78jSM8g33ySRgeorv0q/PcGAT36SIn+BzPeAtodA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da673an4b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 20:21:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b323c43fdso48888711cf.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775247714; x=1775852514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nka63p93CHyAXN8AJpLbagLIq4nnZW50CH63xXuqh0U=;
        b=c0Jva4r1LP9bOzwAvfzVSXjpzd/OAluulrKQGz3RPnE1KKZ4evDUJtPioDA/kvEzLJ
         s7EqTK4f2OFApRyAzFOx9aTg7ECPaipe5JCzbYMmkt3FTHvwK42ywwMotwIhuFqjc3AS
         amonJ9tMITwIByVSTPhgyJBt9isw6v/LS3Lca6tjERTpdnjJkZ++VEhDBzzR/Xg5Ccfl
         WXNBG5qxDj0qYfbJcLLnuS6B32BE9O2KqTelj7h82oUoaZ5/DnJRyPhBAKYXSIMERGz9
         PILlHoA5AYpzmOxCCXULTn7cGTAwiV7iuTXZi3Pn7UGdpN622gK6pqS1EQjVX0cyJyYa
         yFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775247714; x=1775852514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nka63p93CHyAXN8AJpLbagLIq4nnZW50CH63xXuqh0U=;
        b=rXnxK9Eo2iBXkI7ySitJvgbGZZp9VLS+SmLAcWrEr4DgrjcphWGogXFsZb69ryH11n
         DIZ5I7i3IGZsC2/9AE7Fb8vlolZMw1NLwVK0nkhT3v6bARuZkd54JOqLTkY91mWHLlXa
         PJoZSuSq0ytye2pZatrfIr5i7VKNnuVlTSgDvQDrR1b8VevmP3J1Cmhz33YahhO9NSCF
         /xCLZfLgOpTpDx1sC+GMWUAWG/ES2QTpJtlkZbHMMmCIfPqBuHu2tsEBVHZCh2ATOH/M
         I2ON7mS2nynRaT5L2ggGxWeY+/y3ZTnbTZkFCQ07LmV6QJ55p8x5yOxlcANO/d4hRiyB
         3zMg==
X-Forwarded-Encrypted: i=1; AJvYcCWooYtGZCVZfFvNi8SM2lGHqvhxsWp3LXn7Mi0w3k7IvojtMRW1mBo7+1fGAi5rDjxRP1OVftE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGUs1i7pHnIHiiS9bTJ/PJnoA5w3BsGXSFYcWHt+uBv+JSjv6
	JHVivuWsQFL4CQC/68xfJKZ17oj5v5k08EbQMTtwRz/0m0OYC6FCOKhPVwJOKINjfFOykCtLOZN
	anmfiaiut3w7JENJbo/UKEdbizD0EpxIu55njgABu8QwuUVPgxa0sh58FAWo=
X-Gm-Gg: ATEYQzwyFQEapfPMvI7gS1gS4aDEaXbOE828SNwnTfWGE9WNkz52kdl/5WqEBayXX0E
	WH7rxruIojy0K2YSqpTE7wgDkJ4tLfbmyTRAYABAhC8/3Zv16TUWUhZje4BFmrhiWXZ2BTCcIq5
	egWjcI7hkxsHFEu3ps4fJSqveTBWEgtkGHvfP8U7e9LORv7ZUjtTDuOLziGVXIxa/xWr6otg5UK
	i0WKAn6H7vsaJhAGtEIAMfJs/jsj8b6tI+/buiKx4RgXjw/YnJix/Y+wJKB4ZD3GOnSARBk3zB3
	kFGfjjWg8NREokh3kdJw17U2q1VjTohb0Xg56WkuNY+uqOCtYl8wyCsIZnyow1KzAG0NFpdt4ur
	QPFegLebGt12WM9s2VVkYMVdyiaiCQnCyR0hdDI7e2Tk4L37dF57UuT8mOy1BeyrJW7+uwRkMH7
	eUHKVhYngXxn2tdAUGIh2brKDY68yOfs8fB6w=
X-Received: by 2002:a05:622a:7004:b0:50b:4226:9250 with SMTP id d75a77b69052e-50d62a8d628mr44817881cf.44.1775247714124;
        Fri, 03 Apr 2026 13:21:54 -0700 (PDT)
X-Received: by 2002:a05:622a:7004:b0:50b:4226:9250 with SMTP id d75a77b69052e-50d62a8d628mr44817521cf.44.1775247713632;
        Fri, 03 Apr 2026 13:21:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c644basm1694310e87.0.2026.04.03.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:21:51 -0700 (PDT)
Date: Fri, 3 Apr 2026 23:21:48 +0300
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
        netdev@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: defconfig: enable clock controller drivers
 for Qualcomm Nord
Message-ID: <bjf4jxgvtc5mm4w4mqy6lnh444p46skwr4etxehx6zsz3wyhjq@l6icmwtqrvs6>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
 <20260403-nord-clks-v1-7-018af14979fd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-nord-clks-v1-7-018af14979fd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=erjSD4pX c=1 sm=1 tr=0 ts=69d02163 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0l0SkJvSUQpXNeVDXDcA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: rHPOwg5V2grmebJ4KJTLqqso4bXaiJhf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE4MiBTYWx0ZWRfX8mZLmRidOIcQ
 OOntue6hVhfC/qeAa+K3l/u4BbrpAf/cT9aEMA/zwBP5+Xbe7zCgw4PNDYS+bRVisvCqmPkjNs3
 zkfWfUEhB/YI+w5VdWmHW4yvA6bUFq7S4NC36wBsUxrElgEVw5+uey3VNxH3LeTSjrEc4mV/+U9
 U4zSKN6NsxnGPcr6WQbLzwl82rjbd+p0UBsLjYXXPBEkW/O/ogz3ReOMlXSZajJ9xdxrajhu1WD
 gz8hS4K8XBlw3+uQnJuTRAL67sOb7LJllUrxOL8IjmuG4KvO7GETA0foQtA/7N+aFXRfi4fUMjN
 /zy8YJIhP//HSlRMk3reI2GJ8/rMNbjM2G8kB1J0YAcRQBklo6iJFfoRou1unB7INNTWv+tWhfd
 2pt+JdwvCXo/yfiyKSUMa0v0NfTWw64pesUP1N6jX+RfM37MMmVQa32qZYXUuscqQPFtFo0ocrO
 XKEOlT0r2zaQzYOiOGg==
X-Proofpoint-GUID: rHPOwg5V2grmebJ4KJTLqqso4bXaiJhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
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
	TAGGED_FROM(0.00)[bounces-275205-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,oss.qualcomm.com,quicinc.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: D8572398222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:10:55PM +0200, Bartosz Golaszewski wrote:
> Enable the clock controller drivers for Nord platform from Qualcomm.

Same comment. It can't be enabled for the 'platform'.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 163b7f0314c90fc45eb6c4aa5e8faa549c60fdf7..f1a3333bb07482ef4f8b4ea9154b0f2c74587a04 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1483,6 +1483,8 @@ CONFIG_CLK_KAANAPALI_GCC=y
>  CONFIG_CLK_KAANAPALI_GPUCC=m
>  CONFIG_CLK_KAANAPALI_TCSRCC=m
>  CONFIG_CLK_KAANAPALI_VIDEOCC=m
> +CONFIG_CLK_NORD_GCC=y
> +CONFIG_CLK_NORD_TCSRCC=y
>  CONFIG_CLK_X1E80100_CAMCC=m
>  CONFIG_CLK_X1E80100_DISPCC=m
>  CONFIG_CLK_X1E80100_GCC=y
> 
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

