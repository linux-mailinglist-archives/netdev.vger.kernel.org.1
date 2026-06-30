Return-Path: <netdev+bounces-303154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EmSAImC4Q2oMfwoAu9opvQ
	(envelope-from <netdev+bounces-303154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A76E43C5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:36:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TGPyUaeI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DRL3tjB0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303154-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303154-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D739A3010DF1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86340BCC6;
	Tue, 30 Jun 2026 12:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36E40DFD9
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:35:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822958; cv=none; b=bsU/UH7aWsAseOpJ79dkEeIaopRFVPEK8Z75xODalDVZGpSVdUYqeX/PLgVzIr6H07+xV2ergQUUqvINHy+Es+FLl6o9GRaj6yX8VihBOhypFdBBzoLXTPLCjSqMnh59x1CdVgKv7NZR2wlQx+9dINI/LOeYuwSdjwPB19ZWW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822958; c=relaxed/simple;
	bh=vLLmYFCrj1ZpLwPqXPaPHpgTs7bbyh+LFs7PAoMXyh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfQl75Xiij6Yr90wmvZiLKz6LJrqOaIEE1S6NSW8br5uxeAN6AAXXDY0s8wkr9HtHNbDRZrIF7rpAxTWZ3h9NlX68LjgvDYKOuI/WukBFuwmoGmu8mYEkVyLmCO+xjMsbZMIA0SD+Odo2TFBJh0E8v147sTAk047K+3pn6CHV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGPyUaeI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DRL3tjB0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mxL91612151
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=; b=TGPyUaeI7PD0l3ZD
	RXUKwjXocsLqVkkLw493t61d5m5eW5p+GjrblI3HaXwFRFAJyCt8ufcYOL5UMpRs
	ubYftG9AINmVA1xjbKA4MA4O8GENkvzEA/LJ66khEL8Q2SnIjCkWThxNI2Exinrx
	CwNBvO3PSUzn8cYCaTzD5Sl6TUsgjTLZsqkyo89x6+0b/eEMdkChPeMQPDfXxqtc
	xb8mu5qnGtm9zd5IB+jXQLsXM9qt5GxT54Fx/vfUVEYcCnYa9T7TQ6r+4ITYjvUP
	hEA3g2zC/RyAeRNdFTCngAhd1MZnNOYdxGSs2+9rKxnzRV74z1aCc8adLqc1zcet
	HODrGQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441gtm6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:35:50 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-96920484543so145679241.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822950; x=1783427750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
        b=DRL3tjB0C1m+OndZqS/nYckhtm82nBsO+yYyKPkTfoIPib/7yW6gyUrs6KCNvlqAjW
         +2i49AIzbuscKiBkR6sW5K+3bNwp6TPXtVagzVqDJUZM5DztcPlaL4zScLasgh0EhzhG
         UXXwaGy6dUoFe2LcuGAKpFcVWiOZ3UhOE9j0i4o9tvcntlSaerDSWcyvYq6+BztCvY++
         A9TPvPqxATrs4ZeZYrv4bfbm0n9QSKankRoPibv1SYZ8uOcyU+Ga6XIppjt4QRDNv8DB
         Mm41e5z2LPmBrsIsWBQzOUXw9veyw/HItWOeNmPLxb2FYbwDalIRvLeq5aqlvU0L4I9b
         ntzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822950; x=1783427750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
        b=Pnp3uuWRl5wr7+DOqz5YXgTCZE7fiSOPRYEh1Y5bXI46Yp+w2jNtN8316KQ/K50iZF
         qxm4y4hq52oZtd/tK0WNpv1OR+h+zujdhlcXO6FPn1Bz/Rd+pKBBb+v5aPBwJIohfioe
         5LzE77OOzcgrCtlstRL7M7Ze9FgOpIWmCukpoBdcDICy/9clDerzpEpZcgPEYHF38njg
         4GhPraNJHXCXIWjiu0NT40b/smJdvLrLIXO4fpHLhcu6Zu2MQLue4Gb8Hy8EFjN+hp8v
         jqcpAUZpjjOMxju7tHkn1c+9i8N5gjMObyRbW/KmQiVTyfe52pWATGyZXrNcBLK8rY+d
         Pe5g==
X-Forwarded-Encrypted: i=1; AHgh+Rrcqg/Tqw0dHt37LO9L7hk+Wi+KvfvEkM5xRl+Oev8UUnbR6Kn5KXaEZt7YmlxTRSlF1wA5LwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZWzSDMpsmpRfB6ePCR3m76nm+EEOruRoecvosifaWWA103Oz
	itAtx4UzGS4SoD3Zg5AXNL70ch2j1DQQZCkNiLG/aV9olpvm0ipJIUwMSMYzLlYIRU8rpZwh8Qf
	hPoiylWXdyXLgTqM1671/TBjMWuX6iEgL/AMh54qF5HBf+yc5NSeXDYpuX5I=
X-Gm-Gg: AfdE7ckKFFfjp8LebeZhgGsjE3BNx1vWkN0edBrfXIRfVmAUDc9aTTf2iYrrQ7wjatB
	Ja6lYiuE7irzu1fNVveiSrweEd2VecsNTyc+pnlnnjY8YXUIqSPkbwT+L+baLPyUVyZfoT6lOXQ
	8vdWz7KlVHYmHGOt8QnppGb5FiCSu3gWs3Tfily4bnL4Ao+Z+HTC3f6vma5rk7QtKXEGCjwSYKP
	R/zDqlVQlGgWNV2uK/++6CzraSF18viKAnhKVOzJozOTlrlD5phNhwU17jJ5impDdb3DKJDKKbI
	dIdCqJoyvSX7M68tH577y/xhdVfPEb+de5zU4bERuGxWLPVeUfiUam0hEG4gLvYGXf56HK6dRNA
	8PO0PWlw6aUpmdh6L+THRFVqfRWwHizAVR64=
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id ada2fe7eead31-73a333cbc93mr634708137.0.1782822949910;
        Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id ada2fe7eead31-73a333cbc93mr634672137.0.1782822949547;
        Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69885c9e8e8sm441434a12.16.2026.06.30.05.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:35:47 -0700 (PDT)
Message-ID: <049a4aba-1c35-4a47-9a34-25e76ae8e72d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:35:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/14] remoteproc: qcom_q6v5_mss: Switch to generic PAS
 TZ APIs
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
 <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX8KbCWeEn3dPh
 hSlpSnl/yeS5L1+sd1EDr2LKOfQZf0JFsgOg/U24l36+ZMZeNm23TtdAlzqhPsvuY3/kj5KxLY7
 unqspBpr/0BLAo/7YNHkH3OdVvTHo88=
