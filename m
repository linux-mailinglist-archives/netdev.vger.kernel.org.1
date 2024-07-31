Return-Path: <netdev+bounces-114695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046994385D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6991F221F6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 21:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D816D332;
	Wed, 31 Jul 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcPYoKY7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9106716CD1E;
	Wed, 31 Jul 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463077; cv=none; b=ukB2hgsC4CByKRQF0Xo2S0IK7QLOdgDAEFBY4OMGkJdWc8xwRNkmrAvetrRtnqeaWmBcBL5Mb1nrg4o+ID1zw/JjzmanDCM+hU8xjw+uf9jISSaVF9XLziLQIkQWXh7BlR7+kz499RzhURbIcVjNpWfhkfrTtqaHgeCaI1uq1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463077; c=relaxed/simple;
	bh=UFPqiLgpEdVZHsORlk2KcjTymHhxXC0iMNM3MMjVYcc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kQIWc5VySdbJYhToENkU/ROTMvdL4dcIs0zf7e6AI/aoZX5yIE08FoidF1HUDnV/sWrTlINsMucdyv4BABuxCwg6U3cgdhApiNaqP5FFkBvUNoDbALKVjg/amTy9zA6hLuZtu5O27hBAUf8N9Dm/r7Wb4CJIFEd6rMiq2NKl6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcPYoKY7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1dcc7bc05so387753785a.0;
        Wed, 31 Jul 2024 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722463074; x=1723067874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFPqiLgpEdVZHsORlk2KcjTymHhxXC0iMNM3MMjVYcc=;
        b=XcPYoKY7nDb+jEK/jIAE4iOi4Bci+TvRRHUj5DuKDobpU72G92PpESBGn4el8Wag+D
         Y7CWRZsbTL0qwZVx9nW3PYUCZCFTViMdWga03k5dOtT2BOpqtoWeEq2UimOJLFmkILfn
         Z1qLyLUnYqKrarw3BtQjS+dVnA2nEe+CEudXj5tJDvnuRVn+vYpoAqus0A/M2OJmB1jX
         zYrDW2w/wJTjC8qlXRskdNYl/2/zngZZPbJWJHCkU/swtDSmSERgu2VvQp4R0uoCmgml
         t4c+NLswTQ6nF1rzUMNMvtvHocboxH/X3AAAGDQ+epzzxom2y7w/A85kJnjEjlLqT/Ly
         VeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463074; x=1723067874;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFPqiLgpEdVZHsORlk2KcjTymHhxXC0iMNM3MMjVYcc=;
        b=UEV/jzP4SXu1jNdHXYXqOHM57s4zIk1A5elcZ3v8VfyoZ28j4h5zVqU7iNCUCPvTrH
         Xe9CPKH4KHI4AfQFko/70zmKgjtmFrKUBlqRBbOkYgcvegBm4dUMB/nUPd7dzw9Ab3/8
         7kHxVPUpIAeSnULBVe/ErkPDuw9vwbSop/Adiw0dMlNEGKxnSudyuj0mJb9EI+aOptb5
         JypL+2CWtkNANU3YcoPopaMPqKqoivy5HUA6tjNnrPaUGWlGiA05sz6N5oNvovFuqB6M
         XcZwe56GEhMEpSizpy03sANhsWgRzL5kf+Ifj2Oiwi1WDnHQyYJIBC8oD86gxV20aQN7
         tsBA==
X-Forwarded-Encrypted: i=1; AJvYcCXEVhUCgMNREXeFhNWZ4qrv/eOy9i2VLw6Jk2p45RM1cNBJ+E/P7cy6jexEfc8g33x7cMNdOBCSWMpj9BmeWpGuyUc7nAtTZOfuxEAZ
X-Gm-Message-State: AOJu0YxNBOqIG4HHQqgtZr5Ya4CWl5DhzCaQeIt/X8vEIgUZk1bUvNqp
	EGMAYe7j8A3zfNFxV6P6mJpLt4AkoHPLNa2bfJ+hfmxAkJICDPIaqecwUg==
X-Google-Smtp-Source: AGHT+IGXDSPJ59qUpPzptJiYy10aOJFniW8NsCMCNU8szD0CcqmNq2z8ygYqBxLLAZoxzO6wfupAOg==
X-Received: by 2002:a05:620a:2952:b0:7a2:c96:855b with SMTP id af79cd13be357-7a30c6bdd25mr69048885a.32.1722463074195;
        Wed, 31 Jul 2024 14:57:54 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7395a9dsm795012485a.1.2024.07.31.14.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:57:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:57:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Randy Li <ayaka@soulik.info>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
In-Reply-To: <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info>
References: <20240731111940.8383-1-ayaka@soulik.info>
 <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

nits:

- INDX->INDEX. It's correct in the code
- prefix networking patches with the target tree: PATCH net-next

Randy Li wrote:
> =

> On 2024/7/31 22:12, Willem de Bruijn wrote:
> > Randy Li wrote:
> >> We need the queue index in qdisc mapping rule. There is no way to
> >> fetch that.
> > In which command exactly?
> =

> That is for sch_multiq, here is an example
> =

> tc qdisc add dev=C2=A0 tun0 root handle 1: multiq
> =

> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst =

> 172.16.10.1 action skbedit queue_mapping 0
> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst =

> 172.16.10.20 action skbedit queue_mapping 1
> =

> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst =

> 172.16.10.10 action skbedit queue_mapping 2

If using an IFF_MULTI_QUEUE tun device, packets are automatically
load balanced across the multiple queues, in tun_select_queue.

If you want more explicit queue selection than by rxhash, tun
supports TUNSETSTEERINGEBPF.

> =

> The purpose here is taking advantage of the multiple threads. For the =

> the server side(gateway of the tunnel's subnet), usually a different =

> peer would invoked a different encryption/decryption key pair, it would=
 =

> be better to handle each in its own thread. Or the application would =

> need to implement a dispatcher here.

A thread in which context? Or do you mean queue?

> =

> I am newbie to the tc(8), I verified the command above with a tun type =

> multiple threads demo. But I don't know how to drop the unwanted ingres=
s =

> filter here, the queue 0 may be a little broken.

Not opposed to exposing the queue index if there is a need. Not sure
yet that there is.

Also, since for an IFF_MULTI_QUEUE the queue_id is just assigned
iteratively, it can also be inferred without an explicit call.=

