Return-Path: <netdev+bounces-156036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF29A04B71
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B19166772
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256421F76AD;
	Tue,  7 Jan 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut2Egktn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CA1F75AD
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284559; cv=none; b=kyFnQYKFMnr7vsrGN5fiM2qMLr3fUxERFE5MrWK6jz8z0zsH3J98yYswIyHTt+LfOThF6kueTV4IkYpIcCTZhXXBzw8MNejnR1Gsz/ANwTbJLOSqKNunc10hMBMWqUqORcePDhVVw2aXmC/O3bFDGAaAdT7wn8QqNvFQWGTBWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284559; c=relaxed/simple;
	bh=lFDRObL4LzN1gAVAh+yHNrcX0t909PHm/69JXhQgv7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJeok/sBx74vs4CM5ylcntvMmbrs6C+xaWbTEq+M5DsjsAnQnN9VeCeDAsX9xt9r+nHGINC2b6H/tssF//h3ytJ8C7+ToIAPjy8Mqp3xtAl+/05fYJTxmwBjyVHYwb6psNiRpbn3T/LBrharAmTzcwV1VAdXG7N+G8QL8iAFNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut2Egktn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB0C4CED6;
	Tue,  7 Jan 2025 21:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736284558;
	bh=lFDRObL4LzN1gAVAh+yHNrcX0t909PHm/69JXhQgv7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ut2Egktn3ke0egIazi3UP2t4RZ/TxqvVNlZKliP91r1TKqH8BrAi6l7K1y7wGZGd0
	 RhDhUa8TAdigK+XBal9HnjlspHbjwaFgoK2SKsW8yVjkLwJO8zWhonewhDoIOnW6Mm
	 d6xRVrnaT6debTeVlrX5sLo0mK7HePEQMC8SLvBBH/wnWy8TV573ecjUZOFZ7CsxiG
	 SbOlWhv1uPIZiyhzfSenG/VXS+qSugBJLqi7z/i/z6TvebDnxvH5AnxoVYPgMtrQhh
	 Owz4qSvPJUN2qI+dKOVZcmB67Ewvnj/RG4vEf2R8yNrponvtfxUjdBmAnZi9bLw/pS
	 S/uXGHXZFugCg==
Date: Tue, 7 Jan 2025 13:15:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dw@davidwei.uk, jdamato@fastly.com
Subject: Re: [PATCH net-next 5/8] netdevsim: add queue alloc/free helpers
Message-ID: <20250107131557.5240dc76@kernel.org>
In-Reply-To: <CAHS8izP3meH1Ci18UOutkQNqGJBTJ=rxvNNd4jkmyYBi5oUFkA@mail.gmail.com>
References: <20250103185954.1236510-1-kuba@kernel.org>
	<20250103185954.1236510-6-kuba@kernel.org>
	<CAHS8izP3meH1Ci18UOutkQNqGJBTJ=rxvNNd4jkmyYBi5oUFkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2025 13:08:27 -0800 Mina Almasry wrote:
> On Fri, Jan 3, 2025 at 11:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > We'll need the code to allocate and free queues in the queue management
> > API, factor it out.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org> =20
>=20
> Reviewed-by: Mina Almasry <almasrymina@google.com>

v2 alert!

https://lore.kernel.org/all/20250107160846.2223263-1-kuba@kernel.org/

