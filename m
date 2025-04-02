Return-Path: <netdev+bounces-178826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB4AA7910D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10631719CE
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2023643E;
	Wed,  2 Apr 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/84A9//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609D23A57F
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603669; cv=none; b=bIp0GEVuqDoh955ROD+9L0evA5bLC21SSipzhPFBHXYG12Uaqv6J+SiyqdSrxmB0Vxvj6p9ruP5DkqoItrLBRa/Nc4ZRsklU5oCtb18GykTqE4hXqFWrWpxEX0oYVOAfa59UbHf5n/wIxz6fspfyQ37D8/9HY/N1rO3Odtq9K2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603669; c=relaxed/simple;
	bh=tj84o11HB1bARzcKYoa1u24KxvhDhUh0K6r1VO/bIJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ehigtG2Ww2GZ8NAJi3d6gUHYigwaswfWT4B7w3fkAP5zchV+1R/kaF85Pv9vMNHTxQjd3pfC4kkPNCutddRbgwULlQ0Ov3RcPJu7OPYt9M8AIcBZ1QD82rZy0VclMm3XaHIJtJ3CV8zKvi3GyIUhxkXFo4pxIqVW6WF378upZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/84A9//; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56f60so161236b3a.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743603667; x=1744208467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAx4z//z5vHeT5QPgxg9GIX6P1URKoCV8aHv69JGa00=;
        b=S/84A9//LwvElCtObijy519x+BDHMAeH+VxrNrDNkDy35MwhErBmXo05oSDDHUXyTZ
         hmQnxDPTgojmM3beW+DnT9OBdtGltgZjYm66C6pTQfMSETu2Ross/qErar0mQGi5gH9f
         +Dr2XfegNUgfLlAObV0EKTuix+20DIW8ICB14eNoXlQoL2B/TYGieYqfu87vpiioFla3
         7XC93OwiZKos8WD9xuaePcs2YdNLrNZ2KPA4/xrqnBzj45BXb8LFEEuQggS1SDEPdayT
         5jCYiP5c+2P1RLSH0/g3T+pVQ+HNKquljt5mxqUSJObZUCBZ6qbv7fnthFgCz358tmYG
         K9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603667; x=1744208467;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAx4z//z5vHeT5QPgxg9GIX6P1URKoCV8aHv69JGa00=;
        b=i+b7iI+06nHjvCVjfEMMnxXV0Z75fBhOdqo2rfD+xog31bLL1DEMqQVZW5eVbMKKNc
         /0XD0TcKj44eAufseGR5pEay5ziQKWNoxSyemOEa8G90Bdym0dSgt8eyEw10z5BbZckz
         FytS+QTXwyZNamH2cDbTIVJvCgjqnFTAv9n/0N8vpwnHUz91dc1b5GK8GlcRSreL93rl
         e8VRjSHcPT9u+UdOwNwY+k/wGlPhofbOeO4mlDg600rE46D1NdcS/wSsxex2hpq4lcUm
         Ps0X4Fmn0yZSGqn/iUwrYmfspHZapSQw6vXIiFKF7QjkCSbBe+eWENLQQpWD/qBsE20N
         6LPw==
X-Gm-Message-State: AOJu0YwO4oAgFn3LQ894zemRoPcecHTLHbNy/h63vRknucyFgyuQCOQh
	W5Cglw8ZZ+YFJzpu2uOiKdn0JPHoKQBHZue9EqolKN9PZmRCMDe5
X-Gm-Gg: ASbGnctpcLj5pViKVDFJrcBSe7BJgC5/aozRKDxt70BEOCkXUj4hWOIaEL8LXDotsem
	ZQxuekF/vDiwWudKic689bSibyUj4/WspKyq7wFDlQMtOB9vmlVy8uuVZTMSB/3gzytEdoXUIfp
	V7P+vLGkh2pifPV+n4tmYxGu/jY8olYFdXFDfxXnISKRrsUuB3Dwo27c9b/pRGjCDMab8+HyL2O
	lr/8dALo2h+TZQGH0n2Ma+whUt+8ncfXR7JJa9zjNE2YuENF4oElTLrIOpQwvFaj4qIhqAdW0Tc
	htftbUbf52dPVeBQqI902XL3jR0+Gkk7HASy6chhQMF3yC3VFSRW6Ko+VIXt7z28QsrQLjHvWFg
	qE6LJd5AdCp4q7j/CxZh/MG0l
X-Google-Smtp-Source: AGHT+IEy/Bf/LOmaRNFgX9H7akWtxVbKDyjAOCMmGhEBLmqxQI9qb2HDxx7NogRsybSSAD/1sIDkPQ==
X-Received: by 2002:a05:6a20:9f05:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-2009f7e6829mr28324243637.35.1743603667061;
        Wed, 02 Apr 2025 07:21:07 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-af93b69f6f2sm8392579a12.30.2025.04.02.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:21:06 -0700 (PDT)
Message-ID: <de9d0233962ebd37c413997b47f3c715731cfffd.camel@gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch, 
 hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Date: Wed, 02 Apr 2025 07:21:05 -0700
In-Reply-To: <20250402090040.3a8b0ad4@fedora.home>
References: 
	<174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
	 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
	 <20250402090040.3a8b0ad4@fedora.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-02 at 09:00 +0200, Maxime Chevallier wrote:
> Hi Alexander,
>=20
> On Tue, 01 Apr 2025 14:30:06 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>=20
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >=20
> > The blamed commit introduced an issue where it was limiting the link
> > configuration so that we couldn't use fixed-link mode for any settings
> > other than twisted pair modes 10G or less. As a result this was causing=
 the
> > driver to lose any advertised/lp_advertised/supported modes when setup =
as a
> > fixed link.
> >=20
> > To correct this we can add a check to identify if the user is in fact
> > enabling a TP mode and then apply the mask to select only 1 of each spe=
ed
> > for twisted pair instead of applying this before we know the number of =
bits
> > set.
>=20
> The commit title should be :
>=20
> 	net: phylink: ...
>=20
> > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link =
configuration")
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>=20
> With that,
>=20
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>=20
> Maxime

If needed I can resubmit. I had realized it when I went to send the
cover letter and edited it in another terminal. I completely overlooked
that a change like that would have changed the commit ID so it stuck to
the original.

Thanks,

- Alex

