Return-Path: <netdev+bounces-258178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RKzBEFT0i2kJeAAAu9opvQ
	(envelope-from <netdev+bounces-258178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:15:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351B120E20
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC2793056177
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C83431EF;
	Wed, 11 Feb 2026 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgCWxCe/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEB1DDC33
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770779728; cv=none; b=C/1OUi1/o55weWoUEBNW6o85dyUKRJdfog33LCTdCKiwEiGc1VkRLNGs5QIWAN4jHObl43/A9FnDS6+OLolRmMBc6VjVtS4im3O4umcsf/vZ17sFhcr+MzD9P+9GmS51Sx6Pf4m2fYix6HjE8w6gpK8mS5XeHdnQp3iu1As8Zkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770779728; c=relaxed/simple;
	bh=CubaCy2q/vH3vmqj2GEWg/58SLDZzFdnDviYPVj8jw4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=htxN7qo4DSCmJphns+bLc2i1W79/Ac0QU2+yUMmd6DQsH8X5LVTXipogLrws31y77CvtIVy7xif5BHZGP+HUiw/HU69ikkncD0b9rBmUOUHC87C5LfsCENqs64VRsDTmx4g2js0cUHy+2DpIAQTxmn1T4YOnhoOxHodRStaSg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgCWxCe/; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7964f1405a0so29143917b3.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 19:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770779726; x=1771384526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/Kun8U7WKzuxXDmQMrR/8BHXTmHZAM6eU4S5NSrMAM=;
        b=GgCWxCe/PIA5/wunUyLcV7o47ZbpF/jATQ6tTNozMwjqeXbTKmlXHHclvEWT4lAAhy
         pyB9NLJrkOp83H+IXyix/XnK07Q3H9nk+07km3sF73+XbCkQ/8CP+lFOS3FGFCECepx7
         hTxK5m77KAzx7zItR9GmmRx/JSsnCSUOKRmYb2Rsg7rZyIXDm6azHa6rjtY2q9+N3iH5
         3DNcnwUZdG0+eJHyKgbYWDjGDNcYj4Dh+gA7T30Fvj9eytkeuEkRx0YIAEUEDDaGT191
         1DkCDbLhUbNZi9oGkLINkDEpO+132ddoDJ5rGSHyIecG3bwYBC0grO2rPx+0odr90fzw
         5SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770779726; x=1771384526;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/Kun8U7WKzuxXDmQMrR/8BHXTmHZAM6eU4S5NSrMAM=;
        b=nPTeiyamI1fpQMA1oq9Q8kYun+3UcIhMxRpPb1zaFmTzWM/pBlbDhS67ycrwuCnMy1
         vxGn07sFHaV8fRL3vMkm4gQmiakRf2HN15jmlJKvj9vn0bN2kYJb5w358XkU1xvXQcaa
         gGr48FdIrens5NnDasxzX4qBE3nn35dNetrkls40gdRdHtd37x/SO1IOfzro3FXlsvKS
         prL7qBubnMHqvAYthxMYSg6rKVOO+++tqfjVJO7giClHKcXE+lSYcRnX0bI7SDRHGEd2
         wVB7DmLNRxsSrttTkwupFG2cbdLpqVYp92Y5LShT83stA75FUhL7LgP3TYUdiviu/TTu
         deaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoklSZkIuAOuLEf4Jn8tJKxCAEPMYRDnlwj97jWH3HcYiWOwWoPjg419MxcKlBPlJV/VeSOt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsY434tI7EHehjVvNa8oVnUBWiTgjRgBf8oc3cfiXFsnHmZvX
	r9zVdNyH+6T8Px6zIMg4PZ+NSGYaAHJ0/RMfE93OzwLRTKRgmxtuqPtk
X-Gm-Gg: AZuq6aIaBHTMsmzgCjSuO3brNjpIBs3uT2pO5MWdprPZLld4AI7objjf/boXdJE7b8z
	HsKxEvwGhZ35R/3Y9pnK7BqpJWcRSaWE1KxhdfbrwAQ38ZylxfwJin7D9RVXfK9PIdMzy+RzreG
	Og2saGGq5UeKvwskEcuErMSIdp3l7/GI/21hrRuOgQ4Bq4WleZcl0OpJmvbkzDmMroWIIUdC+q4
	4JsuRae5JRpJM7TRjnKD4Ds96mT+JnejC+/PvYV+CwFQfsWTkh65yJg+g5VDysqc5FaDSc99PQx
	7k8d/0PTx4hPhAuY7/GtcymZR+T9hB40aulSduUf55e8v/RhcQuXtDfGqFD7SKhdYCqjZa9NM8r
	Ic7Ze8OFFFZjq5NMFgnalaNOv2PTkm5BO7T/dSj8eFgnSBvH1joE6uLUJlJezJq3MnYIC+0H4MH
	RX1A+8YVQAqzCGoKwLiAode7OXR95fWnxo87ouFjmkVol9MKai9lma7OuD8Hh+0BeUoEhTDn8=
X-Received: by 2002:a05:690c:46c9:b0:796:3c5d:70bf with SMTP id 00721157ae682-7966a9b6d99mr10352767b3.29.1770779726214;
        Tue, 10 Feb 2026 19:15:26 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7966c2657aasm4802037b3.47.2026.02.10.19.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:15:25 -0800 (PST)
Date: Tue, 10 Feb 2026 22:15:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 donald.hunter@gmail.com, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.503ed4ace7bf@gmail.com>
In-Reply-To: <20260210175638.123782b2@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
 <20260207003509.3927744-7-kuba@kernel.org>
 <willemdebruijn.kernel.743811e01cc@gmail.com>
 <20260210175638.123782b2@kernel.org>
Subject: Re: [PATCH net-next v2 6/9] selftests: drv-net: gro: use SO_TXTIME to
 schedule packets together
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258178-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9351B120E20
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Sun, 08 Feb 2026 21:39:38 -0500 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > Longer packet sequence tests are quite flaky when the test is run
> > > over a real network. Try to avoid at least the jitter on the sender
> > > side by scheduling all the packets to be sent at once using SO_TXTIME.
> > > Use hardcoded tx time of 5msec in the future. In my test increasing
> > > this time past 2msec makes no difference so 5msec is plenty of margin.
> > > Since we now expect more output buffering make sure to raise SNDBUF.
> > > 
> > > Experimenting with long sequences I see frequent failures when sending
> > > 200 packets, only 50-100 packets get coalesced. With this change
> > > up to 1000 packets get coalesced relatively reliably.
> > > 
> > > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> > 
> > Does this require having FQ installed? I don't see any qdisc config
> > in the GRO test.
> 
> It's a bit of an opportunistic optimization.
> 
> I initially intended it for for the "long sequence of packets"
> test. But I failed to get AF_PACKET+FQ to cooperate sufficiently
> to queue all of the packets in the same bucket. Otherwise FQ "sorts"
> the packets, and breaks what the test is trying to do :(

I wonder what's going wrong here.

fq_classify should pick the queue based on skb->sk also for packet
sockets.

And flow_queue_add should add the packets to the tail of the linear
list if the delivery time is identical to that of the tail.
 
> Oh, and as mentioned in the commit msg - this improvement is intended
> for HW-GRO, which may have very low timeouts. The test already
> configures timeout for SW GRO to a very high value, so don't think
> we would gain anything from setting up FQ on veth/netdevsim for the 
> SW test.
> 
> So IDK what to do with this patch. Maybe I should just drop it?
> It _seemed_ useful, but I don't have enough datapoints to do a real
> comparison of how much it improves reliability.

It seems useful indeed.

