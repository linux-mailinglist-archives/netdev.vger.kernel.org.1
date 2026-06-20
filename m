Return-Path: <netdev+bounces-300846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9yYNdf7NmpxHQcAu9opvQ
	(envelope-from <netdev+bounces-300846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 22:45:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 003246A9B6C
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 22:45:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LUPBIixa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300846-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300846-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=debian.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F9D4301F321
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64085B1EB;
	Sat, 20 Jun 2026 20:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6D35DA42
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 20:44:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781988287; cv=none; b=K/YSpOSq4QanUHOYGxsSV7KJTLUHqEpto7GbXP63oZI4mWxK2TquwYgmJ0Iv8Yn4v8UaI+QAqyby/n8KecBcFL+CWYXo1rr4emFPspHJreApdaocIjHNjxUBMCiKxNoq8Gr3K87IWeSAnAx5Ikr1gjQmouUuxuqN8jsxuMlbvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781988287; c=relaxed/simple;
	bh=U7AqPRs5Is8Is9SjOZmekPXBSghQ5JGw1UeCdOvvZvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYg7UXVN6BtyyiugIjimyeIzoUlxg02V4Pcu+tQVvnQW8VhJ/d433nRabJBaU1+7autPYyoWLFsvP/IVLZDggq31+gCir/AIRRp/N2jk/bEUB2BBotqr8cd8IvHTVH8oVT3qaNmieJVbkNrjvZ2WPrTLKWJ4hyu73jHh9PtUuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUPBIixa; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4633193af19so2212399f8f.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781988285; x=1782593085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEJeIuAOhsEHJ09iO7qVlqN+PvloGiCYoriT6c3hYsU=;
        b=LUPBIixazRPSirqDkp63niS5WeCN1ro9nfbI/OSPEVtweqvBR0fp37KJ68AGl0psaL
         NWBF1s2L8Jbk19PyvrNWeI5AXRYbbgeOJC9Wy8Kn0kn4lio+V7dgYcAywe5gX32PhCcO
         OiuOiHQiKoDL+q0F26VF6jyS+aFINcy2s1td5I5NxLLtykxYIYJN0AslHz/GivWGCKql
         H4t+geJKHgfdesazhdUaMp6jjl0gWi2Cj/xOzYD7+imKSPME5uintZ/HoNHpF7RIaR7i
         aAAVmp65b3IKSQPDyjN24v9vFyJt7m8wOUn/Q7rqIUsdhbh8I4EdeH6QeGiOCZPbAhNf
         GAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781988285; x=1782593085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEJeIuAOhsEHJ09iO7qVlqN+PvloGiCYoriT6c3hYsU=;
        b=Oi2xSEkGVpTshGKmaKQUHlTXbymPZxLmmI5EeazMg27srwl1xRsZ5bESGlciUfcCHu
         JXFN1CNpE3VRp6hgCCR7sB9akPgo3G+dFIR29HUKDPY6oHaIoVriBx2c5F2ahVjMculm
         8S2nIbamagknmXz6CTWqxzsNf+SVGNv9p41DvPBciF3cmHOBMeq9niocTZOOqsNFlkeg
         f9YFP+O3bYimzH4GrtuGVtvSuKbF1bqr4to5FNihe/fxaJ3uAB55TjiBRUu4wv3dZFsh
         fqV3ULrap8dBrRio2zWhEQSKc54WYrAcxHUBTfKYvqvd/t1KgQm0wzv5LEftmmvzSM3R
         ui7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro/jav1YKHJe+gXni4Zbp0iXaxaQ0do34wmO4olTxPYlKTHe7fuSUfW5v0tygopWytGCKHSfmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjsZIOk63321GNTCOTZI+Q9ULP3yjJWmw18wv9D/DsbZyvxvv
	0hyWT00eeHxs1imf5+Xci+VXgMPZiRkhn4aZ6V31pPtH6y9lc++ZWmtF
X-Gm-Gg: AfdE7cmEITKhyZzarCTq5/I0HNgVWOnQWyXUEXuBix7Oypw2vIEDYCbdEyL75V4FaXL
	B5D/McDs7n0VAkZzIjtCkiT8LN8kSlkO+pzL3w3bRNYUEykxfQSaC1o8uKpaOLDrWhGV9y3lYCn
	gG3ZORPKoWfasyRBtzNpqFHb/Sb8hfGO62Iep61qRqdBTMD5J8EgI94/YTDzuubhNg024qzBvYc
	iZvmbmYRNo1GMlJmeo8ppqTK6kk3j9xSQf26d2QvzEo48CW/EaR3ANKmd0Cj/MVA39txPGGtjKA
	RWVGaCT74d3icGXyNRd5WI5quhz4/IdLPmbPeQWjW7edGmKhCYURSJQMN/wYsEbIwQTAhhMJlEf
	x4aM8WKVXiBYjAnck1Kebepaqz+vhkGXLReGau1m2KVxIUh2AWtTpGOu4q6BEsW6+UELvA7qjsn
	vsQ8L8Bp5kNBGmD7QlbE+bCuZpZaAK0azJUydeHBLShkjN3HK7
X-Received: by 2002:a05:6000:46d9:b0:45e:ed7f:1dd with SMTP id ffacd0b85a97d-46662334b91mr4727341f8f.25.1781988284592;
        Sat, 20 Jun 2026 13:44:44 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm12184790f8f.7.2026.06.20.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:44:43 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 41C3BBE2EE7; Sat, 20 Jun 2026 22:44:42 +0200 (CEST)
Date: Sat, 20 Jun 2026 22:44:42 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Alejandro =?iso-8859-1?Q?Oliv=E1n?= Alvarez <alejandro.olivan.alvarez@gmail.com>,
	1130336@bugs.debian.org, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Bug#1130336: [regression] Network failure beyond first
 connection after 69894e5b4c5e ("netfilter: nft_connlimit: update the count
 if add was skipped")
Message-ID: <ajb7ugG5mYxYIPva@eldamar.lan>
References: <c72a56ab-a16c-4866-9a44-a03393f074db@suse.de>
 <b3cbfd15-acd1-4500-ba30-eac6f48523fb@suse.de>
 <abW2MAAqLnKZm3KF@strlen.de>
 <177322336258.4376.10097494324750307114.reportbug@Desk1.simalex.iccbroadcast.com>
 <4da571ab-fa1d-4ee6-b71c-24f4a28243ed@suse.de>
 <abqfSB0TUik1kRU4@eldamar.lan>
 <e24a281622cedf9e8f4dc93c961813aeb7b6ce4c.camel@gmail.com>
 <8788e351-553f-48da-a6e6-ce082adacb8d@suse.de>
 <0b8607c8-2d29-4fca-961a-b7a677e968a1@leemhuis.info>
 <f67a985f-c6a0-4796-b255-59d99e317b6f@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f67a985f-c6a0-4796-b255-59d99e317b6f@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300846-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:regressions@leemhuis.info,m:alejandro.olivan.alvarez@gmail.com,m:1130336@bugs.debian.org,m:fw@strlen.de,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,m:alejandroolivanalvarez@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[carnil@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,bugs.debian.org,strlen.de,netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eldamar.lan:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 003246A9B6C

Hi Fernando,

On Wed, Apr 22, 2026 at 12:32:34PM +0200, Fernando Fernandez Mancera wrote:
> On 4/22/26 11:18 AM, Thorsten Leemhuis wrote:
> > Lo! Top-posting on purpose to make this easy to process.
> > 
> > What happened to this regression? It looks a bit like things stalled and
> > fell through the cracks. Or Fernando, did you post a patch like you
> > mentioned? I looked for one referring the commit or the reporter, but
> > could not find anything -- but maybe I missed it.
> > 
> 
> Yes, it stalled and fell through the cracks. Let me prepare a fix as I
> mentioned.

Did that happened? On a quick chek at least 7.0.13 upstream seem still
to exhibit the problem (or would it be fair to let this usecase rest?)

Regards,
Salvatore

