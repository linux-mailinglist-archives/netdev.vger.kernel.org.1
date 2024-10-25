Return-Path: <netdev+bounces-139097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B249B032F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0712822DD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE962064EE;
	Fri, 25 Oct 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH2RSCxs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F92064E7
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860771; cv=none; b=EqkQgtzXCP8o577P9yp8QmEfbE8gYtdm/QyHJe3Vpa73kZJeNlA65PpDWTD8RFWq/52dJSFBzp106OKlwMMnNG0CVHHiJ2JLlJ1YAlbsvipt4YABpmUuNNGb2qryUehfCq6mS4mqPWHFWgo5BPpOm2p//L6pCKeeEImnidnYe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860771; c=relaxed/simple;
	bh=m00pkK8YonchMrHaT2OWpp3cC3BSRKwDEK+7h3GjR4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRyJkdt/WKoazeRF1ZrdYa+KnHfWwhU807WTxGo9ckpLADTt7EW91N6NGNZo25u4llrWmzAiKcV4SbOWDKSQ8S3hv+WNykoT7AwcOa7wdcIqykQxTzLk50qSskcTIBrHJj4VyXJ/dYYdfWIP0Z7IJdTMX3kplroVXlmoh8CcCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH2RSCxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44052C4CEC3;
	Fri, 25 Oct 2024 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729860770;
	bh=m00pkK8YonchMrHaT2OWpp3cC3BSRKwDEK+7h3GjR4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NH2RSCxswHuRiA8+G4ms9RmO36GTPZAVa/IlAPQmCjjV27KsUvu7WUfarXTHc7dOc
	 xIspP/oOTlZjwEbR1g8RqLoNM5VZMikUlsgpJvYhOqGZPxnd5aoqUFSDr3HjFAzoG4
	 XDwzEdvMfoCDZr65dkmhct428nx2mDnrK94h3JmRkBweLtRP4AGF61BWQLe5ympe5S
	 6ds01jmo14O0+/ZZkMTtbeGtOxp/6TpT7/b4zGG1oTHVEr7b6JJ5SUUjQU7ticxA8H
	 xRsztGKGEWYzyl9IOqUN3lYegh6nO4uCTQJQW8Qio7+rQg5Wd6/qIc/9T2ir+N2bfA
	 5rH29nqCKlZ8A==
Date: Fri, 25 Oct 2024 13:52:46 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com,
	sanmanpradhan@meta.com, sdf@fomichev.me, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <20241025125246.GS1202098@kernel.org>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024223135.310733-1-mohsin.bashr@gmail.com>

On Thu, Oct 24, 2024 at 03:31:35PM -0700, Mohsin Bashir wrote:
> Add support for writing to the tce tcam to enable host to bmc traffic.
> Currently, we lack metadata to track where addresses have been written
> in the tcam, except for the last entry written. To address this issue,
> we start at the opposite end of the table in each pass, so that adding
> or deleting entries does not affect the availability of all entries,
> assuming there is no significant reordering of entries.
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
> V2:
> - Fixed spelling error from 'entrie' to 'entries' in the summary.
> 
> V1: https://lore.kernel.org/netdev/20241021185544.713305-1-mohsin.bashr@gmail.com

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


