Return-Path: <netdev+bounces-298509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id //4jBiK9K2pNEAQAu9opvQ
	(envelope-from <netdev+bounces-298509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C0677989
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:02:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Be5VGx4g;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=POCygWzX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298509-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298509-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C01023162770
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537763DD51C;
	Fri, 12 Jun 2026 07:58:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9063DBD60
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251088; cv=pass; b=GAbc5qQqbeCM108rXZVfwwAn3ukld29P6DNQwT97MEnkBsJZDvKeyeVWwIct/+RO2V0JsXv/47g9uinARQrqG1F4Wksk58EDZW4xE+mI5WRrBovrub6+NVUmQ5Kl7j5RaeBJTVNUB81vSpqX9mo3t/qYUdYxp0yADPzersYqkTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251088; c=relaxed/simple;
	bh=qE9FqkhndnGAaai2XsKnxnIlLJwWvj+Km/dAKpVTNrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDTdFwFZXeCxTg1sDRse4SVQK75pGVAhKxjuehopRXZ0nnfe/cIG/HMpA1oFJpdGuQFz9emHSh25EFg+Y8imdluSFCHpNHSs47Phaz/1JxKoF7Fv6DV6tFZHIfqNbDABKpMV7byhYOlm8moLv3sqjp+zCpvQVMWeH9SOj/UTMpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Be5VGx4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POCygWzX; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39WPO2516147
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=; b=Be5VGx4gTUql8Vgx
	MQd5cd2DNjjeytK/wVvLvtoz/4GCK43dIUZNL2r5LzQm64n2OSWrhgsu+S17nxAi
	biRk5OxZn7ZLEuhzG1n7N1H1hG/Hvyl2ZjPusePOMwVKv9m/jpnfo1fPGG08gdKR
	qjpflDb4jHHwjQa8Hms9E7dNyqZ39kDJ6WjummOJ8TE1sUe+W1gQWbbpKqallgw2
	orSXB+5jHzb3rVakigr3LCMzzfgBUFMlcjyakZw0BgPrmAKnvLwwQHbUHdJKNklW
	3TPJmVF/kb7CIXaZBB5jiYLL1964zpfhv1RNhb8810SNEDTCKV+lesMe5jgvamy9
	2ZUL6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r725cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91598ab3a1aso86595785a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251084; cv=none;
        d=google.com; s=arc-20240605;
        b=MnHF3GCq346ZyoJGNq+JQMAWwHbckFLCxiVioKVndxaQZ1PINbTg9AcHYpJj08OrFu
         zXdDFoO2GWVq83kr5cYZlkIPglS7P53WpuDRYm0Saau9BhSqXC8yzfVjVAJ9G/sN5H4a
         RBe2DboWvlDEPOB9Bof9rqy2Eg9rlTI4tu0LIDrw7nxd00M2h8YggC3uN5toExo9bQzF
         4N3/bhlAhqSngXAKgZVb539jkZr/1Kg4y4BJ9geI3YrLqLOV4MaK9K4ijylJv29zu5XP
         e/ZROhoDggAMIOPXvYPlOZvLrar4J/TVOMfZfD6NJATLLFTDsc0mSf4I/aHb4tlByOOP
         /AKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        fh=DJhusFUq4Fp5gkjj2HzvaQEL9y6ofdl562UyT3FQDI4=;
        b=Vj1kf6OAM6ahvH0jHXe7XabKnXKrRMky8yvLx4sTt/DB8m5xsO1DYrFuf0O2LciNxJ
         dq98UMY6qJOemF/OGG6AFtbP+228Gcrv7+l5tMRkbHW+Ar37Ae7V4bOJhRleX38fNRg+
         axG+vCYczaExfLltrPXV4MYiXBHrvTFjOAbtg3YC12OM/JxrorVDQdxXjyyP1ah9jXc6
         1HTZilYyk3+sc5ZnZwQrwaCohu0IPNC4m2+EmwM2T0sLzELCckg+MoISote6Q7ceCIQl
         pmJDkO9t8pjpEgtI5pNrQ03UitZnsm9BbgTKYl3AJPVXLZ+0prU3Fl47raQDWSxnoXnr
         LrmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781251084; x=1781855884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=POCygWzXRhSGiDVOhcRBLv6GKKii028tspR9dtQ09i0fzdtpSdNHuDevaXhLi6vHss
         ygGYWvQZbhMAC81YgzG4ky6au+Aua6+am2FqMiJhu3Y3LaJ4FGkhOEDPcjsrG6m1KBQQ
         yNBwDK9HoxMy+koaGykJHN6A2niBDo0j5ZUzA8DHNa59qy0PB3Avr7UeTSut7kbfmLGo
         twkUgFRDoX/IYqaGw5P6zSSpiraKk+7uAdgurVbxgLX4MiLriUXStmObAM6S8a8BcDSC
         DgcbBvyIHfUbBW3qxP98JRx1PPzmyY1kgcRfeq9GqcxrtlQqokXWNRSyrn+Yxc6WtzJr
         aTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251084; x=1781855884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=ogJt/b2AcbNGp/oqunmGm7QeD9ER3y7NNssvWl3Cuc7oS62xmIqrjFlzqF/A4aq5p9
         /Rt0XJtsB3L62K4uT7d0P/8E3po2xJz6aOR46OZm6gotm83bm9EsjvoYJ/8Kryv4eP2i
         l46E9+YZYPCD8UQFT6xzW7wa8RV5DlVM216jv5NPpoZxjksbYWzzme+9IrwQqpHDixsv
         udlVlDY22jlwezgsITcoObS6fj2qzCZz/PvA+qdreYXFsuqW/MtohDK7kNX+p/ItcJl2
         KKk1X8psYyFBtVGGsOGGjf+EHBUqSFka0T5JI9Lmatlh2AJI6S7guXhUw60UBX9ZMYyh
         3AkQ==
X-Forwarded-Encrypted: i=1; AFNElJ975tVNSeQoqL+Y6hmfpG0s+2AeRCKuG5hQ1c+gOekhlcjODAqY97cUXRth0XV+7GeDtGXAlZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4TawfjE9p2Rq9KH6KIGaqIrNg3mHrs1yhku8/CMiexJ3HiY2
	FWhewufyGkVENMykzgimbsx4e8rkj1QSCaQNIWiFiAkuMwVVWbOBUUlS4BLHsh1EbSX5bmoh/CW
	IABCWbMtiiaYy5q+QokTn7As99RyKkeKwbHeWyl8y/zIsTeXasVsQZrq3d0s44rC24v9pz3KAHz
	hkisQ5bWrDRgwjTclhVYw41sjYEECjYnbXwQ==
X-Gm-Gg: Acq92OF7Bv06XTDUJHKqy8FGL56DBCdLlAyCuiey8Hzawsfhdb4I860d78Fu+tQCt6r
	NgzgWF0dVbP1PLn7LpazX6N/+kIjbObC6KBgy3DE4N56mRF5I1TgVNfPtzpQkJqVx4gkbpBQPaJ
	2R1YPM2IB/rnWQdSD11YuB2NZde3ue07sNRZVHwa3+cFjC6BHsBXXn82fp7h8fsjDBNHm0FQT2b
	poNpscZIQyUDQN1yOSVNVNjKvUu+pelXY4GQS7KhBdk8guKgQEaXf4NzG8vLSdLcjuF+yxy+ziz
	7+PHd7mIdS0gPCBB8ndk
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id af79cd13be357-9161bc5db30mr150538585a.20.1781251084087;
        Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id
 af79cd13be357-9161bc5db30mr150534285a.20.1781251083533; Fri, 12 Jun 2026
 00:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com> <20260610-funny-paper-warthog-25fa0a@quoll>
In-Reply-To: <20260610-funny-paper-warthog-25fa0a@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 09:57:52 +0200
X-Gm-Features: AVVi8Ce9FPbWU1H1fFzoHrS06e66vPYKJ71XBeMTddYgFQq0vpvNpz1VnR725W4
Message-ID: <CAFEp6-0Jqw4HqTu89QVOVtWEYMpNdnd0vYxRyZDgn6oMENCqTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: kGDq_p6l9YS1sFz1XZlZ3lF8JNqusb8z
X-Authority-Analysis: v=2.4 cv=RJGD2Yi+ c=1 sm=1 tr=0 ts=6a2bbc0d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=HRdx1Oj2DPauqesJAvUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: kGDq_p6l9YS1sFz1XZlZ3lF8JNqusb8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX9ivoOfdOxgCm
 8S6FHJVRxBF9JWMKXfZRfFNxY4AUHMpMT71rM+mTVpMEjjaE7fZcZMQC3vOhtMML+j3xzoxsOIO
 C8NK8jB0Q5M9m7bx6JS6iQldDxcspq04jqSByFUrgE6UJKPgDAnA5Or4R12VzYTImTblsGswU7a
 sNdJ54WTx37xYXbmGQ6tkbfOJH/Ci/7SMtTZs9fKeRI4xSm2TzpwOdU3dIKC91//iQ1ipjEDE1V
 bo3J5YyNVgH4Mzyq2XjFMZOAJnR/i1MbfX7wXxgP5ils+tWhjaaaMoDT3z6fdlsKsa0Y/+QLIfQ
 6iFcCRFuPO4CXEZqvs+GbK/fgTmznrykVYs1Ht3z+4se/pywUj/GmJoJW9e0yj4McKI/mhXkWz+
 PdUG2Qw5Q1SeiL/HBzRRQMBicB1MHjdruQTjRrvb2ywmZ70Ow0isbYLNFBVmLjZq0f6+99LmtI8
 DM84tEceV9UskyDg3jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfXxJNeyuEZbjUT
 J0kCJAuTDLZ98IlPaimI5uye/cfm4viR2MwaU9ezVVmKB8ki0U4yqt1mlpVwUGnAOe+cf2AZbG/
 MYMRXbosiY56E4bGfbBWxNf+RMXZEEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298509-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[qualcomm.com:query timed out,oss.qualcomm.com:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC8C0677989

On Wed, Jun 10, 2026 at 9:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:27AM +0200, Loic Poulain wrote:
> > Document the NVMEM cells supported by the ath10k driver, the
> > mac-address, pre-calibration data, and calibration data.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++=
++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b=
9919d48c41ac09f1e 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > @@ -92,6 +92,22 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  nvmem-cells:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
>
> If there is going to be resend:
> Do not need '|' unless you need to preserve formatting.

Sure, thanks.

>
> > +      References to nvmem cells for MAC address and/or calibration dat=
a.
> > +      Supported cell names are mac-address, calibration, and pre-calib=
ration.
> > +
> > +  nvmem-cell-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum:
> > +        - mac-address
> > +        - calibration
> > +        - pre-calibration
>
> This means you expect random order with variable number of items. Is
> that intentional? If yes, please provide short explanation in the commit
> msg.

Yes we may or may have any of those cells. Will document.

Thanks,
Loic

