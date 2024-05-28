Return-Path: <netdev+bounces-98683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654ED8D20F2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626181C2092A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040E171679;
	Tue, 28 May 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IY6Ikr3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30E16EBE2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911929; cv=none; b=Mb8OXcKswkfQr+yB5tWau8GiTNrZj3ev3tJNxFNkQkGya+neo27qVWpXP/NVlakkbLz+ZaYVsF6TVoOS67KkrK7wSwz+T7Iue3/mYFKpB40i8ib7i2hwntmhnXiuiyUwEHKi7Tsx+hZXXLf/EP45VyAHGIpODtn6HyRzJROTm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911929; c=relaxed/simple;
	bh=OBTwJbsSEOdNm91GgRdxi4+K+e8IuMfOkMsfCP9KdCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdWDbvnWyyDpEV6S8B0H9dDXKNcfstrJ58HXMGbv3NL69by0ihBPBruKxDZMsudxHplRNkJqMaK6KgZRdx55Q2JUbhi5k488yEM5QG21zJ7FsJyMTn3I2rOS9eRJaEqeANOIfA8b2Nrf4/kUuSP7I9XgL9spkGmoq6l185wno5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IY6Ikr3j; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48b93660593so157792137.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716911927; x=1717516727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBTwJbsSEOdNm91GgRdxi4+K+e8IuMfOkMsfCP9KdCg=;
        b=IY6Ikr3j0LbrB//G7ON8Uoh84n7QzHkT8gv8tZBLSXt94E3UaMajGUndQIyP91vAOw
         tvsEjALIucBQ6sBMs0a6Wn6L6o3Epz7PNxDjrRD9c0rpMeLZI2ArQGA/AdZz9yQ536h/
         cMgY/1XyhF0GdbpIRwgnaGcZmqLrZAOf4nC4f6/J1A5anZU9cvG1HnD3MWerHqZ26S+F
         LtU8p+r8mYQ3q28o+D/0dh+/tPXcoGz0tTEZjZER2iWgVCm0ipbPmP372CG05lHEsY47
         xwQO8vlBL4YBqQzytjmi3AG9ZRld+K7tSk+nBQ9akgWqLXNOf6Qijs1naXbXeBL4P9eG
         D1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911927; x=1717516727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBTwJbsSEOdNm91GgRdxi4+K+e8IuMfOkMsfCP9KdCg=;
        b=p4DYgVscqzIMv/otihoHVnxb82w9vHRG0mxodcPa93JiLnpNeuFAxE+dEt2xlU1TWe
         cMfPvVbWLgllxK4tJ8N4mz14lpLDIPtlC1znqzGYggDX+8esSjX2IwTyz2x/e0tr87kB
         jjXDKxsCMaxy0e+eozUDS84HEWB4ZJ985uKrDzDeOrrIQnflIiSAn8nVeQgFR1tM0Ll0
         fzvtTXGj4zy6GXdVSStdxonu9Xf2MSvGcSyuA2As20e0wZxpxBdf+F3uOxAxAzgaw3hi
         iZkksnT6J6MRwJq/TP4PMXLdKZwjYNu7qGl/F9Yj/sDDAjStD9zT8ZCRoLBJJkVvk7pi
         uEZw==
X-Forwarded-Encrypted: i=1; AJvYcCVIMBd+qhHPBnuthWRa3LIPf6UT4zqIaeyyfP5Z4S+hLRjeBpEyAGNCKUuTeLtXBxDgGfFfpTaLJKTZFPUQsJj3Xdz/UGBw
X-Gm-Message-State: AOJu0Yxy1qLWAb06RvTtN5OXcuzl4KjLApCPNYrYS9cWjDbvA++ner8K
	QExSQffOkvr+0DaVAtuo4cXT9X/6exMced6fSvw9jib9zpvumFqK/q0FdQHNNQ/0oT0laGuzioL
	4OqSdqEPX0P0UeOrRFz6nSfJnLraXPjQbwg9I
X-Google-Smtp-Source: AGHT+IEE3OCFJsRu2l014vknXXsDCDVoYqubG18iSJCPRfpO5qtONRd6t9OnqRKzPQaXtrWANIZCcRLExyzcTKhDA+c=
X-Received: by 2002:a67:f448:0:b0:47e:2e1:c437 with SMTP id
 ada2fe7eead31-48a386b671fmr12823816137.28.1716911927225; Tue, 28 May 2024
 08:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com> <20240528125253.1966136-5-edumazet@google.com>
In-Reply-To: <20240528125253.1966136-5-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 28 May 2024 11:58:31 -0400
Message-ID: <CADVnQymVjXKA3cTyJ-rZuBGDFFChqVF5R-+G5ANT4WazfDRcig@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/4] tcp: fix races in tcp_v[46]_err()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Laight <David.Laight@aculab.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> These functions have races when they:
>
> 1) Write sk->sk_err
> 2) call sk_error_report(sk)
> 3) call tcp_done(sk)
>
> As described in prior patches in this series:
>
> An smp_wmb() is missing.
> We should call tcp_done() before sk_error_report(sk)
> to have consistent tcp_poll() results on SMP hosts.
>
> Use tcp_done_with_error() where we centralized the
> correct sequence.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

