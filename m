Return-Path: <netdev+bounces-199963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC4AE28EB
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 14:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864A7188A22A
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7F1862BB;
	Sat, 21 Jun 2025 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGiMFS9K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3091DDE9
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750508030; cv=none; b=uPX/CfHmy8mY0eOgp/HZxC7jHupcoxKHkpFeKcEI8lm18Yk8QY/ur+HS6jqAOj6npeqdOPkiZeqne8zuNuySH94iPo3GKT5GH7eQg0NeytCQPhRfkj7CGXMR38pEjR/eheYhJfBb9wCyy8IW7VefAUaJMZ+g3zKDasOJkju9ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750508030; c=relaxed/simple;
	bh=RAruDr6SBXBNz/lR+POgRgxABSTjO6lM1PMHGV3mfgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtiQAOwIZo3pBrxTs0Hnc0sTu8xn+M4Bg108/Xo8E6dhKbVfEnL31NF/DeG54SomJtqOrZ+iBxWdW6MU+M73GQ5YWigJuSJmlOLVNrZL1vcubRekWagddTPQA92nO6F/RgMNi22fNYS+rSDCZKRyZjHHSSgJcHVle2AxreROQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGiMFS9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C047C4CEE7;
	Sat, 21 Jun 2025 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750508029;
	bh=RAruDr6SBXBNz/lR+POgRgxABSTjO6lM1PMHGV3mfgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGiMFS9Khtj/2vqrD3h9oMuGxs+4QoXV9frEHAr1Qhn0uu0N3hUUn6t1hoA+h4Jm4
	 RufIfRY8I0BfWvK41Oun1LqBzi7/ahPLcfIqIW37rWGNVD/g5pVqrOiNalGOSShLdd
	 o8+4Hp2wzkDmTLIi9PsWAqH+Sn0iTQ6aFJg9lQVabx4Cz+2Ofccld9kEYr2n+NVhvl
	 +kchc8O16Y33Nm4FeVqU1BqxTRT6nbQNU7Cr4Si9XltU9n+P1hyXJ64uDiscB5Nhap
	 RQVICFQiEl3wtB6OQPowJ8WCNxyakS2Xy6BVjnzQ4+h6WAgmXSZY9dfAjTPzhrpowM
	 iwFpdXBIzfZ3g==
Date: Sat, 21 Jun 2025 13:13:46 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: Re: [PATCH iwl-next] idpf: preserve coalescing settings across resets
Message-ID: <20250621121346.GD71935@horms.kernel.org>
References: <20250620171548.959863-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620171548.959863-1-ahmed.zaki@intel.com>

On Fri, Jun 20, 2025 at 11:15:48AM -0600, Ahmed Zaki wrote:
> The IRQ coalescing config currently reside only inside struct
> idpf_q_vector. However, all idpf_q_vector structs are de-allocated and
> re-allocated during resets. This leads to user-set coalesce configuration
> to be lost.
> 
> Add new fields to struct idpf_vport_user_config_data to save the user
> settings and re-apply them after reset.
> 
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Hi Ahmed,

I am wondering if this patch also preserves coalescing settings in the case
where.

1. User sets coalescence for n queues
2. The number of queues is reduced, say to m (where m < n)
3. The user then increases the number of queues, say back to n

It seems to me that in this scenario it's reasonable to preserve
the settings for queues 0 to m, bit not queues m + 1 to n.

But perhaps this point is orthogonal to this change.
I am unsure.

...

