Return-Path: <netdev+bounces-176066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D2A68945
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174433B9F0B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900325178B;
	Wed, 19 Mar 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FkhFvJf0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJNn6Lwp"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF441F4179;
	Wed, 19 Mar 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379587; cv=none; b=nPSZao1hgs94IOvK6L7/LOn60fUfYjitYy4EkohRed8OQ20EXevKgvzoI2Qw1NwUiZg4EeiEFjEhqcqMKUmCQpDQC5jiwUEy/6EdZsupW403RqkPxL71VJ9dmgaEm9s1x91Y6zXJTiKOLYYrIRApVyAWGgH8yxDryVge3gDXNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379587; c=relaxed/simple;
	bh=Hh3CFzpnRkrvrYwIsX7t2UZ7nGTfdesn+azK/Q0iP80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3+De82OsCC/R4BpzBFQVRb5p+lh/KGEjggYNkE5sYJlBQI3+RMyiNOx23FvGy7q87/lry1E1Sl7PMuazgULi3dKef0oaX+5QD5j5e147TDTdDjZeX20aH+lXa4s1FyztzEzcPJQuQ/MSQU4+PCz1G+EWzXJ4YKVFDfFRL+468I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FkhFvJf0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJNn6Lwp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742379583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh3CFzpnRkrvrYwIsX7t2UZ7nGTfdesn+azK/Q0iP80=;
	b=FkhFvJf07CxvmLoYuAMhCx8uq+jrRxXM+E27yceHFUFho4yC84glrX8Eyxd/1Gr2oKJRFe
	SFJ0e+ytQL+/9mAIIFQNLt0eKHop5sniH7t8KKbAHTo5EnaFVC84yInLMF7QKt2GarTeLI
	KhyOuIB4boe7W7KIPCt4+hN9+srXJdgU3pNhlA9sCDzbPY7fbLDsgYLfkwbC/B28xlOBBO
	m0JY/bjympXqVK94uJ2Va6hTB207fGQDZb8PGDQwnwMtf/rU3wFCz7EarLmDj9XEHISnlB
	KoTZiBI4xiNXl4jhJWXiZAsJJZhL9K6htr0VS+XQiOZfVDYaNVe6veeeIIb8iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742379583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh3CFzpnRkrvrYwIsX7t2UZ7nGTfdesn+azK/Q0iP80=;
	b=JJNn6Lwp5ImN5DrNu9vn/EN5tY0mExwVy/nOITMZxlHwbMJ4jCPLph0JlRf2sZn7Hz3urm
	nItPKYwBtMlb1dDQ==
To: Rui Salvaterra <rsalvaterra@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: edumazet@google.com, kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Rui Salvaterra
 <rsalvaterra@gmail.com>
Subject: Re: [PATCH iwl-next] igc: enable HW vlan tag insertion/stripping by
 default
In-Reply-To: <20250313093615.8037-1-rsalvaterra@gmail.com>
References: <20250313093615.8037-1-rsalvaterra@gmail.com>
Date: Wed, 19 Mar 2025 11:19:41 +0100
Message-ID: <87sen9qq4i.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu Mar 13 2025, Rui Salvaterra wrote:
> This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
> iavf, igb and ice). Fixes an out-of-the-box performance issue when running
> OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
> VLAN configurations, as ethtool isn't part of the default packages and sane
> defaults are expected.
>
> In my specific case, with an Intel N100-based machine with four I226-V Ethernet
> controllers, my upload performance increased from under 30 Mb/s to the expected
> ~1 Gb/s.
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Great, thanks a lot.

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmfamj0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguCbD/sFqhOTwB8d1HDdtnVFlTJ4+lXvCQrD
8r3VMR2I8A3OLOxgYx+JJLuOYlRU4ETbHw6FmRexWICMmMgv3xfHsEHnGolUek8D
e4sGPF/clFx74OnUi7X9g+22iW3lTFFd6x3N9g/384PP+NUWwvsGN2B3+l/cRTDB
693NKeYHa9ZggsoBS6HvMy6HhDf+p1QwuNa3aRhTDqiyp3HcEdujSgVZ35j8aXYC
8425Qs/CF/OeNwCXuD4xDqnI+3hIDSq3atRgTyhc9ThKIR2v5vgRAitqQHJUVx7K
o10jiTBP6BwCTdM5JQRrbzXoEx+gdrk7fIP/p7dF6T/xmTrr8PuaA/EUnM/IYopj
zHAuCwwcVesZUVkV3mUjD6NVDZ2JyhuUOVuE0vdtu3QA42lBjU5FVq6BacaAovK4
lH8yEHyB9cnTZoT3qiJsI69oNcTo6pH3ysJvU44y/G3drTzaDe3pxI1VDLGV5jPH
/8fMM8OZ9NO9/UHKC4hePLUmpEE867MmQUGbBdnK6Ck03aLX1Tb/7puUJ1vlNS8U
y+j7h8YXqP0Lb+AvaH325ZTSXlluIxsAR8O+e9RARdgzd+cY/s77w7coYfsED6ST
A7Ewyzc/Era0kHlN7z+hCgYEDqZgqB/b0Pr9axCkl+xFXVPXA8gVgFPfq2n+prO5
ROj5ObBGWJ1EJg==
=GTVq
-----END PGP SIGNATURE-----
--=-=-=--

