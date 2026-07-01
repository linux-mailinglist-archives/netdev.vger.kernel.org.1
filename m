Return-Path: <netdev+bounces-303673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h8+KOgwYRWqV6woAu9opvQ
	(envelope-from <netdev+bounces-303673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:37:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637E6EE342
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oKzsFzNT;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=aheu+lNy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303673-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303673-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8E3D30054D5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8B48AE31;
	Wed,  1 Jul 2026 13:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF792480940
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 13:31:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912707; cv=none; b=WAq9aJPJewN3dxr+u9PZnpBdL5hE0Njf2FNEKlb2DpR/QGxSrYDqX+eQhw1jruEy8o7/xB2cNfg6ugxnI1ttFfM/1sTpVemheSPU7luyvULmSSB2Cpj0UOzFA8YHv7d9DFMGxHDmwPHKtzmIZ8bHuQRMkRiVWmErp9D0EcNfDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912707; c=relaxed/simple;
	bh=bP5KfU/0EvFpzUaA0IWBbLVnj4P0xljC3bpOzpSGDv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMkRhMGyRMJDkuousfp/Asc2rzKIdaoEKrPwIkscRBsD8rShd+ziOpgHqTmnmo2f6uaaTpSzZ9wNyVbYtJZfxTFVkJ6+OBH1AeAeznNHp1m0B6MZqx1T/d5XGTLU//gaA/gsQ1dyjOgUDC3GPCqsGWeLLU3NiMrfVVhIxINFn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKzsFzNT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aheu+lNy; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8nrr683610
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 13:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wNaW08++vnLTFi1SsLSGWlzJVpLZiWA1rhZCbZvT7rs=; b=oKzsFzNTJKFZTGEw
	+dbmuPRNFK0epez/YQ8C8fHxvcJc6prV05IP5VHVd2DNOne0+d6uSx/k3giB0Gh3
	ODRqpBkzXUIZF4Ch7FGQJ3Fe2nOS7GbuL5jxeTTrLK13fGV8GYVNApjA3DptNE8P
	oE2Gh5n43faByuq0PwBYL0S9ZPbWnNmDDkVzBObVBhzvOe/YW57D7s7HMlWOygKn
	C/rseP3uIiEkDyrIP8IUnk3qhPVIvLUxIzL4ONK64zmUmxUIH3Swh5GmHdXiFx9h
	0Noo2gdkFUv/LOSsRsN8ABueob4pt0nygp6+JTox9LsbRO9L7jkSnLPJvFvDljSb
	QzAF0Q==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqmg7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 13:31:45 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9e8723ae1so154014a34.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782912705; x=1783517505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNaW08++vnLTFi1SsLSGWlzJVpLZiWA1rhZCbZvT7rs=;
        b=aheu+lNyvawOexkm+FpJSAtn29zC9F/hvcPRkp8Of4MKlFWn91UG/44Wa2tfp17V19
         8OofGlQWCE1DYrzazzjAxSfzohs1qZe4hDq0e30ROeyERcyEZRQJei1Gp7kp3anaDUBS
         VQZrJ7ke5HVFhnqctVMDSeTdurf9ncIaNAjqzFe6YTdB88AgbFFyW2v0O0+MODdfxPP6
         TW+kvkTmtsGV8uRY+pWJlr7Yo1RZzCJiFedtQ+i4vDQvjs7Y3FbzANK5Z3CxhEErIOk8
         Il5y7WN4b+cNsNqD37VNtCDwSQKIob7UXWgxmn207nnZWYJDPy0tRp1HDM7eCqZCuEfB
         2xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912705; x=1783517505;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNaW08++vnLTFi1SsLSGWlzJVpLZiWA1rhZCbZvT7rs=;
        b=Gd5D2Jm1aiRwE99MpxqyxqXuRpBGuYBFEqPeJpJ/Kry90W+567MlWsxEap/AaXLmo1
         1IGMf3GuzlCYjIKCnspraiHuhbNvpwZUkHSamyJ5tffRNtcBgG7gG3FewR7qEKsTGZy3
         SUPPUPwHCs/5TYDQSiu01jtHh/Fd/IVfLtFqChpU/7f1kdn3wA1dRBI7HL4EPegNmz+1
         17dSDnCLQCsu3nCGDBuK+cUCE24jy1E7dK9zld3xb0iuwqMuG8EvSntuugcrvOTlMdhf
         DQKeejFK8GqE2IEPfSo159HZh71E1ScFp+2efp+T0iN+77Wh9JGSCfiblqp1k0lMqxcL
         V/tg==
X-Forwarded-Encrypted: i=1; AFNElJ8MAxYuFgErVgnKlgv87D6hPBBXBkpPU9puKVpYVGuFaOvC9l9A9AV7PvVtbbN+2f7qzY4fH94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXbSEytS2IscIZe/4jckqcdgQCWhFGaWGa9DuPDrg0u5JHyFw
	wp7CgFzPhr+awPSWKKBGPJ7Ah69xRjcnt/XYQf2/HbtM/zihjJQlgGEFn8klaVKe6CTrV34gCSr
	WL/2azvCDOhy9GoSKuK3GgfRUnaXbXwo/y5iqWpgKCDP8QUO1lup2pyBoAfI=
X-Gm-Gg: AfdE7clw4Ly4mDSkjtkBTkVEv4hpixbvy56OZyxO+aBlM8TwQnZCxdAMEMiH83Di9LO
	80BtWJthORaWCl2G6HdYG6Uu+m4DcP9fHIrx/X7c2H+2nnJv4V6tOCO1h3fYWSJkGc2mVwxjuA5
	3F/0GIxbKYRRdBU/QcRO1cxz8xwQReEMDDLjYcsEalopd9q0twR2sCF4Hcx9KrOwsJgZjp5gLW/
	K93sa2pmKzufkRnmZITXxNcW0YKV+ze1QWQ1Czzx539hWgUYymdvQf+375IMHiB1lcfCXFlmPAn
	KKOTd4uAQMqdIZSB3574aLNad5M6zR/vxFNIYCQ21hJ/bxL0v6wy27z97UhgOdIc9uoKaFxx8xv
	ZCeeE+aCXQhy96odkTFGrUqpGBsxC02FV9BI=
X-Received: by 2002:a05:6820:330d:b0:6a1:7ed6:9de with SMTP id 006d021491bc7-6a309b4fe66mr369482eaf.3.1782912705162;
        Wed, 01 Jul 2026 06:31:45 -0700 (PDT)
X-Received: by 2002:a05:6820:330d:b0:6a1:7ed6:9de with SMTP id 006d021491bc7-6a309b4fe66mr369458eaf.3.1782912704654;
        Wed, 01 Jul 2026 06:31:44 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19df8sm277296666b.10.2026.07.01.06.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:31:43 -0700 (PDT)
Message-ID: <1ccca566-f804-4c4b-8d71-1f258380db70@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:31:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
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
 <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
 <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
 <SN7PR19MB6736B784D6A16CBA531DBD5C9DF62@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB6736B784D6A16CBA531DBD5C9DF62@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EebdDlkGx53Wm7OUw8SodjhRgQwN37mv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0MSBTYWx0ZWRfX+/vGkZjWNnvo
 A0g5wMXXPJSpiJOSqnvMAr+6r/Tcx29/2ubcX1tvpO4fIMv/GVOXc3hehtho/WmR50Kk6xNndpE
 PHitqC/XraOeoz5Zq3UKK0SjSMpmMo6EB6eLaOtEEus0g7HIhDKNU8LP2KBhrCPnP/Nt1zfM7S0
 kxmkDIGmZL+6Q0YB+8LBVnXCtO5c+65/INPkHLvmP+Vv0ru2yg+Rx+ghVCDwjIpAXHDTp6moHWq
 xEIXzzyGZ9JPx8TaF+ad+WhPWPoYCNuHRFj0xRCJPF0Y/OlN8CyhLoYZCiNwcQC2kzARQykwhQC
 oLEsDHOLGqWFGPiSMajEnZGOkJmK0WjpA9H/HliK91nGX+/+NnMLVKQX2G531QpVu5FSHT1T8GH
 nLXYyu7cV2qTsTjOUyDhKYnRyV1eX12drWuUFTz6OqC1m1/8RahKd6XJhIxoPaNzXE+uiqCIwo+
 1WbMUsuq3ZUrHXtNchw==
X-Proofpoint-GUID: EebdDlkGx53Wm7OUw8SodjhRgQwN37mv
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a4516c1 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=UqCG9HQmAAAA:8 a=zNuiAkW08ekSdzkv0MIA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0MSBTYWx0ZWRfXyn7sph7Km5mN
 G3hirSNV81J6lYwaw7n4xxk6fpg19L2NJc8OQYmPN/6h3xisr0uEi+v996LEfR7KUFoV4S9aMjW
 IdGQRIQMoBNxGSw06h/ouYeSun0yzs0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010141
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303673-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8637E6EE342

On 7/1/26 3:15 PM, George Moussalem wrote:
> On 7/1/26 14:40, Konrad Dybcio wrote:
>> On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
>>> modes which are required to be configured through a Secure Channel
>>> Manager (SCM) call to TrustZone. However, not all Trusted Execution
>>> Environment (QSEE) images support this call, so first check if the call
>>> is available.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>
>> I'm amazed changing this setting is a secure operation
>>
>> [...]
>>
>>> +/**
>>> + * qcom_scm_pas_set_bluetooth_power_mode() - Configure power optimization mode
>>> + *					     for the Bluetooth subsystem (BTSS)
>>> + * @pas_id:	peripheral authentication service id
>>> + * @val:	0x0 for normal operation, 0x4 for ECO mode
>>
>> If there's just two values, maybe we should make this take a `bool eco_mode`?
> 
> that was the direction I was going in initially but then thought that
> there may be more (undocumented) power modes I'm unaware off so changed
> it to u32. I'll change it back to bool.

We can always change back if needed

Konrad

