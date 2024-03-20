Return-Path: <netdev+bounces-80777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5808810B2
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D554F1F22907
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69E3BB4B;
	Wed, 20 Mar 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptJHOgFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871483BBCE
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933235; cv=none; b=vA6Xj9pkj05XmNKelL2dEQ2zdID3dQb1gZSaQC4eRwB4y3BDNjyd5t3wgAzxAL8wBMkJZ7QUNIqx7/9mTcd3WYtY566/501Hu//gbVByRRZcQ4EHsprVtoTQDXtyHF0744Qj+QJr4j8JIsXycbCNp51+s2rxQS8JkIbtH2V+WOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933235; c=relaxed/simple;
	bh=NtHUiSKmlsnln2Ra4iUXxk+t3Rdft9JEoFLAWKwtOWg=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=blT2T1e+pULKX3mtFMWnwzptZtXGvScjLBgfwe+FNuB9qkB5ejRuX0FcMk5pRITrv8Sm4DaYJqep/taUb/LsDn8aVRwljz+OfBhsy6wU3mLxtZwemHH3JbJarHs54m6t4KKHQL4iXXWKqnL8PwCQsCqwNPgid21AYSBT6ro1tfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptJHOgFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8912C43390;
	Wed, 20 Mar 2024 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933235;
	bh=NtHUiSKmlsnln2Ra4iUXxk+t3Rdft9JEoFLAWKwtOWg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ptJHOgFbKgKjGUqmcA4MfMbZHjS2VOh5+qYiKqYmNq8TMDlOg9QWz5jaOgaktnUSY
	 FT3GIiwcccUEDeOFSgaZYDR+M2bdFMs/HPDroz/Lp5Jt10NCUaCl5NNwZy8Ija9VWw
	 ocQzgjHsIGC4x0r2KyrJhZ6GPcFMp2yoApvn9CBDhKwXviggAuTwwuLPDLAg3SgL7t
	 +qxjKiWSKsDBanLN559E02HvWiVhufsh6AysWJ2h3QOJaPhWb1I06S8hZTmNuoLX/u
	 CFjOIrnhIKzjfGnd5VY5cPVisJCRfJIZACF8XSjjeuIiCarPdvbIgbJwZ7Z5eI5jQ2
	 gpig9h8GNidjw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <99098715-6b36-456a-869e-39f9b211a8bc@blackwall.org>
References: <20240319093140.499123-1-atenart@kernel.org> <20240319093140.499123-2-atenart@kernel.org> <99098715-6b36-456a-869e-39f9b211a8bc@blackwall.org>
Subject: Re: [PATCH net v2 1/4] udp: do not accept non-tunnel GSO skbs landing in a tunnel
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 20 Mar 2024 12:13:52 +0100
Message-ID: <171093323212.5492.17032648986424979519@kwain>

Quoting Nikolay Aleksandrov (2024-03-20 11:34:01)
> On 3/19/24 11:31, Antoine Tenart wrote:
> [snip]
> > @@ -163,6 +181,16 @@ static inline bool udp_unexpected_gso(struct sock =
*sk, struct sk_buff *skb)
> >           !udp_test_bit(ACCEPT_FRAGLIST, sk))
> >               return true;
> >  =20
> > +     /* GSO packets lacking the SKB_GSO_UDP_TUNNEL/_CUSM bits might st=
ill
>=20
> s/CUSM/CSUM/

In the commit msg as well, thanks, will fix.

Antoine

