Return-Path: <netdev+bounces-285566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFYcJE89/WnyZQAAu9opvQ
	(envelope-from <netdev+bounces-285566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 03:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1F84F098C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 03:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34B2E3035883
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC021D590;
	Fri,  8 May 2026 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="0cAFHZ2i";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Cdxm7D/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623A2F8E8E;
	Fri,  8 May 2026 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778203978; cv=none; b=mECS9EdTsUqJ7wIWZoDAQ+FF6R+H+lO7wrSGf42I/L/3gOHN9mSZczucK84BWe29sBp6ipybcll3QS70lB5xgYfIexUzHckxSBnYXRyhaaXsUR1uhZevqkNcjqOUyxJTISZKXVmE8PrZRlWEN9H03hMrCP0l2miFlQcTodfaH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778203978; c=relaxed/simple;
	bh=59Ozai3wYSqFATx+O1Q6wvL8WwOweG+EID5bZRCzz9c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oLk/nN1tEU377aDQ+tCGRWPgQWpbtALqJyDuM90proS5o+smESFw+KmBF969w1ShXLPVnErw8KIquqhCqkMnmnPrA7o23p4lnRjajSXG/mS5LW54uugobzSIxjlkAs7o+NBVXHX3rCeUM+SkLxE3AMSEWEcKaa6H8ptTJMLUWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=0cAFHZ2i; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Cdxm7D/1; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6481WFoU032065;
	Fri, 8 May 2026 03:32:20 +0200
Received: from lubuntu-18.04 (host-87-6-211-104.retail.telecomitalia.it [87.6.211.104])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id BC9011208B1;
	Fri,  8 May 2026 03:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1778203931; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbsB1NBcnWTkhw9ytK5amjtDdrA8CRqzSQfmN5DZrT8=;
	b=0cAFHZ2iClqvBVEj1k6Dk/wRxs36qpYT1cD5W7OSfUPKIjGj416OK1Uz+gCCcJvspcOGdi
	OlEnJ2bSKVJqFrBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1778203931; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbsB1NBcnWTkhw9ytK5amjtDdrA8CRqzSQfmN5DZrT8=;
	b=Cdxm7D/1Go0IWxQMP/p+XKxTmOzvXlyrOxisyqt5qhK4f7hv0ExY9yHqqyu9UbyFW6RmDv
	nz64ExHAGrkR2xAaqdIQ3FoiBRZ/UtiCaO/dZ6kgLXqyEPgYbbrrqKe/SdsWl3OvfPMgfC
	mqZTlvqGsam5/oiUd4fLrLldJ8hQiM8+hEKwHCaaie+SE0XndoBjRZpIoYhPHlh4PtknUA
	lin26JL3SLkYDb56XZ9CG6F7LFNinJcci/TyO9DYcGgH1CHELGEduKgq4zjVDregqZKfRu
	vxZcygOsLTywV1cFjtt8UCoOI9D+xB+TwrfGEqJHdzeCToIen2n/KMe/QJrL7g==
Date: Fri, 8 May 2026 03:32:10 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
 <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>,
        Justin Iurman <justin.iurman@gmail.com>, stefano.salsano@uniroma2.it,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433)
 behaviors
Message-Id: <20260508033210.5149db4fc3977d33937e6942@uniroma2.it>
In-Reply-To: <20260504182833.344d7b33@kernel.org>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
	<20260504163915.4a8b028e@kernel.org>
	<CAGCJULP83NnaX6HAqwb3umDXsxN8LH48_gPpJ_3gG8_xA96QNQ@mail.gmail.com>
	<20260504182833.344d7b33@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Rspamd-Queue-Id: 0A1F84F098C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,gmail.com,uniroma2.it];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-285566-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 4 May 2026 18:28:33 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 5 May 2026 10:22:58 +0900 Yuya Kusakabe wrote:
> > Just to confirm the workflow you'd prefer: should I repost the
> > current series immediately as [PATCH RFC net-next v3 ...], or wait
> > for technical review on v2 to land and fold it into a v3 RFC?
> 
> Let's wait for reviews (adding Justin to CC as well FWIW)

Hi Yuya,

just a heads-up: I am going through the series (kernel and iproute2)
and will send detailed comments within the next few days. It is a
substantial addition so I want to take the time to review it properly.

Thanks,
Andrea

