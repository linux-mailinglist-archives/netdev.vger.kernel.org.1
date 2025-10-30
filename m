Return-Path: <netdev+bounces-234478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52B5C21433
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7423188DFE1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D892ED869;
	Thu, 30 Oct 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fkHOrJy3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391752ECE98
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842625; cv=none; b=RbE85Ui7jUqnCqVMCqWI0O6m6nv5RaF1Tzd+QNRe5nn88UCAJboaTYyg0dwlvLCzfPkB/KGY1Xn0pnIcrc/5cYwy0kBbqhnp/EJFOOQy7Ct/6VSoqxvn9GfFftEEnn9SFWykfnNx6mkRQPkvinnAQx9kqb4pYpk1bTA4eLAcRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842625; c=relaxed/simple;
	bh=vvqEQ26fVa/fZR9lYkduY+SUXK+XDxA6Iv16Z0haXps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8cejN4EqeEyNVHZxMJU4LbPdC3liZv5x1Vq0Rn5wfstG/rIP4ynPP8JaOHhmcqUFI+92bizA8VIyzNsYWAJANqeMpxjhbFh2NykMbug4aYSxp7+IErgQyKLSjtmn7bAbdDK/v6Q+VcHuLP32YqLEi2eBDY7U5odhdwDK5Wm0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fkHOrJy3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 722184E413FD;
	Thu, 30 Oct 2025 16:43:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F51A60331;
	Thu, 30 Oct 2025 16:43:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 993FF11808C40;
	Thu, 30 Oct 2025 17:43:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761842620; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vvqEQ26fVa/fZR9lYkduY+SUXK+XDxA6Iv16Z0haXps=;
	b=fkHOrJy3jFwDx0odfagf0TEuyiyi8HYGybDjSAQ1GLjVW3zrU67CdbhGbU9aNMbmAlZN9A
	VYGobyKQTF0us3LaFQUBKh/zi9Z/KMsAKBEhRdkSXAkuxoZCE2BKbpPaLGqh1gPKqSaa+w
	hpNYOJUIb76ih3ktKNO3KdfhcS28APcI7YcjVaV+kzBfqxoNasTg6LIu/mIWCdSMBWRdpj
	z0u/+00sZZVq5E5T23qkKgD1SxvsWDkcnK9sgeZZ6SvETz6JVjFV69sklFleli4ozC+/OW
	s5f6wokOGEDzRhOSC2HOTwIFdOFgTrME3/H4kfR0p2Mh+Boo/DfZSw72Gk3iog==
Date: Thu, 30 Oct 2025 17:43:38 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michal Kubecek
 <mkubecek@suse.cz>, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251030174338.4a709908@kmaincent-XPS-13-7390>
In-Reply-To: <20251030081423.2bb43db6@kernel.org>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
	<5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
	<ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
	<zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
	<8693b213-2d22-4e47-99bb-5d8ca4f48dd5@linux.dev>
	<20251029153812.10bd6397@kernel.org>
	<20251030153723.7448a18e@kmaincent-XPS-13-7390>
	<20251030081423.2bb43db6@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 30 Oct 2025 08:14:23 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 30 Oct 2025 15:37:23 +0100 Kory Maincent wrote:
> > Jakub, as it is already in uAPI but not used at all, would it be possib=
le to
> > change it or is it already too late? =20
>=20
> We'd need a very strong reason to consider changing it now.

And I don't think we have a strong enough reason here.
So lets keep it as a bitmap then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

