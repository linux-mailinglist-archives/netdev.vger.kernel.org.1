Return-Path: <netdev+bounces-153401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCB59F7D90
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5848016E51C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C821C182;
	Thu, 19 Dec 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="AD1hOwHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8441C64
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620569; cv=none; b=u1ho4on42+r1JFRzZUdm6KuMNGVrMKaf3QxSLtw57IG1PCzjAErgEA5UYlsBOvQ3OG9VElzecJ0NrMVv7aTervd4gbiBGffgSvgdLwDXblrSeSeikoGqPx3tTuPLYGkq+vWgEcC8Yk+87a6flI5g2aLAKAQKCL4u3aKsNVblUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620569; c=relaxed/simple;
	bh=1qLVQrodPfx7G+i0OsOFOTD/ShuC04mAogvTkKQEUjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMJU36zmcekCF6HbicrvZ5KAzBcaJf6eXR8dyoII5ODLmQV0yIDdgd63VOzOg1L4W27E+NU7bE06ywsbYW+XFu+WLlvsGkq3DLKtojZxtYsMmQw4X2BIVE0vP1Idqyal5YfGbNKAJerTylpD98oROSFR3iJtgpsJCRnoRVVRRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=AD1hOwHk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54021daa6cbso827361e87.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734620565; x=1735225365; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwyZWBhVw6ucYwd2ENbyAN57S3Q8k+K1zKoIxG/R15c=;
        b=AD1hOwHkjr3udD025TqqsQjGldNkitGEtBOlK3EplIyhunCPxG+gNMCSDB5RoFXDqX
         dtD+RgwFtwu3tCreqNyJKElMF0t0lmvEwVOn7gY/mz/uBX1qz1DWdyHIhXECj45+Zlpw
         s+oD35iHih+KheergaseIzEDxcWVw0XxsgBwkMC6O6IUHCzNV8Kd3tJ2hCYOmaQBA5XT
         LYlsPzpvXsugMQV+36y8p9E+mJ2WYS3KzLW7avRAoU2N2/bOijpIf5cUYdLg4Umm2Whn
         +ubAdCs5WsrKEhptR+DqiNOJCnoMRHwGHkdbyZkTXLDLNipfVD0WEcH769axKJHPNOdJ
         EcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620565; x=1735225365;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwyZWBhVw6ucYwd2ENbyAN57S3Q8k+K1zKoIxG/R15c=;
        b=kUOcxxAnoZckUzjtwjT8oo/bclFGsX7EUbTgoFTmZO7zwg5bMySqxoSpo/bep2cOcO
         Y9ZvI8XM27PfBA3/VleeZILkcW6ND7/V6rz1nQsTVdeB7LnldWNcE4Ng8bbyuS4oQAbf
         zIbAUi3JMsgVOwItTWKvY9Y+dxCY21RNbwqYX0TIko6p3QxQk5THuJGDaqNA3w8sRTWr
         vzSLPd6AfSma0S81lT6c+ZRmw3imuNNDUuAomw/59ISYMpB5LeIsV7i4YftejC+ppRbn
         dx0Vr2KerPwjyqsGs/e4WJygMasTIv+g4QbxGhK9JFGV1LyRb1FmwJd/+7tx1vAPpTRh
         qHVA==
X-Forwarded-Encrypted: i=1; AJvYcCWfl8Nq1Vud+7i8ADu9puE+iOa1QHRG4S1cdWQt+l7pXo8VEMDjBM7yWZ6ymekIhM3z3TY/Q3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwx8VHXHMm9zFg4qL/30A3/DrVVWci6E/7Ht0eQ3ifazBU0/fS
	Kw8yDTt3+e4xcipzi0rKx7z5bfFN2WgFVD1SoVa7UP6xZjd9S53eoeiOQ1oLymk=
X-Gm-Gg: ASbGncuFj62P0Lu/GDbxpNXTK3g3u2NgpYvGkibXxotSgqIrb//W6F4AyzAdFkTjUZb
	dYbPYq4+UWD67/x0Ekkn4YBk7GutUy+6qd5AxRoMYX91XteitikRr0xEU0kQf09RQg10QTZF89y
	6N3MG2peYoSgEojECAnRllSKTCaEB4HiMLiGAOj0FIkxJrrl5nZn5K7UKLQ4uuEkyh8PvHHHOtM
	CbuCBJEb0tofa3KtPPF55znt0EcRbHzbRxXQaaof9NyTml/OjPCVt6q6VlRgpMcIUD6YXKbjEx2
	eDtAT56Cnck=
X-Google-Smtp-Source: AGHT+IERiCqSvpf3mPyzLutTHbJ4MIlBV9Yg1hI5eobf9kHyh4DjOtPsC+i+1ttdDj1kzv/QSwzIMA==
X-Received: by 2002:a05:6512:31d1:b0:540:1605:ac59 with SMTP id 2adb3069b0e04-541ed8d7207mr2445896e87.3.1734620564885;
        Thu, 19 Dec 2024 07:02:44 -0800 (PST)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f6047sm191597e87.26.2024.12.19.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:02:44 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy
 to user ports on 6393X
In-Reply-To: <20241219145229.2uy3d3pnjqmimq66@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219140541.qmzzheu5ruhjjc63@skbuf> <875xnf91x8.fsf@waldekranz.com>
 <20241219144208.dp7pfbh566htfc4v@skbuf>
 <20241219145229.2uy3d3pnjqmimq66@skbuf>
Date: Thu, 19 Dec 2024 16:02:42 +0100
Message-ID: <8734ij90ml.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, dec 19, 2024 at 16:52, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Dec 19, 2024 at 04:42:08PM +0200, Vladimir Oltean wrote:
>> The other driver with tx_fwd_offload, sja1105,
>
> Correction: I forgot there is one more driver with tx_fwd_offload:
> vsc73xx, but that doesn't properly support link-local traffic yet at all,
> according to the vsc73xx_port_stp_state_set() comment. So we can ignore it.
>
>> is going to drop any
>> packet coming from the host_port which isn't sent through a management
>> route (set up by sja1105_defer_xmit()). So it's more than likely bugged.
>> 
>> We can't fix this from sja1105_xmit() by reordering sja1105_imprecise_xmit()
>> and sja1105_defer_xmit(). It's not just the order of operations in the
>> tagger. It's the fact that the bridge thinks it doesn't need to clone
>> the skb, and it does.
>
> Another correction: we could probably make a best-effort attempt to
> honor skb->offload_fwd_mark in sja1105_mgmt_xmit() by setting mgmt_route.destports
> to the bit mask of all other ports that are in dsa_port_bridge_dev_get(dp).
> But it gets unpleasantly difficult to manage, plus I think we still don't
> get MAC SA learning from these packets.
>
>> So yes, it's probably best to exclude link-local from skb->offload_fwd_mark.
>
> So I'm still of this opinion :) I think the effort to handle the corner
> cases isn't worth it relative to the benefit of offloading the forwarding
> of slow protocols.

Agreed. I will remove this patch in v3 and replace it with a general
patch for the bridge instead. Thanks!

