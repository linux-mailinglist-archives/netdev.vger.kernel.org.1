Return-Path: <netdev+bounces-101138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF88FD74D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681991C22916
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F61586F1;
	Wed,  5 Jun 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyTNBdu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5311586C7
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618295; cv=none; b=aRz6KXaTKj9gFk5vnpL2zyKzDMRyanLcHZWImOD5SZ6JKeV2phlaRcTdCIFqzB0BQzjcqRws2P/epmujNT9TwR/YoVZxCfBjHNwbg6optPQIBNGcYRa8h/vYvFmVbUnE+Pd+K0TL1U5dcMa/DQsv90QILNzpidf81vcd4NdyMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618295; c=relaxed/simple;
	bh=ioYlWZUe55PA4g9dFem8CpnCiILSNt8iGjnYJCrGQ0c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=n2kbmZpqRwW/HmPdSGeOFifuwOsWLI9dw2PkEsaCMgIGZIh+gExjXA7/MPKxU0N04lgDFbqJpuGSzRi70ZGKSv26y6JV85KJor6QQu7AmVRg6B/mOvfvDJf5qTZroOoC2nk/4kD1LRmOVCkXP9J1KcHo5QOQGL93VremwUTAGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyTNBdu3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-794b1052194so9872285a.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717618292; x=1718223092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoJxdM+LMV7HH2aBaolN17U4lrUUxSf7HAV1fXKbowg=;
        b=iyTNBdu3O7GcZxBDhFYbwDwGMcifLcat23sKPMcEBsYxsJ+Z9ZC/mALuZ+tP8Mjh/N
         OhIFDBfkWGwj3zgMO70mJ3DWyzTnkBqlBhusK+fYYmUMLjhnPTUHdVm9lGtjOe+yNm03
         dZSgtgJ+y7v2Jw8KDlRcXs6/GdLe5rgGfEgiNmD7dvCAFqti903JM5hLtsXX2L6ZOboT
         QQbUp6M8A+IisJMuotHI1MU8x3G6d87jUlgnOk+fUJbjg0Ow2FuQqQb02B921sn1uLaK
         g4+nvtwrDDYusEb+GN1a/Lf0sOcMA+h44RJquAkzBprX6phhPBDCPwJiJ0z2WCCuXvs1
         lfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717618292; x=1718223092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FoJxdM+LMV7HH2aBaolN17U4lrUUxSf7HAV1fXKbowg=;
        b=Y0P3LczjbOHVlFHe+jVzQ5FWMaziH0M1tBImLxVc8GKqyu5z5kJhRvWVJJiCPU8UKe
         PdAFkcTe7M8MTtmroIAn3LlpQDVGAAcSImhUpAOBc5Jsu7735NwD9i9t228yY2/Vq0oL
         +aK7klAydGfae2PsKtBESjfIq/l7a1zU6upHU/SR5FZAiHchSkgcoJy3xoDL1mp0THqL
         P7dgEMd8bss6EKJH3A+WgBmJNEn0E7vHYwEt+P5wyUPmLwvMqdYcANVp/KR3UmZh7j35
         kq8NTnWcpQFfopQyIOgkGWVc1gWtV+ldkriZIzIbLKJAvu2yGgPcbb0nYqFgnNab+d47
         RdYg==
X-Gm-Message-State: AOJu0YyzZuFuWVOtBgLkfa5EkmrWunqDpLssOj8s7gvET36TBMUAyHnN
	P6ahDFdPmLKTgUy5ILxlXTXkAyFVtey2BrL2SOImmmlfBNKNlEb+
X-Google-Smtp-Source: AGHT+IH+54y9UCaH8ZOQPKLxcwWgTtfVPZ6Lu1lazMJln1MoR4/hjKrGr9yFGuSIuY6r5o03Rlz/eg==
X-Received: by 2002:a05:620a:4310:b0:790:979b:c20c with SMTP id af79cd13be357-79523d24b67mr456182985a.12.1717618292294;
        Wed, 05 Jun 2024 13:11:32 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23fd934sm63128661cf.58.2024.06.05.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:11:31 -0700 (PDT)
Date: Wed, 05 Jun 2024 16:11:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com, 
 mingtao@meta.com, 
 knekritz@meta.com, 
 Lance Richardson <lance604@gmail.com>
Message-ID: <6660c673921ff_35916d294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240604170849.110d56c1@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
 <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
 <20240529103505.601872ea@kernel.org>
 <6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
 <20240530125120.24dd7f98@kernel.org>
 <6659d71adc259_3f8cab29433@willemb.c.googlers.com.notmuch>
 <20240604170849.110d56c1@kernel.org>
Subject: Re: [RFC net-next 01/15] psp: add documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 31 May 2024 09:56:42 -0400 Willem de Bruijn wrote:
> > > > If one peer can enter the state where it drops all plaintext, while
> > > > the other decides to close the connection before completing the
> > > > upgrade, and thus sends a plaintext FIN.
> > > > 
> > > > If (big if) that can happen, then the connection cannot be cleanly
> > > > closed.  
> > > 
> > > Hm. And we can avoid this by only enforcing encryption of data-less
> > > segments once we've seen some encrypted data?  
> > 
> > That would help. It may also be needed to accept a pure ACK right at
> > the upgrade seqno. Depends on the upgrade process.
> > 
> > Which may be worth documenting explicitly: the system call and network
> > packet exchange from when one peer initiates (by generating its local
> > key) until the connection is fully encrypted. That also allows poking
> > at the various edge cases that may happen if packets are lost, or when
> > actions can race.
> 
> Dunno if the format below is good, but you're very right.
> At least to me writing the diagram was an hour well spent :)

