Return-Path: <netdev+bounces-258469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCYlMB/3jWlw8wAAu9opvQ
	(envelope-from <netdev+bounces-258469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:51:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7C12F1DC
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DFBA304227F
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070D1D5147;
	Thu, 12 Feb 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ax5CnJ3p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ar+NUL6n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2A1E487
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911517; cv=none; b=gE4kgNgXwPFnQ8nnVqdSvbL4RjWMImLbuj7CiPTmIHnlfzGkbSFAJhetnI3KMpCoqCRCZagu8Mub6FdMktESD5LX9mK4OQRLlm+fOgyDIeamW5sdAjiPiyfCTW4/SyWTzJkxcBby+v80EwYeB4Y4C3EFhdTDfm0o+XINCpu/Qf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911517; c=relaxed/simple;
	bh=I+3HK+rzmSqmU/qhNkj7MN8hSIQ8TsvJfaz6qXkCFKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EX33oAaE9Wv7RtiSmNSxl2y0lKCCzyh3HkMBGtGqj9N2BONel3YyTDk/DvoCc3rhmFH7D2iYkwUKgYirCY3Fim0h9cQK+XN2pthDlYPbgolmcQbIs7Mja1UvuUDT5MLd9Ibd+NYIlK/BsJy8f4oRPkSPVGVZTcmseV5/KE1ALUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ax5CnJ3p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ar+NUL6n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRhKo588759
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 15:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jNIQL3IR6L/g6fCcKQxO3ab9CjE6vLb1z+JStGO11LY=; b=Ax5CnJ3pFulxwKBi
	P97kN3f5mxNlXsKJ1F5IDTyIq1YpcGMlLnTUy8jx9wb43MzG8fBh41ClSg8JYz6l
	RYm+bp2cMaYvv+6Td1xPc7ZPNMYuQiErJoNeF3J6T6ZhpS19lOWCxHO1/IDFuNKl
	Psi8Wgfd7+q/IPaNatoFeZN+AwXwExV/Suc/atXFJ4lQoHFi10sGC+/H8eqBmptr
	1ECfWLpmO+nYG1mPLeOxy1s/Ogqfn4dXxDr/jtU3VIzpb2LGw+JOCIGwpBx9BkOd
	SG2l10qoXQQPeTYaPTep38g+RO6kEdizZZR1OPhF/AbsRymJLlW/biYSUbXXMlQQ
	uVvGWQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c93snju8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 15:51:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba87c0e198so2515796eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770911515; x=1771516315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNIQL3IR6L/g6fCcKQxO3ab9CjE6vLb1z+JStGO11LY=;
        b=ar+NUL6ntdaJX3mzLgpVWhYfEp2fibEfoG9vDVIuwKkdfyQXVFe5DWGUt3VZd4RiDc
         s1c+UPiXy/TQ9G2LdvQgLnsiVy9RXFWef9onNNCkYhWw/ZPPrgdOPlZKSCvrQx0utBCB
         XPpvIBmTBUuzYN88yOmvR5gRJi9efMOQEz5tiq3gvfqanhYtU5vrKxGY/ZmvDEqrczxo
         7151PT4xfl/VJ9bMzpoNoD/7aWxRgMARdL5aPjolghJNbLxWyNIzipJ/eKPORErSsMeG
         Pr7UgevWL7N0jb8l75me6Fl9p+zuR8wnwVpSSBlwGypWFB1jHP5nYZDcjxN2MYMV84/t
         HjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770911515; x=1771516315;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNIQL3IR6L/g6fCcKQxO3ab9CjE6vLb1z+JStGO11LY=;
        b=kFxpVpAorcdcz4X+93BaUzDFlwzY5UYigAE9aL8ZyKNIJCa/s5F6CpKiHxS6s/81Te
         L16I0HvchnBxdAeCc3ZQodmRXvS7FDKC09hrVSpehfi6XyrgtOsIUAJOF9Czs6/XGJ6B
         7+FPCL9Uc6ZYwc5dkD3Am0C/IOEa/sLUmKsG/BfBf1Qa2Gd3Jp1whPh/+N2KJFFiOIff
         EX7eTZbVbIycsKS730hbtzSOmtnFu81FoLM8AvkwD3fXu0uwHoXTzYP/SAYoaLvu5su6
         5YnM9w00nkZxl5pvyLDsL/g2yHl10tkurctSMjSz1sfQuzG0xRqIrgVKwtsbj4sHeleO
         PM/g==
X-Forwarded-Encrypted: i=1; AJvYcCX7p8oCWsP/V4X/3HOP4Jzlm9Bqqn9gb9Jd89E6YCSYlTZ69MaimmOze2/AFL/ZT+bFqKg4Log=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZCUfwHy0QmHPN3kps5VePntgNyWD9bs3ia6ini54yoZB/A3d
	Hramsyuv/I1ga+/TO619qdTs9e6xFaBOGWi3PRszW5cSdI6Y4s6yFMmDoGcP58zrwEpl8xlW0ZB
	umnW77yVkISLV7fOLRQd0D8Bt/KGYy4atHjmuv/Umtz42lSjsmPUHqfu7P6M=
X-Gm-Gg: AZuq6aId2fvMasL66jWY8y+qj65dHJcwZj9nEgr6jgguCsaqesMUwI1JQdSGrXvMaLb
	Dtel1L1sN8y2Ua0CWE8KMkVc9LJR0wmYWNwlNJtvCs+wrS9yNXToBVGmpeHSx9JgeAAGi74TbU4
	Lq7alLgWtHLNac/Mw1l3crNv1rLCR48CxuXMsC2VQkY13tqBpTeyy3QoxIdN0oH03sD6D+h5S9p
	D6Ly2uPXsHtXwyiXseljO3DUud3+M/7vvNkR0EFlV+Y7HGTei28t1EWkKIUvNKX1EmydkZVpWUY
	4599C1qQLrjUIUsHgcXuCuhQ4q3eyUEw+EkOzJEmqhd5IA9GC7NOUvSe0/E29+fv2/OBzKSI4eT
	Q0coynJiPqmpAe1Zxz+r0BmTD8paCShEw5hLspTAG2FcHLcndy6U2n598svL7EvZOIjQ6KvO1TH
	O42q0NZUhtjpLUBw==
X-Received: by 2002:a05:7301:678b:b0:2ba:9cfb:2744 with SMTP id 5a478bee46e88-2baa8077336mr1166369eec.30.1770911514524;
        Thu, 12 Feb 2026 07:51:54 -0800 (PST)
X-Received: by 2002:a05:7301:678b:b0:2ba:9cfb:2744 with SMTP id 5a478bee46e88-2baa8077336mr1166348eec.30.1770911513619;
        Thu, 12 Feb 2026 07:51:53 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2aadsm3726033eec.1.2026.02.12.07.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:51:53 -0800 (PST)
Message-ID: <5afc9deb-e6c8-4224-b96d-5e8a2ebf7de3@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 07:51:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for Linux 7.0
To: Jakub Kicinski <kuba@kernel.org>, mhi@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260211173015.327542-1-pabeni@redhat.com>
 <76e6b68c-393e-48d4-9ee5-9e8d511ab308@oss.qualcomm.com>
 <20260211154008.24db40a7@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260211154008.24db40a7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyMSBTYWx0ZWRfX+W/Ak6gS+a90
 4gYuTWdm5+ttPyKt+2VQt0EoEMVTWZBIGNso+OFZ80P880EDC0Q8PNy5/VdGntgU+GzTr73pCfP
 AWMabbAFFqnxgs4UnqScd+AXGvi4LMlk+b6gc9pF84jSl8daWMojz8QlGG4yArqmPoGXB5b21wP
 r3dugEugY3Hy8tvaVoMq0wIkTPBk2ZQYX2mehdK3LQgSTt372ENChhuzpJgoAAfDF9oBF/p3/dM
 EQFCnLHHi7ICN51RG4LTQV2YyPU5TDm1Ly0mLFH3kEbLqIgIKilj95asWHD3gqFNOBJPHFWCeJ/
 T+d/OwHuasUuTFhWPQdtwNw3Hv7VFtx255sxtX9tIgOeL6Wc4CtlInAnufc1k4Oip+SqqeD3GbJ
 Ljue1MiltgI59JGB9/YWpu6sRlMk/bW7dGemWq4445ULJBTnRgfiKWl60+Xey1ak5ycFOC7Y0zA
 1e2RfNliHbLek8/GBtQ==
X-Proofpoint-ORIG-GUID: L6HE195D8pAtrVdxhNmNWZpWk196tmtf
X-Authority-Analysis: v=2.4 cv=dLCrWeZb c=1 sm=1 tr=0 ts=698df71b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=qNABUOcEAAAA:8 a=6jdU60nbdyzYgp056TkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=Ytm653ucTKQjCvbzLygB:22
X-Proofpoint-GUID: L6HE195D8pAtrVdxhNmNWZpWk196tmtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258469-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: 21A7C12F1DC
X-Rspamd-Action: no action

On 2/11/2026 3:40 PM, Jakub Kicinski wrote:
> On Wed, 11 Feb 2026 15:07:18 -0800 Jeff Johnson wrote:
>> On 2/11/2026 9:30 AM, Paolo Abeni wrote:
>>> Hi Linus!
>>>
>>> I'm not aware of any conflicts with other trees, even if this includes some
>>> changes to printk for the sake of netconsole.  
>>
>> There is one conflict between the refactored ath12k driver and the char-misc
>> tree. This was correctly addressed in linux-next:
>> https://lore.kernel.org/linux-next/aXD6X23btw8s-RZP@sirena.org.uk/
> 
> Will there be an effort at some point to improve how the MHI "bus"
> is structured? Maybe this is not a great example but we keep seeing
> patches that touch a driver + the bus. Clearly indicating IMHO that
> there's no proper abstraction / separation between the bus and its
> users..

+ MHI list to comment on this

