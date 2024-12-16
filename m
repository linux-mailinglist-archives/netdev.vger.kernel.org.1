Return-Path: <netdev+bounces-152313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084449F362E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA1416254E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD61482E1;
	Mon, 16 Dec 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSwuKINs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671B8289A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366944; cv=none; b=Xq85qJGLOfW+pMFmAsk0XcJUWSGrCcwU3iY/p6C68DJLRQVy9huD0bzk1yPgG1TlRtLI8WbVcV5nSemeOVfKNhe11wrTZcpLmquBTC2sjgnHfipqVVh+U8lgTRJ9QmpkKGRCeSg4hZ5Alwos3EXZcaJn12yXJebc8qivM8WkitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366944; c=relaxed/simple;
	bh=DsYIf/bDyub2VUxgSfRD3kHXThRcUb04YO7t9SYYKdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7mLu3guCFJ+CBUAa3J1vgGvM9tsBIaddTbqyr1/yCUet5RhMm3Jf0jU/oTBMTLEMaSG1YgIzInHgP+hYuzeODsL74Q3e8sA8GRSMkfOaeYiB13nKVjRTk6TwHj0Yi6oNlXxZjBOmum2CRHj9NOLkOBCDd+acr2Jo4IFvJOtWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSwuKINs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso31113975e9.2
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366941; x=1734971741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsYIf/bDyub2VUxgSfRD3kHXThRcUb04YO7t9SYYKdM=;
        b=fSwuKINsoibUEEHQuI0NpCeg3EQfXt3fKpJ0lBRwTV6gtJ/zlHxwsqbrYXhR3B2oZT
         bm0swK8enbdnTJxtVaHIanD5vRvXnOUPc3lc85RKgwe8Ztz0Cct39yJ1mzNiZmNxZXvp
         aWiCW+55lcK5oFNtLhxU/kUD/gNDT87VqOhPNC5IEB/WZscCXb8vj6vlHwlqCPIMc4O7
         Y+JVu1Dgc9HpVQTq2LIn18JzJS6r+b7RiFeBhT08NcNGc1eER6A39wOYlkNHN92KV615
         VeWWPWGHAlFJuzw9P4V6VoGeV9Tr3oX7U3MajD7SjVrnuhVZ3YizFYsIFfYh7yhOrs6q
         QtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366941; x=1734971741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsYIf/bDyub2VUxgSfRD3kHXThRcUb04YO7t9SYYKdM=;
        b=FaFB4oZhEY/MgjdsU2qkwmsms4a5XpulsG4oET3/eOXO9WGoh0v74MGH67tgxflHiz
         PU6vpB6QYsZW5uc6lR9QdEZ1E4gqPYmMDxTS0aLyPKC1Y5UkgSwa60/QHnXSH/fF+djT
         QZVIR+3vm+7mPj55sAjtKnItkWZqoqRbq4dGfYTnEvxB+z/5Ou1jOjAVs1lldz1+Bob5
         1i7ASDHxOGvTaYiRi6aXA0gqsX+rElwt3wCXapf2Cr/vlqySRZ4Gke1/bTKFgwcaELM3
         XpeGkKRqxsAM5Ug5guS8ep47VlZWFF6SM0lI3FCfFPQiSr8soLvEKGO7KjVwSay4hprK
         uYDw==
X-Forwarded-Encrypted: i=1; AJvYcCWO1TrZu1ajv3+OZfuH+zqJlLGH9LtrQP3Ohqfb3x8SCWY5INXFWomTwZpstFQ/lVpi2bnEwQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJkpc7G++rCjdG+Dp7klIykH8H6pZkd5d7btZXJapoBzO/KSq5
	D5uyoYPorNcYKwSzlUjY+yb6KpOsUvT6NHEsy9KEkSK0bP1OcJuw3X9JNXDA3gqbFc9TYyxud5S
	/xy6jrGag59pQN20Ak6F+tVqk73Q9ji9EfLwx
X-Gm-Gg: ASbGncs5AmjcZjLeizIY57aM2/FfFDY+KEobUYwPjGpVAeONaVaxIdToPLvvt0YZ0Bh
	fJGvONgzAQf6iErMdVyFpDfJ122gIXWiDNs0EGN09M3jGaB/xuTGotNE3UKP3oIzqfTciwA==
X-Google-Smtp-Source: AGHT+IHXKsN6VfnlmQsMwPHnZFeQMUVDybAO3zWauXEK8ntUIToeZ1ShQmQJ0gv31yy6V/VvTupNok1iy5IwuuG69y4=
X-Received: by 2002:a5d:59a3:0:b0:385:fb56:fb73 with SMTP id
 ffacd0b85a97d-388da3942c1mr185875f8f.15.1734366941174; Mon, 16 Dec 2024
 08:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212233333.3743239-3-brianvv@google.com> <20241213123643.1898-1-hdanton@sina.com>
In-Reply-To: <20241213123643.1898-1-hdanton@sina.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 16 Dec 2024 11:35:29 -0500
Message-ID: <CAMzD94Tt0ooCjV2y3-5TFxaZ_sy6PJ6W9zVvmDcHi82A3r8rhQ@mail.gmail.com>
Subject: Re: [iwl-next PATCH v3 2/3] idpf: convert workqueues to unbound
To: Hillf Danton <hdanton@sina.com>
Cc: Marco Leogrande <leogrande@google.com>, Eric Dumazet <edumazet@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 7:51=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Thu, 12 Dec 2024 23:33:32 +0000 Brian Vazquez <brianvv@google.com>
> > When a workqueue is created with `WQ_UNBOUND`, its work items are
> > served by special worker-pools, whose host workers are not bound to
> > any specific CPU. In the default configuration (i.e. when
> > `queue_delayed_work` and friends do not specify which CPU to run the
> > work item on), `WQ_UNBOUND` allows the work item to be executed on any
> > CPU in the same node of the CPU it was enqueued on. While this
> > solution potentially sacrifices locality, it avoids contention with
> > other processes that might dominate the CPU time of the processor the
> > work item was scheduled on.
> >
> > This is not just a theoretical problem: in a particular scenario
>
> The cpu hog due to (the user space) misconfig exists regardless it is
> bound workqueue or not, in addition to the fact that linux kernel is
> never the blue pill to kill all pains, so extra support for unbound wq
> is needed.
>

I agree that misconfig could exist even with unbound wq. Still unbound wq
gives the process an opportunity to run if resources are available, if
not, it means
that system is under stress and users should take a deeper look anyway.

> > misconfigured process was hogging most of the time from CPU0, leaving
> > less than 0.5% of its CPU time to the kworker. The IDPF workqueues
> > that were using the kworker on CPU0 suffered large completion delays
> > as a result, causing performance degradation, timeouts and eventual
> > system crash.

