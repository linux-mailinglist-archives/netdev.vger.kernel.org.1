Return-Path: <netdev+bounces-228532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B60BCD608
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EA342209D
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138D62F3C12;
	Fri, 10 Oct 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8hpJmsR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5232F49E0
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104805; cv=none; b=CM2yw1eil6DfTCX00nKxgVoB1K1PV3WWAn+Tw0LpvuYqz02mx80VmZqPseSl42+5LIcWfQwiH1QcUz0PuWzBO6K9lVTeFWFH4UD6+Xn+t8dYPvZCY6JiizYVB37Yfd5vOqzV0sdpxFWcYnR2qhcxha8/Hr3t1N0RU082ahU19P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104805; c=relaxed/simple;
	bh=iqc69dkAAntVnNKo7FzmB3v9krkGoNIny3X6Dziw5p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLLMtMQLE/d/DvMuHpozh86CcgLvmpnp7+KPctP89dklWEg8LXCavp70wwUlgycMIjpHRZEJp0jZr24u+r5p/GZovFUiZDUDt9B391zSpcAF0wL9llqjw8ZowRJq4r774TqKJ0OtTkHVy3Xff+CE7HOYHBgEc6NcS0FaxvRIyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8hpJmsR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4257aafab98so1847285f8f.3
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760104801; x=1760709601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJXqHnS/O+YL38YuRDMQTn1Jgvn3WgcV3heOu45xAag=;
        b=I8hpJmsR7psWyGbtUcKXoHGeFbOAIXOvIhfuiX/6EPwwHVoTGufvkTSV4UUzMqUMoD
         j1SLGJwcLipB8fOFdLpsRoYqoniBV/d5+TuRO+GuxqlG5XWlGDp35CC1unFeR9nDzWk1
         4iQ6A2e+8tNt0jH9PSxwtmvSQ8a6tvfPU8QuFJ+l+QRdVc/gknK/xqAVecWuTPqO52Ho
         aFEFwEH2Pfsze1wtqUgsQ7sfZkbWS2SGv4VoQeBcysQShxf/e2ScyfWAbzkBzbKhrgh8
         V0eC8cswXoiklQZkTCSVzwmysEGqUwE2rkJ4nzCsIetKER3IZERn0gqz34n7xXCESAgU
         bCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760104801; x=1760709601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJXqHnS/O+YL38YuRDMQTn1Jgvn3WgcV3heOu45xAag=;
        b=WtQBXJcJ0iJf22PuasmazScffBZEq6BsvX3RQPesJUTgIhGxzKbKX75O65KT+P0NCZ
         fut614RJqrzBlS4On2N29PybldWfWwknOETtqKF+5q4su62Wxf97U0X6x/ztV/xRcsW9
         JD3VClttTLizxApCnKO5gRvfAW1PKiMJ4EtY1H2YBmNGeE0ZIy8XCLKWyHX9ZhiDIR1l
         b6+MLp9ztm4CWfdZiODA0DPPfRQzi31kHiSf4H7uTLGQ9rMuBv9lTLzszlpp+wMkjew6
         OuisMxyjby+s9oSQr8Lr1YVe1RUqqGpC/yy1odaUeDwOG+39mxCg5Hk7p8Dv5CG4Zw6i
         0csw==
X-Forwarded-Encrypted: i=1; AJvYcCWA/BdfDuQIqZJeIYguBJxAajmxkJRYCP5oJBpBssLLR8ZECnHmvb9hfKGbTQyAdxFr9CyWr+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4gZHRe97Dxuh5oVKmu7UrZWa5xnJZ4U7timg2gzzKDc5BJUi
	CeXR1rvnkZo/ixM30QdBkKcfrpad7kc6TcMJHDTI/FBJNwAPw16jQlyo7eJ2iiRh6Zo6ssVDjCg
	xd55YZYOX4NFl8YSUfQjQzogm7z1yocw=
X-Gm-Gg: ASbGnctmSeedEnz90yQKNsRekVPEoCI2ruay5YG1pOakb9XEFyX7AAgRXUNLA2beCKx
	qvtb0RFs0ZX/9KbbkksWnVl4N3nlPu9ckYgWdZ1hdDjOMkYavTprTZRxfrBPQ37p+pIlx5b2TIB
	mFv8QBjOQXyp7JmPiRASYIY818VIfI9pZ9qOCWoCY5JRiOu0az84Qa1/Y9dAA4YJmqzuTjachx9
	0/X3NoX9l1k52jUeEz+xPM=
