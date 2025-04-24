Return-Path: <netdev+bounces-185468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0ABA9A900
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025BD1B86070
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57822541C;
	Thu, 24 Apr 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVHKDlYS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D922170B
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488186; cv=none; b=hOyoQTOQJqy/sVHJFkvbABp9cY77bp/5CDCIXk8Ch/nP4v0IBonBDPrrJnXXhxbEJyiDZiV7zE9GnbSZKtNkJ9m60m4vcQnXyzQ8S8eqlPrgSRW5lEhCPNvWVjcfQItLn2LQm60hjOkmnOcAiitiUhQe2hF4dXtqkAws00l4Qfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488186; c=relaxed/simple;
	bh=irmMiAJ+WbB3tpQUEbUIII7LtCdT8MIs1RXKEFQv8sU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1syrPWYXdGEAHhtrWx/HII33tsY4Wj+TVAKIDcpoHtYbKJyJyOakAr1M3BZ8I6njlmwZT7asBTy07fRbTO5mxBLNR1HuQO5YU0iWWTNrdx7l51t0r3T3h3f21wJs2mv1enVlKxsbMBF475Ti57aBWpRoKZheqO8nVYf1ZQaUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVHKDlYS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745488183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xWoZHF08GH5szV9kkGeTDbd7jOATbUDA7UR41d85J5A=;
	b=LVHKDlYSQ/yUOwm2I/QokmooknB+zvaS20FvjCh4jpZYELrC5vhYpe1hHUUKmsxhGRrL/u
	mXLX7PhVkiEAK9Oj4gB7EhatAWPwAzz9iencSMlpCBiL/XMWAGe+FC5LranY/bBXw5j/DW
	OCsRBkg6UioxiFw+RsY5c6Eu+/3gYV0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-lRF5snRUPRCaUFUTU0G9LQ-1; Thu, 24 Apr 2025 05:49:41 -0400
X-MC-Unique: lRF5snRUPRCaUFUTU0G9LQ-1
X-Mimecast-MFC-AGG-ID: lRF5snRUPRCaUFUTU0G9LQ_1745488180
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30c2e219d47so4143691fa.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745488180; x=1746092980;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWoZHF08GH5szV9kkGeTDbd7jOATbUDA7UR41d85J5A=;
        b=OCTNQlCpA8a5AWi5aYJlWJVhmPsNy+jsOpBvGngRkZH4cpeSKYyAx++kkcJ4nh3AVs
         fHd+/uCvaUAItPxG+OoDHiW11/La+6szyGdG63NM9LRbuo2Krg3/0qET2oFl88suIERd
         A7+UgvlZgBPvnJgKKtIE2ibKvp9TWrmDl+5lE3MJc7KFvyDb4tBM1PnCFBFH/W0VoglE
         hbl4buniBHX/q9EsV/dN687ilxp3QnX4YdD6Kv6cCWVORnarHehjJwtI0vC6mc9c5DNE
         7zGPLvGOXMyYMBMUqdITxNQCWI+L8wKbK+0qcfv8g06G0D2+VUvfKisuiyllFQsUl1+o
         BoAg==
X-Gm-Message-State: AOJu0Yyu7v5p3O13cxxwF51VvRWH1/0pPuDidW9m3/GoTy3Z8lm4XWGQ
	nUVNdGr25dBYG6b6yk+NobKPDfymOfSSnZ4UGqaVA3Ygj2PDYzEblhzLE9pfV95BhEkt++j5txR
	tLNzK5OQYDlMAlzQ5cTa7M4Ilj2FTraHR4hC/SRxb6fMa1Alb1mzuXA==
X-Gm-Gg: ASbGncsjOdtE0iyc6ClSaObGXQAdlEr0Ce9tsUBLoJUwELcQc4f5+ajL0JUsAHtLtJv
	By4eAJk1dW3UvdMoG21WMY6yLyueZJW/JJGIOPzmvqSZ/eIRzWerDBojD5k5HT4Yvn1dd+oK5Ns
	JYLLCa9yHw04at9waJKlJDlBHvzjSU1dqExY2wIVCHokVFKm1GH+wbiNZnnajZZbvTzQQZfgaUR
	kSgS/JeuGsjF5aZOoFpMEY5BhPAbPQGGTDKFqStbhiivDhGvHHk0KyPyn3wA1QpckR7gngiqcvG
	APnx327E
