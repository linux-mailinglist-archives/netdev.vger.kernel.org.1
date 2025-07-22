Return-Path: <netdev+bounces-209023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FADB0E073
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D21C836BD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAF2676F4;
	Tue, 22 Jul 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6AY6WIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C93265CAC
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197879; cv=none; b=bNSUjRQ0o/CGM56x5cf26Oed+KyeyXKfMq6aFq5JbD+pvQ513FuBB4yC6lFSU8Gkab5Wep6B1Ka6bHhhyzSBn0lovjBmKVQRrC4Btpd9aCRsFQY7U5yfEuvqdoiXkUjxxTsek9yPr+tZ4RadLjzQBgVihZr6dtHukJtX4RKMJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197879; c=relaxed/simple;
	bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLh2vIbGNu5j+nmINvLC6HrDbkAhBgvORyL1hNP4yY9HE/VUK/FroOo2rMqabPCkVDxQm/43NjyoKSiZgYnaInirk2CrhTzR450+ClLuI2xs+4ONg/iFx1X3+BrNFzheTQJfCQBQdEp7RWaqtLegiTSsgSxEFR0w7Bq4LXs+cTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6AY6WIk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4abc0a296f5so49249441cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753197875; x=1753802675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
        b=J6AY6WIkYuozsulcwA+OG++HiPMxHiwi5GZpVV15L5v2xxDchNcbm4D1RiusAnr/K+
         8XUL+tNpSiL2UEaFqnmf5uf8zNFlsCvCLrHvXIR+Gdu+e/gZwEaJRDWqnGDP1ldgGdXo
         YiC45swlwO77lgubGT+xVxK6ilEFg/aND3suJ/vE8ATTkNcXmR83vovvEAsE7K5chqTK
         dyW+/2VGa6DKNs4EYzBxD4bIf3MLZUb/oXfuU/Q807ucc2E6NZLwGwQwApwFSEYA/bHT
         8A5I19hQjAONyRk87u6kVNQSPZzpsDsuWWzLfiW73sVXRuheUTsmAnbGxFvAapBWl7Vt
         OrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197875; x=1753802675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
        b=nKpk/j4kWGb1OQo6dYszyJjqRPLWbMMIRF62r1gr4cuqU2lqn8ltaWIXtVIAhSY2Aj
         +p5iyPtZxxf6vFdSiLtC99GqrQJftcAWBZvgakk9Rw1Hn/eTbsWvpSiRm4+1rg8cei1c
         Vf5e9yYjzCMfjVdOWHVceM2bWPT9Cy4l5xn4BUN+rl3eoYfogx79OXxPnSetYAOJLXx7
         ZfTHTOyb06NlYj0wHiRsXxSvK/gV+frYWQxFnjmK1bVUu4+TJk3DOXpu6zc4TnJv/G/5
         4JNR9W/m9LN491UlfgONIVZUC91kaMnblZzJDCZpO4WgnCKrBLgIJjXnRY+m7mQDTAji
         3FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhlOaB25UKzb33gwUCJiAFiCYzQYwTOhw0xO3b+iIxmyGVZhWbSRQ/y1X8sy/+8zjJMvauvco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tFQHw2CKK4b0iq1gTcbblACfB7XTa57ZZWCzYiORpFR5a4gS
	gP0gndhuClBtr+DqtFF1h2mniNpChZmQPlVi/UU98vDBCdofFbN2HRnqKNmMMs/AWC1JZxiYwgM
	vq5EGj0ivuSBcysIBLKpwB13dvTIFJpSy/tpa5sXV
X-Gm-Gg: ASbGncsx7GUyJnRUq3GXi+05qx8RDxYcFI4IoaIO0qsINyZtUxkDBaoe/Z0Ly5GEXjy
	ZxzQN5X+BsbghGzNxP/JleKMx2VTT+qAmqIxI7FsFbsIDAYBU/CbIpHJge+8WWnOP7klt5AJ8h+
	D7XB61LDiDu09WPHgTvVyO7hShz+hOxBUPrnAQ6QxqkVkpQo4FYG+uewZOzO2/tO/j4Hb2euxFp
	1WUfA==
X-Google-Smtp-Source: AGHT+IGNqove+d9nqBnprWFval+F465BdR48MaFKPBz3i7+j2sNb0kdf1AFXSoxhiABjI4x2NGpy1yAogO5YUQ5F9ng=
X-Received: by 2002:ac8:5a0e:0:b0:4ae:6b72:2ae9 with SMTP id
 d75a77b69052e-4ae6b724070mr1666271cf.43.1753197874316; Tue, 22 Jul 2025
 08:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
In-Reply-To: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:24:23 -0700
X-Gm-Features: Ac12FXwavIrX7g0teLwhtLsjBkoK2NrttJzG5Br2HWJz_qCsAQMuVk1ahKeyT1Q
Message-ID: <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:14=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > When running under a non-root cgroup, this memory is also charged to th=
e
> > memcg as sock in memory.stat.
> >
> > Even when memory usage is controlled by memcg, sockets using such proto=
cols
> > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> >
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits, especially in multi-tenant environments.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and a single workload
> > that opts out of memcg can consume memory up to the global limit,
> > becoming a noisy neighbour.
> >
>
> Sorry but the above is not reasonable. On a multi-tenant system no
> workload should be able to opt out of memcg accounting if isolation is
> needed. If a workload can opt out then there is no guarantee.

Deployment issue ?

In a multi-tenant system you can not suddenly force all workloads to
be TCP memcg charged. This has caused many OMG.

Also, the current situation of maintaining two limits (memcg one, plus
global tcp_memory_allocated) is very inefficient.

If we trust memcg, then why have an expensive safety belt ?

With this series, we can finally use one or the other limit. This
should have been done from day-0 really.

>
> In addition please avoid adding a per-memcg knob. Why not have system
> level setting for the decoupling. I would say start with a build time
> config setting or boot parameter then if really needed we can discuss if
> system level setting is needed which can be toggled at runtime though
> there might be challenges there.

Built time or boot parameter ? I fail to see how it can be more convenient.

