Return-Path: <netdev+bounces-244030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4148CADDB9
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2300C3064550
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BC2FC03C;
	Mon,  8 Dec 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMwS0y3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247A2FBE05;
	Mon,  8 Dec 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214173; cv=none; b=TnNkR6vAWyesJ/Sd+QC2nKNKMKb9huc6bthC57cGsmjvACZtGCtAZex304drsgejXPKw4bNrOOAkYqYjspwkenyAmJkgHQNeqHCuxAjlxHcQihgOv1cNI0qShhiQEnoWU5StZPxRLuPNotBxqWlcBzWIMdS9F6hd7c37XeZRQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214173; c=relaxed/simple;
	bh=Bbhttr7Ktx4MB0NrB9LJrMZ/YzjWNnMlRrwigv3NZEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUz78V7thLvpw5hiKih3LGZCa6LndrmjnBnvmgb44CzHbpOWTXLAHKJRtXg9TZo8R+SsmXYe+FDYmk2PdaWj33dP5ceWcyOPxPGxNfsSjwxlLRSF8znU6ni/PZADmJWMv6YQOHB5T0QWb5ibXEaOcXUGkd/SFiCBGapkBDKunjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMwS0y3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87266C4CEF1;
	Mon,  8 Dec 2025 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765214173;
	bh=Bbhttr7Ktx4MB0NrB9LJrMZ/YzjWNnMlRrwigv3NZEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMwS0y3SN3SMUu8lLywAt0IkiUKBxC1bPaq8rEqhDxfwvpNFL9wWEob4h3Y9ld7Jq
	 mDK/LOutsshLfG88QaDJrHvK7Zs13+it17UalGTrIBw8yWokHCosMY64J69hwhhfi1
	 Qrlib8VF35WrLUMquXN3ITR7vZyHuLoA59PxwhMS+AswRxQ02DxWP04mwNzcVEpyWa
	 JUNcWGzej+hlQuzOdGmRjizBKIVb7fy5YEBZoqH2rfIotpIufgYgKEr/kx440JEvdV
	 rfEfz2fOkMbuSuJHJLOrLvlmeNg2azrj4Y7pGMhmbRnJepQfrvfXYq+a7Qk/eMXxlZ
	 l+ORNlEhln5mw==
Date: Mon, 8 Dec 2025 17:16:09 +0000
From: Simon Horman <horms@kernel.org>
To: David Bauer <mail@david-bauer.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"R. Parameswaran" <parameswaran.r7@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] l2tp: account for IP version in SKB headroom
Message-ID: <aTcH2UjqAvd84l59@horms.kernel.org>
References: <20251206162603.24900-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206162603.24900-1-mail@david-bauer.net>

On Sat, Dec 06, 2025 at 05:26:01PM +0100, David Bauer wrote:
> Account for the IP version of the tunnel when accounting skb headroom on
> xmit. This avoids having to potentially copy the skb a second time down
> the stack due to allocating not enough space for IPv6 headers in case
> the tunnel uses IPv6.
> 
> Fixes: b784e7ebfce8 ("L2TP:Adjust intf MTU, add underlay L3, L2 hdrs.")
> Signed-off-by: David Bauer <mail@david-bauer.net>

Hi David,

This feels more like an enhancement for net-next than a fix for net.

If so, please resubmit for net-next once it reopens, after 2nd January.

In that case the fixes tag should be dropped.
But you can cite a commit in free-form text in the commit message -
above the tags - something like this.

...

Introduced by commit b784e7ebfce8 ("L2TP:Adjust intf MTU, add underlay L3,
L2 hdrs.").

Signed-off-by: ...

