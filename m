Return-Path: <netdev+bounces-185800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1FA9BC3F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4F09A05BD
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFB225D7;
	Fri, 25 Apr 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOhz2zwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDA17BA3;
	Fri, 25 Apr 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543910; cv=none; b=oIOC1z+0LKW2SU7b8hbOezfMqwvjxdV7AUTJQdG1aS/ufl/gpqQmu0oFfDCkDODcONYnmyTeSERnjGj38g6IBmnuhGCA6HT1DGlIcymfgh1DpUsnWF5d+clbZ9+/ipOVQ6ZmMI8/uOC+UQjaCgwhJhZ4vD62WfuEao81mPMEqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543910; c=relaxed/simple;
	bh=K/GeNrOiuPv3iZwrpJYyZG+Sj1INmpMuyfgp26OM4hA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGdNlHogYDm7Thprl7cokrE37Eof3p5wtDfo9H2QxjaFC+LSMmswpWFqR4wAdpK1og9nQN6gZEQAESTYW9pkHaC6fFupr4LVAvyd+ZsA7jVGwvVF2NodtCMvVKKyc7d/3Zgn6rQL1VRfo7N6HPco0LLLX/3o7pSxg40aIqgGC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOhz2zwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7DDC4CEE3;
	Fri, 25 Apr 2025 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745543910;
	bh=K/GeNrOiuPv3iZwrpJYyZG+Sj1INmpMuyfgp26OM4hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NOhz2zwZ93Kc8W+um1HLX78ajBeHZPEbnmoowmTwDez2rj+WjDD3u95WICe6Utvhs
	 gfsJ7hM0SzDBBWchdAygEKVRrhjzOll6kEe07SZRo+2UkJJg+4uuz+pxbHBr4toYBF
	 PFPjQ4CS1CFfyI/xPE+YCZiIg5UyYudF5GnMu6GEro+7sevklLB50wDajbja88dYRj
	 59UxOt12zzYhEWrgUF4IL5OJY0wKLzN1o9MzuF1gSH7lBHh15uE/WnzmazGi42ZN2y
	 wbQC5XfWJLo6nrLZhgNhpjCH0YqTFDiPMKNGKe+UDgl0gzHouGOgye29DuCZajaF98
	 BKksqzfIEYVlg==
Date: Thu, 24 Apr 2025 18:18:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: vertexcom: mse102x: Fix possible stuck of
 SPI interrupt
Message-ID: <20250424181828.5d38001f@kernel.org>
In-Reply-To: <20250423074553.8585-2-wahrenst@gmx.net>
References: <20250423074553.8585-1-wahrenst@gmx.net>
	<20250423074553.8585-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 09:45:49 +0200 Stefan Wahren wrote:
> The MSE102x doesn't provide any SPI commands for interrupt handling.
> So in case the interrupt fired before the driver requests the IRQ,
> the interrupt will never fire again. In order to fix this always poll
> for pending packets after opening the interface.

Wouldn't this cause invalid_rts or some other error counter 
to increment every time the user opens the device?

