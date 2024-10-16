Return-Path: <netdev+bounces-135926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B810B99FCCD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AFBB24635
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4E4C98;
	Wed, 16 Oct 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3KUnawI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E94C91;
	Wed, 16 Oct 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037414; cv=none; b=TtsJ8nK+ZO8xrO5/NtGc3uO5E0i0XezktBbgQUXi3LYksf9QwV9zjxo5A5dUjoU7Vn8C+pOzGRLzOZR5vk+UBojaT8nTNBGzuuiGsB+0FHScPhORURF0Bwi280mSums8xxTIijDAF7av1NDlDyT7PzsLkEfe+0h5TtPlzUj9Rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037414; c=relaxed/simple;
	bh=PEvu6ecLrtTLoIG7xngZEUysaFi9La5kNX6nC4vOi/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7Y5OMcvnpohOdBxxQrsl/t7LSbYRMHXuqEgas47mfmUqKkd2jyeKVnv07EO2VNqae5Z54Hhv1dlmUzxEoyBkqq1n5HjJRrRpcbGtH2ovcq8s5jcaRksDsBjsijP7W7MitYg1Gl9B6ZJyBrdrDFXJxMe8ZaCENx8IgtWpdhCY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3KUnawI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DFCC4CEC6;
	Wed, 16 Oct 2024 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729037414;
	bh=PEvu6ecLrtTLoIG7xngZEUysaFi9La5kNX6nC4vOi/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m3KUnawIAQ0CMgdKWfeNLAL3rCS5+MTD/b7uGynfE6oWaFRqJVWnQX4m8ok/NnFAE
	 nuDx07ClSvGPnKtZRrBLPYykgabxBDoilk0yPuidQYKvxKK/NfRIIikhGrRQA8EkuH
	 ZN0LjzYkn20x7O8Y++84f1AN/LtMIH85IvpYEnRtPEhKRZEyt7ghDDToP2SriSN8TC
	 cInTCIHJ8bwax6aAkxYgQi7zA8iNG+0KivlymeeqNDTGexfZtfJbKD3V/Rgecq9bHc
	 962C2ctuPcvPH3H106lgsRhwW6QlHOduW1PLETMaFr1ZMNy2VsHu2T1WuEaBSq/Ga7
	 3AQPlRXClZ4rQ==
Date: Tue, 15 Oct 2024 17:10:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 08/10] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6_mroute_getsockopt()
Message-ID: <20241015171013.7cc3617e@kernel.org>
In-Reply-To: <20241014151247.1902637-9-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
	<20241014151247.1902637-9-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 17:05:54 +0200 Stefan Wiehler wrote:
> +	rcu_read_lock();
>  	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
> +	rcu_read_unlock();
>  	if (!mrt)
>  		return -ENOENT;

presumably you're trying to protect mrt with RCU?
so using mrt after unlocking is not right, you gotta hold the lock
longer
-- 
pw-bot: cr

