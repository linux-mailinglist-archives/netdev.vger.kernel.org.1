Return-Path: <netdev+bounces-206950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474EB04D87
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8842F7B0026
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73E0288C15;
	Tue, 15 Jul 2025 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrUBhGQr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B501A5B8C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543490; cv=none; b=fDVf/2MqMOBwynFhifRTLHWD4yjbxZsPEemD+C/IJvJsr8ykN+YxTqx/nst8E/eXLO36BiomvBS2MVkqeZEwx536OYe3y370Fkca75h3YkpFw47jLgYuPF9bgGOk7vFLWjwJve4h3BS4t4QSGBUvrIVAf4gPtfb7wvuPyIYTW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543490; c=relaxed/simple;
	bh=cNCNmllpS8iWCQasfVOHi8kmn6fKsyd2/XJHLexMlJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDtjI7KDnD3S54naseu83R0+olhqNFTqBzIXdYpNX/vfkNbVxzjY6Jd764f/y8qTRUCvz9PSjX21Q9rhCC+wQfWaoCI0pw1XNR3wvtLgoew2J9ZPvBVZ69qgSfWBxIUS+FYePqXbZ0EqcEzOhkd/BaJ5vjA6Kjk5Wbc4uZynPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrUBhGQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042BCC4CEED;
	Tue, 15 Jul 2025 01:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752543490;
	bh=cNCNmllpS8iWCQasfVOHi8kmn6fKsyd2/XJHLexMlJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrUBhGQrCGeU1PlCUHqPFewMY24KjrS//fwrBFKGOSFD4vQgPIcL24NxHUFN2PaZB
	 yzlICJwTfGe6uA3p2IhFNPAh9a+IGZ8RKRQW0Re8SaSoOYKBqsCmTyRN35CVlwJ9Kw
	 Lfae8Jp8t+wboKDrKrgo+bkxz8CsV/EDTtsxXB87rWLFH/VRkHegnY6fRyGhRhZTL+
	 CRnvX2PJwO87USsomaoy1PNkjp9FAYQmAkWHS+yYQL0L3jomf8NnDk8LuQ0NBGXRbw
	 kt/5vs11W4mpKxUwNXJz9tEVB4d2ifBNXnWK6tW8jj5+F7QpQX+qTiYSOXklyVwxCj
	 6GGgTK8qSSFYw==
Date: Mon, 14 Jul 2025 18:38:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/8] tcp: do not accept packets beyond window
Message-ID: <20250714183809.02ed2853@kernel.org>
In-Reply-To: <20250711114006.480026-2-edumazet@google.com>
References: <20250711114006.480026-1-edumazet@google.com>
	<20250711114006.480026-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:39:59 +0000 Eric Dumazet wrote:
> -	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
> +	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field.
> +	 */
>  	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
> +	/** @SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE: Not acceptable END_SEQ field.
> +	 */
> +	SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE,

FWIW this is not valid kdoc. We can either do:

	/** @WORDS: bla bla bla */

or

	/**
	 * @WORDS: bla bla bla
	 */

but "networking inspired style":

	/** @WORDS: bla bla bla
	 */

is not allowed.

Ima fix for you when applying.

