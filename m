Return-Path: <netdev+bounces-259419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOAnESbYlmktpQIAu9opvQ
	(envelope-from <netdev+bounces-259419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:30:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B150C15D612
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CD09300889B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47433A03F;
	Thu, 19 Feb 2026 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIih+xhq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X6uY0aZq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75C33987F
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493404; cv=none; b=CeW0qGvRyI5HJYoWxzCojjCqN8ysE5ByWYIakYG1UU2woHU9kJ92vIr8aYE1NGgLUFfDN5TEcNzL/aNw+6PLwkBEZ4HeEsd/n9ixsqaDztiltT55wgP2QM6n5kLidO2+vz8aC9kpt8Q4cZLbJQvQV61srMv90hYu1pU/ANA3B7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493404; c=relaxed/simple;
	bh=RygtW83dHF2LdzupDl7e1RWiWV5bC3NvpUj9QHFGlXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghCwL9da8VJez1a1CrkfyKcU75rqAgipDQ/HNF3v4PjgizVkXdaMaeWtMMw5gxAIGrkzABj5TUo7iAIIrsxVRZ/o092WKI2btmlw/okDIKRxDneC0WjX78zxNmq+Juy3GuTcJJDjO8tsc7igW/bBdQ0nj9Lm7qJJx5blgh6AYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIih+xhq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X6uY0aZq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J1ExMK160255
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJsPVkggm5naZHTouB5P3aQWHbVavGwIin4koVrw3Kw=; b=iIih+xhqETsKZO85
	3Gh6iJUIn1pjzSYOjb8c13/geQBBb3pd42DYOCrDqzZce7GTPScg1ZBMMvexhflm
	Ki/bW7yoCM0hc4vm4WZLvIaiKctd4lTaBH+gWWKZcUh9FZFnQi4TTL3+HDTpBRB0
	LLAZZDAFaV7YEXK+neBqCyZyO0lWLPCP1F1bGpmYkVDUXuWFJ5RT7R8XbRwGz0YN
	a10PQOjHIlBIRwn2jqUtqhNyN1Y0HaBBTdcYWz29ULGvaBE9gb1k6kLArv3U0yxd
	u8IKl6zEWV2sCkhcgRHI0a2dHlLHuhLfucNwVkP2OaeE9Q1HkWGT1qA8bzmrksmF
	eWDiJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdrpg8x6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:30:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c72d23dfso4291443a91.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771493401; x=1772098201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJsPVkggm5naZHTouB5P3aQWHbVavGwIin4koVrw3Kw=;
        b=X6uY0aZqaXVxRyKZjGqUKNyyXwQ3lbxqPF33rrbSCMPUyU0XFh6T/k7CQy5sE718pC
         lfT1e4kXx9gLgGKpeGWt7Gmq0hBePMd/CRz6+7RPR3dLH1ON4day/jCLnRPSyxnCCpla
         SuHClKDJ83zuYJufdo/CyZVdDQ3Z0/cxfDQNJ8MSP0wRQ90MfrldC+wuUX/f2PEIqc/m
         4YZfydZT4ZPILK+C/QpBPg/Slbenu+Y6/YLFGd5wVNwFBFaUNNb6A+FfS3CqxO+rtb2w
         kwqsvns6bPuPiiMbdX2GFcVm8dlD9aDaxwEn7LOuHgIBQZCOnXGE8GJAtO8ZXYsREICb
         rbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493401; x=1772098201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJsPVkggm5naZHTouB5P3aQWHbVavGwIin4koVrw3Kw=;
        b=c1z3O3xD+s5m6tfU5aDjSVIUkhfvcYs1+HGHi0/Q86rCsQNdxVCmNkS7iGgVug50Ru
         L5oqSajdeikX+JG/jjPI7IE5rS0+8d7L2M9JkYbc6muV2x387XUUl6m1W+303xlGCUm6
         fzEOqMD5jhkwgdnI2r6MZUUtJkD09GLY02znrZO9gXjKj+x2U8e9RHZpx1PIchyvqavG
         cE9enfLFtEMMYsRzltcoAUrHLS83o3llFuObur8bpeaHcOlklJ8T694nhelUpr/6MzxW
         1R+3zGLBEhNqh9leegJWYs0bJkzthqfRvSzL54OT8WtnyboVNem/jmKBkTMYg9EmKFy1
         B1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUEhioIiyDjatEKsJMwH2NSG3sYGniiDXXf9RRXToTKL0BF7uRaq6TpjqtOaX0cYkXn3hGwJ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQH2d657rCXO4DULYdOTiT1ZgcckRfuzxAVsc/qBB+RpUZHckn
	5KhrmQFL9fuQI932yr73MSaJxw3BCPWtj1QINcGuuvDsThtZ5znwLFGpRhnTMZSXarK9yHxId4X
	JsYNzPrJOshbdB3S4T/exHh8FTG9AgNAaq9OX2Hwq+2j1aLhY5HL08qGigm0=
X-Gm-Gg: AZuq6aLkAlTFuOJEJXJMPfB0d103OkeM+A6T5m19KsFRn7dln58GJCYaWxu96kA+9J+
	dexuxzdyx8QvRzFNUqinsX3mlc59lnDY+G8anmhKvXkY+czExWSI7voBQyVc/Z70H7zPwSk4lOh
	swWeeOshT8NaTrMBNWURZ5pW6Qe1haQr7MWs/05au0ueYwAYa55nBJ0r2vAy1FnJDD9n0BeEUvR
	C6m7Tvy9CBfhUVrFSC2pbS/oT3lMXZ3adDWMoTyh4qaoDZQYG3cjPXRJJ9aYkivmASFFtkRoG4/
	0u6yJZTU4Fnz4lMRMs2p+Kyb8fyUJXzJexpuTVYKSImFnSei7LXGOQnqrUFE8q+NS5tqVtP9HrK
	5Jbzd6oDH2lRR1mhML7lRvj+s8CGIvCseR6ZoGZU4vGYvBE5t
X-Received: by 2002:a05:6a21:489:b0:38b:eadd:449a with SMTP id adf61e73a8af0-394fc339ee1mr4614429637.38.1771493401295;
        Thu, 19 Feb 2026 01:30:01 -0800 (PST)
X-Received: by 2002:a05:6a21:489:b0:38b:eadd:449a with SMTP id adf61e73a8af0-394fc339ee1mr4614395637.38.1771493400788;
        Thu, 19 Feb 2026 01:30:00 -0800 (PST)
Received: from [10.92.198.80] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a627a5sm23548236b3a.27.2026.02.19.01.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:30:00 -0800 (PST)
Message-ID: <bb28589e-714b-459d-a609-0153b97ac158@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 14:59:33 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Wen Gu <guwen@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dust Li <dust.li@linux.alibaba.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        David Woodhouse <dwmw2@infradead.org>, virtualization@lists.linux.dev,
        Nick Shi <nick.shi@broadcom.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <51e8d8ce-f291-4e31-a938-2c1a0e8684c2@linux.alibaba.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <51e8d8ce-f291-4e31-a938-2c1a0e8684c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tUX4NgnkcXMhlz1whxHQ0mLIsOlY99cq
X-Authority-Analysis: v=2.4 cv=JrL8bc4C c=1 sm=1 tr=0 ts=6996d81a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=ibL7N2hfcdCGtAndqR0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA4NiBTYWx0ZWRfXwHdi+/H5EQdH
 sWca+jKArICVxgnmBfgp68Obsv+N5MK66DoL8DEgo82C7BdedDUxNhXIXut6faR94gcYE1Y2dh+
 eWHoo5VjAi8ddUk1b3vtzAUe8rWb3fm4w6GdCaxyLRTS1kZa6G9sI2qPq3Z+8FBC4/9ad/XlFNo
 eOAD00SMVg2WId7d0lR0BqE6LHmat5sfdEwdcb7mRu205BZpxhZ9A9Y8LQ4eNVvb1ZySOOw0/9A
 /T109KJ8RMzX5rnH03oFf4O46qpFeOJ947uqEo4gBPgY4YV1d2wwRZS40d8hBpr9JB0B1Hxc4xb
 MXUGDpN4Zf+CV9hqG6bk72+f1hzkxtWgqCl7P/QkRz8qY07H8PgtzHZyMLuJfdE0z+n/DbJYDY7
 FbQmeJDGDyAVrBP0LoaSsDHItFWVpjDqrXcdG3X3pmSMt+9kvmPOLORhpxOWolKTZYuUgiRqTtF
 9A21OhTRqVsUdkjol6g==
X-Proofpoint-ORIG-GUID: tUX4NgnkcXMhlz1whxHQ0mLIsOlY99cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190086
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259419-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.alibaba.com,linutronix.de,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B150C15D612
X-Rspamd-Action: no action



On 21-01-2026 07:59 pm, Wen Gu wrote:
> 
> 
> On 2026/1/9 10:56, Wen Gu wrote:
>>
>> #
>> ## Proposal
>> #
>>
>> 1. Reorganize drivers/ptp/ to make the interface/implementation split
>>     explicit,
>>
>>     * drivers/ptp/core      : PTP core infrastructure and API.
>>                               (e.g. ptp_chardev.c, ptp_clock.c,
>>                                ptp_sysfs.c, etc.)
>>
>>     * drivers/ptp/pure      : Non-network ("pure clock") implementation,
>>                               they are typically platform/architecture/
>>                               virtualization-provided time sources.
>>                               (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
>>                                ptp_s390, etc.)
>>
>>     * drivers/ptp/*         : Network timestamping oriented 
>> implementation,
>>                               they primarily used together with IEEE1588
>>                               over the network.
>>                               (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
>>                                ptp_idt82p33 etc.)
>>
> 
> Thanks for the feedback so far. It seems we are close to consensus on
> the directory split, as [1] summarized:
> 
> - drivers/ptp/core       : PTP core infrastructure and API
> - drivers/ptp/1588       : network/IEEE 1588 oriented PTP clocks
> - drivers/ptp/emulating  : platform/hardware/hypervisor-provided pure 
> clocks
> 
> For how the existing drivers in `drivers/ptp` are categorized into the
> directories above, please also refer to [1] and the follow-up replies.
> 
>> 2. Transition drivers/ptp/pure from netdev maintainership to
>>     clock/time maintainership (with an appropriate MAINTAINERS entry,
>>     e.g. PURE TIME PHC), since these PHC implementations are primarily
>>     clock devices and not network-oriented. New similar drivers can be
>>     added under drivers/ptp/pure as well.
> 
> 
> Then the open item now is maintainership and the merge path.
> 
> Based on previous guidance[2] and the current MAINTAINERS structure,
> it seems reasonable to have it maintained under the clock/timekeeping
> domain (following the existing timekeeping pull chain), with a
> dedicated MAINTAINERS entry.
> 
> 
> Hi Thomas and clock/timekeeping maintainers,
> 
> Would you agree with this approach? If so, could you please advise on
> the appropriate maintainer/reviewer for this MAINTAINERS entry?
> 
> Below is a strawman MAINTAINERS entry (happy to adjust):
> 
> EMULATING PTP CLOCK SUPPORT
> L:     linux-kernel@vger.kernel.org
> S:     Maintained
> F:     drivers/ptp/emulating/*
> 
> 
> We (Alibaba) are also willing to be the maintainer for this entry as
> a fallback.
> 
> [1] https://lore.kernel.org/netdev/b5a60753-85ed-4d61- 
> a652-568393e0dff3@linux.alibaba.com/
> [2] https://lore.kernel.org/netdev/20251216135848.174e010f@kernel.org/
> 
> Regards.
> 

Hi Wen,

Thanks for driving this discussion.

Is there a patch series posted that reflects the new proposal?

As Manivannan mentioned, some Qcom MHI devices have similar 
requirements. Once the reorganized changes are posted, we will also 
resend our patch series adopting the latest changes.

Thanks,
Imran


