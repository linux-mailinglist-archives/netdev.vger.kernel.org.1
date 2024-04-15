Return-Path: <netdev+bounces-88137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C0A8A5E4C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 01:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB31F21E63
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69C158DDC;
	Mon, 15 Apr 2024 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/jWDTGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B8156F35
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223846; cv=none; b=ff4MNwDLFXl+FTSwI2XHCiC2kRa70IeJJl1VR2kq8tTLY+lZ+JEk80yl71dc8jL5dg2p3m90V+DrLvmsKTwjrur/904jywiUjrlthPWHvCYWq8refDajy7/Kh441gZLGDpuL3XC5S87zRC5aiwTzxeBB90efdWAEXY1I5HUZFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223846; c=relaxed/simple;
	bh=NajtsMA4EDbiavEqAnc+j+erv1rNbusQwsRy3g+/ZHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlPEXgnR0qX0YVZXG9O0C+NM5YUXNqi8eyqFKt7rClaoC/KKTZ2iDH7s7/JGsQMGKak/mT142aYQjYgqHNAflS0FWTJHBds6wVL4GGAYYuOSdj1MqQAFeR2FriWvM79oZIn6N3Gh/XdJKQy6Y2becJaO1Wu/TYmuTqFZiwg7dzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/jWDTGc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3927500e87.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713223842; x=1713828642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NajtsMA4EDbiavEqAnc+j+erv1rNbusQwsRy3g+/ZHk=;
        b=A/jWDTGcFwHqUnX1thUWpACtQDn/5aB6cVEh7oOluyIDQ8XLBJF8UJI3lFQd6VnOn/
         J1r713Paux8EFGpDl1q7HbGCwDuPjtKOQMzLyHiBZHsjwIUYj17KdXT/6gtpiNCgwTVT
         LRMGr0G9zZYACi6z9w2mfIPDnU/tEez9kAZLRwsQBzsRnxroGnqc4f2Sq2ZyusncbluG
         QkQzXAiWhh7liiUMAXZG+02DTdEAzMuT15wlssfvtBGoh+5Kb/Oz8Tlny3hyg83KqxnV
         TSy+VVmeHSeVlQ9CzdfKxJyKxANWBXGrgP4wmzZ0XCLrzbeXit4OyeDRafVJ/z+dIo5w
         0OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223842; x=1713828642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NajtsMA4EDbiavEqAnc+j+erv1rNbusQwsRy3g+/ZHk=;
        b=QgSeua47Un75W5xfu9lTDQ883pDt0HCI9RGqB947QvKM4/K1RFnPHwMA+N10kDhdo4
         ik8Bd1ujS1l+6ZW+X4SoaCT9ErXjPZ+hhGb6f1SbfbgaboDc8vz5yN/Fxe66FtWH6dNn
         UxnXe7SaQzjDHPxNzBXq4JsFZYpEjrE16sjk6NGGC8Is6hfmFCSK47GbwB8HZ6t8rws4
         Ha8KsbP028+rTQOBZ2KniiSLra0djplC5wft1t6KB4WLuKyNOlrW8pNHUARaCXbB4Rc+
         CyJ7B6Tkpkz8qftv2P6V6zylwHpt+CNibecuGtGPqV9G1lx66HNoU84Z9WwnQI9oG42z
         bdHw==
X-Forwarded-Encrypted: i=1; AJvYcCUXkmrsVUcATpBMfPx91ErMNTZf7fhizkjHfPvK3q3C/eb//Q1LIxaCkuXsl+QjGU9NFkt/s0E7hoow09IZ6cfTEropriLo
X-Gm-Message-State: AOJu0Yygb2PtCvFjz3d4dS252iY1ctZKV4MLrqq5fRjFlfyUSxzElw22
	nJMuszHYjPH6Yo9aFeqchwCwb8ahpE5r04bnUDOoD53OMT8wWonN7yG6Bm7ib46+lKVO8S2Tq6r
	q3kiNM2z+7Y/v5gAULZm7/wLquTjY9sFC2ukt8Q==
X-Google-Smtp-Source: AGHT+IGAtdXdST6K51Zvoue30IMgnK4/Wt03pE8GFDNYlsYawZ5xolxNSDZoRJBV+8UiwK2EF4BGkqkIbFp1NMLPoYE=
X-Received: by 2002:ac2:4910:0:b0:519:a55:7ee7 with SMTP id
 n16-20020ac24910000000b005190a557ee7mr1714870lfi.26.1713223842176; Mon, 15
 Apr 2024 16:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414195213.106209-1-yick.xie@gmail.com> <661d3583a289e_c0c8294c1@willemb.c.googlers.com.notmuch>
In-Reply-To: <661d3583a289e_c0c8294c1@willemb.c.googlers.com.notmuch>
From: Yick Xie <yick.xie@gmail.com>
Date: Tue, 16 Apr 2024 07:30:30 +0800
Message-ID: <CADaRJKtvGf_+aCx00KpJqz3gerBCWKvg+=PxcsTPSbLEhAwg8Q@mail.gmail.com>
Subject: Re: [PATCH net] udp: don't be set unconnected if only UDP cmsg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: willemb@google.com, netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:11=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yick Xie wrote:
> > If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> > "connected" should not be set to 0. Otherwise it stops
> > the connected socket from using the cached route.
> >
> > Signed-off-by: Yick Xie <yick.xie@gmail.com>
>
> This either needs to target net-next, or have
>
> Fixes: 2e8de8576343 ("udp: add gso segment cmsg")

I should have added that, sorry for the mess.

> I think it can be argued either way. This situation existed from the
> start, and is true for other cmsg that don't affect routing as well.
>
> If the impact of the route lookup is significant, it couls be argued
> to be a performance bug.

With sendmsg(), any smaller gso_size could be picked up dynamically.
Then it depends, "ip_route_output_flow()" could be as expensive as
"ip_make_skb()".

> I steer towards net-next. In which case it would be nice to also
> move the ipc.opt branch and perhaps even exclude other common cmsgs,
> such as SCM_TXTIME and SCM_TIMESTAMPING.

Both are fine. Though could it be better to take an easy backporting at fir=
st?

