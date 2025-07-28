Return-Path: <netdev+bounces-210651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C986B1423C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B29516737B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD4275B11;
	Mon, 28 Jul 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwgavwS8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34059218AC4
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728867; cv=none; b=olXuBq+tKPmm9gA41jOf0F9RQP1PZpl2MmGzd+2ivSgfIf+Mcj8yXDewSmTWMCq1qLgLkQbV8+2E2SonVmylP0gk4qNsEYjHzrhprcq158fqUatCnks0p1EKkOIaKk09eBwKsnwocXmwqvcgLn0sgiD7+xJI0wRpqTgiRmMrHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728867; c=relaxed/simple;
	bh=k65gmv20u1ZM+EkgdD6WRee7XJJqgv4mn+/eHRc9zhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNLFIe2BZGqWL+fkcHGo9eTfQOZsEIlGCm2dcXrS0hN/pv4PAVYBf94dzJZFbw+qfI9+caBokQGPt9lPQxY7F2l/GmH85FmktRVyl8mjxCd/L1sQCSevu/2tT+X1PU37nI9njmDltn6G7FaUvd/TUmXUOiBB155xX+/m+zhkNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwgavwS8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23dd9ae5aacso27605ad.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753728865; x=1754333665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k65gmv20u1ZM+EkgdD6WRee7XJJqgv4mn+/eHRc9zhg=;
        b=PwgavwS8nIxww/og6EbqFSsbgi41L98qS8OUOT4ExrPoRpTeqCLeNcGEeh0CbluOQb
         hiECGRAOH26BLJxQWa2s49DgmEn3hjreExWZopyFghMjUwsF1uZcG613tAHOeH0oy9BB
         v32/e8DcAM54zluSKBAUW9eedNk8ve83ogRqHqHupIUOo8nPisvWjxEC2QDaL06Ih4QJ
         IVo+hPiYBb/sUXsdGEoqM0AvWOFhG3V60ps8w2mXHSfWngEIkkWH6zIAuudeU136yLnc
         hoZdS22oKTNGzZQVT+QXqbF8aIaNDFx5OueSVIaxOBo2WZYudKOAtZwTeOKR0clHHQoy
         3xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728865; x=1754333665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k65gmv20u1ZM+EkgdD6WRee7XJJqgv4mn+/eHRc9zhg=;
        b=WoOBSUVni7QuF8bJ+G5g22FY5yXbb+r5pBDs4Gnb0r3ro8V2rq7xg8ai/wcYtFNS5n
         Y/6/Av8/VHK1JQdKBsiMhT+x2mQZzQDsWiYIPG0CBkV1jXGg2Z/XXlbmLvLifhpQqyl5
         4ratHtNIngtUV46zovbAvVWCPHquxjuNXVzmA6+dC3tcyliY2SrDXMUiv9ITMxXNucO9
         OXX08tOR8F5fNXtsUcSR3hx5LL16XScb2BxTRxPnBvnNYUqup37DjwDxQBh/ac/WoLt8
         SXI6VgRHx3tR1aVRIuBWjghRtoeUODAPBW/ycQ938TIVaN19Wrya2C3oVaD9/ddhGady
         voAA==
X-Forwarded-Encrypted: i=1; AJvYcCXxOVXnd1I3Kc0ulZsPgMW7eOAhgjsQY6k+GUMm0BzcoHdGUkSIKGsYVJI2CsC+6qGhDgWPfbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBOW1UZJFH3DqJ71LhQ2Ny42s8vx4Op+DgTwhboP/XNI44Z6b
	IMDegYL0MyBlYsgZ+ZEB7/lcKHf9rtQU2ae3+cPHXcFbEd0rrsStzAm90Vmp8tMIkdj6oom8nk6
	MVwR8YIF67pJah/PA6/0crLX6eMU3atIEz1jqSRDu
X-Gm-Gg: ASbGncu3P8/Nl83c28wWx3AkcmXGYdxctnCASE2yfzaphCIfUnNt+dsgH9DRUrH6n35
	RtZindlL7rn+OI886p0fBdxEo6t/vTlvfTodmNuj0xpUjnsP1+YsHTgYgE6QJIX8sXT5++BQInK
	lWomcgtAPlk9SgVcpLpmvuOCYNYqdrainQlfQhF0ftOjpByX+CvKH8oaIbdU1ZpcPd0YqE1gBMv
	ZYv6RdE0SZxasf8hamGEX3elcp9HqbkV2HfBA==
X-Google-Smtp-Source: AGHT+IG/DZTSmaKHsprKCdV9Q2aojWsxO0LZXBlVNhJKGj8xTF6s76f/cK53VifN5frM0gYX4u1vA2jwx5WFjG87MlY=
X-Received: by 2002:a17:903:41c1:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-2406789c4c3mr382465ad.8.1753728865109; Mon, 28 Jul 2025
 11:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com>
In-Reply-To: <cover.1753694913.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 11:54:12 -0700
X-Gm-Features: Ac12FXyNUD9YZfoZ5HOXQ7kpyeivuaarWVnbjQRSmqY09ZCfvuOl2u61PG5hmNY
Message-ID: <CAHS8izMyhMFA5DwBmHNJpEfPLE6xUmA453V+tF4pdWAenbrV3w@mail.gmail.com>
Subject: Re: [RFC v1 00/22] Large rx buffer support for zcrx
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 4:03=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> This series implements large rx buffer support for io_uring/zcrx on
> top of Jakub's queue configuration changes, but it can also be used
> by other memory providers. Large rx buffers can be drastically
> beneficial with high-end hw-gro enabled cards that can coalesce traffic
> into larger pages, reducing the number of frags traversing the network
> stack and resuling in larger contiguous chunks of data for the
> userspace. Benchamrks showed up to ~30% improvement in CPU util.
>

Very exciting.

I have not yet had a chance to thoroughly look, but even still I have
a few high level questions/concerns. Maybe you already have answers to
them that can make my life a bit easier as I try to take a thorough
look.

- I'm a bit confused that you're not making changes to the core net
stack to support non-PAGE_SIZE netmems. From a quick glance, it seems
that there are potentially a ton of places in the net stack that
assume PAGE_SIZE:

cd net
ackc "PAGE_SIZE|PAGE_SHIFT" | wc -l
468

Are we sure none of these places assuming PAGE_SIZE or PAGE_SHIFT are
concerning?

- You're not adding a field in the net_iov that tells us how big the
net_iov is. It seems to me you're configuring the driver to set the rx
buffer size, then assuming all the pp allocations are of that size,
then assuming in the rxzc code that all the net_iov are of that size.
I think a few problems may happen?

(a) what happens if the rx buffer size is re-configured? Does the
io_uring rxrc instance get recreated as well?
(b) what happens with skb coalescing? skb coalescing is already a bit
of a mess. We don't allow coalescing unreadable and readable skbs, but
we do allow coalescing devmem and iozcrx skbs which could lead to some
bugs I'm guessing already. AFAICT as of this patch series we may allow
coalescing of skbs with netmems inside of them of different sizes, but
AFAICT so far, the iozcrx assume the size is constant across all the
netmems it gets, which I'm not sure is always true?

For all these reasons I had assumed that we'd need space in the
net_iov that tells us its size: net_iov->size.

And then netmem_size(netmem) would replace all the PAGE_SIZE
assumptions in the net stack, and then we'd disallow coalescing of
skbs with different-sized netmems (else we need to handle them
correctly per the netmem_size).

--=20
Thanks,
Mina

