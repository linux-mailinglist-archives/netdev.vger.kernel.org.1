Return-Path: <netdev+bounces-165369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7BA31C18
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B663D18822E4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCD76088F;
	Wed, 12 Feb 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upCCDRQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59254271817
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327609; cv=none; b=t35QG/BCR4Q8YmZArdArgUUejAw4AnoDVVKbhqUv4DswR9+2PhSQhghA+weT694VntgBSkzE13UQoTvPBMM/LFMtq851iJMhQ+8EUuNeWDxB8eQpzhCjCC/khUPzXMhato9u2NlW1Dcg8jfN1tvo8v515cJ53whCzrIIupSt8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327609; c=relaxed/simple;
	bh=sShdZ3ZQGlj1pgyugzzTfV8HNsgEZroUELCQs4Wl/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSc0HW3dboKOQ+U7x1E5zupMVwKw7GNhedOYS2M58mkWpmcUkKEdloAm+/DZ2H5Ppp1biU+kOi/bDlKX57Du5YnU2V4u4gwmo1Ga2kH56pxred6CfbbTa32DEDdQUKp96plmbXtYY+WbThzKiWmjFgP+GIu9KwmSaTessUrbn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upCCDRQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F2C4CEDD;
	Wed, 12 Feb 2025 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739327608;
	bh=sShdZ3ZQGlj1pgyugzzTfV8HNsgEZroUELCQs4Wl/w0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=upCCDRQK+uvj2IgKwjkmV0/EK3b8TI8niWJ+BtFdjh4LUubCcxtNEiJVok7adu6G0
	 1JVCHcVFSD+vbw77qAfhz70IDcqKLZMBAOE7sZ9UDiNdSOxMsFAdTmMZxGk6A4TbYl
	 PRDannEK0npNK982E/BFwJvthsDTC8heXmS704e1oruGvoVoDl9e8xXgYkmys+MAuf
	 ODnMK7n4aeJXd1icwpRZVqmbRUpK5OAakVyh1vMMMofOUwe+mk6iTPF5RyrAe5Zs0/
	 u4j2JI0ZIjTZBBWBAncL9UBRyBV25TKyFVNhHxhDhoaLZWMBrcbdxaOIa0J5UL9q35
	 flKnOa9ia3Pwg==
Date: Tue, 11 Feb 2025 18:33:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 04/11] net: hold netdev instance lock during
 rtnetlink operations
Message-ID: <20250211183327.21d685cc@kernel.org>
In-Reply-To: <20250210192043.439074-5-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
	<20250210192043.439074-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:20:36 -0800 Stanislav Fomichev wrote:
> @@ -11468,6 +11387,18 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
>  
> +static int netdev_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b)

over 80 chars, fwiw

> +{
> +	/* Only lower devices currently grab the instance lock, so no
> +	 * real ordering issues can occur. In the near future, only
> +	 * hardware devices will grab instance lock which also does not
> +	 * involve any ordering. Suppress lockdep ordering warnings
> +	 * until (if) we start grabbing instance lock on pure SW
> +	 * devices (bond/team/etc).

mentioning bond and team here may be misleading, add veth or dummy
into this list? Otherwise it may seem like it's about uppers.
For other devices we could probably sort the shutdown list, and
we would be good. But yeah, we can defer.

> +/**
> + *	dev_change_name - change name of a device
> + *	@dev: device
> + *	@newname: name (or format string) must be at least IFNAMSIZ
> + *
> + *	Change name of a device, can pass format strings "eth%d".
> + *	for wildcarding.

Would you mind making these kdocs suck a bit less while we move them?

No tab indent.
round brackets and no tabs in first line, just:
 * function() - short description
Document the return value in the kdoc way:
 * Return: 0 on success, -errno on failure.


