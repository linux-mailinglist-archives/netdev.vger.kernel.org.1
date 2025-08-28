Return-Path: <netdev+bounces-217526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D78B38FB2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D531B21BA7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D012FF6F;
	Thu, 28 Aug 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMzBXb7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320ECA6B
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340385; cv=none; b=NSkTsBnLMrlJhWyVDUs6nldkcFiv/Fnh1+YNLNbc1ipk2Zv4AbBz0W4DC2mrSqOh86hDjV0RCKvvqAqGATNjr7mjATB4YIM6d8slAy3NUIb09g7fVFHjURAYDLvXNILzpm3LPa6zo3aLGdsXZOwT+Vyjw0zIKTg8Bo1coOQzWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340385; c=relaxed/simple;
	bh=BnSf8AsPUnZL6Y9gudlIaObH1DM8+jTKCqsWJEycmFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prqt4tev2ff5PllRWKAEjQ8+m7Q0XclAmWCir5h2Gvm3jXnzLHZzTq29AQ/NfMEXA30Vi675Mhyao4ElRYwjNvzMlrhywO1h9eK9hDfVZA5bstJssYPFBSM+FoBXvYXRmPg5aWCTtWGQ8Q2DWJBlzSIldLqOgf7Hdcx/fBf6y2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMzBXb7R; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so339493a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756340384; x=1756945184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnSf8AsPUnZL6Y9gudlIaObH1DM8+jTKCqsWJEycmFQ=;
        b=pMzBXb7RUvTx3WrajDjQ3DjUVUvFVZki/N83dhH2CKhwhD8MngObtNd0qhP3dXCCwy
         8ta/wFq/WjcFEAt73w0gD/RKNW8jX5l9fNMe+ppqY9YvYVdr0bMcS4pczU7lTUH+ah2v
         2n4ex6VJaAPFQgySMtULRkx40kdOnl3FDh3ZODUZluDkGQLbH7uUD8poiWknW2Y90P/1
         06JGn1AP3kYZK/WCuhWO7TJrUiGzXLTr9dQCjx5D9kozlT9LG7iln986fkPryL9sHRJo
         p08IEDpZ+b43M94PdujPqNHlfn4dB2fQrHFBDwGx2BhsHaj2EWNA4stv0NQP8XtstWuS
         q0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340384; x=1756945184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnSf8AsPUnZL6Y9gudlIaObH1DM8+jTKCqsWJEycmFQ=;
        b=PxHKqnIUfT8jYQ2G4xQTjvwcsf6WenGsbKfD2R1vjSFZ2XVBH+db3MLIBz9khV9xZf
         bmTK0OZwFmp0BtKUe9n3cMRDdbYva+fq0LFdN/EzWMDu8ADVySYm9QKnlQs755S9lWR9
         DomQujvDqNsIetYhCRfXQfQ8iTV8qT/NWyF9NhBKEAOx5EDcScg8Hp6CZmWuFTlj4BP+
         StX76ezQf7m3zVWehdX6SuYLUP9cWlrjXaLH7RQD59lrpmdy1GQZR6Ez6mS0NWlfZvoV
         g4XCnS5exzeT42EP/lRba9PkOSVCKzvHOBvk9o3sJCRt1OY9XcK7D9j/r196OxfMtIlD
         5lpw==
X-Forwarded-Encrypted: i=1; AJvYcCUP2TisFPtk7MeeF1gMwRp2E6yBlKInxYytwISc8AP4BjpcziyldFQZreggvPEtkq8Fw8WRB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qEhLO12t4RhbSdhWIYcRamJEzNz9I7z7F4e5DdcfLzaBjrZS
	8ixN17n2zpme/8HCSDfqgLPcxTErXizp1R014xYFzTDF3tYbnY+nnkk0FN/SdG4shQUEaXZA+eK
	DjsEs5A3JQE/IzwOM6h54/NDpVDmpLRGSrSqOQy5f
X-Gm-Gg: ASbGncsSY18boKTw5+dGibdS5+J6LeY9hVwEKjZ9O6QNTNxKA1tT6IKQd5nKmq5nfhw
	Jr7m40w3NLQaHKoeQaBWmZpfCD9i6MP6xfbx8W7XxsppLjZbnrkDYhlLmJrHpLv+fRDNPSL5zlD
	MXgPqx26tzCwBIEuNb28hetf4gSx0aTbXTyrjcIbP8ItTklPSUyoshz5LfSTL+Ynk8dC+91hFTF
	OhQgysNckps+ip6uKHsLvPplVrnjT/DNcnlpKg9zemAtGwKaT6NC02t77WyTZNkjL9hhwW4hF1E
	gAs=
X-Google-Smtp-Source: AGHT+IEcMiaI8p4nu0+Oo9FmX3c8dSh5JHEOBpRgx1fzXDPwmG+cFna0yv+B82bWgwHATb9RvvUHalC2nnsdSOA2KIo=
X-Received: by 2002:a17:902:ecce:b0:248:ae62:dd with SMTP id
 d9443c01a7336-248ae6203eamr41169345ad.42.1756340383569; Wed, 27 Aug 2025
 17:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-3-kuniyu@google.com>
 <aaf5eeb5-2336-4a20-9b8f-0cdd3c274ff0@linux.dev> <CAAVpQUCpoN4mA52g_DushJT--Fpi5b8GaB0EVgt1Eu3O+6GUrw@mail.gmail.com>
 <e1ec7d14-ec50-45a1-b67b-f63ba75699a6@linux.dev>
In-Reply-To: <e1ec7d14-ec50-45a1-b67b-f63ba75699a6@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 17:19:31 -0700
X-Gm-Features: Ac12FXyhl0cHjLniHgsnjLB1YunJzhJbR-hzj2gsufADHNTLK3kQXg1nZBBUI8c
Message-ID: <CAAVpQUCnNbV+CcPK48qxTF812xbCeq+g7+avKRSKu2sS+oKw=g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:06=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/27/25 3:49 PM, Kuniyuki Iwashima wrote:
> > BTW, I'm thinking I should inherit flags from the listener
> > in sk_clone_lock() and disallow other bpf hooks.
>
> Agree and I think in general this flag should be inherited to the child. =
It is
> less surprising to the user.
>
> >
> > Given the listener's flag and bpf hooks come from the
> > same cgroup, there is no point having other hooks.
> iiuc, this will narrow down the use case to the create hook only? Sure, i=
t can
> start with the create hook if there is no use case for sock_ops. sock_ops=
 can do
> setsockopt differently based on the ip/port but I don't have a use case f=
or now.

Yes, we can support another hook later when needed.

