Return-Path: <netdev+bounces-233622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E2BC16695
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BD40355B4E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86234F498;
	Tue, 28 Oct 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBDUB+pC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B834F497
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675168; cv=none; b=gah31l2eGFE8iwFmeKioEJZfVi8svZkgw+eB/dEM3CUz7XckdfTsbwjRzBL4jlNPTvYZQDLz5JkOxQI6snRltipe+S33YVG8G7wd2601hnwAaZMIy/a2puJllROk9AWCTCpibC2wkui6g1ItazXHgDumPvSndlBFUr2WAgzkEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675168; c=relaxed/simple;
	bh=rMFZ5kQBLZhjQxuEnEYZtqELf662NSTEeOQnwo23CPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p23GGmYrQD9oOfEZ7OAUA/xnZw4KZAlPBFFelRaUFfBc7lldj1iABFEqcn1L/IgY+6ryi1GudnCZGaRyVFTFnEOJ77nJMuHvzahaJ0iI8g75P7LdVP0Uz+LhHZmfGShiuyQ4TNfZhxKTWJMXvEzWsavT7YHS5HnyME03tGdsC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBDUB+pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ABAC4CEE7;
	Tue, 28 Oct 2025 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761675167;
	bh=rMFZ5kQBLZhjQxuEnEYZtqELf662NSTEeOQnwo23CPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBDUB+pCEnZzSnEulSKLJd5xLkpkam7tch3J864WTz3dc3AiW+jO8bM/LRk4TVF2d
	 d6Zj/3wg5hJRFgOooPvWHcEzDIe/MmxyBuqAOdJud5piZuGI7SLqXBXhMnmayddjoS
	 ooJgNPN5RewCOM0n0eYeEFb4kKTktbiIhG745BeHhFFrW/fJkUjxkm28lZTnUteTPs
	 pibwu/zJuI+a8x9CBcuDKfXCwfF6njKN+7wFbFbiar3cYwbC9kSffMozakhmUtm723
	 mlPz1kaZuGy40T+J5tJuNshycy6DIz0zfNQzpjE34EhJmdymoDJmgas0ErwDoVqtte
	 +JxzPJs3zW32w==
Date: Tue, 28 Oct 2025 18:12:42 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v1 3/3] igc: allow configuring RSS key via
 ethtool set_rxfh
Message-ID: <aQEHmm4YmzBHTIUb@horms.kernel.org>
References: <20251025150136.47618-1-enjuk@amazon.com>
 <20251025150136.47618-4-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025150136.47618-4-enjuk@amazon.com>

On Sun, Oct 26, 2025 at 12:01:32AM +0900, Kohei Enju wrote:
> Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> RSSRK registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


