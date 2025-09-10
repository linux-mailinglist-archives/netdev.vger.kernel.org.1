Return-Path: <netdev+bounces-221480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A791B50976
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42F64E57D1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C315817BA1;
	Wed, 10 Sep 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjytF97B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9410F2;
	Wed, 10 Sep 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462455; cv=none; b=UXi51F/GevHJyFIH0CaeSzOxARlDIiGfyfbZ58yU625l+VBRGvfhQ/uSEYHrSvaTLFsRZlN6f5apwuTewB62ui9ZiY3QrlTodIh+arzI5V+JMcKWxVq/cXQgY77KdeldTr1e0qQ+Z7AQ3b+uOF/Tws+eqA3ljJ+yM2QQTG4uWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462455; c=relaxed/simple;
	bh=T2dGmfcpRuIkRrBuxpENztq7/EZdH7TQujjC93PJ6QE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/Vs4wjjj1vXfPYMMsonbDZZZ4O6DO29KgN7Ug63LGSbYd7wuaH1MFFleaftpeLEe59lc13g2wK3vXHgngItaS6NI0gOvaS+E4746tTsf+2Re4oXN6vFc3IB5lG6t6HirADDzyndPn2AOLbkZSuIfYSl+nyYyPzBKY/CQcKxKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjytF97B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE71C4CEF4;
	Wed, 10 Sep 2025 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757462455;
	bh=T2dGmfcpRuIkRrBuxpENztq7/EZdH7TQujjC93PJ6QE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IjytF97Bm/junWGLsaJGRm7N7a1ss+vOqbNOdUeBW33UOC9nQ3UCbonEnmHXfub5R
	 SHaIpl76ToxXITmlOiDtcGPL9J22APDEg9Jqds/XUXpsmqw6O4GZv8hSZD478rqNrL
	 MBws5ul6dC414m9nt9tJcyKVELQssOkWTZty8gWLQTZQINQKsvD/Ya7u1uKjEPg6fh
	 fHysyXy45HqxeK3ONvXXtvfgetI/vYsJ78XyzuBUgvV/Zi1Zpn2FrNf+I7/pJDMSgD
	 JbJhHx84Mbnu221gqBW09oiDdn84Hw5IAWFW1ssJa2uLfyMAOKkg0PbKd/fako07pK
	 7qmMYUjq1QKpA==
Date: Tue, 9 Sep 2025 17:00:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Andrew Lunn <andrew@lunn.ch>, Frank Li
 <frank.li@nxp.com>
Subject: Re: [PATCH v6 net-next 1/6] net: fec: use a member variable for
 maximum buffer size
Message-ID: <20250909170053.6d0eb1b7@kernel.org>
In-Reply-To: <20250908161755.608704-2-shenwei.wang@nxp.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
	<20250908161755.608704-2-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 11:17:50 -0500 Shenwei Wang wrote:
> -#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
> -#else
> -#define	OPT_FRAME_SIZE	0
> +#define	OPT_ARCH_HAS_MAX_FL
>  #endif

> +#ifdef OPT_ARCH_HAS_MAX_FL
> +	rcntl |= fep->max_buf_size << 16;
> +#endif

We try to avoid ifdefs inside C functions, they make compilation
coverage harder. Could you define OPT_ARCH_HAS_MAX_FL to 0 or 1
depending on the platform, and then use:

	if (OPT_ARCH_HAS_MAX_FL)
		rcntl |= fep->max_buf_size << 16;

The compiler will eliminate the condition if it's a constant,
but its slightly easier to read and lets the compiler see the code
regardless of the arch.

