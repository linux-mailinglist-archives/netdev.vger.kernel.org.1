Return-Path: <netdev+bounces-286212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIUQNLiN/2nV7gAAu9opvQ
	(envelope-from <netdev+bounces-286212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 21:40:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A650140F
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 21:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3778300FC43
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 19:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FB3BD659;
	Sat,  9 May 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FvLj6KOM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C439DBE4;
	Sat,  9 May 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355613; cv=none; b=eGMUel8CC7kPxbtcNk4d+dbo+A0HYA6OJATqWCh3pa4qhZOnE9qaS305JfaPZuaebI12IcDyaUGGlCCm4D3xhZ1+hcm0TFbEM2oWUqf6sxqu5kUFT3Cjs9U9PtLcCpocS0Sp8WVUVzJlnAfWRcWwsFmASkAxIyO8vW1UM6peP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355613; c=relaxed/simple;
	bh=C2S0N5RnhH/2vct1Y/2IEjCnbP2zJTdvkWAdLDK1SP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgbFDDJ+Wz14rJS60MNOkf1I8b1e+aNxQWcXguG54lez50+HfbjmVuYNpOR7OoUmNgIVQYSBSdF/i2mTnGZ3hbw0knxWI+jNaR+wVjIH2edtvlqzn7QOb3onyVtjV5eUQGRehrj39sc3LG5eLMBP17Zco47tumJ+U8D4w2H2Hiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FvLj6KOM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=apx2itl6ido/GDl3BMcfRXwcHiMC7anhmX6nWBT36b4=; b=FvLj6KOMbWMxDi06MfXhf1T4Db
	gOGH3pxNNBEqVPUNxs+pZzjJdIqkGaamay5kH9Bu3yRxyIHMTOW9/T1sHDUn8uZURXPvaH9WElPm8
	rmxQam/srjIgPv1mISpW8wJ7NA2Ld/bmhZERgs2DwA8rT7TmcJGBuOwyYBTckIrB3pLw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLnWa-00287z-6L; Sat, 09 May 2026 21:39:44 +0200
Date: Sat, 9 May 2026 21:39:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Adrien Reynard <reynard.adrien.08@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"open list:KASAN" <kasan-dev@googlegroups.com>,
	"open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
Message-ID: <3b4357a7-f70d-41b0-a75d-c30f9fb7dd98@lunn.ch>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
 <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
 <3c6cde1a-9ce0-4d63-ba89-820c596cff3e@lunn.ch>
 <27c61395-f04f-420c-9a84-7e27773f2027@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c61395-f04f-420c-9a84-7e27773f2027@infradead.org>
X-Rspamd-Queue-Id: 573A650140F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-286212-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,google.com,arm.com,lwn.net,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> > Can we get the tool changed to add a warning, something like:
> > 
> >   WARNING: This tool uses very simple pattern matching to look for
> >   repeated words. It does not understand the complexity of English,
> >   and will often result in false positive reports. Please assume it is
> >   wrong until proven otherwise.
> 
> There was no commit log and no cover letter AFAIK.
> Do we know what tool was used?
> 
> Adrien, how did you discover these repeated words?
> 
> (If it's my script from 2021, I'll gladly update it.)

Thinking about it some more, i think the warning might actually need
to be different.

If this tool has been around since 2021, all the real problems have
been solved, leaving only the false positives. So the warning probably
needs to be much stronger, saying that it probably only reports false
positives, unless the code is new.

Maybe we also want to extend the tool to have a list all the known
false positives?

      Andrew

