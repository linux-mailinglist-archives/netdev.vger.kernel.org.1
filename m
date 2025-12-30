Return-Path: <netdev+bounces-246319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3ECE9433
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2DB2300EE59
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA82D7394;
	Tue, 30 Dec 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+s0fcxV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZvPrZUhM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DA266B72
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088254; cv=none; b=P5iqjf8Ct8RRa5cZQAxHNkv8MGfd/Aap7o6OB23PZV1TyXiDOfSr7NHPwjENuKp7Sk2Pwo7Ow3fOBMGwBblqLq1lrj9VsNcaTMye9Ds/hwSBUKCVAPgBNtFbMT8x/NQT65Y/gIPmkvq4veUDgK5TeJGQAJaHP0/aE/xURgkfKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088254; c=relaxed/simple;
	bh=AezMIr78RfBsrmMoauKZQnKcpLtYq7A47d6aa9ubbLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMwa1Q+dRk/1J0OE1ogNiU55FmiPKDplqXzxECt6F76lRYAOpYLSfq2z78AGMRCbk44imZ+7Nvlz9eGZbqo7b/PBLlAJq6YH7H0asgE4rAWEGV00eOxVRsMaGnXp+xGkSBdku5RKKQQyiSqhwELSZw8QvaX1Jxnc84wioEO+NzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A+s0fcxV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZvPrZUhM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU9CEpB249004
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AezMIr78RfBsrmMoauKZQnKcpLtYq7A47d6aa9ubbLA=; b=A+s0fcxV9wQMugJH
	V4Jdckn5hb+r9TB30GQcfdIAtMp0IiiTUJvUzm0LtqDD1rX+sxlAH3Mi50kk9gjz
	ss3GgtbZQ/SxoJjif3QBqs2KdkSdD/n+Dl6mumk3X7M4Z5frVIZu974+KYdVGgtC
	aqALJPdOLKEEqtQSV9z91WeyXDEmL85TH4vKV6sRHW3LpSdCW/JEKEvT4AWCAwpw
	vbz/KFRAsc7zICuEbrORxl/q+6rKbl3aU+COYhsbjwyyhRK7oHIDkmT49okZ9qoW
	x2d6uOS357XH3omeF1mgEwS11SZC67WTrjeDxrSkPR4T1xNTv1R3Bo6/dHFRe7jU
	DXlfBw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcbwb02sm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:50:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0c1d1b36so237093071cf.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 01:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767088251; x=1767693051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AezMIr78RfBsrmMoauKZQnKcpLtYq7A47d6aa9ubbLA=;
        b=ZvPrZUhMHt0sVYFtbtKMpRt70hp+vS4n5ZBrHyBCdoqkSgEJiOVSaBili0Msaa6KZL
         WhX8xrcyNXXK4QDCvM3kVMpS68q52LkvHzYRD8drv8CD+D/eufIdIZDAKdkA96UCE5+p
         4xHujvXx/Y5vLrHUvMbQUVBjepGWFG3PB9/Udp8eNrPKG+IY7+IO72Wlmp2GvBob9d2E
         HCcNiA9tDftvf0tKVW576dWNsA3p241gFcpQpBLHx52m0UDly+06VBpZInHbfSXHHMey
         J5HALJNKwQNHaLGdPRXeWLNvWnRUpXUqTdV8uYE2QB+MmAV2Lx3Kgto372cyPz+qAzyY
         jS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767088251; x=1767693051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AezMIr78RfBsrmMoauKZQnKcpLtYq7A47d6aa9ubbLA=;
        b=evajUO5vruoqzSBIrFrqXUttMQWLP7FddBGXdeuVTQFxZlpVh6+ZxRFLCy6ahr3oaB
         iAZ+fWqiRDQRzGr2l8ofuc81gyP978dquSOTYgC7gh+JuYEPvvoLGjifdWmGJHw1sOoH
         0HSNEmOMzbtskLAtTqMJqUTHmXvVCe3hMZZVCnf2SJ64VsZAVkL0weqQaKPzTvT+8BGc
         S51RM4U6qEdJoqazyD1jT1ZdEStTfXHzZ+sKw6HlX2y+cVLckJemnVSMM2RDkWivFN2V
         /Qj55zQOH58PVd0VR1v+bkJgbLcbOefQXlj2wYyP0hKzA6lGkuIhd0Ko8165Jt4ES49y
         UbAA==
X-Forwarded-Encrypted: i=1; AJvYcCXm49uuPYSmfoUJsLviOm8Ro62QRcLsBqRdFMDKaqQ2ZM88FWbo0ojbRYcGw+FqsnEu6RLJIfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLeBKDx0s/Ye0hPIpfqUN7ATR6Ny6Ux4/J/+p8QMiAHNSgv/m
	q4nzetszVuYl+5pINO6nzSWgSFC25zv3qRs35/0/S4vgkWR3bqshlFOWXlwv0XLtq4D7VigcoTx
	U6WHdflJLARV8ObCD4uw8qkvSmxFnod/i1ngIjz3MDJapD8QUMRCWsh6Pto+alAugc3d3bRM1Qv
	gwK6ZhCNW49sdBD8iU3KZ2feSxj9M+T+eRYg==
