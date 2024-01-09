Return-Path: <netdev+bounces-62696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FE82898B
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDAE288037
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5F839FF4;
	Tue,  9 Jan 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPfBG4mg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C89A958
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCB1C433C7;
	Tue,  9 Jan 2024 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704816037;
	bh=Kjf6wMa3nRm2ssw7w+d3a3xIXZ0iopYF7rgjTrwYpCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MPfBG4mg5xvAUCR0QZ8ws1FhAo/xp6pVjR8GQ8mLrfcrYlopYrGW8JhI39uyjyfZe
	 QiZgSyaH8EC/6Q88lRdfm3/5yRW0MEMKtL3ct71tmkHrnZvdRFft/PX1Dzv6UJU+Vm
	 BEbxP0hth7t61CfeeSiIMHhIvepJOtnk3AkLD3tuJkLg9EzDMd//1HL34rDATdPq2U
	 E+hOnvPQPRXBieVLC5sFMLOy3QZZM5K7YY0A/lZ7hqHp4WR4EK1uZCX3CKQ75JZY/e
	 VDE4rIb1c7D14UjZhirdslssPEdY1O31Y6zMnDlE6/YDg/TWr1s80F6UAaIwBYfyFr
	 dasSTVUjmp2Mw==
Date: Tue, 9 Jan 2024 08:00:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
Message-ID: <20240109080036.65634705@kernel.org>
In-Reply-To: <d0ce07a6-2ca7-4604-84a8-550b1c87f602@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
	<20231221005721.186607-11-saeed@kernel.org>
	<20240104145041.67475695@kernel.org>
	<effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
	<20240108190811.3ad5d259@kernel.org>
	<d0ce07a6-2ca7-4604-84a8-550b1c87f602@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jan 2024 16:15:50 +0200 Gal Pressman wrote:
> >> I'm confused, how are RX queues related to XPS? =20
> >=20
> > Separate sentence, perhaps I should be more verbose.. =20
>=20
> Sorry, yes, your understanding is correct.
> If a packet is received on RQ 0 then it is from PF 0, RQ 1 came from PF
> 1, etc. Though this is all from the same wire/port.
>=20
> You can enable arfs for example, which will make sure that packets that
> are destined to a certain CPU will be received by the PF that is closer
> to it.

Got it.

> >> XPS shouldn't be affected, we just make sure that whatever queue XPS
> >> chose will go out through the "right" PF. =20
> >=20
> > But you said "correct" to queue 0 going to PF 0 and queue 1 to PF 1.
> > The queue IDs in my question refer to the queue mapping form the stacks
> > perspective. If user wants to send everything to queue 0 will it use
> > both PFs? =20
>=20
> If all traffic is transmitted through queue 0, it will go out from PF 0
> (the PF that is closer to CPU 0 numa).

Okay, but earlier you said: "whatever queue XPS chose will go out
through the "right" PF." - which I read as PF will be chosen based
on CPU locality regardless of XPS logic.

If queue 0 =3D> PF 0, then user has to set up XPS to make CPUs from NUMA
node which has PF 0 use even number queues, and PF 1 to use odd number
queues. Correct?

> >> So for example, XPS will choose a queue according to the CPU, and the
> >> driver will make sure that packets transmitted from this SQ are going
> >> out through the PF closer to that NUMA. =20
> >=20
> > Sounds like queue 0 is duplicated in both PFs, then? =20
>=20
> Depends on how you look at it, each PF has X queues, the netdev has 2X
> queues.

I'm asking how it looks from the user perspective, to be clear.
=46rom above I gather than the answer is no - queue 0 maps directly=20
to PF 0 / queue 0, nothing on PF 1 will ever see traffic of queue 0.

> >> Can you share a link please? =20
> >=20
> > commit a90d56049acc45802f67cd7d4c058ac45b1bc26f =20
>=20
> Thanks, will take a look.
>=20
> >> All the logic is internal to the driver, so I expect it to be fine, but
> >> I'd like to double check.
> >=20
> > Herm, "internal to the driver" is a bit of a landmine. It will be fine
> > for iperf testing but real users will want to configure the NIC.
>=20
> What kind of configuration are you thinking of?

Well, I was hoping you'd do the legwork and show how user configuration
logic has to be augmented for all relevant stack features to work with
multi-PF devices. I can list the APIs that come to mind while writing
this email, but that won't be exhaustive :(

