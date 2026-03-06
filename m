Return-Path: <netdev+bounces-264942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN3iCp1Oq2mHcAEAu9opvQ
	(envelope-from <netdev+bounces-264942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:01:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA12282C6
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7AF3011F33
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A677369232;
	Fri,  6 Mar 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LZFxCCUn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eO8Mygg3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864B2D73A0
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834457; cv=none; b=SkRwkia3NsyFbK5RQc7fi3yDfeuXdDZMOmpfBsNjrM3WmgQ4ii6LIVu+VDbdDDeNpNVPUqt74HzqFXnmAB7kzUZRxyBen140hBuV0v0BjBpzaJk6EbfLC7/+yTqdN5cSLiobvU4mSSy8dl9heQEiMVlsXVtz9YPpEW0smUltLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834457; c=relaxed/simple;
	bh=swHjPgms4MZhnC7AecoYqmjnZlbvr8+euga4dr04mLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kd5PMLyc30h7KubWwWNwdO5cMza52M/ei678CHi91dhUB06S8WRpZFOBxkWsA6R8z7Vf3AMfvJwReZ60pndjVCeQrDt8qeoySDCF+ElDTUQKHAqDKrqKf/z30TlH0sLEAaHwWbyuCG5hZYYuQYxqnJmuSClvpHmPCqs50qH5ncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LZFxCCUn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eO8Mygg3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Kpmuq1863799
	for <netdev@vger.kernel.org>; Fri, 6 Mar 2026 22:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gYR9JUD/FzJUCFovVZEtzoQZJUM7b6CyT+PGPqzVdqg=; b=LZFxCCUn6WpNEccg
	RJnzb64jVXdN3+LfB8r8zhZFKZvCxW7dwcQdYCpWhoWQ5zLxLUR1MJomYdDYFV7g
	52tgon9P+7hTkEdj68q9W2y7TrE9cQcZblIsqWVLvUR4AykkuAbEZdh0MT9gpOUz
	yn6Ebl0mn+fs0Z6dg+vdt16RUdTBDUpiWWvlf7fRoTPE4pboJgPsI061h4SS/io3
	Tp1FjnM5LfCpfd+0/fC/vvDevcujlhfid2NYFvI4lIa8Tutb81vWpz2IIkl66HLU
	0uPflehAB6a3WuWNrav5pU+XcrN8ONqkeOcPSYbv0jhXD6lYPAb8BSyHjYt1piO9
	kJQLhg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr6b1g65p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:00:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so8701513eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772834455; x=1773439255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYR9JUD/FzJUCFovVZEtzoQZJUM7b6CyT+PGPqzVdqg=;
        b=eO8Mygg3kPqFk0I84wo+zh9D1d0rkw+Bh7Fb4llZJq04ZTV9f9sH5scYC6qFp8UVwo
         K4IS4+e+GoJGU+FeIzdzV7FC3U31O24UCXruhFQmkie9+H7SKeBvEPNPs1HL1JftqTeh
         0Od0pFGRw0QIeHdtv6WV7bgvqZ57YkLzB8Dx4YTpXJouYVuhWJsmFxu1hpMvarq3J9d1
         TI3ioEDCnqh2RrLp6b5oa6IzZpApCFd97pQnpEe1/oGS8nJ6WzmaxrFEZnnn7mCTu6vs
         9o5e39ZAy3icPHc0Bd0VAM47zhMHdobIVHBsvZTi33cxOba2QcVk/y1vXrdf3q7NuNXS
         C7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772834455; x=1773439255;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYR9JUD/FzJUCFovVZEtzoQZJUM7b6CyT+PGPqzVdqg=;
        b=XKMr4y4HrJlgYhmc82mJLMCRezuYdfR0goue1iwB4B1OJ4xdogpvI7i1Lx5/WbfL6w
         VaG4BqY3Srmt3rLrAkWphvD+EOGpPH7i4tv05Oe3PeSgQq5UjRFyUeypEmho5EW+lPdj
         MVvlycBkuInqDRYQdN+pgIIj2jToKhHNf3v7C73NVhTemf2rmHQ3tFz9NShN7GI9VT2j
         eTzFhaLYQm/n90v7yy8pvzqVHzWlo+/whL3v7InR6EfJZwIwmS6Kxk5kGCQT0itvFpD8
         WZK03BR0bxoXDSn2QLLHbIack07KWQNBCTQ2tMrc11+u5upMRjX47jlBsASpIwDJdm0x
         8Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCW3A1KTuprnpdq7/kapoz3fC5h0zOtULE+97bJvoC5PVo6qSJA6WjDa6aWhdtOBGQQwsU4G87Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkyPfHSc3rPiMQJOjFhpR6GG6lHfkBoS7EZ/FglvIGa98fEeB
	i1G8ZY39BR8dYPAOlMedEVWZX0L7/7afDPrp4byUL8vq/2P+DoYp/RnoUgpsMw1w+oqD77ru4Ir
	ad90SgYtS7ImVQ1FiqaKnOE2Yh+qzoAPa67rCqJiKWnqg+K1ga4Eaug0a290=
X-Gm-Gg: ATEYQzygD1h7Q/LcrP8J/+PsTVd+jOXadA6gcK6cAf6H/m0t7QE5QdAnd7e4qjJQWM8
	g931+3mHP6i1TzQQHE0vF+m7eNrAeDfH5yNBCap6ANVKhG29CkzL/twbDR9T44erbidUryFGa1I
	xzBilIHgHrQYisjzrabbGQ2DS8E3JSUlVcy4jD+zLYmThdjkWnHPh9aE7Es31mcfHUF4r3AXXuK
	WUi9mvgJEck1/dFOwbjvhfLGaF9w8GovrcmJK2nmnlOOyvYvTWLV9ROBynHjxUyNGUHtrwmtcsx
	24ciEmLQyA9EsnX3ar0Sz5eWLiPpaMf9zLZZ0eS8JK6xT1KZfTaFOz30wyHjOKd2BXlV2iTEb+M
	x4iqTuqrbLwclSceTMSYphtl8Tg4EqeewmvNpOFoqHoocFc500uE98GR5Ej2kY0n5mkqClmjg5m
	JVfo2lUwyxP9knAQ==
X-Received: by 2002:a05:7301:608a:b0:2be:1946:8587 with SMTP id 5a478bee46e88-2be4de8f969mr1272712eec.9.1772834454908;
        Fri, 06 Mar 2026 14:00:54 -0800 (PST)
X-Received: by 2002:a05:7301:608a:b0:2be:1946:8587 with SMTP id 5a478bee46e88-2be4de8f969mr1272665eec.9.1772834452873;
        Fri, 06 Mar 2026 14:00:52 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80cc1dsm1962924eec.3.2026.03.06.14.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:00:52 -0800 (PST)
Message-ID: <13091f47-938d-43fb-a8c0-4b081818b557@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 14:00:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 80B2k1C3tCDJTPiCT7CW64UopMovlsIg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIwOCBTYWx0ZWRfX4YbVIuzZd1oy
 E5X9CgzXs8T2q3rdseMqFEBXMXmYULPU5JG5ll84te6tjvYbZGLY9rHHNk4f8CTRTkIg/N7x7+s
 chy90TdE6wSV6RaRiYPaV6eKpYhppTcxNcU1PIE+Oxz9BRXhKJed8Hrt2RTa5iUi5twMEMPxpYv
 iTwRL94ke7hYH7B/7DwveUFG4JwShg/NcJ01Na1Q8WRkC68kOb2Kg0bRJDuNchPmPVY82lEtJjf
 7ZkJF3b7UTg0Nl3wz0BsZ0gvrpcrmZonf6/rB8FdIEM/oiRocHKVZDHzZB6jKtG0Pt480gHfDnn
 ezuUA2wfvckQTi748BuCy/PVfQSEcLPjV4f3PSFcO8CVQKq7NRcGf6duH4/k/XWOgKjoztTwYxL
 GzH/bYVfdxD9sXQN8aiB7jPGjUFfPLB32sNAq95F7z67Bsbw7RO+JtmKG9SOwvscPoXf9Sp3krM
 cR/TJq5ZN9VJuBQ2Gcw==
X-Authority-Analysis: v=2.4 cv=X9lf6WTe c=1 sm=1 tr=0 ts=69ab4e97 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JJlnT80H4U8AMWgPcGUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 80B2k1C3tCDJTPiCT7CW64UopMovlsIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060208
X-Rspamd-Queue-Id: 7DFA12282C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-264942-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 11:47 AM, Trilok Soni wrote:
> On 3/6/2026 2:50 AM, Sumit Garg wrote:
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Sumit Garg <sumit.garg@oss.qualcomm.com>");
> 
> What is the convention for Qualcomm authored drivers? In some drivers
> I find that Qualcomm doesn't add MODULE_AUTHOR. Can Qualcomm community
> clarify it here. I prefer consistency here for the Qualcomm submissions. 

WLAN team was told to not have MODULE_AUTHOR(), so ath10k was the last WLAN
driver that had a MODULE_AUTHOR() -- ath11k and ath12k do not have one.

And in reality it is very rare for a given module, over time, to only have a
single author. The git history contains the real authorship. So just for that
reason I'd drop it.

/jeff

