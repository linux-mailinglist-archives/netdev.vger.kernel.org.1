Return-Path: <netdev+bounces-303155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nNkID3q4Q2oRfwoAu9opvQ
	(envelope-from <netdev+bounces-303155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:37:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 444E66E43D2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:37:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hMAv06XB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CyuOJQ8a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303155-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303155-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFE713004CAF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BB40B6F4;
	Tue, 30 Jun 2026 12:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8E408617
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:36:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822997; cv=none; b=bzlJNeEtQPtD2JBNNxbYynVV2AsRvW/2YchFdgFyYkQn3o2Y6cAdY5HGEnddZTFFfBSTY2ys+yzIbNa5LEjbQqdpKTYjdQf1so1h9YrS16I2OfhioD6NbSsNibmD/W8GFetuD2JSVfGh+4FOnZd/9Jzxko5+kJMGbaP+M56A3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822997; c=relaxed/simple;
	bh=xalr14ue42EEz8a0KF+uv2BCteqC/Z7u/YTLcm6EW80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAufiFNes7xXG2DYa1Q2amDtUDGOOK+04Kh3QrKWCqOVNlBuheQw9tF3E6G80hdydIh7KOGtBnR4IGduL+I4IqMLCkZ7CVJHoGaof/17FfuO7zcUBcvYXifLCOM1+9fC+pa+5xTA3fYn5q3c9J6nNzbUq7D/ltT5xm5gVM+Iv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMAv06XB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyuOJQ8a; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9muWA1604517
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=; b=hMAv06XB7kVL6dKY
	+mHGw3jLF/V8VbrZUImQfj2Obz1kqidz2H33ovgOc19u+mb+yDLaOpPN/kUCihqJ
	VxyDFRhHHF3LE+BMpwV25kokDuysV/+xRDcxCR/nksSgx/Y98VucDYD/N4RQvqAS
	RfzOiO2B+ckua6pWwG5ZmOxuB/BsGWc4mZ8/uTlRsGQW8OZvq0FVIp5Rwvm2/qnM
	rHSsXx4FPnD7merqI3IYjqYhb4n5YQSq2ebVHHhxuIgh4ogpK92nyJAxaWQOyjrY
	yPhPlQTtcEYNELxEP7xiMOsLVXEo0PekJnEHp1ItAwYxkBJailhxbT8YtECLlLUg
	7O5slQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fj7eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:36:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5a63e1f2so23539185a.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822995; x=1783427795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=;
        b=CyuOJQ8aAG8xUVeyvM3TPGSI4qTUS9FXv9stfk8bBFZGV1MQORxD7ofxwlowYGd+VC
         7v3o91fY8mlC7ZL1jyPj+JjnoDwj7yaBeg55nZHPM6RptrMMGTXm8YNRlkmddvP0d7Zl
         OSMy19AdvsL2kYc5wBfOhgjw6N9KCP3yqdE+qkAXc/o6hP+JYI3lZY+Lw6BlKnQCts/B
         BTwvPo7wPAQ5FQl8cvPfPvIbWqCLt6hioKVxKAltV79DXQ1VvxmerrwxwMeh+7FqgEpd
         q6wZMQ2D9MCBJxpXXEYmtUbYW+y5LLISRnjV7VV7/Cb2sssmm6oxm0RkKo3LA/5Tkmdf
         8+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822995; x=1783427795;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=;
        b=pajc2/Ksne6VZn0HneHfTWRMcOt0yzHGM1h28YkBcHDC9zl6E9kE5OfDd3gB8R6RAq
         nKMQVIrPe1RUUx5bb940VKXTKSn7Ym+KDQhwdVm+grVkF7pm/ETf3n7T7VSpbOsiXtJ6
         2Z2ZChbzUKLJg3DdIvyKEsWbFmx462k51HjXII/fTpm0giWlvyjI2b3QJpGlmvq+cyL7
         Rx4PNioZCEJVi3PdM4g1DsDL3gOS4SpTv/ocYSI+g8Ao4TfYERpfKe1YBKAcSgB2qHjK
         Q9cDqcjYfoj4hvc+XIRh2/4KV43qIAJQpXj+vrwRvL4AEPCSlYg41pS/9Aa8kFErblzI
         h8Ww==
X-Forwarded-Encrypted: i=1; AFNElJ/5uGbDF2lH+gKSEk/V8cTMG2U3G8vjK1HT7LhYaoUadAZuYm9ug1LCJ8e2tuL4rMP+cKNiqFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy66MvXzBYbdn5H1LQE5S1HgrU6MlwNksyN5zSBjj4Sio0AMgY
	EOf0Zgonn2y7Lw92DH/6mDCulpBL5XkzPCZao4UsQiezYck1uleY5agm3p27RAddxCymbsfmg45
	LQNo7gqt5uc9lI8RbaT9DjqPhbGhontnwQb4lfTPQPvWYTogejI2aSRiFbUw=
X-Gm-Gg: AfdE7clmkRvedKWD6o+9IpV748u8abypT6e4rsI9ch8pEW3+3YkLAYdMp1Ld+NMVM78
	XslQsbfszXEhhYuu/KN1faCxf7CxylotvjiDfROOmExzY0IQceXaznuwPM/hNzZ/L6WUa49djDg
	AM04CoLGWR/JxFk06WRZ2znUoNrTJ5NSsJ4Sx8GFPForuetMrFwouDFtYrXESSs2ZFcer7+7BkK
	rA0JCOSOX5Vx+mXLRpQhz/r7dlqunefaFWq1wxDArn+y8K+C1IXcbrNNTboFrYQFEd15cBnRThd
	huEDaTSoKpeXHVpkf4igrO4wgrqgl5l4QUQKQJEK0Rk4s0eaO+5WgKQocw9u/nBC1s/8lgj6ok2
	y096llFbKa5asQTKuwB3N1hJsuLPSui5j5Ak=
X-Received: by 2002:a05:620a:2a13:b0:92b:14bc:7936 with SMTP id af79cd13be357-92e6247af35mr377072685a.1.1782822994706;
        Tue, 30 Jun 2026 05:36:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2a13:b0:92b:14bc:7936 with SMTP id af79cd13be357-92e6247af35mr377067885a.1.1782822994089;
        Tue, 30 Jun 2026 05:36:34 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f48b35sm115852066b.46.2026.06.30.05.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:36:33 -0700 (PDT)
Message-ID: <6ea161a2-d959-4028-8aec-175b73df18ea@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:36:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/14] remoteproc: qcom_wcnss: Switch to generic PAS TZ
 APIs
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
 <20260626133440.692849-7-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-7-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX+f97oldKbvxj
 8bXsMYbJyYcoAYaFaukxYVs/iTgaJUiHPISj6kol/gDGHCZHHTMbrfod4s/24vqqovfKs/M4Gzf
 dmeTSg5yEz8gCKZcRmAXr6JJEAmLKG1beONgw/WE8q6gzHf3I+bZz/CnBIL3D2L4mzJa5hduvhs
 Ua8zNp0UphYjZWJfz6GkEmTSoQ3HaeCGNwlcCgImLZE9fWpBlGyx/HlMHrI5T1gpEV9PiTcMHl5
 I1RenVh2oNkCSBkYz21d1hEC908X6Fh+Wr/Xn2F/J8IdC9riHLTShPxg1DJuCq/GKNUmswjzjJ0
 gacJ8lP2xfSUVetu3430J4k1hH6YzGcxSyIJGpWiCzad3mtb98RznMetqUAI2wx9oondndxWlGM
 /GKS9eCrf4jx6OPhWcsmb0MM7q6tirc+dOvxP0TtwcgwMXJiKF4ilE8lKecsid0dU1JvgXuha/W
 ZeJov7FKRIU1L+oEOlA==
X-Proofpoint-ORIG-GUID: h0rUHqFtoNpfNFd8wXQLykGx6K9dTWV4
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43b853 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jx0KCs2Px1p7SxVd6dwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: h0rUHqFtoNpfNFd8wXQLykGx6K9dTWV4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX311gWPbOUx3k
 WtgW8A0DB33cw7oNzKzpU9alfaM6ZWaw4pVQBZZGKt2UqQD1LGhwCEGNNt8im7dHKRjvrIP+cCv
 MwfsygsGpKEDy8zE+LGCHBP1xfeYd4U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
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
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	TAGGED_FROM(0.00)[bounces-303155-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 444E66E43D2

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

