Return-Path: <netdev+bounces-105841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FABA9131EE
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 06:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE77286511
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 04:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE831374C4;
	Sat, 22 Jun 2024 04:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gfuDyCNM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8A2D02E;
	Sat, 22 Jun 2024 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719030471; cv=none; b=dVp+/rN1wg582rt43v2xTMSeEPzTjVNDD8QSzy+s/oyFsNKsMSrQBZrEGniNrBSFSSYbbHZppWVl96CkAGOHs4KjLVBjeqqxldOJqqUxce4kAXjKbz0uB8zU4ywUX5vHcpDv55fYO6gsIk7N6xfvPd9lpscdfkkEs9FkF4rOfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719030471; c=relaxed/simple;
	bh=ItteozRxD9pZl0Vo/EkeGN+3dFzTCeY/ora39soN/1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ko5Dysxl4I7n7GAHPawS0/H7gzILqOz6+GCJCjlTBBCX+jSuKOeAqyMPfOKH+QBday6pKblfClZKw+sTBeWgCntg5yZ+ohrG0/uFewYzaY4vVerh0JXfLJ+9vZNvG62BwBLilCx787lEa5QljGdTYzKCwmLEGKNvLoz0UvtxNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gfuDyCNM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719030460;
	bh=/VVyoTFqBHv0DbfaJoIZVT/jCvwNcFS1WP6GyNkTAeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gfuDyCNMt/fwzbmPByYmLccOW0b2JS0DQfgb5a0Aw7JvniOtsRte9Jh6LTsQW1jjy
	 L03nHizw9R55fA0ERzscVZ0Mumd4W+t2BSjAgm5xrPAartRiZ+7UtRp2NdQERSvgqf
	 w9sVZrEw69YgjuOcyDaaEvY3ZGD8DOfeXNjCuaash2hvrV1i/L97UXqJvy2rzu8VMO
	 8n76/lCsFKBOgWFFpbkREVf964cdgABz1erMsSgPBC6/nInWI1uCUHiYXxHMV3Yvxs
	 OFLRIZsGDD7D/3xPnqGUAgqM7swfdsFMkKi1dQ2e2ftGDu0fqKVbYgohzMcfKOyKtu
	 To9SlW6KAh4qg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5h6046pKz4w2S;
	Sat, 22 Jun 2024 14:27:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, ksummit@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
In-Reply-To: <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
Date: Sat, 22 Jun 2024 14:27:34 +1000
Message-ID: <87v821d2kp.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> Based on multiple conversations, most recently on the ksummit mailing
> list [1], add some best practices for using the Link trailer, such as:
>
> - how to use markdown-like bracketed numbers in the commit message to
> indicate the corresponding link
> - when to use lore.kernel.org vs patch.msgid.link domains
>
> Cc: ksummit@lists.linux.dev
> Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat # [1]
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  Documentation/process/maintainer-tip.rst | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index 64739968afa6..ba312345d030 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -372,17 +372,31 @@ following tag ordering scheme:
>  
>   - Link: ``https://link/to/information``
>  
> -   For referring to an email on LKML or other kernel mailing lists,
> -   please use the lore.kernel.org redirector URL::
> +   For referring to an email posted to the kernel mailing lists, please
> +   use the lore.kernel.org redirector URL::
>  
> -     https://lore.kernel.org/r/email-message@id
> +     Link: https://lore.kernel.org/email-message-id@here
>  
> -   The kernel.org redirector is considered a stable URL, unlike other email
> -   archives.
> +   This URL should be used when referring to relevant mailing list
> +   topics, related patch sets, or other notable discussion threads.
> +   A convenient way to associate ``Link:`` trailers with the commit
> +   message is to use markdown-like bracketed notation, for example::
>  
> -   Maintainers will add a Link tag referencing the email of the patch
> -   submission when they apply a patch to the tip tree. This tag is useful
> -   for later reference and is also used for commit notifications.
> +     A similar approach was attempted before as part of a different
> +     effort [1], but the initial implementation caused too many
> +     regressions [2], so it was backed out and reimplemented.
> +
> +     Link: https://lore.kernel.org/some-msgid@here # [1]
> +     Link: https://bugzilla.example.org/bug/12345  # [2]

Does it actually make sense to use the Link: prefix here? These sort of
links are part of the prose, they're not something a script can download
and make any sense of.

I see some existing usage of the above style, but equally there's lots
of examples of footnote-style links without the Link: tag, eg:

commit 40b561e501768ef24673d0e1d731a7b9b1bc6709
Merge: d9f843fbd45e 31611cc8faa0
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Apr 29 22:29:44 2024 +0200

    Merge tag 'tee-ts-for-v6.10' of https://git.linaro.org/people/jens.wiklander/linux-tee into soc/drivers

    TEE driver for Trusted Services

    This introduces a TEE driver for Trusted Services [1].

    Trusted Services is a TrustedFirmware.org project that provides a
    framework for developing and deploying device Root of Trust services in
    FF-A [2] Secure Partitions. The project hosts the reference
    implementation of Arm Platform Security Architecture [3] for Arm
    A-profile devices.

    ...

    [1] https://www.trustedfirmware.org/projects/trusted-services/
    [2] https://developer.arm.com/documentation/den0077/
    [3] https://www.arm.com/architecture/security-features/platform-security


The above style is standard markdown style for reference links (or as
standard as markdown gets).

cheers

