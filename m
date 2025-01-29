Return-Path: <netdev+bounces-161524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE17A2206F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28FD1881D7A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE061D90A5;
	Wed, 29 Jan 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwEFDZVN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35714830F
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164750; cv=none; b=tY32SjIE9mmpihwM/IqoK+htYjvKLd42qGPweq/AGGnVBBeRNAcrr5MB+V4SY+uRBSywd2jR2f+JUkWo0DKoUk/p5WXVEXkdV+fmqiFRCVvS22zSkQYIfd7ceo8Fou78h6izPIel6GrRdvpe3CScHqEtGtIKUT1xEavtbQQMGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164750; c=relaxed/simple;
	bh=AlsQnwjj4SWegh5CLX0iiER9BctggdIk3gw78L9SLsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMUIJsvJMF/ez4AlNancqd3j3hQZ+GXCpZKNQoYC9wizSEBAxDboTXlxzmKXv5JgqKHHKTxIVgn350KbrqjhNPPkAPPy55Up1zcVEW4LQau2vNWLppDM4/1uCbtqUPT8FPjLZHx4rgcfhtaXIFZzkWR/We2/P+/TQoiOXWgx+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwEFDZVN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso12055834a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 07:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738164747; x=1738769547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0T3dSZYO2nQ23J8b3KXiYs/1XHkGUnNQm413uAPWLU=;
        b=IwEFDZVNcXB/cgEkwTlZAYF39jPzXCzAJHAsq9r2lr0ycBsruN4YtFVmgvddtoGEd9
         N8B50aY2cWDkQRhk+QmpmMjZJIvjGAjItHph6tuv6ZAYk4xkE0RhB1jddzbaEDmypDpg
         C3z/Go4nI+y1JP2yJnm06JNajzkk8Bqt1VSuYvcIactyGMP6JoMwrBO39Zc5YS1MgBW7
         oWZTopqrnzao22P4YVwgjURixwVKEYgkZAjsXDpxwYS6bSgOjx7soFzEsKPMeGPY0dlV
         rT54Fyrj27sFnsYjf1CxVBK2k5qiVL5q/+w/LbcNdRowSVHUQQXy6v8+PruNaTK8ze+m
         fmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738164747; x=1738769547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0T3dSZYO2nQ23J8b3KXiYs/1XHkGUnNQm413uAPWLU=;
        b=noSxYIkuIZ2R/yF5D6tKBWW9DM4/RRK0GsuarUJITI0togB7anXKJ/hmhTjY9WpFjH
         OkOjZFlk95ODLLFUK3X/UYSDQeIH2UdWvHyK8tkBFknkKPnAvGfXCtppEQvsIuSU72Ev
         OZw3SCOqkqZFAagVQ7fHmlhDkG/Pz4t1C34yLaJYeAthev5aR7EF7k74JYVmDfvxUOyw
         9UvWBAV3G+5/VCpt587Sr3u2xsBKgsqWt48RqXxjJMPRvTi8k50NNU4eZZwa9gM8XrDH
         F9jJXMuWOnvO1MUmNes+X+xYH6rm0XTJpMjrt19mXi91/pgCQ9FUUxmMIgAV8ATVjroQ
         HjUw==
X-Forwarded-Encrypted: i=1; AJvYcCUdprWR99M2626901yhgZjM69JYsol43GfzNR28stWQ1TBTuFyRPu8qLpbxcHlUo8004uz5g1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpXuPVDAJTJPf5zsI/n1QbV5yrir9ZR9XPDL46gzItKgPdAoI
	HRfznjSyfQFQlChXvkPV2n5iaB+wchYFZj6HePoOUaO+zaG0kJ89Bi+9afEPr6ljRDF+6RcK5gZ
	FT43B0WVXxwFwkIRVBO1wgKd5OBsKvpgYHjSeiUupgHcjM62ajQ==
X-Gm-Gg: ASbGncsQk0CBd9Nthp3cN6wR+Rr2l0y/ELEfoBc/X19R4+GrVIEZP7jgZquyLJOnxVj
	DGm144/B4Aes5yiO7BqNLZqFQZV3ymahV71wk5POr4OrB4ozW+/q7GKfSokKFhNmZvPtUc4ogCQ
	==
