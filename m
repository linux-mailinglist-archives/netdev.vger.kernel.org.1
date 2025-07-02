Return-Path: <netdev+bounces-203485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3181CAF60CF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F285F3BD02F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A130114D;
	Wed,  2 Jul 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYIPlbd1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F572F5084
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479712; cv=none; b=Rzr85UY8wjCKUzuhrPVg8nKbpXCJps+xKRQHDngjyuTuwMSsiAhQjn/79yytuUJh9t3b3Jp3ZfdN+K0Ly9vpFE3HlF7m/VZ9tfTuCvJaygDua0PF/DAo1Bg133+hSai3uPBWt9sDKhqm7srLKOKbfnUgzpoEqQcPVDScBajl9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479712; c=relaxed/simple;
	bh=mOL8VJK7aCoh3dLPJKQhpW1pYNccPgnW+Tcrc0D9Qbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+RE+saKpjCCvD3UWxrW/UfGx7zES4yebyf12bQHsF3RDNb5TnAWxAeu7kF4sCXqCZi3L6dD0jQYA1Dp2g7i7DRkf+JW9jNbGXB54dfsPytIgMkNW8Cb6zbHO0WaCvnv5TneyP6vvhMVja4gm+vwgx/Du7iE5DzEj53jPD32Bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYIPlbd1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a52874d593so4030329f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751479708; x=1752084508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOL8VJK7aCoh3dLPJKQhpW1pYNccPgnW+Tcrc0D9Qbk=;
        b=FYIPlbd1oqDV27yN9DR9a3e+tOdee/fivSjEEZh91UW6L+WhhzE9sH/19WpSELMmDF
         /gxFLHVj2EpnIBktnw8Xcd0zrm9lfFg01q49ObIFHr1FDbtiJk12yGSro2knMH/4DzzD
         NBFGVxm6VE+/0v4QPsJv0Kx16vzMQHF1AeciqSj+TKci/plAACMtvBiQfrvsAHjMJsr5
         egaknbUCZiFt/HgWVU0l4g0KaU9417oT6dbMTaO9htjx7YdVvWtC4j0MK71Pkq5zzTsw
         tjKR7f8vwG8IGduwUOai0sZ3LgfaWXyObiKJ7Su0eTOEX4EH9W/IGPhYUelL2RZ9AoRA
         yjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751479708; x=1752084508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOL8VJK7aCoh3dLPJKQhpW1pYNccPgnW+Tcrc0D9Qbk=;
        b=pH9ATtYJ94SCk2vK2aucxB9qZcoP0d/EgI4k5PALv62bXCM715yrKv2mNy+GNafR5t
         x4SVEzvSxcl04UoGfCcb7sZdoHGwzQiDURpQaddsaJ/zwJNfBI/CPB5Jo1XddZ1DVdlf
         dAHc0qLFInDEd5ulHPpzsEYfVSgz01zUaPvh/bn+hQggZzAf9deov6TB6qzGiZPyOyuK
         zfyeft4bnWxh0gjavBqWycPngCQjshkjQrdxrGUnvUl4weFlm+c4GXRhfHaxJp25nzC1
         9dTopjX94PuENhw1BVp8qypC3w81DDMOWG+UOCWOaciOzByIQpA06/glRanUK8EN4eJC
         WaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRkP0a4afvXrJZYmSzosz+AIvW15OZTmJar1zCWU4rQpFarzqljCxz77XZj7cK9m402mVCLQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5lLjCb/dXmVsUw8pCtalR8xNhef6jaiw+0mHH5cj/l76vPzO
	kC15vocGlt3QTknvaNDb4QphKqIFNwY4hOshCa19B2fN6jDmqTdyIMcQIqOzdmIuoORYI1PNn7m
	6GWIPnAuVd+pOrcBu06GjYMFuMHxa3yA=
X-Gm-Gg: ASbGncv4dNaW6LS2mANZ1JnOptxoq5PeyjUIFo/QekCB4XDjE8lVoJuJmyNBo/Jf139
	RNfnY7nL7LJeJj3OrbP+5ngWldduMAn4Xwmqv6D6/O3wS4jxh2RPo1h5YxlHrrcAcjmoX/FoRcX
	yikNIa5hBzp10TtdVIT0YVShCjF0O//CNDQ0VHvpQyJdrjaFlRvWKSAu0MsDbryrbkNd9EWtCS8
	Os1
X-Google-Smtp-Source: AGHT+IE+2IgqQJv8art+Mjfl13ZGivZRjcett06G+THRkpFsWKyTuRbJLxOCaF7tjuzR+LM7ikVqHGRlvyffUHTtvTk=
X-Received: by 2002:adf:9dcc:0:b0:3a4:de02:208 with SMTP id
 ffacd0b85a97d-3b32c1975f9mr152894f8f.25.1751479708389; Wed, 02 Jul 2025
 11:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk> <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home> <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
In-Reply-To: <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 2 Jul 2025 11:07:52 -0700
X-Gm-Features: Ac12FXy9Ds-SseIIJ_mfVw2QeVaYthtuqHgFEKGmMZmJ3gmZOlowl76LisUNmGQ
Message-ID: <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add phylink_sfp_select_interface_speed()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:37=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 02, 2025 at 03:14:26PM +0200, Maxime Chevallier wrote:
> > On Wed, 02 Jul 2025 10:44:34 +0100
> > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> >
> > > Add phylink_sfp_select_interface_speed() which attempts to select the
> > > SFP interface based on the ethtool speed when autoneg is turned off.
> > > This allows users to turn off autoneg for SFPs that support multiple
> > > interface modes, and have an appropriate interface mode selected.
> > >
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >
> > I don't have any hardware to perform relevant tests on this :(
>
> Me neither, I should've said. I'd like to see a t-b from
> Alexander Duyck who originally had the problem before this is
> merged.

It will probably be several days before I can get around to testing it
since I am slammed with meetings most of the next two days, then have
a holiday weekend coming up. I will need to rebase the patches I had
that add support for SFF-8636 and the QSFP support for fbnic before I
can get to testing it. As such you can probably look at having this
pulled in and I will try to get it tested next week.

To add a bit of complexity to all this I am looking at reworking the
fbnic driver to probably add a phydev or some type of c45 swphy to
handle the PMA/PMD (serdes PHY) and AN which is mostly handled by the
firmware which provides the advertised link config. The main reason
for doing this is that the PMD has a 4 second training window that the
firmware kicks in after the link comes up, and I need to essentially
do an "&=3D" on the link state to keep the PCS from reporting the link
up while training is causing the link to flap.

