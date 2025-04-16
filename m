Return-Path: <netdev+bounces-183465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACBAA90BE0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D016A3D9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2521B905;
	Wed, 16 Apr 2025 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dczUkfjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60F1E9B04
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830226; cv=none; b=fwHz3AZYP7KjTpd9x21xFEwaSXhR6ajY9dyMOIJBmOJxRNngwYPeeG/Ppnc5SgV62/C1Rf/rbairIxhQjAmr0AVGD43yyO78ZdMC2faFbpRtB6TqLePJkILEI9pCiNOj9tLCwB+GqMO+EQGavE4we9UmC3kYgxCIneHOlALuWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830226; c=relaxed/simple;
	bh=bTTTtcXzO5uiu4GOSJg26OtAn88djchI6opNf/Rry+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAEuPwzaoPqvwuYqXMu7jemTWb4mZ5vVfn1R341XtqeOPeYOUVBUcYlm3psZfiIDVVVrZ3iU+AuwdXfZbpXy4NIbhsB0dcF0kQZpqyp9RMNJrOfpZXlsHTO+njbKLKuxMzkLHgHtmT/Sc84WL/W0Xq+A2D8huBfT7jgbkbt+E1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dczUkfjS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ac9aea656so7342246f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744830222; x=1745435022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+ejwBKtvA7qcbVjUptozTsapZm5l6incZx6kdbPByg=;
        b=dczUkfjSfN6mM/Lh1wIiwPY2BbxOAT7mLIivAw0yybe4a97phutR29h6P/nLT0Yq5A
         /9wuHV3I1iBYUBrfBB+8phC7N13voGXj9ULhhMP0Pw/oMp2sjzy0eTkzvVlyoAbqaOMD
         I4TqtLk22HUgWxlSNtVHAfKL3oa7GLqdjkjVrVYlSbUSdjdyxBhEZRaUGPmtvonxfIGL
         IqfJ3qFECZ5uJzXSa2zDj0uSOfdNyt2Dyvtl2IoepoKr5Q7jdS7ytwMYBfcy+XCT2E4w
         vGojf3rInw586DE03kKUNrSGCGCdzz2i+3dSWqPVVG6zQbEfvwh52aeylSHS8W4qaMzN
         Y16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744830222; x=1745435022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+ejwBKtvA7qcbVjUptozTsapZm5l6incZx6kdbPByg=;
        b=S+n5FfuRR9qDvlH4VU/T+7T7qM2t0Eh+L26sNi/e43noQWKJtIuAI9tZrDIPc7Hio6
         DEsrKLXnx807m/8tJXha1zpJygJelGvTLCyRrAvCt5tSEFgu6aZK9w5Au2cInTTujREu
         5rBOV5BQiXX3omZbGRP+Nd3GkUWFNR//AJ31SBePUDA2KoOnxAcZm/jtv8xU3vE+H5bG
         rzC4f0B/TULrWtjbZGfwdvdu1oWWMP1v3VJIGaCHZdeH7irm11L/QPu2HfZUi5SRmZJJ
         S0vBlEdj3lodOHvz1MjNU8s1SyP5u8JpzYUIpmZ9qWkz8CRlfHg8r1sxhTNymVgW15A4
         sEbg==
X-Gm-Message-State: AOJu0Yy3WwuaJ9Ms8UXaV+sQRkCSeTfuFOVdqqsN4HSxmrulBkjG/zLc
	kq0j+VPtGON0HQ3xEZnqHmmp+lp41T4uwECrd+daVXDRbxrpSWkadYkiTMD15vy7vo46JBCnXcX
	0AwRRvPLhZ/hgCXrZ3T7+zWji8UE=
X-Gm-Gg: ASbGncs6D07GzK4MKwWbTupRvc6CFyPsAtYzLo+GUxGqWIWTSxRhZUxoZhqe/6jbzaT
	p/67iZumBBesxr1RgsTRbQI0VN23iYvZzM6pIG14xs2xIndcnlCvJcb7B6Dd91FcVo7VoBbRpP4
	VK6zVkE3oxWcIzLOvQHRrO1Z3h+SxhsudhukKJx0hyUcfnVDZMV/qg5is=
X-Google-Smtp-Source: AGHT+IH2OvlICi4vMQWwLulJZw4+Qsly1uMLUTwkxQXFIOtc5zS41o4Y4j+NwG+3QQVC1ocFofqUrk1xkgqY0+1hjTI=
X-Received: by 2002:a5d:5f8d:0:b0:391:13d6:c9f0 with SMTP id
 ffacd0b85a97d-39ee5b9e1bbmr2842706f8f.47.1744830221423; Wed, 16 Apr 2025
 12:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa> <Z__URcfITnra19xy@shell.armlinux.org.uk>
