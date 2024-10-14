Return-Path: <netdev+bounces-135073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E62A99C1BC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADCDB25348
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E714A0B5;
	Mon, 14 Oct 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MenY87zb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE331145324
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891790; cv=none; b=kB4fZUpup0CJx/fhlxErNtfWBAjV1yYrTYVaJGN5aGIZc26ZyWDj7XvPYyQVOSSvcvEmMLz1maEg80BNiXK99dIf37hyvLn6hu8ehsOiWv9pok9rXvjosv/9EO/qwjQ+LI16rIZkd2jOwPCWwVOcZYhcO7mU1cGw3fIowW+2Yoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891790; c=relaxed/simple;
	bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8jG6p4Yp5JV4gaMYqwfY3gYg+N4nu6pvxPyb2rbI+X+s9TUdmfpzVsyFCeUG0vYBQqKX5hY16usvOL5mGnOmkghqWSAutnBBSYjEfpFzRspAzjceHkO+1JA+dlr1sugxn7xt7bO9cg8OcecW8uBFo+PJR5K48g67gfLp94IRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MenY87zb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so2854893a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728891787; x=1729496587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=MenY87zbE+9/Lzev8kzG8MK2Eg8qcJo8KggwiwBVxNE+lBZRMzVl8XXo0lYjljjzFV
         5Hbdl1jGm8PafLx4YgRTaDXd+jNqhfIbnL9pEvu+K1kLPPbXN9LILfpq24ED2Dk+p3JJ
         PDJpVhghI5le2mx8HsosEIKyA01bj8tFrhTVaKbXUsNnLIZCSkdUAKMR6g8oPgMSMFW9
         AwQ52yEUXIwmiG2Jh5uPnfZtmYBTzC+ObsQLMVhMsFZCeGhPL1w9HQMk448glRhcQojq
         73TY6/bFfX2zHSC5+eKqeTLLHj8qMV1gZQedaqTpJ/D1hTxFiyeGfemZ6zL0g0/8EyQV
         4tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891787; x=1729496587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=EYK+qOJTctdjG8q249RaqfHnXTaJ2qQqHfKj8Kx0ABMpy6GdzFK+Q1TlansENpT6Sl
         vQcbu0HYxafwhcwCSybcyC5Q4bAH8RlPN7MiULPXwYrn1rSLJjEU8oNKezEFtvK5gLqT
         gIpoq+lYktIAXybGEFQNVuxk3uoR6IM3T2IU0EfXDQ2uaZf0x1vc5wgiy1gGNH0h2QM/
         imYIcP2QDh0ysQdDhJp0d3cdSOuDg63YCct7AGuNfUjWA0eGPw6QnF85hWykrNCc7jhf
         hX2k5fraekvq5XqXpmciX6WTZz3uPPVfWqXg3DbgKG88pwJyGwEXEkgQVPZtt8gse+4k
         M4aw==
X-Forwarded-Encrypted: i=1; AJvYcCW80gC/4syEhVSuATGnoBtj96w5vlv/C87IcXXZ9tiS91cSlAeMZSqDho2Y/odheSGsW8yoKrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6vFVPNjKlenxNJHC472nh9OepJorVHbkhB6oB0YJX/CEyg3t
	yvluUG9vkT6f/sAEqWuIcZA33SG3yq8gTGHUYnik0naYzUB0quYup7WQap7v3gtDPk/BO+vNqWq
	4J6nTRUVuTu21GlG1sUkMqtcnYwjEHCRfMJNU
X-Google-Smtp-Source: AGHT+IGuvZMzRXCYECsuw+x8VNowD+t14ByUWke3daYyYrET2tmW9vNZChsIu54ZzwxoPl2kRhOna6EkqNPhh/X4rjI=
X-Received: by 2002:a17:907:1b96:b0:a99:d3f4:ff3b with SMTP id
 a640c23a62f3a-a99d3f5095emr550405766b.27.1728891786788; Mon, 14 Oct 2024
 00:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-4-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-4-Julia.Lawall@inria.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 09:42:55 +0200
Message-ID: <CANn89i+qkK7NvsJMiV1wWhbUajJCbtTeDLPB8TH1DsQAJk4pOg@mail.gmail.com>
Subject: Re: [PATCH 03/17] inetpeer: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "David S. Miller" <davem@davemloft.net>, kernel-janitors@vger.kernel.org, vbabka@suse.cz, 
	paulmck@kernel.org, David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 10:18=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.f=
r> wrote:
>
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
>
> The changes were made using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Eric Dumazet <edumazet@google.com>

