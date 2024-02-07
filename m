Return-Path: <netdev+bounces-69823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AA784CBB7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32E02811AD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C676C8F;
	Wed,  7 Feb 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9D0iOnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2A1E48C
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313049; cv=none; b=UHjUhhnuW8Bfc76e82m4O9XzBywZQMyf2RvJ7x7N50wOT25Ci7HY0davPe8qnIbyu6nZ90PCGkfxXU9mN7QNMhD4PRsTMAoqx1BIv8efRlJx2F1MJd8Mv0KFSvP/uQbLuCew/hmN7J4j62gE5hNPFKnVE4/D0E4K+qzjUNjzyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313049; c=relaxed/simple;
	bh=HWjXnX/mPLyLIC6uPQmy1/OoCdd7pHOBiaB0OYo68CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ln52PQbF2PHIUw84RiFBDrvf9ssha8XZ8wNfxycjxRI7em2ZHd1zfrCNGolMaVIWS+QVXa6o2mHP5I08aZK87tQOr6aRfCt+pUTuzxa+hXTQD0XLMRyzSKWOjETYXJlt9dp7R3oNwEDs1UltU7kygFESvfkQrWO2t09LLLRiDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9D0iOnP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so6793a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 05:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707313046; x=1707917846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWjXnX/mPLyLIC6uPQmy1/OoCdd7pHOBiaB0OYo68CU=;
        b=B9D0iOnPtvuTsE5zjGbPQpZpxgecFkhLkhgin52dgaRFDk2MqB97lWXJEShTVlRiDi
         1+uKIyNDTttTJ1seLCrsp4KhrpEsTgnJpLsEinFfdJUOvX27nukyMdSPQBLuGz4ez4on
         g87MnEYJOmNUyv/8NP8Bb5gmVx1ze/PPHYyadNpS7Lv6qeanVZ295OXa9AiHbE+jgMkW
         kNa1s0nWCvDM+mJysxx0wizU4zb0psTZo1iDiGRXw674L0aA91Ze72Ar3pAtqly7t+Dt
         D6XOhO0fL1Pa1hHNkF7JeBF4JxZiFoSoUYLCan/FmRMIQQoHqNxbs0DFF9cdcx9+c3ud
         HGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707313046; x=1707917846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWjXnX/mPLyLIC6uPQmy1/OoCdd7pHOBiaB0OYo68CU=;
        b=D66Ke2PXgibpo/I5jbkEV0WfG8wWQqNaEAJIwiumNYmKYgyx/7/H4gNH3r64LZY768
         HPmtPoK+de0jH6M+jsNN7cPfIzygIAIQHEHvtlZT5fDDxY6mw7/opf59KKuVgzaUXw7F
         lihQlLobSjzHfXxgXGtUWrUN/HEzvh3fD7J2VhJrgkrsvWkD1lBcLUQlakl/X90OuZ0E
         7PyApFHmWfA0meggccyvuQSZaHGEme1zoQ2blkNEKvsBVaj6xRPqAr69luBYwCwyBkWz
         2FXODCAMTPYNhtECl2h5s6yKCZs6cuWQMbzishbeN6wH0Jy9QHFDIouW147tlV72am2r
         BZ4Q==
X-Gm-Message-State: AOJu0YxxMWuCDTdkBkV3XGSf01SZ11tqCrZ5OM2aUZM1pLDbjUJrKtNF
	zI1sAoiwNNuAChqLc39Kz5qaE8q+JuCfqYZ3NB8mh+2iiJYb7KrCkjvKJ6Z0+qcV24TRI3ypnsK
	3n0kMWOwq9HvXUpkvUUhymrFcjzzLleZcA/S+
X-Google-Smtp-Source: AGHT+IHiEmkRU9MA5G9TSrnUQ0HgUQTSNN6gIcM4aXd+rOHrOqq20fdwO0QpX220VUxEL3T/RXpq+UYt0tbf2Wi+X3M=
X-Received: by 2002:a50:bb29:0:b0:560:4895:6f38 with SMTP id
 y38-20020a50bb29000000b0056048956f38mr98636ede.1.1707313045625; Wed, 07 Feb
 2024 05:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204104601.55760-1-kerneljasonxing@gmail.com>
 <CAL+tcoCZG=SCPZDd3ErxFCW6K8A_RHaYR6vJTQJB_BOkhsg-JQ@mail.gmail.com>
 <CANn89iKRCxmMH5f_NxDCXHNzRvk+oKT7t9m3r_=hOwP5rSkwTQ@mail.gmail.com> <CAL+tcoDtiQJFuoeCUv3KMy5q8wU2jYoGRuaNJQrk5WdwHFnXNQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDtiQJFuoeCUv3KMy5q8wU2jYoGRuaNJQrk5WdwHFnXNQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Feb 2024 14:37:14 +0100
Message-ID: <CANn89iKgX=Ci93U1xpRm3P_3kjPsV_AnL_we6FM6mo8B+kTw9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add more drop reasons in tcp receive path
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>

> Indeed.
>
> It took me some while to consider whether I should add more reasons
> into the fast path.
>
> But for now the NOT_SPECIFIED fake reason does not work if we really
> want to know some useful hints.
> What do you think? Should I give up this patch series or come up with
> other better ideas?

Perhaps find a way to reuse return values from functions to carry a drop_re=
ason.

>
> >
> > Please make sure not to slow down the TCP fast path, while we work
> > hard in the opposite direction.
>
> I tested some times by using netperf, it's not that easy to observe
> the obvious differences before/after this patch applied.

Sure, the difference is only noticeable on moderate load, when a cpu
receives one packet in a while.

icache pressure, something hard to measure with synthetic benchmarks,
but visible in real workloads in the long term.

At Google, we definitely see an increase of network cpu costs releases
after releases.