X-Google-Smtp-Source: AGHT+IF5J4ALV0Rmse/FD/aCtVd3O1YzmdxSWcl5qgGd/hyWbdcRTKGm7gKpPv8omCpz74ZyJOazcbgDk8kH5e5k9KQ=
X-Received: by 2002:a05:6402:2711:b0:5d3:bc1d:e56d with SMTP id
 4fb4d7f45d1cf-5dc5f01e7famr3084065a12.31.1738164746909; Wed, 29 Jan 2025
 07:32:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129130007.644084-1-edumazet@google.com> <20250129151338.GB83549@kernel.org>
In-Reply-To: <20250129151338.GB83549@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Jan 2025 16:32:15 +0100
X-Gm-Features: AWEUYZlv4U-AIzCL_ZRgpU51ROlIYeIikmSE5-5oW_td8Ju6-kRhdlIwxmSxHeU
Message-ID: <CANn89i+re0EQNt0K1=1XLsqApO=Qceu3Bix3ALWWFNd_E3KSnw@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: fix fill_frame_info() regression vs VLAN packets
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Stephan Wurm <stephan.wurm@a-eberle.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 4:13=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Jan 29, 2025 at 01:00:07PM +0000, Eric Dumazet wrote:
> > Stephan Wurm reported that my recent patch broke VLAN support.
> >
> > Apparently skb->mac_len is not correct for VLAN traffic as
> > shown by debug traces [1].
> >
> > Use instead pskb_may_pull() to make sure the expected header
> > is present in skb->head.
> >
> > Many thanks to Stephan for his help.
> >
> > [1]
> > kernel: skb len=3D170 headroom=3D2 headlen=3D170 tailroom=3D20
> >         mac=3D(2,14) mac_len=3D14 net=3D(16,-1) trans=3D-1
> >         shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0)=
)
> >         csum(0x0 start=3D0 offset=3D0 ip_summed=3D0 complete_sw=3D0 val=
id=3D0 level=3D0)
> >         hash(0x0 sw=3D0 l4=3D0) proto=3D0x0000 pkttype=3D0 iif=3D0
> >         priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> >         encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, trans=
=3D0)
> > kernel: dev name=3Dprp0 feat=3D0x0000000000007000
> > kernel: sk family=3D17 type=3D3 proto=3D0
> > kernel: skb headroom: 00000000: 74 00
> > kernel: skb linear:   00000000: 01 0c cd 01 00 01 00 d0 93 53 9c cb 81 =
00 80 00
> > kernel: skb linear:   00000010: 88 b8 00 01 00 98 00 00 00 00 61 81 8d =
80 16 52
> > kernel: skb linear:   00000020: 45 47 44 4e 43 54 52 4c 2f 4c 4c 4e 30 =
24 47 4f
> > kernel: skb linear:   00000030: 24 47 6f 43 62 81 01 14 82 16 52 45 47 =
44 4e 43
> > kernel: skb linear:   00000040: 54 52 4c 2f 4c 4c 4e 30 24 44 73 47 6f =
6f 73 65
> > kernel: skb linear:   00000050: 83 07 47 6f 49 64 65 6e 74 84 08 67 8d =
f5 93 7e
> > kernel: skb linear:   00000060: 76 c8 00 85 01 01 86 01 00 87 01 00 88 =
01 01 89
> > kernel: skb linear:   00000070: 01 00 8a 01 02 ab 33 a2 15 83 01 00 84 =
03 03 00
> > kernel: skb linear:   00000080: 00 91 08 67 8d f5 92 77 4b c6 1f 83 01 =
00 a2 1a
> > kernel: skb linear:   00000090: a2 06 85 01 00 83 01 00 84 03 03 00 00 =
91 08 67
> > kernel: skb linear:   000000a0: 8d f5 92 77 4b c6 1f 83 01 00
> > kernel: skb tailroom: 00000000: 80 18 02 00 fe 4e 00 00 01 01 08 0a 4f =
fd 5e d1
> > kernel: skb tailroom: 00000010: 4f fd 5e cd
> >
> > Fixes: b9653d19e556 ("net: hsr: avoid potential out-of-bound access in =
fill_frame_info()")
> > Reported-by: Stephan Wurm <stephan.wurm@a-eberle.de>
> > Tested-by: Stephan Wurm <stephan.wurm@a-eberle.de>
> > Closes: https://lore.kernel.org/netdev/Z4o_UC0HweBHJ_cw@PC-LX-SteWu/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> Hi Eric,
>
> Just to clarify things for me:
>
> I see at the Closes link that you mention that
> "I am unsure why hsr_get_node() is working, since it also uses skb->mac_l=
en".
>
> Did you gain any insight into that?
> If not, do you plan to look into it any further?

I have no plan to look into it.

Given HSR Orphan status, I guess that it does not matter much...

