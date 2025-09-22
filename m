Return-Path: <netdev+bounces-225144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BEFB8F659
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BFA189AEBC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAC2F0C6F;
	Mon, 22 Sep 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXFF2VLu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0B261B71
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528227; cv=none; b=Q4AlmmIPMKnYj9n6oLuns9Gtgk6zkbILhWqCRSUs54gAIdiZPLfDcPbbBzFRRZ4LwGm/cCIS1DRbm1xVztN1lDyTbH1kmwvB2vKD9/9kFvCOj44LJfEudvHcPx1OPaxG9pY6eZJptGhucCC/D3FenAQzmHKWqOruSyP6wytH+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528227; c=relaxed/simple;
	bh=fLKl5BZrVFIqTJqnBHvS8kMf4N8M7UHmQdFKi9gvXMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gehPgDFHseZeW3Clog9oYYpefdOSIepf9yYCwMlht2KXwEGOz6hi+ooDTqVLZ9VIQuMumfCOf5lsW5JxUGE/mHG1JOARK6AWhHjOkVVdCFutUOj8UV725TtQ/Wcyn0XgMhZlkppdfs0wgBg7ZY+WbEDwO9dZZKi6W28W78fwTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXFF2VLu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LNAoRx009803
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fLKl5BZrVFIqTJqnBHvS8kMf4N8M7UHmQdFKi9gvXMY=; b=oXFF2VLu4IBZmzr0
	EduJWK5Lq0b/VLAP19RjtrB7oEfiIoIRw4LUR+WTbMHXC1Q17p33+R070ZqOULfJ
	kvFNeElSr1itsHW3jjKhF5XspJ7Ua5W2dpc/DsekRg1C3LRB+M0G1Bcvbc4jAZ1H
	FF2uKj8PoZbQEckDIdC+f35yUJnjrghZPwG/fEtVmdDknI25Q84QgJCPoKIJZ27H
	WU0AHZMxCfP3VWU8MwH+sDHGP4wQlR9LG/w2wuEqWJJ9gB02VQeFvhzc1L/722Wv
	N5a2Pvj7/dhhFA0Z0Zp076k+kdjUE+hn0bwmkI2DIXMP4p4cEr8BBHH8Ja4SksPi
	RqQssw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7bv46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:03:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-84d47fe9a38so56527485a.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 01:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758528220; x=1759133020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLKl5BZrVFIqTJqnBHvS8kMf4N8M7UHmQdFKi9gvXMY=;
        b=NV4d1twkiTKB59HGhC755yOfHP6c+VPqBDxpMD6nsEF9wzkiTkPwcGO5VkcT5bf9Rb
         Ogz+bA34olJf1cgl9GZzrKbKwjRS4MFUhsH4LXnkYJhBm/iz655AbVf1D/rEkErj6lfH
         KeeLXgX9t3kwdGt0XVXmKRxn1Tk9GEx9Me84heL0WpS6uVHeqDNaeC8sGZk/aeLQsUtE
         +ZG9J7Q2JeYoMzFUXaBHuH92dlzplCE04OkYPyJPW/tpzpnrUUEaB7Pt/bIqOplLiOQk
         kIaptGa8KO3ngFa/IaovocI+4fvJTSq2Tix5x5W9XPgXxa7WlLNvp2i3be87b7Lp4tpX
         bXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUwpnMn3epOxedbyQO8hN3IdHPCqZdLmjZ9oQAjUuOGekEZJ/sXTl0lRL0djpv9LbhYGK3/2mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTh5JR4DAyvAgNRHW4rSzQ5z6oC7aUl9lj12cWWt3YBnN5AtVR
	Ue5R3sul343JhhTjIHzB0EBitgtcoq/qNupA5tbzj91EmOR0emWgtAbwkcDx6tinAeGt+607FBp
	rS8Ol2MyTyGsAgupm5iAXGnmxfkIfWX/LcMwTVIPkDf8/9svN+/SzVmFwtrR1u3sMwUBXApE8O+
	Zf4bKpZJ06tHKVd6cBXVSRrKkf9cXEdOm+Dg==
X-Gm-Gg: ASbGncsYX2/xiEaPJj9GR/RruX3G8wHfU+N9Koz2a/fnF3+xSh3L04BInsTssR6PgFO
	2w1xNedJ8xALcGoOeacK7f9PbEfU43tWShCIbtd4mwPrstYmBZ/TNeMOVC/YdS3XCqShnF1G04V
	zxP23p2U9KbbFKzDQwOdkhSw==
