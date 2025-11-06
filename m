Return-Path: <netdev+bounces-236135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D1DC38C2F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C704F04BA
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12522248B4;
	Thu,  6 Nov 2025 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/LN3e8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EF225390
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394186; cv=none; b=R6AzBFfzSUVq/1Gif56WnNOBFOc+a8FzAtDB1+VWlYc+j+E2jvAk3NzXjPk7LW602YUYucRd95lC6MYYrSXn+JYn3LxVj1+/sT+yahX7IyYvNMSPAqZZTvbU+E8A1G9NMxAsSRVhdy71NoUB0KiNFCp9LZZLGl70RuJK4HZlhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394186; c=relaxed/simple;
	bh=jLw7k/KAz5FUEjGhd6v3ts9iOCpt5gHWAPtf5CRRl8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mISn7EJNKfe+xGRkkDcdyTz2SL3Qvs3TCKXU2oQdLaK7TQmjCWPALx0KECoEEqszctA8tSH1mex4oHXONy6jDIgD3zyuTKIwFFMszkZ2y5fC0eYYb8RQzdLoihutyY+rdPMqUdg7WageytN3mILmhtOfQ3snkNV3W7CFvUCpVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/LN3e8i; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso132951cf.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 17:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762394184; x=1762998984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUatHznZUYVcukINaQffbDk6qMtXMnZNYeCcDgim0vc=;
        b=H/LN3e8iVZU1vF8Ko6HoNITQ7O0K/zgXfrs0Wxo82wsqa+eUtEh5cE1fUl6wPJNspH
         tF7Y2ZDBKCxgVTr1NGmiQv9jWuK6braoULKx/HeGHHWOmPRJGEQEB0Y6fVfuwEv/sjiM
         whuoMfzIaZ5ayaAAdUvYhqIoueVIdt70xGglZisTJUwjxAE6TJInnTR+ksyy+XuTnwRz
         V7bWWIB2nlmnbDGVtdFYhwdcQ9t4VCb6lXHUElTwRMxd+fZpmqYQ/SUJRyoAjbBAtYha
         YVhJ/4O8ROjLvQtTGz/F0mXRMtoFkUdS53vP435+1WD4n5Ag64BNkg443NhiSspUSVEN
         R/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762394184; x=1762998984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUatHznZUYVcukINaQffbDk6qMtXMnZNYeCcDgim0vc=;
        b=p/KHfGaxtby0MUiZ7+0AWClaJqGDSit6EACXCucQ8C9GLZinkiDTpba/nix1+ZmRUU
         Xjwud3OQ2mjSPrRvaOiCzq+29wz9tAHkIxD1UgnwKuu7WxsMEhp/i/r/jDrmuZr9D5a7
         s7Hsm13Pu4mPFBUu7MzDs6MmQgHy7uMTgqwJUm0rsgOE8uc29UZmBWFo9wKyAJ2yB4S6
         iurSM39CS0rNpxrDKl/XxvxrJTZ8pY3791u9YtST6XrMpVCuvlaOfzKGglOreYwJ9GCG
         AH/hpp2vAlp+QYVn0z3Un4+iYAiz46IW/xBDJSMDc0pu1l5alMYT457laOhbUUBvrRUN
         mMig==
X-Gm-Message-State: AOJu0YzbHm6fquTEipFYA+9KEW3m0A0Y2URT6v15hEb9LuxpVWoDUraD
	NE2xms6UhOu8mEQnfJzTnwoOl7diOyE15mH+xirujOKsWZOeNTv7VScEIH4539fu1UKE44xDmRu
	gO32CTTj+EVdbAts31OkYIxbT7cqO6f0FBJI4YXeQ
X-Gm-Gg: ASbGncvxzDIdDhrmtt150CVPTtiw9zmckWz+LEYJ7m5EscAwMNMoI+XMCS8XfBYEfmv
	/3qSV1MrVk9W055yOmtt8lEw/flRRzuqIRlvVFV1QeAC2+srIx/x4vmVkExsyC+sUxJhkuJPvhX
	WoqwziAizU07tSEvCzL3R2NtFrnNxwzVfUw8yruIWKOT6VqRtlliWBzJcedBe5xHiUFuOLHkvJB
	mcwJo0+yUtMf7glDzQxbZBZz0DtNi2bjdBku5vaT4a45h43uYV+9JmUpLiZ9E5uZtbwyN8CA7X5
	UvtQhiDEmUauPtsWCGmNz98VOQqr
X-Google-Smtp-Source: AGHT+IHibGvmFnDlfr24rRt2tIra4G1k1r3PX3TWXENAKkaEvVbOFGfGF4YxKvcB5vtfTr1sBaCrevD27B/Da7aRkrQ=
X-Received: by 2002:a05:622a:15d0:b0:4b3:7533:c1dd with SMTP id
 d75a77b69052e-4ed82b51179mr2027741cf.1.1762394183935; Wed, 05 Nov 2025
 17:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com> <20251105171142.13095017@kernel.org>
In-Reply-To: <20251105171142.13095017@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 17:56:10 -0800
X-Gm-Features: AWmQ_bmWD_sYB6gVzqw7Ayfki29RE_amHqVThrUXCC1Sw1ZxmeZGu81hIcUYDwE
Message-ID: <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  5 Nov 2025 20:07:58 +0000 Mina Almasry wrote:
> > NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with the
> > current gve devmem tcp configuration.
>
> Hardcoding the ring size because some other attribute makes you think
> that a specific application is running is rather unclean IMO..
>

I did not see it this way tbh. I am thinking for devmem tcp to be as
robust as possible to the burstiness of frag frees, we need a bit of a
generous ring size. The specific application I'm referring to is just
an example of how this could happen.

I was thinking maybe binding->dma_buf->size / net_iov_size (so that
the ring is large enough to hold every single netmem if need be) would
be the upper bound, but in practice increasing to the current max
allowed was good enough, so I'm trying that.

> Do you want me to respin the per-ring config series? Or you can take it o=
ver.
> IDK where the buffer size config is after recent discussion but IIUC
> it will not drag in my config infra so it shouldn't conflict.
>

You mean this one? "[RFC net-next 00/22] net: per-queue rx-buf-len
configuration"

I don't see the connection between rx-buf-len and the ring size,
unless you're thinking about some netlink-configurable way to
configure the pp->ring size? I am hoping for something backportable
with fixes to make this class of workloads usable.

--=20
Thanks,
Mina

