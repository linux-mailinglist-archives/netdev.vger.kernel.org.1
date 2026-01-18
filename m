Return-Path: <netdev+bounces-250821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D6D393A4
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 10:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D4CD300FA1F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A02280325;
	Sun, 18 Jan 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcZcvxGW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KKJShZ2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69138286409
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768729604; cv=none; b=HAOCAraKohVLdIiSk2Ol2Jr3qP0P24ubFxK3g9ODZ1HycEHXAHfNQMHd5VlKDaoaLZ5i6CGSRAegTd/HK6pUWzzM8iUtOs/xkf1oeGN7iWrfElphEmwQNCgc/ByFGLpQgrlLJlr5fKp//6lPRlWm/cQktNcrMAKwUaiwAo9jFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768729604; c=relaxed/simple;
	bh=EuS9AyX67Bd5hrUuQDV6F6zYH9aVq79/gfsJPlbg/i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT03fGr/HvNwvGxwUUiZpD3HYFDfPCXw/zso7jRHRhs1iCXDeyj/FzeJfjE6pMje4RuD2CtdQvPrX/URgnSsMogtQTLrmGNGHg7uMDTGmSNwZ8ucFNMeLuuI+rD6Yblgg/nsLd75wRAL4wBk2rbgOXYhGqi944Dtj5xCC9N+9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcZcvxGW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KKJShZ2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I2wYDw2119855
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CLpb85hG1DwP1aazprj8nSeCCWXQcNxg3MGRKgXKrYM=; b=GcZcvxGWhjJrzdAI
	6U4fiOmfNW+LwRTQUZO255EkNjYU7MdBWaCJVM97d0sgyIHO3kNsoMUlFf7g1FL9
	2C4KzprN1Z65Sd7XSR+wDak4fwGZqaqSx5YOUK1yBRBNV29Qm3tjG88pkzBsQ8NQ
	YdFS1pObuWwkjMY19OtktRmNeFFFkVa/Rb4A5H6dIWhshszSLjH5nzalZj+cNFc7
	xIAj68jv7erw+R9kH9N4WbZD00cZHRtYLNArDDXWLvW9tq0TIPdOBA+22MSJZA3m
	Epi/DXrwpgGJSVUHo2WKZ7r5x7ImW+ucrQncffjJnVM7Axtb4unFUmBKVFUYKMuB
	YX6hJw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br36da5hk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:46:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6b315185aso385124485a.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768729601; x=1769334401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CLpb85hG1DwP1aazprj8nSeCCWXQcNxg3MGRKgXKrYM=;
        b=KKJShZ2QhTSliEW00Y9tgMMy5/e0+3klgWvZ+mqHrK5NUGNwiPuM4oF7vxe+26E5c5
         c9NgDGTJ2K2x73bY7bsCgG8neKFe5x1N9KC2T3h5YBDeb/6NMEGNYh1XM6/TAUL/3Ei/
         5HMDgngnRBLFXunxLKbeUt0DlU/azhOdJJSW0N6JOxQ+sccfM6IBZrIFaA9X/UnANcut
         Zw/j7haN3lIGPQvxPUpH9jcg0C/6x79beYRyf6ixC6iXqY3Zwdx9zCt8Is1WOhTwOeiw
         vVD5U4/j111u6ZmoVahQ2VlYVcB+xZMiqDg6xELN8/HAcfbcF+xRkvITRyrGFXksmVZR
         rP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768729601; x=1769334401;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLpb85hG1DwP1aazprj8nSeCCWXQcNxg3MGRKgXKrYM=;
        b=U8fljTDC+spu7zlkaGB7IXAA7jQD08UUgCsPgR7bn3r4hdtEBLnjkkttw9QKrI6x8w
         5S6yB3Bwu2a5Yq5RNQEHBL2L3DSfvgXCHabpkatkI7J/9yhOw1EIVWRIWN4bp29+N+Ze
         PkLX3OnAyK0Zq5GlshSH4lzofSu2ue+AVeT9fL0cqbJG7qEr9NqTv4pD5vZzYCKZIN0B
         /eMNLJSNdgOijKA3x7Z4CgTVCn0omDBBMr2E23SA8HblGtgZi2MBHQ6Yhr7NropNRkQ8
         x98uMVoxKoTO19GP/LYeYtbOACNyg1Y+X9fam/gHHO1YyNZXwrCT5Uj8k3EWYPiDB40a
         K2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyv89+fS9J1EkU6XhYMV6c7r+401rSTsiu+xofDVjkI/f4/ibF6bEMuoWMauAejacz2Y/XaRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6njNBitbttAbhGdJWSOvgp3v8DqxtnNEgDLcN5yQloGpp42jZ
	ymwX3X9cg5h1m9Nu7/t+39NozpKfmQtrGrKLAPhayAux46JPuixYtwKUhf6TlMbbAYX71hkg78P
	R/6JFS37Q3Mig4Vqot+dupCDKEa4oTLK7wklSX9Lx5bPNAMrktavW0Qf+kT0=
