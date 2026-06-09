Return-Path: <netdev+bounces-297115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rq4dCXIxKGqG/wIAu9opvQ
	(envelope-from <netdev+bounces-297115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:29:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7428D661C09
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:29:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eDnmlTR5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297115-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297115-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3AC30E47BE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D74ADDBB;
	Tue,  9 Jun 2026 15:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B54A13B9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018034; cv=none; b=uR1RTrdvKQFLfBmBpuo6QSYYueqY/d9+IISuC2x/joDiREMbPlxgcBnc/1dy4kcfHBU8TzePeDzOluka/Rb3A42ky6aF1m5bhRTYe8Qlg/7DYF59Jzx/SwyA8WMrYAGZ7RrSGjDloumysdya3r8caU019MK8HEkKBBC1z15vqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018034; c=relaxed/simple;
	bh=Tgj2/f5KwE1aGzhSuEmxWHXJ26+0zAS918oxJXslIPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcA3XqMNWIbgmT2MfTcG0/gbfe4Trie2uEmyem2Ba/tR/CWQBk3Z/fciTWSxHO3puheIyIrPNGc8FVw8vUYc6v9Pb1igsddwCHJf66/8sziISEG/urvr6rJLLg66yc65IbxLcAgpIjyJoSGokUcT7vsixpkyiZ3ZU3W6lDLBt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDnmlTR5; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eedc94d37so2875973f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018021; x=1781622821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS9BfQsDmesJT0AInGwOXq/X3DAmc3WIA3Pzjrg2pfY=;
        b=eDnmlTR51Qisn8G1HGxRzhpM/4f8MiowQoWhGCv01Ro0aAVP25snMxrWmcSmFcTQa0
         kSqbawpNnq8FhnzmVbETXa0AnDSm4stItKLC4Vb+bMhOUcR10lyMCOcZgmKWbdPWBfGc
         wCLJUWKNTcBfXOrfJtmb0tgKJkPFbwgWf9ORzDuJ3bziClvqziatwyT1BbLOOgzijpzK
         bbX5zZb7b3RpVHqM1qG1Lqn+ZeCKvjm8kQUWqmQE9N609q5oyuTzJX+445Bm1oEnukUz
         0Ojn7+KOKd3Ojcsh8qy6EKtFUukke8gP+aksgI/fnF4vwSMZLx4PEgQMyI7GQEVacC/i
         OkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018021; x=1781622821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LS9BfQsDmesJT0AInGwOXq/X3DAmc3WIA3Pzjrg2pfY=;
        b=M+ys8BMZ1NLf9qIOYMyl4Tn7N4UiXE8KTOG5hlVRSbIcdkbkBZGrLeLfPhTzKlojAS
         xsQXO3/TDEdzgxVlpVkKgFMCTVgDJk65NmL5wpliQ4+kC0USJKOjec6lNJ6GjkbQ4ehB
         z72KaEsD88RU6oBykA70yDTaavWGyHDQDErShvjnawAaoaZ6sTEVOwhOcAPoTms0a5V9
         gmGTTBp8PIkQcXb6KqPAgVFKlBuiFniDcmRW6KBZCYXuQWT/CI0aAv8Y5lhjVj/PVcDE
         1J5gRNJW6dG4xM3HQkM2BuIuk1o3lv1u43JUkEn6aU71z/2EQQ35neLcxalBGgGwXCeW
         Fuuw==
X-Forwarded-Encrypted: i=1; AFNElJ9xnu2ZymYPiHjpyLGZPuFm3N29s4SMjSTjmANVlHd7HtbobFYo8SZQiaM0QMkKXwA2T2Bbf3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOL2uhrKeOSbJAWNF13XIdlbc4I95rg5S3nUAoC8c8DetQ7UM+
	uUcrl6w/bbbOB7cXWw38uVv33DeGx/5SxIiLJZWerIXh71tAGAHedK8+rmRZrfgn
X-Gm-Gg: Acq92OGw8Hh6koYUmkE5tMzewUx0ASpaKfmMQzenJOLKjfOwEFkcDT3OjsusREGJLTD
	p4MK1m5uAQY91+beuyX49RXk+rpwqDKLVa/Q0LNvQJrfgkhE6i036m8Z8hVvXf7jwW9r3JWctN2
	eU0Sd8huhzhB4xH0OH0rzfy+oP4ivaIZ2Tiba9OSe6IPvqoKHFNBuktOEdgnIKO+SP6F7LTrYr0
	OLPw4dt81Tm2DXd5dyErN4fxAAnhyPKdwWI1lcnytrrv9WYEMK+wycN4J3GwWOdIr+tRWCFq275
	5qW+s6eMBYEtBIgc/O43Jpl/m/FAhBV7fkm90kMU+YzlrN99WyPDYeOwXBsl44Tupjp3Vt2sro7
	0IeaUrgMngDIeASmTDmrNlBTN9u1HX1V+9ru2bkjzjTzYTsEjyOvgzAe2CXX5Gq51smMULYMQgz
	iRmKvV57TylmlP7ZjmZZxBhP5lnCVOvIvYhhlcnr1qhgOoPSWONlj2lwa9R6i4dr/zlkclqvI=
X-Received: by 2002:a05:6000:4312:b0:45e:ea9b:edfb with SMTP id ffacd0b85a97d-460566db7d0mr4546819f8f.39.1781018020420;
        Tue, 09 Jun 2026 08:13:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm55897116f8f.30.2026.06.09.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:13:40 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:13:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings
 into arrays
Message-ID: <20260609161338.2222ff26@pumpkin>
In-Reply-To: <c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
	<c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297115-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7428D661C09

On Tue, 9 Jun 2026 15:39:35 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 6/8/26 11:54 AM, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Replacing strcpy() with strscpy() ensures that overflow of the target
> > buffer cannot happen.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> > 
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> > 
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> > 
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> > 
> > Note that all the changes are only compile tested.
> > 
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> > 
> > All the patches are being sent individually to avoid very long cc lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)
> > 
> >  net/devlink/port.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/devlink/port.c b/net/devlink/port.c
> > index 485029d43428..108926d3f899 100644
> > --- a/net/devlink/port.c
> > +++ b/net/devlink/port.c
> > @@ -1222,7 +1222,7 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
> >  			devlink_port->type_eth.ifindex = netdev->ifindex;
> >  			BUILD_BUG_ON(sizeof(devlink_port->type_eth.ifname) !=
> >  				     sizeof(netdev->name));
> > -			strcpy(devlink_port->type_eth.ifname, netdev->name);
> > +			strscpy(devlink_port->type_eth.ifname, netdev->name);  
> 
> Given the above BUILD_BUG, I don't see how this change can help?!?
> 
> Generally speaking, I suggest restricting this kind of tool-assisted
> changes to real problems (if any).

My aim is to get to the point where the calling strcpy() is invalid
unless it is used to copy a string literal into an array.
If/when all the .c files are changed the .h file change can be committed
to stop any new potential unbounded copies being added.

I do want to look at the 'fortify' version of strspcy().
The current version can call strnlen() and then real_strscpy(), so
ends up doing the length scan twice.
(Never mind how much gets inlined.)
strscpy() between arrays could be implemented as a memcpy() of the
shorter length and an explicit zero of the final byte.

With the BUILD_BUG_ON() (which I didn't notice) the above could
be e memcpy().

-- David

> 
> Thanks,
> 
> Paolo
> 


