Return-Path: <netdev+bounces-70012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5484D56A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735821F2B558
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2A12BF16;
	Wed,  7 Feb 2024 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJEVQMXi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA912BF26
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341576; cv=none; b=OOOv/tzMRppoaaS0SrBLaPDQ+SMHuOqObOgRzUi4DLije6Oy42LJW/L4gRzvt5iUsbRUe3z35kXU+8+Ch4ZLr6IoOfJuJMVZURFhEcuUVu5Tz4uL2Dnd+pB3kpB1JiL4CSYVTOnaR8FJydZ6QVH6V+CyLm+CK5ckJb9aZ+q2Hz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341576; c=relaxed/simple;
	bh=z04eXL5xwAPRH+5XFuVAmCNX8jo6Ag8cUU3Q/5t3NQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIVrGJWPMJtmbhBP5KWBLrSBRUFKrtbbvwbfJbVq+7ytCA7SGfVt+CbcZFA1AI4tx58Qqvrv4DuUKB7UuOLquPLZZMM3IF//qdfzqq9d6I0LRQMQx9y1BC+0d/k/OO9WQZ4iOAVeSaBWG3BOzDUIh2ZD/A3qOJz2wO5EHIID8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJEVQMXi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so3614a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707341573; x=1707946373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z04eXL5xwAPRH+5XFuVAmCNX8jo6Ag8cUU3Q/5t3NQA=;
        b=SJEVQMXi4tuSeMlVlmAam5iz2LnUNvcx++/1YXjkwK05AIaioHcEm0Ry/KcImSnD5n
         5d6n2TMietM0LQXCxSq/3hZvHfZMAPICmvXMxRPGpKOcQNKkYRSWSNBxomuUnELq7sa6
         7XCOaCCnzRvsmJL+e8HjJP6/9hLylofLoAK/99MoJJBR0T7aknsOGChseBxK425TmaHz
         h5yTfluK1Ktt6qin2v5QoKKf2l/VH/n1SjQpixKwv1GMUMfs+eDJPMyqc85DyBgwACub
         DcZ6V9Hf1CMj3zLR2LbiG2ndQCXAvTJUSsXwBSvyC7VrsPImncqga+x1T23fQwGJq7rh
         hUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341573; x=1707946373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z04eXL5xwAPRH+5XFuVAmCNX8jo6Ag8cUU3Q/5t3NQA=;
        b=icFz3sjXaDYjU3LQoMEpKV/bx3OePiUfj3OjoceMuOZ7Ib6odbQPSBml0KTSgRMXwq
         pTL73wry+DfOjQz8IRW4nDR4dKNXdBh8g4L38BUK/WNeJ4jMjTTwVomjHrHP4YIssLxc
         o6mrxvlhzu+MKLaPFkeX6IV48WJXOjIE3/NatiR/N/nYzaTFEFbLIQH6ROVOXzCjam3I
         3HXJg59O6qGCWhTzbS4E176McITaOeWAmMARJvh3id7VLIT8esoc3AxzWIc420/lLPO8
         mVtgACUEca70EDmkjzuUtlqD6A2wdFr9NXRhOUELl1omT/guI4S3r2MfNOirgEg6dF0Y
         AdsQ==
X-Gm-Message-State: AOJu0YxntBGSuu7NnZM+PKhRar+mhJTdN4uM/eyyMHFV6snBJaBX8uIk
	QEoNG2y4Ig1Sky6xSOTlF1dRZVm4Te9B0R9AHCuZGLrqIwn6IuSI4rKfOXTe1198FPnfCZ8Uc0t
	OLQ8140RYfh+n13bVZaMSgzAGRY2m1Qra85gX
X-Google-Smtp-Source: AGHT+IGlf6LuQpEee7hgF/r6NP7FvLeYjKxS23x5IwtZx/ZQ9D5vsxSUqjONKeHG+JvvnRPQQ5Wn9UfkNcUqWtnOOww=
X-Received: by 2002:a50:d64e:0:b0:560:f37e:2d5d with SMTP id
 c14-20020a50d64e000000b00560f37e2d5dmr104589edj.5.1707341572784; Wed, 07 Feb
 2024 13:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207205335.1465818-1-victor@mojatatu.com>
In-Reply-To: <20240207205335.1465818-1-victor@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Feb 2024 22:32:38 +0100
Message-ID: <CANn89iKk-mG3-QPUNymbcBJZxLH02Nqz0u+ZOtgRoDOPTXd7Fw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_mirred: Don't zero blockid when netns
 is going down
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com, pctammela@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:54=E2=80=AFPM Victor Nogueira <victor@mojatatu.com=
> wrote:
>
> While testing tdc with parallel tests for mirred to block we caught an
> intermittent bug. The blockid was being zeroed out when a parallel net
> namespace was going down and, thus, giving us an incorrect blockid value(=
0)
> whenever we tried to dump the mirred action. Since we don't increment the
> block refcount in the control path (and only use the ID), we don't need t=
o
> zero the blockid field whenever the net namespace is going down.
>

You mention netns being removed, but the issue is more about unregistering
a net device ?

Ie the following would also trigger the bug ?

ip link add dev dummy type dummy
ip link del dummy

