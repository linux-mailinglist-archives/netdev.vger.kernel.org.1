Return-Path: <netdev+bounces-213340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02161B24A10
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27CE721DB6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FD3EA8D;
	Wed, 13 Aug 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="XrwdfLoo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD552E62D7
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090019; cv=none; b=pvfA3bhon1d28S3hw0ih+Pgy3F/pekHrHKYdxWLZ3Ln0A6n3XbBJ4kOBxYUyZ1pF6MW6FzxpGMmwtPRhWij3KchsZDS4BM6pAXzkq/1M5KByFtW5T5wdgRLUJ4oi/kQfx8bVdLwzS+gx/ondXLiJpltPnZgPK6PrdSgKC+pfzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090019; c=relaxed/simple;
	bh=kbkSRKewyFcnbz3jsVNMUibXidkHNks9qnhNs9m/Qbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmMJRfQ4YB4RoOebV76GjKW7PIrTeRb/5hb4rb5+7MBHwdA91DQBoU4RmDFy+M3o9WQS+22hnvz1jZyIGk8RDihghmkPxtviq+w8ZPkFfRkdL6rTdSRyfQjKgdLLghTwyM++b822WGQacPlBnRheXkEfC/N4yQ9oi5YXXS+TwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=XrwdfLoo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-709ec7cbaa5so6540176d6.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755090016; x=1755694816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/BrlZbr/T7l2ZRE6UEhDbhwVQUKfgdvzKuP95OrSQY=;
        b=XrwdfLooH8vr3mObn6Ld61VxpbpQPvg7XhYLUMZw0HPBu4FZvZ/P1MAtgIEKTKoYCr
         BLyTnocIB1WZ28pyLtelyzrptdsKOeJto758b4kpUfbgEahjwJXI6KIfIBljuJJr65/z
         Dj85l/pBuKzDea2UZPp9f1nfWZTEDyj/eQLtcTnl0CMgzg5jI99MgViYm7CxKhQztWg3
         I7PCORcsdQBwoZIoUuKQyitedhoINzH7hlO088o+Xdu3gevT8Ml1W2FjmJckodtBHx5z
         D/zETMcKXCaD1PpZVbaFASa16q/nHwhOtixrJ6s26RY0/YPh94r/DM0oeGnvG9cf1B0H
         4yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090016; x=1755694816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/BrlZbr/T7l2ZRE6UEhDbhwVQUKfgdvzKuP95OrSQY=;
        b=o1f6IlGqOOdosjxZSPeT0k8whPWIAOfprAPy+SRwrpCujxZqGuuiAF6BjbN67v8ish
         /nnY3oFwfNlow8c3LOeBMx22py9PTQcLbKpkzgWqIgnHhYQxOLqqxsudVcMUcYqS6WlW
         3ZsWCzzqj/ltC4dLavmn7zZa8wa+4I83tFUTlr+jTfVc2LHWLtxRqEhSvyKvbCcY6P0k
         BcafCFtCvuLlsPlZ8h5yJcJYI0z12B24f2qP9U+pgFGjKx38v4iks1IhqiQv91rT7keH
         SXH3F69aq4YQX+ZNDe5TKhptRkPcDnXS1cK4txTEgoJlSTUYTxPi39vfz2cO1aSOB6Iv
         Lnyg==
X-Forwarded-Encrypted: i=1; AJvYcCXM0CGVkXrppEc4WPP1H0QcFl5mKVQcwBDznGQRbzBwdwRtPw+YrubKWK2WcFPMmy7THrrwBVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaXeKN3JUv0mydN4JDmjswuZM2h+2d9SwiSVQNJk3S2lBC2XHw
	nIT9IeO4TjHM5zg+urb0F1rLJI2CTTKXqK0KO2OXHtK06ghJIL6swNJPbXc7gbh22CA=
X-Gm-Gg: ASbGncvKu5QE2OMrQt718kTmS1KaV/A6H2nLUJEqlZ9Y4JZSw3jXNy4xaDw3agY7atO
	ZTaGSU3Q4VWAKDIEcpATKIdP9NL3/q7bnlF4+CRiCBlKxigKzZsYgMA4YRwhPIKsH9svZq6MbPT
	GqQdNKczZbeDKP0SSyPw0wgnCH4QCkuy2lXvEE5IpDEswBO7yD40qG0KCmAlOfrCscpzNiB24BS
	wOqvWrcN6kiwQM2eddErz6qpVzSnVG6xb8sUKop9k6lGvYYR4ONB9pKk5oH3YOp3iOgW6ab4gX7
	nXqhrN/ciFhRVhAdht6rkL1LNYlp9o+DJeEQXItH3/3und/Tos/oItCuDyjVoxqf8bAW+wZWt55
	/A0ZdOLG7r8hPk3IK6YyMhygfSNsVa4zV
X-Google-Smtp-Source: AGHT+IFgGWoMlnm/Y1OcmFOyyn2dsuqu/R1TVP5M10fhTPzIDW0MUbQN+HwN5hLswo+SbRfYuOk9QQ==
X-Received: by 2002:a05:6214:27e5:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-709e8843a0cmr37405206d6.19.1755090015449;
        Wed, 13 Aug 2025 06:00:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70920e28dbbsm188318676d6.62.2025.08.13.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:00:14 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:00:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
Message-ID: <20250813130009.GA114408@cmpxchg.org>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812175848.512446-13-kuniyu@google.com>

On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and processes that
> belong to the root cgroup or opt out of memcg can consume memory up to
> the global limit, becoming a noisy neighbour.

As per the last thread, this is not a supported usecase. Opting out of
memcg coverage for individual cgroups is a self-inflicted problem and
misconfiguration. There is *no* memory isolation *at all* on such
containers. Maybe their socket buffers is the only thing that happens
to matter to *you*, but this is in no way a generic, universal,
upstreamable solution. Knob or auto-detection is not the issue.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

