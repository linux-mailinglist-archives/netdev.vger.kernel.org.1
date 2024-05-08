Return-Path: <netdev+bounces-94656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1318C0102
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB41C2074B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAF1272C0;
	Wed,  8 May 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmK1xxQm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149D28E6
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182401; cv=none; b=XAwQRfsPG48U7WeR5pD3sQaIiRC1bb6NAP5jEBTvFKCYDitbD8JrMB0zbaX1wVqzxMoVqxrQh092WghkAxPfVyBIi4W9fZN/Rs/YsDlsOE7qmQpmoOlPvC2PAEW5cjXNmHZ4lJzJ76yw6cuMW05YD0ku5Zn66pjcpBACO5Z845Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182401; c=relaxed/simple;
	bh=f/2yQZEw+yNsbmSK7ll579YoXQRVzp5lQ3w8ZC6iKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLQoyzlYxtI0LQnsjEqCum4CfyUJE7I0GG717MRqxpL8tmN1E6cuW3P+KVLRLDs1JGGGD1b661Tcih9OsXUhb8wtIvsVwzlkXugFWWBA6FGKDlRdXA4tU+R2trMddVTu+X4js3RZGnuQDgME0gvAwvnVFoxEkUHF+MDQyRrbZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmK1xxQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBA7C113CC;
	Wed,  8 May 2024 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715182400;
	bh=f/2yQZEw+yNsbmSK7ll579YoXQRVzp5lQ3w8ZC6iKfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XmK1xxQmrn3BTVuddLW7rZ8WQfh03kZZ2KAVXCQMa934Q39RlIkQ+3C5u5kzXPcjy
	 UEITXurIVCkD9/5PnaSoUxNzVqGjHRMiNl16B4ryB8SozQKjLHkwDa3MbNozCdQdSs
	 H2opSKMUWvxTTFKWBn+ivdW3SNaegvSj5oUp+/EHc9WizFs//E5niwxGnbXMH/rgNG
	 OstIukoaS8B+RL8nSF2RtS8x9XARcXJqFSSQG6Yl1Deywx07EVlZMk3GeXZmQU+sDc
	 v62w+CZXNCd6eXf55//Il1lScAz4VMccvxD6k9/ygqw0AbenR/5w06e+lqyAJEHzxZ
	 jQrVAuY5A8Yew==
Date: Wed, 8 May 2024 08:33:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>,
 "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
 <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
 <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH v1 net-next 6/6] net: ena: Add a field for no interrupt
 moderation update action
Message-ID: <20240508083317.62897ef1@kernel.org>
In-Reply-To: <6f5415915976495f8252411c317aedbb@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
	<20240506070453.17054-7-darinzon@amazon.com>
	<20240507193111.5d24343c@kernel.org>
	<6f5415915976495f8252411c317aedbb@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 05:55:50 +0000 Arinzon, David wrote:
> This is a true/false indicator, it doesn't require history/previous value to be considered.
> Therefore, not sure I see the how |= can help us in the logic here.
> The flag is set here to true if during the interrupt moderation update, which is, in this flow,
> triggered by an ethtool operation, the moderation value has changed from the currently
> configurated one.

I couldn't locate an immediate application of the new value in 
the ethtool flow. So the question is whether the user can call
update back to back, with the same settings. First time flag
would be set and second time cleared.

Also the whole thing appears to be devoid of locking or any
consideration of concurrency.

