Return-Path: <netdev+bounces-140838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C689B8743
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3741C21178
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619971E2007;
	Thu, 31 Oct 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNgddRfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8261E32C9;
	Thu, 31 Oct 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730418988; cv=none; b=iBgvd1VbLftEgj8jHc0R1nyfwWctEt7Oxlji/wCpi+BnPBX5BR780jL/h8Zd7t//D0F2q2OP5zKXcvRpjeyqYB/ztGlqzSzIuEEOPaxlkSPKjgpbg9qV7uO14lfndzCFvsRJTjqKcKXuZ04YnuSk6lHvK2FgcOF0G/YOo9g3QFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730418988; c=relaxed/simple;
	bh=+CgojspNnngKYe7U1Hu5cFQ3thdG7/LYHxt6PHnK0Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEgricUe19gbY5DRTthhmZt85mr/1bYvHbCt37L0zQ9UtaSUdAjd7+cmWmuSsvO3wkHIuVxW/241MMrk7IAhEd8JMQMreudayd+0tJxdtIxedfqjNLy4Z5DY3cjJSx1x5t93cMCwsmF2AZ4AbqQ5WjlrIPahg+exq82jBN2bN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNgddRfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709A7C4CEC3;
	Thu, 31 Oct 2024 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730418986;
	bh=+CgojspNnngKYe7U1Hu5cFQ3thdG7/LYHxt6PHnK0Sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNgddRfJguCLziHbvj0yY8QnwHXkouu85EilkIoiOVY4bWNOCPjB6Gjg55l0x0Eoq
	 QfpXmaZtKL95yd2cdzVRVBXgAsTyMaXIqNtOrx+UAranAIxs+uIxbM0+mERTIXKdUL
	 xtmhb6SiAmTg0HhXm+zTn29xvmGHJkg3YlQyyZkGTjF3TsW5E7xZSFXdQ4JjeeakzJ
	 iEa8tL+vZ0cfeOusE0jREWkJSl5LA+JevLy57syxfsmn5M3YstF+S16sWkD/x7Zaqm
	 9mq7yQaOzpoRUoARQ6qsADIFQrRrtuXHbRYrpg0PKFua8JSH7NxihW4a8idurD9zEO
	 Y6A5eydKutIRA==
Date: Thu, 31 Oct 2024 16:56:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 2/7] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241031165624.5a7f8618@kernel.org>
In-Reply-To: <CAMArcTVXJhJopGTHc-DqK1ydCkaQj5-VRGoJ-saGNGeTLXZHcw@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-3-ap420073@gmail.com>
	<20241008111926.7056cc93@kernel.org>
	<CAMArcTU+r+Pj_y7rUvRwTrDWqg57xy4e-OacjWCfKRCUa8A-aw@mail.gmail.com>
	<20241009082837.2735cd97@kernel.org>
	<CAMArcTVXJhJopGTHc-DqK1ydCkaQj5-VRGoJ-saGNGeTLXZHcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 02:34:59 +0900 Taehee Yoo wrote:
> While I'm writing a patch I face an ambiguous problem here.
> ethnl_set_ring() first calls .get_ringparam() to get current config.
> Then it calls .set_ringparam() after it sets the current config + new
> config to param structures.
> The bnxt_set_ringparam() may receive ETHTOOL_TCP_DATA_SPLIT_ENABLED
> because two cases.
> 1. from user
> 2. from bnxt_get_ringparam() because of UNKNWON.
> The problem is that the bnxt_set_ringparam() can't distinguish them.
> The problem scenario is here.
> 1. tcp-data-split is UNKNOWN mode.
> 2. HDS is automatically enabled because one of LRO or GRO is enabled.
> 3. user changes ring parameter with following command
> `ethtool -G eth0 rx 1024`
> 4. ethnl_set_rings() calls .get_ringparam() to get current config.
> 5. bnxt_get_ringparam() returns ENABLE of HDS because of UNKNWON mode.
> 6. ethnl_set_rings() calls .set_ringparam() after setting param with
> configs comes from .get_ringparam().
> 7. bnxt_set_ringparam() is passed ETHTOOL_TCP_DATA_SPLIT_ENABLED but
> the user didn't set it explicitly.
> 8. bnxt_set_ringparam() eventually force enables tcp-data-split.
> 
> I couldn't find a way to distinguish them so far.
> I'm not sure if this is acceptable or not.
> Maybe we need to modify a scenario?

I thought we discussed this, but I may be misremembering.
You may need to record in the core whether the setting came 
from the user or not (similarly to IFF_RXFH_CONFIGURED).
User setting UNKNWON would mean "reset".
Maybe I'm misunderstanding..

