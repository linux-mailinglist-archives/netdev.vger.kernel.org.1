Return-Path: <netdev+bounces-303748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DhcxCYg9RWqv9AoAu9opvQ
	(envelope-from <netdev+bounces-303748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:17:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B06206EFA3C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:17:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=eLRgeEjC;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=cvgAo3am;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303748-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303748-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C5F5310BDBC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F934B8DEC;
	Wed,  1 Jul 2026 16:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38994A1390
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:00:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921653; cv=none; b=eUEce6Lkj7xxzw/LaLlgYjrKv36ECuWNbhtzQTtW0LpK4olla8G8VC1t0MdPM+R3wu9k8Gkraz++eP4/dgep7VJP1tjRtvkSgMDwu5rowFR93YJne9FamWS7+JEHIwvUqt4x9bnp9bLIzXJJ2HagQ3HrxV+N0fCgDJlcfmpy3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921653; c=relaxed/simple;
	bh=NJn2c31lUH7/D4D288VRl32/NWMVhF4Gt9cu63zJMps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fgg6D8khzs6SFw+lKKz9PJySQfNAigbxKVjhJjuCtdnqLf/ukaRsiwy9p6CpW8rDyhs3PTZwjWmEOUEq2OSJXIY6Hu2tD39V1hnP+5mFfihqI7z+n1kcCuS1xt3RMIQziDTnO3Of5XTeEqeEMEOfGmm7CbvpIRv2i1wxLJdZVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eLRgeEjC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvgAo3am; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoCsn1553071
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 16:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h6kqBe/1HqC093rRFcLnOq
	y3nv640MGtvfx3ayZFRYw=; b=eLRgeEjCy31rzy9tZarhmF5RzLaGbFh22koYq8
	lnRDUX7UJO8DMuxeaspcWJObEChEuWWBXlCZmcMHWa3r3L7BnTnVkXbN/+3dcej5
	TOqAFnF5ZayUzTxPDjCspYi1ZFjqCx56CCYyPc4PgZCcwnYhx4VPE7bd8ZmvlV5F
	zX8jYx6CzMWPsLM5JytL7MLbAz0LiIdNcCJ41t3x3d4SU5sNKUe4ISRQuyNjm2o+
	oTgWOf0ItSsdXQeWJClRR+1ANT5kKplRAO48ogqA7kHL8pQqHvclLBjj8V113eJu
	+URP6/d/0sdAvLIq07glcUNxxfYuCzoxayTai3hvkC2AuiBg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd1fjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:00:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e66f9e2baso83556085a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921632; x=1783526432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6kqBe/1HqC093rRFcLnOqy3nv640MGtvfx3ayZFRYw=;
        b=cvgAo3amhba1oNxx9EAuaS/0c1VjSvqYRvqRG7MHuljEFCMjMUE1oOIqaURXVA2zr0
         iJQV8vzOCleeeop96ty53ETA5uln5tbRvAAO/umXaPlpRMDTwsv22m/kANjfis8QjfR2
         lSpTt6AYFw3tsavXrE4EmxdbTAnvvdkN34LCmIORwsxh+ceQaIqcn5pQkVVJ57AId3dD
         rnHiDcQSkCIZWRxa7ECUTAgBjlVwkw5haBjnXEwJ2lIt/LPVkTFQgS9eYCfzfc//5pkb
         qk6cHqu1vp4Fvns31D75wDFvx7EP6+t6AGUA8hhyn9GFBZwdEgxa2Tv/uuCAgwHI6nUu
         y8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921632; x=1783526432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6kqBe/1HqC093rRFcLnOqy3nv640MGtvfx3ayZFRYw=;
        b=f5Q1N71XgkYjKJkTyrqHQ8bsT51y6K6niX4+Rp4QamqJzDVjBWW7wbKqSFKGRvNsao
         DxLi+4FH00AGzTpJI4OkTy7RtWMuMx5Q1YSONFd7c5fIizzZbargfe4pCdm+tzchGLrx
         808jQh8q5nEyc5G3FRVTcfrL01FXwGaMSduyjhF43KbmqDJ1HjV3rGJQmvXYqzXuoueX
         rbbE/+E684PJkUh4QR4ItwO+dbuw4ia+TJDVBwuxsb/IpGeQpFsm4slmt24Cmad0v98P
         KuX0PlJfEun751EcR3oLXJXE1iORX22/U5Os3tzwx28ankdHUsuyr5AAuUEvt53VDK2h
         rBmw==
X-Forwarded-Encrypted: i=1; AFNElJ+sQjDbOjOePSK/KktMYta00GW6rMBhbM3ob4YzIvNSP0NiEor3LQm06M3aqLTJEewvwg+KNL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyagUfllumk73Q5KLlzblGSOsbqcnKrupWWHWnwEf6uBju2fXBE
	3Url6tXXj4vgczSwcKGzEFriX7zWTns+nAoScLIb0sYjDqfMm0UT5tySq8x6peeJxeuyVwaq8jC
	OHcj8zc725UdB7nVJ2kHoG6n/5JY2PNpcbvhEqsrBb8X305nI61LGmEimXnE=
X-Gm-Gg: AfdE7ckHAOlZNmG3XEq2Xxtc3kwAvjyA6lTVBYpM1mowxmERQo/aBA4v1zfJ0CAHkeA
	YK22NWLE1p+pn/too1MlHm5yf2YpMs4OrRkGlQx2YTAbmUYues1WCA1dURdkFfR7DuG4Gr/z90J
	jxyn++5+euf24e1ic+dwsdrdQq5urmq+6i+O1cV1vGluqa9S/LpYFrmrtwsDwWf+TFUmfZ0do+H
	frbCQNKXVfVGw/ni5Mr7gHSbcrcOiH2Ko5ipfymwMtvQ61hBF1hMyAc66NBbsvFOi1V+RJgdY3p
	3TOvEXQ1VYtdCrE53CxnUgdlGP4ezkcGlTAaPvaEWendIsnAOZtn3J5Xpd6g8jZuRJnbFWbDv2X
	Bh4vwzpPN5oHIrT4u0OHXw9zIdd4WJhdRXXCqeMmpkBoVDn6bqByjpSWPkXr5UexREWSiDgJSqH
	8pNdvscZ6xijgqLwXNZtl4JhjmiyBoZ4tp1fcVvEs/aOEQxDviHVlWpCI6TL8MjJA=
X-Received: by 2002:a05:620a:4549:b0:925:4655:a89b with SMTP id af79cd13be357-92e7b056666mr210555885a.27.1782921631861;
        Wed, 01 Jul 2026 09:00:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4549:b0:925:4655:a89b with SMTP id af79cd13be357-92e7b056666mr210536885a.27.1782921630809;
        Wed, 01 Jul 2026 09:00:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v7 0/9] Support for block device NVMEM providers
