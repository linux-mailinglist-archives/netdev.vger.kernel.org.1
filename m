Return-Path: <netdev+bounces-41610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E3B7CB702
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1228C280F91
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE938FAC;
	Mon, 16 Oct 2023 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR/3zAHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112127EE0;
	Mon, 16 Oct 2023 23:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF2FC433C7;
	Mon, 16 Oct 2023 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697499061;
	bh=nwdQBoh44SzFZ2rYCp83ea7TerdiBs+GYGKIDM09S/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sR/3zAHs90iIH3UGAt+nf8mUNK0JcfcAd6Appi9qlpPZrtS8fuGRSOmrY+oEHir6g
	 5HN+LIFvW/X4MS1PyLdykc9TmMUnJ3TFpU/j53mjExdqeBocAh42VPMeECx6p3QESQ
	 vaExacPpd0zMgg3zQ8uqdJ9wjOsuIZG5C2+AwNIgQw6i0dxevP7EJLj5sxUewVymi6
	 ecJ5nGj1DCx4WFdoOVEHokIPD/aOVbqOJx4/z/mFB83gsnQp1srFho/Mm0G1k0vuo9
	 ZCk+AKToCpvMWmsH4eQXXFzBLQ9bfSS0v/9hjpVM9JfA0WbQJ3ABnX9L8t26oy+0Hg
	 DbweH3VCR7ODg==
Date: Mon, 16 Oct 2023 16:30:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com,
 linux-doc@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
Message-ID: <20231016163059.23799429@kernel.org>
In-Reply-To: <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231016154937.41224-2-ahmed.zaki@intel.com>
	<8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
	<26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
	<CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
	<14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
	<CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 15:55:21 -0700 Alexander Duyck wrote:
> It would make more sense to just add it as a variant hash function of
> toeplitz. If you did it right you could probably make the formatting
> pretty, something like:
> RSS hash function:
>     toeplitz: on
>         symmetric xor: on
>     xor: off
>     crc32: off
> 
> It doesn't make sense to place it in the input flags and will just
> cause quick congestion as things get added there. This is an algorithm
> change so it makes more sense to place it there.

Algo is also a bit confusing, it's more like key pre-processing?
There's nothing toeplitz about xoring input fields. Works as well
for CRC32.. or XOR.

We can use one of the reserved fields of struct ethtool_rxfh to carry
this extension. I think I asked for this at some point, but there's
only so much repeated feedback one can send in a day :(

