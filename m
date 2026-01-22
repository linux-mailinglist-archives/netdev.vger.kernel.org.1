Return-Path: <netdev+bounces-252550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNaJNrekcmmMoQAAu9opvQ
	(envelope-from <netdev+bounces-252550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:29:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F0F6E273
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B64D230066AD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB683D726C;
	Thu, 22 Jan 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3XdaekD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC6307ACC
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120948; cv=none; b=hQiHKcKLV79/apksjqSWhnXT3QzZ5w+nxcS6XKB5LATiB0mBDDwhz4OcmF2fnIBWQ3K4yWb9l8hF/TcaIW/8jtaoF5LJ8g6CAKeW9dbsfS0BqtUlc9PBVWMjxoqtrFusHbdbH23uISzf9lkq0sjCWZ1XlttTKLHon0ESboGfbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120948; c=relaxed/simple;
	bh=vcTWFVkjwdkfvhISGpqBq6oJa0i9lDbSWwFlogzoGtg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OI8D4oLz05MdCmVY759OLCFa6DrQTf8jpjXDhD51eWk57CvdAjzgKwm6joDd+GK8fZUdhv1sZFavs9wiP4EFFHlAmmpXEfWz+9fO89/MbZK18v59/mTde5uVIAOs7mx9s4tfoavM0ZqJUaSwpG2BujEw0XhQrg/RdKTur1oQDZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3XdaekD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79274e0e56bso15800857b3.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769120940; x=1769725740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVevhxX2S1Ysnf/5jWyTArZndZLi78xOkzKIFBbUxwY=;
        b=c3XdaekDwnuhub/rQ3hB+2xW8j/hbKPZ01X5uTXdYg7XzvSGjdBRhYw5+qiWERMNe+
         U1GPZXKv9yC51a0igt91BkBoC9XNFZ9giUzgdzqzQCvc3ThvmbMIj2/UFxBm1p21mD9d
         sO7oq4vV7k44zu+PyQ1sSe87ENuWQGXhcKiIt61mlBtiZCJGGXaWdlVIdTUiuMZiUvLv
         5Rnlsoe7rEY0iXbYHU/hum1C7GcpZyztPS3VbP2fm8buRx0zGTNkxPdZvDYtrakGI53H
         8KmzonpFWbaSf02UpLELPNt9vi+zWdEXHja76iSBueVorLk5AAH37CkUZk3vDcBz4O8Q
         oLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769120940; x=1769725740;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVevhxX2S1Ysnf/5jWyTArZndZLi78xOkzKIFBbUxwY=;
        b=wzxy7qP5EOsUoa7/NfII/6JgHvN4P1XvsiRXaAF85L0m+HKxWlxXi9be58ysuIIddM
         bi82qWmOjOKzC47OxIl0kRcSd36gnZw5Qlzt1NKwP/w3oQYrNzqE0kqa3q6eooZdPDbk
         Sq4aKbxUXK/OIurJDedoBt6KSPwL6Da1iFk8c7pzz/ECl4esGLiE1prYUzIJYD/zsw7A
         kAbOmr1JSk2k0dNmcyHIVeFfWFW43CAqMKqT7pKR4rugOw9OBGTftaRcM0UH6cLKUoO5
         s/HUQ0cgc6p+msuvd31DQD/7H6isBrkHcgMyRrZm7OrDD0UHAKZOz8LJBTVFm3cVOdAN
         xiyQ==
X-Gm-Message-State: AOJu0YxOt6IOLmKKmM9UQA89/9bEbBUPI4MEgRluRspPeVEMw2gQ3FhI
	weBXYhPjEcXXhP++JEieoSJ8Xk5GoG2xS5pg1XOBx26hjMHX2eJZXWOM
X-Gm-Gg: AZuq6aKk0sBNsx3lqcUgq6aIZyffFzM3c8BMiC5fzDBbR9fr6s39BoC/WIbOHloj/r5
	EutbACKPC9UyzLt014uDeuOICi4c5Hj6kTsVLFfGnkydO7IB417UMpxN4Z8vwM9D67ejs7GeaEZ
	HFXOSPnhw7Je7GPTDaG+QT/wCC92AjjWzZhO9SgC5dTk69SOuvrzN1aaKxno3djhNTD75XVTOpb
	upu6R0ntIuBM55OLMdBA+N70HGw9Buot8btJBKNXkKg7/2GtIoUD/8RmyLFYuDzvSETnybWFPia
	OGmhP/lKXa4wugie4GCaNFDbBvnYedBVNzzJCYhkPsfnMef2GsTiNMM6ZoW6o+A/ZryZNTs7LEC
	N9V8PZKqriX+RSie5/5dZ/OSqDlCMfjtP0UuteYwq1dufi+2uMJvJyQIyudAKH04ltiY2GApSKW
	YLjh5u3ay55Wb/mkKF5Jy19ku863KXtgjd617bXp5gU6B+Zk0HUCC5RtLmqwk=
X-Received: by 2002:a05:690c:389:b0:786:5afa:3751 with SMTP id 00721157ae682-794399cf83cmr9288467b3.53.1769120940357;
        Thu, 22 Jan 2026 14:29:00 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943af13d6dsm2743027b3.9.2026.01.22.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 14:28:59 -0800 (PST)
Date: Thu, 22 Jan 2026 17:28:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>, 
 Kevin Yang <yyd@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Miller <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Joshua Washington <joshwash@google.com>, 
 Richard Cochran <richardcochran@gmail.com>
Message-ID: <willemdebruijn.kernel.13b62cc180aaa@gmail.com>
In-Reply-To: <c5ba02dd-e81f-4590-9e35-90c9b2c33bee@engleder-embedded.com>
References: <20260121160458.990785-1-yyd@google.com>
 <20260121160458.990785-2-yyd@google.com>
 <c5ba02dd-e81f-4590-9e35-90c9b2c33bee@engleder-embedded.com>
Subject: Re: [PATCH net-next v2 1/2] net: extend ndo_get_tstamp for other
 timestamp types
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,redhat.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53F0F6E273
X-Rspamd-Action: no action

Gerhard Engleder wrote:
> On 21.01.26 17:04, Kevin Yang wrote:
> > Network device hardware timestamps (hwtstamps) and the system's
> > clock (ktime) often originate from different clock domains.
> > This makes it hard to directly calculate the duration between
> > a hardware-timestamped event and a system-time event by simple
> > subtraction.
> > 
> > This patch extends ndo_get_tstamp to allow a netdev to provide
> > a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
> > driver to either perform a conversion by estimating or, if the
> > clocks are kept synchronized, return the original timestamp directly.
> > Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
> > a use surfaces.
> > 
> > This is useful for features that need to measure the delay between
> > a packet's hardware arrival/departure and a later software event.
> > For example, the TCP stack can use this to measure precise
> > packet receive delays, which is a requirement for the upcoming
> > TCP Swift [1] congestion control algorithm.
> > 
> > [1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
> > for congestion control in the datacenter." Proceedings of the
> > Annual conference of the ACM Special Interest Group on Data
> > Communication on the applications, technologies, architectures,
> > and protocols for computer communication. 2020.
> > 
> > Signed-off-by: Kevin Yang <yyd@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Like Jakub in his reply
> https://lore.kernel.org/netdev/20260119115710.6fdde8c0@kernel.org/
> for me also the question why this is a driver implementation came to my
> mind.
> 
> With vclocks it is already possible to get timestamps for arbitrary
> clock domains in parallel. So it is already possible to synchronize
> the hwtstamp to CLOCK_REALTIME, CLOCK_MONOTONIC, ... in parallel.
> Therefore, user space synchronisation is needed, but e.g. ptp4l does
> a much better synchronisation job than your solution.
> 
> Maybe CLOCK_REALTIME is not supported by ptp4l, because due to daytime
> saving this clock jumps. IMO these jumps will also be problem for
> your solution, as it will lead to wrong delays two times a year.
> So usually CLOCK_TAI or CLOCK_MONOTONIC would be a better choice.
> 
> To sum up: IMO you suggest a driver specific in-kernel solution where
> already a driver independent user space solution with higher accuracy
> exists.

Definitely a promising alternative.

With multiple netdevices, a TCP listener socket may receive packets
from all devices. This would need new infrastructure to lookup the
correct vclock for a given net_device, cannot hardcode a choice with
SOF_TIMESTAMPING_BIND_PHC.

And this needs to happen for every packet, so with minimal overhead.

Though for established connections the expectation will be that
packets generally arrive on the same netdevice. Bar infrequent path
changes such as from sk_rethink_txhash on the peer. So there this
value can perhaps be cached.

It would still have to be learned by the kernel, no explicit
setsockopt.

