Return-Path: <netdev+bounces-149944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55C99E8302
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9746281C92
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF29479;
	Sun,  8 Dec 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1PIfaAe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD8EAF9;
	Sun,  8 Dec 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733622243; cv=none; b=s6cOfzQ5iw551zBIOFvshUlMuOwmToB64nfS6PRHlmZibuAd79S2I6l9BAKugQftZjKJP6oKlbtPTqshs99JxBDmLYYtecnligDNVxQJ9ds2GOaTFWKW+FacI+teHIZgZyx8+60nu7qYcEEjJCcg7L4XI0YrTSubDL6VYCwFYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733622243; c=relaxed/simple;
	bh=adzW/ONnxxZsPDe+0bRS9bkgHglN5PsSpguw+KNch/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qE/5g75JWTQ2TgS2PJoYvCshpeWd5IuFP4zRrbxdvRm/tzOT+gakx4U+bSp8zIMl7vU/BtXfwfz5n0eYdA+ORsX7Tkndnzvql+OXzEtpwFEX/W/HnOtA09XiB/BwxN9p/MOHK7JLDCjEBVqhkS9PFUqQg9eVYR+1/m5QODnetus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1PIfaAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2CFC4CECD;
	Sun,  8 Dec 2024 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733622242;
	bh=adzW/ONnxxZsPDe+0bRS9bkgHglN5PsSpguw+KNch/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p1PIfaAeRHH2a5jH2y7YrUaad3VbF8sabotjLihJ7ifOZd9TnvT9Wij2q1tAjqE6j
	 THkTJrfpvyOLDBTpMoQ/axHTyqQ3bvS2vmiOyRpDmiqq+Oj2Fd5Mv+jV90Cy5d3Vuv
	 qo3brKicnq/Idetvs3P21tDvPWtLr4N3rRg3MSUuOCsgX2h2ldtBkIF/7U5WF1OblS
	 hSbO9qe+CrrAZJfDTO0TgVsS6nvrFZnHegThlX7tPnssivr6Rs0zkib2Gw5C1SpcgL
	 iWBPFkSARHI7HtxoHJ2Sswy5igeUpC21k2lWQzCSHinMZ+1VPOomJ22b+QyWtbJqNc
	 e9pDJGmgvCHMw==
Date: Sat, 7 Dec 2024 17:44:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stas Sergeev <stsp2@yandex.ru>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tun: fix group permission check
Message-ID: <20241207174400.6acdd88f@kernel.org>
In-Reply-To: <20241205073614.294773-1-stsp2@yandex.ru>
References: <20241205073614.294773-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 10:36:14 +0300 Stas Sergeev wrote:
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> 
> CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Please avoid empty lines in the future.
I personally put a --- line between SOB and the CCs.
That way git am discards the CCs when patch is applied.

