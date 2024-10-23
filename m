Return-Path: <netdev+bounces-138392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044BB9AD493
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F7C1F2276C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12B1B86DC;
	Wed, 23 Oct 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExFahBFt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D01E51D
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710860; cv=none; b=m1RI/m8tnkEzrQ3x7gI+/048z8ml67Ht+Xu+ESL/YXC8CZ9by4p8TlTJOZWW+abonejwj0S0ds9MQ2QbtYZ3IVaXG2et1RLBhoeCCBjuDooSy7IoP4lA/PqdsFpCvFzOE/OsTYdfZrE0uZzhmJW/48chOMhLoEEBXU25NvCQVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710860; c=relaxed/simple;
	bh=dJWmfru1Lw90MKLmp4zLu6aocJFsPQ1YDzvk5LzT4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwyGjDMYvaY+P2GSAHfuN4/qyknYX5d8oK1xc8fiMk/WysrLA6D3xXbaQiNFZOCmpE0VxxYChztqcpTbMF7YGhtbT1WNNlCsHJlFhNy+FnZxw/ORlkHx1BuxxyvwLYfTU81x8sCsNNWg9gshdM3vt+VZPVaLGyiyF7x7rHeyM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExFahBFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE3FC4CEC6;
	Wed, 23 Oct 2024 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729710859;
	bh=dJWmfru1Lw90MKLmp4zLu6aocJFsPQ1YDzvk5LzT4ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExFahBFtsbn9q92JHgrp8OK012pPaMO5SE/eOKK7WlHUHSOCKUK94ghqqZmJJ5qDg
	 z0x8WuA7Y0JR2W9heYpyAUaC0w+pkk8OK74bcHwsVL9vJVWtvSbAUB0QiUhCk228Q9
	 20ve7MQgwBExrs1rPlhMljFOYMQq95vpbkN2QVy1lHXeCzlKseSqlPYe/EHDxXJHtR
	 /NEY+3BcSczSniWm8jlrMYQa4lVPjmn2dkIxwfYM8Tjrtu7mlZkrXf33YUSxK9iTXK
	 N/IvXLugN1Sh690d46/rkvEXZCjS8rpiMXrPqTGxjH8GQHWGYfm4mFrKqVIkf2gwIz
	 zGjMPFRTVPC+g==
Date: Wed, 23 Oct 2024 20:14:14 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <20241023191414.GD402847@kernel.org>
References: <20241021185544.713305-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021185544.713305-1-mohsin.bashr@gmail.com>

On Mon, Oct 21, 2024 at 11:55:44AM -0700, Mohsin Bashir wrote:
> Add support for writing to the tce tcam to enable host to bmc traffic.
> Currently, we lack metadata to track where addresses have been written
> in the tcam, except for the last entry written. To address this issue,
> we start at the opposite end of the table in each pass, so that adding
> or deleting entries does not affect the availability of all entrie,

nit: entries

> assuming there is no significant reordering of entries.
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


