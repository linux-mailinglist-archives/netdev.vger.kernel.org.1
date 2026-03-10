Return-Path: <netdev+bounces-265960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ja/M1Xmr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:37:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6200A248963
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27DCB30315C3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57853ECBD5;
	Tue, 10 Mar 2026 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rn0hRge5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XFGQLq7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEF2C0F6D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134748; cv=none; b=FwI7gP7Mlnh8ksdjJSmODA5k80tojSX0SnMkCesHZKqUhB9zDRTcSCUjP+tpOpZmLtJF2M9hARgez1Gq1R0HxDfJx7lst3hskdJak72m5hGS4L3tbcOt0TGKOPpbAaQgRqx1a5ok91Z5a01efo2anAUVu7tUpES1e5qwGPztDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134748; c=relaxed/simple;
	bh=jZgtP750FUWYeO1itBDwt8X9mVUXc7Q5nFzfsL3PrbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtwwelKepM+rUkkpE0e4SkVDDTTxcXWrKhiccnCbHvOoZp9N7XJi+H28W+bZ9KpOnShpoBz1hx4Q1jRoGeFSbPTAqvidFdOdP5OAb6Y+jcItEFWm3pIs94GolDCSr1sTfxKdAG08j5e+QQlEmoYVa4zzXrMG1ueLTfqWG8zxspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rn0hRge5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XFGQLq7Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A91QhO3754541
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jlyq6GYdL2QqXeKG1FxVIJMJFLp6i6OBoNIB4BeJyFk=; b=Rn0hRge5rFsx81rt
	vDjwHSRCwNxH6liJSfgMd/bhrYOx2yId/06ZBdMu98dRRZbiVkKjytuw/Gu6reYU
	GnrZo6cCxGFCKezQntLWVz53BRjiTZnHiZ9+CwigzjDQZe+EnGmmvClfqVEjlj79
	NIvH6tOt2479bvHcGOhB15dkiM9jbSsKbRcPPhMuu20ObulASDMOu0x1fyUcJDRi
	0wBiIT/Q+941mKH/zPGcj3KdzjXhK2bgplS6qPYIOqTsVxFiwKLAhYkIpfpZ0T/1
	3a31GuJ6iV1Kn8NlWK2lesr0QXVhisjLXnGdjirpAFztgCbTw8agNk+uiw/xvorz
	Y29TpA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477jetr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:25:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7fec8d44so1274728985a.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773134746; x=1773739546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jlyq6GYdL2QqXeKG1FxVIJMJFLp6i6OBoNIB4BeJyFk=;
        b=XFGQLq7ZpZW0eVX86fI2341e1pnK/QzGEqD1tbc0rQCuiT45/VhOLbtDk96kdVJUSM
         iYj86/rGAM2DAl8wig+ROvBz/seX4OFxVi3AUljfbsrM1PUDpfcyYcv24MXESZst1spC
         j7DpJx9kk93g/1Mi6XG6ZjZyHX1FkD0ThdB8x3dFy0nIrLKRFSN/8kqOB86+L1AhCylC
         9wwdWJKpTZziTIti1i/bXe5WJCEqMPHxYiwA9efyjjoVJw8yULCQyT51fRY3xXkH+ct+
         PT7Cmg2kxHRCkucgoVBQ/GjqBKEgafSR/+bZJ0aJsHdQY0Jzuk3IDDDR837/3SmHx/L3
         mNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134746; x=1773739546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jlyq6GYdL2QqXeKG1FxVIJMJFLp6i6OBoNIB4BeJyFk=;
        b=G5uf3W3G6MDaZLiEQqLVJOzxUKy/fMy9Sikot0XgINlkxiid31wt2pQlSR/aYfuLCH
         g7SCI7BLW5q5WwFMtdQlVgb99qSrFmuaFx1A+GBpLEwFeCAIfkQO2oJKmUxU2rqImpWd
         fAD/O0HICtUrcboDGVWcrUVYI6mk56s0yptlhJIYJFlWXQULJA6+ftN138qQ0i0DKpJ0
         /sJIDo81IilH1rOnpHkcl67cIrneFkTBNdyICGyTDbW96++sgwDwPTbw+5fCzXG4ZGQr
         o+hywwKhiVIl806xAPirKjq1TppT458Aa+r59fLGKULTwQl3kx4Be6LDgprqEA2SXmpx
         shRA==
X-Forwarded-Encrypted: i=1; AJvYcCWx94LQ2bSueEFDgjAd7WO7Yr0s8gEr5BD4ejR02Gn63vRthz/ZgFlOf5J4WW8jcrhbLuyuofI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZBo+NToDNqGvSipIvK5RBWdo9Dj03vxGXAPLQISVHwjujzdm
	LGUhzexigl+tq6V+WUcLjclU0DPEjCZdxNtD3upOYeqQSUoD3+I7Advb1wZwOZ8Zl9zzJvzrkHS
	wuSDvDa9j1lqka68V4My/lfD7Q89bfIvpBkv8kHBJjO3b6fIjICAL1lxfcnA=
