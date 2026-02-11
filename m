Return-Path: <netdev+bounces-258308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE6JNVGvjGl/sAAAu9opvQ
	(envelope-from <netdev+bounces-258308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:33:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C8126259
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1EB30AD8D0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CF2DE6FF;
	Wed, 11 Feb 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbMlfzyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEC33F38C
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827387; cv=none; b=sS9PdvRYYyJS5JzJd5b1aIfoWZ6fXc5ffpIFY+PpoE3PUgLi/4OyhyL5cSB6AhrA1GUx7dUhcYjdXKHP7zzmKMIfMj7InnS/9UlPMFqqh5lSzJOOi+XIwh4Tt0fBLQoOQUBAEb3NGF9bkAa9LKaeMyJzJjyx1N7FjNqfzRqQadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827387; c=relaxed/simple;
	bh=cJVICiDTHaNQrF+kdKm16GtTojzuaRaZXTJkbLCQE1w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HBgaSOO1C1yVkc4KZ1EiTbgC1KNTORdidrkS2qv7RQTHZJ7pyrzyUtIXtymefrRqrCAKoPtv1PGfpOmunyxU/u/6Nn7y6bkNTLHU8UPc0HIQnokGGRlrzRqW/ocy6oceJC38C0SG+6WGjeuTQUKHUr5FJR3SG8qRe6Aw0JLlRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbMlfzyS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-796d0395828so3442517b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770827385; x=1771432185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQv05ILMKxllfl45z92SDOph56g77ozE9I5ricXOpDE=;
        b=gbMlfzySJ4rR5kRYi+LMBdjOIa/g3fBNl16RvNabN/CeIHLxceoDszcRH8stVIGpXg
         E0U4KyXXpyzLQtGTb57kIY7O+XnHw9+sJonhDDFzM83j1dvXOTNU/CJvwmXUZoLQDt9Z
         ZfOm73yz1Soo4FHjNR4yYI5h2FI1/sbaUU16h5lcNpITTjSIvI+0n+RBKK2EpZJ4ufRH
         T2WLZ9VU3vuDNhGyh74r1n5FxLzClXHQ/mxEJRUK+F/KKZQmUiDb0/tt3hIXagUwzCaD
         ry/zGbggTQYQeYwz121k6fr3gG5hhdG8pUKxuiOX3VGkePPd5dsAVcHNz1o7xDSv6AHc
         nnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827385; x=1771432185;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQv05ILMKxllfl45z92SDOph56g77ozE9I5ricXOpDE=;
        b=E32cKR59zULpLdLD1IQFG9HkNB4xcluBfCHJzN035mCcZvDmbFnMIlfGVNfCAsj3j4
         wPbDTR5TD85SXzXA/9TiNiplJaJp9Pi4GNa3MM8zsowCIfaIZ6voKlkjtms3pvQhBRxU
         4tJmvuoqgo9+6XEd5XdsXbkKC8fZ02+uaHayEAXRm4kc7c2CpSstLLb/ZIBmkOlEDHLf
         qBmu2sZS0w+8sJ5jfckESx2zt8rwL2f42koryFGv4+1GArPx/Ytphp4v72cLCsXXxxOm
         GxtxTrHWdP0RkL2L8s/FfzkmtyLlISItVQLhvqzNbJiinMqB/5cw+f9mCWLSKQgl24k6
         tbjw==
X-Forwarded-Encrypted: i=1; AJvYcCVrJsnVnuV0jIFGEBGM9sGUK32VYg5UT6jZxSd8ijJ2tILKa2mhracBzhfH7GKf5kUSOJJImKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TTE6pKmk7vc9xI3D0rzBSd8aKaWLBKJl4nIc+P+uuAw8xF8J
	+jc6pgbYjeOiPUuy/9mzp9Pj5G8sxUmrFuwJYb9SdJwXQI1l0T07nXeD
X-Gm-Gg: AZuq6aIIIv/Ztiy/a7dPuEN8rWp4fjNvc0pKd7cMcocRcss4OA5xFMv4A6Bayz/uY10
	OKt4fzLjYQv6rBkCg8AxWo6gsbUz4wS13jcqAwVLdx7Pf4OXMk/VN4vd1C5p+1pU58DHzLe38aD
	61pEq9yWyUcbQvVaeux6BnsI8BoO7wxE3GYo59uRgMVNslsGICbvb7tjmVHEJvHFpWFf6vR0RE2
	4/rEdxsQsZbSqNYmzWLpPUh34zG62BLxU9lXhuFbo9Rdqb3SgBTOBZQpgGSP67DoaJBV2hmZoQS
	nCX2QP1TU8uwRsjBahBj/jZQYKOIcgYgG6t+d5InW40217+54CjZMOlyAwAkwsR+y+sIujIcXBm
	Cny2mtUppmfJpGYb7EyQkVnMYIupN5dSLc0BvN0k9jVk+UK4t1HBXaz8ashdEjt4tf88T6qsXhn
	q97UJ1Y33EkyVwJ9SmDlCleBF8TZqAxW+TLi29ItqqJ4I8k1+wfxpBnEuW9kLs44R25BznyGU=
X-Received: by 2002:a05:690c:6602:b0:794:d887:726e with SMTP id 00721157ae682-7952ab3c507mr154210237b3.57.1770827385211;
        Wed, 11 Feb 2026 08:29:45 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7966c16e7c6sm21293957b3.1.2026.02.11.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 08:29:44 -0800 (PST)
Date: Wed, 11 Feb 2026 11:29:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <willemdebruijn.kernel.2759f838d176e@gmail.com>
In-Reply-To: <87qzqr5vos.fsf@jax.kurt.home>
References: <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
 <87qzqr5vos.fsf@jax.kurt.home>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-258308-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 501C8126259
X-Rspamd-Action: no action

Kurt Kanzenbach wrote:
> On Tue Feb 10 2026, Willem de Bruijn wrote:
> > The core issue seems to be that the ptp_tx_work is not scheduled
> > quickly enough. I wonder if that is the issue to be fixed. When/why
> > is this too slow?
> 
> The igb driver uses schedule_work() for the Tx timestamp retrieval. That
> means the ptp_tx_work item is queued to the kernel-global workqueue. In
> case there is load on the system, the kworker which handles ptp_tx_work
> might be delayed too much, which results in ptp4l timeouts.
> 
> Easy solution would be to tune the priority/affinity of the
> kworker. However, we have to figure which kworker it is. Furthermore,
> this kworker might handle other things as well, which are not related to
> igb timestamping at all. Therefore, tuning the priority of the kworker
> is not practical.
> 
> Moving the timestamping in IRQ looked like a good solution, because the
> device already signals that the Tx timestamp is available now. No need
> to schedule any worker/work at all. So, it'd be very nice if
> skb_tstamp_tx() could be called from IRQ context. BTW other drivers like
> igc call this function in IRQ context as well.
> 
> Alternative solution for igb is to move from schedule_work() to PTP AUX
> worker. That is a dedicated PTP worker thread called ptpX, which could
> handle the timestamping. This can be easily tuned with taskset and
> chrt. However, there's one difference to the kworker approach: The
> kworker always runs on the same CPU, where the IRQ triggered, the AUX
> worker not necessarily. This means, Miroslav needs to be aware of this
> and tune the AUX worker for his NTP use cases.
> 
> I hope, that makes the motivation for this patch and discussion clear.

It does thanks.

I think we should look at the locking. It is not clear to me that
sk_callback_lock needs to be held here at all.

From the lock documentation itself its use is more limited.

sk->sk_socket->file is indeed dereferenced elsewhere without holding
such locks.

sk_capable is another indication.

