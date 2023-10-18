Return-Path: <netdev+bounces-42078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1667CD159
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A9C280FE3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18D8F44;
	Wed, 18 Oct 2023 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sczVb/vv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C288F41;
	Wed, 18 Oct 2023 00:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75D7C433C7;
	Wed, 18 Oct 2023 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697589290;
	bh=s4c03elfdERBy4zrtDjx6kCMTKW/KWYHfHp4XQimaus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sczVb/vvpGtFXEO6D/aIRYs6n+ceGsHSEAVInJOS4taE/yqBzcR7cEMIqfeEVMzdM
	 Jgxk85NBx9FHN/Rac39XbEFHtqeXPl7CJ/T5L1Nck9hjW9I4goczq3S+81K6XN/XS/
	 cMqi0l/3qiDUf4UbOedAOOwY6Amm9U/Uvma2dzr0Q5RZPnPCwo6qomMiloQB7EzWMg
	 +M9ipIhle6TQmYJJ8rt5Gccm3F6Mz0InbfExeduA0vZiVd2ff7jlwPyP/q5JBAbA+T
	 AvypWJ1+EklpA2wbdzRXaIzVj/+P+S7VBcos/cnI9wsZal3ZUNex4+vKiNk1Q8ci3Z
	 T8QBNTWEKNIcA==
Date: Tue, 17 Oct 2023 17:34:48 -0700
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
Message-ID: <20231017173448.3f1c35aa@kernel.org>
In-Reply-To: <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231016154937.41224-2-ahmed.zaki@intel.com>
	<8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
	<26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
	<CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
	<14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
	<CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
	<20231016163059.23799429@kernel.org>
	<CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
	<20231017131727.78e96449@kernel.org>
	<CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 13:41:18 -0700 Alexander Duyck wrote:
> I am thinking of this from a software engineering perspective. This
> symmetric-xor aka simplified-toeplitz is actually much cheaper to
> implement in software than the original. As such I would want it to be
> considered a separate algorithm as I could make use of something like
> that when having to implement RSS in QEMU for instance.

That's exactly why XOR and CRC32 _algorithms_ already exist.
CPUs have instructions to do them word at a time. 

	ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function -
	Toeplitz */
	ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
	ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32 */

If efficient SW implementation is important why do some weird
bastardized para-toeplitz and not crc32? Hashes fairly well
from what I recall with the older NFPs. x86 has an instruction
for it, IIRC it was part of SSE but on normal registers.

> Based on earlier comments it doesn't change the inputs, it just
> changes how I have to handle the data and the key. It starts reducing
> things down to something like the Intel implementation of Flow
> Director in terms of how the key gets generated and hashed.

About Flow Director I know only that it is bad :)

