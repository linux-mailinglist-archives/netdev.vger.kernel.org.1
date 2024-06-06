Return-Path: <netdev+bounces-101235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFC8FDCE6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00062845E8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D906199B9;
	Thu,  6 Jun 2024 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUk+mhQG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6018638
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641637; cv=none; b=X4M61KxtLt1a+6yjcNd5pS3I+eyObCSQjYSuUt7o2NW2aDxWfWs9KVhuupLAfSfpR9YG/iVJ0dPd2dwzwmJfvo7aoNzWLzZH7lCM/v0/7V3+LBJD3tmfNVxatnp/fLCGG2h+wo//2ic8UfGSB2Bg3SvX5eRJzkxned3XT2dXtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641637; c=relaxed/simple;
	bh=maW8XAM/xra6fA7/Tcc8fjC0XPc07r865VEkHb/emAQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HGPdNeWdayHRathUsiw1lBtUo+O6LDyAO2yijzv4a5j/cnogKHCCeWE0bx9+WQJzR9aNM2UylmcX+Jj7y2mYxu7SYVDH4KRrV6tNGtVh4h2Cw4d5T+YQ0NjUl4k/+Vx7rxKFtPfnvLx6f1jBwIyBdbqlKbJIen/LuZMTmH9dpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUk+mhQG; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44030ea4251so2416761cf.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717641634; x=1718246434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr4cKrXSK6khqTrOgb3rQpoXLFXBOzFAUA0w852Wcng=;
        b=HUk+mhQGJ/ZGWzTJAocqG78cIhn0hpYy4F+Eu60L5vgj6W9yrC0Jsu3IngbT2fct/U
         EmmY/0qnky2VdV2tPf5dCyW4jkzuGWR0G3HnCbxEu8T38aoYsEddV/h4Ly4xeSNvuh3P
         0UfDUEnE5OITPXibcOb3NQMJeitmJs75+9AFZzmKGCl4C5n3Uo4U2fuvy1ESZtKUUOLz
         2fbMpMfbepdNexSc6OyTWLs01EPYGHvdx+CvTxcBVbsa+//DJjLRwbeB80dVzTbC/mcY
         Gv0gXXcZbwq2jwI5ESwoAfWBHvEGu9Auzdb8x4yg6/0qQrOLozUbT5HlmZSrpwHiuOg5
         Kzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717641634; x=1718246434;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qr4cKrXSK6khqTrOgb3rQpoXLFXBOzFAUA0w852Wcng=;
        b=E4jmKx+bDjbzJboGTqQOblM7IQjXmR48MDGb6DlxA1ROL1a8VElPYctEeKJG3+um4B
         bGxLaaTO4Lr55aiO/dTc7sI1pUcM/GX0W3bAjxbeLqhF8LI5z/Fdixb41oKrRyhvyESW
         n9c96eVsTfYEOVBYlOeiKhiOtXfhrjHcUWlOX35dAzjgzb9BlDkKAPWKAk9WqOrK7yMp
         5eYQI933XCkbfcC+90pG96DMS0qPf5R2EZoMcsDWraV7l8GWT5lp6MaNHpi1XTPII0hY
         vP1A6NJVEZ4jKe8871iXKnUc038hOXjWQHe+uSdJmT0LyxSvhXyzmZRUUUo1fv0FK7BQ
         FTdg==
X-Gm-Message-State: AOJu0YwPTS70KIOqLmQ9S4gLFTpuRDOvwTS31v7MhpL0rqBYBL1urAP7
	P3PvhkDV/gxitOB7hzkYXTQpaf+oJHxyQ2fsdoH/1hiBO8FYVEye
X-Google-Smtp-Source: AGHT+IEBTXLk5JSSCBT35cx18xpbNDgBUorDYgSUhgBZxFpKL1P1fLUC6JGW8FJWPn5mXuiCQZUuAQ==
X-Received: by 2002:a05:622a:2c5:b0:440:25f2:4abe with SMTP id d75a77b69052e-4402b6d988bmr54316471cf.60.1717641634168;
        Wed, 05 Jun 2024 19:40:34 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4403895af04sm1568821cf.20.2024.06.05.19.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:40:33 -0700 (PDT)
