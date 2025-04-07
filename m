Return-Path: <netdev+bounces-179812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AAFA7E8D0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48F73BD899
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21245254AFC;
	Mon,  7 Apr 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFivnkmi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86F254AF8;
	Mon,  7 Apr 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047471; cv=none; b=kjsCdyc/jnVbBC51sVlgckRM1dIQHBqRXi3UO+8YfrbZLHTmCesjmoQrWw9Inaj9FCy6XdXDO1hxmHWXnY7nA475o1rugoqSioMUXrZdsUCpUrAHYgQYtWW4V5zw7UZ+05QNuKEFfB6NZtN0UVHnZ12lQzk+43H97sa085xOLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047471; c=relaxed/simple;
	bh=MW7NMtPA5VclrLe1RcPq9HcZiKDuUh9KnVa0EAVCI3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGr06Ie+CinE6okh2wm9lUD/lRgwrj018ZedX0yMqbrKDoh7jrUA46uYGZEcTP5TmomRDdt7YYZut5ibQi5ENIuwKTz6KbztrPltHM2ZOoJVU8lwUHZopT/sE/Oak3P2wsXxRaFZ4uCFAFzf4TzUzMWdEnlopsekbPCKeo2dO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFivnkmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69893C4CEDD;
	Mon,  7 Apr 2025 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047470;
	bh=MW7NMtPA5VclrLe1RcPq9HcZiKDuUh9KnVa0EAVCI3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VFivnkmiRqtrQTjIYSCWscKdpvG33+b+McV4yFLcpXa5ROcX8d1MCwrLqwX6JAjOF
	 nVV3ZkmmqCeHxBW71+MRQuO8PNq23v3VoOg3XDRl1yyapmZSQDjDazxQNdsjpUOLfU
	 0joI1kyXnk5aKy01x68WGlG6mwfVWWmcRiRWGEVXXYIysyjp2v+O+FxM++np903n6i
	 qeh1vHa7hjvjSpL8TG0rHhgI7FEh7Is7LoPOfeMp5v8lH9sZP7PJt5DoZok0JgT5aG
	 2Jerfxi2ixhtOAZwEoyssgb4S1wT2wu5gS5n5XbG0hAqhNiV51fMIKtozY1zhYgTY5
	 xTf2UIsq6uJ9Q==
Date: Mon, 7 Apr 2025 10:37:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Marc Dionne
 <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Christian
 Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-afs@lists.infradead.org, openafs-devel@openafs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] afs: Use rxgk RESPONSE to pass token for
 callback channel
Message-ID: <20250407103749.4e59159c@kernel.org>
In-Reply-To: <1349701.1744042902@warthog.procyon.org.uk>
References: <20250407161225.GQ395307@horms.kernel.org>
	<20250407091451.1174056-1-dhowells@redhat.com>
	<20250407091451.1174056-11-dhowells@redhat.com>
	<1349701.1744042902@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 17:21:42 +0100 David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
>=20
> > warning: format =E2=80=98%zx=E2=80=99 expects argument of type =E2=80=
=98size_t=E2=80=99, but argument 2 has type =E2=80=98long unsigned int=E2=
=80=99 [-Wformat=3D] =20
>=20
> I've fixed that and posted a v2.  I've also dealt with a bunch of kdoc
> warnings.

Please do follow the common netdev rules if the patches are targeting
net-next. We ask for new revisions not to be posted within 24h,
*ESPECIALLY* for trivial issues like compilation warnings :(
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
--=20
pv-bot: 24h

