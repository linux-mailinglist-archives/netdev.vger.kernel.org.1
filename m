Return-Path: <netdev+bounces-229331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34077BDABC4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D25B1895CBB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D02FC007;
	Tue, 14 Oct 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFyoYh9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A2226863
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461499; cv=none; b=jkW9/khO340JRbduPQMmnOrA+Mfgh7LyZ1q4NNeRNaIjfy6BNiUUgOduXHBqWnKVdgEXhnw1xq8KqPB+5IWskKV41hy6z8r6RMsX3Rl66CZcs+0n1uHPMOPUXLOjUNLAAKufUbkB2+R1nLYdE2Vm0pGstkbW46DjEvpdmW+Gyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461499; c=relaxed/simple;
	bh=zR4mj2V8xlY6/bkgaX0KeLu9NGXdt0uBdeyroBZnuXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXxPvUSATUiuPllXGw+hRos/nxNZoxcjphtF0HRC71jkzQT70NP/w5rBeIiUeB9pYAO0/TycXMhGE0mfs6lu6RZlxXoJrUk3qET+xnmzqIwQvCbv9yE6BKczWgB01GFhqV/YYVwkmo+YEMK79/Yblkc+/0nTIeDmwOljhp31hR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFyoYh9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458A5C4CEE7;
	Tue, 14 Oct 2025 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760461498;
	bh=zR4mj2V8xlY6/bkgaX0KeLu9NGXdt0uBdeyroBZnuXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TFyoYh9o1mQ5kRzm/lKPzZS2fjgxXcSn1Nnr/oXwplmENuJsQ+unynLLSU53rtYdL
	 fAIcSo1h9oE85Jn9xsptxcJlQMdKWMvYCqYTCka57w5BqgLpeBa+d1sT3b4Rkllj0e
	 DaiXXRkC6PdSyHDUdgLtPCWxVmemEQ6h+DYZV2p7JZf7iI930fNlfEj316TfVyGAhm
	 LUjFzZr0a1iKMjZkwq8vjcOtWFPxNmWCeW0XfgV+hurQL2dga+fuhYRTXIDXauS8Uv
	 N5flbSPxy8AHQXimgfErnfv+DD7BXSOZ9iU+d/FMlC0oUf9whZq75iglUtwQ8O6Yes
	 ZMip35fh/+gdg==
Date: Tue, 14 Oct 2025 10:04:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established
 flows
Message-ID: <20251014100457.3f6de3e0@kernel.org>
In-Reply-To: <CANn89iL0ZjuH-YiuBbm2+s_2adQzVUVOi4VYDvwGBXjTBYHb=A@mail.gmail.com>
References: <20251013145926.833198-1-edumazet@google.com>
	<3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
	<CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
	<CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
	<ffa599b8-2a9c-4c25-a65f-ed79cee4fa21@redhat.com>
	<CANn89iLyO66z_r0hfY62dFBuhA-WmYcW+YhuAkDHaShmhUMZwQ@mail.gmail.com>
	<20251014090629.7373baa7@kernel.org>
	<CANn89iL0ZjuH-YiuBbm2+s_2adQzVUVOi4VYDvwGBXjTBYHb=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 09:16:23 -0700 Eric Dumazet wrote:
> On Tue, Oct 14, 2025 at 9:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Tue, 14 Oct 2025 02:40:39 -0700 Eric Dumazet wrote: =20
> > > Or add a best effort, so that TCP can have some clue, vast majority of
> > > cases is that the batch is 1 skb :) =20
> >
> > FWIW I don't see an official submission and CI is quite behind
> > so I'll set the test to ignored for now. =20
>=20
> You mean this TCP_TX_DELAY patch ? Or the series ?
>=20
> I will send V2 of the series soon.  (I added the test unflake in it)

Great, I wasn't clear whether you'll send a separate fix or v2.
So I disabled the test itself.=20
Not the patches, patches are still queued.=20

Sorry for the confusion, our CI is what it is - just carry on as normal
and I'll try to keep up.

