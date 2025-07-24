Return-Path: <netdev+bounces-209812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2BDB10F52
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B175882F2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCAB2EB5B4;
	Thu, 24 Jul 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmiHpo44"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550F2EA493
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372793; cv=none; b=lWbBHeBXorIlij6XhE6cibL42rsSAXy8QwSo+ItRfsPvGKeapGMbEw5zbPusooYcqdW6BREov2RqQV0NWGgtBBXHijeFsBo5OS/i2XFrVZag488RNTAfXdtnPXwiVvPkontx4MqQBohgA0zXwau0FqVkUWx7wVqfLciS48Wb5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372793; c=relaxed/simple;
	bh=dx2VRA6BvKhPA5vORygkUm1H2jI84JUEt7OvOhDTkvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjy6INlY4+8eGXTtfNi48ktNlW5xn2bqTMbkrLoMTLZGoi6+Au7i8H+ApN0awdzspYpOfBsoClJGTeAWz1/ymEplhW4gF+VG6E+dJa/vbjqJ0mnhc1oHv/m6OvfrE8+eEFZf64K9Rt5kjOxgQ1c0NXMOkIINlkody6kNVz8I1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmiHpo44; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9sSFJ018720
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=E/S7e90kXRCRpl38LXl7BBpUAVdm4Oac/G4ZTBf/0QY=; b=Sm
	iHpo44TuiBkl95lDh7s5/8i0ONsK14PxaGGh842salt4lKbHGDKYqRgWLSwY2FD1
	nWZN01VGh/KDIt5MozcKhx0b+hLZPGfLScKAW+kP4w2GGA0UWthNiJmWpmaP9gyW
	UwVFgqn4F1GgAogIuwYzluB5zv/hi5BG+65055wlaFJQMimr7ad4dlZdHkpturjN
	UFqfeNC1i/wEsLzJmUAIHTdoAN9L7fESrsKXcU5MzVpODumiQ+1qMhy3YFgjaYH5
	smZqlIdnJTc0Z4yiTbb7spGPk+fq56K03cbQ6AipBpn4GXdoEvAh03tJJqGh+KWe
	UGg/6PcP5KnQTgBl+LsA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6uf4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:59:50 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4139102c793so1118639b6e.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753372790; x=1753977590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/S7e90kXRCRpl38LXl7BBpUAVdm4Oac/G4ZTBf/0QY=;
        b=G5BvGpWkfCGPKnCMc8PIO3mryTiB4C0Htju4l7EURkg9cLf6fQC37C2cv1TR8LtbSE
         H+/6NugpGHB4/SWzmPpAYgDTMAOaNrwoGBiNwAWwaT7XRoMktuLdk5UNz0bFY8Y7+d6/
         OyPnT+cj3ukrKmWUx0fKWKOdjGdrlwjPHrzK7O8FNhNnoiZ6umNZvMSlL/vmSrEENHeO
         cBv3D8R/Er/iTsD4urOmQscaweXRETNyQbRcdI/RnsmTRCWQKAP4PTaeFEFVeYTlkpca
         RLhRTVa6pCpMub8SWDP0WtNFOhbMVHiNYvgPVAnRXE+sXGjvnYHXNIMZKQ8cZnfxFTXX
         ktTw==
X-Forwarded-Encrypted: i=1; AJvYcCWkQFUEdQBy5AQCfL7QmmtSvkCwE2AW5s8RPeKBcOJQS46hcaRGMXVBSk9bfioZsNEIqbX3K8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXJ7BvtCGgErtRzpMhsEaG17EDWz9bBxXkGp3X1iMriCEKzH8
	wQG3qSzYqijlnWxncUHatPa4dDSZGQCTp2tfmzLfGWhsB5ct40uShK7HMOp78n/9/93JmENa+Ep
	mKwDaOKqCJY25oQZAhTaitdaESNGDkiuakKCPxI5fkddvZ8WKIn7mybMAhaoIA5+wiD3GQGwH5k
	k/Ieeo5Z6JhXR1f8TeYyZmp6bMzku1Fw7VCw==
X-Gm-Gg: ASbGncsifDdIMDsye5ZCG1fglJ8k56+g/d7975T1GxBrGgAtmE7xlK+UmBTF+O1naEQ
	BWFGUXvJ76GHSxvARt2ZdCLTy4vjb6cGQP7aziBCbwEKhLcnv+e/7BsHLckvSY7JfgdBDFTS2hQ
	Ykyz412S/AN2QM0CqoD/4pk2V1E59DMGGUY8Dw3+rUHo4B2rJxjdIB
X-Received: by 2002:a05:6808:148d:b0:406:67dc:85e5 with SMTP id 5614622812f47-426ce19e982mr5554836b6e.32.1753372790007;
        Thu, 24 Jul 2025 08:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGpXcKJ3QbUsbLvKRbDwKfkM5/VNGjGNkn2YEywAD3WzJbVx/vrkRWsPUkc0+Fk08vMtSUlyQSZ5q6OmZK0oY=
