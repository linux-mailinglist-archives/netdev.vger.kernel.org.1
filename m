Return-Path: <netdev+bounces-90082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED18ACB11
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F948B2268F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0102146004;
	Mon, 22 Apr 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqMA/gD1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAF145B35
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782424; cv=none; b=Vzw8wcWT/av0thE2aXYGdlxa4wNQtITtRC9NARU7upP5xEO2YIlHhmU+c/3d5pLqj/0iGdmcery1vecbn14xeb9lOtxWAJBn5M5eIoQqudk82JqcCVHOK4JfrSVQ4ZsjacLhayz0A/Rj4jaq+z7SmlAf1zSz0SZFcoQ6JwON7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782424; c=relaxed/simple;
	bh=U/D2Lc36T6HM8jmIRLh9dzzGm5hBwA/J4shR38xtGj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VASHd0cWR6uw437RFKdkRi9qtskti0/2+MDyaodJN3pg0sTAm4xNnwRGGZexmJG/IbHGkRKsuk2s9QwmxAvBt2FB9aKSamudEkvHdBRWVsZkyFWzyw8YN5DiuipTYL+VjV0DeilPnvwLqZFSo8iTpapgSnRznLtMro2ZxLmBTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqMA/gD1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so12940a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713782421; x=1714387221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/D2Lc36T6HM8jmIRLh9dzzGm5hBwA/J4shR38xtGj0=;
        b=sqMA/gD1bKrl1EvYB7YIr9kaxLVDl5kbuNIz0Z77vPSzvjNGK1Lv9xWbzL6TlHmEvu
         ypiwxxyazDIatg64ZSlWgSyM2GsP+Zn9ntnrzgxUOBBVFgUJgCaPje1VXpVsgt1hGxpu
         6nYceYQEaFm1SVZgWD8MA8muDJvPSk35A7sJioRu6KNjul1EvHUgWusvUkQIZH4vf9DU
         JGq7AakBMcX5SWtqoXUpIAn0aNEuuRlER4A25H5SsEu8W86aWRoAWxztDTnwJ6YuVzyo
         HGoH+XN1b9Iw+f61x0z7ebhQJjsLW8vLsN0ZJeToIzOMIrl4PUzCbhUqjbaI2rQiuMw6
         r1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782421; x=1714387221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/D2Lc36T6HM8jmIRLh9dzzGm5hBwA/J4shR38xtGj0=;
        b=MqhiJ/7EdimOTAP24qDQDjA6Ic8wcB3eHc9C04wT3V819Jy7bxqqRGWNTPzLE9o8Bc
         tKh8ut1QKhu1gSTQXeYUmfISz/a+SnE1alLSTACY3IlAHxyBfGkG/2QIDdXhNjJe8Ob7
         ZgX+YQqrboh8X7BLii+nb928RYxEiebO8aCkAA9hErnf/y3Lqm1iCAlYEnkhAQb2/y87
         yPuIGGVsY/523psSHOtXmETQJy/O2LPmetol/vRrSQT8kBQWmVIG9ilDG+Fv+7+RWFjA
         KBvBqO1eD/PWy/5KWp3ljxMZ3PlhtC0SRDhOPF0dUTgIURosZkx279KcPj40UWOU9mGR
         7Bcg==
X-Forwarded-Encrypted: i=1; AJvYcCWkY1he21rOcBD/pTh/sR6/4s7O8dy4AzwnJWitfjjGUrnZafbILsHzXpOxO7SF0LS1OfOa8bLcIMyTQkFzQJs5Wrzg2RIX
X-Gm-Message-State: AOJu0YxZqLew2L7fxjY6GY58yf9x1RWJg8oN+7fr9H6gJH5cxAZcNlbQ
	XXtGNbJYoDT/Biyid9utIdPTn9YA1D2Vy1pWd/0ny99Xqznj6mRsJ5Oc3YVOxkTWFUdS85XehPb
	X8YQv8myOK4bfLh8Bsz8F9U/PF4jl0QyWX1DT
X-Google-Smtp-Source: AGHT+IFEDJzNyvnKGXFHdnc6a5FK7k7o2i6NtwjtvYhoFz+lwjwRo8hJ3dNM906sO76hi2xhm5lND1VqKnFt2nWDqvc=
X-Received: by 2002:a05:6402:b12:b0:571:d9eb:a345 with SMTP id
 bm18-20020a0564020b1200b00571d9eba345mr199785edb.4.1713782421073; Mon, 22 Apr
 2024 03:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Apr 2024 12:40:10 +0200
Message-ID: <CANn89iJA4nC_c7K0ivb=hENFZL5sEB54SQHvMSjEAJQG7pLEmA@mail.gmail.com>
Subject: Re: [PATCH] net: openvswitch: Fix Use-After-Free in ovs_ct_exit
To: Hyunwoo Kim <v4bel@theori.io>
Cc: pshelar@ovn.org, imv4bel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dev@openvswitch.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:37=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrot=
e:
>
> Since kfree_rcu, which is called in the hlist_for_each_entry_rcu traversa=
l
> of ovs_ct_limit_exit, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
>
> To prevent this, it should be changed to hlist_for_each_entry_safe.
>
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

