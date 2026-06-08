Return-Path: <netdev+bounces-296502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sQ23OP2pJmoaawIAu9opvQ
	(envelope-from <netdev+bounces-296502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:39:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A4655C3C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=iRwVfBpm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZJlELmD+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296502-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296502-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60A3F305325B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D96365A00;
	Mon,  8 Jun 2026 11:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE2366566
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:29:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918174; cv=none; b=LvzbXry3WMNQAyJQImaYr3ejhfJoAzQfV4ehXNZTmny5OLI/FNkF9aFOSWiJjni6V2m4IIa0alIuEUDi8KArvRLbABw4LHaJMocI3kgQY2Bfw9QzajPmpPmcmuansR5Hcom+RYTBKTjbKUX3IhYi/sa+a4VICfpmAS6BRY2z37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918174; c=relaxed/simple;
	bh=J3+cUGQtV296Sp3DrkXESZjqtBQ7EsKWbxudP8Kp5wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBU/ji3Tfgbyt3kQtLMuWzvt1wW0RRBcsPY+CZsQP3asCHUBLw7Lts0mHUnjCkSdlWwvTkY6/r+qjGTHGOs1sLpc/J42o+aOQ/m5QHH7dFmHhQyiQ5olDn5tGyo+dB1ET7i4s/vnzYNsDwnk8zFLlBZYD3Hpx5u80F0TUwF4RGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iRwVfBpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJlELmD+; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BCEm63480290
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 11:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kfS3gOfl7UBIyYndiCaeSVmlIF6ZDOAgaactyCrKDOw=; b=iRwVfBpmn9UWi8Gn
	iMoh/T8wBP2us0Rs8mluNRVdeQKRZ11cqeP0rF/hm+cyM1jtljsbqKKzUEc0vM9H
	ijnpWH2vG/fVsIJM+U4Guz2meoXIsgmh2HT+U+EOdEqfrRvyl4Pnr8fW7IVl22vD
	NVGlqnfuFuNgPEQH2vpmczSCZmylyZJ2/mdlHDEXZtbIDSZKhxNn76PWWG4IvR21
	uEynevaOERdAM7stoKdbQdKNJdclTBHnbN9axSkfvr2YxBCP7VtM7VvxLtGAVOra
	GAi49/J5mJBvzrlsK1fkd7fvYzuFIXKi9uU/p32AeC+OP+ZyszftvVV2ybJ+Hvug
	TyO2Cw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4yw99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 11:29:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915a4ca0a4aso136538585a.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780918172; x=1781522972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfS3gOfl7UBIyYndiCaeSVmlIF6ZDOAgaactyCrKDOw=;
        b=ZJlELmD+9hX+McTEqE8KPs5XREt85CUJ2PnLVDwatXqGxFJRlMpm5J61NbFUhQwC63
         bzUV643Ab+w9y790kfXtldtYJZZCFdjWBMRWQikkICzlHn34lvZh+vuxlg1UWo08xTJd
         1bChpldO/+v65ew3gR6pdIEuSfZpYJougrMrGUEEOVjqKlLl9ztsKH/gbWim8fEAo6kf
         9V9JzNyP9DnCo8djPfl/7Fw3wrg3t6BM832DKE2nrD4s6zD7IfkO7Y7IX3gORopJgXt4
         nYfQ3xwAptQLDVsCeNwDiNk/GF8xR7m5xPqGQ8QSS+q6Q9wckoT9msk1VIlaPWfi1GPg
         KVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918172; x=1781522972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfS3gOfl7UBIyYndiCaeSVmlIF6ZDOAgaactyCrKDOw=;
        b=MKa1Auvr1NUFdyHxDuOr0POPG5nFJ1AKWiVr6z266ikqb+DMNj/M6LSf9z+H1ZUZiW
         nWTs77zSmvKUJshdkmHRb/shcoT5tKD+NtzCskImyPhVCmpQDvx5IJB0EFgsmVKJrX00
         veGi199olqvevaL5FCyqNUXCKZRjKFME7Hf+xEGA7ya6LQHJX8ODOWez1e8nQIc8xkcn
         YOCUgkI7B16ZvUiIgY3Zg7s9jyCEUkeL+ZkpupgNhnA6iyYC1HXUe4MZXT7XCTji1r3O
         4GcOJarU/o7V/rI9+aGhJaL6sd+th10GS4Cby94UkCWuVUJIWmBv4MQeDp5X1XGWeIBb
         taGg==
X-Forwarded-Encrypted: i=1; AFNElJ/WlWqHmfpnOfIDjcS2B80vIEDT/bCW+u9GN8bNp8wfJjd+ZWHoKYnb2lc8YwYp0xTIQHRzzU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1ghEmFC0qgFfXUbk9IH5jL92QZJMv68S2qaTInd2KuFGRMos
	BApjevQqyW/8sut8DCKmQ3L/pTRRDlnXxv0W5i1KaPSropHkEjIK7BDBIHTCYfbIgcy7/ABVERC
	KIAMs60BnO7T6iOXF869e0EoBOoP/VRt7Dp123NBrHMi3hfZx/HfaIMyoDRk=
X-Gm-Gg: Acq92OGrBw+b93cEyQhtR10XosXAl5Cb6F7Q6qO8FsLfWEGeEcq1vadM/y9yvm7bXPf
	mz2sosECMZkdnaTeg1q9cuwm37EZLaaWlFIj/XeSTAlHUr8yWZZR2DyXlS1TPR9iYbh8R6TdDiB
	iYgUJzMGw+9Nh9jO3tA9L5onHnr6BYIasDff3L/hVk9IoCLqvGqbeWqGIL+o0GA+OLx1MwRIubg
	1NJN0xlAqA9G4H2AXfSWXNHvnOy3Znv8UudhMIlOUvVBZ112tS8BJ+gEuxuFYDM/kdoMtjWBfJj
	Wub63gBEFaj9748FA2bk/3FTys55vnSssgJ0veTI3+dc7LZ9wMXVUXN1QlhESfECULUpXSOwCgv
	jChfCzrVAiSpkQywXXgBixHftP7uO+kPu7U/1e3NseH0YViqPooy1+++B
X-Received: by 2002:a05:620a:2692:b0:914:c589:7945 with SMTP id af79cd13be357-915a9c76410mr1405356285a.2.1780918171974;
        Mon, 08 Jun 2026 04:29:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2692:b0:914:c589:7945 with SMTP id af79cd13be357-915a9c76410mr1405352585a.2.1780918171578;
        Mon, 08 Jun 2026 04:29:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055309368sm844667266b.49.2026.06.08.04.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 04:29:29 -0700 (PDT)
Message-ID: <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 13:29:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qkwKzAACTRUz-ilywvE997-AYh1jaJFt
X-Proofpoint-GUID: qkwKzAACTRUz-ilywvE997-AYh1jaJFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwOCBTYWx0ZWRfXzcWTKxs7/K0v
 WXEFyaXPgvPfZiVOOJT2TYPainUa4JTugrYowvW8OEp+ucdQyz657yypf1tFhcKAO3tugRRzN3I
 QRguDWRmrJ5GXrJFOcTA+QUjVq7GdBoo8FHpVgTwwqDgtgHr/wDHvjyKTvWpBhXE0Xz/LCBCHpx
 OgTMlEQR5d3s1qAvjLvMsaxttXnaa18oyIDfQjChMlAmXTG1osqeZMEdv/tQr5kNwA4YlauwS/W
 3wgj6pvvj4bbC7i2/f05nHy+NfTDpNsgOUFTDKN/DjMYaKv43036KV+WUtwLbwD/0ee7r7UZN8n
 jxd7Pgmn6N6r/1D9+sZ7nhoVWHiqGKaN4KhQ3BZjy55KI3E7wxY4LMexgRcgO0ntVop8E7TLnG0
 4ToQs+HKZbXcY+OYpCfcz2+8/aqP9xX4WnuOiUK0Glzw94fOwy5e/zVl78hFI1XmlW3w6YlEZy4
 HY/k0hsEUJKSeyqGgww==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a26a79c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=m9cM9ScjmTDVYK95jDAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080108
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: ED5A4655C3C

On 6/8/26 12:50 PM, Loic Poulain wrote:
> When the controller BD address is invalid (zero or default),
> set the NVMEM quirks to allow retrieving the address from a
> 'local-bd-address' NVMEM cell. The BD address is often stored
> alongside the WiFi MAC address in big-endian format, so also
> set the big-endian quirk.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++++++++++
>  drivers/bluetooth/btqca.c                          |  5 ++-

Squash mistake?

Konrad

