Return-Path: <netdev+bounces-223520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA6B59650
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C790316586D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736E2D7803;
	Tue, 16 Sep 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOCdmxqv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A712D47EA
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026191; cv=none; b=tmpVPQ7MLhUayDajuW5H4aG7rmNwp7DVs/G5pMOeTV5/1boKHg20q627AgW6gGmgJVg8nN7tzEBl++Kgj2OsxwEVUCDE3MZq0G8UUBSBLLhfCRb2/vt4CuFRRWPAfh/gxSR3Gg0Rty3d5M0kDk5x0QN8YVx3luvVIU+TObui/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026191; c=relaxed/simple;
	bh=keO2kIrkBOHJeDQkyZ5lo+txN/YCikPFzx0QQyGzK+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiCIny3AI26vBAJSsCHxj0SH8StY1wFfiHUzScl+MlxL8oPDnwzZ2i/J+EbEjohou2sahvKp2SwmZeDhIM6g2EO8CgDNzz5V8GGxZKcJVPxYCV41QY2Jwno3Ve/LpbHnhsOF9QUmE8p+N9eRH7zLKrLh7Tsedv3nqz7325/ec/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOCdmxqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4368CC4CEEB;
	Tue, 16 Sep 2025 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026190;
	bh=keO2kIrkBOHJeDQkyZ5lo+txN/YCikPFzx0QQyGzK+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOCdmxqvj/FHaBLLlyynPUENogO9Y+o8XJhHX2clXJHdMBsGmpcuLH7xaLETa3QUc
	 Ksenk2HPI5tE7P1UsodfZ82a3/3sU2n6ifjI7J3azqjf/2l8W6u3rmDJUFmUlkvnDj
	 4uQvioBpaJT1M5ZKjzXXh0NisXwY8lzEo5JWtJ8oPaPF/atTldNeA5Bv3wci2/OXUV
	 bMkGiAOyAeeg6AiCMP2/SSaQ5k7DaHcInBx9iE6LZ5Ba+ZwJeB/hY3yDBGDFNXm9hA
	 OOoq41oMOyo2zNXxDjTl1aqeffAePV7aY+V3Prr57n3/8BttLLKOxvmZpONSvWBnf5
	 KaNv7gb9Cdqjw==
Date: Tue, 16 Sep 2025 13:36:27 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 5/9] eth: fbnic: support allocating FW
 completions with extra space
Message-ID: <20250916123627.GD224143@horms.kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155312.1083292-6-kuba@kernel.org>

On Mon, Sep 15, 2025 at 08:53:08AM -0700, Jakub Kicinski wrote:
> Support allocating extra space after the FW completion.
> This makes it easy to pass extra variable size buffer space
> to FW response handlers without worrying about synchronization
> (completion itself is already refcounted).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


