Return-Path: <netdev+bounces-186447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6DA9F226
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC54189EB42
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E826B962;
	Mon, 28 Apr 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NwIfBq/0"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6D25E81D
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846640; cv=none; b=E1pInKxoLMrv9IJwoEWKr0u3REzEL95fG0tSGFnjZV+40pACIrJULmQF2eQTsWCVjY6bTlrOsL9wRapmEvXumh70k3EpKiarJPpzAYk8efQXxUHAPEhmHfNV4vG9Spg/He0ndjEKEUM5+Ql4jubKrjXjKX3wWMg7FJpXg/N4GNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846640; c=relaxed/simple;
	bh=Jfb/kIaOSOa8TD/lWvUsGjzvd/OAZPsWS5xudOXFQ/0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jCjDnxyKgVV3tOHiQszfQKR8qtApHNdY/VRqO4WG7PvUnv100VKaV2OirUr8HsOevTbneF1ceu93YsJiJTZEqFsUluN/wjaQiYt5rUs/++RGFhnxl3kxMhLvxBtgRrTL2pU1N9H2yRRRDlWB+uxvlIwwrgzbpf1RmsEEgyUHpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NwIfBq/0; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745846636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jfb/kIaOSOa8TD/lWvUsGjzvd/OAZPsWS5xudOXFQ/0=;
	b=NwIfBq/0dl0/BPFfR6riLW+Z/IFLTIeVA0xvy1sBq0f8KQzEHQSAfCNdkzBRoErBp6e229
	jnZbtlsT2j38EEw4M6EDr0psjcaDcVyUcA+k17R2SpGMqqAc6iQBHMyOfl/3sDHBdSsjtW
	3Rk016mWC/WiOWjFGSxdW8eLpv33vUo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH net-next] tipc: Replace msecs_to_jiffies() with
 secs_to_jiffies()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <GVXP189MB2079DD4E21D809DD70082B15C6812@GVXP189MB2079.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 28 Apr 2025 15:23:43 +0200
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Maloy <jmaloy@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <183272C9-A50F-427D-8492-A474E72E97E0@linux.dev>
References: <20250426100445.57221-1-thorsten.blum@linux.dev>
 <GVXP189MB2079DD4E21D809DD70082B15C6812@GVXP189MB2079.EURP189.PROD.OUTLOOK.COM>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
X-Migadu-Flow: FLOW_OUT

On 28. Apr 2025, at 04:31, Tung Quang Nguyen wrote:
>> Use secs_to_jiffies() instead of msecs_to_jiffies() and avoid scaling =
'delay' to
>> milliseconds in tipc_crypto_rekeying_sched(). Compared to =
msecs_to_jiffies(),
>> secs_to_jiffies() expands to simpler code and reduces the size of =
'tipc.ko'.
> I observed an opposite result after applying your patch, an =
increasement of 320 bytes.
> Before patch:
> 969392 Apr 28 08:53 tipc.ko
>=20
> After patch:
> 969712 Apr 28 09:11 tipc.ko

Which architecture and config did you use?

For x86_64 using LLVM, defconfig, and CONFIG_TIPC=3Dm I get 929960 bytes
before and 929864 bytes after my patch, so 96 bytes less than before.

For arm64 using LLVM, defconfig, and CONFIG_TIPC=3Dm, I get 8005616 =
bytes
before and 8005304 bytes after my patch, so 312 bytes less than before.

Thanks,
Thorsten


