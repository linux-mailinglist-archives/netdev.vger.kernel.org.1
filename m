Return-Path: <netdev+bounces-291388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKpBI5OHFGqPOAcAu9opvQ
	(envelope-from <netdev+bounces-291388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:32:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D92675CD642
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AD3300E728
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CAF274FD1;
	Mon, 25 May 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxV51+2D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BE1429D
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730318; cv=none; b=ARM7dKapwyv5il6INz8pWXAONfx2pnplDJjrxz2bL/qNRL+GQzOEgFO05VgIf5UTpBMPNqr+Ac0jMdy8fTJ/mQ3vlrTQu3GR3XQWdP8dpDhc7pyEr1GKMrOR+XEtT9d/phZ3cNCVMq9JwKDuTTsR6f4tHVX702z6YkpEufaH4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730318; c=relaxed/simple;
	bh=WzdSh1B+2qm67QydYdUWnUTv+HJ49Td2uHEwz5Mt8Zs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r5NXpe8UD1gV4kRzTRbImMHvJ+aqWfQfdSS/WgnvogxYqwKylJDzQPcEpJYbYmQZkYOtWxXBylzvvH2u7tagjhF++tSY3mzn8W1XqkuVJG4vgaPt0nDpNzZ7sdjUFokhaqLuA45/sAxOaP3bHIazJoOQiPCIFPvpHAQ2iqQcY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxV51+2D; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7cb345cb5bfso77016767b3.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779730315; x=1780335115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG7IEgFs/m1oFs1/lf3+pd8kkR0y0NNeYlLItnr/YTI=;
        b=hxV51+2DAhw75Ua02ayLeC5ZdF5p7aCKykbK2CfIhyP37OiL5AaLtjDIkViN7b34/3
         p3IB6f/hQy7TAu2cvFPdzbZYMTgyXwcywhoK4ANru9Ao//jobh59FxoGzGgodj2mj2n8
         SPSLqze/+GC4+x8u/hWvq8x7qc0rh6fB7Dv+cNz9Os6SxgWJN8yzerGzKJ8vQCe8sK3s
         X6VaTQUhZYBmuZGnwVVYBbpuTWPOVwcTJ3HMml//VVeGxO8ht99h6a7/os1dr5ZG9OLc
         fZWsiB49MunnUBUDfngpE+vqwO3EaiK4aFcJX45CKRQiuY2kIXWIVHS9SCCnVGo+PeQY
         wq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779730315; x=1780335115;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HG7IEgFs/m1oFs1/lf3+pd8kkR0y0NNeYlLItnr/YTI=;
        b=fQZZ6zrQ7FTqqEbu6kRp7tysq69GTTwOiW9NrPh+6/h2ojVxeGiaGOoNHhquQnAe8b
         l5inZUoekYpNO7bjGnKmUCz7WPWXIXJfREK09Y04LTw0Rfhr+fCQq++BwUazSUBryZAN
         31tmXwIGjkVokNTYVin22FkoGhacOWwb2VscQU3fSY1uHnx37F8DRkSnjyanjoelcnPB
         d2jsIuEtEqn9TuZJIIU8dDgQjYFXcIHQ1NBuKCLmEkCZfhpX26/grcwVFWfA6gTn9bNI
         Cv4dJr5Fco9jQSgU7IgOBegWoPGvDkptqiIoY+WcS/SlPYGfx9qDzTnUYADRR47I6x6b
         NByA==
X-Forwarded-Encrypted: i=1; AFNElJ9cQ5rsS/9y7WUIR+fftuxFmMd+3lnMjtThnkUo4e3kQSkuxsOQA/yWKDGgVysr6W6DZ0atrE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqiGYE2dfGY/QkmrUg05Cyg1FHPuWBVsIXlU97Qlnbn3Ym7psJ
	yCEBN0bC2xDRBzpGoOz8Tr/f97gucc+OKOaWu8mV6iFKlCWukyE0GyyM
X-Gm-Gg: Acq92OG6379s74Bk9XXLrdpUlY722W5shcGuEgUx58XyEt7MhNEfJCQp7c/YQyAQzHP
	t8ve57cqgXFpQCC/IlzZm7a9R/UATDyEPOln/ydRiCtt/KB8vTqdSzu6EFg31IP06EJYMgaey7+
	8GAbNy8MrPe+J9Z/21iFwg1fiVlM4DrO010XFXC0M/e3pQs0y+81uHZmbtKvVNJ61WJM/ihOapO
	7+l4KjoijONw6Fck9dTuQXHXwoeQrzP9XrldA5X32JZwNWASgNW43jTPhctUVYyAHmEwH6jz7+8
	EA2dUc0YU1WifAWnOjPHSJ+hTIs0VcxUsye1mRn22IXEdB7Ikdo+N/4RBY5gRF7cEWykKwQfZ7w
	LS+o+kast+vErHqF7doo8oUWfr+noU3+yzAVISCNeJDqkP4aQPgjWPvth1pmLuIjCFhd9OYg8oe
	rKyY7TnQlaZh8zQiZ7jUu/dXxJkRWLqgGMRTtLqpDdD4x4a2p89ghe3cAPLrL1CZnXCBR02Ufu9
	0ZF0JA=
X-Received: by 2002:a05:690c:968c:b0:7d0:354c:6594 with SMTP id 00721157ae682-7d3373ac29dmr173365357b3.33.1779730314707;
        Mon, 25 May 2026 10:31:54 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c435b54sm48694267b3.40.2026.05.25.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:31:54 -0700 (PDT)
Date: Mon, 25 May 2026 13:31:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 lazyming <minhnguyen.080505@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 w@1wt.eu, 
 security@kernel.org, 
 linux-kernel@vger.kernel.org, 
 lazyming <minhnguyen.080505@gmail.com>, 
 stable@vger.kernel.org, 
 asml.silence@gmail.com, 
 achender@kernel.org, 
 mst@redhat.com, 
 jasowang@redhat.com
Message-ID: <willemdebruijn.kernel.2a4ec672bf2d7@gmail.com>
In-Reply-To: <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
 <willemdebruijn.kernel.27d7990b24613@gmail.com>
 <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
 <willemdebruijn.kernel.9bf2a08cffd8@gmail.com>
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291388-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.455];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D92675CD642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Willem de Bruijn wrote:
> > > > lazyming wrote:
> > > > > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> > > > > the old skb_shared_info header into a new buffer via memcpy(), which
> > > > > includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> > > > 
> > > > These functions are not supposed to maintain zerocopy frags.
> > > > 
> > > > Both call skb_orphan_frags.
> > > > 
> > > > I think what may need to happen is to invert the order of that call
> > > > and the memcpy. Current code:
> > > > 
> > > >         memcpy((struct skb_shared_info *)(data + size),
> > > >                skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
> > > >         if (skb_orphan_frags(skb, gfp_mask)) {
> > > >                 skb_kfree_head(data);
> > > >                 return -ENOMEM;
> > > >         }
> > > 
> > > Never mind. This actually corresponds to the first Sashiko report you
> > > mentioned: if zerocopy skbs are converted, then the memcpy prior to
> > > that call will have stale state.
> > > 
> > > For skbs where skb_orphan_frags does not do a deep copy, we do need to
> > > take this extra reference.
> > > 
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > 
> > Not sure the potential preexisting issue is reachable.
> > 
> > Vhost-net and other zerocopy that predates MSG_ZEROCOPY does not
> > refcount ubuf_info. Instead it calls skb_copy_ubufs on skb_clone.
> > 
> > So if such an skb reaches pskb_expand_head, it should be guaranteed to
> > not be a clone. Same for the carve methods added later.
> > 
> > But, the commit that added zerocopy, commit a6686f2f382b
> > ("skbuff: skb supports zero-copy buffers"), included this 
> > pksb_expand_head call to skb_copy_ubufs from the start. That implies
> > that was expected to be reachable. I just don't see how yet.
> > 
> > If it is reachable, then all that is needed is to clear shinfo->flags.
> > Or more neatly,
> > 
> >     skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
> 
> Also, I'm not the expert on more recent managed frags
> (SKBFL_MANAGED_FRAG_REFS).
> 
> That calls skb_zcopy_downgrade_managed in pskb_expand_head, but not in
> the two other functions with memcpy before skb_copy_ubufs:
> pskb_carve_inside_header and pskb_carve_inside_nonlinear.
> 
> I assume because those shorten the skb, so no risk of getting mixed
> mode refcounted and non-refcounted frags?
> 
> In general zerocopy can be split in refcounted and non-refcounted.
> 
> Refcounted zerocopy will not downgrade in these cases, so will not
> modify shinfo->flags after memcpy.
> 
> Non-refcounted should always get converted to copy in skb_clone,
> so will not enter the skb_cloned() branch here.
> 
> If in doubt maybe warrants a rare WARN_ON_ONCE patch.

I was unable to find a path also with the help of Gemini.

It did spot an interesting case where a cloned unrefcounted zerocopy
skb can be created. But it is reduced to uncloned immediately.

skb_morph is like skb_clone (calls __skb_clone), but skips the
skb_orphan_frags check. Its only caller ensures that this is safe.
But I'm inclined to send a patch to net-next that makes skb_morph
itself safe, by orphaning as well (and updating the caller to
gracefully handle skb_morph failure).

