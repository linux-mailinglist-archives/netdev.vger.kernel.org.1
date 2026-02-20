Return-Path: <netdev+bounces-259779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC2wHOvWmGl+NQMAu9opvQ
	(envelope-from <netdev+bounces-259779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:49:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131716B0FA
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2CCD30089B3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFC2BDC28;
	Fri, 20 Feb 2026 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs2Uylpj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225511C84AB
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624167; cv=none; b=VppWSbq60LFHTnzEDb/ec52qL660MWyNM9+b9fliOfxYeGOGLY72LVcp2R2gJir61REYUuYiF1FjjlmL6+DDERaNRMyaieGg+H2TlN6ggiPMEsJw8Ona/wCJbjScBH7P7zbQzNe6pyX1dCy4s2YwwPTajqUeTaa/RyvR/4RYRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624167; c=relaxed/simple;
	bh=Jg8Yzha08pRaidg9Jkw9kbUT2oM/LXBKW8Oqoz5WC9Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Mt60pxC27kf27XNNGlBx2r2GWdE2CBc5vZ4bVC6qaVLWEHDrjg8udRwt5jFoCUOFphhhHGYD4Jl8RvXESX1g1v4Q10YP5ICT+gr2Ju8tH0E2GGed8TcYiZFvsD4HcR1rrzzcTNulxFFaKD7FgTJl5zomtYqC58uVadw8BRvPhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs2Uylpj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-797a52d8c34so24648207b3.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771624165; x=1772228965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/QDaPHkpXswmwJZmoCkz5JHjOMwGBj+P+wPLhK87M0=;
        b=Cs2UylpjzewUJJr2MVgC3kLvhJOQp0LUkuRs+u53rDtwlwqyQ2ojgg8onPMWEi7fQ+
         dhLWarTBJKrbw7ELdXdWaOgoUS+9Ung4QkyYcAX1bMtDlt2xcvyrfNYI34MjJVqxAKpR
         wlD80V43heEfVOetSmsuaiX9xLDekqE3j22NWvc1aiUJ+4ndCIRQTZ4RGDkHczp3fkI7
         S9HaDYVZNl1rS1GEIhFvu1Gu/98mDp1jZZL3p6PTlpATfFAi7Jr1qsksghUX5WqF4hOY
         09Ig/AOGu8XvAJ6IHrWzd7l7qKaM1xai6Wqzm2hhEhqL4QWKrB1dICPLww0VY8TLqvbu
         +hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771624165; x=1772228965;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/QDaPHkpXswmwJZmoCkz5JHjOMwGBj+P+wPLhK87M0=;
        b=g7mjDd7HajBgtgBuF80w08o6YAOUnMwsSoGCEE5K7pwNtpAAByWK1BU2e+kIcSTGwW
         IKrCaSrrOysjXrEVEo+I9eMd54QsSRqsy1vEFYtALJsjUcbsq7gjY2I5H7w+Szm1Fzd0
         H2XX5lrae8Qr+Ok+5cltM79aEMuPq7hpPM4vJkscJvQdESdA6pcnMgdtww2LPLsjt5q6
         YO0dodMOSw0tCXZMo+tRh19FonZ6bcJqLjk1P9z0I/uQ4bjrGFuWSzXfBawJqjz3SgH3
         K6XHZpin/7RASm7V/Dhp2hsu4cHzhf49jE1FrKjSJUwQSS/goZCbsqcYH7OzIAgLFTTU
         rbtw==
X-Gm-Message-State: AOJu0YwPxLoVaTA+DN79AovGFhfCqRwOruaTXgY1t09nkaPo5sHaNChl
	VKFSEhUwjJuq3qr4e9PuDpsDI0v50aXeaaacHoPNu+ZJl8j28/36NaB/
X-Gm-Gg: AZuq6aKsHfSQdEXvep9ZxZEn99CZQc05shajmJZP3J2FXTiKSE8mz+SzNsYCeDWb89N
	mCxKNscR23E/+G1KazcCTa14HjdvNNWuPP6oDzcWfGJ7BLppKgJMpbSv1Oznq2RafSOt/koCFGk
	3kTYInRuxiciZPhGNIQdOZeD8SRr7Tv2vxthnIVTUCw8DvvAxoJrR1YZi+MffO082DRmQbnEnN+
	bpYDeInSwBLVl0K0kTknoWvZ6K0/Pb/YmqEliy7JPm6jG4THzGTjz3xc+bk8wjw99a6Y6Omo2IY
	k3fMHxElkzocHdoRnZRnonFgVDJQ6s2EVNd06qugtSVVaC4bgKFWNEvlM5WGlQUZVE4azMHFiUQ
	8C5HTDXvoW4I3wHBTlp0uUUZ4SAStQ1TeVVRShIoCRE7RxqjZ8bUdel4NxOeopiqTpr8TGiRCS7
	D1ppgwxnFhLokmRt8byKX47G3wqgUeucZvNAjD4uUsZj/6rOPt1XepQ7NSYd1uAruPUV7W144=
X-Received: by 2002:a05:690c:92:b0:798:25d:a4b2 with SMTP id 00721157ae682-79828f07424mr14745197b3.19.1771624165098;
        Fri, 20 Feb 2026 13:49:25 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7982dbdf23dsm1956577b3.21.2026.02.20.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:49:24 -0800 (PST)
Date: Fri, 20 Feb 2026 16:49:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.85c1623c5d65@gmail.com>
In-Reply-To: <20260220132932.1ed45656@kernel.org>
References: <20260220183858.N4ERjFW6@linutronix.de>
 <20260220132932.1ed45656@kernel.org>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,linutronix.de,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-259779-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1131716B0FA
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Fri, 20 Feb 2026 19:38:58 +0100 Sebastian Andrzej Siewior wrote:
> > skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> > not be taken in IRQ context, only softirq is okay. A few drivers receive
> > the timestamp via a dedicated interrupt and complete the TX timestamp
> > from that handler. This will lead to a deadlock if the lock is already
> > write-locked on the same CPU.
> 
> Fine by me, the fix is fairly simple. But FWIW I can't stop myself from
> restating that networking core is not supposed to be called by drivers
> in hard IRQ context in general. Especially when it comes to anything
> that may involve user sockets. So my intuition is that fixing the driver
> to use a tasklet^w work_bh would make the expectations clearer.
> 
> Willem, you don't find that argument convincing?

This narrow case seems fine to me too.

But I can understand if that would be a global rule. As it simplifies
reasoning about correctness of core code quite a bit. In which case
that would trump this. No preference from me. Clearly other drivers
are quite capable of making this work without requiring updates from
hard IRQ.
 
> BTW IIUC the driver in question was igc, and it did not exist for
> another 3 years after the commit under Fixes, which is another bad
> smell here.

I was wondering about that too. But Sebastian shared quite a few more
drivers: https://lore.kernel.org/netdev/20260217132838.kgRAQ87W@linutronix.de/
I did not bother to check whether all were newer than the introduction
of the blamed commit.


