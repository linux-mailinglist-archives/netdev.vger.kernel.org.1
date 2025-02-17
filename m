Return-Path: <netdev+bounces-167097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1465A38D47
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E01891809
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C1237703;
	Mon, 17 Feb 2025 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CTd9i/QV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3OcKfr/5"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6C149C41
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823831; cv=none; b=e8xX3K9JjHodYe6r9/QV3H2Q9/VF2VcNGfHdfXmTOJkIOcYB7YNtvbYrAVz9KMfXWyK0pFhkFJJWqfn6nUCmJJPk7B0nwqd9NWcK2aXc5HlU7+kciJrdJt/VSSIcKIGHANgAFWEOL8D5AkOpfNwhsUGnaWBIo3eL1L1oSgsuZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823831; c=relaxed/simple;
	bh=ufBc15Dz+HhZR0kkJ41z7UE+kjhL8L1t5FJCwOq/yEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HSaGTd6d32V39ob4fUJ5tGTiK9K+ZNDN0Bj+im1IQtnmYcIMj4Wd/vimDxmpSaZxnWFf3oqtN/uWvM0oYljuY1ZQl0HJInNGLjj/jggumetr6zQDBrRppS/WEiPwJgLCglDBS8YtPBINKSSHAvpGiaZx46y8EyuClBgsJ0+2g10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CTd9i/QV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3OcKfr/5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739823828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufBc15Dz+HhZR0kkJ41z7UE+kjhL8L1t5FJCwOq/yEc=;
	b=CTd9i/QVR/aU7asse2JcRRvf4DmChU/wVzQRW6g+BaECO5038nqNSaYi4GlFrMKFtx1SSU
	k/Q5IkuaY7UtZBwnxrx/oLU1LGkfoqPiG2Y7Yk3qmDoMvGu7fDXYlMktquYXKm2y+dOsta
	snyj8jSeE0z5HgYoHjbqWvxhBRJRmQy/NKfqTxdXFItaKj2EJGtaLgz/TKFXsT8qbTSLKx
	xFKGHdTs251rE5QD5nVPLNaEIDFt4yElONVUme27nG5Lj4NFmWS3TZ6DTn25bSPHE8z1HM
	nSX1UMP6zJQcgkwrdXxY16yLgoT5nhc6NUbkMWvW5g1NFal56dD78UGDrMCnxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739823828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufBc15Dz+HhZR0kkJ41z7UE+kjhL8L1t5FJCwOq/yEc=;
	b=3OcKfr/5NfEzN2C6XikgRXOf9DxVTINoX97L9vEzDm+UuEu81yLAzNNJLdRxUWCck834FT
	yWVeve91JzsBC6BQ==
To: Wojtek Wasko <wwasko@nvidia.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 horms@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 1/3] posix-clock: Store file pointer in
 struct posix_clock_context
In-Reply-To: <20250217095005.1453413-2-wwasko@nvidia.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
 <20250217095005.1453413-2-wwasko@nvidia.com>
Date: Mon, 17 Feb 2025 21:23:48 +0100
Message-ID: <87frkcjp63.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 17 2025 at 11:50, Wojtek Wasko wrote:

> File descriptor based pc_clock_*() operations of dynamic posix clocks
> have access to the file pointer and implement permission checks in the
> generic code before invoking the relevant dynamic clock callback.
>
> Character device operations (open, read, poll, ioctl) do not implement a
> generic permission control and the dynamic clock callbacks have no
> access to the file pointer to implement them.
>
> Extend struct posix_clock_context with a struct file pointer and
> initialize it in posix_clock_open(), so that all dynamic clock callbacks
> can access it.
>
> Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

