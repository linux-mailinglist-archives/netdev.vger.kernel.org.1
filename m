Return-Path: <netdev+bounces-204439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273C9AFA6C1
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1E3177515
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64581295539;
	Sun,  6 Jul 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4F7/k7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B5295504
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822110; cv=none; b=NajKDzdwAsYPNr7/eCJS00PCIvLnrOWd/R9r3djBa6XckI8fKdAx+/gR/+GnhYn3sSBW6C4RbxAXYkAzPWVSyohQ5HUX+4Gp3CYb811FKXSE+S0NBVkxkf9DD2M1AJ1D+vfh+MEbc31CeiorI7XdIWaQwpRplc2pza4S/ziW0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822110; c=relaxed/simple;
	bh=p4nbTSt7utFUXz35Tt6n0h0pEjmMw1djq0hMoE057wk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iL0NhTaw2savy0OtZCdlvKls357h6qrVWVSh9buLqNvycYa5eObpGrCfCUWi0ModXyLh6d9rAgYnsJYzLtVSXqquKLiL67RSBexRKJ1dJLcnM/8uNW3PWhggBHmPGpKA7QQqa59tS/MWP89vW2/Yxp2kKV/FygiZbkRVhDfdsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4F7/k7W; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e740a09eb00so1969877276.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751822108; x=1752426908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KncLTULYs4+eNfpljba13Lx57LSDtJZ6MxilKHFEuC4=;
        b=U4F7/k7WT2OmqpW3eZ26QuSJ3B262967R3iIrDEXMvOU9+b+zhKRJdgA4cNj+8Ale+
         XQXe8JqdAeBe9HN9ygYEe7JtZ9YRxxh4LUQTeXOFyVqKR5wKo/OIS81QCYsJ0JFiyaRe
         JohLOtHRBhHS1E3e5QaoGXR2R9v7HrbdxZPMry+rb4Vp2pH0JDqfcb4jJQx3YrWJlhEy
         RCHVahGFf899GIvDY5KZWsmsGqhOXO07OyrZA3M/b4S3nUzr+QfkUz0iAMRfh2j8EhFz
         JZJgrnh85PySP5voq+kldUQvWQ9WCQ2kNfh5K1TT9h/neYtbVb5Vv3SuPhRxxl+FsdxE
         bqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751822108; x=1752426908;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KncLTULYs4+eNfpljba13Lx57LSDtJZ6MxilKHFEuC4=;
        b=Zr914P6hDZPmiKx1i6R87dwS4zJxgJUAzHUYWWwx4wKptRzjpXwq9FHWYXJvds2wxi
         cB3toiWY9hvgmAFn+qXzVDONhMifQZjg7ieKGTDCh2GuAMhX4D4+sI01/BTQClZSa+uY
         i8neVZHZLqn5iAkrsGn7b18HSHN15J1nuV5c+wl3YIQyAGjJfrhZnBV0qg5Cp6/D2ZcC
         4ZQsOMgP1A1f1wEQ+3l7sG4Jrk8Dxx3xkq62YzXc+kpADnVJmZf8keO48BMWW71TaPeo
         f7bokgnOIRMIePaz/K69u5h92d3bnJundoRUGK6hXwqMw3PKuMBLkm6yF77QtYqsb0sO
         G4HA==
X-Forwarded-Encrypted: i=1; AJvYcCUayUAh3+gzzy4GJWOmS0mrjFOy8RNvqmn5ykDSw0Y1dhiAkyMBFIU+rV0ZM4/4DojaXz7S35E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/dX6MpQulzLLDs8PM9Fr4M9jPRzLy6CR2S+v5Zt+s35maRsW
	R1z+CR3OWpJYm2r/qxgHLYPZpY4xIr92L1NznoVR7IQYscDNDeKxI28E
X-Gm-Gg: ASbGncs5moDflr3N/0yC2ITJYnr4WIPL2/3NV2KKpnFRqCH0iMc3mcRRqi5lrh9mw5g
	IPfC12I56vxe/pvin3RmtK66yyXq78AaI+wJ5PO8OjLln4cj+WoPsxKapPuNJEeOgWjgORLBGDg
	o2rDpVr6kakJDbozTEzzZW2652PlCD+l18JRLTgghb3VqICoNVE16aerb03ZJTknsTqub9dVrGs
	h2r/OIsebHaEZws+qwsPXp4xbdBaY/UVOy61QWQiJs9el9otyDkuGCakGBh4I0/8SYOImzs4iqw
	kMr3YdRUeJ4T3xLMPOCifgvgahhlY4Z6w72WCZZef14EexW0kUGQV0hob9aLiF3CoEKnoyWddVl
	6nWAB2lX/Gnkcxj3oevQDUzAL6mU9Bt2rvkUvH9U=
X-Google-Smtp-Source: AGHT+IH+wNdv14mh50xgEsYijct4gokOHPD6h6URmO1qXFJOKJHPJXd5ZtfRV8phlJC6zOesm/JtbQ==
X-Received: by 2002:a05:690c:4c04:b0:70c:bb54:cd05 with SMTP id 00721157ae682-7166b6c2eb1mr129420127b3.19.1751822107793;
        Sun, 06 Jul 2025 10:15:07 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665b43cbcsm12664257b3.109.2025.07.06.10.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 10:15:07 -0700 (PDT)
Date: Sun, 06 Jul 2025 13:15:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aaf1acacc1_3b7462294aa@willemb.c.googlers.com.notmuch>
In-Reply-To: <686aa91268bbd_3ad0f32942b@willemb.c.googlers.com.notmuch>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-10-daniel.zahka@gmail.com>
 <686aa91268bbd_3ad0f32942b@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH v3 09/19] net: psp: update the TCP MSS to reflect PSP
 packet overhead
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Daniel Zahka wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > PSP eats 32B of header space. Adjust MSS appropriately.
> > 
> > We can either modify tcp_mtu_to_mss() / tcp_mss_to_mtu()
> > or reuse icsk_ext_hdr_len. The former option is more TCP
> > specific and has runtime overhead. The latter is a bit
> > of a hack as PSP is not an ext_hdr. If one squints hard
> > enough, UDP encap is just a more practical version of
> > IPv6 exthdr, so go with the latter. Happy to change.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> > ---
> > 
> > Notes:
> >     v1:
> >     - https://lore.kernel.org/netdev/20240510030435.120935-8-kuba@kernel.org/
> > 
> >  include/net/psp/functions.h | 12 ++++++++++++
> >  include/net/psp/types.h     |  3 +++
> >  net/ipv4/tcp_ipv4.c         |  4 ++--
> >  net/ipv6/ipv6_sockglue.c    |  6 +++++-
> >  net/ipv6/tcp_ipv6.c         |  6 +++---
> >  net/psp/psp_sock.c          |  5 +++++
> >  6 files changed, 30 insertions(+), 6 deletions(-)
> > 
> 
> > @@ -95,6 +95,9 @@ struct psp_dev_caps {
> >  #define PSP_V1_KEY	32
> >  #define PSP_MAX_KEY	32
> >  
> > +#define PSP_HDR_SIZE	16	/* We don't support optional fields, yet */
> 
> Duplicate of PSP_HDRLEN_NOOPT?

Oh no it is not: that is the length in 64b words.