Date: Wed, 05 Jun 2024 22:40:33 -0400
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
Message-ID: <666121a11b795_365183294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240605152431.5f24cb45@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
 <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
 <20240529103505.601872ea@kernel.org>
 <6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
 <20240530125120.24dd7f98@kernel.org>
 <6659d71adc259_3f8cab29433@willemb.c.googlers.com.notmuch>
 <20240604170849.110d56c1@kernel.org>
 <6660c673921ff_35916d294ef@willemb.c.googlers.com.notmuch>
 <20240605152431.5f24cb45@kernel.org>
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
> On Wed, 05 Jun 2024 16:11:31 -0400 Willem de Bruijn wrote:
> > > The retansmissions of K-A are unencrypted, to avoid sending the same
> > > data in encrypted and unencrypted form. This poses a risk if an ACK
> > > gets lost but both hosts end up in the PSP Tx state. Assume that Host A
> > > did not send the RPC (line 12), and the retransmission (line 14)
> > > happens as an RTO or TLP. Host B may already reach PSP Tx state (line
> > > "20") and expect encrypted data. Plain text retransmissions (with
> > > sequence number before rcv_nxt) must be accepted until Host B sees
> > > encrypted data from Host A.  
> > 
> > Is that sufficient if an initial encrypted packet could get reordered
> > by the network to arrive before a plaintext retransmit of a lower
> > seqno?
> 
> Yes, I believe that's fine. 
> 
> I will document this clearer but both sides must be pretty precise in
> their understanding when the switchover happens. They must read what 
> they expect to be clear text, and then install the Tx key thus locking
> down the socket.
> 
> 1. If they under-read and clear text data is already queued - the kernel
>    will error out.
> 2. If they under-read and clear text arrives later - the connection will
>    hang.
> 3. If they over-read they will presumably get PSP-protected data
>    which they have no way of validating, since it won't be secured by
>    user crypto.
> 
> We could protect from over-read (case 3) by refusing to give out
> PSP-protected data until keys are installed. But it adds to the fast
> path and I don't think it's all that beneficial, since there's no way
> to protect a sloppy application from under-read (case 2).
> 
> Back to your question about reordering plain text with cipher text:
> the application should not lock down the socket until it gets all
> its clear text. So clear text retransmissions _after_ lock down must be
> spurious.

Ah yes, good point.

> The only worry is that we lose an ACK and never tell
> the other side that we got all the clear text. But we're guaranteed
> to successfully ACK any PSP-protected data, so if we receive some
> there is no way to get stuck.  Let me copy / paste the diagram:
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
> Looking as Host A, if we receive encrypted data, we must have
> allocated and sent key (line 7) so we will start accepting encrypted
> data. But at this point we are also accepting plain text (until we
> reach line 9). We will send a plain text (S)ACK to encrypted data, 
> but that's fine too since Host B hasn't seen any encrypted data from us
> and will accept such ACKs.
> 
> > Both scenarios make sense. It is unfortunately harder to be sure that
> > we have captured all edge cases.
> 
> Are you trying to say packetdrill without saying packetdrill? :)

Ha, no, no such hint implied.

I did expand packetdrill to PSP to exercise the cases that I could
come up with, at a minimum to ensure coverage of all branches.

But does that cover all edge cases possible? Including drops,
reorders, geometry changes from MTU changes, SO_LINGER 0, races with
slow OS operations (like that slow SADB insertion I mentioned)? The
unknown unknowns. Stuck connections are a low risk, bugs that can be
fixed later. As long as it is easy to reason that actual crypto issues
like plaintext leaks are not reachable.

Extending packetdrill to netlink would be quite some work, I suspect.
A quick scan shows that it knows NLA, but only for OPT_STATS decoding.

> > An issue related to the rcv_nxt cut-point, not sure how important: the
> > plaintext packet contents are protected by user crypto before upgrade.
> > But the TCP headers are not. PSP relies on TCP PAWS against replay
> > protection. It is possible for a MITM to offset all seqno from the
> > start of connection establishment. I don't see an immediate issue. But
> > at a minimum it could be possible to insert or delete before PSP is
> > upgraded.
> 
> Yes, the "cut off" point must be quite clearly defined, because both
> sides must precisely read out all the clear text. Then they install 
> the Tx key and anything they read must have been PSP-protected.
> 
> Hope I understood the point.

I think the issue, if any, is that there may be a gap between the two
methods of integrity protection. What we call "cleartext" here is
integrity protected such that no insertion or deletion attacks are
possible. And PSP ensures the same. But is a a deletion of the last
plaintext or first ciphertext possible?

An insertion is not an issue as it will be protected by neither,
while PSP is expected, so it is dropped.

As long as the application (or is it presentation?) layer has a clear
definition of at what point in the stream it must insert the Tx key,
plaintext deletion is not possible, as the key is not inserted until
all plaintext has been received.

Which leaves: is it possible for a MITM to offset the seqno, such that
the first PSP encrypted packet can be removed from the stream and this
goes undetected?

