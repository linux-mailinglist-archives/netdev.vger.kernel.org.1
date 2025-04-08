Return-Path: <netdev+bounces-180380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DEA81297
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25B47A565E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F5E22DF8E;
	Tue,  8 Apr 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTeaimiG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663922D4E3
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130443; cv=none; b=blTYE5SSloh11gaQiFYMk+0Vr2PEIsR8wJ+KoYlbKmPS9ghzdpIeeAoxU55Q1IwBWQqpz1jzfsDrtvnlb2H0jeEoV8aiWAqog8oJL6YCCtVsPi4V+EpEELoJV9WnolHWYub/IKev0JjG9UlbNdxATWzPoroRVVREjdHlIyCh0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130443; c=relaxed/simple;
	bh=ifkmDg9EAW9rlTsITEIFc9RI+MtlN1jgiRqQYpanbY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIrt3yeSQ9nh8Yzb7nzblgJQ/Ovc5PcTSShnkG7Kre63I/qyfuO3kWxUcQpRFUgLYV7EJbTb3sjyoxFjK2oGN3x7bGzeZbJc6gcqXXOEXo9nuZe7G7SiCRJZab8b4B3T5qNlQXOtZlPqdW938F9BejxDShfWakouytDqz1HCh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTeaimiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB33C4CEE5;
	Tue,  8 Apr 2025 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130443;
	bh=ifkmDg9EAW9rlTsITEIFc9RI+MtlN1jgiRqQYpanbY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTeaimiGrj+jjOS8dAQlAfIoFZnQZAjPA0fRh3jfr/vGJDeNeApEF31mJhYAMzQqL
	 exAmcHT1H+1grsjrGjkaspVMB84hFN68wH6PqjeKAAiuy1RB/Pe2x/o+ypgJoVy4ZX
	 9xGLZLgPqm3JW1w+bAz3ea41NxJ+SVivjKbXo/fpyhbFCaQv+V6n6zK/qt6pMUq99f
	 Vi1K8uCzztamv3XGrvKyCeJr1EpH5vt+x68/cgsZV1PZ8Bi5bnjPYK7PJKvRpAZXLd
	 q+YmViQJgdT4vGoISHlqRpcbuToGdZIGYFkSzfANYbfFO8vrSBE0Vls8s40pKNXesr
	 wFo21S51/KYeg==
Date: Tue, 8 Apr 2025 17:40:38 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, suhui@nfschina.com, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 1/5] eth: fbnic: add locking support for hw stats
Message-ID: <20250408164038.GA395307@horms.kernel.org>
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
 <20250407172151.3802893-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172151.3802893-2-mohsin.bashr@gmail.com>

On Mon, Apr 07, 2025 at 10:21:47AM -0700, Mohsin Bashir wrote:
> This patch adds lock protection for the hardware statistics for fbnic.
> The hardware statistics access via ndo_get_stats64 is not protected by
> the rtnl_lock(). Since these stats can be accessed from different places
> in the code such as service task, ethtool, Q-API, and net_device_ops, a
> lock-less approach can lead to races.
> 
> Note that this patch is not a fix rather, just a prep for the subsequent
> changes in this series.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


