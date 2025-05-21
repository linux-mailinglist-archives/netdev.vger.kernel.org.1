Return-Path: <netdev+bounces-192122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F7ABE954
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F351890773
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED519D07B;
	Wed, 21 May 2025 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXEH2XuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256219CC3A
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792306; cv=none; b=UbrFTgzCNvF8Bmr9kcavg3iofXGBbj7vhXa8ygkimQ1Sle3513R7AJLRu7po8AYpg4dMEK+CB+vtHCkPhzZcvtT8DQ/ZVuI7kidd425j3VLSJZG1zzdzgecR8OmwUf2n9uXrMT26g/K2HVwaRmH8qQ9ROn+8p5HLuGojDniUuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792306; c=relaxed/simple;
	bh=r+yGdKeoc6UDIYn+rJLsnyqDxyIUFox89QWLZ8dyQUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBWQj0FvucXjGy18rjSlUjvARG53glXLz1Z83IgucbBMVuAT6khtubarr63KcSopMF7oSw6wc/qQJx6RR3weLzQ4ywY41eFmBUksBnv/ryTdaHQGAYmgReY75ZTpjofn7tIrHJsYHYTHRpBBCMiIkssXfTZXinX+TTekTkUb6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXEH2XuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B94C4CEE9;
	Wed, 21 May 2025 01:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747792306;
	bh=r+yGdKeoc6UDIYn+rJLsnyqDxyIUFox89QWLZ8dyQUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qXEH2XuSymWMyrr7z1l5qDvqVwuJ4zteqNawlxVaTeIfHVyvr2M7fFjjhJ2okVh85
	 KrsidrzpNSU/W4WG8F4gaMxhWYR2bv19Dr8ru5FxZYKUXZjXNI1IGN9nOk0aOY7BOp
	 J+a2JoC6ayr6xzJs8M89smrmdD5K0j+HXhNH5hQRCGJprx8wByTewT3OEZ8iSpkHuq
	 IvZRpkL3bK1UevrNqT4a9ZyklMXVrYVz3h8oO7bubR6VklPKg/+Giw+ZpqqPUtc+xI
	 KHfG1MgAslybOZt/7pa9VA1nSGKjElXheu8I18lV2hfpRrWhEzqAmZherwvodsnlHL
	 delppYunTNIJA==
Date: Tue, 20 May 2025 18:51:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS
 contexts on queue reset
Message-ID: <20250520185144.25f5cb47@kernel.org>
In-Reply-To: <CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
	<20250519204130.3097027-4-michael.chan@broadcom.com>
	<20250520182838.3f083f34@kernel.org>
	<CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 18:38:45 -0700 Michael Chan wrote:
> On Tue, May 20, 2025 at 6:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Mon, 19 May 2025 13:41:30 -0700 Michael Chan wrote: =20
> > > @@ -15987,6 +16005,7 @@ static int bnxt_queue_stop(struct net_device =
*dev, void *qmem, int idx)
> > >
> > >               bnxt_set_vnic_mru_p5(bp, vnic, 0);
> > >       }
> > > +     bnxt_set_rss_ctx_vnic_mru(bp, 0);
> > >       /* Make sure NAPI sees that the VNIC is disabled */
> > >       synchronize_net();
> > >       rxr =3D &bp->rx_ring[idx]; =20
> >
> > What does setting MRU to zero do? All traffic will be dropped?
> > Traffic will no longer be filtered based on MRU?  Or.. ? =20
>=20
> That VNIC with MRU set to zero will not receive any more traffic.
> This step was recommended by the FW team when we first started working
> with David to implement the queue_mgmt_ops.

Shutting down traffic to ZC queues is one thing, but now you
seem to be walking all RSS contexts and shutting them all down.
The whole point of the queue API is to avoid shutting down=20
the entire device.
--=20
pw-bot: cr

