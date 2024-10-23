Return-Path: <netdev+bounces-138220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E29ACA16
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4609BB22EC9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14F1AB539;
	Wed, 23 Oct 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlWvPL3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B91AB51D
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686854; cv=none; b=S4YVxNNvDPqe2+VClBZ6JLGvJH4trKMGH6m5MyN/IN15Tok0O2c/QOS33zmwYhi1bDYcd/PH/jlimbBo1+OM+KwvpJJsWLgu0era5zEeYR5bZB6lwduPpQ4cfw+dU8gwXnTEbCJFGKzpnr0Ni5e8yNOKcA4RaGTx8FQ9Pay4WDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686854; c=relaxed/simple;
	bh=deCFwGg/9lxaABG8sXNUu3EC6Nlc4Qbqov6VgZhGjOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcLIlNzY5kAEa6SOsw9FUcA2VkL423x30xMRUs7w/Lacw8PzZzhFvzRJtREE3I93McYPiOW79rFtw4D7fH083/BDfMWTyqW52rwipChPyPANaFSuWKZM0AqAC4i9Y7J1jZ3ngg9AO8YaZ9W1wMkx5l4hCdDNMVeacb0rzX6bwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlWvPL3D; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so8431130a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729686851; x=1730291651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deCFwGg/9lxaABG8sXNUu3EC6Nlc4Qbqov6VgZhGjOg=;
        b=mlWvPL3DjYKbfNlMzjXn5YIFO1EUsQ+AmJQ6Ir9sCD2gB3PPg9NfcZfH66DEO8+Up5
         FeB/8DeRWwDAfFPHreQV8uyyCehfNrktswBVm4MoYRh4tpOqRAG49VWhfoWdypHXUulC
         1rNc0WlNTMvgIc6wSAGjzPMO3ijlLJ32JDY4k2O1FdUpXOTXZsr/xnzfvbMTdDvw5y3K
         uB4Lkq/wfe50zBQBPiqjKW29Gnf4xZD8jO6Kirr0WZ0Ve43l43xvDLyAi/WLpqLSK2En
         EkG6P0eeHdBdtbwXvG08JjoD3J9EUNriRgzEnkaZk436Fjxxn0g+efvVouy5Vnn8l98s
         vaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729686851; x=1730291651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deCFwGg/9lxaABG8sXNUu3EC6Nlc4Qbqov6VgZhGjOg=;
        b=fJpD9Y4UC+WjwM4S6YfQDZ7udayXeZohtjGpj9IgRLcIEhgsbhJwnk4qYa/ycAiRaa
         xk2LB+vmFNO8Tkk8r07a4ooYaEIJUFrJUi8Vi5Akbok8Zr6QpCLYnp+QrhZ37Rw+VFl/
         kBlyXh1LnTZr4f7dLkpVFOlH3+X/DokBw2GWpqi6Cc5A906i58Z8Zu8jjBjBZiPvEDCn
         CeIeYgyrDlwQH00S7k8fCSQkEZZynTBjr5xSzk/UkR4pbycgLUqsU6b5Mi6oL7G1iU34
         UdJfzfTHeReiNBMKbOm3WhI0ECgDBkwsWKb/OTRJTOc2BwXU4LRQ6G2vuD+pRWAYnsGs
         u8gg==
X-Gm-Message-State: AOJu0YznFLVatJ4s2jrdtpTcDEfqro2yvmozg25Ub2DROb3nFyqSYUv+
	Sz6+lvkOiWkKYCAWzuaOk1IdP4lcbsOzvvnjAaoCFcDXEtkjp/PSzTNCOJo5nvzqGVMDQON4SmQ
	Dr5GgwOpoXDalNtYTr2MYiLQHtKQsX7XRzAqm
X-Google-Smtp-Source: AGHT+IGJE65dowE1y2FqdYjpITPp7HgqrSh+DyeNIT/eTRZZa5k1iFlvxoCR8Mg8xmuD0y7QzyIfMYmY2aiW7nuEcSo=
X-Received: by 2002:a05:6402:2356:b0:5c8:9f81:43e4 with SMTP id
 4fb4d7f45d1cf-5cb8ac499efmr2031876a12.7.1729686850363; Wed, 23 Oct 2024
 05:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123009.749764-1-idosch@nvidia.com>
In-Reply-To: <20241023123009.749764-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 14:33:55 +0200
Message-ID: <CANn89iLOPZ3DuaZJR6=v=3BFkq8dcy-M3HxXY22y4LS4LhZzhQ@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv4: ip_tunnel: Fix suspicious RCU usage warning
 in ip_tunnel_find()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, pshelar@nicira.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:31=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> The per-netns IP tunnel hash table is protected by the RTNL mutex and
> ip_tunnel_find() is only called from the control path where the mutex is
> taken.
>
> Add a lockdep expression to hlist_for_each_entry_rcu() in
> ip_tunnel_find() in order to validate that the mutex is held and to
> silence the suspicious RCU usage warning [1].
>
> [1]
> WARNING: suspicious RCU usage
> 6.12.0-rc3-custom-gd95d9a31aceb #139 Not tainted
> -----------------------------
> net/ipv4/ip_tunnel.c:221 RCU-list traversed in non-reader section!!
>
> other info that might help us debug this:
>

> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

