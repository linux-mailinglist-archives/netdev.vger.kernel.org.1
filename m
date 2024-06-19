Return-Path: <netdev+bounces-104701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816BF90E0F7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B1F1C222E3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8E4A1C;
	Wed, 19 Jun 2024 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf3TNz2B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF74687;
	Wed, 19 Jun 2024 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757901; cv=none; b=Ku4uXHt7WZZ7e4kBHQYRpJaLZcfnOnTHQKcc5xxs1Huvz0kL31ci7x1WDgUlj7fyUDxyt1ha2AyomTR3fXY39o4ReNvrQSUAFxZZsr2fWwqdvnrHGZk42X87uMbdAqdpGkyO9ebMkTC7NlknRakpMS5Q9LED5jN5ZRjYQI9W9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757901; c=relaxed/simple;
	bh=4MSwzDwCDVOtASEfSX2a65c/to5zuEGQDDfHQVDYUpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRkzxacqRVGGsFyom8S3AeHpWkXwSLW4Jxaz7TZkSKi9/DjLxGZDpzYKjcfd30y9jEzlzExSIwA7H1dzkLnXFzkzzTbKN3G+5UMl1I0pH231iQSNdTYmeVLSTkuVx7REIRN9GR+uuNURpQKMVBB0HwfHYcPlZqvMzMgi0RWYV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf3TNz2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD51C3277B;
	Wed, 19 Jun 2024 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718757901;
	bh=4MSwzDwCDVOtASEfSX2a65c/to5zuEGQDDfHQVDYUpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mf3TNz2BRtXxesfQP75+rglLlPAgEsO1xIp/NbQh4ionEPhFjjgJKrUNolt07oJQh
	 6+VkhMO5yo5xi5QRBTK7f+piD2fy0d6CyZp0iHL/0WwhdA8HJHrGEX4LcY0DM1Ps8Z
	 6okdOAeda7PVcI3HEgbuYrb/MfvnRwuLnCso96+FbVgSI8D7nz5jzHFy5ixU6r2AjB
	 REHVAlxvBNtc6q4pPz88n6zuUn0UNqsAdqSevu+OlmRBCq7Kqwy2d3dmYzRsOPTFk9
	 Z99C1Qr8ak47sVGZc3uZvQBinRHpD+tQ1M1SZn2QtbuqjrxCXOpIxeQS2DtudT26mq
	 0EEzVql14BA7Q==
Date: Tue, 18 Jun 2024 17:45:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Denis Arefev <arefev@swemel.ru>
Cc: jiri@resnulli.us, edumazet@google.com, eperezma@redhat.com,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v2] net: missing check virtio
Message-ID: <20240618174500.49a3045b@kernel.org>
In-Reply-To: <20240614101826.30518-1-arefev@swemel.ru>
References: <ZmsG41ezsAfok_fs@nanopsycho.orion>
	<20240614101826.30518-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 13:18:26 +0300 Denis Arefev wrote:
> Yeah, I was thinking of adding Fixes: 
> 
> But this code is new, it complements what is done.
> 1. check (!(ret && (hdr->gso_size > needed) &&
>                ((remainder > needed) || (remainder == 0)))) 
>  complements comit 0f6925b3e8da0
> 
> 2. The setting of the SKBFL_SHARED_FRAG flag can be associated with this comit cef401de7be8c.
> In the skb_checksum_help function, a check for skb_has_shared_frag has been added.
> If the flag is not set, the skb buffer will remain non-linear, which is not good. 

The Fixes tag indicates how far back the bug would trigger.

