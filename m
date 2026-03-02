Return-Path: <netdev+bounces-262609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PtZG9dppWkaAQYAu9opvQ
	(envelope-from <netdev+bounces-262609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED01D6BD6
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF9E53055C81
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82A335067;
	Mon,  2 Mar 2026 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rq4xdrlu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B447332EB1
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447631; cv=none; b=oFM1TujBJzJ56sGJxU6ToOT1AyAKeoE7CbMD2hsedHBA7EC+Z68yteSsJQsSdEeieUwCIH0ud9wfvBkH8NdJAtj9r55WhJRjd/4UZsrX+K6gO2hcT4fs4j5SieqoCnECwLAU4rVFF4MjxOG18OtOqF0Pd9vj/eG06pBPKIcmT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447631; c=relaxed/simple;
	bh=QEn+El7Z+bL/DWqeCCzlYqCfrkxihEN+xIGAxOA2r98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tjKDFGip67IkJYM0LPTLEKGtXbf8d/+r9pf+PP6QiBtiATrHLF3EwmuZkBRrqRtjOabCcxm80F3MgXOXMTi/aELXQ747TfnsaMT//lVVGC+XwZdiaQACz3PB7nzIX/SJS3Vsbj6FxHjpCmflEaz4W4DxAgQmIpxHf9mNrasKwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rq4xdrlu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso55051055e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 02:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772447626; x=1773052426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnMgJMcaQgCDj7i00Uawlj/G1rJtXPwe1sCLwvhoFHI=;
        b=rq4xdrlutDZNzchgca2LpBR52y6AVtdV4PS2i7Okgss3v9KH1sO1XKDitIIPzPn/hI
         IIqBvmSXgRGHTGiuZ2XWX5Pua3XkiI1cc6lsjEoJf15THOIKyZkqFuCYgr+6DkhGcWbq
         zmNhmcRRpDjeE4c/lOsqWaUl7ccq5LIpH087AwRE7M6mp8jAvMMQTC0dLUrRHa5N6j+y
         qnQVaZXoQ+z5FqKmO3oODPKlACGy9IKYFof51fLeqJh/4dwg7jhlPr9QlqoUYGSz8FbL
         yQAzPFa8B5RV1degHbdqhI7/iD092kEARW9Nm78z08vqGCxZw109+IAio3IZyqGc1FDw
         0tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447626; x=1773052426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnMgJMcaQgCDj7i00Uawlj/G1rJtXPwe1sCLwvhoFHI=;
        b=HxdrxdozF/BTgQTcDIPaW6gNW6gxNVaRgL/jLU7OaiEGgTxb3CWyOJqh2feM9cD6IV
         RWytzgV7hACS97OypwofvQMy9mmLeCvKmZ0pC77qMSq8dbapOcR+gIQ4jfrsAxOnMF7d
         vxgIasLYnfdMjXpx39pzh/1eBf0+1TMugpZBteSzxZVOEkrpGZGgZyN+vlTjmFzRZqpw
         9bLLC+QrGbDgG+QqCZJl4UEdsRGL5DTvBlXa8EyWe7Om42/t9XsdlWSMBVBuAPAHHkC8
         mqxsNPkv/Rx82jnqdArjhKjlyQdbqRGNEvmy+0cHgiO10sk8tQtVne/Ulb5UsRKcsj+q
         lmBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCOxMFBzg9lDhIgXcMqnXC6UUVM33l8sObyLs98I4WludS37Ekwhq4DC57se50lUo2NupaHfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgGZvxd5lo9UVQE2Z+DxHVEp+8sPlAIH474Yin6T3Y6Vo61SJ
	pOo7KsNVdEMGb4mES8ZOAW1IwF3nHa9mCF+dBybnfckwN+64/fcgZX0k9uM00WgNAg6V+XVQvew
	M9FaL1PlQPrM0nUbWng==
X-Received: from wmdd1.prod.google.com ([2002:a05:600c:a201:b0:480:3227:a124])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6383:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-483c9bdb683mr186031315e9.32.1772447625915;
 Mon, 02 Mar 2026 02:33:45 -0800 (PST)
Date: Mon, 2 Mar 2026 10:33:45 +0000
In-Reply-To: <f2f3a8a1-3dbf-4ef9-a89a-a6ec20791d1c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-3-david@kernel.org>
 <aaLh2BxSgC9Jl5iS@google.com> <8a27e9ac-2025-4724-a46d-0a7c90894ba7@kernel.org>
 <aaVf5gv4XjV6Ddt-@google.com> <f2f3a8a1-3dbf-4ef9-a89a-a6ec20791d1c@kernel.org>
Message-ID: <aaVnifbdxKhBddQp@google.com>
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from zap_page_range_single()
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-262609-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBED01D6BD6
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:27:40AM +0100, David Hildenbrand (Arm) wrote:
> On 3/2/26 11:01, Alice Ryhl wrote:
> > On Mon, Mar 02, 2026 at 09:18:45AM +0100, David Hildenbrand (Arm) wrote:
> >> On 2/28/26 13:38, Alice Ryhl wrote:
> >>>
> >>>
> >>> Please run rustfmt on Rust changes. Here, rustfmt leads to this being
> >>> formatted on a single line:
> >>
> >> Having to run tooling I don't even have installed when removing a single
> >> function parameter; did not expect that :)
> > 
> > Well, rustfmt comes with the compiler, and it would be ideal to build
> > test changes before sending them :)
> 
> At least on Ubuntu on my notebook where I do most of the coding+patch
> submissions it's a separate package?
> 
> I do all my builds on a different (more powerful) machine where the
> whole rust machinery's in place. Further, build bots that run on my
> private branches did not report any issues.

There are some build bots that check for rustfmt, though not all of
them.

> > But no worries, I took care of testing it. Thanks for taking the time to
> > update the Rust code as well.
> 
> I just did an allyesconfig and it does not report any warnings.
> 
> So apparently, rustfmt problems not result in the compiler complaining?
> 
> Or something else is off here that rust/kernel/mm/virt.rs won't get
> compiled on my machine, even with allyesconfig. I can definitely see
> some RUSTC stuff happening in the logs, like
> 
> 	RUSTC L rust/kernel.o
> 
> Thanks for the review and for pointing out rustfmt!

Similar to kerneldoc and other similar targets, formatting isn't checked
in the normal build, but make can be invoked on the rustfmtcheck target
to check it.

Alice

