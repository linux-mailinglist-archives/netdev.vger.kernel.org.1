Return-Path: <netdev+bounces-304445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wnQaNvZzR2rEYQAAu9opvQ
	(envelope-from <netdev+bounces-304445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:33:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D29CB7001BB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:33:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="LZsngP/2";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=fwbVDhOM;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304445-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304445-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D102930ECF47
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F337104C;
	Fri,  3 Jul 2026 08:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A44360ECC
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:08:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066087; cv=none; b=jA5E+WTNCL19p0vSTQhceLA9zUUHSOXRMdZREqlP1sR5wnXCZGh68ZXaNdh0Qk4J82sdfwDZMHjF9hbuKBdZMnbFy6YteYcxv8pmw6B2GzuWEUA3BULZfLA1itp+RTPB9HZuxP4I6VLbwTGcURv27a1kTgWCcDxF19T2+8MPmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066087; c=relaxed/simple;
	bh=SABxmrpSsVm8A2Mic2cd6WWMecfoTNnX7lTCRtSFO3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GMPkZiqbgSfpF43lbuMw//8puSbRsDVKs6hP5YjEq37xsQQV7zN/0P3/ORVWGLJbX3ahzG9j+Hi6Y56XY8Y060hlxSi64RHFryq5GuZ0p05w/CulEeigrIr7IiDaUxjpaXDzPhiedjZjYuNcq3yJXJp5rTABvRFA8lSOZm7Luxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LZsngP/2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fwbVDhOM; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rZ6R3136108
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 08:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4V2s7NHyHN6PrzMIzpSsbSssKK5Q81QPBKAbT+SxC8=; b=LZsngP/28qsZ2Wj4
	Xr7V3rB98b4xXBNvUz1F2mFkH4NWMlSrQCNJiSezO4Zl41Hyr+3+ydPZYn/pEnVr
	3T+xYofnGJojzCnpp0a6QnqvUVV37uxhO7siL9np7kUHcuOY5rrp1yyphdMRZrFR
	jLfoStscZvA3iqgmAyICsI+H7a7Iz1TdFvd1epWJBW5awBItDQDFc5t+4UxC2Juz
	GuHo+0helestKCp3um+pq8ivmakd4OJmeN71l5Kr3GcfDmb3hCnAKoQiwrbSYik7
	S8cGMKPzmHqwa8tD40OT4TrgA/e1NjTRo496A/U+1GM3LGvkmb2hLTHCozABIsVE
	/1HRCA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59b8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 08:08:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37e5ef8299fso376958a91.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783066085; x=1783670885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V4V2s7NHyHN6PrzMIzpSsbSssKK5Q81QPBKAbT+SxC8=;
        b=fwbVDhOM23im39T0uEnIxE77TbH62GqkFOaNk1KOPfBr5toMifmUNS60t4lIZ8iEPo
         ssvciXQGrkNNl/kSK/mNKtkIJfZMrWgXo/NNKNy7wdwHaz+Tl/4ZLFccPisVlbhF2epq
         Qash1QrN44AjFyOUOb+IsJrOpM0/5LDkDbvUqxjwbLr/j4GGnlIeeWQT2k31duLf80AU
         Vn+1Wcykq9ErzbTHfkUvvHGUpS7aW8BhnLUuTof/iutmBZxU8kx8TYqRk5VLZO8ro+hz
         akFRGTnvbxeu1f8mxkL8usgStUAejgb/LVh02ZgremCl7NDyNWfI+UOiA88Nq8f4ld7a
         Pn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783066085; x=1783670885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4V2s7NHyHN6PrzMIzpSsbSssKK5Q81QPBKAbT+SxC8=;
        b=jWaZ0IQmdWbjt1luSOKJCwLvW0A0RdZ9hRUg5DIrbM2OZOsdaiB79aWC3AeLo2tpBk
         nSj5q7z5cjlZkD9UEamVcwo5A/Yip8Sd6QLlFTSFB7yUCLScw5TcBduzjp6jTjApmTYQ
         t9nW8fu8+g8MdZRnydBPGBWxqgaz3CGqyxoHmGsBA6ZOGQRkdejkEzPP4EtyVJSuqmjx
         U3Wfzm0KBwWbAa/neTGx5hVYVGNnjUS37EMjV+4+bgQxtdKQQgBKJB2rbHO7CYrZ1Ch8
         WwKZhGVC49xPziLm1Fp4NODIg56eFe/LX5Y2b+TxwB8mvgsPIo2/bHbXe24JYmo03aCF
         eldw==
X-Forwarded-Encrypted: i=1; AHgh+RpU9ZHrSPMPDOEp4zYvu15mT86xvvOAHY1WQHgMiUBd5YuM+HlGyiW4c2dnYJvANiMOP+oZQng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWKY7Kb9RQMo11Xg/2uQPzT15eic6zMfKreo2rVuhgWt5Eqv3
	8/1MZ23Vh37jF1dUQMcgKeDivn5/bR+UxUsfBGg7HlUCOXr0SCq8WMxXrOM8qvFxAvq6GCscjGj
	x6ONX01AeCTLqvy2I46rhY7HsdoTxCZWm4ftlGQAi/4ujozXu6gpzcjsnr9Y=
X-Gm-Gg: AfdE7ckt75T2NZ5woTI0l4gT8XghW0K8e5NYhD4JggCbotyfcGspNh6jl93dU28rwUQ
	BiSFHu1TyOK02WJVpW+zegR6LKSmcDUA1cEYqmLtgHQFYY34nZPbnaeOKVwKNFRcGAZDlv6Q35d
	HKnvOvTrPmtJ8HKwuA9UjkQ1l0CTHNmtIHHImIEw0ihalardq/+Iter0l3DNhufW07b5Jj7XZmy
	z8PApCBM7CRSwnYhKjcAGqtFUqNoiWJUn6N+NVmt8876y/ns+nDTfvFJUd/iTIUumx1AcDuRS2m
	RS404HuhbeH2RMCjedAB/0wJ6+4KRhaZkosg5xdt1RVp/K6yef1J4vep3zJnZkkP1YItIpGjEzs
	P8okQ4meQIOzjQuHvKu5B6xpS8TaJ+QDBOfIR383RRIYZaKM4/kGz7s3M59HMUqm9scjcvUXmwV
	E=
X-Received: by 2002:a17:90b:1c8c:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-3811f512193mr2505712a91.2.1783066085035;
        Fri, 03 Jul 2026 01:08:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1c8c:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-3811f512193mr2505681a91.2.1783066084488;
        Fri, 03 Jul 2026 01:08:04 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c1c68bsm599047a91.7.2026.07.03.01.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:08:04 -0700 (PDT)
Message-ID: <44393910-8fa6-4580-a70f-796c844e4639@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:07:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ethernet: qualcomm: Unconstify function
 arguments passed by value
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3NiBTYWx0ZWRfXw7fb41ynNuuc
 zT12ALuwEezeaCLM5HIr8dbufvFOZvaElaKspHWZVEbofErIPb/Mi5TwJZ8nmgEut4y5MjMN1k4
 OUuYTCy9MVOD+GdBIG2HTJ2NThLOshQ=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a476de5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PaHDVFjmPNp70HpvHSgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: JNMUr3K3c1IBNhWTA32k8ROpG-x1krAr
X-Proofpoint-GUID: JNMUr3K3c1IBNhWTA32k8ROpG-x1krAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3NiBTYWx0ZWRfX8vhi1nc/KlD1
 4gwsrasKQ/kohhiOoE0PVk8C45IXRXE2WT2mn1Wmjh3ZNADTDKvbqahFbtcGIbojPqLdybi0Jfo
 LEh1cZOTjdUtHEe9zicEpea+FTgDBujBpRNz+ml+vQpLNfUQCOOooQkK++mw/Me54n3Hv74WqeE
 5Z7b9qRjln1CV/R5pej7qQwinVAx16KMPGo0NPtUnedziAMzGAAXGrz/RigTAiOminHIwfwu/Km
 DlHqi7cyqg77I01H9ewGfyDs/vFtgENxR6C7cI7VSOX8HA2Zckt5YW3cHBoY2bvYlcyJ59KhFB8
 1zJP3ONiuLtkwrUDsglTj0kNtPXwmLxS3MSvxCZgDGWkYc7nCh+CmC16As8PWe64z/wlY0Mc865
 mhjEAYA/XaIr6V8vwEFlseexlpYfdAUQQQOSTTwJMHpUOwr81a3dhnV0RQc5naBKE6scHmzNb0k
 ObNcP4lq0b0OXqc3FRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304445-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzysztof.kozlowski@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D29CB7001BB



On 7/2/2026 5:49 PM, Krzysztof Kozlowski wrote:
> There is no benefit in marking "const" a pass-by-value (not a pointer)
> function argument, because it is passed as a copy on the stack.  No code
> readability improvements, no additional compiler-time safety for misuse.
> Drop such redundant "const".

Reviewed-by: Luo Jie <jie.luo@oss.qualcomm.com>

