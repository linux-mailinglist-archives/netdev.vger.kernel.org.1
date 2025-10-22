Return-Path: <netdev+bounces-231689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30EBFC987
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 084C94E82FB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC822A7E9;
	Wed, 22 Oct 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+h/Ls+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62B35BDC8
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143920; cv=none; b=aJgLyMOJY2rjvSwdG1vMIY04NUJMJgoVrMgdzSBi1nZlX/JDE6wQWTmugcNmZCohGy9S0whz1dDLl/qwi39W93T6GXKOAL2vgifXo6Hn9dZxdoI18SzKVla2BduBf6ySdfQGbegi3M54dXABENg2l+RFTmlQntk19oEH8BfC5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143920; c=relaxed/simple;
	bh=5OLoP/JafLChQU6zqWjThxLWCd9/hPsGnsvrMaiR+CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZI8++pq5EuwR92S6y0zDxNh04bRlkizT9orMLKIcBBs/kYKrlnfP5jQpeyyu52txX4bKIgPKpz0UHEKUu0ugQpajKeqUydZkLwHgK+kR7mJQE6eIgI2gDn2qniTYWicLxSDo2/RzJctyZEakm3Zg6vx+L0ueR26B2LLsYzW39kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+h/Ls+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABF9C4CEE7;
	Wed, 22 Oct 2025 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143920;
	bh=5OLoP/JafLChQU6zqWjThxLWCd9/hPsGnsvrMaiR+CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+h/Ls+RjFImMpD83TtltRkQ6BrDJ/DcEnv8tD0j6ZZo7s06PmTY/gCZtQTzepef+
	 YwUzY/7FslYtyZ8PII1aamj7oujylD7o7GX1U2s6VKWSot+Oqpf0qLGwcFpKth608J
	 6dCAABdcDK6E3ksU/9cTrLdwM12GFpVMzz7Y/qn4P+rOEDwGr/SPhPl0oeitGMG4XA
	 WeWEakHkh8mim9F0Km7cnAJCaRDUzpIzgbp7OK5+1SHuIyO1vTR6cUvFeRmA5GRV+U
	 D4wZG+tNlQVIni1DjWxYwdxgKLljKoUurUyNy8+R8T2Jwyg1jll+tK/yDYbv8IZoIM
	 9XWDyFmwtxUZA==
Date: Wed, 22 Oct 2025 15:38:36 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next 1/2] idpf: correct queue index in Rx allocation
 error messages
Message-ID: <aPjsbGYDtohQaAy7@horms.kernel.org>
References: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>

On Tue, Oct 21, 2025 at 11:40:54AM -0700, Alok Tiwari wrote:
> The error messages in idpf_rx_desc_alloc_all() used the group index i
> when reporting memory allocation failures for individual Rx and Rx buffer
> queues. The correct index to report is j, which represents the specific
> queue within the group.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

