Return-Path: <netdev+bounces-273135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNgaDN1dymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F835A371
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3016303FADE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC32E3C199F;
	Mon, 30 Mar 2026 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M5vrsa+3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ezBPLgDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173F3BED75
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869545; cv=none; b=Cit2p5mfq1WOwPEeu8mOYmsyxJpfX3/JMoEQg+v93TraWRT0o5JA40ro3+uRqIvH+F36eWlUn6ABU/Y7eVNySZ1hNwDIAJ83xFxd4Zl96KYFSe6KgRb+bkh3s3hOGc4VTKdmyTl9Sc+4JlJAgSoGHjYxowaO7anz9iugCl3liVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869545; c=relaxed/simple;
	bh=nyQfzMVY5tU8yDNVE7v1bNOl2YyateXWELi7HVSLmwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFLvnDRubC9IajkNhz7Kzr4hh7Vii+hyH6SUrI2DW6MXQ+xCuLCr0rXRYtQlA2Lf1BO7f9v92KKe/qKkdtoioOFie4VZv751vu9zpJcj/KS9ovEW100cresoy+rpViR5gw08bZSoavyNiPRx/yqmjnck37mYa8lgzylxnDBArr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M5vrsa+3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ezBPLgDZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U78Tov4161962
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nyQfzMVY5tU8yDNVE7v1bNOl2YyateXWELi7HVSLmwo=; b=M5vrsa+3fUMTvHpN
	R4r8YAG5do0rd6uVgMpdxA3GUV/CpHibqfk3AxRUTQ6xYqdRzuWmxWDRBRn5s6Kq
	qPE9z/wO3StzK3mq5IR+h8ybPjOA9T7b5Tn7XUeyd1IguIr9bj+IdSqegEvacKB3
	TkLB0kTRZmFQszEF3+GtbufyGIzDvvAVePhkPJTYpwhuYzCsHfhi4K7iUmHGGpF2
	VUknKt9x/iIe/SEI4VLcpwPJfnt5vLKEIQ5nEpFaeVGbp73MMAmTrzNyRYFB+i0o
	4qd9slaq0ECgvfg4772fmPAhIDbq+bIzV4T3nSs/POsB6C3ANB502S4go+ByEQL+
	cE1/qQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7mhary89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:19:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfc4ba4de0so124826885a.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774869542; x=1775474342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyQfzMVY5tU8yDNVE7v1bNOl2YyateXWELi7HVSLmwo=;
        b=ezBPLgDZ4KFiDZrBfdmylmQBGt0MFB9e/FFykrWpWtTygzjYyCbJD9sm4df1q2eHBd
         NhsPz6lVkkSmO5Psc9EUuxhOOZRHXxeIr8zo/qbpvZ0SzX1Ns8ao8V0D5YIRAQECNXhZ
         osgCmANs3+8BpUzPjwkCbBfGG5PABFqfIkDbfVp+J5WoOXpci9zna3JB1fgYxu7GKjgr
         Pf67Qpa9mUZTRVhrsn8xUUHv8E4JAO+c/ZAgyt63a5RlvMtywzZ/Aey2xfzAAci7jfbI
         vdA1vNIvDXr4JD1QmPB/Ip7hfsAXpUZTzohaq5JAz5gkTCFJIR1b5nCT3SGhn+Kchld8
         FOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869542; x=1775474342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyQfzMVY5tU8yDNVE7v1bNOl2YyateXWELi7HVSLmwo=;
        b=IDRaLpN3QpDdAhttum1+9q+jPZ6FnOp0n6rDsbpyT/wc3cUt+zeoz1a3jDaj5+vYlI
         jK0t+skSFpkFn5lHSPfm3udjR8746eZW3LSiTn0EDWLy3LCrzVfYnGt2OJVHuHFmbRy1
         Eyvt9w7YlZMkp21CTjSN7vZqsiQYnt/uBSZOSL4wRioyhM7HLgYhbnOF6X0sf51HH0ZX
         ksroe1GNp+k72qGbzaHL9sehOAHOEAGOesZyzIW3XRyARC0JgFIcCHwwSu+PwFHlSaso
         0zZGEQkpO2E+IlDX1Splg1tEKmDsl4sjq7h7SVByYAkEYGGErEKodaF1ZheQf9/DZ4XQ
         g/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJtJyQDKIyt0Ews5yt5CT6fZcKrMWh5mD0j6wmCuz2HIaKhfX/dWgmJAjSUX2RjNr2NePQyu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGp0OpvIBy6GiD0e7fEA2WFVMxJuGk63JSYro0hqnManKhnGP
	BNo/FbIzfLclX4kJ9pQ0+jbReupPXrK3L7k9eLSsb8VMkymUetu5VUxWfzxLpvQCcaQrtQqKNi0
	/MbHpQwFzYsuuwnL3OMSs5C3c81MWrnUQ16EcI060ncKuckYs5XbRKNr2XRA=
