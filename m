Return-Path: <netdev+bounces-223115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF4B57FEF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF93BC04C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338833EB0F;
	Mon, 15 Sep 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9GlCNMm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799AD33A00A;
	Mon, 15 Sep 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948758; cv=none; b=EG3ZJsJJClx5Ce+WNThz+yK+FrjO9JqkM3MEAeq1N4jow9fXnPxQJ9n8cZGBemlFXXJoMTBcM8oBhaFxD+Ks+0vMgmjM95v/LvUvjCJzCTw7dkN9dn+S0tPJ1F913oxeKOYwd/9sZOTklg5s0WeJw1Vhb6VKUxLSlg1DuaILCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948758; c=relaxed/simple;
	bh=IL/HPOtD60ztlstGGOqnCC4OEnR3kcItwqkiKqfFY/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uY+blF16v+KfpcPLcYK0kHgpNwKfbXuxCcj4iM0DV6O/vdqDBpl4u2crjecrGN2NOI6L0iN3/JjBRPin6awDaaCRLptc9GgCzloCH+JYFQgs90oGGwxgbFnui0IxjQYVxcXgKhZWFydyrET73k8u4YTa8uXLv0SjcyGr0kDYqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9GlCNMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2A4C4CEF1;
	Mon, 15 Sep 2025 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948758;
	bh=IL/HPOtD60ztlstGGOqnCC4OEnR3kcItwqkiKqfFY/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J9GlCNMmpkI7UB5BpO6lNJVRF2sv8i8Bw0ecIYj5TKX3epJ2VD6L6+x5s2b6zTntM
	 TxnV4OmL7pZwv6kI5SJlsZDF3ug2yMxjjD/Cv9S6S77Sy4yUV7CUcWwsjyTNY3XnJA
	 IIQ6uoqdJIWE8nmnllu54YTL/gxPTd+qF5oVLF7QSVKkdkX5S093263tY4YUYvEVwN
	 iMWOSvpWMiXgx8UPpsQMYw49WpzDckgfilDDMh6x00fOLtzE2JoYTmpEFDaqhhnAzO
	 yvBPFRlLBPIM9q/M9ZRCesxN1cHNyC8UQdrN5GAU8GRK5KGvu8XbY40xsjRQ9RiAFw
	 7IQEV+5xjPrpA==
Date: Mon, 15 Sep 2025 08:05:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: Sebastian Basierski <sebastian.basierski@intel.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>, "Piotr
 Warpechowski" <piotr.warpechowski@intel.com>
Subject: Re: [PATCH net 2/3] net: stmmac: correct Tx descriptors debugfs
 prints
Message-ID: <20250915080556.0984a051@kernel.org>
In-Reply-To: <2a0b4669-0867-4d8c-a88d-22df714608e5@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
	<20250828100237.4076570-3-konrad.leszczynski@intel.com>
	<20250901130100.174a00f6@kernel.org>
	<40c931b2-f565-478b-8900-1a6aad6d9e0c@intel.com>
	<2a0b4669-0867-4d8c-a88d-22df714608e5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 14:54:55 +0200 Konrad Leszczynski wrote:
> Would it be ok to remove "net: stmmac: correct Tx descriptors debugfs 
> prints" from this patchset and add it to already existing one for the 
> net-next changes as next version?
> 
> https://lore.kernel.org/netdev/20250828144558.304304-1-konrad.leszczynski@intel.com/

Yes, but to be clear you need to repost with the appropriate patches 
in the series..

