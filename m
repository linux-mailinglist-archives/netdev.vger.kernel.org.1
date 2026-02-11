Return-Path: <netdev+bounces-258378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMeZLrELjWkCyQAAu9opvQ
	(envelope-from <netdev+bounces-258378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 00:07:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E741283A3
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C5C3029F46
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC56353ECE;
	Wed, 11 Feb 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZLDvdE8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chxAjLzD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1322A7E9
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851244; cv=none; b=Cuz4JZQK2SS2JjAz7qWxDTcKvF29D44JUM3TMRQ7g+7LHKMgOZeHViKSc7zgjj0tWDKqs3vcHAvri6hPXOGS1f90nJ3TwCrseg0ohQCrluwz5rDJ/gry7OriIsmvhLus89TJKxE1EACttqI3MQYalwCC43P02FDCG5AYnIsLNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851244; c=relaxed/simple;
	bh=Yzg/R7KROIZWNTb/Gf1jUQr/UCGFBKqVzPPrSnKSA0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWJSLWZaM1TNqSfKcC9sxRyLZmxrqv1nEQl909/f5qa/T69TjgWO7gtmKigxAPkC8ZINsMWdIWUGXzWnH0GRr8i/m8Wm1+FF+LVPlmpg3pLRfkQAzMPlVuWwSs+KSeTQQuMdFzKOF12ngZXLT00gKH6vKjie+tAeAs4w8LcWcCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MZLDvdE8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chxAjLzD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BGVMj81951210
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 23:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZpN+I346fUVYue3TiuwfSu4EN1Ix2xrT5hADCfjP8mI=; b=MZLDvdE8Ilp/4yj4
	pmlAeMkrWt0Sji/9cT7QjRIbHr6cagxkZxFW5ThP0ENuGeE/2hJu7b7cKIXlPJEd
	Q8XSq1lEoryUH1Qk3pCG3Vp/GAHmc66UojiL+BRwd0jV92YsLCqdjaqJIStWRzr7
	x6fetbi7HS5eoSYmWz+BF5J4mcR8vvLqqECsDqWZLfixq96rmlMFYhXi6ov2FbBn
	Bk/5n/v7/hJJ84NaXpVU/MFl9ucA732rOPVsJn1t/+dkG5wyJFoi/XhxJhtP/DxB
	jlCZHqVXtyxQPzumZaaLuKx92uJVUCuzEh3GeUszaC9QwOO/xrU14ylHtD64ZgRj
	RndkKw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8wc4s4ru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 23:07:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba68ed568bso1014545eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 15:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770851241; x=1771456041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpN+I346fUVYue3TiuwfSu4EN1Ix2xrT5hADCfjP8mI=;
        b=chxAjLzD7rYox+S9NpWUOn6SWuJAW6EHDPgdBQFglxEckKjEItyU8dsStqBIasY98n
         suGusTM/fNgD/HhmXwSKjOxaNcNtq8fuUWkGmh0WM5fSE24gYLWzPgv4Kw+meUCpjHnr
         D/p9Cd1dcaTrDEBvIpb+o9ICGDSez/3ynCr7sUpuLJCE+q94xsPfmhYAJfloX+8GsJEO
         C6H3GmTLp6grS4vsXEr5w0pH4C5gWajQj3Dro2C8aWjpawvv33XfIJMFX6apA3wtl8xh
         zZZtRtjxl8ZtBUFqwcviybupJ95G7mJcpNYb3PG1/1LXykR0IWSjGrZxph0KPnzdTYTr
         LS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770851241; x=1771456041;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpN+I346fUVYue3TiuwfSu4EN1Ix2xrT5hADCfjP8mI=;
        b=W5WLB5dZIV2N8OnuaKucnZ3Ax92auCU0DTYNa7q4Ag6lDfwbyNkbi4MBBh11MbKqW4
         iLxPyNo2vlGurwkPjmU4BU32YSEbL7LB8mjBzZFENfkbeVkfqCWgN7lS+3Nzz6gDmw27
         5+fG9PX+ZYQwZ5Lzi0elTzej4pga+RevzkLi8CStIOmYudV0HdXRrnKXkr/mLOhHbMQv
         cjS4dgWxBczvNeDr9ImyPU85bPjXTSv96fRw2eLVIb5DTRVPdvlSPcFJYgpk78CypbPK
         pyLV2xRJBF83u3LNJ/EtPyW5G5UwL9PZQMcOCxiN2v7pvRhRvh1MRjt1xv7PKrog+1fC
         quUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp6fnBavvfEHq5d5QG+kbM792t783EToYsr3DXgSjt/G9Spt/eLyREP1TyIFHHd9p9ayFPN3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyik9EgOeHKcNsipaUnS/loA4IryBGfseuoQXG5hcGzBgO6P9BB
	7j3wugjw0xQl1e/I4dfR4Oc31PnKcy+72sZQUCzTAhsY0sE4MRSpxXxyX99QBQ8jXZlcwNzvfMc
	YVo595iH1226Z3GRcEW1SoYKhTT9J+J1x5ln8giUxrA1TV0zsUjvVni2DF4s=
X-Gm-Gg: AZuq6aLcm2u/qkktenL/BsfgL/K7AjVkOrZom6JSSO8UK95EN6lZU74XF5wgkniyvWx
	7RbD1TctdNb9K5mJqfxQQ8cuK38UQj7WpUcUNlLCXanf1DS59hC+nb3N2wjGRlyyh3xB5x3v+GR
	c8/4UMar10XZRb3RTnw6DlBUOz1y8zXfhARyB5Igyc2XNGwPKqgR0mve3HmwN5lKYII+DjilJXH
	O0JwLQovgY/M2RAdquV8szZcJg4Y/SIiFIZLoo1fKcCQteCKEPvRUuuFV2e09KPybsag1oSCQ09
	x4H4nKilgxvXepO3fqFURHCjJUwmPGuOeClRGSVJ+Xc3VaKCgqlndXkdhc7PMAV29fgjdzuKLTW
	HdFFLN3xUWVR8ZwWZjXnjRTTQeQflPfR1P5uGZUncBmDq7Qqj2a/vNRUFCOyQKz3vcVnDY+Yt1q
	UIpWtdwWj3s04HzQ==
X-Received: by 2002:a05:7300:cd8f:b0:2ba:9fad:8fc4 with SMTP id 5a478bee46e88-2baab6f4597mr251516eec.5.1770851241140;
        Wed, 11 Feb 2026 15:07:21 -0800 (PST)
X-Received: by 2002:a05:7300:cd8f:b0:2ba:9fad:8fc4 with SMTP id 5a478bee46e88-2baab6f4597mr251496eec.5.1770851240567;
        Wed, 11 Feb 2026 15:07:20 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dbe127dsm2151263eec.11.2026.02.11.15.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 15:07:20 -0800 (PST)
Message-ID: <76e6b68c-393e-48d4-9ee5-9e8d511ab308@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 15:07:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for Linux 7.0
To: Paolo Abeni <pabeni@redhat.com>, torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260211173015.327542-1-pabeni@redhat.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260211173015.327542-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bEXATbLc4Yht3bwjmDoDf6MBqQbQW-V0
X-Authority-Analysis: v=2.4 cv=NrLcssdJ c=1 sm=1 tr=0 ts=698d0baa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=qNABUOcEAAAA:8 a=VaXPDn6nftydSaR212EA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=Ytm653ucTKQjCvbzLygB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3OSBTYWx0ZWRfX52GjRkrKf/bp
 n/3AkBhzFRPwDGJCOblbEkPLWNk5IeXvgRASw2bNdMo9Jnj/TysC/NofJSCyWSneGwwy/6B579t
 SljMSSHVYtKyylySsGruD4XJVZ8TsZTToc8sXYTIaQnq6jZG4e95puB8xmlP00xEMCkRehZn0mC
 2VGly/rgJ6hMyb8kwqlTfipkz0p4GW/WmtdqH2Vbh4GpNDCkk/KptztEYncAFAtgKe7JVO2gwgE
 7+XHdwMuydDCAyN7N+lapoFGpXRbw7rYszYxbOYHdhtEu+oeEoUoFpue+eVMuGi0wMVEB6rYDsl
 QrHVGvSlhw/KCnxvFnHHJ3dXoqsBdZkgqpG0QnsNKVtWQXKpQwDzTx8cV0wXMhP+uB002gseaSG
 5jxsZ3ZsEBpuIc7V5u2c2dt9QWfKbYTZIkjaydQA1AdzdM9D9dG+aEZ+3nw43mvchJSZ+4n+ZEv
 vBJu4ciAS9tOXF10gWA==
X-Proofpoint-GUID: bEXATbLc4Yht3bwjmDoDf6MBqQbQW-V0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258378-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: E7E741283A3
X-Rspamd-Action: no action

On 2/11/2026 9:30 AM, Paolo Abeni wrote:
> Hi Linus!
> 
> I'm not aware of any conflicts with other trees, even if this includes some
> changes to printk for the sake of netconsole.

There is one conflict between the refactored ath12k driver and the char-misc
tree. This was correctly addressed in linux-next:
https://lore.kernel.org/linux-next/aXD6X23btw8s-RZP@sirena.org.uk/

/jeff

