Return-Path: <netdev+bounces-120151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6948C958732
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258932819AA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8618FC89;
	Tue, 20 Aug 2024 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bmp2kHn5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F418EFF1
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157591; cv=none; b=KWuDemrbI4MjwfdULJ8v6/kEvT5paOU+g8hbD2soBw1f/ay7yi+dVvBaAyUHJ83ktig0GoUS9JltJokGNnGGhWS+Z4C2uZg7uD8qViRih6h6IsV49u7Q7lwHZHZuE2sO+0BiffS5lv7c4MEufPQfcci09YjHvNdVHUVpKtghfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157591; c=relaxed/simple;
	bh=E9PqZuDAngt9XXheVDDrRUni+KBJcelvYst/lgDlNQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwdF61VDfo1XoxoKzIyDIVZnxf7ZKK7KKso1tgh6xB9BEkv33WypKhbu+er03eRmnuzizGEsE8efrRhOxuVSVXuCkB2aAz2ZOtVE1vwiAugZcp9sgv/oaDReAIj13UUu4tJcy6iLyjg63Wc8BSs4tXyGkKSCnnpkN1mmOeIzbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bmp2kHn5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so711252466b.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724157588; x=1724762388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9PqZuDAngt9XXheVDDrRUni+KBJcelvYst/lgDlNQs=;
        b=Bmp2kHn5RLV6bj7aDp+ZdmtFCaj8hxW4tTrVS8zDbAJWxdIPeKKH6++m9WYNkyUufx
         WnvzNpG9umAU6si9yGU376U0HqMqxCqo2C9dwo+T2DVv2YDfVi9jWjGG46Pqg7GSE+hb
         /dMnnVoUxrZzERwnBlS46Jh92V3aXGpI+C/2DKf6PdDPTDZA3P/N+F+7v/6495lzeAaa
         7lMNcSX1Gvrv6uCAhiixCxza1MnfSNx7Ayvpb8JU+Cuu/CTM94TbWZsOLIifeC66WMQo
         dm3ZEL1ffY3CbkKl4rPC0V1Flb9hFatXlrx6epj/dyNbwupqNk/2+gU5IeJaw1XLATV5
         ZdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724157588; x=1724762388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9PqZuDAngt9XXheVDDrRUni+KBJcelvYst/lgDlNQs=;
        b=lu0vIq39Jv2NpD4SQP+KltGLeqNUo+QkKV5EiQNv7iD854rzAgYd4Ow74yoOFP4CrI
         /46NcXDmRUj4e37OIqrG5Cr02Lhre1cwYSTJpFOtWe/RB7UEhxPnh9+3RWHjC7uFHq1Q
         3wJfYoP94H32inhSkAErCsWZWbjhbsXG/ipAVT4j/hmMJ0t0LkOuNzi97h2dtmWepaVk
         m9af7NeGNEg8U88nuvF+47Vz7CGw/n26osdtfQBvXAVjyHV4LE/b7aZpbXxyqvXEUI9z
         MYnckziGO8omSgxwhQ3qQSCSnrCJ65c42scrFX4bK2ihHAUI8veEk86dywl1R2PwQHKs
         KOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRPvkYjW6fUN1sb/e4RWAQ2zP7S8udf1htxvQTAueI97nl9msdqMiCpuyo5B7yV3ie6D7DVXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0NQVv2NLPw6aet4mjYGL7U1kvRTXoXY+SfIsQohAZW7qBUBa
	0H4QsjDSPmoHwdHRKn6Xo2d9q37Yzn+iI6K1mVWSalkObiMB/OjbG68b0Nh2VP6xzBXI/Wt40wT
	47nystzzWZCvhQ2XBzlbkfNOqtBv621of75IG
X-Google-Smtp-Source: AGHT+IGC3gdYXZRdIaKDUJDPgtpx2+FDxCtLkDVQhnvVQMXL6xeoppuGwS+06uqGfqZOdK0V7Q/b2Ff+7vthzrXsWvo=
X-Received: by 2002:a17:907:c8a5:b0:a7a:b43e:86e4 with SMTP id
 a640c23a62f3a-a8392930be7mr1047077966b.27.1724157587356; Tue, 20 Aug 2024
 05:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815113745.6668-1-kerneljasonxing@gmail.com> <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com>
In-Reply-To: <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 14:39:34 +0200
Message-ID: <CANn89iLn4=TnBE-0LNvT+ucXDQoUd=Ph+nEoLQOSz0pbdu3upw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/15/24 13:37, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We found that one close-wait socket was reset by the other side
> > which is beyond our expectation,
>
> I'm unsure if you should instead reconsider your expectation: what if
> the client application does:
>
> shutdown(fd, SHUT_WR)
> close(fd); // with unread data
>

Also, I was hoping someone would mention IPv6 at some point.

Jason, instead of a lengthy ChatGPT-style changelog, I would prefer a
packetdrill test exactly showing the issue.

