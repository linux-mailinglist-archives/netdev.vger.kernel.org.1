Return-Path: <netdev+bounces-204701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC7FAFBD3B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3FF3A8149
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC426C393;
	Mon,  7 Jul 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIk+2GFM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C48219300
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922636; cv=none; b=f+ZooILTHK6PsvUi9a3rDrccDm9EgG1pItDSIozJ6wpEH4pRqZvC9vL5IcALSvJlTu65BfXIxs6M5oe7Mc6SgdIYS2ybJNnECoB+U9fpJjy19Rg1rHMtnvAGflwPF6QT0hm7P3eA2LF5WZsQGf61rdXwa5RLIvN+I+6xsJmfH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922636; c=relaxed/simple;
	bh=c0DJkAJx/ECBfUe8SsVB3Usym7EWpuZ/BH5DsypIWAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qu2HmGcpxOZ6KFL5mwM6hCpv9ISLqMXC73NWgmEQFsf/eNj2D1mvy3+riKNuyIbNTN+2oI87eJJyJgHD/yeVreTeWAEB5EdexYVsXhIx+sIoI50VPQ76LXBKtRLkjtH12kRQRrIkdBaKZ54mFuv33avMVMbKMKnudYAicREQohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIk+2GFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD00C4CEE3;
	Mon,  7 Jul 2025 21:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751922636;
	bh=c0DJkAJx/ECBfUe8SsVB3Usym7EWpuZ/BH5DsypIWAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OIk+2GFMjHNJ05zicv+2KuAT6bz/A9hVAJn80N7vPKiYi2CRXosraJeXhIHtdv7bw
	 6nrp7ORgCOj25RcrbLxg36jjaGui4mLh6AxEtYY6NRuMfjv+uhrLwyLilyLhWYcGtO
	 wCSISE/+u0BhcLaTIQBx+P2kHtRK+l7S/P1EoRjwjW/S+BfGnvZvJ8+XjlAG0fONJw
	 l9AGvQmh44GCx+BAnjUhUKiYhHTIe4HjFYnaQTX8oMZbTrPY0e886AcorKQQh6mmA6
	 xdlfGF2u9UkkdwbxQg8c+SxK/Hll8//RBjTiopKco2WkIier9f2x5c+7MCOXDgmRpH
	 b7EtwwiA7rFEQ==
Date: Mon, 7 Jul 2025 14:10:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 08/19] net: psp: add socket security association code
Message-ID: <20250707141034.2367cbc1@kernel.org>
In-Reply-To: <686aa894a8b6e_3ad0f32946d@willemb.c.googlers.com.notmuch>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	<20250702171326.3265825-9-daniel.zahka@gmail.com>
	<686aa894a8b6e_3ad0f32946d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Jul 2025 12:47:16 -0400 Willem de Bruijn wrote:
> > +            - rx-key
> > +        pre: psp-assoc-device-get-locked
> > +        post: psp-device-unlock
> > +    -
> > +      name: tx-assoc
> > +      doc: Add a PSP Tx association.
> > +      attribute-set: assoc
> > +      do:
> > +        request:
> > +          attributes:
> > +            - dev-id
> > +            - version  
> 
> Version must be the same for rx and tx alloc. It is already set for
> rx, so no need to pass explicitly. Just adds the need to for a sanity
> check in the handler.

I think because version implies the key size. No strong preference but
without the version it's harder to split the request processing into
pure parsing and operating on kernel objects (under relevant locks).

