Return-Path: <netdev+bounces-304569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IsdAESzBR2omewAAu9opvQ
	(envelope-from <netdev+bounces-304569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91179703388
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:03:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="KRPhwA/o";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Rj70q6qs;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304569-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304569-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A13731A67CB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891E3E6397;
	Fri,  3 Jul 2026 13:45:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAE3DA7D0
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:45:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086346; cv=none; b=gXTkqkxc2uR2bj7PqMr1aXMBGgBbrh13QgfMhNErqXo0yicEBPPUG0qQvdx31xXsuzOLczaInCdA7sxOHmr3Y11FVgYSPEddLzVVKwALEl7b6oWHxRc+ctVxAJg/noO8OZYHhJEvoqtqeEc+LToSS/CtWzMWZUf1EJYv3spETxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086346; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjdyjR45Dd5nX5H+cVvPVnbwVRS5FAe9uOy4Al9FF1aqdVYnbG9F+sGCpSecHyyIz2qhdtWE87H2/2LEYLkwnIY0JYi+EQlFzNPVu+OAAfPpIrW5j2Rhvhg1enmzvLgrbctQVSjMhyP1MLj+c6otNi78lCbKtidGF1SsYUhWdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRPhwA/o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rj70q6qs; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BITRW3108960
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 13:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=KRPhwA/oh9GV+uNe
	1MwR120BO+YSIq3ukMGeVBkcNZ5Kq3I5QOL0MKh6GD0UGJx4JioKC0KrZhqHprCX
	/upucVc46jPkUtqpoIH6svQnEQiN1ucR7xoGqS+6VUkQk/x4I6LXRFd2C7rngb35
	bdHPBxAI78RtRL+1+im0WisB2E+fI9770b9Gh+5O7PM4nIxpjTDS9eleXZVGc9kE
	cvk64B0goHWTRwLh9h+RBZZRpzoJHGAvT5zlKLBHvOqgJLfDQdAxd10A/CUMDXUl
	cEl2S5PfetXf8QNlHbKCosSTnlVM6DKsZaOdZZrKZk6CzVLKZHDpox4ONUWWS+Em
	cPOfJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybab3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 13:45:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91ed0e140c5so108076185a.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086343; x=1783691143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=Rj70q6qsx+bZ6l+AswC7+k9Ht7zn215LQIncwfzfjFTWyP1tQIIp4L1fu6Ldrsb5ZC
         du6QjPOsYSn/inr0AcnrvxRaN3/udaRVic4j9APkre0fFQ7yaLnSCS74kO4LrUevlwqY
         pfwg0Tmkhix1kdF2dfBCZ49+oWOQf7qzW2utDUPPMLkaGev71LV+E+Ctsb7jmkjHHaCY
         FCcXqU4lTE1bLAKV/RN2SNRDcNYXajfdNf/KoR0VO5wJOI47Oeu636aZrlwOzVPQwRzk
         2e4Gf655Qx5PpAEUvB6MVhtpfp02qyXtTDGATWtd7fyC6bS9FVnnUZtzIE4nI4R+ayiG
         XLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086343; x=1783691143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=rhUMwMaednuF7Ih1ZHu+Zswv43eYIOc9okgYDo00S0Ic9HKyx8yPoJ2x45to+SzdUD
         lTJe80JZOnPr+n7xNl0zwXoFwgdYyaW9h5JbA2vnpiZ92xR6XgF7VgcsIJi+7CuPveDS
         1sc5m9SfPt6VwjOf2gQ6VUSDQcJSMi+quyKNIKyuW8hIjdjmS4h6rJcTuru61lIQDg6X
         Wc5LKCOmYR49Q+6AanAE5R+Zn8Tfdku0Mg2FF/vMeHwZpI7drMT+5gcJmjNweeUnoa7q
         gnuC1swFifxbj867sl/cKYirrRV6uYct7im8Wlk+BlFsJf9+TuBfTynJzq9ynzUTV301
         l49Q==
X-Forwarded-Encrypted: i=1; AFNElJ/PObj1rRNMBuvowfk6H4Ae/gjulVaRqyzbNhRsZJIPLG13fCHsa1EcXXLFK4TLgikThPoVt4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyddEWdtCKscsZeFfvJMcJpkouWh7Zb9guvZGd+9p3RShGCmmIV
	Q9HIpz9OIPNfr+84JARquOtGj3ae8dB5rQvS3TxcMiLD91riqYQAjI5z2pBzP8QCrJi1+yLLcGu
	D3poFYUVowL3u6MJdDjbJCFQ//cQEXhkTRVBBa1ZV6sMKEm2OCVr3on7q0zM=
X-Gm-Gg: AfdE7cnf6rZsm110cEY5Xe6xnUBPruR8zEPD84VF8xN8Cp4ONUAJiFzCgXiry+fBxXZ
	qvkcjKpV2Ihw1G7ydM+2ZoT7tN5L6qNO3VAtLk3VmvKg5jU+waNpMc41jyBzzgGGZxLKM/TtRtd
	1SxZ+AWenCepymE17FxrGJA3lSQdKxETKLZTZti4zsoXBwQUNBQGc/icoS03LuzZZCXjDLhXODm
	SRpLx6dCwZ0NM6pqTl3gOIbDA58qUS5vDa+L8IMB6QIuyEYPWMtgNAbw/OBvTnmIbpLHnKhz25L
	g2kQygoJ2yk6hxn8KCDivasV3rPmUaCyD9sJ2Lm5mAV8x4N52OqCYgpq2XTOL3sN136D4q2T+NF
	ni6MkX5qC6TnNgFhUuU2FVrE0ygpSxVMYBgT7nJXJAryR7/kxYIeoJbPUR6gFtC13a+dB7Oo4hF
	LehPkRzzd8FvgtyLU5zqwhXTA6XArh3u10zsJEQNZe2enHXem0LITHthZXp1Z73GY=
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401573785a.57.1783086343126;
        Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401564185a.57.1783086342473;
        Fri, 03 Jul 2026 06:45:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:21 +0200
Subject: [PATCH v8 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-8-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX3q13pc0hcUxM
 hUqp5UrHndx5OumbdqgAik9I5XXaguXC/HxqFatUUsS/o+9jjcIJfYdkSI0w0E0w/IUphdnHNrI
 rGCLOEMm5q8GzgvreO5q7i8KRWhEPKDiQvUEDJefr3L1mF4lQuUpdZ6xzCq0loISm+a8ngxySOs
 bRjAeyhj1nGfWNbE1j2RcljcJqg8+WuP0zfNEKUbp7YD0vE8lIOvc62cu86Y9d6vXmNRN8xrKCk
 cLsQQjVInRwl7+r7Tam6MZm1F3AkcIfIjYlZ2jCxwqmTO0dEe3rx041RoChhbQW5EX1gT8PbDxh
 1/5jHl4jB/YJBptColBB/Lez9vbk204LkbitS8AF8t45YWQQ86+HdTXnAypE//CIEf1Ddhn8acz
 TyLeEgv+vskjMm6QOvCgxG/PZmnfwenAJguPmeuntKcxDpKcLf/hIFQo/PbepVEVk/+H5+cwIVn
 gnYpZwVt5TDgtIPKEww==
X-Proofpoint-GUID: v8FzUwwFCUS9CXLhM13mmIa2hvMIyxgQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX2HPZBaFUbnp1
 YqBozgCN2zvO0dnEPoxlvlT8otPQFXnAZH0Tz/W6RiJ+As6DETv1J+fsNUFKvYrVn+p0GjFknuV
 rn+wPH5Iv6BbDgEmRgyPHO3XNCVfq44=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bd07 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: v8FzUwwFCUS9CXLhM13mmIa2hvMIyxgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304569-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 91179703388

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1


