Return-Path: <netdev+bounces-109984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2592A91B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A7B207E3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C714A4D4;
	Mon,  8 Jul 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5qpAuXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7515A8
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464216; cv=none; b=IcL1nWhIQVw5JwtJxCe4ObQ4ER57Cn3uig9U36sD8+iDWAiS0YnCo/CH7pP2DsFnCHPLlvjBXzO0cSStQ9FOLsT9Lk8YiQrp/xA2l/XgIPzgHrohBw0a8iCYfLM1NXG+gzSzDWk/3uGXf6jcFB/OcZji3+AJpiH7shCXKxUYDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464216; c=relaxed/simple;
	bh=u/snc6gt3exl4XGcT1PuUyvESobYXsekd7lIoIY4Z3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2OXtULxO8EuJ6R+UCiZ2aWO98/30SzCCcVR3SIbUihxLijHLPdovsEEEE5/3nQNDrwPj0EncZcCZnSfqU6aotfM6alobWqgrDf6ANKWPE4y2SPGLVV0cy04xgcD6A+MMlLSk2eUsJFaHtzWzzM+/xgYI3rf/15l1u6MCWPBcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5qpAuXs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso2724a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720464213; x=1721069013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwcE62VdpEk89EDqTSQ78XSWrrnWuL7lJzpVurmR5NE=;
        b=v5qpAuXsDQXZu8vBcvKtkYQZSJeByK5vh+VmLjrgS9x7cKs1HmJPK/nu3PZonUIjHC
         5I7h2D3TadrJrh7fydS9hCshT/ZV35fzRk2EruDj+c+DcGK7jYwznBFaoova7beRUtrY
         qoFKZ5rV7mKEmSV+43R4Ul+rbuQKxjLwXaZa0axDMEkLje6zkahJUmCKNP+b9ndicHOC
         7RsBzPGy8Vkd5qu1BMSM6NK9l4U22cnfJFEZ1VBrCSbg0PSBBSXP7VLZIpbPfIkcWYzW
         Nblx9tyk7OmaC5OXj5aJScfyYkjzfycYLyEFZ1WtL6ciZ6OBd3ci1w+4jQ6UEIWH2DjH
         hJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464213; x=1721069013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwcE62VdpEk89EDqTSQ78XSWrrnWuL7lJzpVurmR5NE=;
        b=azIhp7zVRSL6SzFdYJxvEIFqaS1UPjm1fjw1ndCFZ4hcWBj5PLjvzJaOppPb1DUldX
         GrfsNUnY8Un8zTY3KLYLhzGSuiZiLFzAMXnMi4NK7Q4dIR+a+eQSn/JH/Mc6D2a36UBG
         D37gC17zpMSHmAhRIjD60r19aR93L5zlfURwmGhh7edU+OfZwtxLsboJ8N7Rd4eSRL6B
         TqCZnR7lN+2MkFQ97X9yzYS9qa8eub+WO1E3olnyW7wjaPwai8eC0SurxwvH+Z82CUy1
         UMHN7flPlUBFFJMj3tNrIIaH2trkDtYT3XbB8+N81VGG5FCgkCd5AIlxKzJ834ue8ZAP
         jiFw==
X-Forwarded-Encrypted: i=1; AJvYcCVdUPTj9qvDp9VNgMww8idMEb0jnIWBdFlb4IV0/wmCKzSn9Us99wjFpT0n9njIYAMp/3R4DYacFO/JUqux1YwAZmm7L1hg
X-Gm-Message-State: AOJu0YyooYHYtnIBiSGbN2jmKdDC5EZRmY3O+qDcmqSLby2M1MtsY6xz
	CTCrhEkZVGRwNkz1I5suXA3pjdDVWWWP2OWg9P/THN3rYuJue1HF78Z1xO5Rr21KO+CFRWiyqFN
	IoaZJSjCfhd2ByR5MoAOtxIM9JarEywBjMw1B
X-Google-Smtp-Source: AGHT+IGAq/bn3YGfgncUS2t1ewdIHTeWHbvLD5ClcWNUvNb6wlMVqPDzdfZuU/JHOdBipasI90dpQRjnEu/Np46WBqw=
X-Received: by 2002:a50:cddb:0:b0:58b:93:b623 with SMTP id 4fb4d7f45d1cf-594d728058dmr16077a12.5.1720464213251;
 Mon, 08 Jul 2024 11:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708180852.92919-1-kuniyu@amazon.com> <20240708180852.92919-3-kuniyu@amazon.com>
In-Reply-To: <20240708180852.92919-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jul 2024 11:43:22 -0700
Message-ID: <CANn89i+YajBMzFt7CcQ0t3XbrsxY-6KtNHX+VmpYrT=0RU1O2A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] selftests: tcp: Remove broken SNMP
 assumptions for TCP AO self-connect tests.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, Dmitry Safonov <dima@arista.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:10=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> tcp_ao/self-connect.c checked the following SNMP stats before/after
> connect() to confirm that the test exercises the simultaneous connect()
> path.
>
>   * TCPChallengeACK
>   * TCPSYNChallenge
>
> But the stats should not be counted for self-connect in the first place,
> and the assumption is no longer true.
>
> Let's remove the check.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

