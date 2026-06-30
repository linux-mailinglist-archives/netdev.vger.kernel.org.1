Return-Path: <netdev+bounces-303159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3HiFImu6Q2rBfwoAu9opvQ
	(envelope-from <netdev+bounces-303159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:45:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9556E45BD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:45:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PZsvIHOw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=D3Wa7LOv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FEB3013263
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6740E8C9;
	Tue, 30 Jun 2026 12:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62CC331EA7
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:41:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823292; cv=none; b=KJY6NAGTXHHTm+tM4mFeRXFpVtBfUJ4oNOMTHibI3q4xpDYU3Mhq7+ErUQ68FOJQc3eNZCpgoFQl4DatzxQ81gIb2YUU88MzPeq+Uw3w/IOwugZiILdncZSmg+L54BeV9bzTGRyWxh+D6x2kWO98MRLvQ9WglmcFXwQPvA0jaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823292; c=relaxed/simple;
	bh=jQD23j2vf2XXCyCGAPYr1v149ZU5HdPGAyLFjjrpeEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCO7W/Mp0Gajna0F2rtBesFuWFb12RXbPpoo1SBw7u2gKscI1lD9zV0YCQGwW8vAMpZPP02V7T9q5iAk7KVdGB0u4qhv8xqvfAc50PY/oca78x8uU7pttCYJiGl9LEwynxlWqaRQVZNZKZ0ev7qB5LDZf+ildpx5s9ApIe9Avxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PZsvIHOw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D3Wa7LOv; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9moqO1542055
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=; b=PZsvIHOwGcpw1Si8
	mjM5tSeCEW73QMW3pin7A9aNwjptzuikOdaZziRc9EWb+Lwj8nI/lcJb7cE6za6h
	cLx9tEcWyKYljPLsaJkqt1rhRwJpacz3La/f77wc05T8v2A9GTcBWr9dJtX341vN
	bUqEp5fLEOESTWBWc8CY8zeqUKgJqBiaG9dsmhBfd0CJHqYaEq/2IrW/rwR53imk
	STlC6MpL8J2CK4lIgUtWLqlG8+r4dS8XU1CHJMlU1ZY7OU5Cvf5uHI9dn6uDylJI
	C/7DwbOC/0Viob79NGAGUiYF4EqwK0c1g1SpktXNREopXQ82rQFYORYlJIwhpBe2
	jS7SEA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4jfet-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:41:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e59d97df1so33853885a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823287; x=1783428087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=;
        b=D3Wa7LOvjmBkJYavabaQ8mgETBvsgtzdjDsT8a0wu3B1DVlxP6GsCBP86KZexY2F5E
         SxZ7n5cm65Yo3im82xyheP0ZErTuL3Bgh7kp9VHOY6hGWsccqju433wAbVqqFaWqGT0O
         f53oYiW9dPLcEoKjLBHePv5icI79W9fvAr2Ym20jl+4T0NDWIPCntfG8owBgfkrnSb+S
         6XAX+OL4H6V4fOKAhTTZXtLgF9t6gJEkFeTOHxL6hdC+M1bnU8SiilHRb/hhoSBdWt5f
         KdMsB1cV0HKvwYpyNdBsIy+PTD+SObCmxTPmI6T74QPdRSqG06bH9wEOUz6Gpo0SK2Kz
         JO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823287; x=1783428087;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=;
        b=joC4rhWBCNRfg3d7F4P28bIxfdh9xXsEdD4k4lfa+ei57n0NZvCbpHEXQctQ7qZIXt
         7qfQa6/Jdd3tbcVNDHEd0jrjcPcl8bpopWeyktOfQjI4JyhInp/iZEui9PMj+LsVHwQf
         mpL6SdyMmyd+jnNHFrxG7B8gWXsk4xcUsvUxy4rPPeSooN75V/0YpxcD3LZqoUbDxtV4
         UK6oYvtZrilnYhR7fVgl67xeyCKFfe/4DSWKPnd/uukLW255CvHkl0v3wiMhUXwQtJji
         Rj7AeNdo8T0aeJWRLdH0n1By8l1YHkLzTM6i0RGWeVXUrNnCxe9lVlcuMAWboITre2gP
         6RdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+g3+tNBbOtOVJknDCGEiY3i4Xa27U0HYVbmTAhvKotOVJFXpUZIbl0xHy5G6dpKRMGAMnP3/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxCGT8ANbK/eeNSnAiXtkYeMkDvPGS/W74MyYtT/5XQHxnpj5d
	yoVtfDopjnXLalFApLxBafwaxIgvEn5Pn1Aq97XwkiusppBAYBtIZB+QT3wsA8EkIYk9bwzEIQk
	5qaVY9/zdnbolzf9W/+3UI84udiskO99umqf57mKBVnHFuKdO3hC7dLNpgqk=
X-Gm-Gg: AfdE7ckls/OWfEKUQO9YIKhWw7I2S+eVJ2E61/6KaeJxwmpKtZxnjuI3W9MiyBvLthx
	XaZisaKc7rr5tt96lhq1yDVYKwP9TlMVZ+PZWsUHsmM9t7oOh7tbmyCfsAfFfM0F1QEd4pfXIUo
	xVAZ0OzICPNWRy3Ak17MJZ6mocW/UR7jL6memEkLk8EN/26W7irqGkCf/71ouekuEX8sxepUAT0
	gKJ7DrKlgHYYvZZl1qJyPZh/VGpnrYprvGpgiMeY+d0NKk3AxsGLl2rPkfOqA/obdKvlIh0KnM/
	ISkGuo34LcGHU9XOJ1eDLV6eap/BlogjyQ7VkXPKX0BZzlXvZSU2JmWgTdjJZJJOaD8qkTlPOWv
	5Dyg1FhVMSmuMcwBtLpV36YmRww1Dch+PNCE=
X-Received: by 2002:a05:620a:8813:b0:915:4ca0:1210 with SMTP id af79cd13be357-92e62689c4amr349001785a.3.1782823287420;
        Tue, 30 Jun 2026 05:41:27 -0700 (PDT)
X-Received: by 2002:a05:620a:8813:b0:915:4ca0:1210 with SMTP id af79cd13be357-92e62689c4amr348998285a.3.1782823286896;
        Tue, 30 Jun 2026 05:41:26 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d18735sm121211466b.6.2026.06.30.05.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:41:25 -0700 (PDT)
Message-ID: <ba22eda5-bc7b-4ac3-92e8-c14c4dc13483@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/14] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-10-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-10-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PMxApc9-fYaV9qtsrAo8MkaQGEkiBqGW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXx+26aEBfQylb
 0t4yrrdcFuN8gTKU4FT5AqUCxKGhoKQuIkPKhveKvyn/hFRTHdEIDSOJRtz3BWZvVroNNxipNu5
 TMx3cpwVY2PY4XcGFO8BscjUwBI2+VE=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43b978 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=GN6ll2GKXf5L_uNS5a4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: PMxApc9-fYaV9qtsrAo8MkaQGEkiBqGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXy3Wr278MSHDX
 Pjc1vNH5TYfqlo4kgpszJ2+flF+W5ykRVAHVOP3fhIoXv8bQsA/l0WJP/QjhW4VtoAK7nkF9gey
 ohxZo1jd+ZMGmLojYLSMJHfD+r53WEZaPlqe2rI8GGadP1WiC5NGQi2dLBIF/F0HGe4SenyrlPw
 JG4X394Ya3zBk/Jr95POUYb9tFEKQhn5FsBUiiASroq1G3z3Yn2sPFmXOQjLfGdg4Xm3J7nfhhT
 5NAfETZkUM0dM3D77Ev+kUMoFmA6w0ZmTVSumxX7q7bxvc2mUoRG7b+tawfyny+9z/+3WSa5pZj
 Nfz5EyaTUhyyDMsEl2Vdv6Qzmd5FrjQKkKq+JApwk7kUOfrbPwuAKjiPdg336+0CIY3w85Pur4M
 +Mg3efgfST6dKeKgH3BM/tlRXjNoY53LOhc1KiOEyWwkWlv/1A0rbWas2fUFstvetviBoWi8big
 8f92QMuM1RarwA9B64Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	TAGGED_FROM(0.00)[bounces-303159-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF9556E45BD

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

>  config VIDEO_QCOM_IRIS
> -        tristate "Qualcomm iris V4L2 decoder driver"
> -        depends on VIDEO_DEV
> -        depends on ARCH_QCOM || COMPILE_TEST
> -        select V4L2_MEM2MEM_DEV
> -        select QCOM_MDT_LOADER
> -        select QCOM_SCM
> -        select QCOM_UBWC_CONFIG
> -        select VIDEOBUF2_DMA_CONTIG
> -        help
> -          This is a V4L2 driver for Qualcomm iris video accelerator
> -          hardware. It accelerates decoding operations on various
> -          Qualcomm SoCs.
> -          To compile this driver as a module choose m here.
> +	tristate "Qualcomm iris V4L2 decoder driver"
> +	depends on VIDEO_DEV
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select QCOM_MDT_LOADER
> +	select QCOM_SCM
> +	select QCOM_PAS

Hidden NOP addition

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


