Return-Path: <netdev+bounces-293093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DkpAX96GWr3wwgAu9opvQ
	(envelope-from <netdev+bounces-293093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:37:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50057601B52
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51ADB303A928
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C073D7D94;
	Fri, 29 May 2026 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWCR0XlN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DxE3XyO9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4553B47F0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054510; cv=pass; b=Z2PlxIhHnLrTzGVZp56xiKiypRaUj260c8ogEQBusRCcDqPKW2jbRwQNOxt+iy6r6x3Hxaeb7lztmThzhqjvkaBw1V/W/+1Fn52+7MfF18W3rwAZ9Dea2itIFZUgW0sIebpR7tjSwRy/W9+zy3u4K2jRDkJgCfvacMprLtObNAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054510; c=relaxed/simple;
	bh=huO8bRInzjhYYkaMcGwmA1m1eitTJULbuc3GGHGj7cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ju9iYEpW6/JxnsGntxTRZ8EItlpceQP1jn/Qzp02TliB8l9zR1ALx/0nrKCDEHUr916oxKn4UlOs2o1IDKGTBFWeCR/ybV49UGjsR/vJDH9gIUqY2Yn0hnraSgCudmgCx3rPXyZZBMwdh6ng1tGsXCORBYzqvJ12uTc7G5F51NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWCR0XlN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DxE3XyO9; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TA5fph3677573
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vGT1/nhvnzAs60ud7trJSzGxuM8CGWqV8b6Gm3SERAY=; b=LWCR0XlNyhSsZweA
	ynCPx/nS9EYBBGJqYv1e5Cr9FKOYBQb9VSg1uots7qIQK+pOCFt++EG0z7UmXDGE
	MD+87xJEWe42qpL9sYPwIcJc6HuDFhVyaFbZz7xmsGECsqOIN/amaoZKTVDhkKxI
	6QIrTpXgxKfZwq8GnbyjpceLFQzBZ4OTJ32H2RwuUvFo3XBGpwGjAvDy7+v0cpFr
	QWQ7SilF/kvNoDaotFi1insl/+ocFyAhGmRqiZkj4WRC/OQMLj/rc/DOaKhUtHZX
	jsWkiGq4xa9roUGFs0LRRjE4zfbXGMydYHinSrXaldrtUhT3RzdbSLqIknvH96SV
	oGGS6g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rcgb6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:35:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-914a8522bd2so1679181285a.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780054508; cv=none;
        d=google.com; s=arc-20240605;
        b=VeGwIFCY/4b7d4La20CR4Ki1OeayWwyvBAHpnHVNEOPI+rcvC3KSy4hOCVSUaGMZZm
         A1N7vmN/aA9SQqtSGWW/qW//BmlAi9wV2yrzwMe7h7FjAAoak1GodvxDY6ThaHzl5rTY
         F2Ydg5fLqtNBtyU3HzTIju+/zXA/pJt1oUqcjc/MWep9uuMKJATN36UjtZzDUY8AHNyk
         pDC44J8LbvNHFNXA1IEMXoOTmhyFSmb0HkoJ6naidfsrn7XbZEYbP3I7aancntbwYffw
         Pcm96kC7670FzPBK63DAXTgFBOaqFWKtMmRqnjMYTRv3cTHJx+2VbcVg4R9aXaZrNNhq
         JqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGT1/nhvnzAs60ud7trJSzGxuM8CGWqV8b6Gm3SERAY=;
        fh=RZMynqGzA8BjBk2ozc6wR7tN+CzGEYUkWhqpJhuvNg8=;
        b=KZWff2dtT/RYDKNZwpZdhWla7yRU628u97RIWltCfGJVaxIods+sTT/nrgynEwCrMX
         WFP9ssRWX3LRrY3RCCv5V+75hZ8htv4WnDwkISihHXT+nXdvzkQ65jhlc/SQb8qfwsZ8
         FmoKzlAwwy9mK3BlKR6Q5aV6vt0vKL28bzH1SiMkZSnSRgr3GCbkTMcJ1aPioZxkH0y3
         BgpwVTgkkrdfbi9HBhyal/9v0Cxq1ucaLND7bRDQ/D13qZbTqN4mW09Xp9Quj36pPe2t
         UzpwuR8aVFrJ44xAESVNL22oxWgx2JyoOf0jFaFoVQift6cuISYJ89lEULsljbFXGELT
         WIeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780054508; x=1780659308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGT1/nhvnzAs60ud7trJSzGxuM8CGWqV8b6Gm3SERAY=;
        b=DxE3XyO965BFTDF13Y0468FJV+svCeD2mO+rCnm8sptTwSURm8tuucIEDasIaqW1SP
         ZJ6VONPHP/9HAc2kPkdMAc4JUixxz67aMQ/9I/yl6zRKezDiK1WwIOqnkpkBDnpr7XQk
         pUP64Fsk2PQE/McmBV/lu/VapHhO/TMJIFmq4kIgVk8W2KeqS/MoSDqvg0q2qlEQl8yj
         6D3K5jx/0tOYn1SMaFth+uJj/Ns1NgBW6s1DvB73yU3b7KZydiZI8Xsrl11r4AsB7tWH
         VllLs1KzSFZ91Muow5Z9HQ9XQepQ2mKxcvltzs9k7buIt2NCNLsDBS1tQaSfRhxzJVJ8
         1IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054508; x=1780659308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGT1/nhvnzAs60ud7trJSzGxuM8CGWqV8b6Gm3SERAY=;
        b=TLH/y++JVy3rfSdpytoGDINKj1toCqXrxkUFQKXqQLRM01o1tgP9lSWVaLiMmfMHlA
         3QVkAMONq9ROXAdldXoVjdnoPpPE4A2CCT1W9TplScW+9wET/ydB+RruifK50dGZPhZZ
         U40JAdRLuAXIQe73Q90dQpRScb7MMaA9N6yG1FxY0F38H6XS46qs+wqp/DJK3X9tCPya
         x9p2zDVZ8yD2fat9UxIW9PGZp3n5pvh4N74cYtIEjVr4p3Z8XCVls+09I5h1OObUbX8V
         9ZUSsOJXb5dSyeawgvhg0x90IzoIz65eD/wRWFlXvUXsY/oAy38Tr8TSdAHr2+/I0ZDW
         FIeg==
X-Forwarded-Encrypted: i=1; AFNElJ/UpubdCqvMoagZ11W8YxfOKZ1eJUgutH+ABHeqOy2Sgtbb53DwaRzdz7VezylPENtGx+iqoMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2azOdtaKIHW+bpMTBWH8Qm7MWRolBClR2oW9/l3oserNgyfTX
	Jd6Y1IaJs/FhCOEOI9q19JJM/FVzPWGvOQM5JbZfexkLtktSGWo+ee5tc5Hz26rWuIa/3jBCtT1
	JNSy9udLpYlAIXe0lZqcFsEV9F+NEJOM8pPqgxrh8JkDUiJ0g4N5c6fA9FuPzzA4X4ZiJhEYe0f
	fRkZ+QwvY1O01CpwdDoLCbHcQ5luO/jKUXqw==
X-Gm-Gg: Acq92OFgeZ1SnFSmMc2ys8z8pHagQwni0v4c+Km8tVOyEShQe83bmu8ZNsIu50zwaTX
	tnWyBtDln+NJnJSBIj5pfvzLFmhcknJ8Dtgx9GrQpsWAe4ErooX6aE8VBWujrOLb5LGJVRjNdqW
	rjzndezHoMGewwfizcM54tpZnOmX/m+MBvfkYhWu60XrTP22+09K/bhzWPQZ3uP9sPs3QmemjWy
	6wgLdbXUZuqo3bxZp9YPkBxjTe9abv7D6WtkHh/DXUjosFgmi4=
X-Received: by 2002:a05:620a:4724:b0:915:29cd:306c with SMTP id af79cd13be357-9152f8ceecfmr296539485a.9.1780054507745;
        Fri, 29 May 2026 04:35:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4724:b0:915:29cd:306c with SMTP id
 af79cd13be357-9152f8ceecfmr296533885a.9.1780054507346; Fri, 29 May 2026
 04:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527061451.12710-1-jtornosm@redhat.com>
In-Reply-To: <20260527061451.12710-1-jtornosm@redhat.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 29 May 2026 13:34:56 +0200
X-Gm-Features: AVHnY4LHRyofb6cwEp5U5n31VpAjK193XW2dSE-0GWngGVKB-G7uf8zRxt64oy4
Message-ID: <CAFEp6-1ffWLZUWiwNAs-ke-KbWS7pHy_31_dGhdQJFTcu42W5Q@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: Add delay between MD and SAP suspend
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: D-lPe09_CDImBhIKV4Yr2Wl3-6W2BGud
X-Proofpoint-ORIG-GUID: D-lPe09_CDImBhIKV4Yr2Wl3-6W2BGud
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a1979ec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=bAedRWiYt3rdd2Y5BmQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExNSBTYWx0ZWRfX71IPw93KTZqO
 RVPJHN28FfpG6D+RvleJeLZknSIfyUT9cE07lMJBI42esSio7RmG1msOoa8MzT6Z7auewJKjgkd
 P/ksRpmqssNWECERy4z2gg6zYPO5MN+5E0nyWxYj4vjWvh+BMSt6WFPbcUagiLvv0T1PLUesZCv
 MN0ZZPwqNtZGrJp2KdLNmFTC8YLFWIJR+kuNptA4cTyUzj1P/PvyS5s5glcZ9kkeiQc5klo6iaP
 RFYf8m27EOZP6adDo4jQPCJiq30QtmoqC6JAMpbQfth+1F/WT9fjmr08ch2SBAwrr9jEaboGcX2
 H1mxcNpspjw9zR7Vq/GRsmdgfHoJTzAmyjNyf2oKqKo75FiTj3fg0LNdHJ+lTDUMcd/YusrCija
 5lSdzv9OoFrAAuSiiaIfooR7y04wZ9VO5GR9NxZZOkR0//hFckRYsneBx3ZCE3Ow6XMAfH6TIyP
 AtoZTC8JBhLytZbr35Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290115
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,mediatek.com,linux.intel.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293093-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 50057601B52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 8:15=E2=80=AFAM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> SAP (Service Access Point) suspend occasionally times out with error
> -110 (ETIMEDOUT), followed by modem port errors and complete modem
> failure requiring a system reboot to recover.
>
> Error symptoms:
>   mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
>   mtk_t7xx 0000:72:00.0: can't suspend (...returned -110)
>   mtk_t7xx 0000:07:00.0: Failed to send skb: -22
>   mtk_t7xx 0000:07:00.0: Write error on MBIM port, -22
>
> The modem firmware needs time after receiving the MD (modem) suspend
> request to complete internal operations before it is ready to accept
> the SAP suspend request. Without this delay, if runtime PM attempts
> to suspend while the firmware is busy, the SAP suspend command times
> out, leaving the modem in an unrecoverable state.
>
> Root cause and userspace interaction:
> ModemManager 1.24+ includes changes that reduce the likelihood of this
> issue by ensuring the modem is in a low-power state before the kernel
> attempts runtime suspend. However, the kernel driver should not depend
> on specific userspace behavior or ModemManager versions. Older versions
> (1.20-1.22) are still widely deployed, and the kernel should be robust
> regardless of userspace implementation details.
>
> There appears to be no hardware status register or other mechanism
> available to query whether the firmware is ready for SAP suspend.
> A delay between the two suspend requests is the most reliable solution
> found through testing.
>
> Add a 50ms delay between MD suspend and SAP suspend. This gives the
> firmware adequate time to complete internal operations without adding
> significant latency to the suspend path. This makes the driver robust
> across all ModemManager versions and system conditions.
>
> Testing: 96+ hours of continuous operation with ModemManager 1.20.2
> and Fibocom FM350-GL modem. Zero SAP suspend timeouts observed across
> 2000+ successful suspend/resume cycles. Previously failed within
> 24 hours with 100% reproducibility.
>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/t7xx/t7xx_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7x=
x_pci.c
> index eb137e078423..46613bba1f41 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -447,6 +447,9 @@ static int __t7xx_pci_pm_suspend(struct pci_dev *pdev=
)
>                 goto abort_suspend;
>         }
>
> +       /* Delay to prevent SAP suspend timeout */
> +       msleep(50);
> +
>         ret =3D t7xx_send_pm_request(t7xx_dev, H2D_CH_SUSPEND_REQ_AP);
>         if (ret) {
>                 t7xx_send_pm_request(t7xx_dev, H2D_CH_RESUME_REQ);
> --
> 2.54.0
>