X-Proofpoint-ORIG-GUID: _cK02LgxMzwLtJKlQSnvTvgn1GqUBbap
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a43b826 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Vkn3R3B67r5ClizzeDoA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX5PHT+xx/l9Cr
 ZPugAZQEwmMf0zz968LE08Fh3Zzvwg1Q+Wkls/XHst6p2YJ3zyD+GIA2tEK4tVq7Hixfwq66kWa
 8gWoPMgWjZvnIylfNsYUldNKAJwz+UTw/gspYuTf5ly/6bEJPlru2Xd0QJE6P7mLEkOMhq1j3i8
 F+E7rgsn2j3q+ZAdGhwSFpSlO525M0LPzDni0bzhEw94yoZ2IY1WNkN7tiDyHk3CFz5f1Xs8RgO
 Cu2hvpzgt14yERtW8EVY2LMk01WzVFZmzbYCsmHDb1W9bafmjDfWxDA4svyE+jdYgFvUfys+SG8
 vZ4kpYgrNizUEqW452Qs+V3TeoRjFIvShMyJd6QKFdpI+PjfulN72bwdsmH1Qh8BibMrZQPOJbu
 IgcT1I5oQRX/8RR2JMqvJfLEKy4eAWIrC7oBExwDVpqyUK8MTDmR/ZZxHaEdIY7QETZdDU8Bns5
 iI/Ths8aau2AxAsMg9w==
X-Proofpoint-GUID: _cK02LgxMzwLtJKlQSnvTvgn1GqUBbap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300116
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
	TAGGED_FROM(0.00)[bounces-303154-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CD6A76E43C5

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
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