Great :)
 
> > One unexpected example of the latter that I came across was Tx SADB
> > key insertion in tail edge cases taking longer than network RTT, for
> > instance.
> > 
> > The kernel API can be exercised in a variety of ways, not all of them
> > will uphold the correctness. Documenting how it should be used should
> > help.
> > 
> > Even better when it reduces the option space. As it already does by
> > failing a Tx key install until Rx is configured.
> 
> Something along these lines?
> 
> "Sequence" diagram of the worst case scenario:
> 
> 01 p       Host A                         Host B
> 02 l t        ~~~~~~~~~~~[TCP 3 WHS]~~~~~~~~~~
> 03 a e        ~~~~~~[crypto negotiation]~~~~~~
> 04 i x                             [Rx key alloc = K-B]
> 05 n t                          <--- [app] K-B key send 
> 06 ------[Rx key alloc = K-A]-
> 07     [app] K-A key send -->|
> 08        [TCP] K-B input <-----
> 08 P      [TCP] K-B ACK ---->|
> 09 S R [app] recv(K-B)       |
> 10 P x [app] [Tx key set]    |  
> 11 -------------------------- 
> 12 P T [app] send(RPC) #####>|   
> 13 S x                       |<----    [TCP] Seq OoO! queue RPC, SACK
> 14 P      [TCP] retr K-A --->|   
> 15                           |  `->    [TCP] K-A input
> 16                           | <---    [TCP] K-A ACK (or FIN) 
> 17                           |      [app] recv(K-A)
> 18                           |      [app] [Tx key set]
> 19                            -----------------------------------
> 20
> 
> There is a causal dependency between Host B allocating the key (line 4),
> sending it (line 5) and Host A receiving it (line 8). Since Host B will
> accept PSP packets as soon as it allocated the key, Host A does not
> need to wait to start using the key (line 12). Host B will queue the
> RPC to the socket (line 13).
> 
> [Problem #1]
> 
> However, because Host B does not have a Tx key, the ACK / SACK packet
> (line 13) will not be encrypted. (Similarly if Host B decided to close
> the connection at this point, the resulting FIN packet would not be
> encrypted.)

Or if it plays SO_LINGER games the resulting RST.

> Host B needs to accept unencrypted non-data segments 
> (pure acks, pure FIN) until it sees an encrypted packet from Host B.
>
> [Problem #2]
> 
> The retansmissions of K-A are unencrypted, to avoid sending the same
> data in encrypted and unencrypted form. This poses a risk if an ACK
> gets lost but both hosts end up in the PSP Tx state. Assume that Host A
> did not send the RPC (line 12), and the retransmission (line 14)
> happens as an RTO or TLP. Host B may already reach PSP Tx state (line
> "20") and expect encrypted data. Plain text retransmissions (with
> sequence number before rcv_nxt) must be accepted until Host B sees
> encrypted data from Host A.

Is that sufficient if an initial encrypted packet could get reordered
by the network to arrive before a plaintext retransmit of a lower
seqno?

Both scenarios make sense. It is unfortunately harder to be sure that
we have captured all edge cases.

An issue related to the rcv_nxt cut-point, not sure how important: the
plaintext packet contents are protected by user crypto before upgrade.
But the TCP headers are not. PSP relies on TCP PAWS against replay
protection. It is possible for a MITM to offset all seqno from the
start of connection establishment. I don't see an immediate issue. But
at a minimum it could be possible to insert or delete before PSP is
upgraded.

> 
> With that I think the state machine needs to be amended:
> 
> Event          | Normal TCP  | Rx PSP      | Tx PSP      | PSP full    |
> -----------------------------------------------------------------------
> Rx plain (new) | accept      | accept      | drop        | drop        |
> 
> Rx plain       | accept      | accept      | accept      | drop        |
> (ACK|FIN|rtx)  |             |             |             |             |
> 
> Rx PSP (good)  | drop        | accept      | accept      | accept      |
> 
> Rx PSP (bad    | drop        | drop        | drop        | drop        |
> (crypt, !=SPI) |             |             |             |             |
> 
> Tx             | plain text  | plain text  | encrypted   | encrypted   |
>                |             |             | (excl. rtx) | (excl. rtx) |
> 
> > > > Another example where a peer stays open and stays retrying if it has
> > > > upgraded and drops all plaintext.  
> > 
> > May want to always allow plaintext RSTs. This is a potential DoS
> > vector.
> 
> Because of key exhaustion? Or we can be tricked into spamming someone
> with retranmissions and ignoring their RST?

Simpler: this falls back onto unencrypted TCP where someone capable of
spoofing valid data is capable of terminating a connection.

If denying all plaintext after upgrade, PSP protects against this.

It is arguably low on the list of concerns, especially in a closed
world hyperscaler setting. As it is hardly the only DoS vector.

> > In all these cases, I suppose this has already been figured
> > out for TLS.
> 
> Assuming the answer above is "key exhaustion" - I wouldn't be surprised
> if it wasn't :(



