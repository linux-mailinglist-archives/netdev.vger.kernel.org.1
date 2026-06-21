Return-Path: <netdev+bounces-300920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pGVCO4NgOGrmbgcAu9opvQ
	(envelope-from <netdev+bounces-300920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:06:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637D6ABB3B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:06:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RoQTNfrs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300920-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300920-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A2F3009FBB
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E1E370D4D;
	Sun, 21 Jun 2026 22:03:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE62E7165
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 22:02:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079380; cv=none; b=KXpdWH8uwKtwHyoEHwRHX6lWb+Q9jJT2G4BuMkdsDM12hcAQYRtTsuoX5qr/aWWnNDaD9/yG8DTsSZ89sUYMB5iKDJFYYXglBEkJdPiKlvzvq8ndNUjtDJRoom2C4Qk/pXAIxKPCbYL1kuKTj3GaB/Eieh1ybpoZXNHonVijw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079380; c=relaxed/simple;
	bh=GotsuY2JtZy8Np0qCYeXbOELyFjEkWO+lDav4MKQc2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgfqbT55eLGx1TbvIQKK6RXMX3fz4wtq1IqugkjnFmOqvckxFI9SNss5jQVo28YxVyF0gAnru/fgX0RJDefvgnQhwqQu5mzYlgU7vvvOddqukMNuEzWUKMH5MIV72VF+85g00pgGIeL41U5XiTiHYnlsvrha5ja8ZGu421BFTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoQTNfrs; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490a76757e5so22910675e9.2
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782079377; x=1782684177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmNG9A3WEdwCXFa3vcLlptzdmDIAgfVPQr6/ZnDFWmE=;
        b=RoQTNfrsLlGmwBh8WVmmRF0Yyx8UyskNyDjVL5lIV0sHp/DFh68t/H9k3EC4ykblhW
         l89ricf6vyRBkaMQ7ixYza5gf75hrBCUyto9S8KBDSuXhgC4LXSRa6ysOSlfC2FGA3tI
         qt5Dq+8aYSDLWMAvNqQygHqrBaZYvacEZUPAiK7Y0cbL005mzBAYMoEy8nJuqPmW64M/
         xQm0rNgPpnKPRG9CzNUZWFdwbdLHDreswKxSEcH7YFi6caO7MOTkn9U2RUfbMWKOUW73
         Cg2ktkzT0hEzoHX7/Bi8yFeZJlPQ/0X4gO439f74pUX6bhx0B1Xv7mh1/MKqJij8CLTr
         XI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782079377; x=1782684177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmNG9A3WEdwCXFa3vcLlptzdmDIAgfVPQr6/ZnDFWmE=;
        b=UC1XiQnFFP0G+SSfVzcQs0HtcNkzF5B3JfpPYu9CZfWuqYIwGoFvtvoTgt3IvVBDvr
         Fz7w9JfJdg9ABJCN3AMYR2ol6x4UikKeWm/sFCZiGwfek6NOEl9Cg9KqC6CJynWx9fMc
         ZPtDYJLA5Lh5qoXBzmw0r5Py2xDoU6IvRSzynKRaVGKR3f38KoZFYobrVwpauJA81fYF
         LeA0tOAE7Y46tKiAaVZ9KZz0zpIiys3LwICm8YeVCwy1Y4p/DHiIDdmctBZMpVYc//YH
         p9bl0eflxClC/T5JlJRtOLKHQyRpl0+1iy7OAWNl2CMoPpAp6B76/ggkYo863HcDlR3A
         itXA==
X-Forwarded-Encrypted: i=1; AFNElJ91gLcR1klvI5fKS8mR63IIdVUEQXUM13Z6+ctaVmXZKPo8PGaJBaOkCbAx4qmkvnWEOoJ2MBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwVdV4/7U017IYIcK4rrQ8aNHVLclZ2ioPBMRW274emLCQ8Yf
	saHoR2OyshGA5XbMXBjQKQlUt7IuXua/Vp3eqgIwKKSDvLOXbDTLAMJg
X-Gm-Gg: AfdE7clCVxPuBbaXovVFdRXJ6gPaObTlj0vjTIq7rcFAnmXNYlo0WGaBazG4TOvi8Em
	5DiduaU1OIj13Eu2oeAafI2ZS3vzg+/gx/GIgEYdQcgJLLApKKJKXjsrenBVkIBjpS5z28AFmFq
	KQR6LHi3rpk75LqoTlYbONmavk/McjXsTMfQQWRdb18sPKd9NOEYiqNBKQ+Vpgmrju2v61meE8F
	amwHBF3cCCPRO/DYRgnBCFCY9qybhtGIqWhwIrUb//l6oUjqvlTTaeZlJZ7R8lt2dTx/CJshtLA
	KQ0SlOMKn/PyrgjEF75TDR4mTQkZBlKzfSpXabTxn75Lx43zSwe9GKqEu2ZywU9K4tVvQ1jmSyt
	WvaOI+kaQPKWq9fFyBdPDdTYzxraU8tVx5fYbaU3DwgHNlBaLMMmxjONTzCfkorMX+jhRUGLvPb
	dM6i9o+CsTJjh3QbWyEZ+k3jSruozgUv5rbmlW0Z6VBFQLXe3BgO+KrPQliARK
X-Received: by 2002:a05:600c:3e14:b0:492:4392:4dbe with SMTP id 5b1f17b1804b1-4924392502dmr176423325e9.34.1782079377192;
        Sun, 21 Jun 2026 15:02:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240eef2basm255372805e9.2.2026.06.21.15.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 15:02:56 -0700 (PDT)
Date: Sun, 21 Jun 2026 23:02:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alex Goltsev <sasha.goltsev777@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] net: add sock_open() with flags for socket creation
Message-ID: <20260621230255.0a425b0c@pumpkin>
In-Reply-To: <b057ea36-9810-40c1-9154-859eb9e0da5e@lunn.ch>
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
	<CAEKmD4K-v_srabQDJCfqaqA6vssk-Hg-mLHEdTsphTBLmQVjnw@mail.gmail.com>
	<20260621135746.067a93be@pumpkin>
	<b057ea36-9810-40c1-9154-859eb9e0da5e@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300920-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:sasha.goltsev777@gmail.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:sashagoltsev777@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,vger.kernel.org,zeniv.linux.org.uk];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5637D6ABB3B

On Sun, 21 Jun 2026 15:59:30 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Jun 21, 2026 at 01:57:46PM +0100, David Laight wrote:
> > On Sun, 21 Jun 2026 14:05:40 +0300
> > Alex Goltsev <sasha.goltsev777@gmail.com> wrote:
> >   
> > > From a9316957e594708dfb4258ad968fe88666c9b736 Mon Sep 17 00:00:00 2001
> > > From: 0-x-0-0 <sasha.goltsev777@gmail.com>
> > > Date: Sun, 21 Jun 2026 13:24:29 +0300
> > > Subject: [PATCH v2] net: add sock_open() with flags for socket creation  
> > 
> > A) There is no info here.
> > B) You've not said why this is of any use.
> > C) It isn't a bug fix so would go into net-next
> > D) net-next is closed.  
> 
> E) The patch has had all its whitespace corrupted.

F) Patch sent as a reply to version 1.

> 
> Please "submit" the patch to yourself and ensure you can cleanly apply
> it.
> 
>    Andrew
> 


