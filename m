Return-Path: <netdev+bounces-95833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CB8C39D4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8C01F21134
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB94AD31;
	Mon, 13 May 2024 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arn6YUMe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553AD2FA
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715563467; cv=none; b=m5L/xS2BiyKP0JYs3oaaHvQjmRSXG4ZqlWHLUbnQgWD2tQYYH0ckpLXYHtNZ9PVpMwyj4UI2sk33K5vmk1LHtvbAnst4FoWu5gTS1bvPHMadEc2Xb8+KX328xCYsImAxag0vAXCyvFEP5NM27LjBVNCNfp5Wd4/9UKzuX3FmMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715563467; c=relaxed/simple;
	bh=LlXQo3sKIwT2IY/wZ7wfNTtcKkO/RJq+y53GfmxnhdY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pUkJm71fGY10pZiLrHfhImqjDeTUQV2M7K+l7sBzhFLEEqkHg2E+SEdY1bsSXJsDY/2Gw4/hHYFfzkWLWc9+AnklNQMu7BSZasaYYllNcXKyPwWQhhTgg3WkkfCMYUZONi2Yj0AfckWX2Nftgk6hJMmkDVvjMbDGj2ES8ZqqMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arn6YUMe; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c99257e0cbso2195281b6e.3
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 18:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715563465; x=1716168265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD5tX6zq2BS6Nk3g3GfewzYpg8do5Y470H3Sn57JoUw=;
        b=Arn6YUMe9U/8pCitir9AWs1TxKrSbWsGyQcqM/UWIN4dXmMBxR9+ZLoXzyBf2K6O5K
         BgjCnJ15kNaiAWxda+KrIDom82oQPrpPpIfrCmBmWM2wAG25tBW/Gx38k5vtWBlvR/RW
         dUT9sAn6m7hXsyCel3VvyoODIB3tS6f30MrYqhoMW3oubHOAk4E6RHc4mgpclaq5FtOZ
         wNvYG2ZpxAwxJs26BSINL0Cg0kxvPaQTQGhfRZyexEjXqtPVBXzMOpDtjOQ+0E76M3eg
         QQt6xAkfIS6gc56mQogc//CVh0e8o1971RjS86KaDX4cMFLRcTEIBAXqLn4XrPtbCiO9
         1XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715563465; x=1716168265;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WD5tX6zq2BS6Nk3g3GfewzYpg8do5Y470H3Sn57JoUw=;
        b=N73m+Yr55WqMdhjvGwRah6KtXNJydNcjyTvbg4C6CWJMO01hQ3gZlqk+slBXc/LNPD
         9VD3tUrbAJyCCmFj6WG6IODDtUkOFoR+jpsDGB5W76LW3mkraE4BVRTmYxUwEdwK+/QE
         gwCP5/gWiUy72BL93vmt/r0bvzDNWsHjYloZc3FahIWxH7syuKyy6U0t5zHd4w8erxXe
         1zmdn54FG3Xum8Eo5osuYKoKNdc8gZaqIp2DCBgIynrTqgYw4rXmilsOwHbefFfr/fgv
         GmGszN+Fb7hVA1NlQd+go+oINhy/CYCqyolM53mGz21lNlZT63Bkqap/JlOY0vsE5jFP
         j91Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1kB2PEBm07iO6nbeh4rdSkv9+CTPlyq8N46qomq24kAElrK1sdyK3FW2hvWGFoVx2r1ydkkxEzz1zhzpjwtStgg/63Cgh
X-Gm-Message-State: AOJu0YwMk6DQ1xE5LBqEgUgShxVfMrOfXJ+ZW6vzhp89taFyG0fvvA5Q
	FrS5w4MyeYOmbsbz/zmf2ceX0S3iirYgp7SwRLj3UIpsY0HDauj7
X-Google-Smtp-Source: AGHT+IE5vFs89+EuxnIk/E+T20TNCwj5PHPyR659RfJhBuDHRPDjvSfmTo+T2248X+0AsvKY9efrpA==
X-Received: by 2002:a05:6808:2208:b0:3c9:717b:2fff with SMTP id 5614622812f47-3c997058d1cmr12926705b6e.22.1715563464629;
        Sun, 12 May 2024 18:24:24 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792da262d60sm113404485a.24.2024.05.12.18.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 18:24:23 -0700 (PDT)
