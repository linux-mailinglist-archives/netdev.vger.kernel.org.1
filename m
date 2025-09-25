Return-Path: <netdev+bounces-226480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E27BA0ED2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41EA17A4BCF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC12302150;
	Thu, 25 Sep 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lblUjUi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D178F43
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822128; cv=none; b=qL+wVYNp/AqdJ6T4FSjx+y16Uatbelax57lx2ggdigYYtP54tHOa8WpPLP3+BQDFSH/PgDcyGFI5UvoPcHj4Dqq3XpcWsP30tS3dqFkQMJgcmSY3mDVOPR0/CHfII8k4WLopMPMIwkRsA4prFxPareqPhYycSEqAVfGNYOJKrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822128; c=relaxed/simple;
	bh=Q0C+GcWsIdI1fnXmWm4ajyjzM8VnrnF2eGZbypkHLns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUaZlNguLRTRsEY4QzaZuo6B+bwbvwChgS55+R1hXlBzuMLH64t6ko0ADsiL4SxHRXUBCrJ8joJ98iDrG0bTYQwh1erAfRBm3Zx5foz3aJ2AuCfd8X9yK31GQZ7cNWibV5VPNXYHm012BzMWsz5h9HEMLG1h0NBQccMDGeuzahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lblUjUi+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b556284db11so1216692a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758822126; x=1759426926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0C+GcWsIdI1fnXmWm4ajyjzM8VnrnF2eGZbypkHLns=;
        b=lblUjUi+iRXWIaITQHyS170jEb0AUrfB6Jnr9WNHvSMEOnUPibqSuQthDdZlw3WbrA
         cty2yxJe28A6U3LOVOWBYG1o69LL3oTRsGpGzgsa+prHsCRFeUf3FACtKXiAeJJ+uCmB
         zjYHi+xVyZ18SarrEu5ZMs4y/q3byDLDjw4OnBB18vRuZAA7TrQ5zaUgy2fLSm3L5hOy
         22e26OhDLBduPwcJEtXOpnzwI2Tue7aeh1WXsUWBgaWf/WzRPwYvUTPHswDhnU3qxExU
         XVpPf30PEnMtsocIaCmNvm4E6RiOjMfj5yGWEPptVnQGiDQNnXJREeQx/fyU8+difcUR
         E1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758822126; x=1759426926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0C+GcWsIdI1fnXmWm4ajyjzM8VnrnF2eGZbypkHLns=;
        b=iBx2F6f4UfWd2qYCXuiDUsgCXU+DNENvyQOu9Oi5N+03eu+ievppaqD35X2yPFay3B
         wHh1mTi8k+SD6ar/zRPHEpSOO4auVJxs+X96JtGhS1Oxg93Y19+WKlOweHGGZnB16sO/
         YY4F4vfHwn+0SfFuBh2Qq5tEaL8Q7gXJXbX0AP0lLfvnqZlLfieeNOE+/B4xQoN4lmpT
         m1CAf1TUtH0D2PmL+RJLcMySVdfdCyyk3SP8og1n9aAyfYDIo3onSFUKSBgx/sC+xJhn
         Xypaw23Z8zZ6mj8CnSSyVQD0PXMpyYTTTrbR96LKdS0Mjdlw+lFIJOIYX5KQi5AxMmuo
         V+pg==
X-Gm-Message-State: AOJu0YwNRz40GRPw7qit5BYXeDWB9C9QI4He6SO26A5kc2UVqlQVXzgu
	uL9tq0ZWVFO8TbtHkV9WPekt9R+viUz6v1b3vzPDK2eGhBNI5W0ePtIc2R23DvlGvxaEw+LXa8N
	7AYNbrHjgyX9gZV21CniffVHwxDHoL/rLHUhkaFPr
X-Gm-Gg: ASbGncv2ThchewE9t+N5Fm5SfzBYqBQBjKnzhEVmj12tKAskATtIGdCJC+IGVCtS81h
	E9tbOEZ+CLXGz6/KoxJFKNNRg/MQ1wAkSnC7QSjZfbPhD9PC8bcTitd3VJfSnLhEA37VeC+GVsy
	qsxznI6z17263I49co6+ju8Ou55Y9UCewxjHL8JuCvh/Vl/Rt/uLDEKJ1At8jyE1NBus+2m25St
	FNaI8GwSHg1hnWIEvpsRqSCIuio/XvR+2/Ei0IcwyURKdP84D73FQgpSg==
X-Google-Smtp-Source: AGHT+IE8fZfiMAKwOs7niSD9BX/4zeM++qOK8XkYs9sJvWK03cPeMUDsj+MQhuTv/z3HmriYuvenopAgCx/WzRY0Ux8=
X-Received: by 2002:a17:903:1c9:b0:266:120a:29c7 with SMTP id
 d9443c01a7336-27ed49df403mr45939175ad.6.1758822125802; Thu, 25 Sep 2025
 10:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925131102.386488-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250925131102.386488-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 10:41:54 -0700
X-Gm-Features: AS18NWC0bXQ6KDKAlvYCCTk0lL_ZFofDc8WBtNT4TAUqExU1UFsi6nLUMOWH8-g
Message-ID: <CAAVpQUAA7Z7iF4eDs+f0jyx-eHUzgbArTCjd-4X7LbzOMVckZA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: fix spurious RST during three-way handshake
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:11=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> When the server receives the final ACK of the three-way handshake,
> tcp_v4_syn_recv_sock::inet_ehash_nolisten::inet_ehash_insert() first
> removes the request_sock from the ehash bucket and then inserts the
> newly created child sock. This creates a race window where the first
> incoming data packet from the client can fail to find either an
> ESTABLISHED or SYN_RECV socket, causing the server to send a spurious RST=
.
>
> The root cause is the lockless lookup in __inet_lookup_established(). A
> concurrent lookup operation may not find any valid socket during the brie=
f
> period between the removal of the request_sock and the insertion of the
> child sock.
>
> To fix this and keep lockless lookup, we need:
> 1. Insert the child sock into the ehash bucket first.
> 2. Then remove the request_sock.
>
> This ensures the bucket is never left empty during the transition.
>
> The original inet_ehash_insert() logic first attempted to remove osk,
> inserting sk only upon successful removal. We changed this to:
> check for osk's existence first. If present, insert sk before removing os=
k
> (ensuring the bucket isn't empty). If osk is absent, take no action. This
> maintains the original function's intent while eliminating the window whe=
re
> the hashtable bucket is empty.
>
> Both sockets briefly coexist in the bucket. During this short window, new
> lookups correctly find the child socket. For a packet that has already
> started its lookup and finds the lingering request_sock, this is also saf=
e
> because inet_csk_complete_hashdance() contains the necessary checks to
> prevent the creation of multiple child sockets for the same connection.
>
> Fixes: 079096f103fac ("tcp/dccp: install syn_recv requests into ehash tab=
le")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Xuanqiang is working on the fix.

https://lore.kernel.org/netdev/20250925021628.886203-1-xuanqiang.luo@linux.=
dev/

