Return-Path: <netdev+bounces-87696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53978A41EA
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 12:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3351F212FD
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A42E644;
	Sun, 14 Apr 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN1ErKEN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220C21A1C
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713091505; cv=none; b=ceAHe9FQUMmxBbET1RfbmrzWRienxQkMdptWBbGA+GwIhbTKAeymsHnbqxvmxr8x59KV/dVni8b/cIerU9qD9nmW8oKBh1VqN4ruJQk0TmhsIeITqJfhxMn1y5QfcNIZsLLsTQSpVvavqM8ttiIw404fgDKka79kBq1foS17TR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713091505; c=relaxed/simple;
	bh=+iPx7L3YADSjEsnMN8C4gLtm3meBO09BJJCj0YD1ZHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFybrTJoIIDtp0bnMBPnxUNWyqz9yGrezIMa/dJvH18UFJjGy4ItdMp2wOuOQm8/56YdaQjDB5/ylYys0Aeiebco9yy9KQzrwzdfpsizmpOsgBSnCSJ7miKZdSIluzSb/oF7QeByUEz9eZKorMRQOEBLpm7B8cpFjvcXVJsov+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN1ErKEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42296C3277B;
	Sun, 14 Apr 2024 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713091504;
	bh=+iPx7L3YADSjEsnMN8C4gLtm3meBO09BJJCj0YD1ZHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FN1ErKENe6JzbK502/tvn8A86Zixlyt4NP6gfu0GEbkzTzbp4SgH7jUfsYsNpTCfJ
	 2W9YEL43JmODrc7XAHpYfNrHPDwTueLf1zpIMLuar45HJXu6qDeOH587cFRG2UQR01
	 EjVyDm4fR5UqDGBtTvZK/7j55PyRb4spF9pfT2aw0QafEU5ncodAs6zGm5whc3MOnb
	 40LzQrNzxz2FzWKNuAR3+S66kM3k3YTie5w9KLaBvktUwM2gBxFL+sTO6tRMVXIodW
	 adni3YbY/TXEvkG00kK6MeWjrXd46vHc79s93JPafLNhOHiRrzoyxD/nBEZIL+xItR
	 bfkZ/7sNIluLw==
Date: Sun, 14 Apr 2024 13:45:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>, antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v8] xfrm: Add Direction to the
 SA in or out
Message-ID: <20240414104500.GT4195@unreal>
References: <9e2ddbac8c3625b460fa21a3bfc8ebc4db53bd00.1712684076.git.antony.antony@secunet.com>
 <20240411103740.GM4195@unreal>
 <ZhfEiIamqwROzkUd@Antony2201.local>
 <20240411115557.GP4195@unreal>
 <ZhhBR5wTeDAHms1A@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhhBR5wTeDAHms1A@hog>

On Thu, Apr 11, 2024 at 10:00:07PM +0200, Sabrina Dubroca wrote:
> 2024-04-11, 14:55:57 +0300, Leon Romanovsky wrote:
> > On Thu, Apr 11, 2024 at 01:07:52PM +0200, Antony Antony via Devel wrote:
> > > On Thu, Apr 11, 2024 at 01:37:40PM +0300, Leon Romanovsky via Devel wrote:
> > > > On Tue, Apr 09, 2024 at 07:37:20PM +0200, Antony Antony via Devel wrote:
> > > > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > > > xfrm_state, SA, enhancing usability by delineating the scope of values
> > > > > based on direction. An input SA will now exclusively encompass values
> > > > > pertinent to input, effectively segregating them from output-related
> > > > > values. This change aims to streamline the configuration process and
> > > > > improve the overall clarity of SA attributes.
> > > > > 
> > > > > This feature sets the groundwork for future patches, including
> > > > > the upcoming IP-TFS patch.
> > > > > 
> > > > > v7->v8:
> > > > >  - add extra validation check on replay window and seq
> > > > >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > > > 
> > > > Why? Update is add and delete operation, and one can update any field
> > > > he/she wants, including direction.
> > > 
> > > Update operations are not strictly necessary without IKEv2. However, during
> > > IKEv2 negotiation, updating "in" SA becomes essential.
> > 
> > The thing is if you want to limit update routine to fit IKEv2 only, or
> > continue to allow users to do whatever they want with netlink and their
> > own applications without *swan.
> > 
> > I don't have knowledge about such users, just remember seeking tons of
> > guides how to setup IPsec tunnel with iproute2 and scripts, one of them
> > can be potentially broken by this change.
> 
> Nothing is going to break with this change. Old scripts and old
> userspace software are not providing XFRMA_SA_DIR, so none of the new
> checks apply.

Right, but what about new iproute2, which eventually will users get
after system update and old scripts?

Thanks

> 
> -- 
> Sabrina
> 
> 

