Return-Path: <netdev+bounces-32158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623EA79320B
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 00:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E372813F4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA8DF62;
	Tue,  5 Sep 2023 22:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20BA53
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 22:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C34C433C7;
	Tue,  5 Sep 2023 22:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693953455;
	bh=d/sh29sVp2yI2/siIM8XCjBscl+j38GKqXME3fu5YvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kh4jroAUW2f1qvlnwj4WeBxWI2n219TB2O1eH9OphP/wrAwo8k7HuL9l6nRqfPltG
	 Wk3jNFruqzyhYPFQ0WGrqJ3OqwgVPWcTnuUrq1l/dlBrakrxZVz73ry9u9mZz5SrLB
	 ojqLy/sbP5vLD+d2Wz9miV5SX+iHReYeuytslWSsInrSgMCAbx4EnEsrt8TYom0Qnt
	 A8LGCe2gQYlZtyuhq5CSFHrd6iDigSgI1dOPzDeKTKsvIKXAm0Rpax8vQIBWBA1c/P
	 ffcHajG8WeB7U5e+k/UY7Oq/QPBiMhk5Pk/STwd98fZAIcsvP4HKDX6Ihta5+qEf+C
	 iQKsW7c+8YbUA==
Date: Tue, 5 Sep 2023 15:37:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
 qi.z.zhang@intel.com, ivecera@redhat.com, sridhar.samudrala@intel.com,
 horms@kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com
Subject: Re: [PATCH iwl-next v9 00/15] Introduce the Parser Library
Message-ID: <20230905153734.18b9bc84@kernel.org>
In-Reply-To: <20230904021455.3944605-1-junfeng.guo@intel.com>
References: <20230904021455.3944605-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Sep 2023 10:14:40 +0800 Junfeng Guo wrote:
> Current software architecture for flow filtering offloading limited
> the capability of Intel Ethernet 800 Series Dynamic Device
> Personalization (DDP) Package. The flow filtering offloading in the
> driver is enabled based on the naming parsers, each flow pattern is
> represented by a protocol header stack. And there are multiple layers
> (e.g., virtchnl) to maintain their own enum/macro/structure
> to represent a protocol header (IP, TCP, UDP ...), thus the extra
> parsers to verify if a pattern is supported by hardware or not as
> well as the extra converters that to translate represents between
> different layers. Every time a new protocol/field is requested to be
> supported, the corresponding logic for the parsers and the converters
> needs to be modified accordingly. Thus, huge & redundant efforts are
> required to support the increasing flow filtering offloading features,
> especially for the tunnel types flow filtering.

Are you talking about problems internal to ICE or the flower interface?

> This patch set provides a way for applications to send down training
> packets & masks (in binary) to the driver. Then these binary data
> would be used by the driver to generate certain data that are needed
> to create a filter rule in the filtering stage of switch/RSS/FDIR.

What's the API for the user? I see a whole bunch of functions added here
which never get called.

> Note that the impact of a malicious rule in the raw packet filter is
> limited to performance rather than functionality. It may affect the
> performance of the workload, similar to other limitations in FDIR/RSS
> on AVF. For example, there is no resource boundary for VF FDIR/RSS
> rules, so one malicious VF could potentially make other VFs
> inefficient in offloading.
> 
> The parser library is expected to include boundary checks to prevent
> critical errors such as infinite loops or segmentation faults.
> However, only implementing and validating the parser emulator in a
> sandbox environment (like ebpf) presents a challenge.
> 
> The idea is to make the driver be able to learn from the DDP package
> directly to understand how the hardware parser works (i.e., the
> Parser Library), so that it can process on the raw training packet
> (in binary) directly and create the filter rule accordingly.

No idea what this means in terms of the larger networking stack.

> Based on this Parser Library, the raw flow filtering of
> switch/RSS/FDIR could be enabled to allow new flow filtering
> offloading features to be supported without any driver changes (only
> need to update the DDP package).

Sounds like you are talking about some vague "vision" rather than 
the code you're actually posting.

Given that you've posted 5 versions of this to netdev and got no
notable comments, please don't CC netdev on the next version
until you get some reviews inside Intel. Stuff like:

+#define ICE_ERR_NOT_IMPL		-1

should get caught by internal review.

