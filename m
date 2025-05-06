Return-Path: <netdev+bounces-188466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A7AACE5D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0121C280B4
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754301FBCB1;
	Tue,  6 May 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq1F70wR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA232747B;
	Tue,  6 May 2025 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560923; cv=none; b=CAAREvzW/+c6g1wnVQceZ7ww4bGnCuDg2jAXy/HaCt7QGn6nQBe+BzbAUn+hRJXJ56gxPcFoOYhVThgU/eeZrRFswUjtrpCy3Mws8dBS7Lnz7prgyazDju/8nLPqLDcp/FxN7xKFpJCNbzc4g273H3K3dkHg74gOkgc1JcdcggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560923; c=relaxed/simple;
	bh=PkmrdC6iaXS59CiZ1r77gW4+loRhtwiAMbwjBKW6ATY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQo9ahkUPg70WMzdRp2+eaDO9487h+x2UcAb+CPsgjx/SXfqvnOACwtSqCIc/XChozKM9/NcNC1TZmsuK7slwCbe7ERieJT7KZk+84balFOYv6keo4THRBBji3a3vB4/uj2C+1KNE4DghKUHo1Zpt/SJ0OKf8XY9tSV/rJN5o6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq1F70wR; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e740a09eb00so5570919276.0;
        Tue, 06 May 2025 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560921; x=1747165721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkmrdC6iaXS59CiZ1r77gW4+loRhtwiAMbwjBKW6ATY=;
        b=dq1F70wR97o+U5uOvTIZwfsEeAp2yXJfyLfRBUdDRorREk1Stbwl6XkJGJ4njBfuFl
         fKvkEy91jxRMPekfoXrn76I6eZTpdIxyEieqtBf9VoEvloQRVH1fHMRJdPkOxmvIValZ
         LPQGa+NA476W1MTyuEJ40bc32DDuGw8p9HxK8lkQcxnPnsvXwZmp6rfbUTimybdV146+
         14GKsuIuWKGNdLeyZYuHOTVodWqsRgF9Rgl4p6kG8aH5okRRlHVzwwRiCVxixrmhFkqV
         Lad3yJ06OgqVrq1j+Z+lTQEf1keYdporFn/kzRdBLIE7demzEst+JNsHsbgPKfl9ZgcI
         keHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560921; x=1747165721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkmrdC6iaXS59CiZ1r77gW4+loRhtwiAMbwjBKW6ATY=;
        b=vehqwlmiARJOV9/0dMuO9Gcb3uV8HPhNFgwc9CY85ZBG6q+/Ds0drd62LBB2alosB6
         5laAsTruKKO6mRzNgdaZ51LYZZ2NmZgzKPYEYLmM9E6n8rufTdakpdDHKxIy/B/QPN/D
         WZbi0qznN/mMgNo7EauoC/rAarZp02C0Xkmb5Hthm9jv7mXkHf+ZlTgMwOEx2meCRRgC
         sdaZXlKuSlP5ieniZ2qDW1/5mEKDyA7yYqk6KFWcC4PFgPHO7+vr2mEaFP3v/YSDH+dO
         mrnv/0FZTihGXaAnusf8DSwrQmKgp+HvCFCyQKgJB2oqEX2vftuGv9+nXgb+ySW5HDdA
         Pt9g==
X-Forwarded-Encrypted: i=1; AJvYcCUINDdtg0QiZveyM+vcuss72GPFzkzSSiOhwNcLz+CXjiGmTd1m4ZWNBhxrFP+1FJX9/g6NS9Lo3Ub5XA8=@vger.kernel.org, AJvYcCV7RRbYJtzw1XZyK6fxaeOsQJWeeQgCzCuisJ4sLCTpzux0thUHEMnvsK80B9aOQ5+IMuwKn89l@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhk6/MIHw6fPAtS6SZP9WXPCIf0oZ1qIJbuVdFEstB9UJUVXv7
	WRkfADPjX4D5rGr5phU57VEYz53f2j3gTjSsou1KcDb4RmlwJ7AhYKhzVxdpGFdP2bqyETnZKsm
	ZGc1+1h3N0U1N2s8rpGcR2vLmLuo=
X-Gm-Gg: ASbGncszcxhhXARob4bleCUiE677Nj8ZLmfZoi1BPU5YlARPzmHXCvXBQrRRvPMpmjv
	wMGX7hOnc+DbyZWieCqTJwHWZwvAbjg8MikTc66KA21TC3iP912Zo9NxA0u3wbB3BcJ/6wQOoAQ
	/eCqJvy8RyFytFi8wtZFUT0TvWl0/IxY4=
