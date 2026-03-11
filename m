Return-Path: <netdev+bounces-266691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI16As2SsWmRDgAAu9opvQ
	(envelope-from <netdev+bounces-266691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:05:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8CA266F44
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DE093170650
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25693A383F;
	Wed, 11 Mar 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgP3KJaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB93CEB98
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244901; cv=none; b=TiKZIrAieCSSRJjhMW1bAHJXB3/zBjhNQ2MyzZhmApHG44tG3lwZpV4D77AyUyCTaIBEKC7yoCiaMXnueubkGmNGEnw+VCt5iG8B5+F8xrvMNFkz65XAc6FuR0G2hrbWUF0F4teBmC5Smv5GN6C5YeHcfEDIwUU7JPi1O++fGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244901; c=relaxed/simple;
	bh=alZSKgg1lU1wQh0A0HBF21ufoC8erK4cgoNEO+IVhhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cerz5r7SaaPSsudYg+mQl5ltVhjraWL2EqGOpqxe+MlV3Cu/3PbYxOI4LwdA9epVWfbIdHGXcyo8dcFkjq4/eOGqWsRg79KddicgPja6XokhbpKcWkNvHD5djoc2kbboE8gx9ZfSPGsno0A8xSFVbbfClXmRH9IFF2/ohkT+mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgP3KJaq; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b844098869cso1293344166b.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773244899; x=1773849699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ9wJHN98p2eqW+aluFwwdS4VIjV0bOaQ4w+79zBhNs=;
        b=rgP3KJaqF2BlecOpPvT5kKAcfsza44TQB2S2rx00vuamlvPC3PCFQtN7iBBVErQ0kT
         4WdJtxceJIxgfEoqrKiMSBM220p/tm52QxQ+p/Vm9qhMEQGFaHmneuWDzyXc37rR6IvX
         j5BlJPNzE5lVxK7VrA572ygi0hpBk5fcEnP2yH7V3Q+z+BLO1dy4fVpi0jRKEMeOTip2
         HIDkQduGaTUGLYmL2Eky5xA41gFzkVV4qEEUwksw40H4w8eZCk0GeALUIDP+Gr7DNvF1
         2+wUJnKujEB5WM6EYBJBnq343bDJzOoB3ZqK8V5pehsfNWev2da3jY31l4UTLmX5NLQo
         YIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244899; x=1773849699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ9wJHN98p2eqW+aluFwwdS4VIjV0bOaQ4w+79zBhNs=;
        b=KUSyOqj2SHTOkY3WEIQna4ohUuIdLGom6JnWIobPh6/E284HJxuaZ7DnJif8gPkd/l
         YHxNO5hUy6Ei/esRTOw9XNNRJadsjxUCmiyGATzW3NubLQzWrmeAvp0hjYZ42GRviFGB
         jJ4UAJVrJTNETokKx+iUUCpJY1ockIGLTguTeyPOB+PUx3J1OW2xYpWZ5Albac8LvpKk
         qWTkDHimPnDAcMiZN7RA/BM6w/k+XAcoHpO6CeXQ9hyCJm7y5hTSqZ4LyrnbqpamoIL2
         o876cqekdADpUeTDG9/KbSl1aRYv9FHQoGeuSr7Ezduk6fK+mNVqNV6QV64joArZSmIP
         CBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH7JouuyQxkBKc8meRZ3DgYHjnQ6kviizfXKB16BlbJpZwihPN56MxUstyigdkjDA8q6yGMWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuU1suQQ7hUuO3IaMMlB77i6AqYCVGOVY7RkdBavkUYY8cHkp0
	6vD1OzerrEbQir4JIy/dhemaPqxgW+aMPYW9u/JZ34S7yhzag1w8+GU1EPsjxgdI2eH4IUhC9LM
	2GM+Pnsa7OIZb2pj1bQ==
X-Received: from wrbgw30.prod.google.com ([2002:a05:6000:40de:b0:439:ac29:98cb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d22:b0:b93:3792:4b03 with SMTP id a640c23a62f3a-b972e4f775amr187595066b.32.1773244898034;
 Wed, 11 Mar 2026 09:01:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:01:36 +0000
In-Reply-To: <20260311120418.GU1687929@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-17-david@kernel.org>
 <20260309142954.GM1687929@ziepe.ca> <61df6369-333c-430a-bd18-c5b1acae68ea@kernel.org>
 <abE4JYo223OxWCBQ@google.com> <20260311120418.GU1687929@ziepe.ca>
Message-ID: <abGR4GWMXC2tJyr8@google.com>
Subject: Re: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in zap_special_vma_range()
From: Alice Ryhl <aliceryhl@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org, 
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
	Simona Vetter <simona@ffwll.ch>, Leon Romanovsky <leon@kernel.org>, 
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-266691-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D8CA266F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:04:18AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 09:38:45AM +0000, Alice Ryhl wrote:
> > It doesn't really make sense to have multiple binder VMAs. What happens
> > with Rust Binder is that process A is receiving transactions and has the
> > VMA mapped once.
> 
> IIRC the problem is the kernel doesn't guarentee singleton VMAs,
> userspace can always clone them with fork or something. Did binder
> solve this somehow?

The Binder VMA is DONTCOPY, so it will not be present after fork.

> Since you can't assume there is only one VMA the locking becomes a
> mess to cover all the cases where userspace can trigger a VMA clone.
> 
> address space deals with this internally.
> 
> Thus, zap_special_vma_range() is extremely hard to use.

I mean, the hard part about the locking is keeping them in sync. Binder
just doesn't do that. Only the original VMA gets pages inserted or
zapped. If you create a second VMA, you just get a useless read-only VMA
that you can't do anything with.

Alice