In-Reply-To: <Z__URcfITnra19xy@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 16 Apr 2025 12:03:05 -0700
X-Gm-Features: ATxdqUGGYcVk6-6Dt6CWdUZOIBlyU5JCjTsGhX5B9S6gL-3TR4ZQ4T5wgcMo31I
Message-ID: <CAKgT0UcgZpE4CMDmnR2V2GTz3tyd+atU-mgMqiHesZVXN8F_+g@mail.gmail.com>
Subject: Re: [net-next PATCH 2/2] net: phylink: Fix issues with link balancing
 w/ BMC present
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 9:01=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 16, 2025 at 08:29:00AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > This change is meant to address the fact that there are link imbalances
> > introduced when using phylink on a system with a BMC. Specifically ther=
e
> > are two issues.
> >
> > The first issue is that if we lose link after the first call to
> > phylink_start but before it gets to the phylink_resolve we will end up =
with
> > the phylink interface assuming the link was always down and not calling
> > phylink_link_down resulting in a stuck interface.
>
> That is intentional.
>
> phylink strictly orders .mac_link_down and .mac_link_up, and starts from
> an initial position that the link _will_ be considered to be down. So,
> it is intentional that .mac_link_down will _never_ be called after
> phylink_start().

Well the issue is that with a BMC present the link may be up before we
even start using phylink. So if the link is lost while we are going
through phylink_start we will end up in an in-between state where the
link is physically down, but the MAC is still configured as though the
link is up. This will be problematic as the MAC should essentially be
discarding frames for transmit if the link is down to avoid blocking
internal Tx FIFOs.

Everything for our driver has to be a light touch as bringing down the
BMC link for any reason other than the physical link being lost is
essentially a criteria for failure as the BMC is the most essential
link on the system. So, for example the code I have in the driver for
handling a major config is currently checking in mac_prepare to verify
if we already have link based on the requested interface mode and FEC
settings and if we do the mac_config and pcs_config steps read an
internal state flag and do nothing, then we just go through to
mac_finish where we write the necessary bits to make sure the PCS/PMA
and PMA/PMD connections are enabled which essentially becomes a no-op
if the link is already enabled.

> > The second issue is that when a BMC is present we are currently forcing=
 the
> > link down. This results in us bouncing the link for a fraction of a sec=
ond
> > and that will result in dropped packets for the BMC.
>
> ... but you don't explain how that happens.

It was right there in the patch. It was the lines I removed:
@@ -2596,16 +2600,6 @@ void phylink_resume(struct phylink *pl)
        if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) =
{
                /* Wake-on-Lan enabled, MAC handling */

-               /* Call mac_link_down() so we keep the overall state balanc=
ed.
-                * Do this under the state_mutex lock for consistency. This
-                * will cause a "Link Down" message to be printed during
-                * resume, which is harmless - the true link state will be
-                * printed when we run a resolve.
-                */
-               mutex_lock(&pl->state_mutex);
-               phylink_link_down(pl);
-               mutex_unlock(&pl->state_mutex);
-
                /* Re-apply the link parameters so that all the settings ge=
t
                 * restored to the MAC.
                 */

From a BMC perspective this forcing of the link down even if it is for
a fraction of a second is unacceptable as it can break up ssh sessions
to the BMC, especially if somebody is doing a bunch of configuration
changes on the NIC as it results in dropped frames. When compared to
the firmware based NIC approaches such as Broadcom and Nvidia/Mellanox
it is a huge negative as the BMC link is static with those NICs and
doesn't bounce no matter if the interface is being configured up/down,
the driver proved/removed ect.

The issue, even with your recent patch, is that it will still force
the link down if the link was previously up. That is the piece I need
to avoid to prevent the BMC from losing link. Ideally what I need is
to have a check of the current link state and then sync back up rather
than force the phylink state on the MAC and then clean things up after
the fact.

> > The third issue is just an extra "Link Down" message that is seen when
> > calling phylink_resume. This is addressed by identifying that the link
> > isn't balanced and just not displaying the down message in such a case.
>
> Hmm, this one is an error, but is not as simple as "don't print the
> message" as it results in a violation of the rule I mentioned above.
> We need phylink_suspend() to record the state of the link at that
> point, and avoid calling phylink_link_down() if the link was down
> prior to suspend.

Looking at your fix it doesn't resolve my core issue. All it does is
address the "third issue".

In my case the link is up and needs to stay up when I resume. The fact
that we are forcing the link down causes our BMC to drop connection
which makes it difficult to remotely manage the interface as changes
to the interface such as a simple ifconfig down; ifconfig up are
enough to cause the BMC to drop packets and potentially the ssh
session if we start losing enough of them.