X-Received: by 2002:a2e:a58b:0:b0:30b:d0d5:1fee with SMTP id 38308e7fff4ca-3179bc5a05dmr7796831fa.0.1745488180137;
        Thu, 24 Apr 2025 02:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzaS2HNlFJvw5ko35RTjMLg6Qm0wxFXoiWEmoRU67WZ8iXr5MiwGheXascUkqg9DxvWOVcNw==
X-Received: by 2002:a2e:a58b:0:b0:30b:d0d5:1fee with SMTP id 38308e7fff4ca-3179bc5a05dmr7796651fa.0.1745488179726;
        Thu, 24 Apr 2025 02:49:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cfb484eesm1960951fa.41.2025.04.24.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 02:49:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1EFB31A035E1; Thu, 24 Apr 2025 11:49:38 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, Arthur Fabre
 <arthur@arthurfabre.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
 hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
 lbiancon@redhat.com, ast@kernel.org, kuba@kernel.org, edumazet@google.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
In-Reply-To: <aAl7lz88_8QohyxK@mini-arch>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
 <aAkW--LAm5L2oNNn@mini-arch> <D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
 <aAl7lz88_8QohyxK@mini-arch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 24 Apr 2025 11:49:38 +0200
Message-ID: <87tt6d7utp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stanislav Fomichev <stfomichev@gmail.com> writes:

> On 04/23, Arthur Fabre wrote:
>> On Wed Apr 23, 2025 at 6:36 PM CEST, Stanislav Fomichev wrote:
>> > On 04/22, Arthur Fabre wrote:
>> > > Call the common xdp_buff_update_skb() helper.
>> > > 
>> > > Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
>> > > ---
>> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
>> > >  1 file changed, 4 insertions(+)
>> > > 
>> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> > > index c8e3468eee612ad622bfbecfd7cc1ae3396061fd..0eba3e307a3edbc5fe1abf2fa45e6256d98574c2 100644
>> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> > > @@ -2297,6 +2297,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>> > >  			}
>> > >  		}
>> > >  	}
>> > > +
>> > > +	if (xdp_active)
>> > > +		xdp_buff_update_skb(&xdp, skb);
>> >
>> > For me, the preference for reusing existing metadata area was
>> > because of the patches 10-16: we now need to care about two types of
>> > metadata explicitly.
>> 
>> Having to update all the drivers is definitely not ideal. Motivation is:
>> 
>> 1. Avoid trait_set() and xdp_adjust_meta() from corrupting each other's
>>    data. 
>>    But that's not a problem if we disallow trait_set() and
>>    xdp_adjust_meta() to be used at the same time, so maybe not a good
>>    reason anymore (except for maybe 3.)
>> 
>> 2. Not have the traits at the "end" of the headroom (ie right next to
>>    actual packet data).
>>    If it's at the "end", we need to move all of it to make room for
>>    every xdp_adjust_head() call.
>>    It seems more intrusive to the current SKB API: several funcs assume
>>    that there is headroom directly before the packet.
>
> [..]
>
>> 3. I'm not sure how this should be exposed with AF_XDP yet. Either:
>>    * Expose raw trait storage, and having it at the "end" of the
>>      headroom is nice. But userspace would need to know how to parse the
>> 	 header.
>>    * Require the XDP program to copy the traits it wants into the XDP
>>      metadata area, which is already exposed to userspace. That would
>> 	 need traits and XDP metadata to coexist.
>  
> By keeping the traits at the tail we can just expose raw trait storage
> and let userspace deal with it. But anyway, my main point is to avoid
> having drivers to deal with two separate cases. As long as we can hide
> everything behind a common call, we can change the placement later.

Being able to change the placement (and format) of the data store is the
reason why we should absolutely *not* expose the internal trait storage
to AF_XDP. Once we do that, we effectively make the whole thing UAPI.
The trait get/set API very deliberately does not expose any details
about the underlying storage for exactly this reason :)

-Toke


