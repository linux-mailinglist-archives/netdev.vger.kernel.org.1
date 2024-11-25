Return-Path: <netdev+bounces-147191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335BD9D8230
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24D4281F79
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AAF191F67;
	Mon, 25 Nov 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6cX47Im"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7311917FF;
	Mon, 25 Nov 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526787; cv=none; b=MO5FuKKHgPF0Ft6sQmcL3Q+3pjux5qhFqCTn+yjEa5CjGoG8cjIK0baTf8Ttc+CQP6qo9hwS+BMkO7SReTZGoKTzPCmiBiZjPy2pkt5efAuupYKFtUb6MafL+eV4bsA0aaKI47aXnt0/x9ZszZZ6UZmStzEwojcmbPkv913vUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526787; c=relaxed/simple;
	bh=QHhDkNUF779zgJCNE3MNftukR3ZM6l0jDZiflD7kPOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6sahJi04JgwtqaxCHqnRkHlJq/p3N8zZmts04oL28xfh/BIaFcZLs1MEwguYDBVUYnskMdQ+n74fm6t+pomEqKjZowm5FUWKYu8L/vjXryxbKwnXjw22tWTgLqLCyEVXH7Fx5gmh7IfQivswyjruz2Q4PnGm8Lkg7VGKhkzW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6cX47Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8D5C4CED7;
	Mon, 25 Nov 2024 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732526786;
	bh=QHhDkNUF779zgJCNE3MNftukR3ZM6l0jDZiflD7kPOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O6cX47ImDkLiaXISx2JHvSlVuRTXkrWdeRTsce76ge4uKgsYSVva0ljk79MetuuY5
	 AgGBZer7Vgb77fw1Vf6TIQ1jZdgHANnom0xI4ROaCjKfgWokPtKLw+rxDC0Vw8GzJ7
	 kFqCLBhjFqWM/TInEV5JHk7uXjZUavaSJXOHhHiroeYyZ+fRR0HhNCzal8IEpe2GJQ
	 n71onnVgeYPdEnA2KbgO6UYzAAAVHdVoGK9u0O2r6LAnmsx75gPxz4wUxHvyBkvDoy
	 hsf57elYhoKM8s4QkzGd8TjwVFru0HxKvGdDS7H+VQwo9YCZaSzBNkYof0sHtmKmfp
	 5Dx4J36IW+lKw==
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85b09db4824so382861241.2;
        Mon, 25 Nov 2024 01:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzYp7Bbml0/Ra5JetIZwv4e//FtkqFF9O7M78O9BqdrBk8yDHCqY0gkr9AOrdn7nKONVIAk4iqDTnBZg4=@vger.kernel.org, AJvYcCXPUAng5/VzE4lr43OwrsFjDthwLYMLExQZCtJz+ZxESYPzGouJnscdzZEBXOkT8r0QSjXazO22@vger.kernel.org
X-Gm-Message-State: AOJu0Ywysj+dw2IiHRyDcfSMBtX2VL84UJLUMfBz0qaIwLYU1Ii+hfM0
	TuJdFXku0odwKhk6LhR8RHrMl6o+DUhOM/TEeV5wjIy5spPmgEgpZkM1b0IDTegUTaYk/TuNb9/
	OphJ1tt/DhjHoi2D6omQ3yDPmjIg=
X-Google-Smtp-Source: AGHT+IEb9fqfE71doZvP388OfePmr3GzqVRkWAsyxsJb7vFM5lL4XOgLM606xR4c+u6Z5i8n4cJth8LPMjyygGpkElQ=
X-Received: by 2002:a05:6102:292b:b0:4af:7bf:86c9 with SMTP id
 ada2fe7eead31-4af07bf885bmr4770096137.4.1732526785748; Mon, 25 Nov 2024
 01:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124093531.3783434-1-ilia.lin@kernel.org> <20241124120424.GE160612@unreal>
In-Reply-To: <20241124120424.GE160612@unreal>
From: Ilia Lin <ilia.lin@kernel.org>
Date: Mon, 25 Nov 2024 11:26:14 +0200
X-Gmail-Original-Message-ID: <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
Message-ID: <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
To: Leon Romanovsky <leon@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 2:04=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> > In packet offload mode the raw packets will be sent to the NiC,
> > and will not return to the Network Stack. In event of crossing
> > the MTU size after the encapsulation, the NiC HW may not be
> > able to fragment the final packet.
>
> Yes, HW doesn't know how to handle these packets.
>
> > Adding mandatory pre-encapsulation fragmentation for both
> > IPv4 and IPv6, if tunnel mode with packet offload is configured
> > on the state.
>
> I was under impression is that xfrm_dev_offload_ok() is responsible to
> prevent fragmentation.
> https://elixir.bootlin.com/linux/v6.12/source/net/xfrm/xfrm_device.c#L410

With my change we can both support inner fragmentation or prevent it,
depending on the network device driver implementation.

>
> Thanks

