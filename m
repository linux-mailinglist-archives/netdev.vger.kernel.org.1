Return-Path: <netdev+bounces-243446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D0CA1579
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 20:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD62831A8A18
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126F3254A0;
	Wed,  3 Dec 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMjnNqVm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B2318140;
	Wed,  3 Dec 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787761; cv=none; b=mgLXCix3n8e1W49Wrkx/GQDpTSLsZhIwGMnN+EwRg4d0mbv+Vj3G9H2c1lKJdPQQpDyD2kB6grEIdB9O65wpNdKrh3CBrBc2Um4slVARJPZP5UreIZBlBO3lhiG7mNeLUCaghPeYgfDKl7g4HURJv7BGO4NGKeQFaRZHfDOUt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787761; c=relaxed/simple;
	bh=709OoZmrQs02YGDpPNi+Ci4JkVdDhr6Sw0qWc6Y3lr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAxRxPfgcSTlGwYlKrxN7IQjsT0pnxfJh0UGSxv8AnFiOw4Zsz90UtoPKRRrWxaYHLQgsaf1XaQqmCXcqy8f2SJRd0029cDxMM51//EUKrHHylJD9sVwdtfDl/se+Fk7dlfeQ6C5YNlqRvyIvnMLW/Mpeqa6gu2wV0sqmPQeg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMjnNqVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52FCC16AAE;
	Wed,  3 Dec 2025 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764787760;
	bh=709OoZmrQs02YGDpPNi+Ci4JkVdDhr6Sw0qWc6Y3lr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMjnNqVmzJof79bCMk03RAgInPYzTUExN72Jw3RocdtBx5WR0pYo6c8DOWHcmuH8I
	 sx7KZ3Jcl+Alvcu1y+FrJZp2xru6etwCCGAO0IDNyc7rBy72V3UcdTXvkuoz8rTxRr
	 dTOJAJPHO5toJICDUfpEKiNJv1w7q10YYsDrHHD1zr3YURzX8aec6tR+aUP6HaESpj
	 hea0ZHj4lCjCnP/hS4wdmk07ylUqNMksSPULG6YDNuSCaVXpP5bjf3R7lTfWLTVxe6
	 Y0FLtCQZu/RtBvOMIdsPbrEaxzI/W7DQmk2/1wiC9EVUNYO8lBzDCDtteCNKrVsNPy
	 WOFtegLxTxSUQ==
Date: Wed, 3 Dec 2025 18:49:15 +0000
From: Simon Horman <horms@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, willemb@google.com,
	pkaligineedi@google.com, thostet@google.com,
	linux-kernel@vger.kernel.org, Ankit Garg <nktgrg@google.com>
Subject: Re: [PATCH net-next] gve: Move gve_init_clock to after AQ
 CONFIGURE_DEVICE_RESOURCES call
Message-ID: <aTCGK4DtwVkY4FkI@horms.kernel.org>
References: <20251202200207.1434749-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202200207.1434749-1-hramamurthy@google.com>

On Tue, Dec 02, 2025 at 08:02:07PM +0000, Harshitha Ramamurthy wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> commit 46e7860ef941 ("gve: Move ptp_schedule_worker to gve_init_clock")
> moved the first invocation of the AQ command REPORT_NIC_TIMESTAMP to
> gve_probe(). However, gve_init_clock() invoking REPORT_NIC_TIMESTAMP is
> not valid until after gve_probe() invokes the AQ command
> CONFIGURE_DEVICE_RESOURCES.
> 
> Failure to do so results in the following error:
> 
> gve 0000:00:07.0: failed to read NIC clock -11
> 
> This was missed earlier because the driver under test was loaded at
> runtime instead of boot-time. The boot-time driver had already
> initialized the device, causing the runtime driver to successfully call
> gve_init_clock() incorrectly.
> 
> Fixes: 46e7860ef941 ("gve: Move ptp_schedule_worker to gve_init_clock")
> Reviewed-by: Ankit Garg <nktgrg@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

