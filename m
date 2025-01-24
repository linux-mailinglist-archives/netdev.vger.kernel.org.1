Return-Path: <netdev+bounces-160692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E3A1AE28
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5047716A34F
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE822075;
	Fri, 24 Jan 2025 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU+EMQMF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43C6FB9
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737681866; cv=none; b=l13a4kIwLbpbikAlc4DfMoxKfb7RYPArEKX2eBh4CT+7bJxpds92I42evzN9nztCdat4kjeBF610ybCR9IM+IK/fN8rFGFQzSt5uShLhdyl8ZNMQdw1O7wq+EuqVYyDPTMQqKeQY5ZZw9W+1tXk8fo1MDTr+L/sXbvlVzgf7rM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737681866; c=relaxed/simple;
	bh=HUg+U/SKY4O50e5JtFMgTD6LPSxMwr6I90P4n7nAFZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qO6D6Rd9R0ZNyGJPycc1DlI7HuXz9V73/lwyZS3LsViQFKYHWde8aZ0bwKyERXPNaX/IRlAdWhG/za8FLAC5YfWfFyzyhaST4hkaYfiZBe7e+55h7pNre/6WkXIszkyhQ+AEnyKh6R3Iav/rkkDqVro2cRiSwD6Gj0+03BXWTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU+EMQMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFC5C4CED3;
	Fri, 24 Jan 2025 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737681866;
	bh=HUg+U/SKY4O50e5JtFMgTD6LPSxMwr6I90P4n7nAFZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cU+EMQMFxu7boTflI0lwDdABXlBRxC4o6ZNT/nrsiZfNvkbd8tK65fe2LDOWvmslT
	 TZrlokOM5dyHZr2TnIC7NeYgmnZIzosv1eVLvMIEyjVlqqFBftY4lRuioY6I+vv3Mk
	 7hAK4lJlCR0unvq7+roy2qJuADat8osixuHht9N6ohp+1oAppxFAe0G3SVGtzhSYiy
	 bk7egOQbOhc+gbG3V3uUKq+IW5bmscphAi+ekTkpV9eYM7CZiT+GomrfN5mqaLHH2o
	 /Z84iQYil08MPwUDvi25gL7Q75Xo/39PLLJD1BrkaQ0CCyZd/tZA3vgbOlk+sOlqk3
	 f6ibbAtJeHwHw==
Date: Thu, 23 Jan 2025 17:24:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Add support to do threaded napi busy
 poll
Message-ID: <20250123172425.63279bda@kernel.org>
In-Reply-To: <20250123231236.2657321-1-skhawaja@google.com>
References: <20250123231236.2657321-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 23:12:32 +0000 Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.

## Form letter - net-next-closed

The merge window for v6.14 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


