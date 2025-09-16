Return-Path: <netdev+bounces-223543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52EB59732
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AF41882947
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB02D7DCD;
	Tue, 16 Sep 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N/sgBRmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B162DAFB5
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028503; cv=none; b=LsEjwalOBA1ifqnnl+qOv0wcvTYlrbxPkLrzEVFJgXEWO2CGLY/4+l+DarnJ+MWfZZ3uQT3Qnbq8exjopxPD3DopMjf42Dk+rndQrndK9IJCsOSTj0vCFDeEmMDEMJ3H2Qe7qD3Vt/wRaD+U8VrgZeRGeLrl8SQcrw0Pl5JGSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028503; c=relaxed/simple;
	bh=qYOXSAuVETfAqbVxwgGh6oM6Itfs2JWazdrCDA7fhEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNZ68ReQJzDyGlkpcwyTSAho3tUvksVzVoJ/f8GthT9sTXc2AesB34NMHM6ZmOd+l7sfsMQko7e0abwFqHgz/7DSs87sRnkACYFeu6RUemsjYUDpssl4hd5FPOwEwWZJO92tvE9QOnPhzXIh8Hb3zBbXhs3c1m2xAh6Sj49aYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N/sgBRmO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso7332599a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758028500; x=1758633300; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVwsnwY1eoaq5uc5Kwtsk2EPq6m+058SD1iHskVvrjA=;
        b=N/sgBRmOcZpw5xkgU5MmgMR4o9BPuRA/+xXPtr/7HHg4m7uRyLn807GcsqZ+ckQWi2
         cF27Nbv4NDAA5T4LYbWJg28ssFkp6YUidj5HA1y2Bbh/ApLOo9G8eoQfSqnTmTOzRMoi
         WGZOmQUygmzx6EvuPUWc47R2NjOvvTJ7KZAEtld/DmPWYx1/8ZyPZE43QqgB+TNREvY5
         06uz8A6NvySHvmMh+757mNp/6OKw3A4SiawSUjq3J3tIQYC3DaprcysnFucPZs585Ou/
         L9ysPJvTP7rQvd4tDl62bFyai0znDCkXDon+Bm01H+Q8ohkPkh+VQj3H92dApOduJCdF
         g7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028500; x=1758633300;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVwsnwY1eoaq5uc5Kwtsk2EPq6m+058SD1iHskVvrjA=;
        b=Av/PXXSwoPvBkBZRYtUg/yN/Ug9mEtJCB4zXE9jq1R71BHnJtfq82/5qAJhRbQ3aAo
         ecPr8chxAATWkCc0920cL/c/uEixWmYJfbj6YidNTFb+OlLr7wuECT/Y/RzIZGh25e0C
         YE+tj6m4tbqSUGRSl+PR5vhCZdFS7/PO5VDdCyBtDrQrwUNDDb248Q6XQsZGyuXJn1YV
         LnZM4GLpaPs5s4Tvj6mtFwM9gaiLNvHwofIT+mmyuQd38j1WC9JMzSQCAFvOX3K8FGCp
         Jilhu9Hu1CwglPnQVl/8boJlb5peIkEo/dGCvviXbnd5vFel/4cKvIlD/HJgQralwWfm
         E5lQ==
X-Gm-Message-State: AOJu0YxXTpbaPUGlpqYnc/28/gYm4ery2BXNzu2oD/141ApcLVCZLdWA
	xrwE6bv49swHQTbRNtt4CDzxp4QTwk3TR8C1gNX3AcubIa2pJI8QSd6yG6ISZUFQIFU=
X-Gm-Gg: ASbGnctWp/g50KOav+b38mGif1z6cMKW8eexpjpTWJExOHEUw0SEX+mrrw9pdmFUEMc
	25xPItmaL03N6DwfoLmL/rJVL+mTSE4J2e9UytV0WPMcL62l2W0YslgBM482OCxrTqap3v1pKsn
	OuGAtNuSVVoHuwH0yC0J49d5YeNpRMkEDJkor7+hFFNoUq/lqMuA+Pmp69lRO9aF4oioFeg8yo9
	v4OHOarV8B91CMDJ5Mo+HaM8Ql8fpwViHiBjitB8nSYtohFBh7yfE7fr0Hz+fGTB8LG4ROYYRoH
	sXWH4yRHK+I+mtG7bQdpXz49H10a87mlnehVTNOsx3/iSernrZfudMVevCvnT9dw/OkMlRHe5/X
	QHTnGYq86aAUm9w==
