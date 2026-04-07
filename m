Return-Path: <netdev+bounces-276197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGKnNNGB1Wlr7AcAu9opvQ
	(envelope-from <netdev+bounces-276197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:14:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737313B544D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34BD93025724
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E537F724;
	Tue,  7 Apr 2026 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OweH0Y2k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Towwi8qC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294837DE91
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775600075; cv=none; b=k1X8DUO+d8ofRc9JOgYBh0HMfW2gjVAVVys/reQ6UR7paAkQnTdyx4Fr6x7SCQmNsBt8rJFM/0ded7hjcIn7dT+nRyLTbgD0QAMx4pGNllV7q3Jm1GJBTfpWoD+7DeBq8+7dRXm+dqSKSyMpo6NorY0PcpA3+j38djL24/A/bzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775600075; c=relaxed/simple;
	bh=O70zG8/vQ7/2/njiFcnoP01VaZrKBSDy6k7ous7SiZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/GOZsoNExt4f5rwsaTY4sx0R4Tst+TN/XRpXUtyGs59zmI7aDDBt2jGWk1Iar843sWcqRosCIwkvlPTJ2G0uhGGQN+lAUf/mFxsrka74TC8qZy/mJzpXj+Ibu6qRUJSKgyt3rDhGFAB5vuHjVmh0BlsMnmj0+3A5uLO0aGhYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OweH0Y2k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Towwi8qC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637M4MjX2860429
	for <netdev@vger.kernel.org>; Tue, 7 Apr 2026 22:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=; b=OweH0Y2kARoYn1W1
	qq3nLdCQrnMusgkFKVH97SH/YIOnMEsAfAZK2KoiG9Gxh/8/n7cU1UsGD3/JY+O+
	TnCC6+QeX8Z0IUKHaUmjTIypZ2H0UfYbyJVOT7JUEat6dMR7LzZBxjoLQJyQmwOz
	hXC6WmTAPgKiCEnt8sayLvxEaf1aQEZ3KVbNm3zDkVgkpsYAgEMpiGSFzicXC+GT
	zLbUcVWQXj925Bce1NoFoyGvgQBlVpoEnadvPpUlxJC/tmR4UarU4h86gc0j8iqn
	9zGvFPUfebfRPl8K/kWd8XSw9wadeBrURZDqQNVSPOk9jaO1/Rspujy1bXSio4MO
	UaKy3Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddad8r0rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 22:14:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso7903256eec.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775600066; x=1776204866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=;
        b=Towwi8qCgZfYUflNkOb/McOoIKWL4FXtnHS+61NfoX++L3aMY7rz/hE198FCH4bEr7
         lTERDD6vyUau5niV1ACETaGLJLCGKM8CtQ0iiSxhmTxj+2HO2sINAgOq0BoMpBk9P1YU
         W9md2wZDgOfa20KbSwBg+UV8n0wd523R2GHFLceuS34njkbSagCzY+oSqRTutlOBHC6Z
         e6Q135NmJUVeVXysLPa9h+mTLE1K4lGnxU8vGE6WgQf84h93PCfXW7qpQB3FDz88YPWz
         6xhTGOk4ctF9wQjZs54SKwXMl75pDrM3hj5xPU33fZycNyzpm+gsA1bz8/8rTSIX/0Ll
         hLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775600066; x=1776204866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjGZu1nMIYxEH+BkM12qs+iRxdD0JnnyuDFHzOWT/rM=;
        b=gUN1t8hqph9wDnte3WhenlzaR9CFYvXVs0tsRBkgvsAASKrpIz1B6I0qhlnkDSCw9W
         6LTLjXy5ZSIlp+yRCc6f1znt7RCLlrUsKyZUEL7hI/tv1VpG2kAJLmnuGPBno2VBX6zT
         xsifHB0TlIGKlhhTsnOAdX2yW06qEebaoeCtbF+Bdqteh/9dpk9rcqp0xOhm4nyop1vT
         uO+dFewNkMxuxHmEWtAQGbRP8vaJwSYxgnttLpepdRhjoev8/1qK+7duoaqUcdOvSHGr
         mVQ1yibF3+nldK64NwygkmZqvVxow3F8xfHJB3oR6+fnCsQ1mG+QLUg4wzXdFb83cjpI
         s9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWz39V84KQTuWgHfR6Be2RyFhRq5mvF5GCyrEwMGCXbtcKSS8zf8s1U/+2Euvhr5BfIoYK9i5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXoZP5D4coLC0265cC61th8NTHv6N+60ZLsVwB8TPNcDJeTVf
	7rfxxx/ZQxPlYHYA6x6ilOQJkjUFTWMjiih9IUizCYV6hzadqOMEysdhppOVx7RjXT46SO1X5NC
	sfWkirkVcsRuKnq5cCOpCNdKtBhJHCu7k0fKGdWm5H4doLxnJAnvGuJ2DSKI=
X-Gm-Gg: AeBDiesiHabV7VZb8ym0IGLpX0NL51ccP56L9fSykKGzx1XhsUrk724b3LF30wvZiii
	KgTIrrhCgdPbejnRMvyiJk+4KpMYTc9PW4wQvn54SEiTnB98FG29urkhtLsFExY2MaU1E9x4+Ww
	N9uBxTqLs9WFbKiyxdkD9pgT0YiUQIXVuNE712U1C2xpRpMOggG2gvTPd1sFW2cjJwfVcc1Teck
	SPOOwcaU8MQcUFAH3hClmN3AFcicOyEohV3Hzp4GmqZg7eepfwzScvLetZSZPfrDBrDkkmhpi2x
	urX821fGLEXrK7YHcXGxkWBbTEWxNO/c3zmtRevtwzbIVOi8dJykVzT0IZSiX9fiKLS1+nav9Js
	8RyHWlqq+BNNpaJ6itAujO0ynsJyRvH6gGyL8QzokrxubPas0jKbwOwRndwnAi27iZwPaNKh+k+
	T5Zi09
X-Received: by 2002:a05:7300:880a:b0:2ce:f3d7:20c with SMTP id 5a478bee46e88-2cef3d70bd3mr4324857eec.29.1775600065600;
        Tue, 07 Apr 2026 15:14:25 -0700 (PDT)
X-Received: by 2002:a05:7300:880a:b0:2ce:f3d7:20c with SMTP id 5a478bee46e88-2cef3d70bd3mr4324829eec.29.1775600065017;
        Tue, 07 Apr 2026 15:14:25 -0700 (PDT)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cf2be19f85sm12178552eec.30.2026.04.07.15.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 15:14:24 -0700 (PDT)
Message-ID: <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:14:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>,
        Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        vikash.garodia@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org> <ac-KQ7e8-syph1Zl@trex>
 <adOcMsk8a_Clb4WZ@sumit-xelite>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <adOcMsk8a_Clb4WZ@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z_yxAaiIiBE8T73lnFIfyz6JEwibWJO7
X-Proofpoint-GUID: Z_yxAaiIiBE8T73lnFIfyz6JEwibWJO7
X-Authority-Analysis: v=2.4 cv=EoDiaycA c=1 sm=1 tr=0 ts=69d581c9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=nRfXl0x10UYwF-qtBXkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwMyBTYWx0ZWRfXxSQ6i03A5bEY
 G0WYfSWdjlClxLf2v8yd7UMBzZmPg+O+JWB9yuAWr/45QmmZdQu6npLEKyE+daSSFaNn9G+TP8K
 DZO4aCueF429280Hbj9u10jVNXy0kO1Mwkmy4XzRSzJBZvN2Skm9VH7gmuTI90hbN5vUNCKb/NO
 JHzbZL2+QJK5h/vddFy9qxt33/j7nOx/T/M6Okiecar4zF3rdplkHVBIvv17OLNazRJd0WxYYnt
 WU3wxNBSYTmCoET90n7wyGmsjuQyi4kCNp6P7J/YHIb/5XIqxHyeAdweSgodyYnsMQWuBeMECKh
 tLovsSz9ueZirOHqDsByiZY0KTwFdylx+1c63voxPxi91uX87htfO3cf3BFAEz/nBbeHi5I91aX
 JU4IMFZMrZbPI+ccdb4zt1e0ECFAyWrPqbTA3Ap8e1ZlbEnVMfs0Ll6Jhc7SWa3qxQ14EWgv275
 TZotf7avHkYsHp9C0+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070203
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-276197-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilokkumar.soni@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 737313B544D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/2026 4:42 AM, Sumit Garg wrote:
> Hi Jorge,
> 
> On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
>> On 27/03/26 18:40:39, Sumit Garg wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
>>> TZ service allows to support multiple TZ implementation backends like QTEE
>>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
>>> backend service.
>>
>> OP-TEE based PAS service relies on the linux driver to configure the
>> iommu (just as it is done on the no_tz case). This generic patch does
>> not cover that requirement.
> 
> That's exactly the reason why the kodiak EL2 dtso disables venus by
> default in patch #1 due to missing IOMMU configuration.
> 
>>
>> Because of that, it is probably better if the commit message doesnt
>> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
>> implement the same restrictions that QTEE (ie, iommu configuration).
> 
> The scope for this patch is to just adopt the generic PAS layer without
> affecting the client functionality.
> 
>>
>> I can send an RFC for OP-TEE support based on the integration work being
>> carried out here [1]
> 
> @Vikash may know better details about support for IOMMU configuration
> for venus since it's a generic functionality missing when Linux runs in
> EL2 whether it's with QTEE or OP-TEE.
> 
> However, feel free to propose your work to initiate discussions again.

Vikas and team depends on some of the IOMMU patches to get accepted 
before they enable the EL2 venus support. Please reach out to him
and Prakash Gupta at Qualcomm. 

> 
>>
>> [1] https://github.com/OP-TEE/optee_os/pull/7721#discussion_r3016923507
> 
> -Sumit