Date: Wed, 01 Jul 2026 18:00:24 +0200
Message-Id: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJg5RWoC/3XQz2rDMAwG8FcpPs9Flv8k6WnvMXawY3k1a5It3
 sJGybtP7aWBzBfBJ9AP8V1FoTlTEafDVcy05JKnkUPzdBD92Y9vJHPkLBDQgcFWhsvUv0tf5Lg
 MNEgTNLTUhug7L/joY6aUf+7gyyvncy5f0/x79xd121apRUmQzkfU1FjVgX+eSjl+fvtLPw3Dk
 Ye4iQs+FAvNTkFWQlINxWiVNlRR9ENxsP9Fs9Kia1Wy4L22FcVslW6nGFaMbRSSC4i9qyh2oyj
 cKZaVzhJw1SmlDiqK2yi4/8WxkgC5k9hH4+I/yrqufw3z5J8RAgAA
X-Change-ID: 20260428-block-as-nvmem-4b308e8bda9a
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a4539a1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=0GYAYOgpis-UCnD6-MAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: guTXKuTedfMgPAjOAslwADNceur1Sadw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXzsp17Q4OGeea
 WMsFxy/DAZnbBex+fPJTdWygic2CS3vh+gHJdDfiIaErofFz720Dn30Pi114ugQ4zL2/NOkgUHG
 PLhRKM2R91fa7uY1yRAGyDkHA2NHGjA=
