Return-Path: <netdev+bounces-271736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBNHFwZJxGn5xwQAu9opvQ
	(envelope-from <netdev+bounces-271736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:43:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D032BF54
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52AA300C5AF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C32374195;
	Wed, 25 Mar 2026 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BgBBResu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471C3537C9;
	Wed, 25 Mar 2026 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471137; cv=none; b=uPBrPGsZcdW0bFTcQ0bPgMF1Sk4rqDgJx7UnIg5XtEpSQSRkN9HyoFyyx7UleTCeTg+mcA8K0Bt2qHithU/wLzLAL+j6trfYwc9pLlJu/M1JI21V+k4gWq7AvebHNu8mYmAnVbWcsiojKXYttOQ15wb7TX8ZhSZwCJIE0kH5wUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471137; c=relaxed/simple;
	bh=3qQOfI80TwhWA6qJISPfKRiQ49oBnJvL0Uq6Ke3mv2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tms7MfR1Z/vnoDKbiia/XWHXA13ZSKgQjYc2EmJEt/UZ85HYDc6zuAW0BAahEUxLUMo7fg7+stxTEn1Vx0WHlIgOU/qBr5BJLM3n5Grmu0+VlhQDp4QdmOG35MswGCxLrDPFA/eoM4+OuvC+s08/Q1liRxpjjU4bGX8/8sTHmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BgBBResu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A553F40E0174;
	Wed, 25 Mar 2026 20:38:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ys0G2Hjfo8ez; Wed, 25 Mar 2026 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774471122; bh=Kfl+/u8o55KrunJlXJFoR6X6kWZP2WOLZYeH9eXsClU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgBBResu9KUlmSMB0AlDnOVskhxO1vQosnIJ0o+a1HseLE9jTycdz62N/5wuHykqZ
	 r4vyZAjxIxb1ytUHeFWqbHNMJYUfLgLplzJ1KugiC1Emys6FYKlm/nUPOgUO4pfM9a
	 tUxAhJthc7YAR9CIliL2mgVVqRsDkWjwBi/4jKEVVhiORDNXmUw7ZdvVBytqWYjb7v
	 glspvfPjFJo1oQb7cXPojfG1qZUO0Ufk4g+RXGjPC0te3TI3qoEdv9gLisuRL7vD0I
	 psEWsk016ZBd2LWaD05kWo0PBPXgrdPI4jVyKp0lwLcPygt8oNHLEPBLO1qKgKyY7x
	 zahRc6MYvgv0Yc1aBUPJ0KrKEappyZ63ZigC3LRW2BZMa/jiVnMwC12ozh+I4WeE3i
	 x9eR/gBVHkN+Jtwm5nCY2jT1SIt/IqoE2i7E6L3nxzle21THCT+NVo+6xVKRmgE5Kk
	 O32BlK31p6qCxEybh9gs5ik8C7PiM3CTi/lilqNKuwV2mYOwsb2qq1/NFi7iuYtTq0
	 BLsLUnEnw++SCenos0qik95nxuehLpYB5olExeB9i2chG9j9a5+xAGnVrd3LAInyiM
	 eYD31FXqpqEiofiu7R+J7BxV4YMFOAti/ouIFm4DY2MN8poNCycA4fc3wZTNvg5y1w
	 4edxwwWMF2fcaEHXZtMMOzcI=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 872D740E0031;
	Wed, 25 Mar 2026 20:38:04 +0000 (UTC)
Date: Wed, 25 Mar 2026 21:37:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
 <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
 <20260324221308.7sh6afdy6r6tsf4w@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324221308.7sh6afdy6r6tsf4w@desk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271736-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fat_crate.local:mid,alien8.de:dkim]
X-Rspamd-Queue-Id: B42D032BF54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:13:08PM -0700, Pawan Gupta wrote:
> This is cleaner. A few things to consider are, CLEAR_BRANCH_HISTORY that
> calls clear_bhb_loop() would be calling into C code very early during the
> kernel entry. The code generated here may vary based on the compiler. Any
> indirect branch here would be security risk. This needs to be noinstr so
> that it can't be hijacked by probes and ftraces.
> 
> At kernel entry, calling into C before mitigations are applied is risky.

You can write the above function in asm if you prefer - should still be
easier.

> Although call to clear_bhb_loop() will be inserted at the end of the BPF
> program before it returns, I am not sure if it is safe to assume that
> trashing registers in the path clear_bhb_loop() -> __clear_bhb_loop() is
> okay? Especially, when we don't know what code compiler generated for
> clear_bhb_loop(). BPF experts would know better?

The compiler would preserve the regs. If you write it in asm and you adhere to
the C ABI, you could preserve them too. Shouldn't be too many.

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

