Return-Path: <netdev+bounces-122414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C59612B2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346931C22B7C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391911CCB34;
	Tue, 27 Aug 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5gIb0II"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BA1C6F65
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772723; cv=none; b=o+ZrKrNPkSu+NUBo4cc8iNnKKU5Y0cOmFEkBxaVwqzDw5IyxYnDjo0whBt9rQWvtuvZO4LVRPB9eSzDirlaacZKnqo2g2Ejwum/Z4xtErSUm7LXC94vtyQ5xF5kR7SbzMgSSo9xBNk8eHW2chxSjLEmMpqEQ/PvLyzx1faTS47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772723; c=relaxed/simple;
	bh=6UMS3q4R3eGwhJED70ox5v0Ygxw/IpLaSAGGrDOqqcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUvBe2fnhrnyuup1ogP2mc9hWf29omqv3CAQvLXkmJ6vKTQzVSTrUZgHDC9Tc7Q6/LEPA9k04dr4UFyz9wmAPKyXokZDlVfcYeMZSbZCuvMmDVm8Jhk5djjR58rEOSpmurxLF9Gn8zvJGT0djYU0ngCHxPXjd3iomed4IdkyGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5gIb0II; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-829e8718502so77217539f.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772721; x=1725377521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shw+jTJ4FXObwLcEEgFNljwWS+oBsCIqP6U/OxlEqPI=;
        b=C5gIb0IIkgRbzeYfTl7fZREON+SDoQIWCbc3tLvY9c6gfpu5WbO8LuyQOpngYL3th5
         aoB2WliBwwMufxEq2u10Tr6JgNMx+402pR5OWrOSii+t9fdpGAhkzQF17KuH7QWC79e7
         8lzGXJJ/5UulDBAHgqECpaC1OoLybsbt9QgWGrMoM2845XmWm42x7LrGg3tRJTjTcU1j
         I0iDKp8BMLeyR/Py2+XTgBy5v6qBx12KDnNkq68A4obgkxcrUULIYYSjp5AK9u6naITL
         GvpNW1qkYyonb6bz5nHwhpj0ajZRYw99DOdTifIszEkpOstPsT62z7tUYX6zAbXJsAi4
         ur0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772721; x=1725377521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shw+jTJ4FXObwLcEEgFNljwWS+oBsCIqP6U/OxlEqPI=;
        b=NMjiYHIKnxh9DvALpUfeP4eprMr5HG2RHpEyk1BkNNvqn1zTfx1tuE9J1j8cNYFugI
         icc04Yek4uOL+M00ZjdqJ2BNCxW2ERvWtDk3FQqiiqb5bJcDOyLeqtWUJEqrB4QlOhjR
         N8Rlci7vq+nljrOEt2n+YoFjIRkPqim1LlVieiP3mKjIYV+0990D3HeZEYA+ngYLz4ai
         kYfwN+vX+l+y6BUlCj3CIwrAreX5yXIJZTnYPtcm4xANqajc9bZ5Lspn9dgFo8ClKX1U
         6rwNZkIsEGIq5oVv5ii6P/F7ybzlvfmUewjuYjXQA3ddbyy0utiJcRvLQTBe1pnt/fEq
         6xBg==
X-Forwarded-Encrypted: i=1; AJvYcCUmTWj8crYIWc7LXU7y1/rj6Bu54O1fVkkaByUb+Yf/BJkQ3eXI4dpFEJ7kHXqBZAZHrLnhum4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxspM2OJmDc4xvsbsfeyT0qbBz2br7H6TnZcdjHzZpqSdTxaJFe
	zKZZSQF6ym+rtjgb8pTpynBLnO+Mr4JxyzUtj7JDlMKYVcFL0QMPLbz1mFQW0kwGw4JHo9CxWo0
	BZTlhT2L5gSBQED4s7KgxSIrJIkA=
X-Google-Smtp-Source: AGHT+IFHw2PyqmK+W3fBOFSen2JTFvfZfKUwb72QubA9ghVKoiw0h2OSo8pi7A7R5VnOBo1SEAZqSh/vpBhrvwUxe5M=
X-Received: by 2002:a92:ca0c:0:b0:39d:376b:20b9 with SMTP id
 e9e14a558f8ab-39e3c9c0b0dmr177195645ab.20.1724772720872; Tue, 27 Aug 2024
 08:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com> <20240827074620.03f4d92a@kernel.org>
In-Reply-To: <20240827074620.03f4d92a@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Aug 2024 23:31:22 +0800
Message-ID: <CAL+tcoDfWdrDD5zTwyV_et3X1pgWhrmSpYra9_onM-MVDnFKJA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

On Tue, Aug 27, 2024 at 10:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 25 Aug 2024 23:24:39 +0800 Jason Xing wrote:
> > However, there is one particular case that fails the selftests with
> > "./rxtimestamp: Expected swtstamp to not be set." error printing in
> > testcase 6.
>
> In case you ever find yourself looking for ways to improve our tests
> may I suggest trying to speed up fcnal_test.sh?  That'd be a very
> productive use of time.

Actually, I'm very into this timestamping feature which can be
extended in some aspects for debug&trace in production.

Since you mentioned that we can do more about that test, I think I
will take a deep look at it during the weekend :)

Thanks for letting me know :p

