Return-Path: <netdev+bounces-271980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAZrCSQQxWkI6AQAu9opvQ
	(envelope-from <netdev+bounces-271980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:53:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D9333CBF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77966307BF2A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8F833ADAE;
	Thu, 26 Mar 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLI58UJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F7322B7B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521962; cv=none; b=PQXkbdKRhm0tPJayKj1ntucUSpMYu/28CWIfLtivnKkGy4IHBWkncC7fNA85OfCJOM6RBbT7loxDJf8NVBsEd9IXKYRACKZmgatSz7BCY5SvhfBPp2TJrccWTuyae7dQUKxhTxx4B84BZnFG8S4c1J0pD90tOn7wm6vTpNgzjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521962; c=relaxed/simple;
	bh=64Fas5hYKuMJHCmYPOt+8bmUOjahEq8MaPoJMlkt2pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9wO+0LF8oGP9V64HpVYG6xD2RwKDrjLtPuKnS2cBB4Ma17Qs+PTmMGSpHmEOu2ayIMy/uKmIil7pZpuixgcWPvFxhleZNKeYCwwGsikRF75hDXxJVw/5EJzcacyB762llCijdQ9jZt1ekUnrz3oG8rEPWMKXWWeN++FS5jnKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLI58UJ8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so6160995e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774521960; x=1775126760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWeS487NzYUaa3hGKWOyH/n+tSqTSbzSaVNvnjqb4bk=;
        b=hLI58UJ8v2QepCbMQ7JXS34BNPDhv0dCXKaAHRysAX/8YJJ5cIP4FVXpB5Dj7sVUsj
         c7zeZDyRI2tLXE4fRHkuju7HFVHxZFEwouQq6R49k2w53PL/shhfNNzk6wDTbkFyXEve
         5SfNlCSRmeBRfnzPdf36kfW5+5lnEYBj4EMvoOyqMDWfvenhSQIfiNm3ggi4ZmntM7ot
         HCogKDoNDiuGehloKtT4Oygmb1LvkNv7k452N1cZ/tVd3k+U6cuGuCOsVxoIOzVD4ifk
         biF43fIKqPSOGULHXaI/prV96Bp+hQnBG386+/m6WOVv3jojVD4Yx5ce0nlhbEZTZ8Gm
         lR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774521960; x=1775126760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWeS487NzYUaa3hGKWOyH/n+tSqTSbzSaVNvnjqb4bk=;
        b=XO8I/HBt81YODag/3jRRcwpaldUHUI7wI5j2LnwmTifh+aBvs2f5P+/0cg4D9nEqdX
         W6XetunF2wfXCrnj+Q2OuzMrekBU72KfsZ+rS8TqBy9hW4UgId5Q8/+ggljKcKrYGcIV
         DW/iF9cH7v+OUUpO+G6aXJed6+2Bah1G8z50MtZndHv8zEYB0vMdenNn286qA877Nh8u
         Pse31Ci2XzBUHUdz3CW38dwXLfkiTw37Fbvq4OXMA0I5p6dMi2AWrAOEA9pHe/7N6m7l
         jRwPJzS+ZnjjjqyqFw5P8vj8B8V/Edfr6i9cjeImlO06gAlVv1QXspBrijKi7ugLR5uV
         fUOg==
X-Forwarded-Encrypted: i=1; AJvYcCUXlP+6iEiND3SnATSaaFb0pldGhYC5T5bSmfqn5K9Oh1UwW6jQS4+tAUAXLg8vQPMv9PuRv0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9I0TxaRorCw0N0WN82ChMqRCfZRDIAdcCx0NOdyHpZcjt6c8i
	9wq51doxAOMOD90skuWRXggIf9jQeuy7GMim4LD5jsBQbwM/MgaGtG3s
X-Gm-Gg: ATEYQzwrQa3mnasOdBC6MeCttfdY7A23OeysIBbZ0j1RGrFSEJcfCJrqwt+pM9UV+E8
	6R3otyIvmdT5GDjBTlhTxppeurLln0LWvFrYGmoUuJC53WPj2IKmRnElNXxZl38r+cX1X2SvTLE
	caVqE7PuP6Ttow/e+67r99nfebvyF3NCIi/VAnFqLSYA4UfEzgKyS8ugk9InsP3naoMteD+xuoi
	yu3Hc8jWE9I6tVHWGrh7a9YofFqNss8po8zaB3UPONvi5/8x0KCJQMW9zMXnE5vGe66OJhcLmlv
	fR+0TXWiGtVfpxkpe74qAcLVius9ThsVnOnqGhdKvS0jS5Cr0hDtzwGUXiuo5DJ/HvOs+fEu3Rr
	LskN69+IlFLAyBJtlO4nGEbhCfkYjdjq6L4kir676jFSpAB1cjnJANufLP8+n4NV/uNUylWIj+E
	K02gmdoZtYbBcYC/MxjQp9y+mpaYAKYjzmF3qpda0fwoluVgN9+3G/ltld/Onvv6G7
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-487160881a5mr109891615e9.31.1774521959596;
        Thu, 26 Mar 2026 03:45:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df6d4sm6790010f8f.25.2026.03.26.03.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:45:59 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:45:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, Jon
 Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260326104557.24295cbb@pumpkin>
In-Reply-To: <20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
	<20260326083934.fk4wyhe6rgiss34z@desk>
	<20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271980-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D4D9333CBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 11:01:20 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:
> > I believe the equivalent for cpu_feature_enabled() in asm is the
> > ALTERNATIVE. Please let me know if I am missing something.  
> 
> Yes, you are.
> 
> The point is that you don't want to stick those alternative calls inside some
> magic bhb_loop function but hand them in from the outside, as function
> arguments.
> 
> Basically what I did.
> 
> Then you were worried about this being C code and it had to be noinstr... So
> that outer function can be rewritten in asm, I think, and still keep it well
> separate.
> 
> I'll try to rewrite it once I get a free minute, and see how it looks.
> 

I think someone tried getting C code to write the values to global data
and getting the asm to read them.
That got discounted because it spilt things between two largely unrelated files.

I think the BPF code would need significant refactoring to call a C function.

	David

