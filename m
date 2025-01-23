Return-Path: <netdev+bounces-160596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C3A1A74A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68923A2097
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147F2116FC;
	Thu, 23 Jan 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6GtRgnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736C288A2;
	Thu, 23 Jan 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647306; cv=none; b=rutjf0s4WpBKLerC2ClFulcc0sE9hs7lClYiKB7epef8vj3RSSr/rxokx1GRMav44Au4kz9/hvxPxgAQ+pJAoJBHHLhfD0fMvOJkSfJNZZ5zIHwfDN1Ab2CugwzRXyI5oNYSAe+0vWZuAAD6RNl0oJL4tG4Lcz4m2JsG3w/DuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647306; c=relaxed/simple;
	bh=k/GgcBQWg18y7s3DiJCfnG3Ph276g1uz2i3hg0odj78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZCffXCdBWewpWHtDmZ7xyepHLulI+yPdexNFPaCOGoG6744hlGRMYBO5hekgwI9qUH+o2qF3NOnNvXIkbVxMFqJG28KDvtSth6mc7WxrJjHvuohVG057si1O/dn5/isb2oM+CirMWq12GcTN9CC6ZQg+J+rQiUlPxWB1uBrO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6GtRgnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE41C4CED3;
	Thu, 23 Jan 2025 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737647305;
	bh=k/GgcBQWg18y7s3DiJCfnG3Ph276g1uz2i3hg0odj78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6GtRgnNFk0MaMfxeSL+iH4xPdCPSn+6PxMnwWzBoCHlShQMNeAc97VjiBfjMo7ux
	 8R+/2niFRx7+uEaaKYx4vDmpzQVPU78ZYym0mTaJ68vcUSwJLvk3KZ+0PvQAVqmkF7
	 rNmB+F8EH1t9Led8mO37Zi4yNDq+NC2VcwcAhDDJp9RVOpXUO3cZXlVhIllogb4z8T
	 ZopnYAxW5l369H12runkvn2kjMjBS+/YyRE5u3fLfjzVg49BU3BNiD34NfrzQSLN6q
	 q5VyiEDnHsU8pga9Gogcw8GAduCbR4dAZOQK3+xr13LbzSf5jJAD4Ky/AYfDPOsHkf
	 V7bQkDUErpV8w==
Date: Thu, 23 Jan 2025 07:48:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Cc: Yonglong Li <liyonglong@chinatelecom.cn>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com
Subject: Re: [PATCH] seg6: inherit inner IPv4 TTL on ip4ip6 encapsulation
Message-ID: <20250123074824.5c3567e9@kernel.org>
In-Reply-To: <CAAvhMUmdse_8GJtn_dD0psRmSA_BCy-fv6eYj9CorpaeVm-H3g@mail.gmail.com>
References: <1736995236-23063-1-git-send-email-liyonglong@chinatelecom.cn>
	<20250120145144.3e072efe@kernel.org>
	<CAAvhMUmdse_8GJtn_dD0psRmSA_BCy-fv6eYj9CorpaeVm-H3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 11:20:05 +0100 Ahmed Abdelsalam wrote:
> This patch is not RFC complaint. Section 6.3 of RFC 2473 (Generic Packet
> Tunneling in IPv6 Specification) discussed IPv6 Tunnel Hop Limit.
> The hop limit field of the tunnel IPv6 header of each packet encapsulated
> is set to the hop limit default value of the tunnel entry-point ode.
> The SRv6 RFC (RFC 8986) inherits the tunnel behavior from RFC2473l

I see. I think this information would be good to have in the commit
message. IIRC we do inherit already in other tunnel implementations, 
ideally we should elaborate on precedents in Linux behavior in the
commit message, too.

reminder: please don't top post on the list

