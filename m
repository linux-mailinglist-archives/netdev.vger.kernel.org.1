Return-Path: <netdev+bounces-98720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDB8D230B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25899282A32
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D347F60;
	Tue, 28 May 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmIe6gV0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612D45C14
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919765; cv=none; b=dilS2F1Aa4Kx5t13T8LDXeuUEioo+p2IXnQUAH9Zj1zcjxKFXeo622IGtY1uBqZuVtmQ2zkKoXk/Nn1ZlrVyyFftqc+JbKi/5AcJhgcAzC2gz3YW8wHWhBL6wx5bZe8rVe+CYxJ10UIUZsBIUonDCEU0dceVbicTjAu/mr3u4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919765; c=relaxed/simple;
	bh=KD34xdxulxYzo/NvLrf29jnx01FFfXdsTgBJFdiXof8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgt5GNbExUsJIVyg4zuKOOm4iyH7q1o3kc+uCa3cilPAFD//mIAEtCyDx2LWO193IAOUc/Wva6mbMSNTybD6eXwiaOUVx8q00lJJeDq0tsv62wYVZ711/1HM7hreYEVPnJbJZ6aFswR6yvsvl9X2WthrumdoJp6irwb5sy11F4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmIe6gV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04438C3277B;
	Tue, 28 May 2024 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716919765;
	bh=KD34xdxulxYzo/NvLrf29jnx01FFfXdsTgBJFdiXof8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZmIe6gV0Pz6RcH1//xpQqK65TMyi0uQVTUuU+r+3nuuVfpoVUoRPygKsZbs3fCpt+
	 5CQWRNNuseLM9iI4OOqFt/mOr7KfaJuOSu1dnNVeD2L4/q4qR3yZhRTobSNkpyCf0n
	 IkghrG2sOHVarTREeY0CFFv8ClBz6+qfbfA5YR3n5mJOOGFTsbeeY3NUiLFxh35S1b
	 or3tyk9unSEk+59CjrO83JxB+b8BnG4Wo48GqcCwujcApx1dc4+JWDQyPLmDiipS8d
	 C3Y+wUcZcR7alF7AFl/sanEphhtKXxZ4e8y5WMDpHDW2RQozEdM74h0Er8HH2qhGW+
	 V7aF2eEEsX7SQ==
Date: Tue, 28 May 2024 11:09:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Wouters <paul@nohats.ca>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, pabeni@redhat.com,
 borisp@nvidia.com, gal@nvidia.com, cratiu@nvidia.com,
 rrameshbabu@nvidia.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Message-ID: <20240528110924.0f131264@kernel.org>
In-Reply-To: <81646030-00b9-10ad-abed-a7a78f0c511e@nohats.ca>
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
	<ZlWm/rt2OGfOCiZR@gauss3.secunet.de>
	<6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
	<81646030-00b9-10ad-abed-a7a78f0c511e@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 11:33:33 -0400 (EDT) Paul Wouters wrote:
> > It makes sense to work to get to an IETF standard protocol that
> > captures the same benefits. But that is independent from enabling what
> > is already implemented.  
> 
> How many different packet encryption methods should the linux kernel
> have? There are good reasons to go through standard bodies. Doing your
> own thing and then saying "but we did it already" to me does not feel
> like a strong argument. That's how we got wireguard with all of its
> issues of being written for a single use case, and now being unfit for
> generic use cases.

Now you made me curious. What's wrong with wireguard?
I have only heard good things.

