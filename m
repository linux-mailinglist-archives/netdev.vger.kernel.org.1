Return-Path: <netdev+bounces-303791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0NQeCvZVRWqg+goAu9opvQ
	(envelope-from <netdev+bounces-303791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:01:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 773FB6F07BD
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:01:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=doyensec.com header.s=google header.b=HZE3lwJG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303791-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303791-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=doyensec.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B63300D68B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4259494A0D;
	Wed,  1 Jul 2026 18:00:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961034678C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 18:00:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928852; cv=none; b=Tii+SEMMwy+VGAN+n+mTLeR5od72UKkzT1zgad7X9zIXmtgUUK+IoK7ryUx0ktcW9fNRbKp7T+krclevJYDNGsLKDiHkeUi9QXt0ZXtIZ1j+uCjiRd7KzIPrTJ5KDtXXP0LwOd3Yo6e6EW+QBAqhC9luwYo7Etqp0koQAbwd+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928852; c=relaxed/simple;
	bh=/Bc7N8+ZpdLfeXuwHsaBPQensWNYtrDCDbb+DbfN+8g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZIKrytGbEPzRLC+s3YMorHZ+MDfZcokFwZPN/Oyx4EGuKFlF6J6LJ5KlpUS3SrR15xy/MIT7aLUD1QqVW72pCo1zTwwCROiAgHonPPuLM6FP/5FyvONyRlCp6ZsvEvbSnApAyMEQRQsxlfqncmO5q9tVf+GrW+WkN8VeguxC0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=HZE3lwJG; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so1750704a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1782928850; x=1783533650; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzCF9fMgyjkAYX1CbvUsJFExjIFI3vgiPqiUwQX0cHg=;
        b=HZE3lwJGF0N0L0aAjw1KoGzkKtVnLgvMIOI+xTJnd8Pir3/cmNUIDVlpCthHt8cXFz
         AeJJm6ww+AjpRUjPB4EtiRtfmRbATCktqiwX0KMll8bRP69XdkgvfqcWG36hmPKfwFro
         lUBSY3AdfuPiNc1uq1Ogwrb2MgCTtpcXNqPundSGGPlDtubTI3hCdXs6LtKg8V0qtfPC
         61gJXCPyqPCCJISNN2r7resMFqFQZ+eo7RVj9xZty/KCrMXaJ4RkvrFy4F+QuGR+KIIq
         SNjooliwOYtsbMtdwRrDSB5dYNUPJ4N7BhPetmPoi0XpwDGDVOLHJoj/DvzPpkuiAkR/
         2m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782928850; x=1783533650;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzCF9fMgyjkAYX1CbvUsJFExjIFI3vgiPqiUwQX0cHg=;
        b=ePOUKptKpYpBFgCrZWRwAnaKFho9MiBaFMD5j3WjVywWvdDjwPRECVMVizblk5iKuI
         UDlwxG4wo2+hM1bwz4h/0XvHyJzhUPZPXcJ+kVibgP4wOXBPryPhCDbnQ+8nNR/AoKUc
         LPkftMro8s1qEWvbSj258W/pPYP0QkLBI5JYRUAfBiZ+dJ4JpXQFTr2lDf9Z3R6zIYNL
         LAV7DfxX+BN2rjp5+sdZ8l1/N8nfoNtvHzoeRsNl51fj9FOLFKIhivZK6GtbIKygg7x+
         lyR8bLJgICzW7JoW2fQXMMBPx6CYyQUhSnTocafHSAxOIopX2G5U7JQwq220RRPwgUBz
         89Bg==
X-Gm-Message-State: AOJu0Yy6By1bzwXKlPzTC7JkaaVxY6cC4l+r7IZ0YcDzs+lmYPsX3IOP
	CPoPVJH0Wo1lVQXrUyjSuGPDnmXBJx3Z/7EJJ4o6vsgfpt8j7CS+k+AcN+8tme4traw=
X-Gm-Gg: AfdE7ckx2QDdbyRQBtld/A5Wy0Sct8kCXHoLTV/1mbq4ksZlFVJBff7HCxOs4XTbWbr
	6w5i7i7Mc/WN3InTYBWnT/c0oLEI5k44rXiKMdhTvYN6IXZwzIkJhfVeAZ5lTB6ayFJNgUSfFcc
	57NS7dKUjJ5waU/Jn8ERfphlSZXF+UkPLUgNn84VRcwtCJ2Uk7dUCpwyRE2jDusBwNu5K6ov1Xm
	Q8ATa9gTnV8plSCpm0825KE3gBo6Vx16cJZTRbDv/t9M58jPnVvfwprY2GXTSz+7eq92J2KSWmv
	Kn5lkWyNgYoPuAfplWoH3tEdAy8fFVt8GMy/LwnzJ8UVU62F6VS1dlWJpBoFVD5eY+BcHtBAuZW
	UCWT/unPcETks0leZ1cp3qLCL0qqQmTio1zD7OFHawdaF2VDBcFuq/zs5YCMq5Ua5f2FRFv8Yx0
	grgql6tmYw1l14+1JoQRnmcI+zYwjRxzZP7edC1mskWasqInUCraPwE3N0ybHvVBUK1i/icBX16
	sTNV44K+UdLyeJJJJdon/hHjscP/gyYmF3oZGu2d3jhJAIdMa+5A7o=
X-Received: by 2002:a17:906:3857:b0:c0f:bebb:6d89 with SMTP id a640c23a62f3a-c12a9d9883bmr93090166b.24.1782928849443;
        Wed, 01 Jul 2026 11:00:49 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.68.ipv4.supernova.orange.pl. [83.10.35.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm1108066b.1.2026.07.01.11.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:00:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net] ppp: defer channel free to an RCU grace period to fix
 pppol2tp RX UAF
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <akUSFR-ih9U27fgr@gmail.com>
Date: Wed, 1 Jul 2026 20:00:37 +0200
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Qingfang Deng <qingfang.deng@linux.dev>,
 Taegu Ha <hataegu0826@gmail.com>,
 Yue Haibing <yuehaibing@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3D8CD266-4131-4C6A-B69F-B69B8070BA03@doyensec.com>
References: <C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyensec.com>
 <akUSFR-ih9U27fgr@gmail.com>
To: Breno Leitao <leitao@debian.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[doyensec.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[doyensec.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303791-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:qingfang.deng@linux.dev,m:hataegu0826@gmail.com,m:yuehaibing@huawei.com,m:bigeasy@linutronix.de,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,gmail.com,huawei.com,linutronix.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[doyensec.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,doyensec.com:dkim,doyensec.com:mid,doyensec.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 773FB6F07BD

On Jul 1, 2026, at 15:15, Breno Leitao <leitao@debian.org> wrote:
> 
> On Wed, Jul 01, 2026 at 02:14:39PM +0200, Norbert Szetei wrote:
>> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
>> index 57c68efa5ff8..cb8fe37170d3 100644
>> --- a/drivers/net/ppp/ppp_generic.c
>> +++ b/drivers/net/ppp/ppp_generic.c
>> @@ -184,6 +184,7 @@ struct channel {
>> struct list_head clist; /* link in list of channels per unit */
>> spinlock_t upl; /* protects `ppp' and 'bridge' */
>> struct channel __rcu *bridge; /* "bridged" ppp channel */
>> + struct rcu_head rcu; /* for RCU-deferred free of the channel */
>> #ifdef CONFIG_PPP_MULTILINK
>> u8 avail; /* flag used in multilink stuff */
>> u8 had_frag; /* >= 1 fragments have been sent */
>> @@ -3583,7 +3584,7 @@ static void ppp_release_channel(struct channel *pch)
>> }
>> skb_queue_purge(&pch->file.xq);
>> skb_queue_purge(&pch->file.rq);
>> - kfree(pch);
>> + kfree_rcu(pch, rcu);
> 
> Why not use kfree_rcu_mightsleep() instead? That would eliminate the need
> for the additional `struct rcu_head rcu;` field.

You are right, kfree_rcu_mightsleep() would be simpler, but it's
free-only. No callback to run the deferred purge, it can't handle the
in-flight skb. So, I'll keep the rcu_head and use call_rcu() in v2.

