Return-Path: <netdev+bounces-301307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F+gpC3NNOmqR5gcAu9opvQ
	(envelope-from <netdev+bounces-301307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:10:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA56B59EE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:10:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=X1q6wAHg;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QGFQ8JJC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301307-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92D74303ABFD
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65683341068;
	Tue, 23 Jun 2026 09:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011F308F03
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:08:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205699; cv=none; b=Lfrs6WZVDYxK3LV/AgZOHqiIDHeYhsZegJSIMAPggLb1ke0Zk5cBaFBwVZpGc7SrCAfepd1fvF/61js0ECSnf75wcWZwp4QTSVjj4CW6nj2bNHDpPuLlmXVVI2flX0GixCbhU0blM0bDa4yY6LZemdu5M93qv/nwN2fT1Hi6mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205699; c=relaxed/simple;
	bh=zM5ygIRfr6T5q2HjenYVrxQr2Py/9mOvTlWDJRoNssE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxZIjLLKJtXYdNFr8wXBUy/iFWfkR3S7L2cWj1bMC8a4T9GDiX+vRX/5DW6njkxqfQ0+r0ognyRstO6blJUXs4gIohZw+Ni288oF70EXz5DiSeyciqafuw08m5aKTHDdmnxC25inEsqFY/xxL95Vqb6K6BQij4LSVK7Q1GHH+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X1q6wAHg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QGFQ8JJC; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cmKX3547277
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I37pwTRNyH2lUXmBptqTrcmcDaXs7c+RllBrCyhsjRU=; b=X1q6wAHgchGik5br
	XriuufvYcwN3RP2fs0QMtgkyW+O4x3A+0ud7XboJ+OuiJ1YiBW4dd0bRYNIVwyIb
	7T4d5UBjCdnJgmxTPb0HMzjgyTgulP4zKgqnxSl9Z7x5SrB8y3RwTdXk2s9VALMB
	5aYuszB0tuptQLcI3YHhHFHVwpVoOpwIlYUC/qxkPYfqGalptoZTvLN5gkzamSF4
	30FZulovzajYMq5r6LjL2eQmyYetESF0SzuNfphYwxCNfXEkcM6b3sXpe8ylopAK
	lFET7VZpVvHxVmGnro+BJGoKPtuNxL+06Q3bo7TadGzZ9MzE1PrFXjQhY5E8dlsz
	9Kffyg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebccdp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:08:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8453031c57cso7597803b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782205695; x=1782810495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I37pwTRNyH2lUXmBptqTrcmcDaXs7c+RllBrCyhsjRU=;
        b=QGFQ8JJClogMN/d5OjeHxjqku0HivEmqIa++Ccr+rGnsODlA04JdxgNKM0dOTTFQ3J
         aQTeaWP7pLSy+RH2s4VRZd5SECkzHyZdRf85KAOUFY+XhvoJnKHXTKsp4CvRAEJxEja+
         BicCZxMxq8HH/ZqAXpF6csG3f7wyM0HK8n5P1Y8eRooCl4JhE9sEAr4hUHqLUXrSmd2/
         fosrgTbg4cd/iNFgO8YZ2pUvDBoXVTrio4xZReND1/smlrpwuexMLbaqNbNtZXioFY48
         jpetOrI1ujxobS2yvdxWdYDhRBw9P17Sf9/MaJRaSGl86QjRmsuxcQxj/myj9uuTs3Bd
         DCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782205695; x=1782810495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I37pwTRNyH2lUXmBptqTrcmcDaXs7c+RllBrCyhsjRU=;
        b=dMRPpMPeW5I1TPE+La36srAROie/Dx8U2ye9bQ8K9QboXBnO0DbznP+zQJCZxt6PnF
         ueFhevhVicRe8u+t5j9Ut1I8bxdfk2wqKGjf71io57j6Gn4t3ls2KjqqJDbOH0uAgMk/
         T5qeocJhL+o3HscFIyDdoNl2VgqTaKxaQVYTLenFOVjMLBZ5VcnZxTpQrX+SLhZpvwme
         0+Y0CD4FgQvM964Ho8Bf3ybQbL3AK7MO3Vn0xxjsDPzTMhKpY42ElcdB/7jlerOo+ZkD
         kMhbaTIk3zFUxoc8aKJbfCXQMPQPQYL7+Opn7MwBJ1IYV21RrOi3Nyng6hsmSnA+nTtW
         VFTg==
X-Forwarded-Encrypted: i=1; AFNElJ/eIcrs82lvtu4XRHJ4Wi89lltNlCd7JqINfdBRTfftjhiqPTxHvptd/RaJNnd4dXvd1r/tzcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4V44plqtJJwAO47IJPjZL/JGZAhdJ+/+ctKjiqm903uNdKyL
	6gNM2f3wp7Enwy8dY3ucAgIBpAGssl2qXg6WeGxYysupfGGdZLnHIRNw3roOBFnEnOGBW6I52Er
	e8o8kgve1bq+FjWZTTBB+O5C0yCumBVPJOcdKDiOa/bq61zxzdo2k9B33lZ4=
X-Gm-Gg: AfdE7cmJ8i5mq0tU2pWXspR05v/JEYZ09kI4SIisOV0f2LSRGj83BVr+XyAZ9SRNSBS
	s6ypwLMZn2w/KqpUqZFlAOxBUV3dEM7b/eVrJmV0/W37BOTMZwXYyElcEYittBfjh5qVU5IEFLW
	k5/baVRwa2lMvP73+OVzP+oyGQ+4S/O91fTMd6NUM89p+mAK+w3Jw8cI35XJgGpe1wtHpRXj6Yj
	axtHTKWXd94GLGA/r9mk5yThGlIuKWTikDDVyx1Fj2ba2qIfK3UzIUALQrBnhV5VEFxiz+Ehtg6
	cNAEPtsgk8v4hpjGsyI26fZcH3CX6PJh+uZ6fCYBqYfrBdvFnO0mdq3VQfXS5HTyPnYuokgTKBx
	YN8tOByqBxj5OEDHCPHh2bEws01SGK6TSzc5SjNEW28PW+pr//kiCDnHBEjY/43D34uyymdMdHx
	w+
X-Received: by 2002:a05:6a00:6017:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-8459700a9a3mr1902371b3a.9.1782205695100;
        Tue, 23 Jun 2026 02:08:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:6017:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-8459700a9a3mr1902324b3a.9.1782205694644;
        Tue, 23 Jun 2026 02:08:14 -0700 (PDT)
Received: from [10.133.33.169] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ebd123sm9431287b3a.47.2026.06.23.02.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:08:14 -0700 (PDT)
Message-ID: <7c75dc89-f62b-47f2-b5ba-63b9e91c9394@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 17:08:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: qualcomm: ppe: Demote from supported
 and fix maintainer addresses
To: Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
 <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfX0nNMo5vA4jSJ
 4CYb0sRgisIIzRlXvUszbHdrVwjjeyzpkHm7AapIwF51KZZDNvsXoUj0ySJuIMrjyUFgUcq35jG
 5vxGNijNlZ/oRoTl5xmWpig9k9G6OMo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfX+ETOEteBlDxq
 4KS4F42TuTzYP/6UUM+0jQpUlR1eG98xIOK+oK4ibbWFCXURAAhwlgG70d6ABBgA4zrRQpSgtHA
 sMTc7djk2TNePot9rmoW0SdAgJN3EvdNRQ9qBer2hGxsDfLPDBP1qYIysHLGoqThJxEH6QQgwB9
 s4TA5Ndb+5kcpCwIvKyAdwQNL4+F1JsJG0cE8bPJVwrX3ZTlqAVvv1/vCEWfkqZPBpT1HW4qBCd
 50vTvLhG5egVjgT+14uheWga0aNJ5axJVlp4Xb9L6AYDFNTeXrYFOhVbhjQUD4sw4QWxMbfj/qv
 pfp9vsCh4ViWrubyvT6Rs4WWXvrIzzzZvpbwLpJfUTw6neQYMQe/WqAxk8l5Nqj4/KFZeAyJfZy
 R9awvbcBHMrP+Hi3vYsglK0WbbTuqmqq1e1LAf13ignQ2GN43Yf13J0z7i2xINYSw2CR0TmYxFi
 WBES0//SACb8gswXmTw==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a3a4d00 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=L7gb0O4lDvObzA7K1y4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: M-T4rB0oMxE754HYjwWy9A66_OzJy6Xi
X-Proofpoint-ORIG-GUID: M-T4rB0oMxE754HYjwWy9A66_OzJy6Xi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230073
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
	TAGGED_FROM(0.00)[bounces-301307-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,quicinc.com:email];
	FORGED_SENDER(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:krzysztof.kozlowski@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:quic_leiwei@quicinc.com,m:quic_suruchia@quicinc.com,m:quic_pavir@quicinc.com,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28FA56B59EE



On 6/23/2026 4:10 PM, Andrew Lunn wrote:
> Emails to the maintainer of Qualcomm PPE Ethernet driver (Luo Jie
> <quic_luoj@quicinc.com>) bounce permanently (full mailbox), because the
> "quicinc.com" addresses were deprecated for public work.  All Qualcomm
> contributors are aware of that and were asked to fix their addresses.
> 
> Driver is not supported - in terms of how netdev understands supported
> commitment - if maintainer does not care to receive the patches for its
> code, so demote it to "maintained" to reflect true status.
> 
> Fix all occurences of Luo Jie email address to preferred and working
> domain.

Thanks a lot for fixing my email address and for the help!
Acked-by: Luo Jie <jie.luo@oss.qualcomm.com>


