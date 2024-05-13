Return-Path: <netdev+bounces-96175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E428C4908
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A926B20ACC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8094A83CD6;
	Mon, 13 May 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKYzTCPv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597822AF09;
	Mon, 13 May 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637091; cv=none; b=LZjVd2rmXoaqkJf+w4furNO+AECKV20XAkr9VDe+fsro6/nW61Jo9TPEPUcrMlFQHknUyMfzbGTV8tmstQINtgYzwghCwP96pmfO0CuAhHugghLvjyFI6gpjMfsw2+RKHsWSeRntV2uW89iJvpSfnVJoOg9wIX+DKAE6k25mTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637091; c=relaxed/simple;
	bh=qjDaR7GpKVcHlSgdXco8X6U5ApfVTHDXF71c1j23G6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMtbelNqUrdZyC7SJJTMK86GuSDgTv8x2LSo6oiKAqoj5P6Uvyfb60nV+U9Hjm9Fsgipn9xm0SEET2Ue0aVEpw7A/ctnSfdYbCUAJxKNpNuoWgyfh5coy6l/GsdE/XcPreIBXg/ZpaCdDcArRWcGxiU5G6JxB9JwGs5AWH6DrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKYzTCPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0B9C113CC;
	Mon, 13 May 2024 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715637091;
	bh=qjDaR7GpKVcHlSgdXco8X6U5ApfVTHDXF71c1j23G6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PKYzTCPvDQEq3qqSq4LvLpV7by4JwQCgW+DL/tlfBikBTc7tcQvlL1OjVxsKKNfe3
	 g6JurEYbAdO5k0ZPpGLsMHZOUWcc8g0lexIHpRbiVl9q4+DYuI6EsyQ+j8Z8QTol1s
	 CCd33VgQyogWUZ5EgVut4ofxmiLdNyo8FoqhoAE2ftSGbbpQc1Goe4emg7pJ9RDN7t
	 WEsgj3VIxGIBBcuYrf7YhASpOZ+HALztfvsMx6ZpGk9ydD5vh+DUH6GEe37aCTdTpy
	 VIxWB3RqQ4kufHo0uwws40I3javIeHgqg0KqIKdH1javzjdxmLVYdjle+3R9ObG3Rx
	 9oHb5KjcMYR8Q==
Date: Mon, 13 May 2024 14:51:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 thepacketgeek@gmail.com, Aijay Adams <aijay@meta.com>,
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] netconsole: Do not shutdown dynamic
 configuration if cmdline is invalid
Message-ID: <20240513145129.6f094f92@kernel.org>
In-Reply-To: <20240510103005.3001545-1-leitao@debian.org>
References: <20240510103005.3001545-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 03:30:05 -0700 Breno Leitao wrote:
> +static inline bool dynamic_netconsole_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC);
> +}

Why the separate static inline?
We can put IS_ENABLED.. directly in the if condition.

