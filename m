Return-Path: <netdev+bounces-261944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEjKAQngoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:18:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699681BBE6A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A2430416FA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535336E482;
	Fri, 27 Feb 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6LVdD/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69436E472
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216136; cv=none; b=L3wc3N512uhmkJX6fn3LavCHctqYy/M8nTJ0/R6qe6ZH7IEeuNSWO4t7/PFMffMFt++5VECMh0dhksJaT3VtbyuupiylSbxHlCKhTeLhqEhC4pcB4oSAPgDX8bU18IbwAEvSYSswyPne9oGcYeo84x9aNMKwYoBU1NouNOC3Dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216136; c=relaxed/simple;
	bh=EIHCSnDQnPgzLOrkBSeiEeMSnqPciWc+HEYIcaNXe48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8OJsCM7Z9WNTAdyCluNoo9dnZ3SX7GusRy8fuG/C5FI8uzvvOk5eqZR0d1/yDiK1XP0NIRcEgQakHUdq6dUl1ZqaKOHXls2l6ToHZWM1sukJzbutXRap9YNAOPNe4NX1HeTuZmtJYJvueaPfSKRawYeuG0yAKVJf3hJZ8uz5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6LVdD/G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so18682975e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772216134; x=1772820934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vLtKfQfpUyImPgufwuUFBCxVkCuAbK5gi85kgZFI1o=;
        b=h6LVdD/GZ4s3Hr4A2zQzkP4zWi17wlFecgS4tVhNz+dAjce1OQ27sPJHqP8Qm/NJ2Q
         GzX7gNLydWx7M0Pnp7WTRQpuQR+s1z3V7Y7w5Gg1PtQImctmytNVD+vPwbh14IUhSAbQ
         w5yW/7qliqcX8p82bDrHPfDt81/zU7ZcctW0iwVocEio1OzWGBquNwQqSmwWHpWuXhP8
         Is6iVJ300Z08CS3ea0WrczFtTIwpmcOpe3O1vyd0EsuJK+pt3UEVmYFFD4fMbSffbrdU
         FlIi0Dym+m9cXCXvFeotg0tIMGGPOoFxqiS8Hkz4USL9nYsVz/E81GgU4k9AEEhtZZ71
         phRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216134; x=1772820934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+vLtKfQfpUyImPgufwuUFBCxVkCuAbK5gi85kgZFI1o=;
        b=AyM6Z6VT/KTS+qhE0ZneIN7WsCeuJL+B8Ig51dCfZCLLrDwNrxW+2PtjRf40eCtSO2
         xrs06UL/mDC6B6a+d9zg543CyRmRkvfK22NZES3+xnbr4NovuKe2ragFkbCnrcmjcr20
         E0ufSLHiuWkvaN+TKXU2giJqRMbGcIMKt3cpMrfADju8td9dPR9KfcfZLKMognaxliHD
         CJCCMvX3Ups0SL6m39tlW0gbmVv2HNiY3ah81Ur+aWQf0zs/JS5UeQVdpJs4PbqNfxFJ
         Zso7w4UkiwWUrXJHO+buiTwznfOdDEcDk5PVHq/MaaOhN+am2ugwn2/VIS7z1XR+2LIq
         +OVA==
X-Forwarded-Encrypted: i=1; AJvYcCW+4RIXemRmRs/OVXUbu2lfPW0itotVSQpGJHMT9ZAggP6dph2Mw9G896G9jDq8pZe/S4E+BjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHEYu9h2KqNxDCzvHgsUzTgWvJOyoCLWfcabhJIsuXoZoLTmX
	Dc5XQ8YUMRSpmDiT8FTuoo1rH0KYILIABe0dCBHmJ7yMF7Ud72f1aqFK
X-Gm-Gg: ATEYQzxDJfXWiGlwBKSftxhdtfWwcObR++8zX6uZpYczxgHy0dsnp43aMglA0xJF05d
	LhSuDZ2LdO+yzjhIHMjXb8rtZwcm/H/xuMMeDvzU9tZ0Hh1I6wMFn7SDw+7g6lgtrB9CdJSvsfH
	m4BSKG6qS63+jhRDKcQ7qNAawd5GfRMDuwh1hdv70d1Fp0j/JZIXxY6u+ThCW2bnBTnRNvLRngg
	+m9fmvvPvbsmNoeoJsHxY6v+obVR1OzF2tgCxImHpMyemC3RZoQQdRAEla7yElPwAY4Bd0Mt8Q+
	H3E4wUwgwymLzz7GeTgDMAv1ghpKgQVnsGcQ+6IYBM7n18sD+cZ+d6Sa2pB6M9v3FB2h2khzZYn
	c3Ambc6oGZnsQrgYekuMhvD94Jq+MEJYdnKQKN1A3sFrSMZLp3/vRoPhW+F16rm50lOfp3DYvcY
	jdlrZL9luHqOFSg13KqAfW9vDcHE5fi/bYmKlRmLLdunOm1hIwiR2Vxrp74jrV0gQG
X-Received: by 2002:a05:600c:3e16:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-483c9ba38damr64818595e9.7.1772216133739;
        Fri, 27 Feb 2026 10:15:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770e7sm131066685e9.9.2026.02.27.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:15:33 -0800 (PST)
Date: Fri, 27 Feb 2026 18:15:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sean Chang <seanwascoding@gmail.com>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using
 no_printk
Message-ID: <20260227181532.1616f720@pumpkin>
In-Reply-To: <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
	<20260227152624.164964-2-seanwascoding@gmail.com>
	<20260227173814.2f928556@pumpkin>
	<c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261944-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 699681BBE6A
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 18:57:33 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > >  # define ifdebug(fac)		if (0)
> > > -# define dfprintk(fac, fmt, ...)	do {} while (0)
> > > -# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
> > > +# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> > > +# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)  
> > 
> > You can omit fmt, then you don't need the ##
> > #define dfprintk(fac, ...)	no_printk(__VA_ARGS__)  
> 
> /*
>  * Dummy printk for disabled debugging statements to use whilst maintaining
>  * gcc's format checking.
>  */
> #define no_printk(fmt, ...)				\
> ({							\
> 	if (0)						\
> 		_printk(fmt, ##__VA_ARGS__);		\
> 	0;						\
> })
> 
> Without fmt, gcc cannot do format checking. Or worse, it takes the
> first member of __VA_ARGS__ as the format, and gives spurious errors?

By the time the compiler looks at it the pre-processor has expanded
__VA_ARGS__.
So it doesn't matter that the format string is in the __VA_ARGS__
list rather than preceding it.

	David 

> 
>       Andrew


