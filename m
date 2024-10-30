Return-Path: <netdev+bounces-140246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A18E9B5A24
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 03:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F901F23A4B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8C192D7C;
	Wed, 30 Oct 2024 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GbivCf2N"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C094437
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257109; cv=none; b=qFvGBevaFQcUbGCrAWRZ73VeTfHiMfs7I3pCZCqKG/j1bR1nM7txpor3D3drE1NASUkP3dpFx7mg/YxoRaET3YAtTvlf7KlBPGp2MuSjcmt7AgrVyvFaRk1Kgn95bv4cGTi5MB1j0TT5/LbFJTi0UhKNYWaK1O0QyzW5rmo4aRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257109; c=relaxed/simple;
	bh=HGHKlL6Q2f5MA/XYDDGdtdAsn7WtWzDu8H3/5Jngln8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRabwmlVuBqhCLqktaSPpQzpPWlmkdiqttdjGnWisHT4FglPMKuZkVWX8PuNlv61VU8iJ+SC2h5zmvi1mi6SfHNGENiQe/LNkiaiGNq+OypMUO33Hg7B6keYNntEQzujWKACgb3uoZYwPNhsWp7EelV9rcWac1jrUS+U7eQValA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GbivCf2N; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730257103;
	bh=1zRzrcVJtQQWhqSWjGI4z6tKLCqaqDtMkAdLFY982aQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GbivCf2NIw7IZQ/EezHko727aupfqDvJ26eaqCMyiDhOJsrKqIrdGpWuXHQxVXRSZ
	 ihvJkuLlqAmaIA9cEU4NywfZS63YufNFQQpBqiqZ1M5FHwseKNygPM0H/1vxIe/2+k
	 2yx+VYsntf2jZOoTxS7NVx165P0OHP7DNat5jT4yarHhIlWbq6GvDrGxf5OyK+BMI5
	 ca0JBtj+jGGGrJnFoDZJzdUG0q3X+h2jEvlBJzs0zsOwiSalE6/lojbjEetWrYHRRO
	 dm0StbdYuTALOC/yRSAgOA0d/qn3OP4udYwe/HfhL35lBPkksypC5FiU03ooO3N9d0
	 9ltKn06/sna3w==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C55716A49D;
	Wed, 30 Oct 2024 10:58:21 +0800 (AWST)
Message-ID: <040df8130f6dffc4c4e519dc9241e1c35ed819ca.camel@codeconstruct.com.au>
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after
 free on unregister when using NCSI
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
 <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org, Samuel Mendoza-Jonas
 <sam@mendozajonas.com>
Date: Wed, 30 Oct 2024 10:58:21 +0800
In-Reply-To: <198a796d5855759ca8561590d848c52028378971.camel@codeconstruct.com.au>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
	 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
	 <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
	 <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
	 <20241029153619.1743f07e@kernel.org>
	 <198a796d5855759ca8561590d848c52028378971.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

[+Sam, as ncsi maintainer]

> So, this worth a try with the _remove sequence reordered with respect
> to the ncsi device. I'll work on a replacement patch to see if that
> can be done without other fallout, and will send a follow-up soon.

OK, not so simple. ftgmac100_probe does a:
 =20
    ncsi_register_dev()
      -> dev_add_pack()
    register_netdev()

- where ptype.dev is the ftgmac netdev.

So we'd want to restructure the _remove to do:

    unregister_netdev()
    ncsi_unregister_dev()
     -> dev_remove_pack()

However, we (sensibly) can't do the unregister_netdev() with a
packet-type handler still in place.

Sam: would it make sense to move the dev_add_pack() / dev_remove_pack()
to the ncsi layer's ncsi_start_dev() / ncsi_stop_dev() ? The channel
monitor is disabled on stop, so we shouldn't expect to receive any
further NCSI ethertype packets.

Cheers,


Jeremy

