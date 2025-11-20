Return-Path: <netdev+bounces-240217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA09C719F2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C0EC22978E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B351DA60D;
	Thu, 20 Nov 2025 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="isUTSwDq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8519B5A7;
	Thu, 20 Nov 2025 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600154; cv=none; b=UpKMDdSitIpD4ncxuosWkqvyQGO6boiLShvZGhBRd4OXhBnrGYEYOTVb3PJstnVH79Lq0bwdpZ4FC99Vl/zra84NNl/rfXRyDA0WhegKol8x87i9E96MFuzqzBpBxKrvBAsWXdATdZcLzqG1mBm8mrR0jO7i5GkemdHEXv9c210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600154; c=relaxed/simple;
	bh=Q0DZZ/JxiekuSF1qvW3fJNjEeUh+Mh6kSzNDRLBQhZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spNfDn0okd6hFF+l9a1dgJuz7RO6oEpyqmDrpskYQLNx7ZhWuHt8XlnutSTA3LmIGtkclPa4GwONlwa/yP5VGP3dNr3Mt+I8Ss1fueZoSwIoD0Ml41NL8jkLREzJtQ1MVfyYs5CRK9JzuOgJZU1ie1XQ4A0hJKiBgrOuucWAvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=isUTSwDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A554EC4CEF5;
	Thu, 20 Nov 2025 00:55:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="isUTSwDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763600151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WInqmEFbDY/RNTxo/ojAG1xVSL8xc4rSolc9zgV/Ec=;
	b=isUTSwDqz/O9aQIVXmq8x3m8Q17M+ZNH3Boeq+6dsokl2bXo1wXUizy8q9SUvf26ogkeS2
	vG6I9VH+DYdi9Cpg1Bba1VglO3Eqc71p6ffGMtgdmda3nh1pYVQgErf0vfKsymgh/N7Wz7
	+R9bONq8+sgufWODyOZxyWhUEa9Eozc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3c48548b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Nov 2025 00:55:50 +0000 (UTC)
Date: Thu, 20 Nov 2025 01:55:46 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 07/11] uapi: wireguard: generate header with
 ynl-gen
Message-ID: <aR5nEnP2PWJ7G7yp@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-8-ast@fiberby.net>
 <aRyOAYuWZE440WQ4@zx2c4.com>
 <20251118165315.281a21ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118165315.281a21ca@kernel.org>

On Tue, Nov 18, 2025 at 04:53:15PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 16:17:21 +0100 Jason A. Donenfeld wrote:
> > On Wed, Nov 05, 2025 at 06:32:16PM +0000, Asbjørn Sloth Tønnesen wrote:
> > > Use ynl-gen to generate the UAPI header for wireguard.
> > > diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
> > > index a2815f4f2910..dc3924d0c552 100644
> > > --- a/include/uapi/linux/wireguard.h
> > > +++ b/include/uapi/linux/wireguard.h
> > > @@ -1,32 +1,28 @@
> > > -/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
> > > -/*
> > > - * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> > > - */
> > > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> > > +/* Do not edit directly, auto-generated from: */
> > > +/*	Documentation/netlink/specs/wireguard.yaml */
> > > +/* YNL-GEN uapi header */  
> > 
> > Same desire here -- can this get auto generated at compile time (or in
> > headers_install time).
> 
> IMHO generating uAPI on the fly has more downsides than benefits.
> For one thing people grepping the code and looking and lxr will
> never find the definition. All the user space code in tools/ is
> generated at build time, but the amount of kernel code we generate
> is not significant at this stage. Not significant enough to complicate
> everyone's life..

I was thinking that doing this automatically at compile-time or
install-time would be _less_ complicated, not more, since everything
would be kept in sync automatically and such. But alright, so be it.

