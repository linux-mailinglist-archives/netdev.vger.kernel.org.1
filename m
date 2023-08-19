Return-Path: <netdev+bounces-28997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1E7815F2
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC821C20BC6
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99691366;
	Sat, 19 Aug 2023 00:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEA1362
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE14C433C8;
	Sat, 19 Aug 2023 00:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692403283;
	bh=TNnJCR7H2u9d0WoXjEcTwXV9cFiwe3jPQqK/BsDpMdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aScq1FfBE3VECD8lOyH9qi7HrQRgFKnJ46rhCwr6E6Od4M7+ZqpllEjInTI3ZvfGA
	 RVO4UTTG4Alol5Mq4uy4Sif2S0wJ/tWiG4OZN2D0RqrYIfKAUL7X8n0vhdybxhaRHU
	 l6yUWaizOe+XCfq1UsGikCjzozrgMzwDtoZC4x19/9y7y0LfX/lCn3zF13B16Ruzcr
	 y+Dxc39i3CCYQWhPf8en1JLJep0nQsTJMRdikwEaXI0KX3yxaGvk180ZRjGbCjos5+
	 GsJ5X3kYK3e6op5hxwrn8vivCCHbZZsgXDffyU3Cuh3YObSZaUUgmZCH6WnnbEYrNA
	 Q/ch80amiOVwg==
Date: Fri, 18 Aug 2023 17:01:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, Alan
 Brady <alan.brady@intel.com>, <pavan.kumar.linga@intel.com>,
 <emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
 <sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
 <sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
 <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
 <simon.horman@corigine.com>, <shannon.nelson@amd.com>,
 <stephen@networkplumber.org>, Alice Michael <alice.michael@intel.com>,
 "Joshua Hay" <joshua.a.hay@intel.com>, Phani Burra
 <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 14/15] idpf: add ethtool callbacks
Message-ID: <20230818170121.3112bb0a@kernel.org>
In-Reply-To: <53a996f1-402e-dea8-9c08-51b84d02d0ac@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-15-anthony.l.nguyen@intel.com>
	<20230818115824.446d1ea7@kernel.org>
	<53a996f1-402e-dea8-9c08-51b84d02d0ac@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Aug 2023 00:42:56 +0200 Przemek Kitszel wrote:
> I see that here we (Intel) attempt for the first time to propose our 
> "Unified stats" naming scheme [1].
> 
> Purpose is to have:
> - common naming scheme (at least for the ice we have patch ~ready);
> - less "customer frustration";
> - easier job for analytical scripts, copying from wiki:
> | The naming schema was created to be human readable and easily parsed
> | by an analytic engine (such as a script or other entity).
> | All statistic strings will be comprised of three components:
> | @Where, @Instance and @Units.  Each of these components is separated
> | by an underscore "_"; if a component is comprised of more than one
> | word, then those words are separated by a dash "-".
> |
> | An example statistic that shows this is xdp-rx-dropped_q-23_packets.
> | In this case the @where is xdp-rx-dropped, the @instance is q-32 and
> | the @unit is packets.

That is one of the two main problems with the ethtool -S stats,
everyone comes up with new "common" standards, endlessly.
Queue the "Standards" xkcd.

Once we have a netlink GET for queues we can plonk the per queue stats
there pretty easily.

