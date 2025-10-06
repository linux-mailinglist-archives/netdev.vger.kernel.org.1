Return-Path: <netdev+bounces-227972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB0BBE477
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14823B69DE
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B52D3228;
	Mon,  6 Oct 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEqmC/38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5849283FE5
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759699; cv=none; b=cwJsC1QBFwIfc97Xe+hgXTHMkKhF6SzFdy3YD5+G62dGguwXArH3SNM9J9AgvM98ezLIfzrFswXHBkOVe0RmP5CAwHK3J3j9eFNXQWmpGaASNTzRdjTD6kPWUnf2v8YGlIHJrnjKm7v6ePMF4DjMtQbDJTYNjdjRuQx5en9sqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759699; c=relaxed/simple;
	bh=vUAsxRSr+jWgaAglz0wKq5QwGRqqLj1lm4Fs6vdBFI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcV7IRYMSKGPW3RVc+RGUpig/wu5ePpFR5S4V82lPy1qOroGoqmTg+RXOFmf1DG3dr//w26y+1kt2OxM6WACFW/2hGcEXYgMSr6rW/jiG489eQDinclgSweodGnxSSBEBM6uBgSxpctAkZT/Js+iFz4P97PKkQ5MaO11Pln7EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEqmC/38; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-64e58fb2789so2185553eaf.0
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759759695; x=1760364495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9euP7FGBJ3Mnsaw5UhcopJybLIQRG3ne8ZMpXXyWR7k=;
        b=NEqmC/380vhFlMkNg86zK6SU3CAqZGwo8lk0sx1eDlXcBTbgY13tvd8x7DNr10z8aj
         pgBH+hDcbr+2Zq4i9EyAblD/6iRONQyogICEE5ARz5wHcRRJjU32bDvallenDCxN+pqn
         pXA/bBJ3radSyCXWaozriCdnd0yERiOLPRqefNrRsiAvEooT8x+kw9Qztxw7mctfsFGI
         ta12nzAEF+//gBcUYslAyXyJ3txEv8W8pTHcBgQ54Un1kZqZUpmXn/CMFhgB41ao3Ytx
         12fd63ASYx5qyFJkV6VIPS0n54Q6w+9yUG6jGOYYNjm6bA9yBIti25To885k1teh9MdG
         Jdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759695; x=1760364495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9euP7FGBJ3Mnsaw5UhcopJybLIQRG3ne8ZMpXXyWR7k=;
        b=FxPfJROb1VBMOxuUit+Ulqg8pPL8jMSw4u0rRIFvi00SQPn8QSUhIZZaGEIlW5sP0e
         aW/ispw8Az2k9kVVjutsnzkhhcgdbK9SoUUT1aAkfLzR+XuNrmsE6r8l4ud3i1eOrYdp
         YpvjX7oj9zieQgSyflO9if0z/i7YSx6FM/QHUeRLQGRSpRT2pJnslZjlIP/20Ek+YaZ5
         xsdhS2Bps4u6ydO1QjkcZ7TF7TBMrKnSGciehEiAxjBIxxaNz6Ew9krhJzLo1rhUrfPG
         t+q3yPUhJgdjuObrKWPHu45F2f0Cebg1uK5WCVPIkhzDm4Az2Wfq3UcMWd1jskRAYz5X
         gbTw==
X-Forwarded-Encrypted: i=1; AJvYcCUsFFItlV3EWrJjwv6dRL2ke3LBxQAKi5iA38sytXUzjayb2wT2KUCh8eEKnmUgzHfRW/ogXmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCD71z2Fcz9gKwkOSKOQMKQtT6jIttfXBzF/upJyilk23IKa7V
	U4BIKEKHDLeE3bzXLUvFr0HA79r2nvZDRYelJVNsm6KTgLTl4aT7y51f3zUDMpWr7OyWQ+F5z/0
	3ToQUup8pzZZMmDRR1wr17qb9/23wKUg=
X-Gm-Gg: ASbGncs6+OGBwn9o2P6FD3TJCHQ9esNjNmY9zi/4kLQDwTOWu6n4ZEWOJjQ2BlnwvQA
	GVusZ8IYeS1fvhatEMaCKfH39DDVjL6nPqwQnT//oyo7Oc5/1LjDv8Dt0KV1bLAu26pZywGPKOI
	v/2PmTgadJYUfx6rAQRSmDObvwCmt5SII/ZU7gXpVZmb7FrUIHVMBGNZHHUVe1O2IYrLZ0zLL93
	Ob/VVO3Bsk5FLZaGs/qYo8AfQ3WXCJTOmSAzUi0G/O7/10PW9VDbRU1C9AxCrttE8JJFXsM
X-Google-Smtp-Source: AGHT+IG9G9DF1YnmrpmfqFP+MFypKlh0tyC8fDD+ikO8KOviGTb+AZDk2RURQyCBPwlv9r2dMfpxzay33ZISfubXUZ0=
X-Received: by 2002:a05:6871:7a5:b0:31d:8964:b4aa with SMTP id
 586e51a60fabf-3b0f3d1d438mr6629829fac.6.1759759695419; Mon, 06 Oct 2025
 07:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002184950.1033210-1-one-d-wide@protonmail.com> <m25xcssae1.fsf@gmail.com>
In-Reply-To: <m25xcssae1.fsf@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 6 Oct 2025 15:08:04 +0100
X-Gm-Features: AS18NWAVLzQxyb6mWjCm7Ybf0iTs2SE7mbGAFrLTnPv58cwUnJ-50UvOrDz_UO4
Message-ID: <CAD4GDZyvO-Uw73hRRhcu7ZSuhXR_XmpTzx_GVyO5qFVukov4dA@mail.gmail.com>
Subject: Re: [PATCH] doc/netlink: Expand nftables specification
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 09:29, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> "Remy D. Farley" <one-d-wide@protonmail.com> writes:
>
> > Getting out changes I've accumulated while making nftables spec to work with
> > Rust netlink-bindings. Hopefully, this will be useful upstream.
> >
> > This patch:
> >
> > - Adds missing byte order annotations.
> > - Fills out attributes in some operations.
> > - Replaces non-existent "name" attribute with todo comment.
> > - Adds some missing sub-messages (and associated attributes).
> > - Adds (copies over) documentation for some attributes / enum entries.
> > - Adds "getcompat" operation defined in nft_compat.c .
>
> Can you run
>
>     yamllint Documentation/netlink/specs
>
> The patch adds several errors and warnings.
>
> Cheers!

Can you also use the nftables schema with the python cli, or at least run:

./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/nftables.yaml

(This is something we should automate as part of make -C tools/net/ynl)

The spec has a lot of schema errors to resolve. You'll also need
changes to the netlink-raw.yaml schema because it is missing the 'max'
check.

diff --git a/Documentation/netlink/netlink-raw.yaml
b/Documentation/netlink/netlink-raw.yaml
index 246fa07bccf6..9cb3cc78a0af 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -19,6 +19,12 @@ $defs:
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[0-9A-Za-z_-]+$
+    minimum: 0

 # Schema for specs
 title: Protocol
@@ -270,7 +276,10 @@ properties:
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
+                  max:
+                    description: Max value for an integer attribute.
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'

