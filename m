Return-Path: <netdev+bounces-209096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD62B0E47E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A2C7ABC73
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8128505A;
	Tue, 22 Jul 2025 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYBsCTrE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD8284674
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214311; cv=none; b=DiZBSBb8c1JhNHPG3iCXmldw27a7iNCtZDvS+8925/CIlqwUDb836D1CLhDkcKr6/ekJJPqGSQqf6ZcqvEUlZYUy35FjAPN6VuwCjRl4/bj8uo+Bg/RFfSyh1eBr/6JXIwsH3uN0hBW9X5P0N+sl3BRrEAtUVto4vYVW3R4Hx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214311; c=relaxed/simple;
	bh=AQ9HUlS3mEFfS+JEN19VPVWTlfsINf6zS8XOENO8xpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9y/YcWS6Z/s3EyO4JEcVPopnF86odeZm0nJJBs1cdLKsDYOyKFHOjMHF2fTOWjtcDBYlZbtW6R326godMgL+/2eqs+npvbMknWepiVw2PkHwfAD6jBWD4Llv0+CfBn+jgZ9zlQKA2Ar0ECOSL+99FRRUQdYpIQOFIE8V1IJm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYBsCTrE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3508961d43so5446269a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753214309; x=1753819109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCReyCpTjy4nn3Or0iXYbxmyahoyxBHy0fmkPDXu2Qo=;
        b=AYBsCTrEgYjADPUkLRusw+8RAJITG8f0TCpCbxsYfEJZDw3I1RG07KO1IThfFeBmIB
         EX4usODtkQdPnPZ5nPeubAk/ujt5Om75u5sAypyOt7iAmBUflx5lNvCE17crFng4fpA8
         cwfY+lhcTNT+FgVmAPTqPkBIotp0xTnAlnH4FWlcdn+gRBhwvDTCuesnioTC6fhcA1Uq
         lw+UL485Gp4xz0BaihKD2MjBiIwnYenrJ+4G6DmOx2ofR7lBXU/L8hGCug095xv7PbqY
         uFMOY3F6jD+aFaCJ+Znrr2TRnTNhLt/qq5qjQFSuD1kglZZxWsK18i3gUVgdh8i+BQoM
         aKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753214309; x=1753819109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCReyCpTjy4nn3Or0iXYbxmyahoyxBHy0fmkPDXu2Qo=;
        b=ikkXOC0KDMj5Ln0yKVIWg/pqQHA32sD48B6Zcpb6eut/P38IWhU6h8DGUBwT8Tsomp
         R9XmLyBaGP7JlLoAfmLfaoqBkJrzEGPxAT9As0dXuoPgxm8o14PGhKO9AjWhkKvi2OFx
         /BPUJestHzUBD6nx5vevTIm13+hwXDl0J8oRhKsAOawj18NTST1u4LI8JifG+sJx5/Wi
         5LeFUvVe0VrN/9KL0NgIpJCEaAlTojFikgp2I61fTYvcoXjpAeEzTatmcsnAUQ4Y5XTe
         kznMgPZdbDNGr9CV3curZsV5KzU+6OJEX1fY+rc8xHz1gbo9PVIabaEMaQGjrR6BBAn5
         p6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Jy3oAqdu2PzLuX14gqoOcJpU50docHJTETychiDewIYdBUY311j4ttd0FyMnMkAVEgSj5YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WXkpge5yNijdhUac1Wkb0oLKJzaSFjfbPbKJd/eLndx+p6np
	ygVygh5CBk410naAqu77wSSfj5DrLlwrYmb1q3NpuE6ygUXEA3VX/Np3dhXpYg3UTci2Srk0W7Q
	DA8rzUF6pngfbphBtweDCglh76uMH1RaC2wbN8rKC
X-Gm-Gg: ASbGncvh8Q15toqf9faxK1KxG9gsiE30gIRZrV0+7g2Jj0F3em65ayyfkbKigl1HW/H
	8nu4nVc9zG6zcNFI/jczpK3pULCW2vGZXE47zE//hV783tu4XLGCOfeZAz9GAbaP0d3+HLIfpKj
	jEzycfEYlrm3JEHeuSfTSsg6ZtznaPwgWShp5Z+jq0+EuN+EurBkG4RtZS76oBCYlwlPjfmXYg/
	lUwL7lV+E2OcK+5NtRmQ6ikM+jbQTfqOEicqQ==
X-Google-Smtp-Source: AGHT+IG0SmhWW8QBqcQaG+aqdEHCX9MzB9En/e5DNQG/qjPLBdBSfDDibdJJYPPZ2Dilzt1dahxQKsGb6dQAJYiMO+M=
X-Received: by 2002:a17:90b:3952:b0:312:e744:5b76 with SMTP id
 98e67ed59e1d1-31e507fdbf2mr658997a91.33.1753214309139; Tue, 22 Jul 2025
 12:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com> <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
In-Reply-To: <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 12:58:17 -0700
X-Gm-Features: Ac12FXxXNAuhn4Hv0iRIqcN8oUeZVkIDq7rLj71nMt9uRXTRgjxr4GtJpTqpIu0
Message-ID: <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:05=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Jul 22, 2025 at 11:27:39AM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Jul 22, 2025 at 10:50=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutn=C3=BD wrote:
> > > > Hello Daniel.
> > > >
> > > > On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sed=
lak@cdn77.com> wrote:
> > > > >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> > > > >
> > > > > The output value is an integer matching the internal semantics of=
 the
> > > > > struct mem_cgroup for socket_pressure. It is a periodic re-arm cl=
ock,
> > > > > representing the end of the said socket memory pressure, and once=
 the
> > > > > clock is re-armed it is set to jiffies + HZ.
> > > >
> > > > I don't find it ideal to expose this value in its raw form that is
> > > > rather an implementation detail.
> > > >
> > > > IIUC, the information is possibly valid only during one jiffy inter=
val.
> > > > How would be the userspace consuming this?
> > > >
> > > > I'd consider exposing this as a cummulative counter in memory.stat =
for
> > > > simplicity (or possibly cummulative time spent in the pressure
> > > > condition).
> > > >
> > > > Shakeel, how useful is this vmpressure per-cgroup tracking nowadays=
? I
> > > > thought it's kind of legacy.
> > >
> > >
> > > Yes vmpressure is legacy and we should not expose raw underlying numb=
er
> > > to the userspace. How about just 0 or 1 and use
> > > mem_cgroup_under_socket_pressure() underlying? In future if we change
> > > the underlying implementation, the output of this interface should be
> > > consistent.
> >
> > But this is available only for 1 second, and it will not be useful
> > except for live debugging ?
>
> 1 second is the current implementation and it can be more if the memcg
> remains in memory pressure. Regarding usefullness I think the periodic
> stat collectors (like cadvisor or Google's internal borglet+rumbo) would
> be interested in scraping this interface.

I think the cumulative counter suggested above is better at least.

If we poll such an interface periodically, the cumulative counter also
works, we can just calculate the delta.  And even we don't need to
monitor that if it's not always needed but we can know if there was
memory pressure.



> If this is still not useful,
> what will be better? Some kind of trace which tracks the state of socket
> pressure state of a memcg (i.e. going into and out of pressure)?

