Return-Path: <netdev+bounces-239643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A4C6AC51
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3083E2C158
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48C35F8A6;
	Tue, 18 Nov 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hTMa+WRI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609EE33C50B;
	Tue, 18 Nov 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485071; cv=none; b=QisAcwO1ttHJ05Y6d+gJP26XZhJEVTQ6SZo5jH+iNSeozEggUPL2qvehduU7GawHOms7vM2K4msiBW5H0g3t3XU2I0qN2rHNXd7H1K1jMP/pC3XQGi11E/mFDsLlyoLXjecW28A4p3qxXaI8iIm1McyE0sBlCwh6Z3Tj2fVvn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485071; c=relaxed/simple;
	bh=UDriwsuBnjOEywQCrQ4A0kzuvLtrMAbcXfVnxRTqH1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmqMZIOAG3s0vbLgry1kb9oVAMz1FetsFTXo5hT+9+NTBAvJ9IgvK50xCM61AeOjkPB8rhCJxAtaToo4TUAExPQBkOqDkD+rlb6qddHnNS5ShuRv28RsKrKmwpdcR2goP4JaRZVHec9iXl8dywI4N2uG6lB9c36AK2ICn2Pb/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hTMa+WRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F664C4AF0D;
	Tue, 18 Nov 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hTMa+WRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763485066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCqeKRErpiskaDWQgypPBD6vSuFTsdUlVUEfCgLg8Mo=;
	b=hTMa+WRIqJn+KqsV9hq0rMuRNCkEFOC6MeFEj4ufcRXPcrDrMrQG+QmYLDiNcAr/duaSKl
	7PxmvcngaHQ7gESt59AdM04add+IRDxafgsfu0vDYrP5rwTREkgRvpjaPT9P2oo/LW5OU2
	k7dBtaphmHtiVcA8mfvWd+ssMZOCAgE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 81180c79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 16:57:46 +0000 (UTC)
Date: Tue, 18 Nov 2025 17:57:41 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink
 code
Message-ID: <aRylhXuvGb2s5KHi@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-12-ast@fiberby.net>
 <aRyNiLGTbUfjNWCa@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRyNiLGTbUfjNWCa@zx2c4.com>

On Tue, Nov 18, 2025 at 04:15:20PM +0100, Jason A. Donenfeld wrote:
> On Wed, Nov 05, 2025 at 06:32:20PM +0000, Asbjørn Sloth Tønnesen wrote:
> >  drivers/net/wireguard/netlink_gen.c | 77 +++++++++++++++++++++++++++++
> >  drivers/net/wireguard/netlink_gen.h | 29 +++++++++++
> >  create mode 100644 drivers/net/wireguard/netlink_gen.c
> >  create mode 100644 drivers/net/wireguard/netlink_gen.h
> > +#include "netlink_gen.h"
> > +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> > +/* Do not edit directly, auto-generated from: */
> > +/*	Documentation/netlink/specs/wireguard.yaml */
> > +/* YNL-GEN kernel source */
> 
> Similar to what's happening in the tools/ynl/samples build system,
> instead of statically generating this, can you have this be generated at
> build time, and placed into a generated/ folder that doesn't get checked
> into git? I don't see the purpose of having to manually keep this in
> check?

Grep, for example, for PERLASM in the lib/crypto code. There's certainly
precedent for doing this.

