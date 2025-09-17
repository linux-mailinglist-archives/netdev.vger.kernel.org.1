Return-Path: <netdev+bounces-224122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77732B80FDF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B806318871F2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77012F9996;
	Wed, 17 Sep 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLaotlWD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317634BA29
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126528; cv=none; b=asSuwV+5AFrxYtJQXs2R26OORI6OIUquPtavKCmI4NJpdtHxQ+/UvFsu6cyWQBG3cWV+g82y98orpI5pgcW+Er2j4yvm4WodyK+7MF13ky/oCVA/LOg6R4xNNpDeZ/N7iULFQLH2ft8fYqkLGCO72QXoa4Xv+VuJ34141LUmtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126528; c=relaxed/simple;
	bh=8WYWD+Yg3r5DNPBLtc+iIfIV8PKCZAmtTgmqbUSnjcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp0Mo4MoF8+Jy+TlylVo0k3DzmyLmdpmdffFmc0wJe40+B0yoUDx44r8wBfhiJ6KMRfaarL0lSF9KMccqjurR9s+PI837Vp2qt8jlutIydSkP93i0wTHHoeshXc57CE1VA+9KydPAhO+vH2VpMbeYGPJBOUPHEb4LyvZJONu+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLaotlWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49763C116D0
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758126528;
	bh=8WYWD+Yg3r5DNPBLtc+iIfIV8PKCZAmtTgmqbUSnjcw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nLaotlWDzcMTfulQNPk3qQwpCoGdwW9Kcqa5cYlubED+oDPVCoj0ub+tq7QnX8XHc
	 Y1NfN2TiQphOkNi7+H9rT+5hbipIwghPNVqKexaaeAURhRdjhT/5rq1VCAIK2kDuS4
	 zlTbPQzdha+c/T8TkRDx6Kz/Op92ojdw9W5ZLOSugg+FK5l6X+E20U96G0jTl+bfMx
	 V0n6AsJsRDWwMJNn32OSP0DlDARr3uOIf9vxPBOfSS1cO4o/XTZimCwgIKbNLE7yJ7
	 AT+GenebK92wJErPQ89tXCyhNQwGdW0xDkkd4G7N3qsf1qYUZwjxgkr2cx5k4wuCtU
	 UKS1Xq0+hjztw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3602003f5dcso248491fa.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:28:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVTAy4ncjaen+dJplXS9UA+sn2yvPEl8tjJ8CXFA1tCY4eVMhyHr1cuwMXQ3ExnL/Q/kFObzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjrH80+huaNO6xpTMOUt62HCVhiHcL5igF+I3KWTEJqg5G+01
	2cIxTDHkTcO00wqJx4zBWJFOD3EWQiKErk9M9CXxZzanBB80az0hrLKWq9J8LvDmWwqmstPMOaV
	7lpIWJ9rN+emAcHHqc4wqZu2unyZFe6c=
X-Google-Smtp-Source: AGHT+IHoBsplIvCjqYj/yd32eJ5y7UncFKdYSr9f2zWqIlD/MP5kkZiUcMymkpPWIbDco8wmroHbHHYIHkrfiSTkdT8=
X-Received: by 2002:a05:651c:31ca:10b0:336:e22d:804a with SMTP id
 38308e7fff4ca-3617d39f44cmr216041fa.17.1758126526406; Wed, 17 Sep 2025
 09:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913101349.3932677-3-wens@kernel.org> <20250917070020.728420-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250917070020.728420-1-amadeus@jmu.edu.cn>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 18 Sep 2025 00:28:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v64E+CEjnGmnnSyGhkFm=qHrpMeR+sLv_54qkmnKc1AvdQ@mail.gmail.com>
X-Gm-Features: AS18NWCQ3OVkCviedj6oOCUdjxysf8UgGXGPw_nPV7UJfZIHedYkcadQwVeRPl4
Message-ID: <CAGb2v64E+CEjnGmnnSyGhkFm=qHrpMeR+sLv_54qkmnKc1AvdQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/6] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andre.przywara@arm.com, andrew+netdev@lunn.ch, conor+dt@kernel.org, 
	davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com, 
	jernej@kernel.org, krzk+dt@kernel.org, kuba@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	robh@kernel.org, samuel@sholland.org, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:00=E2=80=AFPM Chukun Pan <amadeus@jmu.edu.cn> wro=
te:
>
> Hi,
>
> I tested this on Radxa Cubie A5E and there seems to be a small issue:
>
> When VLAN_8021Q is enabled (CONFIG_VLAN_8021Q=3Dy), down the eth1 interfa=
ce:
>
> ~ # ifconfig eth1 down
> [   96.695463] dwmac-sun55i 4510000.ethernet eth1: Timeout accessing MAC_=
VLAN_Tag_Filter
> [   96.703356] dwmac-sun55i 4510000.ethernet eth1: failed to kill vid 008=
1/0
>
> Is this a known issue?

There's a comment above stmmac_vlan_rx_kill_vid:

/* FIXME: This may need RXC to be running, but it may be called with BH
 * disabled, which means we can't call phylink_rx_clk_stop*().
 */

So maybe this is a known issue? Looks like the comment was left by Russell.


ChenYu

