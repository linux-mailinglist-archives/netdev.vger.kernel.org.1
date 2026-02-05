Return-Path: <netdev+bounces-257315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAQwD3QOhWms7wMAu9opvQ
	(envelope-from <netdev+bounces-257315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:41:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE0F7BA4
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395593010BBF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE062331A5E;
	Thu,  5 Feb 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdkJ+oKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4E331A49
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327665; cv=none; b=N0eJOcg+EKZbiy4RDAbf/JwRd9EO2WC6Ko2+RObvH6dwTC2dGGHrHZMhUhnsta7yFs1odG5Dd1Tfj9ARqGjIoDGM+u7OaKQvI8LffhLwLtNlJPzrB4gWoWbvIuuEYlQnQfhhz+Kwk/KbjgtnqpWPbAbERTNqhp/7Nlrah2r+k70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327665; c=relaxed/simple;
	bh=xMi3TMTzHre49/W9FbMfovBthku/tyd5plmAYzO1SQM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mzW/7LHmX3oX3vWr4cDbU9MLdNVZ+NIDNYdT4KxlcqQ6cJMC0tZuVUKxv+rfUS3WWKS8jlUIwD96Oyxm7ZKdg9B2bA67VdWKO1lrCqlLP3BEGyw3ICA0frmrH1k1+YBVGPZTw3T8/oe5FNlZIzwpKIcI6+rUuAUqsJlw2zthCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdkJ+oKX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7948e902fadso14230887b3.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 13:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770327664; x=1770932464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMi3TMTzHre49/W9FbMfovBthku/tyd5plmAYzO1SQM=;
        b=IdkJ+oKXF5tiDoHH15Jk+dJseilPeu1z+E+73N8p0gEfA+4PpEf7ojp3YBhg7v4uux
         395vPG1SkZmgfvfgVUoc7iFW6nMgr7D2GkIP8rYUdFHVVQNb0Q8ML504js5cxfa0mx/L
         FnpjkccpU5VQW+J423tcEnvcfqq9nG+veEmvkujkSitDZB1zP870uUSmQwUdLlZnhIfw
         fpNCb37d/5wiBVzeMgyTRwXn9vrwlmUb3nmFvmE7g4TKYHm+PDxle+/eiyalLoOG6rJ2
         JnE/mKgNaZTH/pstbOKBO2Gwc7r8kPCdZuNygMVWGrJjBuDDejw3NE2GKW8nxvbYUOfG
         H5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770327664; x=1770932464;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMi3TMTzHre49/W9FbMfovBthku/tyd5plmAYzO1SQM=;
        b=TlTHPHNW42S/9TqD0iki/USXUcQ8BbMjUItNgoYAuykCumx7qzfOz4RIsMTI14RiCV
         aCK1Wbhnt1aSbUA/d+aPv6M/JuLiYAZC+XrkqML6DhtneBvXFKg4tDCtIGQg9lGeU/95
         wwsh7ARhDYA3lYknD+0JFgUUsJRUrFiPytZu8xRMm9KRNd5pvuS7RxlfNavpjBT/BYbG
         Sov/+ZogdQMCbI9aDS7ByzhIobK+LDR7o+WpwGVrO5SMC8d6kZ365dGDDZt4/ZjCobgf
         SBf8cubEEF52zgw8EBd5rQeqpz8U5JfDUxIw2tZusBLMuAU+RoLQshdEa1a2Sa3ZxqXJ
         +8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU5C/HUVXRtsMm2UMl4E3iy4ZHlRw80INDy7Wry5OehxTMa8RJGczAY77KodxmJhmZxtJBISEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUupxC2HScU3FBm60UHKFaT3BksF5Guv94ym2xgi+8+7b8RbsI
	i1VVHENsuTzeMmYMnxtM73nie2cbUK+trmR7zvR3vsDZsxTjkoAvvk4D
X-Gm-Gg: AZuq6aLG3zWVusisP31ZMFmcuUk/3TH4me4nH6a4rXHjC+/BaQcj5tFk4m7XCposvJB
	kHb/FMGGiVZf66OLgqb/hhPgr76kQGfntEU54CGLOk/DROdgajkQ+xYKaabC2YPB1w1BhU92MNj
	1BDAc+CHbqaYMu84XbIdara1U7bHc3yNR+ii5kV+NdwAKq/L0c9oynLg7r8h6IQ2igPqiYr4SkW
	faxx/hVP79C0C0r5V9K8fjem4K1Wr0X6O6s2N9cpF3sGTgHhnBqNmXM9vXlPpV6tfQTwBC5W6bG
	rbq4Vtv3Qd/HTJqI2JxjsazQHrbIpYrOK8kotJ+JKshngXMUL3w9DJtvNs+zaz5/ZLjgdbgZPPx
	0A3/UEz0a7UWNcJ4/dPqW68E2FGmtLelZfFaYCVqeXKhBEnKOI8XJile/PvST+P6XwBI/FWVL8t
	TysGJhtUYFO85o727dy7XEH0GkpuQ2lNkoxjq3aVQhg4uWoXgtF0D83dUWfwA=
X-Received: by 2002:a05:690c:67c2:b0:794:84c1:9c9f with SMTP id 00721157ae682-7952ab99bc2mr5236527b3.66.1770327664378;
        Thu, 05 Feb 2026 13:41:04 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7952a246cbcsm6412237b3.46.2026.02.05.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:41:03 -0800 (PST)
Date: Thu, 05 Feb 2026 16:41:03 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
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
Message-ID: <willemdebruijn.kernel.459b2672b1e7@gmail.com>
In-Reply-To: <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	TAGGED_FROM(0.00)[bounces-257315-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CFE0F7BA4
X-Rspamd-Action: no action

Vadim Fedorenko wrote:
> On 05/02/2026 16:43, Sebastian Andrzej Siewior wrote:
> > On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
> >>> So the only thing that bothers me is the read_lock_bh() in
> >>> skb_may_tx_timestamp() which deadlocks if the socket is write-locke=
d on
> >>> the same CPU.
> >>
> >> Alright. Now you make me think whether we should enforce OPT_TSONLY
> >> option on socket which doesn't have CAP_NET_RAW? Then we can get rid=
 of this
> >> check, and in case sysctl was flipped off - drop TX timestamps as
> >> it's done now?
> > =

> > This would "fix" this problem for all users which do deliver the
> > timestamp from their IRQ handler instead of napi. There are a few of
> > those=E2=80=A6
> > This would be considered stable material, right? (despite the fact th=
at
> > we have it for quite some time and nobody complained so far).
> =

> cc: Willem as he is the author of the check introduced back in 2015.
> =

> But it's more like a question to maintainers whether it is acceptable
> way of "fixing" drivers or it's no-go solution

Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.=

