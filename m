Return-Path: <netdev+bounces-268177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI4KAQgRuGmIYgEAu9opvQ
	(envelope-from <netdev+bounces-268177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:17:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31729B2D6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC07B3012CEB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0392A274B58;
	Mon, 16 Mar 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPnm+8fO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5662550CD
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670644; cv=none; b=BwoFs8ZAr6Zk6vQSpBjhH9v+pThbrv1+4m7TwWxduxI2xf8O1pJb2deCXskbZnJPLazCmyXzhZp39xQLc1dduMGkXQ9GsAeE666DHSDXVGUlZ6TgSG31TzxCWVYRgB61dt1PmrBL3eYPkYUHib8itqab4KYyxrcbQHGou8j1CvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670644; c=relaxed/simple;
	bh=4Z2qzk5Ei6buOSvL1uoB7WYzWktw+4PTaBBcJFiSR88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilI4N82j5sizO1es0Wq8C9qyQRx+woisOkPtDjccCyRxFIFFBuHFM7xqF54sH2hll0zkSUkrXKkcOcwWz1p1jZ1mK7bGawON8siCpQg2fqlxImC3yWJ0Ax1nwKwvivKhiWJUUooyOQ2YLjIhY0I98YsQOfPY/TP9uraGNBoxMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPnm+8fO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so3035607a12.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773670641; x=1774275441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSv1Zj3lLaPDzLH9nA9KrRnqBcKvmT/TBKcQ0cJ64Bc=;
        b=ZPnm+8fOjpmAC0qxw0X6BnYPOQzwpc0XzM3hsRY/wmVL5+5YYd6vM0qMRgUPAZnEPg
         hNvgZvxzvOObTkD7PFw/x4vZ7bAK1cZsfZPPbbniye7uNfXxwpzNvkuujWlWrfTF71bT
         MQ3hlpxK6SMWXocONat9sUG+vGS0I2MYFfkSOmUxysC8ZtlfMUgNdqtJpCSq3mUl+Zig
         yZZFp8HKYYUOICVZCm4YnW8o+2MQ2oET3dJSHhcG2oXc+A6xrbZnKJ//DwFMX2NgXNc8
         bYPrKC/O3aocLNdqcaEVjihAJ8SJeZIAq1QTxloWUmIDsKeB6eAMfAN5Kh+udpSnN/KS
         ZYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670641; x=1774275441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSv1Zj3lLaPDzLH9nA9KrRnqBcKvmT/TBKcQ0cJ64Bc=;
        b=FDqQSfWY+gwap6+2ev1iWykTRga63o9rKB/tj5khJVQSiKlHpoUNJ+vj6HV9Exk7k7
         Bbz26U1lX9tjfURWmFkyJ3wtSwDuIUmtBwAyA5iKnIkWD1QOb6LWcV6QsIHrbePa5BBY
         UyXDtnXjb9G69qHKAFJoMauAE02sXI9OvmoP9zqC8lBC4B1qGyqs3WQrwGt/csTrHxFL
         /o+lcIcw7Q0y9zXslnD3+V7Q66V+o9kW36GrxZDazrskX4V2ccuS4+2UumBnQW5A4TNv
         2Chg4V7FWzK5FEiQMLmd7Z3bOMjz2jz0ksXdendVnj73ol0xH1Kvw4TkRrO70nkfifj4
         EjXw==
X-Forwarded-Encrypted: i=1; AJvYcCWmm+RzFitzY9x+P7Xn3QB13WvZJSCefxkBQ0Jm/tt8yty7hfBwnre7Ns2UyaCaCSn4q3q06vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInMGQ7UVyDSrVPHbOeoVIg9K2gy/Mf/t0Wad0a23kXCAWp/Ow
	OGtGA4PEwOPeU20t5olYK4jt2oC+uD7nScxhc4NLBuqm+MW+RJNp5ahP
X-Gm-Gg: ATEYQzys3tsiWFlsqQgRS8zbBXBiBHkZ9DAiI/ysoT/du2G7YUkgCDotgow3aORuW4o
	RxuSfGkcEDQL64MBu1qHrKyqvI8vEpVcsQx2ijdQOz0a1jTnsNJwZBT0xqDMSD6YJ3EpISevZZP
	PED+kIwy9W/GljTnIOnhJrOswUAZoPDlajPdrsko+aGkaTPCuvdm/ArvnVG15Kq4NqNpcghWcax
	8IibFzbbH50DR5QheQziT6V1RC0vRzsWpfb/p3Spp7r+zOQF7J5kw6xWzZBuEQT+LL1mPqEH5pO
	BQp0fL7FLRVH2fV50A8j1VjJF7cpfO12mUNzaqOrFL48KAWGrhUkTT75KE+7Z5kcEkX9NvD1kj0
	aVKx/mEWtVH2QyFhp5t39idV2bLFai7KmAiTXKmhdaIaRdPwPoz8S7445ax3fXhyy8MYnUCzp+3
	x8ZxQ8x9PBwvYUwPq6P375PPDQzfAj6PZuuxIijk3GmA==
X-Received: by 2002:a05:6a20:6a0e:b0:398:9042:724 with SMTP id adf61e73a8af0-398ecddc025mr12516918637.67.1773670641362;
        Mon, 16 Mar 2026 07:17:21 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588f0dsm4385618a12.23.2026.03.16.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:17:20 -0700 (PDT)
Date: Mon, 16 Mar 2026 23:17:16 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow
 in flow_action_entry_next()
Message-ID: <abgQ7GSjz2v2_QnX@v4bel>
References: <aaxe-uH2Qr6qM4E9@v4bel>
 <aax2yZtJce0d19gd@strlen.de>
 <abfhRFfZ1LOgWEsf@strlen.de>
 <abfoTBGLhav-iPQb@v4bel>
 <abfuEe_PpDCyA64B@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfuEe_PpDCyA64B@strlen.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268177-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD31729B2D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 12:48:33PM +0100, Florian Westphal wrote:
> Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > > Ping.  I'm not even sure if there is a bug to begin with, see Pablos
> > 
> > Sorry for the late reply.
> > 
> > To clarify, I triggered the overflow using a dummy device that accepts
> > TC_SETUP_FT, as I don't have real offload-capable hardware. The 17 entry
> > scenario requires double VLAN (QinQ) + IPv6 + SNAT + DNAT simultaneously,
> > which is unlikely in real-world deployments, so it is hypothetical.
> 
> If you triggered it, its not hyptothetical and needs to be fixed.
> 
> > > Normally there should be a check that prevents such a configuration.
> > > If thats missing, please add one instead of increasing this define.
> > 
> > So, should I send a v2 with a bounds check, or drop this patch?
> 
> Yes, please send a v2 that prevents the overflow at configuration time.

hmm. So, based on what you said, I assume the run-time check would look 
something like this?

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 9b677e116487..69ffefbdd5e8 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -218,6 +218,9 @@ flow_action_entry_next(struct nf_flow_rule *flow_rule)
 {
        int i = flow_rule->rule->action.num_entries++;

+       if (WARN_ON_ONCE(i >= NF_FLOW_RULE_ACTION_MAX))
+               return NULL;
+
        return &flow_rule->rule->action.entries[i];
 }

However, if we add a runtime check in this way, all callers of 
flow_action_entry_next() would also need to handle a NULL return value, 
since none of them currently perform a null check.

Because of the potential risk, this would require modifying quite a number 
of call sites carefully. What do you think about this approach?

