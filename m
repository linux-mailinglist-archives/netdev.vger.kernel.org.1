Return-Path: <netdev+bounces-101209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7598FDC02
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D182A1F247FB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DC9CA6F;
	Thu,  6 Jun 2024 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njmb+2zx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE579F6;
	Thu,  6 Jun 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635961; cv=none; b=Ix2CQlnIA3NqIAIqFjuNq++7YBRDSZDS7VHshSKJHBLV7p4sqOAAylvBZ+lDye7cxY0EvZYCEsDj+ik7acE2yKd1JuwZpHOUb9i450weaTfw314Q98SlkfZ6wvC6HuUiL7vjIqMJ6ZL3elFWwWK7WFmqlk6wfWjU77OiKcPP9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635961; c=relaxed/simple;
	bh=KXQcY/KUD/GXgOXdMxL/FSYabj4pqwzKiCsrOHYwN4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5xd86hQ6hAm98qYjJQEqcQd69Jz5BPHnVmq/lJM+PCKtbvpxR5Lw8HoMWVgc+iFAmMmSnePtoQl9RhqJvmDAOk2cAGE1HnmiVN/7/UW2cuiTR5/4k90wogYQ6GvPVMGkP0rz8/2szGsI1aXxj3r6lyfQNjshgU2tOucG9ifAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Njmb+2zx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bfffa3c748so346285a91.3;
        Wed, 05 Jun 2024 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717635960; x=1718240760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcR0/t5uYBIvdEQSeuqs0xUstXN/+KdnI45VENtwQfo=;
        b=Njmb+2zxKrwMC3Bcrz7roRfIAxfQ6NJ32gduXkxiSyQv0gystbGzbI13VgzL1xfBx9
         AYgZj6RmNwRKdEZxnIVHDRYk4CYtpgjv8KksEcDel1swd8f3qua9W6xBu3up4i09FCM+
         DR6TRdLyW4mSVyjSQk7dZSioNyyEtb8DXo+2k+Rbmw/NX4MY127JHddafX35BBkjshj4
         FQ+L6CARbCnJXZwLp9n26YHYKyPTuDVPlTLeHtrXvg8SRQwTrSnsHj/f7LlxcWHqjb0g
         XnAYnrQmMNngkJj1CfYFrfqrj+Jkz5v8Ok0EtNrAqptifItNwyT7Kpc9C4C2fJQFBvH9
         twfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717635960; x=1718240760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcR0/t5uYBIvdEQSeuqs0xUstXN/+KdnI45VENtwQfo=;
        b=BqSOX6EVEgmGINymGGdo0d5W4OIqy621/WrGPv3ORzEUmtd3TCuK03QMxURXm8s5lB
         dHcsy5viQACRBnxljOq52sh9okuXldERFfzMOBifvw0CAPd+iFP8LLvKMHamSrCtUFjg
         mSBhFtIJvc4JLsKZwts18K2UP6fhYi20wCDGDKcU7sbLeTdueXPlwlqMG9vufxxcTh5v
         hMY91XISSIUCR/sNmcJUUlFvn67BjZkOfhsNA2huXlhu+Hs5NiO6/2RfVIqq/xsAttzh
         fPqD92C0MUvciwo6mSg18YaIKjl7pbAGpsKDMfUHOF4tVLlh28Cyi+6L1GX0/bMObWtl
         lWPg==
X-Forwarded-Encrypted: i=1; AJvYcCXumDXG7I2DUZ2eI6GFNC/OXDNeaXm7f3fHc6KpaImiDcxXVa/hyvIWAcojnzfDZVl2DjQzDY9CgqmVcBF2tz7oHYGdvj5+OG8GNmNWvTXKAJR6wU3LX9uNFG0Y2gRRVa3QKSzd/gzP89mH4EOV2oSJa+5xCNR+EDGQCvR8vVbYW6QKvQG74xjcTyPFyR/YWnbO258xZK8Qn2FxulpskXAbjwzz
X-Gm-Message-State: AOJu0YxXnrnLPzgZfseUYLWrj0PRpXVsgYvH5ADT4X3ntNkT+g8Lb32R
	kADP0K8sBvb39DqjHc9Wd2vBupwWFFBJACpWBEmFW3niRS3fR4870bARDQHvIFefME/5kF0cvzb
	TizQPvAoYuaUi7EHQzhwsFdkaZT8=
X-Google-Smtp-Source: AGHT+IGf/3ayjCPjRYJx47eHZM1uSmdwR03aG7nsKOkBUKFJf8afN6SS2wYJKWrtuZX+8vnrrV71fpGSU3kWnFC1NDE=
X-Received: by 2002:a17:90a:bf0e:b0:2c2:4107:3a7b with SMTP id
 98e67ed59e1d1-2c27db68490mr4294176a91.46.1717635959629; Wed, 05 Jun 2024
 18:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
 <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com> <CANn89iLHGimJWRNcM8c=Ymec-+A3UG9rGy9Va_n7+eZ2WGHDiw@mail.gmail.com>
 <CAJwJo6YVtBaCn+iUEvC7OWa7k9LtC9yReHM=RmuiDUACFympRw@mail.gmail.com> <CANn89i+em+sjuQE32bM2KWg=EFcf-jnfvzD=YekMviUSjARrnQ@mail.gmail.com>
In-Reply-To: <CANn89i+em+sjuQE32bM2KWg=EFcf-jnfvzD=YekMviUSjARrnQ@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 6 Jun 2024 02:05:47 +0100
Message-ID: <CAJwJo6YWf40BuWCc7rxBAAbzngFMuXeMXsj_Mmxe3W0rjNWDAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Jun 2024 at 18:37, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Jun 5, 2024 at 7:35=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.c=
om> wrote:
> >
> > Hi Eric,
> >
> > Thanks for the review,
> >
> > On Wed, 5 Jun 2024 at 09:07, Eric Dumazet <edumazet@google.com> wrote:
[..]
> > > Then we probably do not need EXPORT_SYMBOL(tcp_inbound_md5_hash); any=
more ?
> >
> > Certainly, my bad. I will remove that in v3.
> >
>
> No problem, also make it static, in case this was not clear from my comme=
nt.

Thanks!

--=20
             Dmitry

