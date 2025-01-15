Return-Path: <netdev+bounces-158520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02EEA12575
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D081880660
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F624A7D8;
	Wed, 15 Jan 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Od3zd3Mf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6624A7D4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736949185; cv=none; b=oHjR8BFPOWneogX0C4DRZwwubv53tk1T2eVdTYspvSDhavoidD7+MkV8HYL6uO4QvmV3Jn6istR9J0xDYcROAssiDfSshV5l3rG8pTMo8VLDT/nfdKXeVx4OjD8K7uSAJcL3cHDJDvEoL0LsmkVd1Gxkpj3QzzPCp+6AXAaBUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736949185; c=relaxed/simple;
	bh=0b9rQR8Bd5m5htxdFUc/BMyjhvr6uKt1GUzub9VM0Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcX5E1DWrR2sVSFNNU7sWO4Fnh0DH97kAKZiKdWpra10zIbgsZGW6TNTsn7MIw1WYrA1KYkejI96GisyXFeCKuYh1iDh8BXGwHrxS6Bmop+z7d/axZ5u5UlQfuXf8tmMJk9pMEPzNLiE/lRW+e5IG3umMVwPXBTR4cljn7Muyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Od3zd3Mf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736949183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bLMBpFvBMz0AmtfPsKbjpEOB0wghPaqEDuI+9VAYBM=;
	b=Od3zd3Mfm+3BEQs6WsEoFGO2QtrWDWT1c4TIMeEJWVRLEp5rekAgR7fTyFEErhmlcboOv5
	CMaF4IpKs70RYiB+cnUrTIcm3zNt5ydXorpniLHdoLkamr8zmQemVEtoso8teZzO6cpFve
	PNAIC39QNRdK9nnS1RQhvDbsScBOPjk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-u315Ig96NVeEgv06_iJgRQ-1; Wed, 15 Jan 2025 08:53:01 -0500
X-MC-Unique: u315Ig96NVeEgv06_iJgRQ-1
X-Mimecast-MFC-AGG-ID: u315Ig96NVeEgv06_iJgRQ
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so15963977276.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 05:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736949181; x=1737553981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bLMBpFvBMz0AmtfPsKbjpEOB0wghPaqEDuI+9VAYBM=;
        b=sjTGPLBJZaiebu0Qk3QbqZSYSxMHVfEppOqjUAMMg+Eq3IYHxK6imrDbMUI7hZSy0F
         g94R2LqznC6eMHS1+jPPnmOBdXvg4xEfQkmo16nfVyrPXRkVAqXm5XMS1rkqopjhOYej
         czTYBmpCOceD2E7Qtfgx08lhR378fYyvjWMm9hXSKuI7Vd0A8S0E+KEu92GmO5yJiG3q
         qVfkRDdniMIVRCNzqJNwViHSggi6ggaj9OgVKXbhsTa757sSp6dqvAOTUQorP5vd2wrW
         NcP0Et2ZLg5lXcPxQnKytym9r3NKw6fPmHbFyOazp/njd4j5iPz/utA2dSOADb2CuafU
         Kzrg==
X-Forwarded-Encrypted: i=1; AJvYcCUF+ay0W9Lv4zVEVLYdagnQZ1ExfIqYE8DoN6Jubw1NMJhKktb+Cd0+ciPcYrm1X0stk2tSZkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynDnict/jKFURx+L9cMu1Jx8Gfe0Y+gWD7turHbTPljmJNCyAg
	LTfJWRsEw/dzZN0Ed77neAZRXGIUNzvi5F6qKXapUCngQ57+4Z9JRs307Klf7lqzTkSHYcpKWs6
	Oe0aksaa6qh7/g859XN9LRyFXZliZ4K0FynsoJSMQar6K5aHaroaX1OgC5LdLFw/Wba3oz533Nz
	ZGwBvY63ZTO6nWuGeGdXPhgXJcGzjY
X-Gm-Gg: ASbGncthAMdTBnXivcvHp+3JkeYYhCyGDVZtLjaWNv/9n1gVFDKjhTtLo9y9Z5MNAKH
	O68ZOKuPs/WYdTUZBdv7kwfrrihQvTsLuFi5+jQ==
X-Received: by 2002:a25:2186:0:b0:e4c:35c4:cefa with SMTP id 3f1490d57ef6-e54edf25ff7mr16682320276.13.1736949181276;
        Wed, 15 Jan 2025 05:53:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF08x6DZhMrwN26X5fqImOQEFvEor5m0mJuy0BZYvFu8pIdbg0F/Dpk1L6RSZu2D20Nzx61q+CHr8isL5N8Ezk=
X-Received: by 2002:a25:2186:0:b0:e4c:35c4:cefa with SMTP id
 3f1490d57ef6-e54edf25ff7mr16682311276.13.1736949180907; Wed, 15 Jan 2025
 05:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112040810.14145-1-kuniyu@amazon.com> <20250112040810.14145-7-kuniyu@amazon.com>
 <20250114170516.2a923a87@kernel.org>
In-Reply-To: <20250114170516.2a923a87@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Wed, 15 Jan 2025 08:52:50 -0500
X-Gm-Features: AbW1kvZtgS2IOBfQ_yJXukb3IQsLXWEwPmjxpyOARwTxNDLvesb__G-dRcwR6_I
Message-ID: <CAAf2ycmV2T_QUn2Y6rSUjwiwTLQqfW1TFk_3SfeTiO03jz8vXg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/11] af_unix: Set drop reason in unix_stream_sendmsg().
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 20:05, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sun, 12 Jan 2025 13:08:05 +0900 Kuniyuki Iwashima wrote:
> > @@ -2249,14 +2265,13 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
> >  static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> >                              size_t len)
> >  {
> > +     enum skb_drop_reason reason;
>
> I feel like we should draw the line somewhere for the reason codes.
> We started with annotating packet drops in the stack, which are
> otherwise hard to notice, we don't even have counters for all of them.
> But at this point we're annotating sendmsg() errors? The fact we free
> an skb on the error path seems rather coincidental for a sendmsg error.
> IOW aren't we moving from packet loss annotation into general tracing
> territory here?
>
> If there is no ambiguity and application will get an error from a system
> call I'd just use consume_skb().
>
> I'm probably the most resistant to the drop reason codes, so I defer
> to Paolo / Eric for the real judgment...

For what it's worth, I agree that there's no need to annotate a drop
reason for sendmsg failures that return error codes to the caller.
That's why my original patch proposal just changed them to use
consume_skb(). I did misrepresent the cases as "happy path" but I
really meant that from the perspective of "no send initiated, so no
drop reason".

https://lore.kernel.org/netdev/20241116094236.28786-1-donald.hunter@gmail.com/

Thanks,
Donald.


