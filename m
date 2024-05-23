Return-Path: <netdev+bounces-97859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C758CD8AF
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAA31F23019
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27733175A5;
	Thu, 23 May 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b="Tm3+tVLL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ycharbi.fr (mail.ycharbi.fr [45.83.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0D1CF9A
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482965; cv=none; b=JW4BoEXhK0Q8E8DAPRTDATTgvSokqzWMq/fwlqCsh0Zq2ChVKhRE8BMMcS2VuPfHyFOR+sJcymuDWK7J0M/7ItcwUpEsTBQzDGbybC2rmwE1H+3dbmA/7K952CZRlz3Orzf+7xGsK5gTUJ8UuD9df3bLPMfqub3H6TODSqt/p3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482965; c=relaxed/simple;
	bh=+TzbnStEJ6ze4/OIf5A5k49ccZkGTpJY8iKaWjH2D/0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nPtAz87EoPqToCvsgj1rWBC7jdMp606F3WZ9P3x0FuPyXO7p7S86Ql9HUWFRbvIjsr/451HB2hUnWFFxWWpvk+hzFH5PmMYiJ0ncpLuPC39QQGySXUXmEsMLTIfUUbYwxsZ3A8/xgdhOyN9I/d0l8T9VBCBEKE+gpPSJTubWAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr; spf=pass smtp.mailfrom=ycharbi.fr; dkim=pass (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b=Tm3+tVLL; arc=none smtp.client-ip=45.83.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ycharbi.fr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ycharbi.fr; s=mail;
	t=1716482954; bh=+TzbnStEJ6ze4/OIf5A5k49ccZkGTpJY8iKaWjH2D/0=;
	h=Date:List-Unsubscribe:From:Subject:To:Cc:In-Reply-To:References:
	 From;
	b=Tm3+tVLLaCrfUN5vZ52M++xi099zo/avgRvXsaCO2TUmdzEDiL0QdPNIaAaDpAIDC
	 TE8ZN0i3e6cHvz0lGABQcFmwg7rFSDHNtFOcLdiTeYqbfZCJySN+mQKCEDPwRfkt/M
	 8np+NhrdL+vXBwbTBkcVTTwBykkYTAmsJEp6tRcB0gJeOQD3OzYspXjg2LERKB2x2b
	 WmUwhZnGKZdfdJnlqlzB7PTdZ1CoWdPEE/H8Ml5364NRZgeMJAL/ix9i2WHtXitUhh
	 mL8+dz/+jUmR3Dy90SvtyhqtJ3DvIjOC7tcWgyJG2Ual7oT6NaeNiQGmShOVBm3aLv
	 d2P9gnp2EoYTEYKd+HDo4Sx6yGrjH0vkA9eYNIN1gDOT/yJv6Rd82u/RisqQP86p+w
	 Z6UcgvyKaWL7ewiOCcr0lPey6MBNO9OkvCGokphv7+HMs063BVfn5ewy+SK+quzO8X
	 TfGwhhSqhodZC4bUJ5z9vBUdfwgxGFzwlTQX/becaY9QfxiHFsJUsAn4Zk/pGo3jxG
	 Zna+tL8DSGjbSkpQb9BmFDRQSOZJwuk1nYlEV/wny63gNK3m+rkRQqJvFyLOCLqTxw
	 Kb7go/lzgZrOafmHh4QpSb6wY4Vb4mfMC3fsC7IkGNUjG6mfboI6aucn9ivdqS0S2T
	 8pIyc00vlbwwF09r6JdEzoxs=
Date: Thu, 23 May 2024 16:49:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: kernel.org-fo5k2w@ycharbi.fr
Message-ID: <69ac60c954ce47462b177c145622793aa3fbeaeb@ycharbi.fr>
TLS-Required: No
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
To: "Jacob Keller" <jacob.e.keller@intel.com>, kernel.org-fo5k2w@ycharbi.fr,
 "Jeff Daly" <jeffd@silicom-usa.com>, "Simon  Horman" <horms@kernel.org>
Cc: netdev@vger.kernel.org
In-Reply-To: <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
References: <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	*      author's domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*       valid
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature

> It looks like netdev pulled the revert. Given the lack of a full
> understanding of the original fix posted from Jeff, I think this is the
> right decision.

Thank you very much for your investment.
I hope a solution can be found for Jeff.
=20
>=20I did create an internal ticket here to track and try to get a
> reproduction so that some of our link experts can diagnose the issue
> being seen.
>=20
>=20I hope to have news I can report on this soon.

Super. Cela va peut-=C3=AAtre faire remonter d'autres probl=C3=A8mes sous=
-jacent dans l'impl=C3=A9mentation de la norme.

>=20
>=20>=20
>=20> I guess there is the option of some sort of toggle via ethtool/othe=
rwise
> >  to allow selection... But users might try to enable this when link i=
s
> >  faulty and end up hitting the case where once we try the AN-37, the
> >  remote switch refuses to try again until a cycle.
> >=20
>=20
> Given that we have two cases where our current understanding is a need
> for mutually exclusive behavior, we (Intel) would be open to some sort
> of config option, flag, or otherwise toggle to enable the Silicom folks
> without breaking everything else. I don't know what the acceptance for
> such an idea is with the rest of the community.
>=20
>=20I hope that internal reproduction task above may lead to a better
> understanding and possibly a fix that can resolve both cases.
>

> The link is an SFP-10GBase-CX1?

As I understand it, CX1 is the name given to Twinax copper cables such as=
 the one I used in the experiments in this thread. It's therefore a prior=
i the right value to display for this kind of connection (instead of =E2=
=80=9C10000baseT/Full=E2=80=9D).

Thanks again for your hard work in finding a solution. You can always con=
tact me later so that I can carry out tests if you need. The machine is a=
t least available for 1 year for testing purposes.

Best regards,
Yohan.

