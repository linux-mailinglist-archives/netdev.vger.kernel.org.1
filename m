Return-Path: <netdev+bounces-181214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB291A841B2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8D41B68032
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1BC281522;
	Thu, 10 Apr 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCGMXqyP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0227EC9D
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284288; cv=none; b=fXnhZ8f5FySq5+AuO5C7ueUeCUgJU3UfmcLvDvkZMYgeY0nbX/+Fdhbydrh4rCjNpk3Ztkz7fbUbEB8t1eCnpeTlY/UmDK9SBbr7ZJBaT61V3WbpAXNqzpuNbxp7VHSIUaPpawfJmyz38RFEz7GszTCAbB3MoHO7CYTiogLOui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284288; c=relaxed/simple;
	bh=uxZG4n3nv8upFUF3AElIC34tkOtzKRJkS7sA0QWrrlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8FsV8VexHX7CRVWnW1q2omahUj+tt1GXMKTG67qN62qotiSluSOQywYEsx1wHSCCaror62kct/0OThgCn14Tu2z3UOAOEE82DUmWVDpgAan38g4scF/p23EiKojir0YpCe9uaDZDqzD/4J7cltSYgWpw+jztuMVf8igfbmtu98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCGMXqyP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744284285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bRUqjURXRfi5I4u/cU2aBmMRmmhkdr8UnK21YTbfjM=;
	b=VCGMXqyPTSXeKbI8pdpIlA5o3i3ALJyCXVN9j9m9VGreemc5yaL4KC8KKjJaFaFe5gRmGH
	nQWfxkqqjWLM7Fcg10NIuRGSazaDLMEWrowGv1ZPZHQZkGqo1DrdPJbpERY8vXQlkNJ5uu
	wnLIxSa2wKKLuq7Te1Wg+sBRN6PW8SU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-sX0DF-esNLSJ5NyPlMEkaw-1; Thu, 10 Apr 2025 07:24:44 -0400
X-MC-Unique: sX0DF-esNLSJ5NyPlMEkaw-1
X-Mimecast-MFC-AGG-ID: sX0DF-esNLSJ5NyPlMEkaw_1744284283
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2a113c5d8so53300066b.1
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 04:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284283; x=1744889083;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bRUqjURXRfi5I4u/cU2aBmMRmmhkdr8UnK21YTbfjM=;
        b=fdaOKV45bFM0Oh/6/VxEge5MRRdooW9vlQA4i2nS8a7iUiY7Kt9jHqlpjkvXMLfS1s
         8J3jq3/hBwiLEhFYZ67iuuQTNCcecLNPvTNW5xqv+RuX7KBZv5KE8vqHGem490+6Fgfs
         BnNF+qNksDEbFaWd0Zug0WLbzUyoRiz5iwFu4cr9Vg3ebIcAvM/vS3Fc+VwBcKZs/UO3
         NPHC38dtN4T4DD9hU+KHViXSfaP8axJHlGmB1tDQRvRHXt5TQfCwN41jpDmhsosEl+5j
         kqD4IBg5o/qvE/qbmoUAuIGTe7uuWcqbGX+3kx+r0SalAKlX6zHUMCsgeGIbsYHREw49
         FtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtDn6yXJd0YI5od5yfJaWYtgTvpcVJ5e/xDERYpdd6Zq/pdNEufqH6lj/meRIybOv2FXvY4mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlttR4AKSyLaC01KQKiTdJq5mQgzb8sBNRBq7PkvIx7ZA4Ktf
	+zj7r3wyoYrQEacUxU8yuF2pnP1tprpq2UMn1ji/rcoIdnV1UKhYQvd0/ee+So0P60d47hsafEY
	D1K53xNTUYjFIerqy6LLKO8IJWYtNH/L762Bz2nIZa+5Xg6RR20ftOg==
X-Gm-Gg: ASbGncuCmc/qFv0SPpdjjnCrQ79ZeyK6tcF/yl9zVbrUAlFZLKVabvPKkxecF3Pd2Xi
	AZOvvJw1KOXcfvBxTxgKmnQhyoSUt6dJ7yfxPxaA3Ktinv+R+r0Fe3K6V8T1oq+HLKh4EAbduHG
	YR812ODlnpXnOtQCyR/pH0TNTyel6dBrGDy1BcNztvdYkQ+9A0ARM/x3wmTZDf/BiyPYHG9aCCl
	7sQUnIcTGsIUYFaUotVzVaPq2K09aQzDdaMIpWaHA+GunQEFwWGCU7pwQxMlzJiW+qb7M4hfx5B
	hU+4pei3
X-Received: by 2002:a17:907:2d22:b0:abf:6ebf:5500 with SMTP id a640c23a62f3a-acabd194daemr265371166b.16.1744284283059;
        Thu, 10 Apr 2025 04:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzYJr1mbcVFMmyOfUdrNowN0DoumFwjn6olFk+s/oECeaB2XhRLnSDLWVgdEThGtX1Z2TGXw==
X-Received: by 2002:a17:907:2d22:b0:abf:6ebf:5500 with SMTP id a640c23a62f3a-acabd194daemr265369266b.16.1744284282695;
        Thu, 10 Apr 2025 04:24:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb312bsm260985966b.15.2025.04.10.04.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:24:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 490101992292; Thu, 10 Apr 2025 13:24:41 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Peter
 Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH net-next v1 00/11] net: pktgen: fix checkpatch code
 style errors/warnings
In-Reply-To: <20250410071749.30505-1-ps.report@gmx.net>
References: <20250410071749.30505-1-ps.report@gmx.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Apr 2025 13:24:41 +0200
Message-ID: <87mscotg1y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Seiderer <ps.report@gmx.net> writes:

> Fix checkpatch detected code style errors/warnings detected in
> the file net/core/pktgen.c (remaining checkpatch checks will be addressed
> in a follow up patch set).
>
> Peter Seiderer (11):
>   net: pktgen: fix code style (ERROR: "foo * bar" should be "foo *bar")
>   net: pktgen: fix code style (ERROR: space prohibited after that '&')
>   net: pktgen: fix code style (ERROR: else should follow close brace
>     '}')
>   net: pktgen: fix code style (WARNING: please, no space before tabs)
>   net: pktgen: fix code style (WARNING: suspect code indent for
>     conditional statements)
>   net: pktgen: fix code style (WARNING: Block comments)
>   net: pktgen: fix code style (WARNING: Missing a blank line after
>     declarations)
>   net: pktgen: fix code style (WARNING: macros should not use a trailing
>     semicolon)
>   net: pktgen: fix code style (WARNING: braces {} are not necessary for
>     single statement blocks)
>   net: pktgen: fix code style (WARNING: quoted string split across
>     lines)
>   net: pktgen: fix code style (WARNING: Prefer strscpy over strcpy)
>
>  net/core/pktgen.c | 111 ++++++++++++++++++++++++++--------------------
>  1 file changed, 64 insertions(+), 47 deletions(-)

Most of these are pretty marginal improvements, so I'm a little on the
fence about whether they are worth it. But, well, they do improve things
slightly, so if the maintainers are OK with the churn:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


