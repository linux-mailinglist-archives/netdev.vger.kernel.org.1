Return-Path: <netdev+bounces-269392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHcEKzbMu2leoQIAu9opvQ
	(envelope-from <netdev+bounces-269392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:13:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A52C94CC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20771300E27D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECDC3B3C13;
	Thu, 19 Mar 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hcTKvR+0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HP3tx9z4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A13A255D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914979; cv=none; b=ugarUNN1sfDZyTEIH9rXzu6pLt4tac2xBPttAcBq2xb9PvKI/HQC9X1F+aeHd/AYsuoo0Cr0GUnmvDs6mAQeYfnwVhrYVxHO8cTHYaqcFufRYzmOzx98ed5zy4rx6unlRs1oJbXDI++pb2m+SXrMqBpyXAO8DXZdcOHg6gR7sRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914979; c=relaxed/simple;
	bh=pUS8KrWp/+SVlBZUCrdm75RxAa0Q8LjZVfSG4rhlrN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGib17GDmaFFCHcf3zHNmuwyQ7wAcBpnnE+XOTigvS8LgkAuGSGGJlh/olmKw+kH9tqbmUXhCCP5FJQwIpD7YpT/vVyrecyjMSIlsopnf9IfE4R7iRGusPqbnmp9w4QL8/BuApiDAoUWN3kDwbldlo8lrToxM3SS39UxGBiQThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hcTKvR+0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HP3tx9z4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J74FR03772533
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N8mxSfzXNyJfRBoaEQdvz7W4Ia4Ks0F5EAbj13/rqrk=; b=hcTKvR+0CZSQmyRH
	E5MJdOoMORZkt8RutJZE9N3EduJrPpl9OgX1etw5ZQk/WQijVcRYv5QPM++nNaja
	lGnrh32GYZRFt8Fh5h9T3mZfabO0DB4ahegsnRE9ptkh0nJGOPQRTHDckCU1dBsq
	nwk5RuuErkoixgJ9h/WikNvamxST4pIhZcpRxtNfUyIRcdketVqM2K6e4qAKsr8x
	tnozskWT9bsS8fNuHhppJgo/djWubalN55/voA73pqeehqNqVBHHnhXG1p9qMASl
	4a9BPmFeZVEd7CW5myQjRmXB1PECK5h7LCPYj2wgj2jDMMGc/2FjzYdX6r0VSpEv
	p8cIUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r9b0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:09:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50947db2e97so6178141cf.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773914977; x=1774519777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8mxSfzXNyJfRBoaEQdvz7W4Ia4Ks0F5EAbj13/rqrk=;
        b=HP3tx9z48Me4vmkuR6C+f3nve9blq81stz3sL4k8yLFqwmqMAUsmnsisAmrvmOtP2d
         vzymzu4UUZ/6SN0kJd5jS3NGF/iQTvMM9oCwP3MhDgrSMfw9aCzE5vKueuS+Dp0ucAmJ
         GNbpsDR49dRkjbdJJo2l7RWgCAm7H2Axa2FSFWOW1BUoXsy1d8HIFv6+whsE37MFnyeo
         91QSUUcFpiIY2TWLiu5poZMZidqzgTK4w/r6ajT8vYy7uZlcopkUoc6R+/WA1MUvWeC8
         C7WCvbx8T65j7CE+RhG6tVztcXxiwlKhWTBctj5N2X5eVRz/iwmnggjbjmaWBwrr/hPo
         f0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773914977; x=1774519777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8mxSfzXNyJfRBoaEQdvz7W4Ia4Ks0F5EAbj13/rqrk=;
        b=TX4XE76s9ADqfeXXUYStM9JDkGdaOES1I9XlSediS6N+Qq5GIClJvcD/H3DijHfp1u
         g5VItLkRovsEQTAdOeMQaBjYFEaW6gHG4GQweAqERSrkFHgxhWq+XMoxXe7kB28oDRWl
         zd7PRkewNqREthDD0nztsKoeGcTc30/tvLmGGeCIgJ07xLHuQ/0UXN65cOlwEbZe9pGm
         bRj/KMWt8WPieWYBvGF+ngqJo2a8KZwedOqB9v7PSTq+ukf9FPYGFYzStBX+iAk7NDvP
         Vd+XOtfMLZK9Gp0TsS4fPvISIRatjfyrZbKj1fvgdVNfkqxR4adFE4KsqzLnBeM0r37a
         XewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEe83A1pVUQUZqcQbSTLOEXxDck8QT4v1fYKRpls95EOaHn1mdwthrrvWOjH0yji1fUcNvXGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXst2f+SChpIP4S91wwQuiN2E7/x7xPmpTV+qQPRxpXU+GH0Rf
	kBXqd1zrHhutsneoyoFLOjz8GboTHS7ZC0YF5bVrhnD67eJvOJQ/Oq8pdScsXv2BqintxcggWnN
	77wyZcSiXrgJwJ7w40nOcIkVZi1V5L5xIYHoxS5otRRCMgfL0fM9wigAbL3A=
X-Gm-Gg: ATEYQzw9tDg04L3WIJihS1GvqwF/SKjEHqtYFk3lwBHE7m44vzfSFd4eb7KuzI7Hi0O
	YSHL7+crXaF/mFQE/otU8wy1vb68JNHQ4iS3amTbL44nSGX3vfx5D2jQKspevPt2KjvBIxI7c9a
	xLikj8WdbLjnVGHeLYyp/wPDkU+A6LvDdP96745VKhqvKIRBQW34ST07EKP6oyms85HlyDfzlGN
	3MpzmfCtAZ1NrVw2SUiIF9jE8FUNcKyqv/eGjEu5aJYA8LxckYT27oBovoqQH8eVrrN9AK4SX22
	UDLJR3nn6SQNlUGYyDdSBnyckzfOiRe/vDp6hoUtvJLMuOcx+NWZIiFNFc6i9AT8N3dYhTMUDYT
	6zT6Ntz24bdIc5bqkxEI1sv4TK5ybhupJ2lf8WhEzKFTg+y0pdrQrBYhLZ39tJaAyPiewu9NwVG
	UjuT0=
X-Received: by 2002:ac8:59c1:0:b0:509:38b0:c44b with SMTP id d75a77b69052e-50b14866da5mr65080931cf.5.1773914976676;
        Thu, 19 Mar 2026 03:09:36 -0700 (PDT)
X-Received: by 2002:ac8:59c1:0:b0:509:38b0:c44b with SMTP id d75a77b69052e-50b14866da5mr65080601cf.5.1773914976161;
        Thu, 19 Mar 2026 03:09:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6688b67aacesm190582a12.11.2026.03.19.03.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:09:35 -0700 (PDT)
Message-ID: <7566c66b-2dda-4b29-b59e-4e4a7e159e21@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:09:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: stmmac: improve PCS support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
References: <abQC7r38QLhSeadl@shell.armlinux.org.uk>
 <abdEscs44fU4kRag@oss.qualcomm.com> <abdYu864OmNWiWIW@shell.armlinux.org.uk>
 <ablpxwGks9m38fhM@shell.armlinux.org.uk> <absjNQ2s3Z5N2Zwo@oss.qualcomm.com>
 <abtE7sDT75I7uPnk@shell.armlinux.org.uk>
 <abvAuHFZzCFobO-V@shell.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <abvAuHFZzCFobO-V@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j5M2UU1CBDWvOXUfaQqWBFR66pniAzs1
X-Proofpoint-ORIG-GUID: j5M2UU1CBDWvOXUfaQqWBFR66pniAzs1
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bbcb61 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Gtcge7hCmZdjPOC0CCEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA4MCBTYWx0ZWRfX+cMl2xQsPUkD
 UqHyh5xThvt2d8KzFGVKrrRp0H+w+kJPYOBX8xtayap+Q5PYbM1O5OITelIGEDqTrQbr1NAkkFg
 hhVy2fZVsWv7ZCevOEuBzHX5i9qYwnI1UTCRMCMYnN9JBK5B2SoNdDjzRm5pGHrU2F5DWl9RcMG
 rScH3JO7S0gzeyPrMVMhxNYEatuB4oj8MDVQVcgqJRPn1Sma+uIPWAKVzgd53kpiLrG6H4QeiUX
 LDtjY4uQ38jig7QEIsfgWdoGIpPtxe+5kvxmSshK15+Pmrk9e4GjqbTURSx2aFQRUMsfNeoe0n1
 PTYgar9Tro8LjXvEVzm/M+DEWp3qOT9hIEwqtNCSRyQ87qpxXHawFOZKAywJRVfmqx5FNPJ5Toe
 LtSOfjoP5aYlKqeseeiQGvVpKyo2BBG7w3bHIbVO+OY/SMRDk+oe70hVPIBTph6T3khq5hY1wol
 5vmUiId7+6J4/L0ekwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190080
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,qualcomm.com:server fail,oss.qualcomm.com:server fail];
	TAGGED_FROM(0.00)[bounces-269392-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C3A52C94CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 10:24 AM, Russell King (Oracle) wrote:
> On Thu, Mar 19, 2026 at 12:35:58AM +0000, Russell King (Oracle) wrote:
>> On Thu, Mar 19, 2026 at 03:42:05AM +0530, Mohd Ayaan Anwar wrote:
>>> [    8.650486] qcom-ethqos 23040000.ethernet: clk_csr value out of range (0xffffff00 exceeds mask 0x00000f00), truncating
>>
>> Please look into this first - with the MDIO bus operating at
>> who-knows-what frequency, this could make reading from the PHY
>> unreliable.
> 
> My guess is clk_get_rate(priv->plat->stmmac_clk) is returning zero,
> which means we don't know the rate of the CSR clock.
> 
> From what I can see in drivers/clk/qcom/gcc-qcs404.c and
> drivers/clk/qcom/gcc-sdx55.c, this looks like this case - the
> struct clk_branch makes no mention of any clock rate, nor does it
> have any parent. From what I can see, neither of these drivers
> specify any rates for any of their clocks, which likely means that
> clk_get_rate() will be zero for all of them.
> 
> Sadly, when I designed the clk API, I didn't think that people would
> be stupid enough not to implement the API properly, more fool me.
> 
> Under the old code, we would've used STMMAC_CSR_20_35M, which means
> we're assuming that the CSR clock is between 20 and 35MHz, even
> though the value is zero. Is that the case? If it's higher than
> 35MHz, then you've been operating the MDIO bus out of IEEE 802.3
> specification, which can make PHY access unrealible.
> 
> In any case, please fix your clock drivers.

I'm not 100% sure the currently-passed AXI clock is what we want
there and the docs aren't super helpful.. is there a synopsys-name
for it? What rates would you expect it to run at?

Konrad

