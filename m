Return-Path: <netdev+bounces-224147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D8B813E2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4883627AFB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB12FE048;
	Wed, 17 Sep 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3/dUE42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1F2F6593
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131606; cv=none; b=Mmnc1Vz9vw6Wb2Bde1uJTigngAytnbz6kFl2NYOhm3GDP0ykdpt1qNjPdeqK7IAgKcHbOkYSV7az5XgHlneiwr0chafMoL3j5vmQbujpsvcAu0iGl8Mp3ysvOCLxe3/+/wDN6pqtaDSJnb3Csj3NWDjAiZJcCJYYcH3xJ9lr/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131606; c=relaxed/simple;
	bh=prPeBKaa51G6J+deMhX0xW4lFPImemmeU0KVGD66rv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EodKjr4K3lTmpvtDc34FQLTRJejoCksEF60shxqdV3O0hRyQjqRtH/7qFhqxD2DV/oS/xXnWS7np+ii7Pp9LRuLqkXJMObjDVl4RDadv57fYOfRk3rVaYNraAlg98TncezanOpR+JRfol2BormjxHSBEDu+kdyhdVk9IJDaAAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3/dUE42; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso38668a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758131604; x=1758736404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prPeBKaa51G6J+deMhX0xW4lFPImemmeU0KVGD66rv8=;
        b=Q3/dUE42GYgbO0eACTfvr/1XjNFBSovzF2SpKViVFipTHebigQdT7RuyxmSOw2OMW1
         gDiF3nuEiJHWBbihwysFwO+pRE7EJdZW3wGERQZ3UJx8I2uinxmR6ErUr8HOKwVlTCCl
         HKFPiRM5Rl5Uc+XSB6dEv1hj7Z3scX/It9c1ztusrIR746zFQmFRw6oCND5B+8zgbSkm
         NJvmCWfNi6YnL4GLBWc4SWwt6aDuc5RwM7Evy7c29QAr+jQAsDR5zRegBGQDTQaJH4IK
         LP4tcgkSWIa/f3ikmKZeSedNY97wMTQrM2N8hRR0IFxKbnsIwIAu/pBOb5U2HmHk8eJM
         q4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131604; x=1758736404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prPeBKaa51G6J+deMhX0xW4lFPImemmeU0KVGD66rv8=;
        b=mak/gL+tY9TvLXuy/o+d8LC7HUVw3KZdJMYNXYWVJObnshE9wHz4NuQb9VGK+OWx7R
         +h7qk2d8kqkw3mSfJuq+9w8Bfw0+J460/3ktTswYT0twweGL5x36q7zd/2WMnML9fJ3f
         DeGev4Q0P2btwxdznp9usZ5QoH1BsSHfVpUmeN1OB+MeMToi1t4ZtryhtsHNXZKD6iL0
         LCiTrtd9U+X0OORBJ21zEZJ/k/NF+RUANsZM9rXGrn5AV1HO2fEar0neymIzAYrqo90E
         Y3QFESQwEgYEFtIPn1iojBwfNqXufrI9kPiq7OQ5OFeyD3b4UmSgZEQ5zOOr3oCVoIOG
         kLNg==
X-Forwarded-Encrypted: i=1; AJvYcCUwIEMjQioI+u7gC8twCuwGgrpn2pqFVX9y+yA4oNi0jhcyBhLjAlu8ec3uJ/ASm3WnZr/4TeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOK7pmdDYMy5ldKg6TzoMqIK/uyqr/V9/koTEP/743SAXBnCOC
	XVDF8SzF2WtGxcvt7U5b7R/9uCZ075TBQreBwrKxyXcAsOnquZ2aN50RXCBVeAN2rqA9lORkChn
	wLK+ZpXqQe0LHL7Se8LAQ1imE5ihK7fcHwGebYSAV
X-Gm-Gg: ASbGncvwkvduLulP5p0P1E+tIHJ/GDy1QKwYu8qiju8z3cxHUsIcGMgoTPGTO6KFMML
	XoF+0IHsJSE0f7BEfjV0yccuX2WLtLaVu+DuGT/RW2ovVUA4JybyiVr4y+Hg/G1qf0tebzEVw7U
	e40pV4t7lLDQSOPJaRyKN/iHt3xvqcVSDeOWvluthy8Gpu+Rw1hvtqfdruKvY2kuvJOIMMrg5SD
	0bZ0Olr7RJDNP8M4qCAInG7KpEdv2l5PmfyvW64xLqU9VcyOIqLa9q1C0+LCcln8Q==
X-Google-Smtp-Source: AGHT+IHrJyd++NKInVDvIQJcyYRssVLier9sPAlip2/M1DiUex+LiAM1Mht5QSgk3G61jDHUUIML93p9VzFcFZYKZKY=
X-Received: by 2002:a17:903:1b46:b0:245:f7f3:6760 with SMTP id
 d9443c01a7336-26813efae44mr34443275ad.55.1758131603620; Wed, 17 Sep 2025
 10:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-6-edumazet@google.com>
 <willemdebruijn.kernel.20220031a140a@gmail.com> <CANn89iKPip5QppUDo_NT-KrZ4Lg+maqJ6_zz0-NpVwbuR8yomw@mail.gmail.com>
In-Reply-To: <CANn89iKPip5QppUDo_NT-KrZ4Lg+maqJ6_zz0-NpVwbuR8yomw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 10:53:11 -0700
X-Gm-Features: AS18NWBxSYHsRh9Op5FdNeSeuENMMATNG6Aeri7ZABL3gBgHQSVkqAQ0FI3AoGM
Message-ID: <CAAVpQUCumbFexO9TBhed0G0wGToLc4crVMSh8OxqwLep6kSzuA@mail.gmail.com>
Subject: Re: [PATCH net-next 05/10] udp: refine __udp_enqueue_schedule_skb() test
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 17, 2025 at 8:00=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > Commit 5a465a0da13e ("udp: Fix multiple wraparounds
> > > of sk->sk_rmem_alloc.") allowed to slightly overshoot
> > > sk->sk_rmem_alloc, when many cpus are trying
> > > to feed packets to a common UDP socket.
> > >
> > > This patch, combined with the following one reduces
> > > false sharing on the victim socket under DDOS.
> >
> > It also changes the behavior. There was likely a reason to allow
> > at least one packet if the buffer is small. Kuniyuki?
>
> It should not change the behavior.
>
> rmem would be zero if there is no packet in the queue : We still
> accept the incoming skb, regardless of its truesize.
>
> If there is any packet, rmem > 0

Agreed, this change should be fine.

The rule comes from 0fd7bac6b6157, and later 850cbaddb52d
tried to be more strict but caused regression, and the condition
was converted to the current form in 363dc73acacbb.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