X-Google-Smtp-Source: AGHT+IEtNdkFlAiqJWyGct/2ou3L/7VsJDFoePwlIo4s/IWqJQJLdkhgHIpGnKrcWA07406YgchLzcJU681IsFgj9XA=
X-Received: by 2002:a05:6902:2748:b0:e6d:ecbb:e530 with SMTP id
 3f1490d57ef6-e78811ef1cfmr911593276.27.1746560920773; Tue, 06 May 2025
 12:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com> <CAOiHx=n_f9CXZf_x1Rd36Fm5ELFd03a9vbLe+wUqWajfaSY5jg@mail.gmail.com>
 <20250506134252.y3y2rqjxp44u74m2@skbuf> <CAOiHx=kFhH-fB0b-nHPhEzgs1M_vBnzPZN48ZCzOs8iW7YTJzA@mail.gmail.com>
 <531074c1-f818-4c0a-b8d1-be63ace38d5f@gmail.com>
In-Reply-To: <531074c1-f818-4c0a-b8d1-be63ace38d5f@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 6 May 2025 21:48:29 +0200
X-Gm-Features: ATxdqUE9U3d4PCiupCyS5H_gMKohABoddrma4RtDGUlZi6d8SyA3PVXSyIlooEg
Message-ID: <CAOiHx=kiLgvTBVupJDqZzW1Dfn9RhiWxDfF2ZXiSR8Qk5ea2YQ@mail.gmail.com>
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:03=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.c=
om> wrote:
>
>
>
> On 5/6/2025 4:27 PM, Jonas Gorski wrote:
> > On Tue, May 6, 2025 at 3:42=E2=80=AFPM Vladimir Oltean <olteanv@gmail.c=
om> wrote:
> >>
> >> / unrelated to patches /
> >>
> >> On Wed, Apr 30, 2025 at 10:43:40AM +0200, Jonas Gorski wrote:
> >>>>> I have a fix/workaround for that, but as it is a bit more controver=
sial
> >>>>> and makes use of an unrelated feature, I decided to hold off from t=
hat
> >>>>> and post it later.
> >>>>
> >>>> Can you expand on the fix/workaround you have?
> >>>
> >>> It's setting EAP mode to simplified on standalone ports, where it
> >>> redirects all frames to the CPU port where there is no matching ARL
> >>> entry for that SA and port. That should work on everything semi recen=
t
> >>> (including BCM63XX), and should work regardless of VLAN. It might
> >>> cause more traffic than expected to be sent to the switch, as I'm not
> >>> sure if multicast filtering would still work (not that I'm sure that
> >>> it currently works lol).
> >>>
> >>> At first I moved standalone ports to VID 4095 for untagged traffic,
> >>> but that only fixed the issue for untagged traffic, and you would hav=
e
> >>> had the same issue again when using VLAN uppers. And VLAN uppers have
> >>> the same issue on vlan aware bridges, so the above would be a more
> >>> complete workaround.
> >>
> >> I don't understand the logic, can you explain "you would have had the
> >> same issue again when using VLAN uppers"? The original issue, as you
> >> presented it, is with bridges with vlan_filtering=3D0, and does not ex=
ist
> >> with vlan_filtering=3D1 bridges. In the problematic mode, VLAN uppers =
are
> >> not committed to hardware RX filters. And bridges with mixed
> >> vlan_filtering values are not permitted by dsa_port_can_apply_vlan_fil=
tering().
> >> So I don't see how making VID 4095 be the PVID of just standalone port=
s
> >> (leaving VLAN-unaware bridge ports with a different VID) would not be
> >> sufficient for the presented problem.
> >
> > The issue isn't the vlan filtering, it's the (missing) FDB isolation
> > on the ASIC.
>
> Could not we just use double tagging to overcome that limitation?

Wouldn't that break VLAN filtering on a vlan aware bridge? AFAICT
double tagging mode is global, the VLAN table is then used for
customer (port) assignment, so you can't filter on the inner/802.1Q
tag anymore. Also learning would then essentially become SVL IIUCT.
Also I think there aren't switches that support double tagging, but
don't support EAP. EAP mode might be the easier way. Assuming there
isn't a gotcha I have overlooked.

Jonas

