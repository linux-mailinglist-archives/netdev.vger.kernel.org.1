Return-Path: <netdev+bounces-97381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2B8CB2D9
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984EAB2243E
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05F148841;
	Tue, 21 May 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b="ryOlEuRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ycharbi.fr (mail.ycharbi.fr [45.83.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947E14F9E8
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312007; cv=none; b=ppMhhFBX0XSQNRk7Tis1uJMAd3S0vazp7UjSCbX3xiiL78Rg7ArIIut/n4H3ROD23FKFom8ke0wqmjjhvavZD+mQtOoDTx5JgQwwFCGzZ3LcfY2HthPEtwj3w4iL8/kwEhcGwfxVTfTt/cOgHrkI3JzOC/nGj0tVlQJ7a7tqEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312007; c=relaxed/simple;
	bh=GxYwjhYfLPu6cGTTTTRlSgBOtxHWiF6wLK6z0gKOHdE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Cm4RoPkg9Tx/I5x4W1y9CORjKMk1WctzEP6hVeHwUK6H0OEAIAOKrGXNmzE/WKzbU6Ny0Uy1lwCWzUY/tCpBryWlMzE7sLix5VmYNW/6gUGlmKD3H6nBt9HbihyQpaAfefrpLyUEAD715NX/CqMVlrvTY6xDcTEbzPaqoibNyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr; spf=pass smtp.mailfrom=ycharbi.fr; dkim=pass (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b=ryOlEuRk; arc=none smtp.client-ip=45.83.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ycharbi.fr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ycharbi.fr; s=mail;
	t=1716311534; bh=GxYwjhYfLPu6cGTTTTRlSgBOtxHWiF6wLK6z0gKOHdE=;
	h=Date:List-Unsubscribe:From:Subject:To:Cc:In-Reply-To:References:
	 From;
	b=ryOlEuRkcGSTae4UZiWNNZL3orksQpXalCRrJRsWxAm56SqTVrUORMet5aAuJNBzN
	 NZoH+ziKtbv2f5cxnkivXLqt4mPqyCuOxEeTci25nfKTWOeUKDwaNzyqKc+CceEL5u
	 Zwmo7ebd5keQ1bBI1Y8q2ukLHF3BH9XZWkWU7g2U0IXEfWaPLcpv/EmPRI0jtSWJeY
	 btV8vUonV+tXLaMmAYvosLC8Y4EutV7qDcMMFKP0Lfi0JJ9F7ZkR0Dzov9moAn1kBx
	 Wbr/XHnAIi773Cbw851wu3wk6GrUGOSvKWCbd5UTxg53+GdsvyF4evI7QLO5NiSGDA
	 pcP6bu01Dfk/2aswuRwQnHKWB4pCR9+VRYAiPNRoNjILDZVr/eIYVZvRwBpPZYUB8J
	 4w1yKSw1amwGJ/+2tEknl33Iwq4vrCpvGzlo1qzSrnortU27KFcLAvt/K2TzQsx8i9
	 gyDrDsbznH4Dwfm007pN3ZdODnJJiLG7w4J6oNIhDbzGD14ZrKntooxcdkmRYabK69
	 Y34TZCn/i3MY7zQKz46TstOvX4kz/onVTm4zHsiVrPWvFN6bLr3Dc8H8E6jKCPOJsx
	 PrLRc+Wt5/5oUS/0quxPhtU/m1QkCkLiLXZ5Cq+tgZCdQEsCtKbvlLNcwsij5quJTa
	 97KRnFCPHwkGHJU5BLWhsGqs=
Date: Tue, 21 May 2024 17:12:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: kernel.org-fo5k2w@ycharbi.fr
Message-ID: <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
TLS-Required: No
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
To: "Jeff Daly" <jeffd@silicom-usa.com>, "Simon Horman" <horms@kernel.org>,
 "Jacob Keller" <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, kernel.org-fo5k2w@ycharbi.fr
In-Reply-To:
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
References:
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	*      author's domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*       valid
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature

If any of you have the skills to develop a patch that tries to satisfy ev=
eryone, please know that I'm always available for testing on my hardware.=
 If Jeff also has the possibilities, it's not impossible that we could co=
me to a consensus. All we'd have to do would be to test the behavior of o=
ur equipment in the problematic situation.

Isn't there someone at Intel who can contribute their expertise on the un=
derlying technical reasons for the problem (obviously level 1 OSI) in ord=
er to guide us towards a state-of-the-art solution?

Best regards.



21 mai 2024 =C3=A0 18:49 "Jeff Daly" <jeffd@silicom-usa.com> a =C3=A9crit=
:


>=20
>=20>=20
>=20> -----Original Message-----
> >  From: Simon Horman <horms@kernel.org>
> >  Sent: Tuesday, May 21, 2024 12:42 PM
> >  To: Jacob Keller <jacob.e.keller@intel.com>
> >  Cc: netdev@vger.kernel.org; Jeff Daly <jeffd@silicom-usa.com>; kerne=
l.org-
> >  fo5k2w@ycharbi.fr
> >  Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome=
 link
> >  partners for X550 SFI"
> >=20=20
>=20>  Caution: This is an external email. Please take care when clicking=
 links or
> >  opening attachments.
> >=20=20
>=20>=20=20
>=20>  On Mon, May 20, 2024 at 05:21:27PM -0700, Jacob Keller wrote:
> >  This reverts commit 565736048bd5f9888990569993c6b6bfdf6dcb6d.
> >=20
>=20>  According to the commit, it implements a manual AN-37 for some
> >  "troublesome" Juniper MX5 switches. This appears to be a workaround
> >  for a particular switch.
> >=20
>=20>  It has been reported that this causes a severe breakage for other
> >  switches, including a Cisco 3560CX-12PD-S.
> >=20
>=20>  The code appears to be a workaround for a specific switch which fa=
ils
> >  to link in SFI mode. It expects to see AN-37 auto negotiation in ord=
er
> >  to link. The Cisco switch is not expecting AN-37 auto negotiation.
> >  When the device starts the manual AN-37, the Cisco switch decides th=
at
> >  the port is confused and stops attempting to link with it. This
> >  persists until a power cycle. A simple driver unload and reload does
> >  not resolve the issue, even if loading with a version of the driver =
which lacks
> >  this workaround.
> >=20
>=20>  The authors of the workaround commit have not responded with
> >  clarifications, and the result of the workaround is complete failure
> >  to connect with other switches.
> >=20
>=20>  This appears to be a case where the driver can either "correctly" =
link
> >  with the Juniper MX5 switch, at the cost of bricking the link with t=
he
> >  Cisco switch, or it can behave properly for the Cisco switch, but fa=
il
> >  to link with the Junipir MX5 switch. I do not know enough about the
> >  standards involved to clearly determine whether either switch is at
> >  fault or behaving incorrectly. Nor do I know whether there exists so=
me
> >  alternative fix which corrects behavior with both switches.
> >=20
>=20>  Revert the workaround for the Juniper switch.
> >=20
>=20>  Fixes: 565736048bd5 ("ixgbe: Manual AN-37 for troublesome link
> >  partners for X550 SFI")
> >  Link:
> >  https://lore.kernel.org/netdev/cbe874db-9ac9-42b8-afa0-88ea910e1e99@=
in
> >  tel.com/T/
> >  Link:
> >  https://forum.proxmox.com/threads/intel-x553-sfp-ixgbe-no-go-on-pve8=
.1
> >  35129/#post-612291
> >  Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >  Cc: Jeff Daly <jeffd@silicom-usa.com>
> >  Cc: kernel.org-fo5k2w@ycharbi.fr
> >=20=20
>=20>  One of those awkward situations where the only known (in this case=
 to Jacob
> >  and me) resolution to a regression is itself a regression (for a dif=
ferent setup).
> >=20=20
>=20>  I think that in these kind of situations it's best to go back to h=
ow things were.
> >=20=20
>=20>  Reviewed-by: Simon Horman <horms@kernel.org>
> >=20
>=20
> In principle, I don't disagree..... However, our customer was very sens=
itive to having any patches/workarounds needed for their configuration be=
 part of the upstream. Aside from maintaining our own patchset (or figuri=
ng out whether there's a patch that works for everyone) is there a better=
 solution?
>

