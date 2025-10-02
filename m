Return-Path: <netdev+bounces-227640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133EBB4633
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 17:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7726F19E3E48
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85987225788;
	Thu,  2 Oct 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ahx1ON0T"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A82253EC
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419875; cv=none; b=BnDmYtZOwqifrk1kSiqAWQJyIxx4o4CxGmHFdHuGr/i3vTjujTPsrG6OKC1jQ46fwIG41US3iK5cmHKfBIIew8MlDMOdnoCWpOWKLd1EfFoV9U237ET2J1w5gXI0SzSeTtuuNBqhL9j/1wCmjuRzGqKMJBh+jfx3jjMjyBXAQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419875; c=relaxed/simple;
	bh=UxHzdyKIz9NErZamOhNON54qx/OcGAIPJkO5P6MyjZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PELpzCNj1HEfzEvGT0fXBLdlPXaukKZn/HbrDWw5/ZqXXtLhWznNfID7mdnsSIKNkJYGpfKg6qiEDG4SZ6iX2UwKgUz3lMF3hvUnuQQT6W9R5z+TpkbsigFx+v85MwHgUz/H1JqOpVVdUylp7fOmANkMKQ5P2vJjke/vml6HCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ahx1ON0T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929LKMl023936
	for <netdev@vger.kernel.org>; Thu, 2 Oct 2025 15:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4pUWzEdgikQ/kbai36U3SixgG41Fve5ZtQpMbVYXqaQ=; b=ahx1ON0Tvf0SBrNG
	fQ4xjl5QaGJtD8H3A91yU8mgoHrDni5JDoJ5Ph3b3oWzaLAWajgQZuxQGUiMa1R7
	txXr+SZ455TymL7dW2RIi1R33SgN8EAY9zeDoBJMYsp75E5vK8FVpCABMiwlCtEX
	LFaE2/nkTkfEupcwyNiF8RRw70ShY/YvQBhg/PAL5jLrbNlPEhLtKnqJh8cYxdq+
	b1aWlZLwHVbx6qe3dVEcjXHjiUd9RxNPofIgDKZVeQUfgvZRTYxT8UrtZbpcwDag
	HnU9aGCE3lEP/bmI6/8jBswzYG9eT7p8Lf4HXTA8LrJvv7Fb0MOfPf3PjJPhwWOv
	7VIpHQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e97801px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:44:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-871614ad3efso239956285a.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 08:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759419871; x=1760024671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pUWzEdgikQ/kbai36U3SixgG41Fve5ZtQpMbVYXqaQ=;
        b=cxIvoirzJU1GY9wVcK/cxIZSFhtqP1dzWFO3GmMll8HCTxSBTQLDcL+K7zxSYIXP0n
         CstorxoImxyvDWwhYixQNRr7tWtYQikzx8Ur2a/jXJawKNDfLZqWeGovn0rgfQJ+KWlN
         U0iXNa6pS+/ezbeYQq/3Yx735ViR36ciJBu6VjPuyU0kOitlqRHAgLz9XS0EcCcJoS/u
         ZUyVR6U1HvW5BNzKxRb7yWDxuyexvpQ+0eiYBiDB2gjawv/QMcVYnFmmFFQPNqtLG+ZT
         Wq/vc74j9+eZdMf+8N7G6SGmQWy2hoKIWvcSvSfAfk3VPZ/x70BT5E/GJQU6jvw3A/qL
         rSzg==
X-Forwarded-Encrypted: i=1; AJvYcCUBGnze1HSDat0mdEh6r4pFt/FXsXzLQJmO/1J7jSAD+lg/lwtygserg/RJnJlR6otte7plZ4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/YnVAc1RovPXYVAaNLy4moWDAFsH/3oKbc6QVTCrF5qbLKtz
	vh5wIe3HCSIuyDA40UlGrpBTd7zQLDXFh907O2/aJEJfETQwlr2qlKou+aIEpZKvIxRb+r3k44W
	BJV6i4YcQYEJAfAxicU8iZxRiBWiAOmuDhx4r5ZZaBZi2FUnX0KcDHmL4CmyBuAzehSRWRnxjyQ
	Noe/CHLJKo87q5f6wLNOkXG/nkKKnPGHdY3w==
X-Gm-Gg: ASbGnctuiNEXxsx2RDZWKb0lb42wBoka0Zf9Hryr+TMaiYDwO6qXaS9ts/ZbGNlk3hI
	cW+OnUEbOTq+NiSR6pDS/mgIdMatoigeHXASIuDcBEQTMWq8L8QwP7IOxShw5A7YXkUCTiy1+HI
	uHZ78UuoOPzGQKYQVKkYOKdAPAXdm0ZoZ1V/cj6psNlcg7qwcCT1Fvn2hVZod5
