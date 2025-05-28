Return-Path: <netdev+bounces-193839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C3AC5FEE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3604C3B46FA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387641C8604;
	Wed, 28 May 2025 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUtdmK2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E32F2F
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402240; cv=none; b=K104AkEkfz5DlPm5a93KPHeN2enKC9sBPAP3LWUynP4/ZqOLksrZxoo6C0fhNNn1rozovMqPYN/wtelJlRR12UeS782YcS/DFcgQrV1+xyNiplkjPTZpXbcbykhRkiIbvUHGcZwiKiBVsEmSlvjOgo1mAbdUppc+/Onf/DSoZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402240; c=relaxed/simple;
	bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeGN6QaLJmje6nSZHiVSNiAcjMqlS//AWiAiqFdHigSYZ85NwFrSgMTypAIRYgVNmaliXhxgnLsncEBgGCIoIj3czpyp9/xgGI4c8snFHNsXcRJF3uTmYfu9fcrIPU6fmn6EbaZ8VJL6oSpu63prFbivCASVyQeBOGrT8fJnfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUtdmK2x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349068ebc7so134585ad.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402238; x=1749007038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
        b=AUtdmK2xipN+sZQV7Qo76/sOfDnoWKgEgP2v40hWsmGmrGxbr0cc9D7EiPHGOS0cXm
         Wz7EMFD9xV4B3CEUWPGwsIjks/X3EGkJcQql3y/mdnouEwwiaEh8hbthGBlwH2hF6jCP
         75Xr/+7z67Ad+8aw1BqRB7LxgGX7bcnc399qs4I09LOw+fhcU42bGj2mcluoqmaSv6wD
         +CsOAqPniJcsIMR2WPzdtjvu7sk43omgmglDfG3e/cDRk0YGqqAIGIAWRjNNbmhmNe5c
         P2aJH7/rRCZvSVi61dAQYUsgqd1vtEcPXsWdwMFTir3OclYupZU2USsXwEdmlPKCTjPR
         w2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402238; x=1749007038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
        b=dZzTP1yh5JlUGix/GdAzAmR/gU2I5Kmd49RH4HqXzmtpA03nPlbiw72guKetWKS+gd
         eu4ajIKnn2mxLkImiOZ9C3plyY22XnVLhLcasQSnJ4vkvUDgoORqAbhX8jjioIPddhUx
         AozSZUAFcyD1lF0na1O15KA+MC9qaBUySmYTw3Jj0IlEdrQgQCfH0QNcnOfFTbUfpH69
         ajiS6Br2Zr6FC9nLmvF7X8DIy2GXNmuXctcOc7qMamkX3RdfSoScS9F1OIm24lYi3rAS
         8KtWQOvEVjhPi7OVmxPXeBRA6eZLFplBz7B30JLb2ccQ2rBhmmDJt8RZjEqVLar4QT8o
         6wIA==
X-Forwarded-Encrypted: i=1; AJvYcCVLyZW/RJKiLaN7WbM4eYhuneP12SAFX9B8hIypjn1FwRwFRWsyQ66HhxUcFyjNpi9L1JpyOlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43Qe84urssqhr4w6EeTQPNgAHUOxV71xQy0fpMwxyWKnYOQUG
	QYkPtUCZeaT+F8CyPF8t+M43tjwJqdLs+q2E4DpHcHzET1cAfKqbdYtSFJS6DxsKkLBhbv5m+5r
	nKIUjpC0hRB/F3kKvgkqdos5p7sphe8R5JXHD9htNGtu2MfZYc4ooK+ezy/Y=
X-Gm-Gg: ASbGncsZx69HwKXZm9fuVY/uxAeCWvQuFq1qshmhWj39f/rn+H5+uIrlruIaEnyDW28
	ZKWWkwo/rI1QTYQh5KqFAKENvfsSMJd7PY3SqiBm/NKIU2CVsHW1jeIMYYJFi+3yaKbL/ysjvV8
	bZs9SYbfTeJyk8J6BKPglFug7X8Oo7eiz1VEkZ6CsK9MdY1bw2Wx7zc3E=
X-Google-Smtp-Source: AGHT+IEnczAUe8aSvzmzngQXQGk0N5lF0CakBmamAAAHOTmJuCP9XYZrHm/qfHgB3Xi0bVS+4KeIoprZZQQkQB9JjsY=
X-Received: by 2002:a17:902:ea0b:b0:234:bcd0:3d6f with SMTP id
 d9443c01a7336-234cbaf560cmr1132885ad.1.1748402237697; Tue, 27 May 2025
 20:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-6-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-6-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:17:04 -0700
X-Gm-Features: AX0GCFs29uDSGIhRSaJWQiNCOlbuHKz4cCZioyPrXBBoYFAI3Cxm46scEROF8Bo
Message-ID: <CAHS8izOVbJZfS0r+A1Pi_ZxmrJBfUBZR4fApbd=GWj0AFQ8vcw@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Use netmem alloc/put APIs instead of page alloc/put APIs in
> __page_pool_alloc_pages_slow().
>
> While at it, improved some comments.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

