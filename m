Return-Path: <netdev+bounces-303142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A3H3FgyzQ2qTfQoAu9opvQ
	(envelope-from <netdev+bounces-303142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:14:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 144A16E40D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:14:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DeBXoe+w;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Ah0gOdKn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303142-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303142-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36DFC30668DE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5540B381;
	Tue, 30 Jun 2026 12:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC2409637
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821556; cv=none; b=r6fVb9PE6tqtyizU5vTmI7N6bfCucRkb3JZ2FXN2Fi+JtGCays+Q/VJj2UOlpe0X/17sK5G0y2/kPEJVz9iSr02eWLeNdIPQ68ikaOypLGfqT7U5HxrbgCGiN+NyKEbKtW7YBkNfmdySEZB/xKKQzz95kl4h9r3wnlIFv89apl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821556; c=relaxed/simple;
	bh=ICVFc88cteRkFnOqK2r8PitO/adADtUmJP+OvcK0+uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZB0cFkr0esEIxuJGVy3PdsxcgeLVYKij8PbYgirY8yOH7ip4m7uitMQXgwDwmW6/0KpDB18nknJNMUx5RulaO8U832NZyGX6LTJlJpC9g3JjxcwY2dqw8TGuJTCkW3tzjPZox1gj6gl284R9Isoqc03Df77xzpZ7lPBot8XGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DeBXoe+w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ah0gOdKn; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n4n91508588
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=; b=DeBXoe+wzRpw33/s
	CVnrtcqbVZXPgn6aEIn1wWBJ+E1acsLKn5JktQBYJ1c3Vx7v3bJeb6Sfff2LGCRb
	P14F9T4XdEDtgEHXToUs+n0tBfDwT6HkTBpS+QWhTgmMGmu+GVWZSKiKs/perO6v
	cnSwjD/3ISf8pOGupOwNoTC76boV1cEYQaRMzBaB9EPqLjF/YQflZlMeHBRR/V3U
	nHZG7oo43lc+J2bi2nMueoNK4Lq94vHJyWnHgDyQYnlMMhtiNY6J5ARy269uCuzO
	tduh69GbdE5Es0Th+848ztOGIcU9ec7BQmfZXeNtwJb35A3jhiKormSghdh0rA8q
	EFEcLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j3ea5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:12:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8ee253caso5157721cf.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782821553; x=1783426353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=;
        b=Ah0gOdKnMfe1KlWAJWpaONApMSV5WXsghEC9jjVxWmMaz61UNPo7qpGw1mmrdSLd6Y
         qmiQy19dnISlpwXlvCsWoy6Xt2yh4NhusRwMS4G7SFLRZIeQcR3AgseMs5rhaLX2t24x
         Q9O2DQdyVvMxxPS0h/Alb8EtN1qjYxW84s1unN61wRVNrtfw9yeJhx6w1GA19s7j1CkD
         25SLVfXDzJbtSSHgF8isJ+C1ChfsYGcCMtzbpvJKDYsMKnoQn4hEfW9BQTQSVD2Dzb4T
         zOOzSHaQjaooztYY+rThD/t2O5O6Ion1GqXm5doD5YUp/AJ0d7tdkgmJfQZV9TRf8shv
         Wzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782821553; x=1783426353;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=;
        b=nJkizExvZvTpIo7N1EmhVslwuX/AsltvqHKlycY+11Ha/jOoIwq3i0chMqkQFKzfJK
         2VLH5IFl5TOp52fPGp+i/GRblKnoFh2PsAHZ2oL4adQAgi+UcwlO6u2oZsZtHG5MqqOB
         rPBNGBZvbmPrY6/v4RR6KviFu9+Lhmjt7lUruOTjUs/CX1DuUqlkUbfPXFjMOrehQLrG
         XZjG2aybP+V0kyQrxt7SC0yPO0ozUgcUzNay8CCtBGB6f6+FvV/FYuLlQ0ST5NOlMy/D
         ZSjUzGQaiP3u9gwub37JEgE1PS/rMq6220n/3XbyKQTUlmAZ/SdReOXVDu7ewappFS4j
         Jxaw==
X-Forwarded-Encrypted: i=1; AFNElJ+9WTXD9B6UrHtGxFK4CmfulSW3vlRSR25uJaB5FHfJoV78lZZFbFgSmFec0lfMSIIz+TPXU50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxn4Lgp3AS1O+8YOZsWbi7xC6MC8zchjqLHOF+Zj0Cwk6qeCVX
	EyB8BfYVFZXiSBEMb4h48Hoizf989VS3aek/4F7EsLfUFzONp2DheVGgZOtWDZz7oDpuxA+0S2q
	/+JnSUCcg+yDjcBwJCru1FSLtl7NJ8mzZRSIlRBg8ZMJ2RqwxgPElAgVdaB4=
X-Gm-Gg: AfdE7cn/6yyzVrkB2qcCOoCXG61M0hem7/6M80inT3Zdhuaq6l73ojdFwUZtL5JWMjn
	g0P67OShdSvdSPcRDUKxyRMmo7lKnl5jJeCntPqFQf2FaIJhkJ14XPeg7HAaBHvpR4B1TvUf9Bc
	WEqnCllYjKwFMh1JVV7zh2pZXeMYQgDokLZn58N3XgY2bKTS5+AYXLmGkk/GTnguvH5R5R19dt0
	ZFUJ2XzlBVyDFx8N5J/2EgYFlgpS7z8GnJzQVACGvt8XJ6tN8vBzy6ReCG4d9Px49tOD+ftL70l
	Go13oWb7tM4cTjVBWyGjdgcrVanfhxQj+tkap9zvXnkXFtkQrWDh86AVoVBv4OFS9NJSmzZbLcE
	ZT6uGLzCU6d7sgPI2vbXlYsnazv+Y3KGGbKY=
X-Received: by 2002:ac8:5e4e:0:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c108dd78bmr26922681cf.10.1782821552719;
        Tue, 30 Jun 2026 05:12:32 -0700 (PDT)
X-Received: by 2002:ac8:5e4e:0:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c108dd78bmr26922291cf.10.1782821552071;
        Tue, 30 Jun 2026 05:12:32 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0cc57sm113884166b.40.2026.06.30.05.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:12:31 -0700 (PDT)
Message-ID: <7d937088-fb52-4a5f-9aec-b5e2409f3cc4@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:12:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: George Moussalem <george.moussalem@outlook.com>,
        Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-5-02770f03b6bb@outlook.com>
 <f3c79cb4-02eb-4e4b-b5b4-9732876c075c@oss.qualcomm.com>
 <SN7PR19MB6736F8FEB36D52E867C000E29DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB6736F8FEB36D52E867C000E29DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2AScTNPLfC3v-yEf3Qsp4Ya1mAt0SvRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExMiBTYWx0ZWRfX7+saDHoKMQQz
 YcpPpuE5SAUvY0f6aFxYcw+0UVv2+hNDtV4naz5C+uHYYkmr2NO+s3XZamcYjsaRh5p41OJarYx
 d0aitnWEsxNDC2GqWwcpDrmvPXdSS0dAnVnXZ5xbvpYNCv3PpEx5p44Eqy5FnP+gHbp5tnuAtpK
 FmDnOVeovrhQjhvW65s7ufk8c5+72+LuDPK7rIrG+AgkkknrlVcZiGciWwvbmj8uCYNYK5ld1E5
 OrwmMAjmHx/M1PZkTmDvdPZsfKL+5wRulaw5KWm+EihYDf5eZ1UhDXv5z5YljL4Jqb6ltjCaMF7
 VS1E7RvemVhZW8py+4YhFib3YJbtzgom396kkipUNVh87g0uEOL8U3+c+M63UGS7Fy9NZQB8IFy
 tLU8f0Qq+H3Mz+louyGe3MtxP2U0BIFh9KoWMfAT4JoYZOeQlWluUFueVyu5cfeVFrSUxU2DdTF
 6sYsUB7wDdORgY2bRnQ==
X-Proofpoint-GUID: 2AScTNPLfC3v-yEf3Qsp4Ya1mAt0SvRg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExMiBTYWx0ZWRfX09ZTH8KS8S2h
 11UcJcLUQFgJCN4hR4ClNzQOHRi3N3ndY1OJ66ClTie9csguYpI71vDmasNuYROMmf+MeRFB0wZ
 monP97hcPmImvZifsmLRTdTi5xBvwe0=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a43b2b1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=UqCG9HQmAAAA:8 a=M9FTrHVy_WBJAQrZl7sA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300112
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303142-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 144A16E40D4

On 6/30/26 2:09 PM, George Moussalem wrote:
> On 6/30/26 15:40, Konrad Dybcio wrote:
>> On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> Add nodes for the reserved memory carveout and Bluetooth.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 25 ++++++++++++++++++++++++-
>>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> index 6f8004a22a1f..65a47ba7d3a3 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -17,6 +17,23 @@ / {
>>>  	#address-cells = <2>;
>>>  	#size-cells = <2>;
>>>  
>>> +	bluetooth: bluetooth {
>>> +		compatible = "qcom,ipq5018-bt";
>>> +
>>> +		firmware-name = "qca/bt_fw_patch.mbn";
>>
>> Is this fw vendor-signed?
> 
> I've just analyzed the mbn file (and the mdt + b0x files): it only
> contains hashes for the mdt and b02 segments, no signature/certs at all.
> I've used your pil squasher to create the mbn file. Here are the FW files:
> https://github.com/georgemoussalem/openwrt/tree/ipq50xx-bluetooth/package/firmware/qca-bt-firmware/files
> 
> Perhaps you can double check?

Using the not very sophisticated but very quick method of running
strings on it, there's no certificate identifiers indeed

Konrad

