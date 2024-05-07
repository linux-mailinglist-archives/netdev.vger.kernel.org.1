Return-Path: <netdev+bounces-93913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02848BD930
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6769D1F23881
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E2D139F;
	Tue,  7 May 2024 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+W0Ru56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2E1877
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046691; cv=none; b=c/f0jkjrZLlSDibtVfVAySHWkF0Tf3AmnX573AWAEnfrcCxR7ANK97BJmsV81PozEv3uC/55CfizHg3pu9KJaynZRMs/Mhb4nsAyce2SBCDcXajwpQwQ/Rn9lA13aex6bB/chb4YqQv642ftytn/DrObvhSDSSRdH8re8OUZXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046691; c=relaxed/simple;
	bh=EPp/NCR8rJBsBjDgow4xgmUIZBRhB9F5MI/fu0MG5uU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CP+4x5eluN79yfR8f0arbKKAwMIu1NjBItCgXLpy9O+zcmvjNjl8mOIctf3ZdnsLE4cto679qczRj4BdtQspNQj+imO0gAfBw0+P+AP7k31KSqpslnsXv0AKi6VQD1LOR/5fafaa8wrep8pFr/hh35KBLwSh/TEFiXqsuvGXVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+W0Ru56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429EAC116B1;
	Tue,  7 May 2024 01:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715046690;
	bh=EPp/NCR8rJBsBjDgow4xgmUIZBRhB9F5MI/fu0MG5uU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p+W0Ru56ADb8Mevuv2Db43QRnI4j94Ds3MDjyBo04hbHROW8C5Lzi0xbXOVW9H9na
	 Gkd/1T7f+oCHHF7D+BfxbTFFm2SFbD1uPg+9UPh8K+B47yWH7DslBcxzwC6ZiQqqJ4
	 e2ZntmurUzNzXslVW1F24CIbU8j0HNggIsJ7Rg4qmLQxyDdSX6wlXgonFAEiwQDrmD
	 s/+0VoLPbXgvzHzJR3FTvlMm5JQz5xWeav/LZ14ID9+zkyOl3Oa/IlHMOH+mVYIP3K
	 Xe1mz6cPNOpeFSfkMs8WY3hNB7NCWN8cHBouU3Z8AcNubkN73ojTZ6hJzcoCLI896+
	 mDEY1/bDWsprg==
Date: Mon, 6 May 2024 18:51:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v4 3/6] net: tn40xx: add basic Tx handling
Message-ID: <20240506185129.7c904763@kernel.org>
In-Reply-To: <20240501230552.53185-4-fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 08:05:49 +0900 FUJITA Tomonori wrote:
> +	err = tn40_tx_map_skb(priv, skb, txdd, &pkt_len);
> +	if (err) {
> +		dev_kfree_skb(skb);
> +		return NETDEV_TX_OK;

make sure you always count drops

> +	.ndo_get_stats = tn40_get_stats,

ndo_get_stats64 is the standard these days

> +struct tn40_txd_desc {
> +	__le32 txd_val1;
> +	__le16 mss;
> +	__le16 length;
> +	__le32 va_lo;
> +	__le32 va_hi;
> +	struct tn40_pbl pbl[]; /* Fragments */
> +} __packed;
> +
> +struct tn40_txf_desc {
> +	u32 status;
> +	u32 va_lo; /* VAdr[31:0] */
> +	u32 va_hi; /* VAdr[63:32] */
> +	u32 pad;
> +} __packed;

Can these be unaligned? There doesn't seem to be any holes in these
struct, it's not necessary to pack them unless you want them to be
unaligned.

