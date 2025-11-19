Return-Path: <netdev+bounces-239787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA1FC6C6D7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C82832082B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C32C1590;
	Wed, 19 Nov 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le/mxjPp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918629D267
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520363; cv=none; b=TbshVehhdBbi5zedn3rzHmQfabzuC4J3b1ZEsTFwNPD3D8hwPoJbeJ6xVV5rRxDFFmRs5A8SRD/nW65J2Dcjfvge2rIEvdevA4wdSlG3RSUCZn7g7LmfADVvKeuHTPUAq/NsIeJCpiokLQCSEJoxFv75mWkpSlce0DCcF6BnTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520363; c=relaxed/simple;
	bh=kivB3IDwUgyvC6c7m0lspcXwZWGwaoluuW90NTyK4W0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpGOYE73oM/BEW0nPsCzHTP0pwXrapQoT2R1qUJmgMcO8ZEt/+PT1B21kgO6Xe6ZfKRv+byOw/JORqwDJx3Hshby30HIOqX38kxnCWqfS0B5JKew6mGbPTq2z24q+UBl5b6Y/qFb2XZObUCRBe4J3Al5eGq+bunpG0ZL+WbKlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le/mxjPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F449C4CEF5;
	Wed, 19 Nov 2025 02:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520361;
	bh=kivB3IDwUgyvC6c7m0lspcXwZWGwaoluuW90NTyK4W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Le/mxjPpgstZQ15NjuVkkJLEkshbd7nsoIBk0ZtzX6fJg1RU/53+hnz+FH3zX24fR
	 NtLs0RvJJmjZNgDJHRy0JGWKuTGOL3DlbvwiS/44z2oQ8PwuoIb8wMRBDbvGHo7mnV
	 uudtIC5XP+6/pEM0MrKHP3bFsz+oYuGAVCEu7c4ruwXHT+/qwCoOAAOWWq3HI69b3f
	 MIkBu9pdlMQGSWXz2xGVkePZ3nwUKYJh/S1kXO1kXxWXwU22ZmMBOVC1r8RX79wMt1
	 rDTvDmMLmXTSsFz5f9c09gELOpUZoz1hYtlZcTyMD8z1kQMZjtqgyFHnGBmVi395GI
	 iZRzkX0gvopcg==
Date: Tue, 18 Nov 2025 18:45:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv5 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <20251118184558.4d28aae2@kernel.org>
In-Reply-To: <aRvdb65MyVc39nm6@fedora>
References: <20251117024457.3034-1-liuhangbin@gmail.com>
	<20251117024457.3034-4-liuhangbin@gmail.com>
	<b3041d17-8191-4039-a307-d7b5fb3ea864@kernel.org>
	<aRvIh-Hs6WjPiwdV@fedora>
	<e7aba5b3-d402-4a09-9656-1b96be6efa84@kernel.org>
	<aRvdb65MyVc39nm6@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 02:43:59 +0000 Hangbin Liu wrote:
> > How did you execute shellcheck?
> >=20
> > If I'm not mistaken, you are supposed to execute it from the same direc=
tory, and with -x:
> >=20
> > =C2=A0 cd "$(dirname "${script}")"
> > =C2=A0 shellcheck -x "$(basename "${script}")" =20
>=20
> Ah, I forgot to add the "-x" option... I will fix the comment in future t=
est
> case update.

I applied the first two patches of the series, please respin this one.
TBH I'd like to check if this all works in NIPA but probably won't have
time to set up a new worker until the weekend. I suspect I'll need
to touch up the vng wrappers since this is not true ksft TARGET.