X-Google-Smtp-Source: AGHT+IHfnfRD6SsG2gA+TdNKy103ZNKw1cDwP4Yv1I4fUinuqwTrMBJmv1DYdTJKi9B879lK9Yu9eZP6MqcpkgJ7btU=
X-Received: by 2002:a05:6000:4304:b0:3e7:6268:71fd with SMTP id
 ffacd0b85a97d-4266e8d93b2mr8218028f8f.52.1760104801144; Fri, 10 Oct 2025
 07:00:01 -0700 (PDT)
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
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
 <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
 <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com> <16c0b1fa-9617-4ee1-b82f-e6237d7b5f6f@gmail.com>
In-Reply-To: <16c0b1fa-9617-4ee1-b82f-e6237d7b5f6f@gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Fri, 10 Oct 2025 15:47:30 +0200
X-Gm-Features: AS18NWAmYq0Khsc_LwELOxAaZZpILHmsENDVpV27zNV8TstHFqJyUB30-yycNss
Message-ID: <CAGRyCJGHv19PJ+hyaTYf40GeGRHMXKi-qO0sgREnS3=7rfWGqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Slark Xiao <slark_xiao@163.com>, 
	Muhammad Nuzaihan <zaihan@unrealasia.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey and Loic,

Il giorno mer 8 ott 2025 alle ore 23:00 Sergey Ryazanov
<ryazanov.s.a@gmail.com> ha scritto:
>
> Hi Loic, Daniele,
>
> On 10/2/25 18:44, Loic Poulain wrote:
> > On Tue, Sep 30, 2025 at 9:22=E2=80=AFAM Daniele Palmas <dnlplm@gmail.co=
m> wrote:
> > [...]
> >> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hws=
im.c
> >> index a748b3ea1602..e4b1bbff9af2 100644
> >> --- a/drivers/net/wwan/wwan_hwsim.c
> >> +++ b/drivers/net/wwan/wwan_hwsim.c
> >> @@ -236,7 +236,7 @@ static void wwan_hwsim_nmea_emul_timer(struct time=
r_list *t)
> >>          /* 43.74754722298909 N 11.25759835922875 E in DMM format */
> >>          static const unsigned int coord[4 * 2] =3D { 43, 44, 8528, 0,
> >>                                                     11, 15, 4559, 0 };
> >> -       struct wwan_hwsim_port *port =3D from_timer(port, t, nmea_emul=
.timer);
> >> +       struct wwan_hwsim_port *port =3D timer_container_of(port, t,
> >> nmea_emul.timer);
> >>
> >> it's basically working fine in operative mode though there's an issue
> >> at the host shutdown, not able to properly terminate.
> >>
> >> Unfortunately I was not able to gather useful text logs besides the pi=
cture at
> >>
> >> https://drive.google.com/file/d/13ObWikuiMMUENl2aZerzxFBg57OB1KNj/view=
?usp=3Dsharing
> >>
> >> showing an oops with the following call stack:
> >>
> >> __simple_recursive_removal
> >> preempt_count_add
> >> __pfx_remove_one
> >> wwan_remove_port
> >> mhi_wwan_ctrl_remove
> >> mhi_driver_remove
> >> device_remove
> >> device_del
> >>
> >> but the issue is systematic. Any idea?
> >>
> >> At the moment I don't have the time to debug this deeper, I don't even
> >> exclude the chance that it could be somehow related to the modem. I
> >> would like to further look at this, but I'm not sure exactly when I
> >> can....
> >
> > Thanks a lot for testing, Sergey, do you know what is wrong with port r=
emoval?
>
> Daniele, thanks a lot for verifying the proposal on a real hardware and
> sharing the build fix.
>
> Unfortunately, I unable to reproduce the crash. I have tried multiple
> times to reboot a VM running the simulator module even with opened GNSS
> device. No luck. It reboots and shutdowns smoothly.
>

I've probably figured out what's happening.

The problem seems that the gnss device is not considered a wwan_child
by is_wwan_child and this makes device_unregister in wwan_remove_dev
to be called twice.

For testing I've overwritten the gnss device class with the following hack:

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 4d29fb8c16b8..32b3f7c4a402 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -599,6 +599,7 @@ static int wwan_port_register_gnss(struct wwan_port *po=
rt)
                gnss_put_device(gdev);
                return err;
        }
+       gdev->dev.class =3D &wwan_class;

        dev_info(&wwandev->dev, "port %s attached\n", dev_name(&gdev->dev))=
;

and now the system powers off without issues.

So, not sure how to fix it properly, but at least does the analysis
make sense to you?

Thanks,
Daniele

> --
> Sergey

