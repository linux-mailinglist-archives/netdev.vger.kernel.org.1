Return-Path: <netdev+bounces-241466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C4C8432D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABCE14E323E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B828265CA8;
	Tue, 25 Nov 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gqVy8eVt"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC326056C;
	Tue, 25 Nov 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062534; cv=none; b=IOVRMPfIDIjIKMcEGKoVL8bl4I7GdS/2mqvt6AOXItKXNWozQTV+tmw/slJ23Q9DaZopqiHLL1P/cOIdbZlZYhYSAiQib08RwhDCUik6wAsCWanRaWChQ+2YeSEqmTvG5Bt4jXE7ZtQeIuS+pL/KoyQ0TPcZDszynnl2SpsnfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062534; c=relaxed/simple;
	bh=iCyFu6epPp6w+mMk0188l9kovrHWn2f2cYn3rjhEeZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYBQqyDXQgO/NDtNmi+s+DGq3gSD1wnsdf/OcWsohFHXGLmIiHfWYTeVm4uDfrAXpvknHIncQd2VJYAioE4zatnBhUzCXiTyuRG5HrBgeqm7EZKku+CuyCK0WXRPmP5w9G7DIyAseyj2YPDqY4vsekJAsPe5F+K7Kr8A3qCm1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gqVy8eVt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2soozzHloM/2VQ/EZFmFRTlOlMJYt9spKgkbfCydm/U=; b=gqVy8eVtWsiaoaIrVDaZkniqMG
	zvT1QkUs6fIrS6Ak6gUIb0llJy5z5fgRP1SsMovvhPNU65UG+89ewX9vIrhm+xcDVE3/HgktW5T/g
	RqJ94KmosL7SGMNdxlzuwHledUE8VTyoWoxn0BfYXOxNqKp4DheVts6TVBcRixIhN80v8zYmmIvRC
	E2dqqEoAZRGgPn/vIi24dLhDyTuLDNiOOV1wcvlRxCti5Oc/Km8wTnoEmi6iQNfwkG1/MZEDb4vXr
	z8ZSeti1flTE5gZfeBHMhBoBTaq99qPLOk/r1XdKZgUMI7BfJaYi+hkLsTR8qi8J1PdhikiYReTWc
	peJrtz0A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vNpF1-003I0D-TI; Tue, 25 Nov 2025 09:21:44 +0000
Date: Tue, 25 Nov 2025 01:21:38 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com, 
	maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/8] i40e: extract GRXRINGS from .get_rxnfc
Message-ID: <nmwkbxjlrgr5daekzutw7juzgdvfop7zbvmsp7wkqr3qfqiys5@li537s2e43zi>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
 <20251124-gxring_intel-v1-1-89be18d2a744@debian.org>
 <20251124194823.79d393ab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124194823.79d393ab@kernel.org>
X-Debian-User: leitao

Hello Jakub,

On Mon, Nov 24, 2025 at 07:48:23PM -0800, Jakub Kicinski wrote:
> On Mon, 24 Nov 2025 10:19:05 -0800 Breno Leitao wrote:
> > + * Returns the number of RX rings.
> 
> I suspect you used this format because the rest of the driver does,

Correct. I have jsut followed the other kdoc format in the code.


> but let's avoid adding new kdoc warnings. I think Andy is trying
> to clean up the "Returns" vs "Return:" in Intel drivers..
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3530 No description found for return value of 'i40e_get_rx_ring_count'
> 
> (similar warnings to first 4 patches of the series)

Ack! I will get them fixed.

Thanks for the review,
--breno

