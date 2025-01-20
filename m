Return-Path: <netdev+bounces-159868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB52A17397
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABFA163FA0
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876561EE7AB;
	Mon, 20 Jan 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCyKR43d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622981EE7A1
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737404987; cv=none; b=KHv2OoYxPB03Jn+If/TCoGvtXCleAmpXqqyw9k8rlM9Yu8Je3eh1IC9wbodNcsQ/iT949KgR6A2g+W1eBZsh1z2J4aPOVhpnBL2ZsFU6rvSJkvQ/8Ax4vyWqAcGXRjJDcflyJu3fwk81EqE5g0DFNM8eY+rEoauJl56+N1/ZVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737404987; c=relaxed/simple;
	bh=uEGN6qnEF2We5PpCwx2LWf9f4zrR3jJioF1GkNQWUvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM+z2VNbNBhdeT9aWDin6XRT5i302E7ON2xXHXuksgmDYN6C7JyrdARgkHX+B5VS9OZZWXpd/tA9COJgYoAo3/PPL/ObCBkdMLeo6Vr1jaWJGoKxmsUn8nHs9rMKmbs+WhbumRYAZmMhlDefh0sD/Imchwx9iOEz8Sf9XD8VdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCyKR43d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA253C4CEDD;
	Mon, 20 Jan 2025 20:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737404987;
	bh=uEGN6qnEF2We5PpCwx2LWf9f4zrR3jJioF1GkNQWUvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCyKR43dE+bcg998/lqSmVYQB7KurtWHqArxg73anScTDny9Hi4gDJXxCKFVlkDn7
	 Cd9dZ47lNqRSn4owiG66Zf9FWmInlsmSfZGP9gftbNlmDd9riZeW93GyCNZkXhZvJG
	 3bUBqopajdTkbJzKBJyIsQWs5Ihmgxu074dNWuywUFfbLoPy4be/JOxaSmGUFu2v00
	 GhYgn03R8z/uP1H3pcoX66Fv6P3nvZmlo0ckKbG+pVy1eRfsJmTDRnHqZQapszWvmy
	 zJ7/OCC5tdOqtTBaPPLTlX6MdbKjpsyEjeUDt44zGBu3spvUUf0AbU0NNDu7OFUMMg
	 T7e6yml9niOFQ==
Date: Mon, 20 Jan 2025 12:29:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 09/11] ipv6: Move lifetime validation to
 inet6_rtm_newaddr().
Message-ID: <20250120122945.1bfd7435@kernel.org>
In-Reply-To: <20250115080608.28127-10-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
	<20250115080608.28127-10-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 17:06:06 +0900 Kuniyuki Iwashima wrote:
> +	expires = 0;
> +	flags = 0;

Any reason not to add these to the cfg struct?
Because these are not strictly attributes for the address?

