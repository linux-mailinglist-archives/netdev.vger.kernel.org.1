Return-Path: <netdev+bounces-305266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RvLuK21vTGr6kQEAu9opvQ
	(envelope-from <netdev+bounces-305266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 05:15:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDFE716F9E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 05:15:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=lDeGwA4M;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=eMNuYgJX;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305266-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305266-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B67C2300B8D1
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0B92EDD78;
	Tue,  7 Jul 2026 03:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEE420894
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 03:15:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394152; cv=none; b=O/xOmRGr17oT2ygb/wjUMt6a9FeyG+jyLNaGq7DCvxRHgq1T4E35+o0WAzEIRkY+ItzsAuEf5AHhWEDJfLAHTyYcexIChLtrIW2iyWQiStFTdvUikRzZWR7Acv0jBrWDs1FkZGa+iRl5Li0rgSmXOheZvd+x+Djsm5PRH9cX1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394152; c=relaxed/simple;
	bh=5lwDQMlulBC0yjUvbH8Nb43Xa9OwjLANFBcGuqy8cF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkMF6E1c8tbcACy5+JLOHXgBnY2PdQvez9lhVPmcWhYStXCiwhjcMxqfmRBje5cu1cZPB1OPXdVT3jZgwIckq+ZqRgzOGZkIcBPijJGTC02Mp628d4mxmAE5uSW7eu70E+R0bDameOjfHl9ed1iv2an1HxpMYoRa9yUM4VnOhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDeGwA4M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMNuYgJX; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEJw81639917
	for <netdev@vger.kernel.org>; Tue, 7 Jul 2026 03:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+2WHMx28uFft/DFZTLCY+m53g7WHXAUCDoM2ChDSZN8=; b=lDeGwA4M3fCTgMFw
	InbTYoTYHt39CZMKtwgnvOoM75XW5RH/MH8++MmwULr+60qlE46bnTrOE/n/x8V6
	y4Yu9dL2FfWk68ZalxmY+0mL4G8zSC/eDmfPbZE4DZTMpJz8KoOs9lhdG0tlRIhD
	10r0Fi7NEBXEjJ09UWC3xwBmu2wy54IvxJQFKne0GLVT66OgUNFLO/thtQUf7AN9
	iHEF3ftdFfNxGaV65zD/yceO46ruPdgCmeylWM56FT9u1s/shMXYZNWmQ0eDBgWz
	ZmSJfDUfd4VpOm30+P/P3qqJKzeFKP2cY0dyZXY1kLR5msILJTEPkW5eowVjVv/r
	/juG5w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r3u1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:15:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8482b5cc6cfso749045b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783394149; x=1783998949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2WHMx28uFft/DFZTLCY+m53g7WHXAUCDoM2ChDSZN8=;
        b=eMNuYgJXH6Qo5IrSPEG5zDxRy0nedTHZzNJP9ZJp8IMxYxUfyMHgJwEUY9Sugr/8c6
         8NCgO39+gulc+4uz1qUy4zAL1tjumNcupmrmMUnhYYJkd9ZJNR69zZhoZpS3iL5+ioMA
         Zy+10esedT1MEQhlLEOmeIvT4/feTuGk9L3MKcJ24GLElgilrnWspvOeQGLw7uo9fTJD
         jMMKLO7gqUb2mdG+flS6ce4JPLcl1uox/ka1NyV1lQ++bbPhVkyYcaUz2uoMLSXpwJ4y
         XEg67RXS3SDRdVbPKV1l/3v6FoC4Kz1f3TM4rWbjfxt1bCifLV6l44cxgQ+plQeX21Cs
         yPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783394149; x=1783998949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2WHMx28uFft/DFZTLCY+m53g7WHXAUCDoM2ChDSZN8=;
        b=ohbSwzZX/5aCRrg+XeSYwyeu+gwrol03sB0tDogYhGFHqhUfNXs4/n8S7b6KezsCy1
         KmP74rv7QE9vmCOu6BUz9OcVo1Sxdx2zUEsNszsqKaCbJ+l50xFTAAgduKATHTSDdkl/
         ne9aDRD837ercUwYSpdrzoTA7Ej5/6XS9KPqznEm35kZmXLizYH7Dkj0rlAT/gozSPDt
         LQSZm2l735rw1oV/7v9iU9FN8c+K6POy1DaY5mnzLvNuNSmQmXCSYuE1+LM6pkLl9WJl
         FEwfzPRW4TlFLNjNn1dxaXihDQAxx6516lDQtJl401V9AZKAk4AYmorYHejD1gGyRy6C
         +T8w==
X-Forwarded-Encrypted: i=1; AHgh+RoB0AqfbS6KHS71QyFgopZJZaM6bc7aPzJOGEiLd5V+ULfhONnlRrMo4Qy4tqI1eXvk6CifABw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2e6vMnbG27JjPywYnHENUoVx61xbgoaMUi4ib90MENi2qluRz
	mf6YOcibPiNq3+NYzPGhw1Mhn+Suhc5vXnmBgSTyJvcaNBhdYgtW3XtEn4Q38wwYr8YoQOz8Qyo
	2bDRfqhLRTxI5wJzMux0Ep+xiJr0rolmTNsVfUNtypOVovFLsasCZl93JCM4=
X-Gm-Gg: AfdE7cmAno00GtujKyacTC3FpfvSKW7zboVOIy8QYoyi+5ELXfJjs5tY/jedtmjEEOc
	uJvxyWjcJOL/FCdIAKOIWnnGiZioh/srmJXzBPAlfaZGwFqBjDdueDGqiG6RuB9WWBJDwsSIF/f
	7x5/bHXJ7yzY0+I2jedUS2zQ+s7kDQ0VkP1dB1JmGtVgxGZqFbcvPsWhLhxmGuQUrDyHbHC6mfL
	Whwxtn62AybAfLgfZoPYtRZSv3oSUPNIqnjG1hocDJyy7G16isU0ulqaej+UxcJa1rlgpljyS+s
	UWaeoUqDEBbo36KsQgJLFvOOIt0j9iBgkUs2bJt+wkrXO4XXoGYu22GVeNAcIwc8GvRTrGRioFP
	mVjDlnpCPtikMQjybghfxwGHL2ut1rRVpwNJ+8Bg9syCuWn2ody2aAJTUeFkNy55VeYVkbBWxAs
	Up
X-Received: by 2002:a05:6a00:3996:b0:842:3a98:b34d with SMTP id d2e1a72fcca58-84826d1a9camr3018064b3a.31.1783394149013;
        Mon, 06 Jul 2026 20:15:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:3996:b0:842:3a98:b34d with SMTP id d2e1a72fcca58-84826d1a9camr3018039b3a.31.1783394148515;
        Mon, 06 Jul 2026 20:15:48 -0700 (PDT)
Received: from [10.133.33.152] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d496besm4636406b3a.36.2026.07.06.20.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 20:15:48 -0700 (PDT)
Message-ID: <4e08f53d-db08-43ed-9403-ad25e3c6156f@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:15:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: qualcomm: remove unneeded
 'fast_io' parameter in regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20260705164208.2184-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <20260705164208.2184-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAyOCBTYWx0ZWRfX9TnKqr4PQTiq
 tWwNRo1EDBAjXtZ0DSKr9jnXy0KrE5vMOyFrNcEECofJ4ncId4LVdBuBvYfUOZzqYJ1PWY5w9Kt
 2ii0qYY6Von4NMpqlHvTKCi+Q2qsEhsie9jo8GXoX8PlC0AwpmzxX2ZNIdMlZZEhkzyzE5WpxGE
 YupUZyeWhHiGYJlFOGW0YcgI8rEd8+LJHuXCfu8clJ+oTvYnadsGnmdqpf4+mybZGIxE+dVYSxF
 V0Nt3wPugOUFe8wgeocnnA5bDaVAvXv86ArifNXY/RPjvhmeqSRT3IjpFLvQ7B3/DHSLx8dTxJo
 ME+p0TFfTaPIeO1hemjlFs/34L5xTUvbBcwJ0vTYW1f8lmQvlbrYg3HTxBhBNDg/R3NLFq0sugv
 F3hbj+q4nTceKPlK6Z5fdhE/EZUG3/7Y+BTpg2wbHpQF/CO77A1uEJkMN5xBZKsskR5e41TDKbJ
 tLJZgOeyxE1MXXrXqSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAyOCBTYWx0ZWRfX/PIYeaQhl9EL
 0R8su2sUP0wFXjs/WvJxLLE/oJddoIGwFl4HyOAfZRYUnUyvp6SuquZRF9/TTsesqO+8vcvLB3Q
 roEaFCUySXK9wrO4pFZqSWScKpHY97k=
X-Proofpoint-GUID: RMwEUpE-Tp8ElWTpYApB9uwNSnkPvSsZ
X-Proofpoint-ORIG-GUID: RMwEUpE-Tp8ElWTpYApB9uwNSnkPvSsZ
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c6f66 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=LDBv8-xUAAAA:8 a=EUspDBNiAAAA:8 a=wHv592AV-T507FYI2ZgA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070028
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305266-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:wsa@sang-engineering.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FDFE716F9E



On 7/6/2026 12:41 AM, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
> 
>  drivers/net/ethernet/qualcomm/ppe/ppe.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
> index be747510d947..3c301e609d3e 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
> @@ -106,7 +106,6 @@ static const struct regmap_config regmap_config_ipq9574 = {
>  	.rd_table = &ppe_reg_table,
>  	.wr_table = &ppe_reg_table,
>  	.max_register = 0xbef800,
> -	.fast_io = true,
>  };
>  
>  static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)

Reviewed-by: Luo Jie <jie.luo@oss.qualcomm.com>


