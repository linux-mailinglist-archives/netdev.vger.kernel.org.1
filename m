Return-Path: <netdev+bounces-251203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38505D3B498
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D017D3001180
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEE9329C69;
	Mon, 19 Jan 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4iQMEGk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901B314D26
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844387; cv=none; b=KttV0m4SZ8QxVex2RI1beA3Z+pOEZota1ZKezHStd9p/gg1/WHh2xV1/yXd8WDnowuXqbaa0Dv/qRltnX0bfsNvUFnHye+pd9HT8VcwVr7joSiC0lKvTECc7sl7wEscMpNL6g3G7P3RABIT2magsALF0wOb7exX8PZztq+mHq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844387; c=relaxed/simple;
	bh=fCm11KTxwgTbqSK4fIVphMdSNLjJnpBaioQ8TKpFVaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr22WHhGWft5ry+HhY6rcw5E5L5dPmJNXebHVimlk04ixu0GaIdNZMJK1o090CRpQfwNWIHy6seQ+z3y5DsGXlIsflYVGFIk0TdVzRZfbWMi1N4RLBNQMqj/4r8J5/A61xmUkqQ74Rbtx54Sd727SQEynJBuNudP6zzUcytXzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4iQMEGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEE8C116C6;
	Mon, 19 Jan 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768844386;
	bh=fCm11KTxwgTbqSK4fIVphMdSNLjJnpBaioQ8TKpFVaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t4iQMEGkllrfxQEDi7/y1W1P06qpC465iod8axc8ugVc3ShOIhduAVYloG7Rqh6En
	 JjxmFfVe2y1BPMrlWh0K4+uGWnGG0VX3puFO56Kz3vjdVErLja7i176g6h3V/MUOaQ
	 w/hUdbtMpQz3JWlILamvnr5Tri9tFv/MYn6CG5rVb9TNJS5j4m0/XU/lI0e4r0EaoV
	 tlZn3Va79MXmseR4ASJ8xRF/sidoZjejz7SD4t33jiWUjMzSMfIBYN/5ANa1VvLviW
	 7nrNIqYbR3A4XlSIye+kCBshtofmeWc5LrqhCRn563niVH9isRqxaRScYctSrD04LS
	 A4r7VumQwUEFw==
Date: Mon, 19 Jan 2026 09:39:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [net,v2] rxrpc: Fix data-race warning and potential load/store
 tearing
Message-ID: <20260119093945.7929e3cb@kernel.org>
In-Reply-To: <916127.1768737781@warthog.procyon.org.uk>
References: <20260118002427.1037338-2-kuba@kernel.org>
	<89226.1768426612@warthog.procyon.org.uk>
	<916127.1768737781@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 12:03:01 +0000 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > > +		   (s32)now - (s32)peer->last_tx_at,  
> >                                  ^^^^^^^^^^^^^^^^^
> > 
> > Should this read use READ_ONCE(peer->last_tx_at) for consistency with the
> > data-race fix?  The new rxrpc_peer_get_tx_mark() uses READ_ONCE for the
> > same field, and the same seq_printf uses READ_ONCE for recent_srtt_us and
> > recent_rto_us on the following lines.  
> 
> I suppose.  Racing doesn't matter here as it's just displaying the value;
> tearing might matter, but it's now a 32-bit field.

Right, total nit pick. It's mostly for consistency with other fields in
the same print statement that are READ_ONCE()d.