X-Gm-Gg: AY/fxX7UQ5W0WhQUHql7W3K82V7TXw+s81zSvOLFNv3eRuvgLUi3aCvj/POZ01Xkm+i
	TKcBAj4C3j1DPOQqiQqsvjMK5CrAYNJc9G3edHso2oEQvQtNqxfMvg821wr0ovEUYyh4uZUxsoa
	H4wwvD72a4QQ6bCx8qsfhymlyRuWe/Ubdir0UIW52EQCQ/ZXhJgeSmn0TVv3LLIDWV2pOur6doa
	uOIJDSQZXcvJMTY5BxJfXfppfLvfneLe6LfEmr3Y5jrXg8K0wm+4QRJoep2BLFDrXWa1ZJjwHpq
	92cgoCZs0zagy1jIm4zjpSG/zfl0FRRwgdMljCnpO6UlKHVG1oow1PC38VrNJ1nelr+vlim2CA6
	B0TahlJlMcRYUC0PLtiJrHuGtMEGbHApvzl1vbg==
X-Received: by 2002:a05:620a:44d1:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8c6a691f5b2mr1150823385a.39.1768729601635;
        Sun, 18 Jan 2026 01:46:41 -0800 (PST)
X-Received: by 2002:a05:620a:44d1:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8c6a691f5b2mr1150821585a.39.1768729601208;
        Sun, 18 Jan 2026 01:46:41 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm190297425e9.9.2026.01.18.01.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 01:46:40 -0800 (PST)
Message-ID: <b6f5dc0d-b008-4c09-b05b-c7d2f125148a@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 10:46:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] nfc: MAINTAINERS: Orphan the NFC and look for
 new maintainers
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>
References: <20260116180535.106688-2-krzysztof.kozlowski@oss.qualcomm.com>
 <20260117143744.61cb18cb@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260117143744.61cb18cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDA4NSBTYWx0ZWRfXx/A+NlXWwf30
 GdrqFSTM/NlKkTWqXjSEg72/7VV/Tl3g/aJHu8s5Bg6ISieMhV7kKEVYd6fPB+8+vO6l5x6ynpi
 ZZ7p/ViyLy3ILsa106dEsWb2BzaNI+R2uY2lYLNj3kzi0ePDTAhQd1Du8pgMcKwLlF1+OtXYNEL
 i6RMGHGe4IZrhoqi+o4+XWIJmvZpH1tq9kCUF8s4yXzUukKLbgVA/6M+PJCZo6ceFm8A0mJEu0W
 rtgWrewlWfmUbFkVhD7L4Wa9OFz9omW3upcYb9k/Y6atHI5Yi6xPcqPZfTwsSMwCoodA3aDPvkB
 aYF4BQaOcTSrEJpnGrZPeH5UucydoP4apwlbnZ8iUOHNuop7rAyd6di1ok8hU84u6dmxkAUirbL
 WMbqD9ahMlnEPqk3uUv4YCm7mH6RIz+WAls8VziTE5FA/NTa9AVmV6ew0Uu3y35NCs+yMHjN+eR
 BvOipK8DXcCDsAgE12Q==
X-Proofpoint-GUID: SPGMMqm4eLuGAR7860EEOloFnJ1oA3SX
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=696cac02 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=irzBmTCmRLH8eAqSxW8A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: SPGMMqm4eLuGAR7860EEOloFnJ1oA3SX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180085

On 17/01/2026 23:37, Jakub Kicinski wrote:
> On Fri, 16 Jan 2026 19:05:36 +0100 Krzysztof Kozlowski wrote:
>> +N: Krzysztof Kozlowski
>> +E: krzk@kernel.org
>> +D: NFC network subsystem and drivers
> 
> Thanks for all the work! Would it make sense to add the word
> "maintainer" somewhere? It appears that folks who wrote this
> code are not listed in CREDITS. Tho maybe in this case the word
> "CULPRITS" would be more suitable than CREDITS :)

Yes, true. I'll send v3.

Best regards,
Krzysztof

