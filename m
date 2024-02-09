Return-Path: <netdev+bounces-70487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE9284F36B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441CF1F25DDC
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A371DF57;
	Fri,  9 Feb 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zICheXYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FA3FEC
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474620; cv=none; b=O21QilVZBNVnzAAJQlSDYIEHF+1+8bQ9w/dvS4UBk87zaMwoaQyH7BAvFmEm3Uu4Kx/BddtSiI2ISybvmySkt3B+XA9DGfQFohpGGCOAAguVg/Ox//X6SEIWfcbgKRoiddWHhV4IP3W/PXMbUzC5kWclzX19+nsR51V22luBtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474620; c=relaxed/simple;
	bh=EjBeicd9ieq2vcY8wUjCBPKYuOQmDV8XgSfrSJl4Pfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD6A58pHONv9HufQ7Sa21Va0O+nYFAKNQ7iPF6557wVWaqq6EwW1DVZo/C+ixXA8ujCQv9OsJIFoSDy+Lv8FArnRq+v1BEa/rmXwKtn6kxrnjama8pCXrH2gw9LyisAACnEgMw2aHTa973tcgOKF0DixrSI5CrukBmr0zPymCig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zICheXYl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so24377a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707474617; x=1708079417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjBeicd9ieq2vcY8wUjCBPKYuOQmDV8XgSfrSJl4Pfk=;
        b=zICheXYlVunPlwBnyIs1wrXUm9Zm3agazWHToawTOzdvzKoGUVy2obZRPOiBU2pxWy
         n0vOlZNuSwFVfDgCmGWLR+cT7NpKbjrWH8Xt7xaHat0MTLy6kD4Xr+UXqqPnnYLWJ97u
         ks5y6v9+WE4+m8WJKvRFukLJkMq3Bw14Q0WtrZUqdseS6gHYSUmt8OjM93WtnQHjA9/k
         dkybNQHWlvXxkQQ1qmMIicbDAPOAWSxL//+ctEvUSSNRT+eFfKQY/Ga+KA6HfS5nA9Wc
         4OfL7O0m0mCNtmnu9p/zBAMrmXKzz1btVehJfqnqwaEz6gnJfx9vTH52x5kN0j/7PYy5
         KZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707474617; x=1708079417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjBeicd9ieq2vcY8wUjCBPKYuOQmDV8XgSfrSJl4Pfk=;
        b=S9PNk+vTiwWWVcv6fQ9WGjRzY5Fp4T2FYUzmsgjJmseTJE+pJ57bA141RCRj6bJXux
         NXdHEvg2yZGE6oGPN40J7wWz7Id6IW0B2z1y5jLVnHQstYy8XjeGX6jy5SHo4xXgzdQW
         I2weNLK/GuWku2b/vB24PjhXXCq8SXvnkJRwvWe3oqf2cz1NnHADNGWuCzpXiqBfZR5V
         01GWe8BMMY99JMqtuAmKH6kz/rEsgiV8bxzgGKc9WolsqVreEP8NoK2s2Qc4WUdXSAQ5
         Bq5EMhvyMHMaPlgOguSHXd9pl7XG600JsbUfjr2HqCBQbQ0sN78upsBBckNKwFycWK7e
         Dtwg==
X-Gm-Message-State: AOJu0YwwsEoIATMbQK0zzyOPyFI1ApmxZiGWz+hGphxroHPiJi2Jb8vN
	+9M55QwkPgTN75c/PlSoVXKpVa6DHl6mxBRRdUWFTKuEttrF5mUA4zuzRySiZwjR7wBu4SB8AyE
	oAiZtQaIHHicZ2VgMKSNei5+CmFIaUHeDwX6VbBlAU7NGecGDWw==
X-Google-Smtp-Source: AGHT+IFLyScXmRBB81amziYPQxTaahmXU+2xO+UASp098OuCFy70vrQoItbuvygnGShOwJ2juxJ1vhxz6aw/J1JKiNU=
X-Received: by 2002:a50:c30b:0:b0:561:207f:d089 with SMTP id
 a11-20020a50c30b000000b00561207fd089mr82851edb.6.1707474617138; Fri, 09 Feb
 2024 02:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207222902.1469398-1-victor@mojatatu.com>
In-Reply-To: <20240207222902.1469398-1-victor@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 9 Feb 2024 11:30:02 +0100
Message-ID: <CANn89iKf4EWHp6CC=wtvEfeZn5w-b-BNBWzRuDWVh8y1EbGOtw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: act_mirred: Don't zero blockid when net
 device is being deleted
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com, pctammela@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:29=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> While testing tdc with parallel tests for mirred to block we caught an
> intermittent bug. The blockid was being zeroed out when a net device
> was deleted and, thus, giving us an incorrect blockid value whenever
> we tried to dump the mirred action. Since we don't increment the block
> refcount in the control path (and only use the ID), we don't need to
> zero the blockid field whenever a net device is going down.
>
> Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

