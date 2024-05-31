Return-Path: <netdev+bounces-99651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B98D5A91
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45B21C21643
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C8A7FBC8;
	Fri, 31 May 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbe+Wzx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883947FBAE
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137419; cv=none; b=pOTlK7J2pxpB0HBktO+QOPGtvMN/CVk26vCCfxLZEirlOXRoTZM6W99RFMJM17xfAJJQf1AoJvhXXBgBK/inHNQjQRVjwQODucuEQbMPSU+XrxQObyUReP5IPcIC7hp4j8xLygNb+3T2b+IUTRfhii6a04rm3XFYVVw500r1qjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137419; c=relaxed/simple;
	bh=CGpTk4lbXH8qLs2ecxKmg9BxLyqP5LmNkGHvwWalhmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcnBrXVNRW+gP7LtlsiicrhurGuAUCMdKWVK+MyeffDhuP5ecEVsf8YKNguG3GUO7v3xqFsppiYiIZCUjdCosj6OMbRQeWhLs5dNGBzEja46/STxpeQNT9euikrN6btLqcytG+9MRzTgqBcK8tJs1/Pdw/Ijfqz4Um3JxKpxriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbe+Wzx2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a635a74e0deso181949466b.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717137416; x=1717742216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6r2uf5/4nHBYjMlsc8P9luDNgjde4ePUQQK33xJhjw=;
        b=Gbe+Wzx2l1HQhTElKWcIfqJgVqDB6oG7x7ya3tAYEB+bjHhhUXBKNRP+uv6FDTzXJ6
         frHLQejmWir00IXf0Vs4JOGhAi3eCId446NpPtnqmjFnB8VJ1HEzSkMMKZkpJuyFdHEd
         Ay7YKTzlVinZIsWLx6ZgXKZxLRe4YWfmqGhwW4NgOIbMUCRbSM0K8yvExuQeabn4jI51
         /crrUVGLYFrwg6UhWoCAdwo5mYpzCwVl1L7VswCcHHYnoZ8LaXJO+iu2BQI5whZSijQA
         ooP9kvLRxXH8uali2PFbdwm9OvZyrRdzDdcGZqEylCa5bZVUeviU01MV8B0eOa+Jf2BN
         DQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717137416; x=1717742216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6r2uf5/4nHBYjMlsc8P9luDNgjde4ePUQQK33xJhjw=;
        b=WLGTdg2v5Pz3OQ8B0c6vCh2m71hNUVAwUkCXvIvwxkxLE3SnBtNlahFv+Wvi38oBVF
         NhXnddel2S7SJhbq2Wd5uAAfxCwed1OqIrQq0wrNWXbQBsB4sUqP2JbRquN2wa+U4MwM
         MQrPHd5Giy4UWBfPwZD29xIpQZbYeQAf+si6KTrCEPQ+TgHssM5BKug8SuqnM71w5QtH
         pBCtuQlE7FaoMGbwbaDgsvo6jXu/q2TO/ZuQjH7bx+6es2+ZBhcgaQ7Kzm4WllerJjjn
         gl0gwOHb/SQOQk9ZbFQH72K7jXE1um9deOGooW6U7Uw0N+yVKS151c5Hn3yiryHxZnMn
         JzBw==
X-Forwarded-Encrypted: i=1; AJvYcCWETsMmRvcOANZVKcVKA30xRC1iuhK7vP6mz8QAIvb2nVgEUrbNU+e6MmK2kBCq8wdnhwRESvoOdivNh7Du2OCWjAZSPVWP
X-Gm-Message-State: AOJu0YyTxESQMrZ3d/sa6LKbCTGwFawX97ikhNn9aJNz+XD19r2tR6M4
	9C9N/g23dpvvKM65NxrFwecIb1mjpuhbJtrpe5IiYsiJXk+U339BhfnMAE12ybL4OlYPFuBCLaX
	sJKZwErFBT3izUfInyPZi73gNYZI=
X-Google-Smtp-Source: AGHT+IF3TqofeKKDWS2kZfv9Xp+UxYFNQUxCNGYM0ylUoRTAMWf1KKuY6tNdQqDvUZbbK+LrIbYs0QeJgYFqWPL+ubo=
X-Received: by 2002:a17:907:c92a:b0:a66:197f:a47 with SMTP id
 a640c23a62f3a-a681c8d9e9amr57031066b.0.1717137415381; Thu, 30 May 2024
 23:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530131308.59737-1-kerneljasonxing@gmail.com>
 <20240530131308.59737-3-kerneljasonxing@gmail.com> <CANn89iJZo2R3eOVvWpo3-5aoMaaEtzxH90H0iv0FQXPUz7aJyg@mail.gmail.com>
In-Reply-To: <CANn89iJZo2R3eOVvWpo3-5aoMaaEtzxH90H0iv0FQXPUz7aJyg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 31 May 2024 14:36:16 +0800
Message-ID: <CAL+tcoBHT+BegR2jyohdg8ENP4xN5vYF+0YbWUQV_3ioyKT2uQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, May 30, 2024 at 3:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like previous patch does in TCP, we need to adhere to RFC 1213:
> >
> >   "tcpCurrEstab OBJECT-TYPE
> >    ...
> >    The number of TCP connections for which the current state
> >    is either ESTABLISHED or CLOSE- WAIT."
> >
> > So let's consider CLOSE-WAIT sockets.
> >
> > The logic of counting
> > When we increment the counter?
> > a) Only if we change the state to ESTABLISHED.
> >
> > When we decrement the counter?
> > a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> > say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> > b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> > from CLOSE-WAIT to LAST-ACK.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> MPTCP was not part of linux at that time.

Oh, right, thank you.

It should be:
Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")

I'll fix it soon.

Thanks,
Jason