X-Gm-Gg: ATEYQzzn7EFWc5sdwnJNVFezq1m2z7RgSOAKSJlnpb09TSDhEZsaYuC8giNSNkgOoFL
	Bd9Wxce3+6qNfIWhe008j+MDhlKpxTxytAbH4ORp8SjtquqjkStkmVRrh6EPmz/vCdcwYlGAwl+
	8SMXnxaYxOQ+KGOb5QmNiy+n4FQp4sZOT/bDP9F0FYKdZr3V7cuIk8PCOwqgegAJ6OpSfYzE0RP
	NrVeFDv8G9gogXGPURh4XGyQzR9CmFZh9ra9JvoO1EvICZ7Md8KZggnF8NY7DwdomNaBlUvmxU8
	62C6EnqczbmyXRvNOkauWYOTvObrASHp8Es9EOKLZ+bGgF8wLXIEG7ww2sbm3SqRG3NqMaEFS6t
	1DXsOIh5NKYNRJSgpzsxJIVCiuSVJyVUEY0NHONZnAcbTpGzmfa3S2LYIfBwTVPyJO71ljQZhP+
	fcMwI=
X-Received: by 2002:a05:620a:2a12:b0:8cd:8bfb:a4a with SMTP id af79cd13be357-8d01c322c10mr1083812885a.0.1774869541637;
        Mon, 30 Mar 2026 04:19:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2a12:b0:8cd:8bfb:a4a with SMTP id af79cd13be357-8d01c322c10mr1083808485a.0.1774869540995;
        Mon, 30 Mar 2026 04:19:00 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b72a6ec5csm2366019a12.9.2026.03.30.04.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 04:18:59 -0700 (PDT)
Message-ID: <9d0a529a-d065-4f46-a93b-23195a4f9727@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 13:18:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: stmmac: qcom-ethqos: set clk_csr
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
References: <E1w6AZm-0000000E54W-1F6E@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <E1w6AZm-0000000E54W-1F6E@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OCBTYWx0ZWRfX7lXddFmkaUYI
 sIUFOHDFjcrKWqEEJprwqcFLOx8qDtu444ZY+ilSYxKM1yKcWW8tMjFcYXTwsQk1JepRUJ4/8Y9
 rxFYI3YUCQdT1zq4kUDA5BktvizKfP050XRHqVUYrDY6uJZIeGG361dFxiANmibHZGlSImWzyEY
 /BK4vWbPOMyJqESEZEVncLGVzTX4nkY0kpMGhOjnIsZjjIHKWzXptz4FpMSQ9/HWICXQeejUoHZ
 UZ8mPXLrwHVgxiQbHYSwqtEbCXcpbep5i3Uiy6mivzo/Ua1AHk/nc/UpMNDi2u0iXNuRcU7dE1a
 x5S3nLicKJ/RpzieN7luAynpzVsTgE0sYz/tDKDmOEikagxJTbP2swp5baQBibj5WauyPlAdG2M
 QRthv6sHgLYqmo5+UC04g4xapchZOz86ac+L3DINpfomOhCud9Jk7P2c0IRlV0FGTZhP1pbgM5u
 gmview8fD1nXXpCpkyA==
X-Authority-Analysis: v=2.4 cv=Fbw6BZ+6 c=1 sm=1 tr=0 ts=69ca5c26 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=JwhTZQfU3B_gdtkNLGYA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Ecj24ddBOXwoD9Wr0yLKuwixlfHzunUd
X-Proofpoint-GUID: Ecj24ddBOXwoD9Wr0yLKuwixlfHzunUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300088
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273135-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A1F835A371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 6:02 PM, Russell King (Oracle) wrote:
> The clocks for qcom-ethqos return a rate of zero as firmware manages
> their rate. According to hardware documentation, the clock which is
> fed to the slave AHB interface can crange between 50 and 100MHz.

FWIW this __may__ possibly differ between platforms, but I'm not sure
to what degree. Will there be visible impact if we e.g. have a 200 or
300 MHz clock somewhere?

Konrad

