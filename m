Return-Path: <netdev+bounces-209370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD618B0F66F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465A9AC5B17
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2692FD874;
	Wed, 23 Jul 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU4unhE+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC692309DA4;
	Wed, 23 Jul 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282508; cv=none; b=qZeYQOxcgt7NrJNXJ3oRygcukI0vYZecyfLw/ouZ8vVQK+5dd4AnE8v8NEf0VMpDl/+kv1G3RA5HwY5xQA+5SiNN+fzenn/eUJ/0FXMvDIm+CjB7DrwS8/dvlnOiTcoWIM2/GfHjX71WeWzQT/Lg8z/9JqiT6MVfF5QDUO/qiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282508; c=relaxed/simple;
	bh=swk2RIvjPbJUxSXUBWA5D9vdXqEHzWOhG365ve/Y97Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjFeZNa31GQ8Q7p3pln8MhFoOcWezrrgcRvag2qfgEU4s40cvsHJOnRHcLdWWrLt5snlMAki1WoRC/8GqY8T/jMhVNX4+TghM4swErCmXyBQ4zWXcotzH37XlrmqGWvD99Kp7uDrquSGJIJIebYP7u8Kw4KlxnJzItmKFcl1WC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU4unhE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11500C4CEF8;
	Wed, 23 Jul 2025 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282504;
	bh=swk2RIvjPbJUxSXUBWA5D9vdXqEHzWOhG365ve/Y97Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JU4unhE+sr6GyfOJjGkf2UPLxubH40Q+QJ5v6P6VX/GAPOQ9u73UpyhascwhuXC67
	 9B39ny9BpBldRVRWEu8ZL7NqnXr3M92rN5yVokOGRSPBTIytk7zG5DCqMrsgFwNx5y
	 UVCJA10UW9Z6xx0l4gO4vbKPJLKlM6fpGOEpPmLo0w/Fjlrml2/MshBuohvMFLj+/X
	 t5rse+XJ9FN++hs6Z86+XoX3251c5JDWyKNXRsAkW9SZsmKIE/IbIF87RAdGUEmX/w
	 Dk9idxf53peal+YpP/U9yvQEmp4WLlPOwkAXC79kbah1K50poZyh0u0toxmU/zEqQ4
	 TiMjuQ44UW1kA==
Date: Wed, 23 Jul 2025 15:55:01 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/5] netconsole: move netpoll_parse_ip_addr()
 earlier for reuse
Message-ID: <20250723145501.GE1036606@horms.kernel.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-2-b42f1833565a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-netconsole_ref-v2-2-b42f1833565a@debian.org>

On Mon, Jul 21, 2025 at 06:02:02AM -0700, Breno Leitao wrote:
> Move netpoll_parse_ip_addr() earlier in the file to be reused in
> other functions, such as local_ip_store(). This avoids duplicate
> address parsing logic and centralizes validation for both IPv4
> and IPv6 string input.
> 
> No functional changes intended.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