X-Received: by 2002:a05:6808:148d:b0:406:67dc:85e5 with SMTP id
 5614622812f47-426ce19e982mr5554818b6e.32.1753372789630; Thu, 24 Jul 2025
 08:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722144926.995064-1-wasim.nazir@oss.qualcomm.com>
 <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com> <20250723-swinging-chirpy-hornet-eed2f2@kuoka>
 <159eb27b-fca8-4f7e-b604-ba19d6f9ada7@oss.qualcomm.com> <e718d0d8-87e7-435f-9174-7b376bf6fa2f@kernel.org>
In-Reply-To: <e718d0d8-87e7-435f-9174-7b376bf6fa2f@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 08:59:38 -0700
X-Gm-Features: Ac12FXw0dD-ILdlDq0K6v0A1YBmDTK14Yafdqu4VzvYZpcerQkSvDG4iv4VMLfQ
Message-ID: <CACSVV00jef8so-jqjCaqJehj-XN2OZ562_R+Dod64+C4-dmDhQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: dts: qcom: Rename sa8775p SoC to "lemans"
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68825876 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oW_OSN6b07XpTVcMi7IA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: WY-OwbV-KJLp2zecE6h44SRiSOmvlvH8
X-Proofpoint-GUID: WY-OwbV-KJLp2zecE6h44SRiSOmvlvH8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMSBTYWx0ZWRfXxpPxMF3jHoDb
 W2xV6sHNFONrWFvT5FJRl81IiyYYH1ylyHnzP2QV5XTcueiyJ4NO1giWlW5gx/NXzXmndlQm1H/
 fuG8ZqaUbSJSJnPLWr26HloxOSjaj5OdbwgMUwFVST1S2JnVK5gkM6d/+xKWYZ00mP/Dy9WV64Q
 gTZ8Cog8ql1eJFzvHs9AgbCi9RYBmOiB0x9m2QKozls4ac1IrJ7DpNU2wqqg9SlqKTuMgN17gVj
 XfhZ27kBUaS1FC8kAWqLwoNxAGuQxVYVg9/F2YnbYkjY2dYhbAXmhlbIgslihJjQjNTBdUKtzYG
 9cwv1C5PLvttCk7XFnwoNouVkq4hPv4EnRUlE0Ux7bbpCNixB3pMoTJ0LTOj2eWuHoctoRdXeaC
 Cyx7FXmplf/mdG5diCU5y0WZHqFY2M1wkeWOdzpw0LEUkpuRn6aWfrzj5zXgLotn6r7Y8nvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=852 impostorscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240121

On Thu, Jul 24, 2025 at 5:52=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 24/07/2025 14:47, Konrad Dybcio wrote:
> > On 7/23/25 10:29 AM, 'Krzysztof Kozlowski' via kernel wrote:
> >> On Tue, Jul 22, 2025 at 08:19:20PM +0530, Wasim Nazir wrote:
> >>> SA8775P, QCS9100 and QCS9075 are all variants of the same die,
> >>> collectively referred to as lemans. Most notably, the last of them
> >>> has the SAIL (Safety Island) fused off, but remains identical
> >>> otherwise.
> >>>
> >>> In an effort to streamline the codebase, rename the SoC DTSI, moving
> >>> away from less meaningful numerical model identifiers.
> >>>
> >>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/{sa8775p.dtsi =3D> lemans.dtsi} | 0
> >>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi             | 2 +-
> >>
> >> No, stop with this rename.
> >>
> >> There is no policy of renaming existing files.
> >
> > There's no policy against renaming existing files either.
>
> There is, because you break all the users. All the distros, bootloaders
> using this DTS, people's scripts.

I think that is a valid argument against renaming the toplevel .dts
(and therefore .dtb), but renaming .dtsi should be a harmless internal
detail to the kernel.  And less confusing, IMHO, than
qsc9100-myboard.dts #including sa8775p.dtsi.

So wouldn't the sensible way forward be to rename .dtsi but not .dts?

BR,
-R

> >
> >> It's ridicilous. Just
> >> because you introduced a new naming model for NEW SOC, does not mean y=
ou
> >> now going to rename all boards which you already upstreamed.
> >
> > This is a genuine improvement, trying to untangle the mess that you
> > expressed vast discontent about..
> >
> > There will be new boards based on this family of SoCs submitted either
> > way, so I really think it makes sense to solve it once and for all,
> > instead of bikeshedding over it again and again each time you get a new
> > dt-bindings change in your inbox.
> >
> > I understand you're unhappy about patch 6, but the others are
> > basically code janitoring.
>
> Renaming already accepted DTS is not improvement and not untangling
> anything. These names were discussed (for very long time) and agreed on.
> What is the point of spending DT maintainers time to discuss the sa8775p
> earlier when year later you come and start reversing things (like in
> patch 6).
>
>
> Best regards,
> Krzysztof
>

