Return-Path: <netdev+bounces-279134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLRYCN014WkEqgAAu9opvQ
	(envelope-from <netdev+bounces-279134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D9414066
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4E930ED31D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42E535B65E;
	Thu, 16 Apr 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY8Id/xC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4C359A81
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366947; cv=none; b=iJrnI1qobwOhFo4vj3xpRXiPnnyoJqEdEWnej6nhg42t2w8OUVcn/bifM+vNxvUTadg3/MOz2h6YorIqi2gWm/OwvMNET9Tr9CNdNX2boBfw57khAuYymuPTHRVBoZYvcyamuNITCtwxFDav8Gblv7aqWj2YWkfDdgekLoK6qB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366947; c=relaxed/simple;
	bh=OJeI+3mV9W6ncnLD1OqQ+pA6ULnbFdUSlKq0JT7njbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWcJIcaAEADSXJXMKNA3N0h0OTLNVisFQdXuWgQQDeFjLVWcavJVtgN3MrqoPEUwL9PKWQJz3eYRXnTrUgqMdT9YxNgxF2DujZfyAwhMyvxqiZR4EqdT4n0H+3mfbTGcQ24jadlTz+5x8s+InLeC97gWMgYmh4VoHvoB7u40OqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY8Id/xC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso46846785e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776366942; x=1776971742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI2dSkxrwqhQpR5uFXP6GxtJ/asEeAYI1RS8A1ZzV9c=;
        b=QY8Id/xCkNSDyRp/6Ia+IhGODB81KC4sCUqlBNfTsAhr60CKClN3QAh6bbWUbx9w0F
         bowURat77zHN+ZHlfvOuP63DWSZJLS9CB67JIgVAKCi6+vwdDnB0WCbS+mhqXyCZvNgH
         3LgovKTZOOZSrowianOqjoxUQU00rBtvbO969KTtzDkyjg4GJlw/bqQS1tjsfKG/nQPm
         ogEfTFcSlOlyCQukZYVXoZ8VBq3hePPIvwrDjEotzfkKEEGQrm4PF/3sJRfFVVsqc4hv
         U3krfzau87CZFEd4MdPgtiuytDHml1jLJtOQsqDYRuR1b6pukPY/ROgrGM7JVAH/3WFp
         ckmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776366942; x=1776971742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI2dSkxrwqhQpR5uFXP6GxtJ/asEeAYI1RS8A1ZzV9c=;
        b=ISBWevaddR7gbhcWSKLUKocc0UDF60eWROKOYraZ68vcLWP2CxDo0BZnwNcHKQoCiJ
         ZpQyT5BxtEdrFleMufvZHdDSW9SD33P64IcFnrlKcFgqEHgcyFrNrnSqgiea2ZF4yItJ
         bmiRRRpGemD1rUca8XhWM+Q6ogKIC0BfaPWl3lwpShMtoJJPehCkEbb8RURp+o//fRf1
         Dk7zHM2n1ySErpOpjQpGz94jKy/5wRwUHSjC7w38CFaokXA2VaTsk6VUnz4XZYkkPMOr
         Ix+JXlgtX8LdcdvQHfMvPmxl2SxkOnPyopxpnEKkvaRyYRexovWsIC3hmxa+B+lFK/Wd
         cbsw==
X-Forwarded-Encrypted: i=1; AFNElJ8YPga0NmLCXjZVZ59XaXwqY1j7TlfvlC7iMNw8FBYDARSrm8ozqfWjKXdr0rRVrgPWAIHS0OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42NNAZ2LChFCqwy12sHAIXZQ0ksIrPhctaNzsFpw6l+80dcod
	yFSSBWbob0Den3jbsAqgmnpqPpwLJtIUiSQFCAS6xNFPcarfI9RW91XS
X-Gm-Gg: AeBDiev+et8/sXjs+DdUgh7m1bP/Ba2RLFueOaMOGrNqFAwMlRuX4WUVQtPevMTI+Qj
	ijL1/xDqLo8wJXAGNja88XpfO/nHHZY4X7o4o6Q1AudvCurC8Z+1jLTX5AolbeONx4CrlbWi839
	v32KWioEPAJoUhWLiRjtw9P4gl2uwEvjZtuFPodPh5W0rfqMNzTkGps3/MN0FA956vPB5BQGaCX
	woi5++FoPG9+rKcuEns00zunHDH4AgOdCojkgr1aNNMJd6ZSx9NA3324yuu+u3FkqT1BgEAEbnW
	LJgT8H7ebgeSkuLcBp05vhA1FAeA+TNmlYN7OFvO9H243F31wrnBhEcf9wuLrDTlmIZZb4s9KeE
	72TrgKK5j9gK03a9wa12393Lk/zUd36tKqnXzNvhCWSvoQpSZ5MWYUp2bfFXn5H5AXNklNvMx93
	IIkskQaTvRsMSj7MCSpVvMkJxdUr222cn/EUiR8AFufkGlAWKKjFIowCnSCtjfNui1dXpFHjVf3
	oY=
X-Received: by 2002:a05:600c:a415:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-488fb26d43fmr1783635e9.1.1776366941546;
        Thu, 16 Apr 2026 12:15:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm16561608f8f.17.2026.04.16.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:15:41 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:15:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: chensong_2000@189.cn, rafael@kernel.org, lenb@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
 dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
 petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
 joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list
 with double-linked list for reverse traversal
Message-ID: <20260416201539.2cee3b99@pumpkin>
In-Reply-To: <aeD4H8P1DiPQoM8V@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
	<20260416133004.07bd2886@pumpkin>
	<aeD4H8P1DiPQoM8V@pathway.suse.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279134-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[189.cn,kernel.org,baylibre.com,linaro.org,redhat.com,fnnas.com,huawei.com,windriver.com,chromium.org,davemloft.net,google.com,suse.com,atomlin.com,suse.cz,goodmis.org,arm.com,efficios.com,vger.kernel.org,lists.linux.dev,lists.sourceforge.net];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[48];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,189.cn:email]
X-Rspamd-Queue-Id: BC1D9414066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 16:54:23 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Thu 2026-04-16 13:30:04, David Laight wrote:
> > On Wed, 15 Apr 2026 15:01:37 +0800
> > chensong_2000@189.cn wrote:
> >   
> > > From: Song Chen <chensong_2000@189.cn>
> > > 
> > > The current notifier chain implementation uses a single-linked list
> > > (struct notifier_block *next), which only supports forward traversal
> > > in priority order. This makes it difficult to handle cleanup/teardown
> > > scenarios that require notifiers to be called in reverse priority order.  
> > 
> > If it is only cleanup/teardown then the list can be order-reversed
> > as part of that process at the same time as the list is deleted.  
> 
> Interesting idea. But it won't work in all situations.

It is useful for things like locklessy queuing a request to be processed later.
Items can be added with a cmpxchg and the list grabbed by xchg of NULL.
The only downside is that reversing a list isn't cache friendly.
Thinks... although that may not be any worse than accessing the current 'tail'
to add to the end of a doubly linked (or singly linked with a tail ptr) list.

	David

> 
> Note that the motivation for this update are the module loader
> notifiers which are called several times for each loaded/removed module.
> 
> Best Regards,
> Petr
> 


