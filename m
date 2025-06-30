Return-Path: <netdev+bounces-202657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CBFAEE85E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7233BC6EC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AB230BE4;
	Mon, 30 Jun 2025 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuRGAXsE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09nzbnvn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5219994F;
	Mon, 30 Jun 2025 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315921; cv=none; b=Nt+3Hd18BoEvTVI/+/ncW2goI3FPFRoKdEdxL/AQrq9KJAlIkMMUQxQbCJH2stAvDRzcfmwr5TqIsxmc5UrEXvxlj90VV7558dObFHkBZEifbnWPkoKArQyBqEHbZCPq8DRmOG3ZEma4CFJqQSibxWaHoAPxLETl0hLnrjK893Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315921; c=relaxed/simple;
	bh=fOxXH3A6blMvDy2s2pIYQv4JDPRPh7R95g+FPtGs0h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEm5sUqudGYXhxeq/brpfYZ6gokndW7xIp3KXCP9CeTBlVsFJdFZXKTbvc++Os7R2WeRxZoOGE6bppOOUCoUtiTV3ungMphptDzc9Et5aowCe4US1BJP5Y/0q9NwGPgw9TtyxD+/56u04TuPc0aENj7eE6gKqHSSt1Cu+2ThAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuRGAXsE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09nzbnvn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751315917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4GeBpcUee9gwkFRkuHm5p3UqvxHI9R1GfIb27a0oRRk=;
	b=yuRGAXsEWdq6gwj1UbfZ+YNh9dNk3b0kx7YSMHouZfLW2lN/Tm208KVUZ4F8H9qLKN7+Sg
	xItQf+BwLiI9iCaycTM8FQKTRQKGUUA1y3MA0AIiDu3E0sAO1M/fhMyz8Dvc4+d5v7gHZr
	2bdxhWqUq1jvc2rtoSpT4+b5HX2Gf2uOofirsFOaqfGPVwWIwiwoJFtqC301MFT2zMsWfu
	XXX8bMuMJ5Zu+DsilZCGDckslHVrffMDOirA8dlJ0fhD+LkqayUwB2XeL65DnWkfIwnFT+
	iRGKaVp4HebDZyG5c9Dl2Plm2GeVqpL1kxzJkttACc5TDdTTE8V7Nfa+G61gbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751315917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4GeBpcUee9gwkFRkuHm5p3UqvxHI9R1GfIb27a0oRRk=;
	b=09nzbnvnn2GkeZDg4N3inwmMfbU/zJNpHHtG4Ao2FI5j6YIQV8WOSFcR4M6aGK0Q2bQEFp
	PuWwLiiSxw0x3MCQ==
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: dsa: hellcreek: Constify struct devlink_region_ops
 and struct hellcreek_fdb_entry
In-Reply-To: <2f7e8dc30db18bade94999ac7ce79f333342e979.1751231174.git.christophe.jaillet@wanadoo.fr>
References: <2f7e8dc30db18bade94999ac7ce79f333342e979.1751231174.git.christophe.jaillet@wanadoo.fr>
Date: Mon, 30 Jun 2025 22:38:35 +0200
Message-ID: <8734bhyng4.fsf@kurt.kurt.home>
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

On Sun Jun 29 2025, Christophe JAILLET wrote:
> 'struct devlink_region_ops' and 'struct hellcreek_fdb_entry' are not
> modified in this driver.
>
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   55320	  19216	    320	  74856	  12468	drivers/net/dsa/hirschmann/hellcreek.o
>
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   55960	  18576	    320	  74856	  12468	drivers/net/dsa/hirschmann/hellcreek.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmhi9csTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguoTD/9B1gWQu2Elvdw+zn3AwcoMPsSuUMt4
ne/jJ86JA5jtLFXw90YTVbPM0b9Ghu8pLh74TcBu3eQIXLkZTPKVEkJ1f3cQOuT6
HCVCHQrCZc//Sno7jfV2GUK9ZTAsvNLSkfmQmhgSOGJSCN0baNRvebnEYi0Ad7A9
kimkAQrc5m35ur9pVdX0cmdFC949Lv3IIPRsmrn1wHbCsA7I+K7E+/1le/2TTxRA
63i1AMCce3tApoA79VRkqjaX5e+n94wa62Rj3OE/kl+5GOBMmlzXebbmOIPAgp7i
F/NPu99Gkpf+zRuPsBOco0vBJEJqSGfzBGomc3wRwX56HH5KG7ULHVblACFlpuQm
gBf0xZgPaHaywFZNbbtvktW5rvoQ1Ira5KzmfEcK82X+3Sp9/LueaIe2B0U4swVu
Ze/+/UHQqqjKrlQhmKoEL+8DFkgufaQi4fO2GpN6UOamNqAjMSXSyK0B/WsySiFC
9093s5xAU1ggeaL4o9cFump65hOHWh47xf8CxHNrgfYmeFA8KjjgHF0YfT0sHpZV
9lkidMSm2kaX8dFRQRKE59uQagzkfLl1oRIlSwOlwQ9EB4bMVZfQkVBIXvTqETSz
zhEIsHkubEeU/jgxArbIrtfTnEULG87BHw1ANcskvSb08p8Ka1mtByMwwJjHjYQ0
MIplmVZu4fyVLQ==
=0bWV
-----END PGP SIGNATURE-----
--=-=-=--