Date: Sun, 12 May 2024 21:24:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Cc: pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510030435.120935-2-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
Subject: Re: [RFC net-next 01/15] psp: add documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add documentation of things which belong in the docs rather
> than commit messages.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/index.rst |   1 +
>  Documentation/networking/psp.rst   | 138 +++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100644 Documentation/networking/psp.rst
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 7664c0bfe461..0376029ecbdf 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -94,6 +94,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
>     ppp_generic
>     proc_net_tcp
>     pse-pd/index
> +   psp
>     radiotap-headers
>     rds
>     regulatory
> diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
> new file mode 100644
> index 000000000000..a39b464813ab
> --- /dev/null
> +++ b/Documentation/networking/psp.rst
> @@ -0,0 +1,138 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=====================
> +PSP Security Protocol
> +=====================
> +
> +Protocol
> +========
> +
> +PSP Security Protocol (PSP) was defined at Google and published in:
> +
> +https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
> +
> +This section briefly covers protocol aspects crucial for understanding
> +the kernel API. Refer to the protocol specification for further details.
> +
> +Note that the kernel implementation and documentation uses the term
> +"secret state" in place of "master key", it is both less confusing
> +to an average developer and is less likely to run afoul any naming
> +guidelines.

There is some value in using the same terminology in the code as in
the spec.

And the session keys are derived from a key. That is more precise than
state. Specifically, counter-mode KDF from an AES key.

Perhaps device key, instead of master key? 

> +Derived Rx keys
> +---------------
> +
> +PSP borrows some terms and mechanisms from IPsec. PSP was designed
> +with HW offloads in mind. The key feature of PSP is that Rx keys for every
> +connection do not have to be stored by the receiver but can be derived
> +from secret state and information present in packet headers.

A second less obvious, but neat, feature is that it supports an
encryption offset, such that (say) the L4 ports are integrity
protected, but not encrypted, to allow for in-network telemetry.

> +This makes it possible to implement receivers which require a constant
> +amount of memory regardless of the number of connections (``O(1)`` scaling).
> +
> +Tx keys have to be stored like with any other protocol,

Keys can optionally be passed in descriptor.

> +The expectation is that higher layer protocols will take care of
> +protocol and key negotiation. For example one may use TLS key exchange,
> +announce the PSP capability, and switch to PSP if both endpoints
> +are PSP-capable.

> +Securing a connection
> +---------------------
> +
> +PSP encryption is currently only supported for TCP connections.
> +Rx and Tx keys are allocated separately. First the ``rx-assoc``
> +Netlink command needs to be issued, specifying a target TCP socket.
> +Kernel will allocate a new PSP Rx key from the NIC and associate it
> +with given socket. At this stage socket will accept both PSP-secured
> +and plain text TCP packets.
> +
> +Tx keys are installed using the ``tx-assoc`` Netlink command.
> +Once the Tx keys are installed all data read from the socket will
> +be PSP-secured. In other words act of installing Tx keys has the secondary
> +effect on the Rx direction, requring all received packets to be encrypted.

Consider clarifying the entire state diagram from when one pair
initiates upgrade.

And some edge cases:

- retransmits
- TCP fin handshake, if only one peer succeeds
- TCP control socket response to encrypted pkt

What is the expectation for data already queued for transmission when
the tx assocation is made?

More generally, what happens for data in flight. One possible
simplification is to only allow an upgrade sequence (possibly
including in-band exchange of keys) when no other data is in
flight.

> +Since packet reception is asynchronous, to make it possible for the
> +application to trust that any data read from the socket after the ``tx-assoc``
> +call returns success has been encrypted, the kernel will scan the receive
> +queue of the socket at ``tx-assoc`` time. If any enqueued packet was received
> +in clear text the Tx association will fail, and application should retry
> +installing the Tx key after draining the socket (this should not be necessary
> +if both endpoints are well behaved).
> +
> +Rotation notifications
> +----------------------
> +
> +The rotations of secret state happen asynchornously and are usually

typo: asynchronously

> +performed by management daemons, not under application control.
> +The PSP netlink family will generate a notification whenever keys
> +are rotated. The applications are expected to re-establish connections
> +before keys are rotated again.

Connection key rotation is not supported? I did notice that tx key
insertion fails if a key is already present, so this does appear to be
the behavior.


