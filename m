Return-Path: <netdev+bounces-136171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A999A0C5E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93571F2489A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFB81D1740;
	Wed, 16 Oct 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Che9ZTe0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EB1494CC;
	Wed, 16 Oct 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088241; cv=none; b=tXCvPeDwEIQQDQxdk5Bba8i6LgRyJpUVse+Io9jXwezbvhGwbyIh8xi5vdpTIVaSPRwikgDgmIFjCINbWUnDNjVAcC/+e5UvL7sjxTklK/nGsCkTZxeqqkMSyfNj6LULdk6O8Prk6HrIgQkLxtNB8vJNuQMTgpD5qcsHN44R2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088241; c=relaxed/simple;
	bh=xvD0EGIlA23nJe+ETgrqTCv8spRK9sqdryQTaYwbPe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl9pSA3RGM+0gJEQDSELjyqarLfKTOw7n4EgW0N8ZmAMIc6f3zGdXcT64EBZiK4mh0qak4KxtqUuhSn+peyahY7W21xvpiarYTHpl4cTpfLww8FPaUdlNrRBy+i7lyvElfo0xpRhCKTmYqbFxiNOZcQHrypOQODEwRRjBX+tbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Che9ZTe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDEC4CEC5;
	Wed, 16 Oct 2024 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088240;
	bh=xvD0EGIlA23nJe+ETgrqTCv8spRK9sqdryQTaYwbPe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Che9ZTe0y868yFLJ7Yq2FLCfwnzruS+q+UMoHXrFDUL2yTI9P5tjg6MxCcayTTwVz
	 JRihxVb/WGD25c/VayBpzr/R2no38EsBzMneisUa4g4gT/lLwmwuAjXaGU2kPDcSUj
	 IULsR7ZSm4dSV0GLTLEft36j7i2pn5PV0OC/a9s79hRLEcsQMuHdHq9bFUQkrRrkAw
	 tQ/aPVwNRLaw4ZCRprft1qx6CShDjpjdF0jRR5fIzaskNOsgB2iuMzHYLB7AOsti3+
	 yfiRcZaW4WX2zy3iaHzURerzYv26CTuBeXV0lKCP6EkQFDFgDYFpf6OcI7A2V9MD7F
	 ApPVP4W5IetiA==
Date: Wed, 16 Oct 2024 15:17:15 +0100
From: Simon Horman <horms@kernel.org>
To: boehm.jakub@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] net: plip: fix break; causing plip to never transmit
Message-ID: <20241016141715.GH2162@kernel.org>
References: <20241015-net-plip-tx-fix-v1-1-32d8be1c7e0b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-net-plip-tx-fix-v1-1-32d8be1c7e0b@gmail.com>

On Tue, Oct 15, 2024 at 05:16:04PM +0200, Jakub Boehm via B4 Relay wrote:
> From: Jakub Boehm <boehm.jakub@gmail.com>
> 
> Since commit
>   71ae2cb30531 ("net: plip: Fix fall-through warnings for Clang")
> 
> plip was not able to send any packets, this patch replaces one
> unintended break; with fallthrough; which was originally missed by
> commit 9525d69a3667 ("net: plip: mark expected switch fall-throughs").
> 
> I have verified with a real hardware PLIP connection that everything
> works once again after applying this patch.
> 
> Fixes: 71ae2cb30531 ("net: plip: Fix fall-through warnings for Clang")
> Signed-off-by: Jakub Boehm <boehm.jakub@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