X-Received: by 2002:a05:620a:4393:b0:815:87ab:37e0 with SMTP id af79cd13be357-83babdff5c6mr1268017885a.53.1758528220065;
        Mon, 22 Sep 2025 01:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqys2ZL24s8pE3wvIl7M0E22+UmxX1VoxgNicx598mhC5p+BqbxS51NSzIieddQm/cJKvxrjLJsYPhkO6niXE=
X-Received: by 2002:a05:620a:4393:b0:815:87ab:37e0 with SMTP id
 af79cd13be357-83babdff5c6mr1268014985a.53.1758528219499; Mon, 22 Sep 2025
 01:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com> <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com> <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com>
In-Reply-To: <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 10:03:23 +0200
X-Gm-Features: AS18NWBY2oKLGJ6LS4Jm0ZJK1TBoTmvwAsXc7Ca8w95mwuKMpgZcHbNYYyFFwWQ
Message-ID: <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
Subject: Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Slark Xiao <slark_xiao@163.com>, Daniele Palmas <dnlplm@gmail.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfXxCz+hfdj+0y4
 VS1K8x20SwITP4BkoMytCNxG15i9SYASrvyXTBf9MOALwmKsUxunYqEqIRhZHfFRbgL+NFdp/ZO
 4muKF+GCSv2YIReOjM6C6ByvHCvc/Pe/G5NEXXFNGO6DDKgRH7A4UWeN2l7CsTfBbFacC+7Ex8c
 +mCpxh/pBsilQhkaiJennjART17JNvJhRmDNmVco95eK1Mg5eR16yeZzSUgXSkwwi1FWhENMi9N
 lsjSDLaPB4F1tt+hXTDWScFKFKGvbfMFAoe6bDsKd2o6Ov8LTby7sVwCVsnmkovA2g2YW+tvEY8
 wRMmdEfmMyOdXrkxOmymJvnfZUOtyGyROkoGBVak5OEdwWGZ7t2GOgNpvDrw0f2XqI0V0XDuNX5
 18DJst6o
X-Proofpoint-GUID: 11X_xoRHnB_ZKiSo4ASt90iaWrHx3FRn
X-Proofpoint-ORIG-GUID: 11X_xoRHnB_ZKiSo4ASt90iaWrHx3FRn
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d102dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=eINbez4ZVvDlUURrAYQA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

Adding Daniele,

On Tue, Sep 16, 2025 at 9:23=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
>
> At 2025-09-15 00:43:05, "Sergey Ryazanov" <ryazanov.s.a@gmail.com> wrote:
> >Hi Slark,
> >
> >On 9/11/25 05:42, Slark Xiao wrote:
> >> At 2025-06-30 15:30:14, "Loic Poulain" <loic.poulain@oss.qualcomm.com>=
 wrote:
> >>> On Sun, Jun 29, 2025 at 12:07=E2=80=AFPM Sergey Ryazanov <ryazanov.s.=
a@gmail.com> wrote:
> >>>> On 6/29/25 05:50, Loic Poulain wrote:
> >>>>> On Tue, Jun 24, 2025 at 11:39=E2=80=AFPM Sergey Ryazanov <ryazanov.=
s.a@gmail.com> wrote:
> >>>>>> The series introduces a long discussed NMEA port type support for =
the
> >>>>>> WWAN subsystem. There are two goals. From the WWAN driver perspect=
ive,
> >>>>>> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). F=
rom
> >>>>>> user space software perspective, the exported chardev belongs to t=
he
> >>>>>> GNSS class what makes it easy to distinguish desired port and the =
WWAN
> >>>>>> device common to both NMEA and control (AT, MBIM, etc.) ports make=
s it
> >>>>>> easy to locate a control port for the GNSS receiver activation.
> >>>>>>
> >>>>>> Done by exporting the NMEA port via the GNSS subsystem with the WW=
AN
> >>>>>> core acting as proxy between the WWAN modem driver and the GNSS
> >>>>>> subsystem.
> >>>>>>
> >>>>>> The series starts from a cleanup patch. Then two patches prepares =
the
> >>>>>> WWAN core for the proxy style operation. Followed by a patch intro=
ding a
> >>>>>> new WWNA port type, integration with the GNSS subsystem and demux.=
 The
> >>>>>> series ends with a couple of patches that introduce emulated EMEA =
port
> >>>>>> to the WWAN HW simulator.
> >>>>>>
> >>>>>> The series is the product of the discussion with Loic about the pr=
os and
> >>>>>> cons of possible models and implementation. Also Muhammad and Slar=
k did
> >>>>>> a great job defining the problem, sharing the code and pushing me =
to
> >>>>>> finish the implementation. Many thanks.
> >>>>>>
> >>>>>> Comments are welcomed.

Daniele, do you think this feature could be relevant for Telit
modules, assuming any of them expose an NMEA channel?
Is that something you could test?

Regards,
Loic