X-Gm-Gg: ATEYQzw4NFJ5zIhajOjnqeHeKlfJ1ta7sQdrWeH2DT/KTN32Hja1/tw5pZQZk1mZbUd
	UW20tMIWeCKIqCZvRUcDQgN1Uw3dlGpOvqE4PPmfxObOBv5zgFGZA4UnbTzCyu0QCV+wZUiTsBl
	bEZK6qjCYA12+6N+KPpsi9TSz83bqEkaAFs4OvG4HED5wbExd0oASyHQcXtz5nynBxn033WOuju
	nbwk0ddussVRUlNpLXnJafoigF+SHYTWngzNhnFAP8GjiZb+ENqkFNUiw3CPBDNrkXAdRhgpAUJ
	msu0NEbICkWAeunNGIrXwo3CB0uNutkZ+pjo5v8XTymOxljA5zghALhJ8tFB/jGfEDtg0hOrjOt
	oGEUr1LRx7+haJpu8ntn0dRqu90lr0fv2zle2ythccVn0Mt5W
X-Received: by 2002:a05:620a:1a8b:b0:8cd:8938:effd with SMTP id af79cd13be357-8cd8938f3b6mr778290485a.1.1773134745826;
        Tue, 10 Mar 2026 02:25:45 -0700 (PDT)
X-Received: by 2002:a05:620a:1a8b:b0:8cd:8938:effd with SMTP id af79cd13be357-8cd8938f3b6mr778288385a.1.1773134745396;
        Tue, 10 Mar 2026 02:25:45 -0700 (PDT)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b942efb5bc4sm463208466b.30.2026.03.10.02.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:25:44 -0700 (PDT)
Message-ID: <6da0dea5-da15-40c1-bee0-6e80229ebca2@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 09:25:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: monaco-arduino-monza: Add sound
 node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
        geert+renesas@glider.be, arnd@arndb.de, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-7-srinivas.kandagatla@oss.qualcomm.com>
 <mnehsjwwp54sk5bck32emtw3e5t66b5o447m67po42vahydkv2@cdnc7yzzkwlx>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <mnehsjwwp54sk5bck32emtw3e5t66b5o447m67po42vahydkv2@cdnc7yzzkwlx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA3OSBTYWx0ZWRfX0Mc9bS6Z+/o6
 0IsuvDG7AAYHmbNaeXh6PbfjKxTRRyMoUC3cTGkwoo4BwRGxg1GJjXK2p2jfEQUVAA1p638tlyf
 tK1SQgfKnHOEJ6d1s/znxRiaZl7sxxqAoQAzRQS+s1VT0MrpTMtIMcRCYS80BDZ3CZ7fEYtFV2V
 mZaA1s+7vTvGr6R0NDxUsGYQJmkosKrh8zidlHpc+ouc79lJhmByImBni66ZpXBt/kfughqAinB
 GoGOpS4miRobqIiW7DifvlwSip+7c8FpyGc0mlM3XygtZD5M4dNH+cSAqIDBHlohREEd+HIjsrP
 k49q3gBTd+jHCXeXqqFdssRXWDdiNC2msSv9iTngLmky6hWPYlWk7U9aaFp3Y9dNf1xu/t0wY38
 G2yKN7NEwVdHMyUCkmzNjL+OPIZqBqvVK0DJE+pOQSKW/AOodwTTL1bZ8LIB3jyqlg5P5lvE3so
 6hguSRjg8c+lEwb9p5g==
X-Proofpoint-GUID: 8rU0okm3ng0EhwbIJp9TFMBJCC0V8nfy
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69afe39a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pNCWrsc1MSpuvQEHcIIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 8rU0okm3ng0EhwbIJp9TFMBJCC0V8nfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100079
X-Rspamd-Queue-Id: 6200A248963
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,glider.be,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-265960-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/26 7:38 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 09, 2026 at 03:24:17PM +0000, Srinivas Kandagatla wrote:
>> Add audio support for Arduino VENTUNOQ board, which has Headset, Mic, Ear
>> and Lineout connected to external Maxim max98091 codec, HDMI audio
>> via ADV7535 dsi-hdmi bridge.
>>
>> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  .../boot/dts/qcom/monaco-arduino-monza.dts    | 66 +++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/monaco.dtsi          | 55 ++++++++++++++++
>>  2 files changed, 121 insertions(+)
>>
> 
> If you've added the file just two patches ago, why do you need to change
> it again? Can't we squash this into an earlier patch?
Sure it can go into the earlier patch, will squash it in next version.

--srini
> 


