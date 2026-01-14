Return-Path: <netdev+bounces-249846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16961D1F357
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BE3530AA996
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8D27A92D;
	Wed, 14 Jan 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCtYn47l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1512BDC33
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398439; cv=none; b=dJatVnmDw416LxzmhwDFf5YtyjH1qoEWFUd0Yi/LdJn8JNNZseBHDATYWuf6j1TU7CLM9CLA5P7PrVk/4pBmY+u3kdMSAbA3g+1ULLoCrMcTlc/MsTWarh2fbT+5Yq4y+3ndID3fgOepZL4l0po6FKqGG/B0+W25JTuXfnuiJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398439; c=relaxed/simple;
	bh=L3dR8NudphjzOLY06rRJEZjL9fEEuauxwFNrQodgmbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2A6RvjUM50IXVvLR5lNv9Eqx6ChWkUui5v79fdlqSzqpDxAHKGrt2d6PzeWfymAQxKo/KYq+B20e4bqaq0qVfYFBIJ6H2MqqLL1+zqm3Lp9fYiCDYsGtVw5fgdTyvqx32PUHP/8dmJf71Ywz9rXJTlmo/P7DP1RjcpMncW42u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCtYn47l; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so3222275e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768398436; x=1769003236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jT5+6PNxAsiSLc4phs+HsvpCwG6ks9aQbUheKgFsmM=;
        b=RCtYn47luvoQ8q4+NaUZlfWWBG/l/k5+End8lqN0K9CXWV+mUFe0dIM/4PZ+VqxFHL
         Yn3pQGr6wWd4aISC/GalrilNj5bjK8CVpn0SRul/jW5bECMWBcUq4ZzT8PJwzN2WpoQ2
         lMheyYHC7o8lKLhvrMO08ebk4F8xR19U1VBGoK2QI7yH8BPIkRc+sIiPLbdQhrU92NeG
         fZs+IdcEKjMy1lUAmeGQDU5S/0qZMCJSOvsgDNXKkS49C/WOXPQg+kRZLODNGXLlO3uV
         tNIUfhMGz5BEf2P99bFttYU0pDxCqUw0HoAra7Ey+saD2eFw9p7IGzjAY+xIk0Ibgo0i
         Im9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768398436; x=1769003236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jT5+6PNxAsiSLc4phs+HsvpCwG6ks9aQbUheKgFsmM=;
        b=lBTTy8gF7xvwxHvS7o+wJ97RVm/LkCJFWZzOopMKA2xuRaf8wWjqykTZR9ASKq22P7
         OELVLqe1uiiuLoxkbWvyEUSpK9aj+em1+tvh4b2IXEiAmYh8BMX6VsycxQtU1SjRyA28
         8T9XUua2T2i1f3hK6ed/qpmE7tqE4nsUxnc4qLyidj1Fxd4Vsm3MTGaA3y0+PolAWY2f
         MWVMJ+KJV8PBrBPDnsa94nLnY3+hE7KvQ/sWIR2BmlDV7yUFeDTOFwYr9zOscEolTBWN
         PeDoei6yXCCcOPDtxelVuzSpsknif94RymDx/tErWCf0ZshviaUJSBuRZ2qO90gdny6f
         Furw==
X-Forwarded-Encrypted: i=1; AJvYcCXYjFH2LzenLvU+zka6Wrtpv5D/YWMo42egJaovKLbKDEcVme6qSTuw84wG/SERB70Vu+J1hqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK23unCjVsT9HjGErZ0KHWTT9URRq3qQexDOfODqzAWKUcdMoq
	cWzPi+uSpieB4/tp3p8/17ZF7FqAtP6OBuJ+LaXbawxRD71SvpphEsO5
X-Gm-Gg: AY/fxX7mbbYcdtqgfC+Gy2Xmjk7iQMabgwnEtXcHUY8BAm0ct2Vz5ERcR4qwtl8TJ66
	DEXC2fetZDi+dG9fFGLEWx9Z1HBrBPQH+pMHfzIAbl7GifN+gyNX9mtGg2oohuIlR88kvZ5n0DR
	Ll/+odBgbU4lfZovNtorPflO19Sik0gUcRgjsl2etJXpqAV2D3h8QAeinM9F3bvISdZxyDg+HEG
	XpaOYLknVXwq1YggWGp8VIddzwgDSvdMi7/NWoT0Z/0zDVMAra3j11ARf90HrKiqL0/cuuy47nA
	EQHQ4rWHPfGXyZCffDzUtZSEfAjB2V4hI/9TkadSwc8XBfar0eViIxR5nv7hoN3yXrb5HHJto8e
	ErnpKNYgm6oQHKPcrJB3Mo6pc20++rknS9KBncSazKPvTTgV5Zt5+ZvySgR5E+Xofc5LUW8cus6
	3Du6jKV/sNH8xcPRp164Bu5jo15OvoX09O62lTQbNDNCK9bK06P2pY
X-Received: by 2002:a05:600c:83c3:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47ee32fcf0amr27966825e9.11.1768398435487;
        Wed, 14 Jan 2026 05:47:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm5184825e9.16.2026.01.14.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:47:15 -0800 (PST)
Date: Wed, 14 Jan 2026 13:47:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, frank.li@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] net: fec: use switch statement to check
 the type of tx_buf
Message-ID: <20260114134713.565f2b3c@pumpkin>
In-Reply-To: <20260113032939.3705137-8-wei.fang@nxp.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
	<20260113032939.3705137-8-wei.fang@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 11:29:35 +0800
Wei Fang <wei.fang@nxp.com> wrote:

> The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
> FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
> to check the type and perform the corresponding processing. This is very
> detrimental to future expansion. For example, if new types are added to
> support XDP zero copy in the future, continuing to use 'if...else...'
> would be a very bad coding style. So the 'if...else...' statements in
> the current driver are replaced with switch statements to support XDP
> zero copy in the future.

The if...else... sequence has the advantage that the common 'cases'
can be put first.
The compiler will use a branch tree for a switch statement (jumps tables
are pretty much not allowed because of speculative execution issues) and
limit the maximum number of branches.
That is likely to be pessimal in many cases - especially if it generates
mispredicted branches for the common cases.

So not clear cut at all.

	David

