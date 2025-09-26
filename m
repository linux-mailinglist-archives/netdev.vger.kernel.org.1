Return-Path: <netdev+bounces-226782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CDBA52B6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3709E1BC4167
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03CE27875C;
	Fri, 26 Sep 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyj4QKfF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70613286D4B
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921057; cv=none; b=oMdxZyYWRvDNDstgPdMzkxdWkPS39Ag+uD0Twy95OOupSHEqE5L/TtEvVxW4qQKdpIlsmf7Ygg+3h8Jchura/FX5/kkCr87PvGPued12wly6reEXfv5wpxOpIIg+lHVGNtf8crwx/oiUZUI1JKHY2u88qbY38At9B332wrwuUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921057; c=relaxed/simple;
	bh=p5oRqBgqCR+joVJDXbhCchcosdQfUHzYVWqwFK03VAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8QEkMddaG9NYWw6BQERb0MeFtfnraFhLWH8a2ItaK6nUmoCefNtzHjnGzxtXCPl55sjNNd28cipxRMCBKR7B0VAXR9r1gDj3v46fjHwEM88CIrfEjN4GdoNbpCBCDCcUWivGgSYMqB5tN4kKczD0p04Ud/JFpdTqc9GWNUqUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyj4QKfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A9FC4CEF4;
	Fri, 26 Sep 2025 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758921057;
	bh=p5oRqBgqCR+joVJDXbhCchcosdQfUHzYVWqwFK03VAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cyj4QKfF8XM1K3u7WHhr4eNHcT9zVnlzk4R1a3LnFQYfKaDptYfFqcsp5DNkcMwyW
	 hUxy0WkKmTPkclflHERkApXuQr/22bS3eA7iFuLfJ7ZSZUXOUMxteYRl+iDGbUOJk5
	 KfPhLecFNq0KjrC/RyOSTStYU7PSMNXVARR3ZTgneaZ3evqV54u86quSRpPRqKZWqP
	 p9eefFybdhRE4HMS2xYRDcdag4hGXOv3l9RoJk2mieW8RDlyHGE49Vpj84eBlacRsI
	 GV2wesPiC20JSlUgFLd3N1Kin5EjIUCwHXoKyUzSd2TPqFDwl+hRlzOysRpKIncIzH
	 FNfeOJJzO76mA==
Date: Fri, 26 Sep 2025 14:10:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kernel-team@meta.com, pabeni@redhat.com,
 vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] eth: fbnic: Add support to read lane count
Message-ID: <20250926141055.1c0c52d3@kernel.org>
In-Reply-To: <20250925101642.GD836419@horms.kernel.org>
References: <20250924184445.2293325-1-mohsin.bashr@gmail.com>
	<20250925101642.GD836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 11:16:42 +0100 Simon Horman wrote:
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> It's not not entirely clear to me why Jakub's tag is here.

Internal review FWIW. Since reviews than internally don't count
for much upstream I opted for using SoB. Probably also wrong but shrug.

