Return-Path: <netdev+bounces-146377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5FD9D3285
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 04:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8068DB20BC0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831A91547FD;
	Wed, 20 Nov 2024 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6o3N25I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D85336D
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732073035; cv=none; b=L49+AEiVkiCtjs40xAO7lEIlwH83I42wv6CbV0y5MpT+Wk48foxd8ietLuNzINaKZz9zmhmJN6EW7QP0MZ/QiQJlnYSkQZPXXDovbBsPdVjiK8ZqWUhIWcZ0L/y8a07952IEiggCnXUZvRYK0IA4w4QB1kmyCWffN6ercOSjHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732073035; c=relaxed/simple;
	bh=V831Yu0s3Eyo1y+Io8OdHWrpU8x+0Z/1gpWRswWUmxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmG4809JHpMU+/2TUCgBDJJatsdwCXjTiOhyTq9eLgRgvBPprpr15sgRnw66zgJs2Tz5cr2Z/eigFdrGHzMyl6wOHO42GVOk0Lx3C4+R//QsJc8Vu1Wj/hdVJdIgkUo8GEziaLTzVO1goLoZmKcPgbo0TF0tZRkQ8cQ1Radyz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6o3N25I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DE5C4CECF;
	Wed, 20 Nov 2024 03:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732073034;
	bh=V831Yu0s3Eyo1y+Io8OdHWrpU8x+0Z/1gpWRswWUmxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6o3N25Ih3J5GqbHaRUdFpXmLchjf7eNs4LXhAArsq12j7j4yD4HAebV/wJ80JPEY
	 cm0HH1pEUo2f08rdk+zhNVhvLaDImYV+q+h7TqhSEvYeu27u5iPRId7N9Z6woxUcIg
	 f7kDf15HOWynCZPRp6PlqvX+/Nld5/54xtxClWCK1YrEJrmxVv2idTq8kxmJkfrkx5
	 jRYSVeS7HkcoS6KL4eaKieHnOTzufWqKpI7Mf0hT8PcIjXBKXU91OmuQ8VDZhrCkSc
	 Kzk49jpRvrcix8rHMmYQyNln6U82jHbPHZ6hI7S7CmDHbzbL12LOzg4xszWTXqdhiV
	 jp9GYGY0zmDyw==
Date: Tue, 19 Nov 2024 19:23:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: netdev: operstate UNKNOWN for loopback and other devices?
Message-ID: <20241119192353.2862779e@kernel.org>
In-Reply-To: <20241119153703.71f97b76@hermes.local>
References: <20241119153703.71f97b76@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 15:37:03 -0800 Stephen Hemminger wrote:
> It looks like loopback and other software devices never get the operstate
> set correctly. Not a serious problem, but it is incorrect.
> 
> For example:
> $ ip -br link
> lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
> 
> tap0             UNKNOWN        ca:ff:ed:bf:96:a0 <BROADCAST,PROMISC,UP,LOWER_UP> 
> tap1             UNKNOWN        36:f5:16:d1:4c:15 <BROADCAST,PROMISC,UP,LOWER_UP> 
> 
> For wireless and ethernet devices kernel reports UP and DOWN correctly.
> 
> Looks like some missing bits in dev_open but not sure exactly where.

I thought it means the driver doesn't have any notion of the carrier,
IOW the carrier will never go down. Basically those drivers don't
call netif_carrier_{on,off}() at all, and rely on carrier being on
by default at netdev registration.

