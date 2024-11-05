Return-Path: <netdev+bounces-141918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592CB9BCA64
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9AC1F24795
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FE1D1F7B;
	Tue,  5 Nov 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tH8Zg5q8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61641D172E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802244; cv=none; b=JMLeXfW310L10Xd703gc+7kLSVRtt1It1g+j6SHp4tMF4KpfDILy5ymhTlsM3qfnqL5DA9iQrCXM73WQ9VvhSuCzfplL6FEwmIOOX8C2l+Qb/7/WZuXHv54xQE2wOsTuDc17MQGj3Mq3I5micLqGJEObvNfmI058aPjU+SsQcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802244; c=relaxed/simple;
	bh=PNoVND3bnc8f75lQllrFXS0FGhD4nHhYki2QododBTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKrFElom8xEetaHukG38+QwHDGd2Y3W9xj+JnE5VQJGaKu5UIBadw/1+LkAcYP9D655EGKUQxQIXFM8I43WfM232b6X4bXgDqTb0Cp/KppwB7S0wLuyLL1SVuYhMSIZgVA9V3OrlhBE15norFeZCSxxfQEUQqIsLrTPcy/uFTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tH8Zg5q8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso9704883a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730802241; x=1731407041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aJTIVUX3AEmT8fiu0foSVXA6Zv2teqAMQYr57Q+vUw=;
        b=tH8Zg5q8nfsQBZJgr2fIe1edv5A2WjDrSs2dN4FzEOZmwZJyZhuY9CVw2+L8He3Tuv
         I1CeJWCD4tI5wnOYB7OpxD7Xi2XJiLIkazeFjHX5ahtsoh6BrmasYtqPJhkrxv3yJFe3
         cMX4qhWAUVVC9/u9a3PP7NK1y38nQeG4al99M+Hdoleu3niB0E2tcjbLowayZ+R2aIUO
         /a3Aq2I6xfLrrgnGFyeAdyNbpt6B5/lLr5pju6NcCkT2ijNmVsbrYRksjWxHQxIFgyLB
         JKZrkLCfuPPm+1MvKumVS+9Sk/YDSMqsIng3AjU2HygJZLI0lBTyMcS/DpYZ7xyVvQXq
         sAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802241; x=1731407041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aJTIVUX3AEmT8fiu0foSVXA6Zv2teqAMQYr57Q+vUw=;
        b=pBsZxA8C5WZPgqLSQFWXlxhMbPhhLAjOYaHUYkwZNylNhduplkxwkVjAur9ZEHbzY+
         F8PC8Vmrct1xXbLRsR2ohFkcIeO2YBFr1wuTRa0ZhCxLTCNyglpRlOzG2trQYte6Cz5V
         Jh2n7mo0AeS1jyT5yPi8CwUYhZTSGXFrmdtZ0O3uIDuZ32NBWO5Vs6xkf0INy91HLswA
         EWXlIe33VY0ny3nPEwV5eGAGh8WmPkcK1ymgdgX7soaRO+eINMxRvxvqIvriRj49qL/H
         BK637Da30QTbiV0cV81tM9+1RHw+6L97BuxCIz4ERPyVqtib+HNLpoAZ8lZy7cZRPqdH
         oncA==
X-Forwarded-Encrypted: i=1; AJvYcCWU8j5efwsz1wKmd4mECSybI6TfV03yMrSfcYY0A6lq8nLIpxXP2V9wX1oDYJh6aQwvwBStxZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Gnahw+57wGNhprdmqH/iQW1wRJS30m5xgZk9Q6PLPMLMQILj
	Zc/Q/pmdgMt2zvtNVysxbh225Y3XsufZG4sINsGQIpjtaxLE4Z8eO4dB7koU7+QMIld/5WitjLu
	tfLOslU6UYuaKwCaLljY5Wv52/bJo8Vn7Lirr
X-Google-Smtp-Source: AGHT+IEtbYHQesiaNQogsvFxCPH2FaJT9RAjXN/UkzFGtvYmzWZNL30eeYn++rDGjQTLrFWxgljLlnkY+qZN7g7IJtk=
X-Received: by 2002:a05:6402:1ed6:b0:5ce:aec7:8802 with SMTP id
 4fb4d7f45d1cf-5ceaec78b80mr13497766a12.7.1730802241188; Tue, 05 Nov 2024
 02:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105020514.41963-1-kuniyu@amazon.com> <20241105020514.41963-4-kuniyu@amazon.com>
In-Reply-To: <20241105020514.41963-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:23:50 +0100
Message-ID: <CANn89iJNYT004pYCApzjqezcJ-UbzvSzNbD8MGMb7OLt_Rjt3A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct rtnl_link_ops.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:06=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> For veth, vxcan, and netkit, we need to prefetch the peer device's
> netns in rtnl_newlink() for per-netns RTNL.
>
> All of the three get the netns in the same way peer netlink attr tb:
>
>   1. Call rtnl_nla_parse_ifinfomsg()
>   2. Call ops->validate() (vxcan doesn't have)
>   3. Call rtnl_link_get_net_tb()
>
> Let's add a new field peer_type to struct rtnl_link_ops and fetch
> netns in peer attrbutes to add it to rtnl_nets in rtnl_newlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

 Reviewed-by: Eric Dumazet <edumazet@google.com>

