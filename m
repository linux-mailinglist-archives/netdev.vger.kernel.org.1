Return-Path: <netdev+bounces-91562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F708B3118
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360F8281E58
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010113B29B;
	Fri, 26 Apr 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bmjmWq6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AE13B295
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115472; cv=none; b=sxic4HNWmlho5UVUVgKnxBSGL4jEtIA15l9UqXrb+Q2uuZY6UTrh0AnCCXh7XyZ28RRslornHCrSURxEJK9Yw8JVRSrS4SgFSkpVwtZJL5+Ct+p2AtohIk9FBPG1m8GT8ZkWaacs3zj7Ce5r7yF6BYxb/x2+7g1oaFEuIquPslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115472; c=relaxed/simple;
	bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMGiGFzuTXfnWAxXrEB+VabguNTZvLC+kqDI0A3MCl8ICJnTvN54YCGY04IraYK8HxWn0i1OnXG0e6y5yTB2JKQn2/lzftKoPSjaPMq5UJjWIp0GPPpDbDR+9DNSY83vOlFwWqSaRkHeYl/ekKuD6qyDhueVwpAyGJq39sAIk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bmjmWq6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9047a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115468; x=1714720268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
        b=3bmjmWq6DISYF9inZpVLsB4bMiuDANchLyBWxi9n4RDfYxINBHdtK2i52SwjlKl2LQ
         6S+a0zOalSrSe3U1Yq08YlNU38OsjLAGkwBSgiIqmz53WP8qQED/h9PvK0U9nwwe1UVZ
         SIX3UsNA3TmsRMd2joW85wjdKx3aN0W6rRsClIM5hEUupCHMiMFf5JXRSgxUPOzxOwzp
         B2IXVMw/UDKG1YnmC+Ee3/NEtAmkbHm0l/VKntqGO1kRCedEjudX7fr5GJme/ukEVYKM
         JOh4CZlbF2s7cKKKn61c2lvo0Fmf6FwAuIZnJL52zKTMUZOH/3sfqPhgtaPf7w4o1RnX
         asHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115468; x=1714720268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
        b=hGYIKkw4+XBk6KhZgcwXdUF854J9uzu/W+Ub4FJ69l9NCf+qiLc/4GVo8+XjwlTB+S
         ZyJ9S/zc12oX+JETfeC32LXrc21gzqBThzMbocz2RZS76U/O5A7WaZ5Q+1h/2mO9kupj
         Q6bHmvbGxc2fgF52oC8l+ke/c1uEQQ69wJX6cDid+YSQIy6zEXBZoCKWdx6krauWwoMf
         6uORFiSGBzm+0zL62Mji3SvsTfx8C+PXqD08vjT7YzBBvwpZZcIheGuYMnC8ocTJptiq
         Vo/A1H+M7pxu2iuJjU3ttfOyBjN11XKlURxcqAtwxtKrBnFV5CZuotmtZpOPCmnsO25T
         Wpjg==
X-Forwarded-Encrypted: i=1; AJvYcCU2mXQuSUclf+MyFhBaQ6YZmsmpAhEfu211j+B91uTRvJyCVkPDKFgCdKODEhnZneEffBqQzHRQTZ4YFBGHwPQn9J9tB54u
X-Gm-Message-State: AOJu0YzUAZ4yqC4at2J87mnZ7NCh5UzDeP23vUjOa7jvJmNJxguKKi1q
	IxVQkMDTgrXGfPlF1V8McPy8FXKbf8jdqh4Htv4NNKV1UKxDEijpyjMiVFaXDcRAHbm3wUmerpV
	pPfD0FArs9KJkigK5OTRdCm5fqcBvJFmhlfOE
X-Google-Smtp-Source: AGHT+IGT6onk+BwIZ+XI6s2mJnRWIfjrCN+NeywEu5zdlZD6o0AXsRSokjeE2Rw/pj9o3mnVZIxQInsQNxEXv0d0IcI=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr43968edd.2.1714115468235; Fri, 26 Apr
 2024 00:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:10:57 +0200
Message-ID: <CANn89iKZV=jg0ebTW-c7uLJxurLd7VWo=3GAqrjpWzDEovResQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/7] rstreason: prepare for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like what we did to passive reset:
> only passing possible reset reason in each active reset path.
>
> No functional changes.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

