Return-Path: <netdev+bounces-71753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE66854F19
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5281E1F237A5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675860864;
	Wed, 14 Feb 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjQyrObt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745D604AB
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929401; cv=none; b=aPDXJTN6jjD6rF8AdiLKg2KoyC20BCi/R8WDzxIOCayYospP5NnJOyUKdNa4q0SXmWhJ4opgAHHvuRNtfderNdBePX2/Ak1XVQrL6t+RD+NDsOyK1Pk2eNUkBtcM2E5epyvWJSSNeT0SaDoo3I7SH6P/M3kjh7Inga3dpSp0Upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929401; c=relaxed/simple;
	bh=a9xJnzRIo2NcSE+12FKwwbL+hhX2XIc2xX52bRNWROo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGJuQd5EjuIQZIzsIgW3HPbGkO92TfQEJyT5iOtOTlP/2T26eWJeELU20WZTLl7D9ixEsiLxN8bg27MPxcP/SogblGYZzYz9TdqbSv/c/79Kp7slSaXnSyBImA/FvaYkgtQ5bYYMk0r6lY8vhVS2nb/a5S7qmMBwb+LxAnCtCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjQyrObt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08110C433F1;
	Wed, 14 Feb 2024 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929400;
	bh=a9xJnzRIo2NcSE+12FKwwbL+hhX2XIc2xX52bRNWROo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DjQyrObtwLsdSqBpWT30Kti/e2D4t178VjqSymEx6Q6cplNLhZBqtI7KX3wsNMWoo
	 4FrYEkXQDoiqgJFTN8PIh5wEWchTp1Wxw24ittq1+bwlxAqold9AarWlaUVzsb7Ypm
	 tT9YeSZ70yVl/o6NHSaC4qnJeHFkbPxtCBN1Cp0mBx2nmh0OSjxrlHzycY4kf5BtIm
	 l7z1F1x1t44mUtlCbvA28y3efRpPSE/fh9iOjrsOfvRfS2AtZyagDtO13m9NvV2wF9
	 9ZBjX/oCQpgJBdIqZEnoSeHHHJHMBA93V4vOtzm3l32oagOoTATCdb/G8Fm4Z8Y1fA
	 RwuXEasZj7tnA==
Date: Wed, 14 Feb 2024 08:49:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: cache for same cpu skb_attempt_defer_free
Message-ID: <20240214084959.26d9076a@kernel.org>
In-Reply-To: <d8948716-ed07-48ab-a933-671f1fc4ee58@gmail.com>
References: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
	<CANn89iJBQLv7JKq5OUYu7gv2y9nh4HOFmG_N7g1S1fVfbn=-uA@mail.gmail.com>
	<457b4869-8f35-4619-8807-f79fc0122313@gmail.com>
	<20240213191341.3370a443@kernel.org>
	<d8948716-ed07-48ab-a933-671f1fc4ee58@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 16:37:41 +0000 Pavel Begunkov wrote:
> To draw some conclusion, do you suggest to change anything
> in the patch?

Yes, Eric's suggestion of __napi_kfree_skb() is correct.