X-Google-Smtp-Source: AGHT+IFrt73aT5QtSiRD21h9+UnYjooiS1GbOrfFm+ej9RLLrmND3EAwsx060Jrs+p7zSw0Cr3ajzw==
X-Received: by 2002:a05:6402:1d49:b0:62f:5135:a13d with SMTP id 4fb4d7f45d1cf-62f5135a3cemr4380071a12.25.1758028500035;
        Tue, 16 Sep 2025 06:15:00 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:295f::41f:9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f28b873b0sm5614904a12.14.2025.09.16.06.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:14:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Neal Cardwell
 <ncardwell@google.com>,  kernel-team@cloudflare.com,  Lee Valentine
 <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v4 1/2] tcp: Update bind bucket state on port
 release
In-Reply-To: <b22af0eb-e50b-4d5c-a5bc-eb475388da10@redhat.com> (Paolo Abeni's
	message of "Tue, 16 Sep 2025 12:14:01 +0200")
References: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
	<20250913-update-bind-bucket-state-on-unhash-v4-1-33a567594df7@cloudflare.com>
	<b22af0eb-e50b-4d5c-a5bc-eb475388da10@redhat.com>
Date: Tue, 16 Sep 2025 15:14:57 +0200
Message-ID: <875xdi5yjy.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 16, 2025 at 12:14 PM +02, Paolo Abeni wrote:
> On 9/13/25 12:09 PM, Jakub Sitnicki wrote:
>> Today, once an inet_bind_bucket enters a state where fastreuse >= 0 or
>> fastreuseport >= 0 after a socket is explicitly bound to a port, it remains
>> in that state until all sockets are removed and the bucket is destroyed.
>> 
>> In this state, the bucket is skipped during ephemeral port selection in
>> connect(). For applications using a reduced ephemeral port
>> range (IP_LOCAL_PORT_RANGE socket option), this can cause faster port
>> exhaustion since blocked buckets are excluded from reuse.
>> 
>> The reason the bucket state isn't updated on port release is unclear.
>> Possibly a performance trade-off to avoid scanning bucket owners, or just
>> an oversight.
>> 
>> Fix it by recalculating the bucket state when a socket releases a port. To
>> limit overhead, each inet_bind2_bucket stores its own (fastreuse,
>> fastreuseport) state. On port release, only the relevant port-addr bucket
>> is scanned, and the overall state is derived from these.
>
> I'm possibly likely lost, but I think that the bucket state could change
> even after inet_bhash2_update_saddr(), but AFAICS it's not updated there.

Let me double check if I understand what you have in mind because now I
also feel a bit lost :-)

We already update the bucket state in inet_bhash2_update_saddr(). I
assume we are talking about the main body, not the early bailout path
when the socket is not bound yet [1].

This code gets called only in the obscure (?) case when ip_dynaddr [2]
sysctl is set, and we have a routing failure during connection setup
phase (SYN-SENT).

In such case, on source address update, call to
inet_bind2_bucket_destroy() will recalculate port-addr bucket state,
potentially "downgrading" it to (fastreuse=-1, fastreuseport=-1).

But if the "downgrade" happens, it changes nothing for the port bucket
state, as we are about to re-add the socket into another port-addr
bucket.

Now, adding a CONNECT_BIND socket to an existing port-addr bucket, that
also has no side effects. We can't "upgrade" the bucket to the shareable
state (fastreuse=-1, fastreuseport=-1).

That said, I do see an unaddressed corner case now that I audit this
code again. If we end up _creating_ a new inet_bind2_bucket
(__inet_bhash2_update_saddr->inet_bind2_bucket_init), then the bucket
state should be initialized to (fastreuse=-1, fastreuseport=-1) when the
socket has the CONNECT_BIND flag set.

The call chain I'm referring to:

tcp_connect / __tcp_retransmit_skb
  ->rebuild_header
    inet_sk_rebuild_header
      inet_sk_reselect_saddr IFF sysctl_ip_dynaddr != 0
        inet_bhash2_update_saddr
          __inet_bhash2_update_saddr
            inet_bind2_bucket_init

I propose to handle that by checking if the socket has CONNECT_BIND flag
set and overwriting the port-addr bucket state similiar to like I did in
__inet_hash_connect:

	tb2 = inet_bind2_bucket_find(head2, net, port, l3mdev, sk);
	if (!tb2) {
		tb2 = inet_bind2_bucket_create(hinfo->bind2_bucket_cachep, net,
					       head2, tb, sk);
		if (!tb2)
			goto error;
		tb2->fastreuse = -1;
		tb2->fastreuseport = -1;
	}

So the obscure ip_dynadr path does need a fixup. Other than that I'm not
able to poke any other holes in how we manage the bucket state.

Was that your concern or you had something else in mind?

Thanks,
-jkbs

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/inet_hashtables.c?h=v6.17-rc6#n914
[2] https://docs.kernel.org/networking/ip_dynaddr.html

