Return-Path: <netdev+bounces-173585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F9A59AB3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4801C3A5568
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065122F166;
	Mon, 10 Mar 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BsvTqQ+L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/+nwL9g7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD30F221F26
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623197; cv=none; b=FQJTatOVxflBLO07PXHYdM9qQNLrAJww/VWATpjSsKz1inmmrA9aLt/Vy75aGwLbD6dBAVNP0IQwCk0f2vQOjb2YGH8HOwpabcjmOzK6AUhbUsKZ2F7iA0cn5QP4DkjJBEXL/5rKxIg0gKKuw6rBh6SsTTr8jCLPeW8HgJvQxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623197; c=relaxed/simple;
	bh=IMsLKn1RPicSoT5hJ9b5CaHf/w5v4Yl0UdAYShh0nak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BxC2ubrjZRqM6LpprDP9Z3mfi+aAzyNWW53+tyLTnV/JjkKFUOl1YuFbQedff414YEDuof7OC6eOCVk3SxBoGckaNjONBz91KZeAPzababb/dM+s91rz3fgqMWeUWhd7PylLYSTUri/b+zqDLpMgSWgkMaLp8Oc24tvS3PHEdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BsvTqQ+L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/+nwL9g7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741623193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuDLAr3Wz8h6YVwKLam3Jg8MiZdFwWXZx63sMilpWcU=;
	b=BsvTqQ+Lj3eQ8exZ6bsc8VUnbeMJ82cZ+rGLIw8ddYh3bNhp/XdtV5qN3uBvcbBbs5ajq0
	fb8tapZDGDidxuQKu8+fy1nPAJkMiCYegN08QhzyyWNTeBkYDd6lGln/A03f0RH+xP6r/w
	3i+WyjUAj6ZJNDdglecVk7yuUhF75joe41yf2dlDTsYUCTnNijP+YIaQ/PdJ5VQ/SP2Ejg
	0uMr/dVGe3ePj4r16i/o2kuyVlVrlPY8A7YiZnvFROR20uqLeKkt2NJLFMnRzEQ/IHnOBc
	5JKABYQesKgZ8yARB5acxgk+xPf06fS1tGFYfIuxTvNKj02jeERemfPz6EMKtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741623193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuDLAr3Wz8h6YVwKLam3Jg8MiZdFwWXZx63sMilpWcU=;
	b=/+nwL9g7OwGj9dFMo3X3QFgEydjfhKBddFn0bg66O5vvpKzfT41gIPIhjnkXTPIQs90UCK
	8QWaSHNsYEdCxwCg==
To: Joe Damato <jdamato@fastly.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Gerhard Engleder <gerhard@engleder-embedded.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/4] igb: Link queues to NAPI instances
In-Reply-To: <Z86kBp2m-L-usV0V@LQ3V64L9R2>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>
 <f71d5cee-cafc-4ee0-89fc-35614eb06f94@intel.com>
 <Z86kBp2m-L-usV0V@LQ3V64L9R2>
Date: Mon, 10 Mar 2025 17:10:53 +0100
Message-ID: <8734fkq31u.fsf@kurt.kurt.home>
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
Content-Transfer-Encoding: quoted-printable

On Mon Mar 10 2025, Joe Damato wrote:
> On Fri, Mar 07, 2025 at 02:03:44PM -0800, Tony Nguyen wrote:
>> On 2/17/2025 3:31 AM, Kurt Kanzenbach wrote:
>>=20
>> ...
>>=20
>> > diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/et=
hernet/intel/igb/igb_xsk.c
>> > index 157d43787fa0b55a74714f69e9e7903b695fcf0a..a5ad090dfe94b6afc8194f=
e39d28cdd51c7067b0 100644
>> > --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
>> > +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
>> > @@ -45,6 +45,7 @@ static void igb_txrx_ring_disable(struct igb_adapter=
 *adapter, u16 qid)
>> >   	synchronize_net();
>> >   	/* Rx/Tx share the same napi context. */
>> > +	igb_set_queue_napi(adapter, qid, NULL);
>> >   	napi_disable(&rx_ring->q_vector->napi);
>> >   	igb_clean_tx_ring(tx_ring);
>> > @@ -78,6 +79,7 @@ static void igb_txrx_ring_enable(struct igb_adapter =
*adapter, u16 qid)
>> >   	/* Rx/Tx share the same napi context. */
>> >   	napi_enable(&rx_ring->q_vector->napi);
>> > +	igb_set_queue_napi(adapter, qid, &rx_ring->q_vector->napi);
>> >   }
>> >   struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>>=20
>> I believe Joe's fix/changes [1] need to be done here as well?
>>=20=20
>> Thanks,
>> Tony
>>=20
>> [1] https://lore.kernel.org/intel-wired-lan/9ddf6293-6cb0-47ea-a0e7-cad7=
d33c2535@intel.com/T/#m863614df1fb3d1980ad09016b1c9ef4e2f0b074e
>
> Yes, the code above should be dropped. Sorry I missed that during
> review - thanks for catching that, Tony.
>
> Kurt: when you respin this to fix what Tony mentioned, can you also
> run the test mentioned above?

Hi Tony & Joe,

Hm. I did run the test and it succeeded. I'll take a look at it next
week when I'm back in the office.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmfPDw0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgn1aD/9tRXm3GqrzZQMU2qpXAYFfWc/58gEw
fkY47pLpb1Flvgj4npkht1GaGAnrnGQQvVWrDNwktbqj/BUSvFK9SGXBgNUgPSXI
NmdKoc0ln9sn+BElFyiwSUk9fyappT8phmFLlfkOYPwQl2oRPg6Mri6PDQBfYw+I
GNoejpbMI5JYnIernngoMbLf4daWa9BLoIuR7k94HO1/NizeWUIuljUFdrLsJ4/K
hdeLoSbkb26BCZvS3YpfBemWQrU8u6bdWATOC5CPRTnlHfYV3VH+GY6G/Uk3T8E3
l/2SUk51UlPyMz286miqO2Eozs2OM/+YLNrPqFZ4kT0nDwEuY2UdmA+kVh8effCQ
EDcxcnpABtUfz0IzoBy0h9PDSYBp0GXM2awtP+9+fz7wt8ctHGdM/1lUuz3NHta7
B1F48wUNllSVc0Fj4mRXcdk81WZqYZwUt0FjLaSkgBvrx/BqPQg2lufaxS5/VUCw
RSVNHKVH353aOzY6zV5hZ+sjBY2f4e6RhKFaCsqNOSBcKPOIIfBrF+Egr+cT1STF
ScDLTkDZAwvmC99IvpJSx0DQprvx0pTZ4nJX0nRgibxHFQLarAhyGPGtAhL4a3wm
5SfQ//XIwdQfnC9Q6VeLQeAtfGuzuBscVNYKhevC6M01Ya3YzRDGCw9vS/0+vNzV
Uvu5DPvpy61CoA==
=mHhc
-----END PGP SIGNATURE-----
--=-=-=--

