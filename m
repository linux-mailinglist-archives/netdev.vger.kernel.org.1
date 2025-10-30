Return-Path: <netdev+bounces-234323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9296C1F5D7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 647D1346CF7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC0342170;
	Thu, 30 Oct 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quzpmg7a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA7182D0
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817438; cv=none; b=h7cIo893j3cZFFCrrayf3GPgF0ZEEIGg9on87PghJ7ANXB2Oqh9YjnBlW6Q+bWEsHqsS27vhCDAEk6k3DkIu4sL1IYVa6NTKOqKISb7zJohOw2JM+wFt8/QICHG6ROyCCHlklnJm7lNdxXJ5vnStnp0qQITFnsOWWViFrgAqiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817438; c=relaxed/simple;
	bh=66uaFKzvQO4YME8P8WHPr3Cioztv0k9CjMfNZNyEt2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPbkXjvWHgQciOPi5B0fyXIBG2sssclhAq3uF6qg0uOGl2iYcm80KZyRhrXI/uZkrpI3Z7fJfMrtOxj1AOyFrQOX55O+3sC7KiVv58T1mJSqxsrc67IIHJVvI7NUGyza2+q0hErhBUAJCz7sxhGjkWFI0uQ3aqKmIk03sl2yb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quzpmg7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A6EC4CEFB;
	Thu, 30 Oct 2025 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761817437;
	bh=66uaFKzvQO4YME8P8WHPr3Cioztv0k9CjMfNZNyEt2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quzpmg7aJR6Od0//S3AQoXd2CjG/rUU1v6MSvSKFleFoWAN1CE+m1uTynhiPtlB5Q
	 O6I1qg2vi4zwCWjXh+EqbbAf4Bbtd9io9ZcrOlw9yAl0+1dWWejO6rHdEZ0OpyDeQI
	 cVemamoVlck4GisVnOcpUHrRJlEx3G5mDA1JQ5pXCgDI41VWgTBA16t9UbyiSm07Xe
	 0oHReMQaVGxkdtg1cGeppIUAbIeixuC3ecHS/o0yX8dIJFpNqsmFba1gQLteFqbQDc
	 rLspXBYPkbYmYPlLtUafpoOiOwijkBhUrFkFZhyRQU/AajBPEi7roq7kQbiTMSnSqy
	 UFIohVALrMJeQ==
Date: Thu, 30 Oct 2025 09:43:54 +0000
From: Simon Horman <horms@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Tim Hostetler <thostet@google.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net 0/2] gve: Fix NULL dereferencing with PTP clock
Message-ID: <aQMzWoIQvSa9ywe4@horms.kernel.org>
References: <20251029184555.3852952-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029184555.3852952-1-joshwash@google.com>

On Wed, Oct 29, 2025 at 11:45:38AM -0700, Joshua Washington wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> This patch series fixes NULL dereferences that are possible with gve's
> PTP clock due to not stubbing certain ptp_clock_info callbacks.
> 
> Tim Hostetler (2):
>   gve: Implement gettimex64 with -EOPNOTSUPP
>   gve: Implement settime64 with -EOPNOTSUPP
> 
>  drivers/net/ethernet/google/gve/gve_ptp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Hi Joshua and Tim,

I think that the approach of enhancing the caller to only
call these callbacks if they are non NULL, as per the patch below,
seems more robust. It would fix all drivers in one go.

- [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
  https://lore.kernel.org/all/20251028095143.396385-1-junjie.cao@intel.com/

