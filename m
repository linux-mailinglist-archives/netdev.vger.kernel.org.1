Return-Path: <netdev+bounces-288280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHLbAvL2BmpUpwIAu9opvQ
	(envelope-from <netdev+bounces-288280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:35:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A07AE54D717
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C28CD3026E93
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB513D25D8;
	Fri, 15 May 2026 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJyvMM1M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EpjeT5Pq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D283CFF68
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841132; cv=none; b=RMFDDZYm8PcsFOEmLGTkt4SHctxca6muZzugvl07ZXtPKkwo97q7fyof5COM4gN0D0qWA+pog0fMHNY7iX2Vhd0PaJBxFQvdEmM7lqyqmR6ooQmQjuBc9RdN+WXAaHbb1GSnAmQOdZLQNwtJsjyH8aLbeL1E6pya6jbkopFZq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841132; c=relaxed/simple;
	bh=LaqNkBsC1aPqGZMmd9r+EzaETwzayMdcQqzUGkAYZx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKg/7NkPZ1Tk47NPobkdR5srW8zCPRHgnn93LJhSRFbyGbv/sbziw/FVubu1moOtcVdBLgDOUu3raNYsmVBGTFAwnCCSv/oVSHOUdw9QGCPFQZf3tMs96G36J+UGv6KdYD/AKTUDMwfvdCtTy2wf41PHmZ9fkJdIbnlL74Gm7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJyvMM1M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EpjeT5Pq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5ZZ3Q3219668
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7P5tIwdg/rLa4pPJy9f6dOdgWa9waugHsGuQ8JjtvLw=; b=JJyvMM1MhhPgRHma
	u6YC1THsAyKMKFu4juyXz8tWxEMCBJgCsohNlcAUWrvAUkG02qKj88x8jgrnAbuQ
	iAWc3YX9CD5AGjizW8WiR28hRDznmBZ1zxJb2UX1aa+2a9TkCvV9m4/dCvAhzXR8
	/85EG4NEuHqGZEbyKykf/wwGiDbMJfnQlD54A66ngowY+5apLcLnKWnqIe132gRs
	IYd0MQljCmNQbi1SpihvNQss9W565IMEwOsFr1kEMzZT8qQhPMjbgFh0YYqL6kWV
	WTxS/62TuERj34FMWWyyiPpWPIYuqO13qaklvmh96JiZoRmNGNKRSi8x+EVzAgjQ
	SgNmBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s2u07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:32:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90fef17f6f5so66088485a.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778841128; x=1779445928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7P5tIwdg/rLa4pPJy9f6dOdgWa9waugHsGuQ8JjtvLw=;
        b=EpjeT5PqIGG6WpjFj1QJ1nv3oNk52EtUiMWpYXMeERodPxbnVan5m3FPMC3vaVHfOh
         kr5+yVBIQB0y1C9ygSxf5NupRxRyIJzNeWRRbFGtjCkZ3dCyVLWZvoTiMaSCRA1OKftn
         WfT0l3AoxddpTusC10wqqGZcpes7ezomEunB7KsJ0ICQwESRq07VPIBtk5zBueKlVFw6
         OQioOenOcXmpYH95lRssixxUkn0nRSneXKH43xKzY1kJZ92UyklwnwXgbhI3iHGXd7/n
         QlVJ2Wk6BRPNREOHPXiJYY4NM/RMQXMh0iusjMgK2dL0DES84BCNYmxoVvXyDSruAhzl
         eS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778841128; x=1779445928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7P5tIwdg/rLa4pPJy9f6dOdgWa9waugHsGuQ8JjtvLw=;
        b=iBdM7EvdS0J2YgjJIuAxbcXvh+W6lDZRAjMeLA2HXYReDp7Bocn3u/XmIdA3Z6FqYN
         MvKqddLUwSBXKwLf3HV2ImTLg/tAHm0rBULzR67tXZqX0V+a8Mki1rNJscfdeL0UTH/H
         4x/RDWxjId+2bgoXQM8vcqsd6hsPesq7ohv6T0SlWqPXQqIqRykJClP1ZxE6L+19MWfP
         ZjxrjdcFRinRMh7dbrE/TghE2raeO4GCXUX7F0gLL0aqML7XQZOLnABLcMz7J7B9b1mW
         tgoEQUrz5Dn9bhQCFcXLfH6FxfzWNCwgUq9ryL5yqTtzFp0sc0YaZ9JSP3UtpdCUpXl4
         oM3w==
X-Forwarded-Encrypted: i=1; AFNElJ+ll5yrtMr5WrluqP30Uj2BgzO1V47iByfAzTNgGPSffOOnGqiTapUUNGaUsEDVWt127Mo3c70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgU0n/tFBEy9b4EBmpi4cuJqKckFdP4fPIjOJMINih+lo9weGn
	GYEuCYxoAR3+o/ENuNLE/1NjGWYPWgSbcQDUV8aE/F4T+vBt2FgzoDDY+ZhQc7SfuY9RVOmoWjE
	17goHDsj+1w+nPtFIayUuUlau4iwREdDXIf/OhSbysCXGIrF3CbYNVpaByPk=
X-Gm-Gg: Acq92OHcot47oyLAoCh49qGiU1gK8JgWs2rvXbA8qs9vzZErWTZKt289EK9ZfHbKHaU
	LwkW50GXo+iD5Oph3pe7FluWHiNY4dcpdTiz7oyQVlwGbwKnSjEkwpJuu9U8cBqT2DD2/Tm41pU
	ljHXekG8eCn2cHglRtIBZdEf9EYBG/bYHkJE4FI61/iratLEb2N18EeLbMgLf7cxA6mw8tSB8fs
	5P3tNAhjHb1Q/uicgTGKwHtEf7pcjzLhTSUmd9uSUGm9XnCUfF21FdHCarYbLYyhs9ALr5I8i5M
	4+J8oMR3cBwGaWkxaEL89E52KxvfGBb9ZML2LEP9rT/lctmmg3snn39xoIWcGQlKtFvKLDP8Ge2
	0ldpt13+Z9AjwQXWKCYqrNq28RktKyrw2ndacQG8FZJAEbpBajAwJJR3CaUzkom96AYf/4V6+OF
	2p6ruzVhq18jvbyQ==
X-Received: by 2002:a05:620a:701b:b0:8d7:3f45:b95c with SMTP id af79cd13be357-911cd9560b9mr374352285a.2.1778841128201;
        Fri, 15 May 2026 03:32:08 -0700 (PDT)
X-Received: by 2002:a05:620a:701b:b0:8d7:3f45:b95c with SMTP id af79cd13be357-911cd9560b9mr374348485a.2.1778841127788;
        Fri, 15 May 2026 03:32:07 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b4069dsm1798256a12.1.2026.05.15.03.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:32:06 -0700 (PDT)
Message-ID: <7d84ca2a-9bbd-450e-a531-a9b2bc227cf2@oss.qualcomm.com>
Date: Fri, 15 May 2026 12:32:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] pinctrl: qcom: Add Shikra pinctrl driver
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260512-shikra-pinctrl-v4-0-b93c3a2e4c08@oss.qualcomm.com>
 <20260512-shikra-pinctrl-v4-2-b93c3a2e4c08@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-shikra-pinctrl-v4-2-b93c3a2e4c08@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNiBTYWx0ZWRfXzLBLx2BUoUvL
 FyZnfnTgG6Qp11n/Jzpu7r/dRVlX9c6XNkUuMHz9spn50oVKuT/7Nib5T+1jGnnoHL8fO+efQyc
 ZaJyqSWE66EJVx8jBn7LW4OK9roBSDXs8WfZiuYmQqJmIFKAOBQOFOpaz+sRDDJDFZE+MVNxF99
 0LNFUz4Ds69pKn6336jLrImXBHYp8KVLGuM2OBTJ8W75ALBGJcJo6edvv2L1TwyECA6BtyNEK+J
 1uVz52cL3IMtWCd57eCKEafmsRjRSEm0vRsesMIZcR5j+QCCVCfVgWg0qq/5mDkQ7qCRsfXz5Vp
 GadVDSZmTei1ypFpH9dGzU+TYYLa8oJw/wcNgWR685Ltq5mhxXoPtCcDO8yD7e6MxmXeHRrpKB9
 qXqaFnYCA2NekYTumiD6v89eRhnVcIrqG82/2AnL5hnNbiC3liLa9WbfwxcuJtgSXHrFQcYmLc4
 zrZnAmMMmBFocUobH/w==
X-Proofpoint-GUID: _rsYCm1NIo3VJTlKQwtzqwEtn5jRcLvB
X-Proofpoint-ORIG-GUID: _rsYCm1NIo3VJTlKQwtzqwEtn5jRcLvB
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a06f628 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=NVK-j4C6oOT1ijtQxEUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150106
X-Rspamd-Queue-Id: A07AE54D717
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288280-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/12/26 3:25 PM, Komal Bajaj wrote:
> Add pinctrl driver for TLMM block found in Shikra SoC.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

