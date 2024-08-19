Return-Path: <netdev+bounces-119642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6BE956736
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A436D1F21634
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8615B99F;
	Mon, 19 Aug 2024 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfLa8S3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5D140E50
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060299; cv=none; b=JtIgxWwDSgvbqzm0jmIcGx422+CnnRxhf7oQJEXAmHjFqgQ3ay8s45FB+cU1uX42mmK710Wfdhw2QjrYAXJuPnivJr/deDCRXruVL4Xl/7aXDBEOzB4bQmQLzeRBfE8goGOoAo/bewQCLUcZ6HJdmlPx6SjaV+YViR89wwZPpIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060299; c=relaxed/simple;
	bh=Bg/4HY+5odY9VRIk2S47FLMIjlEfCsXOmDR/JTxpo4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhlF9Cm9vMxuyfX6UtfA/hPDV0ig+XJ1QBirMi8TBBlQ0uZn/+fAs/V339+x0i+YSdt1xxozFcZKtxBmJrKpdzdfI18M1uRoT4jEvKgKZMAJl3V9b7agcPv+IWXWIL4MQ00OfRabfucbtMNDnt5N6OF2oQx8kfLs6ZhNEOCe6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfLa8S3H; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so5257973a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724060296; x=1724665096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg/4HY+5odY9VRIk2S47FLMIjlEfCsXOmDR/JTxpo4Q=;
        b=nfLa8S3Ha/3BtvKT6mCQl+2GoNjfbVLqmTzVlANFcbPfCUghpsfbsOD+QhHmpu+Jjt
         rAln4O+x2HLZOhs3qGMHX3z4/rhF6Fbn5AYVBisiEabzEWHy1DWCXbz9/keYdt9R5sQX
         q+NsVl9MSCEhzIVBgkoH2mqJHDbxNNB1kgqVSavlhUUjaMZ/CZ2N++lKiK0cexp75DHC
         U8y9qrPcprQfv1Gg+0/Rcsm7fyf85hqgLlIs26JASfxy3amUhDPt79/c41RVy+1bcc2K
         dDN7eyXND/mMTVjKzroz/31uLSIPpAAdmOfh9OhHkTqFxpOenYHlX+CVAwrWcjhibgkg
         o4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060296; x=1724665096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg/4HY+5odY9VRIk2S47FLMIjlEfCsXOmDR/JTxpo4Q=;
        b=BmKTV5DMVtytQ2tUDFfVsweWwwcTn3B00qZ+s4FT6K4LWmKfX7qQoAdgrkCIHRBrC2
         UwI847H3v7nZ8WeDiuSK1Oz6sznp7E53AjEIO9D/EUjzJWXl5OgLseN2LaYylejqCkDp
         F/KrE6/d5WrNlpi58WiFvUe+FFFEet89zpqLufH964+WF7w0fQD35Y0lxVJnVZXWlQKL
         EVeS/AjtUiKoh7Au4rBsjy9as6jc+tu51RguTzktzssxwHMtv4ueUG3Q2n2NA+qD+8S/
         gm6WYVkXciIDuBIAd8FycV5my0BK5PAopbg6RKXJ0zhyLa1jndy0G4+Ad3p88iiabDGL
         xKJw==
X-Forwarded-Encrypted: i=1; AJvYcCVuIqLBgUsh43tKzzjAJIkHeJGaAElmzmcF5N/MoJNnbAKRvKDAMRUgmmL9ds9cnxHUK+RmIRNeUwf1aJyoAzLZm7x0DCuH
X-Gm-Message-State: AOJu0YwBnNFK0NdQTaAGw053Cf4VDznTEk8xk+1KrmM2yHugxlqaZVl1
	Rl77Lmi+xIAmXKk7b6uy00qFVoqAoK1taIqQN3RQ49o3EkLyomTIIScA75BkIGsmzitgbtiqJD+
	CJqJbykAxbBmfYZ9a0FCKyph/7/PY30rsMUWO
X-Google-Smtp-Source: AGHT+IE0e9KNG+uwRklXQ8OminhjFtE/459avKyuKo8ECIq7jDQAfkvBqha50kNmIxYFNKo+1PIJsE1VXF9PyqS4yts=
X-Received: by 2002:a17:906:6a1b:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a839252c58cmr742503266b.0.1724060295389; Mon, 19 Aug 2024
 02:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com> <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
 <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com>
 <CANn89iKxrMH2iGFiT7cef2Dq=Y5XOVgj8f582RpdCdfXgRwDiw@mail.gmail.com>
 <CAL+tcoAEGcaEdCjxs9_nM7ux_r8tuYhjsMtJZfemHQ+DLVqUYQ@mail.gmail.com>
 <CANn89iJmEgeRv5w+YwdOGf0bbS6hNRtYWQ860QGu=KMJqVKZAw@mail.gmail.com> <CAL+tcoBVYE0+TeRW8AkmxXAYuJ04Za3XmZXD5T5R=LxqXRWzbw@mail.gmail.com>
In-Reply-To: <CAL+tcoBVYE0+TeRW8AkmxXAYuJ04Za3XmZXD5T5R=LxqXRWzbw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 11:38:02 +0200
Message-ID: <CANn89iJ_bzC1aBb8UYc4OAChvCbsBJmDDvEOm2BucKaeQixFYw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 0x7f454c46@gmail.com, davem@davemloft.net, 
	dima@arista.com, dsahern@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:32=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:

> After investigating such an issue more deeply in the customers'
> machines, the main reason why it can happen is the listener exits
> while another thread starts to connect, which can cause
> self-connection, even though the chance is slim. Later, the listener
> tries to listen and for sure it will fail due to that single
> self-connection.

This would happen if the range of ephemeral ports include the listening por=
t,
which is discouraged.

ip_local_reserved_ports is supposed to help.

This looks like a security issue to me, and netfilter can handle it.

