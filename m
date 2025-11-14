Return-Path: <netdev+bounces-238564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CE1C5B00A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DBB3B4712
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A7022B8CB;
	Fri, 14 Nov 2025 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/k2Vp3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD721E087
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763087117; cv=none; b=YDxQbjCTw6OLqUpzT3a2tjD8bXgnWg4G9BASw/N3OJp0XGsAhAjuH+79u7vU28UEu01dFrKJfvBGQG9ib79ukPa/dRUXq+VS7TYfZWG1gr3DWfry72yLifu2LxcfDp3ToE2HEdc/7w21WtYWO5i3udKZNYnnCtrYPTpqw0DZMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763087117; c=relaxed/simple;
	bh=CvykzJHEwP9AP747SyPRIjR49qQc4nF8hrUyqgVYcDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbcHUmfRvbFpGizxEESkv5tP1qjxF0zaMFWTCCyOupCoCbr5E0wJzihu6UJxuCKbOjDvcRGcRT2ac8vbaXACmJhbWDExToIS5shQCCnTVpSwQyooe5Dq5WXPVeAhFtEePKaOFuodiDgd2n4sy074Eq7xTYrgIBeOUYvBtfBd1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/k2Vp3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70B4C19424;
	Fri, 14 Nov 2025 02:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763087117;
	bh=CvykzJHEwP9AP747SyPRIjR49qQc4nF8hrUyqgVYcDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P/k2Vp3dHFrmVm/4ABvdtB4lGhNX7CVR22e1743wtEX8GxUDpIOnnjhOGxekvc8y2
	 7cA3eFCjDx/VbJY0709+rPki0ucqm7Jfu9V2RzX8xrCR5QM2DXwD3hKqjIXu/NWvlb
	 iWW4Oebw33DXfEI+H1wWJwz4fsxzbMmot/HffKUfHCwMvQOfPz+9y1jxcYM0XvlHW0
	 F3UBRshTSOqfsEzXhzLpxur7Z0SGhQH8FF7HzWOie1GR7Xf6aj+TJQNqNtm6xkwH0e
	 7kZe3YbrlD7FkFHAz9dwwjQSmh8XSSCJYhGU47ADgic4QNGmHcAFSs0Tp8tEWTnM48
	 FQnJQ+HxjazKg==
Date: Thu, 13 Nov 2025 18:25:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ralf Lici
 <ralf@mandelbit.com>
Subject: Re: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in
 one chunk
Message-ID: <20251113182515.1b488301@kernel.org>
In-Reply-To: <20251111214744.12479-7-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
	<20251111214744.12479-7-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 22:47:39 +0100 Antonio Quartulli wrote:
> +	/* adds enough space for nfrags + 2 scatterlist entries */
> +	len += sizeof(struct scatterlist) * (nfrags + 2);

nit: array_size() ?

> +	return len;
> +}
> +
> +/**
> + * ovpn_aead_crypto_tmp_iv - retrieve the pointer to the IV within a temporary
> + *			     buffer allocated using ovpn_aead_crypto_tmp_size
> + * @aead: the AEAD cipher handle
> + * @tmp: a pointer to the beginning of the temporary buffer
> + *
> + * This function retrieves a pointer to the initialization vector (IV) in the
> + * temporary buffer. If the AEAD cipher specifies an IV size, the pointer is
> + * adjusted using the AEAD's alignment mask to ensure proper alignment.
> + *
> + * Returns: a pointer to the IV within the temporary buffer
> + */
> +static inline u8 *ovpn_aead_crypto_tmp_iv(struct crypto_aead *aead, void *tmp)

nit: does the compiler really not inline this? the long standing kernel
preference is to avoid using "inline" unless it's actually making 
a different. Trivial static function will be inlined anyway.

