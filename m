Return-Path: <netdev+bounces-237808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEFC50778
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A25234C280
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B782D47E1;
	Wed, 12 Nov 2025 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NbWJLtfI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9F207A20;
	Wed, 12 Nov 2025 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919978; cv=none; b=jsVyeHQaBHARHJxa+sxFn4dixqHHmx63eyy3I97ow2chLSIAQzxzZ7HkuDAf5Yo1/sNoNlhB9NKT2Rg9S1QZ/6n15oepkuLtqehMEoR/XOA2TXAvw0JEtdoF7N8lwE/JYUkVigIBCDZjlkmZQTkQnqc1Bfc2gWzmj7gj9u3ghGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919978; c=relaxed/simple;
	bh=bIAGdTcC7bpTcOl7PjaMaeS9W7RV/cb5sccRrrTqMhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuj1NL8fqxsLEjjRqk+Xx13zctH4LcQDXHqNb7A8jATJk2mhP/xb5TeVv/0hpHo+5eCfMWE5W6794+AAloF/Nf/+m2gbG08VDTQ2GAF1J0ABi7IVCx7AQnayvxa7rUOyqLwGzZqIOx1Fzf1l2G2CSxdbkKIbCyz64yUmSP/hRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=NbWJLtfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31972C19421;
	Wed, 12 Nov 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NbWJLtfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762919974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxXWxdAurGNlts2UI7BG2pMBJD/v4/R/0QSS/5mHhO8=;
	b=NbWJLtfIl5vOr7JIVEepRq7aXMOaTK2EU09MeOEXJf1MFZoZu5+LygsMZ47pHYy1s9DLch
	EoT71SxziJ+GYmCpfS2wlyS58S68bUsS/e8iSLoyX7HtXJLTVL61R8dCcNPKnjXamarzYa
	kQQAnJZkq33/afjw+d6mn3ajwmA/fqk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 148d9f60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Nov 2025 03:59:33 +0000 (UTC)
Date: Wed, 12 Nov 2025 04:59:30 +0100
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
Subject: Re: [PATCH net-next v3 00/11] wireguard: netlink: ynl conversion
Message-ID: <aRQGIhazVqTdS2R_@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251110180746.4074a9ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110180746.4074a9ca@kernel.org>

On Mon, Nov 10, 2025 at 06:07:46PM -0800, Jakub Kicinski wrote:
> On Wed,  5 Nov 2025 18:32:09 +0000 Asbjørn Sloth Tønnesen wrote:
> > This series completes the implementation of YNL for wireguard,
> > as previously announced[1].
> > 
> > This series consist of 5 parts:
> > 1) Patch 01-03 - Misc. changes
> > 2) Patch    04 - Add YNL specification for wireguard
> > 3) Patch 05-07 - Transition to a generated UAPI header
> > 4) Patch    08 - Adds a sample program for the generated C library
> > 5) Patch 09-11 - Transition to generated netlink policy code
> > 
> > The main benefit of having a YNL specification is unlocked after the
> > first 2 parts, the RFC version seems to already have spawned a new
> > Rust netlink binding[2] using wireguard as it's main example.
> > 
> > Part 3 and 5 validates that the specification is complete and aligned,
> > the generated code might have a few warts, but they don't matter too
> > much, and are mostly a transitional problem[3].
> > 
> > Part 4 is possible after part 2, but is ordered after part 3,
> > as it needs to duplicate the UAPI header in tools/include.
> 
> These LGTM, now.
> 
> Jason what's your feeling here? AFAICT the changes to the wg code
> are quite minor now. 

Reviewing it this week. Thanks for bumping this in my queue.

Jason

