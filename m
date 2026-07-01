Return-Path: <netdev+bounces-303581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jvJDJFjvRGor3goAu9opvQ
	(envelope-from <netdev+bounces-303581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:43:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 002266EC4FC
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:43:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nsg+7PGS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GyL4FosQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303581-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303581-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EDC9302F6B4
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFA4426D13;
	Wed,  1 Jul 2026 10:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D88423173
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902452; cv=none; b=g4wo37DkAft5//nlS4tOJAiHBITnjYOliI0BI9ZLBZ+YVNk/a7FyGAe60xzvfCaobcRhbDpibYOWWbrPk23qQy+V89JkbEbJOJVzF2E+615Sdj5FqKaBXuG0qI8g31Shbp8gA4yQPrxeoauSgaiGqRCOzmhV1emI7ZV+ZEBvyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902452; c=relaxed/simple;
	bh=HOn0CaCePfNgAAG9q0s3jJIiPvvFTH5KrOgQqhOkSqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YG0c5GT+e6K/z1gNLypEFNIXSLL2Zxan35q5f02RIx6+vI2h4OnyA/jdR11lb2G8SOMsybXcw3Ddy8USgduYm9dxuHDXapbYYb1Hht8EvFyzfSvoHvcvGhzGXpVHIDFm3dX1qtkBWQE3T/fgKf/o2KOsHpDTsmGGsLm7vFXOkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nsg+7PGS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyL4FosQ; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8tvD763068
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 10:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=; b=nsg+7PGSN9LMaaHb
	vP7qwVAt0LvmfNhpwCNGGrHCO3fVvstLF7mT3Di+sWTZork4SslT9bHt26h9Mi92
	IaYhXfMfqJWclBMkqxErZVX/sXvQ1vvohbsCRngPa0TuPp5VB+JOzvndmxfZnSkJ
	ieUI1piKVL7WKls80+Aju0hIxcycUnroOorlyO/9M8hEMVrMg9Pyrww7Lxd0qWPN
	ZqzULmqFpA7/z9kemgHxgGkpVUbrJUSJzUqeFMWkqUtdHdrWDrwwRvgol4kD4Mps
	FMcvtl/2AdFVVCEzWSJDZwHSG2iEjIVD+UGCQ4/eUewg5ouFQT6h713Po8G7SAkB
	+O7xfA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jktbpkt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 10:40:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c267931ebso1500271cf.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782902448; x=1783507248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=GyL4FosQWSFeMIENYzn5k8JSIEfI2ZrGYNpC1fKjjmS6BTMlrw4rxicSfTG4qjXnIS
         9+CZ3gwlOkhoeRZcwnQ0b6/iEy4VFcwtGAfWMcCC6SddQdXl7UZc862VOOwZn/5Y34Mw
         FA59JJ+0GbiFvCry5GBqdGRKHBNyXTjoCEPdFTN7jrt7Tp1GF/CsiBad/vFQWNmP2Q8U
         +6JzkSpZsT3BOUv9RqiZzOYkPZcdR0S+7Odk37PqsVEGPqI1rCzZfz6VT5Don0LtgZen
         rSOTEplzWuWhvChXWd4lm9B0fx0lROoKOZLkV5qzDxDiADLi6Fy0zCPvHzltp3aRKxnt
         rscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782902448; x=1783507248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=JQn7hvPZQXj4/6E2Hdxs29K+j1lxF8yG0KWh79PZEKbmjZQzvvd2nFv5jek+BsP8BQ
         aQv9fZT5P0lhLUCNDBtSCjIHXbh2J3FZp4FM+BXAE6u1r39YGc+pyt7ydZWB/wgNIm43
         WJN0h4baao5TrXcLjpMWFdlUYyCsJTcvAg9LiiVqecaf3IOePWDrI0/AAmYNllEU4xSQ
         1E2TOVdIMXiuxnLgKbXG/hbj1UBgGC67okxVox0FYX0Jau2ywcl3zSqTg8F7o9NO9qJQ
         JcKAyDMR+FJnAOiz1d6kk4YQBqBHZM8S8PGf+moDNYi/bcs55FDwQYrP4RRthNbhdq5v
         L/Pw==
X-Forwarded-Encrypted: i=1; AFNElJ/ad1bgGzBVG0ARVRJ8Pa4I4u78Bl8dRziHub5jgkxnXCBHQeen9HJgvQQ+tLvyF0rhdDUJp7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrS5b1mXEVzfwbjgSnqr/7rbgjoqrkf4Wmg1DlDHyctu4pBng
	2PB//EKl1jd3sAzq7xzg+KOXe2fYiFZ403jUHVbInMP8VbKRFiW2lJG+ubIH+RwDNufDrGBuak4
	De2qL3x7HyE38tTXmoxylmmLiUwNKnO9XvisKH2i91BOpBEHoyWykZYNx4o4=
X-Gm-Gg: AfdE7cl2YCzPsrYPno/UmsHv69AGztCe87LR3B8Uj1VmYi5gt2e2B0ZRvLQuzVXJerf
	0zgYgr7/8rOO+Chh0d3EE6JsmkzY7DyUGh55twJATk3YROsmK2ail22b39veAGbnVHIRxB/Yb+G
	s00Rpt5FIqk4KlWES7eLMX7iUZcvrnXA2+L8cIP/UCqJGhngNlXe4AoG2ydizk749FtlEPsRJdv
	lCVMZR4IhhEFPQJBzojFB/ATW/xeSesSr21odc3ME9h5GIuBaXJVOSD5kxeAWABpaD8LO1XYX+c
	wcpmYn1/6zRP7lUObOiaqM/QvDJ1HjLXXUgLmDAoNGyUx3zJVYYCnVtARR8mhoBSY5YQDp4CYUR
	0blWGqaUStdFxtO856HLAIFJLY9Rc8NK5cD4=
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031581cf.9.1782902447975;
        Wed, 01 Jul 2026 03:40:47 -0700 (PDT)
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031251cf.9.1782902447419;
        Wed, 01 Jul 2026 03:40:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1296b1f9cesm165809466b.16.2026.07.01.03.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 03:40:45 -0700 (PDT)
Message-ID: <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:40:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX8LXnhXNHXvNC
 tA0L6ZmtIh8T+NuvkJvjliwGsAQnC5ROrehW6z+wmpXoAavnLedQW9U6qXo6zqyKC3U9Sh4L/qV
 aBdLMvjQd0jUL9NeWCY5YKEAAWUoG/4=
X-Proofpoint-GUID: YlFyr7yiyRkcT2bFj0hGIgWV1a_nQobS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX8nACmHztROC8
 mZez/kNb/mKqou7QojSQi5pmhVyvykUrzZY0TeqYd+rwbvUhaDd6d1Q7n4fl1+oLoMGA1J1vzLX
 NiHQ3aJJJHbdogtIGx2a6pCxiy0pVF7G3td5TneEz5QBfpCKSFoPku3W7W6PM5HHVRC3ip/Ez59
 PWfdKF4dsfdbrjTppfOtXE1jq0lKWA6mEfr1J9Ni7BmQ1HR4sjPPdNteNRWCBQA47QJyeFQSeyb
 3HIwoYs+Wfq1WN5ax6iB1+gtj3rTxLVS0LK5kM3wXOqbJKfcXSl9W9U9r39YWaYCZYRf4O3Isph
 Gwt1aHADgkj0US4tQC7gMv1c2kWeTpkUHU8LoY+l/ahJZLWkvvzQJuqYefjSHHDTFfpvOC5eeDQ
 e6C+cnnpaHeQP4iFWiBDbLUw1h464Sbc+1eN4+wixy9QN5MJT5hWaY4k1ztKgQE9zNY+EZ6c6EK
 25t3M8lIqrzndeV9TrQ==
X-Authority-Analysis: v=2.4 cv=R+wz39RX c=1 sm=1 tr=0 ts=6a44eeb0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=UqCG9HQmAAAA:8 a=506_Lbxh6H-Y4vAdgPkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: YlFyr7yiyRkcT2bFj0hGIgWV1a_nQobS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010111
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
	TAGGED_FROM(0.00)[bounces-303581-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,outlook.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 002266EC4FC

On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

I'm amazed changing this setting is a secure operation

[...]

> +/**
> + * qcom_scm_pas_set_bluetooth_power_mode() - Configure power optimization mode
> + *					     for the Bluetooth subsystem (BTSS)
> + * @pas_id:	peripheral authentication service id
> + * @val:	0x0 for normal operation, 0x4 for ECO mode

If there's just two values, maybe we should make this take a `bool eco_mode`?

> + *
> + * Return: 0 on success, negative errno on failure.
> + * Returns -EOPNOTSUPP if the firmware configuration call is unavailable.
> + */
> +int qcom_scm_pas_set_bluetooth_power_mode(u32 pas_id, u32 val)
> +{
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +					  QCOM_SCM_PIL_PAS_BT_PWR_MODE))
> +		return -EOPNOTSUPP;
> +
> +	return __qcom_scm_pas_set_bluetooth_power_mode(pas_id, val);

Let's just inline the whole definition here - it's single-use anyway

Konrad