X-Received: by 2002:a05:620a:700b:b0:7fd:50bd:193b with SMTP id af79cd13be357-8737021b043mr1138016385a.14.1759419871248;
        Thu, 02 Oct 2025 08:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOrEIdNNFknfjq39G3gyctMakbGuVTfty1Bze68lUZ2tGc1brEEL3sp7rl/J3EfMiWunbkQfZs7lTUjjcHX5o=
X-Received: by 2002:a05:620a:700b:b0:7fd:50bd:193b with SMTP id
 af79cd13be357-8737021b043mr1138011985a.14.1759419870671; Thu, 02 Oct 2025
 08:44:30 -0700 (PDT)
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
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com> <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com> <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
In-Reply-To: <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 17:44:18 +0200
X-Gm-Features: AS18NWClc0vik2lP2F2gI8sM5EqZdRaic7ktszwKEnxDvZeGQnoJO2qf4QgM0q8
Message-ID: <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com>
Subject: Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Slark Xiao <slark_xiao@163.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
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
X-Proofpoint-GUID: X0ywkNwmwAlyy39msXZad3_IYGZk-3Hv
X-Proofpoint-ORIG-GUID: X0ywkNwmwAlyy39msXZad3_IYGZk-3Hv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXx6cOzT5zy/Dj
 9X8bl3Zc6/fu88dB7s6ua8h9Nt75pIG1LaehVb8L105Ibzg2RXA9yHII27jdUPmjBRpCmtNuzla
 muFSBy233Op+1vpcXsP9x1UzHQHPo6//bBSiLkSt4VN7DvWg4Cjz2otYrFGjkFh8xkZqHDtoKjj
 1FOzBAw7HnmqxytN6P3EU4lkvvJZmZUqfmcEyuwGUfH1Bb+bxr8SuUzob+sF33qaFCRO5pzXnjh
 5q187VpVbLaWcQx2Kv6xHB1l2cO1txoJkWFdmTr5Gmw6OMQIe82UJ9P6A9GblPIOfVRGM7aJvSv
 WZNjG6jSOGz+ziD7X64f4FuF9CgCGfW/S9g8+59D4p1dUg7gzyLMGDod+CjQsc7yNJYl7+cz1Hp
 kl2zS6VMmZqkBT4yOXxft8f7yoSAAQ==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68de9de0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=DnLhdxUMAAAA:20 a=pGLkceISAAAA:8 a=OqwHkW_Z6vu4_BfPeEwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=yULaImgL6KKpOYXvFmjq:22 a=CTwFTDRtctY-zZ8oRDn3:22
 a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Tue, Sep 30, 2025 at 9:22=E2=80=AFAM Daniele Palmas <dnlplm@gmail.com> w=
rote:
[...]
> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.=
c
> index a748b3ea1602..e4b1bbff9af2 100644
> --- a/drivers/net/wwan/wwan_hwsim.c
> +++ b/drivers/net/wwan/wwan_hwsim.c
> @@ -236,7 +236,7 @@ static void wwan_hwsim_nmea_emul_timer(struct timer_l=
ist *t)
>         /* 43.74754722298909 N 11.25759835922875 E in DMM format */
>         static const unsigned int coord[4 * 2] =3D { 43, 44, 8528, 0,
>                                                    11, 15, 4559, 0 };
> -       struct wwan_hwsim_port *port =3D from_timer(port, t, nmea_emul.ti=
mer);
> +       struct wwan_hwsim_port *port =3D timer_container_of(port, t,
> nmea_emul.timer);
>
> it's basically working fine in operative mode though there's an issue
> at the host shutdown, not able to properly terminate.
>
> Unfortunately I was not able to gather useful text logs besides the pictu=
re at
>
> https://drive.google.com/file/d/13ObWikuiMMUENl2aZerzxFBg57OB1KNj/view?us=
p=3Dsharing
>
> showing an oops with the following call stack:
>
> __simple_recursive_removal
> preempt_count_add
> __pfx_remove_one
> wwan_remove_port
> mhi_wwan_ctrl_remove
> mhi_driver_remove
> device_remove
> device_del
>
> but the issue is systematic. Any idea?
>
> At the moment I don't have the time to debug this deeper, I don't even
> exclude the chance that it could be somehow related to the modem. I
> would like to further look at this, but I'm not sure exactly when I
> can....

Thanks a lot for testing, Sergey, do you know what is wrong with port remov=
al?

Cheers,
Loic

