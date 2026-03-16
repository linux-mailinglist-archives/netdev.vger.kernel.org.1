Return-Path: <netdev+bounces-268123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKO/LfPot2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:26:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F14298A51
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A443005763
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D228B4FD;
	Mon, 16 Mar 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c91I5Sta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97A2848BE
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660242; cv=none; b=OF5Hvn9auDlEedpsOG3nPLZmGatAHp85zoT2qiRB4s3PKZ0O8BUU0bpT0Ff95NkHILrIiLBWuSfEY6lMG6CWUCQNUXbgRk7m3j6B/cegK3WHoaBpB9xWig8jVuWEGxktvrATivQ5nz6BkfTuEECzFZ4v+LO6ThraeCrVY9Brt5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660242; c=relaxed/simple;
	bh=WXqCX/DwBCUUGd2jxkGds1I18CJzM7++LkFVv7eZUz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AONC5wiLllQZN1fZK97MADi1XPabncqBrBvhYPsZN5NZqyYJHN1IaBFS1p067FFVynKjW6EMhpgu7qZ7ijFxJJaPCJTIFsXRkAO0VXhvJNJhz0AtYosdOt7YFFZ/yzcaXgeSQvwhcLhsqVFUIBYckin3ljVsFGEnVAhRf10iw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c91I5Sta; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7393536e53so1700097a12.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660241; x=1774265041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99La0VK9SzA1EiGQSH9RsVBy9sx23iujvFhJrIbJm3c=;
        b=c91I5Sta9FPou4QPyGld1nQtc6FYG+eV4/i6WzSa98TAmefoRw8phDMP+FMRt3uqbr
         l5HiIr8J1aXqDqCvFW7MrCt7dFLhR4H1c4xRivk4lNxlMmOkVBT0zYJBzOeIKBRU9+oj
         C5csM30Nk5Vld7ybHd5dtjnjW/EtW/OSNCvehnXltBTK0lof/Yp5ZGxEZhrf6ZlxW5iN
         5n/9sshvHozlfeB29rlSIzjMcfQK/SmsYshoCxwX+rvdAAlW3n74qBcGtWCa5rh6WFjf
         dt6y1UPEa0TAAur3Gva6ABTRd72bvhIkgYcd9p6QSKxV3L1A9gnZJKi15ry7plOxjJtZ
         fbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660241; x=1774265041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99La0VK9SzA1EiGQSH9RsVBy9sx23iujvFhJrIbJm3c=;
        b=Ouuj8Jg20Ex1zob/Wn164UaxMx1gdOMJJ0hIoh8OU467Lx9XORDufkRsHqTL+Wsj3w
         P9K0zDeXjV9+qUhuaUWSzOu2OLeOhyeZmGohXGQQkDVKedIeLlMWKphs/zJ46KZjGVUU
         tSITpiZdP4FTTVO8yEnrc1Mj3z+frWBUpSm5xepwvd/T1J+KSrfCdGIUPS3BoL3NAXjp
         Y+QT+lX/cQLMhYGLU43n+viL28akLcUwyt7UOhlikNm4zXoXg3SFGMxEMPp+nKRFlUlp
         rST8cTFcVxYGMAIdYMZk4skWrAWnwKnEkRkW8R6gH+x1aBLayEJRbT2MRDzbK5Dwv5EW
         p7TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnuI6rgiRHgLVzzIWwVuP84Nq7Ww4w5OkdLMdj+oHpSetWLKZuPJ0/AeYnHG+yGPD6YOAfbSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrSd4/lSrcDe47lRuw4qgV8O1F8h+NxTvTalfMhmHq083K26W
	bOU/1fxwF17VtN1KIUqNKUX8nGD25j7mKVQHOBEmVX/S8Iv2Nmumxr6+
X-Gm-Gg: ATEYQzxEErsLgdqxThe7xGCpyqCIbLViptHhMF1qVqUOAPHutDZ5klSdCkXls7+RMQP
	3kx78YwDqZeuUnDRpoqYxm6aJtnBnhaoeX6Jfp7fvF7Qld/tFmixLpGkLKU8CRdhF/pTH85KnLP
	Q3h0ikq343efmkFrnyp1MnN8J9mDIrhIEjlySlb/IkHOEdayjVzA+uKL7nZK6YE66quXYRCVs80
	Hvxe19pR2LYzwynNZeUXOygus5C5MzyAuZXkgFveb53a9mNo5MMowfK10lw2YzHguon9oU2hoWP
	OqdkoCh/eaEDbulM9q+ZFYEzew3ETqJG4byG2sYtXwzjNvPR84/IYrrsIj+egYZnd0xCp6YV4x4
	rBjDu8ZOX2tcr0HVhZ4TFcOD9wvVcj9PoZa2lNlD5rufkZaveGzfUYEXJnM8X7UT3xUS2X79dV2
	LUf3h19AP2FkcXMX5PsRp1chxjqPjAxnWX0Ba6fYNmh/ldnihpahTJ
X-Received: by 2002:a05:6a20:2588:b0:398:962e:83d7 with SMTP id adf61e73a8af0-398ecd32e67mr12122687637.43.1773660240526;
        Mon, 16 Mar 2026 04:24:00 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c740000056esm4842239a12.24.2026.03.16.04.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 04:24:00 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:23:56 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow
 in flow_action_entry_next()
Message-ID: <abfoTBGLhav-iPQb@v4bel>
References: <aaxe-uH2Qr6qM4E9@v4bel>
 <aax2yZtJce0d19gd@strlen.de>
 <abfhRFfZ1LOgWEsf@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfhRFfZ1LOgWEsf@strlen.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268123-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 49F14298A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 11:53:56AM +0100, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> > Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > > flow_action_entry_next() increments num_entries and returns a pointer
> > > into the flow_action_entry array without any bounds checking.  The array
> > > is allocated with a fixed size of NF_FLOW_RULE_ACTION_MAX (16) entries,
> > > but certain combinations of IPv6 + SNAT + DNAT + double VLAN (QinQ)
> > > require 17 or more entries, causing a slab-out-of-bounds write in the
> > > kmalloc-4k slab.
> > > 
> > > The maximum possible entry count is:
> > >   tunnel(2) + eth(4) + VLAN(4) + IPv6_NAT(10) + redirect(1) = 21
> > > 
> > > Increase NF_FLOW_RULE_ACTION_MAX to 24 (with headroom) to cover the
> > >  
> > > -#define NF_FLOW_RULE_ACTION_MAX	16
> > > +#define NF_FLOW_RULE_ACTION_MAX	24
> > 
> > This fix looks rather fragile.
> > 
> > What guarantees that this stays right-sized?
> > 
> > Can you add a BUILD_BUG_ON or if needed, run-time check?
> 
> Ping.  I'm not even sure if there is a bug to begin with, see Pablos

Sorry for the late reply.

To clarify, I triggered the overflow using a dummy device that accepts
TC_SETUP_FT, as I don't have real offload-capable hardware. The 17 entry
scenario requires double VLAN (QinQ) + IPv6 + SNAT + DNAT simultaneously,
which is unlikely in real-world deployments, so it is hypothetical.

> response.  How did you conclude there is a missing bounds check and that
> this increase is the best fix?
> 
> Normally there should be a check that prevents such a configuration.
> If thats missing, please add one instead of increasing this define.

So, should I send a v2 with a bounds check, or drop this patch?

