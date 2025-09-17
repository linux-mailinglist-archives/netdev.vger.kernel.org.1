Return-Path: <netdev+bounces-224058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A55BB8052C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2425D3BE722
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44132E745;
	Wed, 17 Sep 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEFR27Gz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E032E751;
	Wed, 17 Sep 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120888; cv=none; b=KpagI1MfAgp6JXFUKPLj5vWZi9kk6u0GcMYI5AR81YllUoPSEWe0OZ5fS3yJNG414qidqViK9zyIsdxRoiV3fHga+7aZ0HxdOPrplbGZXYLFgLF/OrYByD3D+OXGrvALxiEPGrSe67iwYWoBCY8tYu2zYidiyo00uwgy+rscmp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120888; c=relaxed/simple;
	bh=tIoFj35d9AiZIRV4c88VMwpWprmFWHS7koL+OfmSgE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi8MtHd8okcGVpwbFepkS+9BChMHaxCxmzxJM4JKcraRlomO2OXZ7jzNQYxZ/NAMn4UoJNoBjHX9nu7hl2OpaSMmPADtwgZFVQslXUZ6ZKlr96fz6ctXIaA8UA5KsbI3ll5os/evgiK+2i2SxVpP96sPs+ElJrqvJkFchIVqpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEFR27Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE424C4CEE7;
	Wed, 17 Sep 2025 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758120888;
	bh=tIoFj35d9AiZIRV4c88VMwpWprmFWHS7koL+OfmSgE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEFR27GzdFQz0RZxNjRtOzD1GE2CAtj7MNWO4v+zEUFNBFIyMkh/1D4Ck7i3PbssT
	 1oWPBHhoLU8olr/yuyKulfA+ZLPpcEh59MbQfFTiVVwVHGMSlNB6Nlc5we6J16Fk/H
	 fTajVaAz+J44hqSONlq/EBVkDZgxds4Eo2O+hSuV+EqwfqKH7MXLmUV2CCViRD6gHZ
	 26dZdyig0w/6XkU2HK37GlHt2Rj4LwCBjdY+LJttd16znQmZ4U+Q5zS/bQ4GcWDmms
	 LxdnjFsGDFEGj/GorHltWfAHwNiibuLcR5D2CEv+HSl1XnGmA5aAT8fbhwXW3SpuFb
	 gamFhbK1YWXmg==
Date: Wed, 17 Sep 2025 15:54:43 +0100
From: Simon Horman <horms@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Piotr Warpechowski <piotr.warpechowski@intel.com>,
	Karol Jurczenia <karol.jurczenia@intel.com>
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: enhance VLAN protocol
 detection for GRO
Message-ID: <20250917145443.GN394836@horms.kernel.org>
References: <20250916124808.218514-1-konrad.leszczynski@intel.com>
 <20250916124808.218514-2-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916124808.218514-2-konrad.leszczynski@intel.com>

On Tue, Sep 16, 2025 at 02:48:06PM +0200, Konrad Leszczynski wrote:
> From: Piotr Warpechowski <piotr.warpechowski@intel.com>
> 
> Enhance protocol extraction in stmmac_has_ip_ethertype() by introducing
> MAC offset parameter and changing:
> 
> __vlan_get_protocol() ->  __vlan_get_protocol_offset()
> 
> Add correct header length for VLAN tags, which enable Generic Receive
> Offload (GRO) in VLAN.
> 
> Co-developed-by: Karol Jurczenia <karol.jurczenia@intel.com>
> Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
> Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>

Hi Konrad,

As you are sending these patches, your Signed-off-by line is needed.
I would suggest at the end of the tags. And when present,
you can drop your Reviewed-by tag (it is implied).

Otherwise this patch looks good to me.

Same for the other patches in this series.

-- 
pw-bot: changes-requested