X-Proofpoint-GUID: guTXKuTedfMgPAjOAslwADNceur1Sadw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX/h35xZDAeFTP
 XeB+ECAJ0PS0s2RcOBkw6x7731O+AA+PWRedTSS79c2x5QQAhsRYeFUxzJLDBh+tW8aRyBuzQ4M
 1jPU38xftX5yfR3m8fxy23mxoNGPiCP14Vw7slZrsrPT/kLv6p25sgIpMyJ/o5Ale8b2fYQwXXQ
 2uPGnIeouQh8FbWURdJi9724K80v0NjvA3nq4Bctc5V0S4MqFNqQ6LXp1MW817BwYoDiX1f3SL/
 eK3JyaXKu4DOBlQFVlGzbF9JnFbYdPbJy49RLcYMzBIuoN0mecbp8+0wF6UlisqgDzlcWfX7s2B
 nujyonNMARnE8AkxLOQJJScLTu5vezGKtQXErh0A8VwUdsr5cU7M8/owwJ9BAs/eoss2DqiUBgj
 zTxbHXoQwkV03uB/mai703ejF7JRWr41IYnsi2lHg8MwapNwuRjuUZdBJoWg9e+wVIQ8ninaApO
 J/x9KT27kbUuk00jvtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
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
	TAGGED_FROM(0.00)[bounces-303748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:piotr.kwapulinski@intel.
 com,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: B06206EFA3C

On embedded devices, it is common for factory provisioning to store
device-specific information, such as Ethernet or WiFi MAC addresses,
in a dedicated area of an eMMC partition. This avoids the need for
and additional EEPROM/OTP and leverages the persistence of eMMC.

One example is the Arduino UNO-Q, where the WiFi MAC address and the
Bluetooth Device address are stored in the eMMC Boot1 partition.

Until now, accessing this information required a custom bootloader
to read the data and inject it into the Device Tree before handing
control over to the kernel. This approach is fragile and leads to
device-specific workarounds.

Rather than adding a new NVMEM provider specifically to the eMMC
subsystem, the new support operates at the block layer, allowing any
block device to behave like other non-volatile memories such as EEPROM
or OTP.

This series builds on earlier work by Daniel Golle that enables block
devices to act as NVMEM providers:
https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org/

It also introduces an NVMEM layout description for the Arduino UNO-Q,
allowing device-specific data stored in the eMMC Boot1 partition to
be accessed in a standard way.

WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
Bluetooth requires similar support, which is also addressed.

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v7:
- Rework bindings/dts so that the eMMC boot partition can be a nvmem fixed-layout
  and not a child of fixed-partition. (Rob)
- Add Support for fixed-layout as the nvmem device node itself
- Remove "block: partitions: of: Skip child nodes without reg property"
  This is no more required in this series and will be submitted separately (Rob)
- Add missing linux/cleanup.h and linux/device.h includes (Bartosz)
- simplify nvmem_register() error path using dev_err_probe() (Bartosz)
- nvmem_device forward declaration to blk_types.h (Bartosz)
- Add hci_dev_get_bd_addr_from_nvmem() kernel-doc for return value (Piotr)
- Link to v6: https://lore.kernel.org/r/20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com

Changes in v6:
- blk_nvmem_add() returns int, error properly propagated (Bartosz)
- Redundant if (bdev->bd_nvmem) guard removed in blk_nvmem_del() (Bartosz)
- Size guard changed from UINT_MAX → INT_MAX to avoid signed overflow in config.size (sashiko)
- BLK_OPEN_RESTRICT_WRITES removed from blk_nvmem_reg_read() (sashiko)
- Link to v5: https://lore.kernel.org/r/20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com

Changes in v5:
- Fixed ath10k binding issue + extended commit message (Krzysztof)
- Moved blk-nvmem handling to block core instead of a class_interface
  This allows correct/robust integration with block device life cycle (Bartosz).
- block: partitions: of: Skip child nodes without reg property (sashiko)
- Link to v4: https://lore.kernel.org/r/20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com

Changes in v4:
- Fix squash issue (dts commit incorrectly squashed) (Konrad)
- Use devres for nvmem resources (Bartosz)
- use __free() destructor helper when possible (Bartosz)
- Fix value return checking for bdev_file_open_by_dev
- Link to v3: https://lore.kernel.org/r/20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com

Changes in v3:
- Fixed missing 'fixed-partitions' compatible in partition (Rob)
- Fixed clashing nvmem cells, document calibration along mac (Sashiko)
- Remove workaround to handle dangling nvmem references after
  unregistering, this is a generic nvmem framework issue handled
  in Bartosz's series:
   https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/
- Validate mac (is_valid_ether_addr) before copying to output buffer
- Link to v2: https://lore.kernel.org/r/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com

Changes in v2:
- Fix example nvmem-layout cells to use compatible = "mac-base"
- Squash WiFi MAC and Bluetooth BD address consumer patches into the nvmem layout patch
- Fix possible use-after-free in blk-nvmem: bnv (nvmem priv) linked to nvmem lifetime
- Simplify nvmem-cell-names from items: - const: to plain const:
- Factor out common NVMEM EUI-48 retrieval logic
- Reorder changes
- Link to v1: https://lore.kernel.org/r/20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com

---
Daniel Golle (1):
      block: implement NVMEM provider

Loic Poulain (8):
      dt-bindings: mmc: Document fixed-layout NVMEM provider support
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      nvmem: layouts: Support fixed-layout as the nvmem device node itself
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

 .../devicetree/bindings/mmc/mmc-card.yaml          |  23 ++++-
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  32 ++++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 109 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/layouts.c                            |  13 ++-
 include/linux/blk_types.h                          |   4 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  41 +++++++-
 net/core/of_net.c                                  |  49 ++++++---
 16 files changed, 332 insertions(+), 16 deletions(-)
---
base-commit: c58ba8c7e9ab26b5e8d91f8ca0e0a16c2ae318e9
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