X-Gm-Gg: AY/fxX42AVCmG1tZhUEmpp0lQYSDzctZ1gMmuZ/TaVA/pyG8AMNZCRBJjfNOlAqCELc
	oXZbwRTI8sF+NEcyTHTvT5psMy7NsZhAMvIoGBj419NRr3H8f4/LKVIo4k+8T3j4/nQ6tSmzExz
	L1UcqGnHmgIYpn45B6kIrunu0hkBgoRWYQrTFjMRd0PnQRK8FHnGXitj6MguH5k7PLYBDMAG7Wf
	8EhbqdejRrsMR8xEjbM92WByRw=
X-Received: by 2002:ac8:5d4a:0:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4f35f473c35mr604284911cf.36.1767088251025;
        Tue, 30 Dec 2025 01:50:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBZ8wGhLditZxalNu2tU6+Li0eUjoydVwABPejTw07ZO7ZImHvKWvoB21fJbJ3aHwmUgMYAoppRtYmiE6I5QA=
X-Received: by 2002:ac8:5d4a:0:b0:4e8:916f:9716 with SMTP id
 d75a77b69052e-4f35f473c35mr604284681cf.36.1767088250633; Tue, 30 Dec 2025
 01:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119105615.48295-1-slark_xiao@163.com> <20251119105615.48295-3-slark_xiao@163.com>
 <CAFEp6-23je6WC0ocMP7jXUtPGfeG9_LpY+1N-oLcSTOmqQCL2w@mail.gmail.com> <4c4751c0.9803.19b3079a159.Coremail.slark_xiao@163.com>
In-Reply-To: <4c4751c0.9803.19b3079a159.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Dec 2025 10:50:39 +0100
X-Gm-Features: AQt7F2p7sKuK-wJ52q7OokTd49nAsSxFeSzV0kjXlxjYiHpoVgcVY-YAufvZoHE
Message-ID: <CAFEp6-2NBa8tgzTH__F4MOg=03-LO7RjhobhaKHmapXXa9Xeyw@mail.gmail.com>
Subject: Re: Re: [PATCH v3 2/2] net: wwan: mhi: Add network support for
 Foxconn T99W760
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA4OCBTYWx0ZWRfX4T0r93524ACY
 +7Z8ScFVztQLjWGJ46es/2N2zq/Ue5WrcwkcwTTJqDBnPoN1+UdpFCT7CSIJqsnlJk692P1G/8b
 Eg3bV5CVXQLDo0kkKTGhz6oVsmJHPmsGHN4oAGOWlu+OekOAL8eTizxJ1b0XMcPL/zuneUNToA9
 +GZZACokWuugUsmEc+awewUiLrSOR0weHnUMo+9B0jUlMnxhOXfmWxoiHjAjUIMTVEfEmNUekWA
 YZPEcQlHbSz2NQgN9zVVz3Vb1dGJhhtk3JqKOBiyfBHCVatIH8vPd2QXX9wOh0abwGag2MtZA7K
 zGWphKpVQMLdro2G8EUgBnxhA2VVzf82kUy403s3PEe2xDzJ+18CTo4affrJvk17+vRkRFyOTOH
 tZiKtVxsR1QG4cJNGZkfQRm/LZ854sPIZUyGsDNxhYRRw7xN+DvV7FzNoBjinmslAdIXv/PGgbN
 zDP/B3eGVZRDnDyzvoA==
X-Proofpoint-ORIG-GUID: aUHQS6aq88LPsJwQ_uxJzL4j6xGVoUGI
X-Authority-Analysis: v=2.4 cv=WPRyn3sR c=1 sm=1 tr=0 ts=6953a07b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=EUspDBNiAAAA:8 a=UVxOvI1-KtSAPj58WwEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: aUHQS6aq88LPsJwQ_uxJzL4j6xGVoUGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300088

Hi Slark,

On Thu, Dec 18, 2025 at 9:01=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
>
> At 2025-11-21 20:46:54, "Loic Poulain" <loic.poulain@oss.qualcomm.com> wr=
ote:
> >On Wed, Nov 19, 2025 at 11:57=E2=80=AFAM Slark Xiao <slark_xiao@163.com>=
 wrote:
> >>
> >> T99W760 is designed based on Qualcomm SDX35 chip. It use similar
> >> architechture with SDX72/SDX75 chip. So we need to assign initial
> >> link id for this device to make sure network available.
> >>
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >
> >Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >
> Hi Loic,
> May I know when this patch would be applied into net or linux-next?
> I saw the changes in MHI side has been applied.
> T99W760 device would have a network problem if missing this changes in ww=
an
> side. Please help do a checking.

You can see status here: https://patchwork.kernel.org/project/netdevbpf/lis=
t/

If the changes have not been picked together, please resend this one,
including tags.

Regards,
Loic

