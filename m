Return-Path: <netdev+bounces-68943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB3848EC4
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14295B21CB1
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E529F225A9;
	Sun,  4 Feb 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUGOJxVv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2830224E0
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058842; cv=none; b=beZ2HZJxtxV8bYuqdSKKkscMY+affHq4K/wHW4OL95j/zBmu5yyUrMii6PjkqQnJdYvgsd3fdZ8sTv0Std9ZsApiAHXbQ0SckwaKT0R8peZkHFOJBglO382MLoastC/dPhdAdgoTZT4k4rDXdpXNkMQk179WRHdaxk4m6syLSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058842; c=relaxed/simple;
	bh=xdSeQvV05nn5L8vGt2d4VTs22D9fCwHOm1ANUT2yxn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjoGlxB8SFGxvVnIZsnDGRUXKXoR8DDbRGOyvdEESmG7U2kZm3YINtiq/ipR/GydX7SKk0LiSelvXeL4lf20hBojMeW2HGhL/Ga0JJRpHm8Wq/sL7ttAcB5KMgF4mAt5ddwoHyFRYQDvwI4m98OS6Xo/XA53RmqTvcy+v5mLgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUGOJxVv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-603c5d7997aso32146907b3.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707058839; x=1707663639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3lqw9guILXTXW+HHup3WqoC7VU2sfl3wXM0hqsaEkk=;
        b=dUGOJxVvIFyaOE/esF1lx2c/aJ8UIlpFFzw9Bugjv00/V4xjDrVUKwCxRoEKGliqvy
         qpAKBABK/CzRE9rMS2V62znJ9uL8vD5BpUOL11NkesMvPY5+PJDCiVSw1ui0Y0Ivr2N1
         EiMTZzUMUiREpK7xPsbXBuseqsRNybWg9Ch9XbKZjdlNQAvIxV4qITYgjrHBwn49B9rw
         F7GoWMm+Vb3IQrzVrhcRwxgim35KIPEsS4WybNbSaNitkU/Qd01OV1Q9V1fy0iWx7kJo
         JIhDGqOuoz3urEvcR7m68E8b0wfCOE8DkIA6tD4fzelxHvF9QSy8tIvM+ZKy34RPHZJQ
         T6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058839; x=1707663639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3lqw9guILXTXW+HHup3WqoC7VU2sfl3wXM0hqsaEkk=;
        b=wwqCFQpPxMfQFwI07S/Nm6aqvawZS6GSboU6QJ+41rsxHjlCh8CJB7qeGRG0CHjbmR
         B5OJOfar2wScUl627Ma7T/sI+Jsy+p0pFnGhnnhT02lo/gZCiBdW0sD27hnUBRecVQyo
         X+21XwysOLRdcLBVqSetyTAGmsG+OmBn5NsUD9Hy9HqJXSyq1ER1UPjT2BvzBg51bPIz
         bYGh7FbIG+YDfDhsBP5XU+WhSsMxJVGY/95T6K67W7xMkAJhXDUD6TG1xclTeOmEWbfF
         UYKwSumMNSjFPLSqNu7O5fzlZbO8fnVitPdu6YEwvI/wFCASSKAk9loQHtinkrRy0dK8
         LWBQ==
X-Gm-Message-State: AOJu0YxTNgDVUi21t0+WnxoQR2sI1/oOZ4LLOTqWfVlfZfWDLO+pOTBP
	ur5wcXh36kRYMmo+VceEYvhvU/lcJuNy+Xd5rWcwHIRJ7MAtHms1MbzS2VBzsrHAT0WFRl+rww4
	tqh/LRExopMfwbJhDZhjSby1OwejFLSt1rCMEMZ0nD9j6bFM=
X-Google-Smtp-Source: AGHT+IHg+0gPpQzlZZ3TALwjYC82frTLQELFYbkrSVOd3QmDViI01eEHMCvlkaUcUAORp4NaJVjUuqgO9iSCHdLFGqw=
X-Received: by 2002:a25:e08c:0:b0:dc2:46ca:e968 with SMTP id
 x134-20020a25e08c000000b00dc246cae968mr6398171ybg.4.1707058838640; Sun, 04
 Feb 2024 07:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204023531.2225264-1-dongtai.guo@linux.dev>
In-Reply-To: <20240204023531.2225264-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 4 Feb 2024 10:00:27 -0500
Message-ID: <CAHC9VhQUkUvpj+c0r3vZvfn7djQ5kuBej9RE2L7TZwfxg-L7UQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] netlabel: cleanup struct netlbl_lsm_catmap
To: George Guo <dongtai.guo@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	George Guo <guodongtai@kylinos.cn>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 9:35=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Simplify the code from macro NETLBL_CATMAP_MAPTYPE to u64, and fix
> warning "Macros with complex values should be enclosed in parentheses"
> on "#define NETLBL_CATMAP_BIT (NETLBL_CATMAP_MAPTYPE)0x01", which is
> modified to "#define NETLBL_CATMAP_BIT ((u64)0x01)".
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
> V2:
> Yes, I understand what you are saying.
> Actually, there is a compile warnings on "#define NETLBL_CATMAP_BIT (NETL=
BL_CATMAP_MAPTYPE)0x01"
> which is missing parentheses.
> ---
>  include/net/netlabel.h       | 7 +++----
>  net/netlabel/netlabel_kapi.c | 8 ++++----
>  2 files changed, 7 insertions(+), 8 deletions(-)

This is a much better approach, thank you.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

