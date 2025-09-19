Return-Path: <netdev+bounces-224890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34A2B8B41D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649F97BE4B4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364212C2ACE;
	Fri, 19 Sep 2025 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23lYkpOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE72C0F89
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315468; cv=none; b=lNFB1xl0dZnwGPzQLkooTZWo8oObh0egPetKChjDTtFXyyIQftLJXOYHKzkzOuqtInB1Nd6F5lq0wW0efa3ucAfz+KjzpkuZwUfZnjfZqWANRd3HXY/CnO6p3jiolmkg2AralUddqbF8KWsHQUiZVWPah0jGfq3MxXR/SgkauGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315468; c=relaxed/simple;
	bh=5y451mmFqbRD13m+TGMqd8GLu0vM9tYHdM4OHW7YdYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp24xcYOkGSxAkni2V0rD8ayMPCNGgBrhJ84V1SNLrnPw7DIgWj/ikzsBxe1v8Ah9jq1lsnQ/zxthYzBVxfE6o/ikHehQYvG4RBraW77YQ/olhwFMXjjuaLhwoJUfr8h5PhN1WcLS68LF6acpD4DB8/iIF/JsiMv8UAC5wI7JwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23lYkpOX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b48eabaef3so26311451cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758315465; x=1758920265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l8+OqSM7zWkepqqT/VZRDVkiN2/eMODoRt+gPSQ1AE=;
        b=23lYkpOXGLXymZIrljlKGyYdHsO+Pg2MA9JhEg3jimQ/j2LHeRcC2qRz0Xlu5pN6xs
         bidDQmDM7dB0y8IKX+l7hStJypRC5JXQqMrvuQHiuxIib4Ut/+NNTIUCh9tt47niJWp/
         dcaQxe9dU41WQgCxcn8knicRV5a+VGwnzYpkZcFZs2VxKZGhN/lUtk/Eg46LrEl9pp7l
         9o0Z2p11Zn+C9O2x0bsw3/OwxBinCW3HxaO5S06Zm3zGf9Zt3zc6PUW986xxi8pdYC7M
         TaIilJMvq7Wjh0SDP18YDWrWxIaf/V52+CuWzmZBTGMJTrMopINKX9vBDT9nuge0oGnS
         n4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758315465; x=1758920265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3l8+OqSM7zWkepqqT/VZRDVkiN2/eMODoRt+gPSQ1AE=;
        b=NdsuVVj8wfKwueNkPaqfpklJn54sAo6U3zy5H52wgEp0TFr2b1zitQW6a8EpfQ0Yw5
         09YqNfLoqo+MW5CcK+dzlo2gdtkZUkuG4Me51RoGy5hWNEEDqmwBaKfGJxr4bB04C1se
         Pof1YEf6ys1Ns2/Ab+xaYMd37y1t1nAoulvQW+ZaaSJKoeMHRmhL3ZtNZkiSrxEhOn7w
         1ZjegcW8fTnAfz1McJwq+GV7a02kuTqDnUKiXyNO0OZcvGHVlCy3YXHyyj3akxdkViRX
         ObIEOlEMLKtF4DjsxYnZnFCkfUGv33TCWvbUs8T9l8Nj0vz5m92sbnHrQ/sPur3S6Aqj
         bVXA==
X-Forwarded-Encrypted: i=1; AJvYcCUcYLSqg5ruVveRqQ+dYBb6+LnjQE1fp/0uX/MoWgLt4OJTSRSvDkTVGo6sJeo9j/VsiOgMkyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHkTOPUqW4jbxfp5lSxqDdEDYr7HVNJZCrps+JrQvMa6KlHFS
	br0rjrcpNd+2RZUC5oNy9VFj/fq2K0JEK1JF9AjRWDed3pKkBItZ51rrpzwdSOG4CIEFo2biVd+
	/J7hftI/UDANrtbvGQERXkBsdoGhq/rIb/sRVU54Q
X-Gm-Gg: ASbGnctaQtFDSUzwMNzSF1pGGIMnFVZjqZtDRivAX5pVoQSmYxdg/G8l8yI7VI1NKqC
	hp25etIJQ6bf67TQOE6Oud/gc0OLZRmDtk9kw/2YVvA8ZHiN1SfLQIT3tyw0LmsMrNxBAqXEK3D
	F3U2VHk2E7cFPJwy58wSlPYwGRnch6C8OhqShTTLfn1JSZSbijKOU8tspbAVhhAQq4+dUf4Ah8/
	odGsw==
X-Google-Smtp-Source: AGHT+IH9fB16H0j+2dcSTo3eMaROiM9CzIQ6ZYwLb0P7ynyYAwz0eKDNcyPaZk+Hwlt79DsRr1vfReZoDHDQpwQUiRU=
X-Received: by 2002:a05:622a:a15:b0:4b7:ca0e:eff5 with SMTP id
 d75a77b69052e-4c06d67e8bdmr57786181cf.6.1758315465119; Fri, 19 Sep 2025
 13:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919083706.1863217-1-kuniyu@google.com> <20250919083706.1863217-4-kuniyu@google.com>
In-Reply-To: <20250919083706.1863217-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 13:57:33 -0700
X-Gm-Features: AS18NWDHpbOETwaRc8XelWBMd0o_44J9S07oWjthBPtQM3L7ehMoHbYAoRU-qmU
Message-ID: <CANn89iKdzw=22NTAT-uGhwNThvA7iZT6WbrdiwN7jQpLOXE3qw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/3] tcp: Remove redundant sk_unhashed() in inet_unhash().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xuanqiang Luo <xuanqiang.luo@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:37=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> inet_unhash() checks sk_unhashed() twice at the entry and after locking
> ehash/lhash bucket.
>
> The former was somehow added redundantly by commit 4f9bf2a2f5aa ("tcp:
> Don't acquire inet_listen_hashbucket::lock with disabled BH.").
>
> inet_unhash() is called for the full socket from 4 places, and it is
> always under lock_sock() or the socket is not yet published to other
> threads:
>
>   1. __sk_prot_rehash()
>      -> called from inet_sk_reselect_saddr(), which has
>         lockdep_sock_is_held()
>
>   2. sk_common_release()
>      -> called when inet_create() or inet6_create() fail, then the
>         socket is not yet published
>
>   3. tcp_set_state()
>      -> calls tcp_call_bpf_2arg(), and tcp_call_bpf() has
>         sock_owned_by_me()
>
>   4. inet_ctl_sock_create()
>      -> creates a kernel socket and unhashes it immediately, but TCP
>         socket is not hashed in sock_create_kern() (only SOCK_RAW is)
>
> So we do not need to check sk_unhashed() twice before/after ehash/lhash
> lock in inet_unhash().
>
> Let's remove the 2nd one.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

