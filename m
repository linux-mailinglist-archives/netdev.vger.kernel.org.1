Return-Path: <netdev+bounces-285979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECAhE1xQ/ml/pAAAu9opvQ
	(envelope-from <netdev+bounces-285979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A967E4FBC0A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2EBD3031AE8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474263DA5B1;
	Fri,  8 May 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hZ6JYsCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47782225413;
	Fri,  8 May 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274393; cv=none; b=iTnMbibu9ayS/aUKo9C40bAe3RSYj6gnEA1w6O09jebQy2OGQHE50y8pKfYtMr6c1sIZjXy9CWErE6oLILKEXoFjZwSQl5j8ltW8Fdcev6xl3hA2+05gToGpeBe6t/odxuML8VBTjxZDe70bhtoWehFF1k8b6pO6/olvdFAoujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274393; c=relaxed/simple;
	bh=T0eWHYvoB32q4/LjWG9pTPZE5yTNYbilqq9QRe3btmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4vFWUzTpNSMQvJnSrfaMkf50EKz0Bn+YIDJTJqEN/qyNIa8Mg8NoHZUAXhfbu/WN4yhJGxcvxLZKuo97vB/VOSIIssUCtUNaNChho2zhxbLfsgC87NUmlxJxBal1+EqqxUOFjdqXxygqOMJfNxY5LtH1pbpi3yzgFkZKB8po8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hZ6JYsCY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7680240E00C2;
	Fri,  8 May 2026 21:06:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hgMfzb9Q01z8; Fri,  8 May 2026 21:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778274377; bh=THjyDfJHG7KW9npiqBHK3HlBg3FTqIowEJNRgPMlB/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZ6JYsCYHUgII6cO/Pj/xxaMkCexjTFlixqmNXNw918guUvdWQNt98LA2QtBpt8oh
	 2G6VbNwCsf1GFoey3tSlMK+l2dB/3LEDfUOc6W7g7a0WEMxfy4oBTzFnWoa08TIvGM
	 H/FeXQqiEkiH5Ac6wIly0j5pb8tqcXvWUYY9sF5P1NSiM/ijHl3gSbroqzXvr+MSxu
	 tI3NpnfLfMmvZF1HmRuEYVqUye4oXpKPeO8hxkxTNUgIuCJ/Tpn3EBZ9qCX8frgC0w
	 B1lIptOv7SA00tM6phu4KI6UahFQui8Ly0kNI+IriGaJAGO4qQhELbnGzoMv37xfKC
	 B/AcsJTnS4HzUcG77+KdyUMG0maJZFvuI7xhlGLHbESKNSz8MFMXMR4l3OZFblsjZA
	 0fN2qlB1egK7K2LAaqxPFw9pOSsiSkJ08ap0TzrcXha9IklHyx49UuhlbXz/J1N3hC
	 kcwh8KR1xqkXVleNxkXmuA7FpWpZTkeUdqic8/Uwu9LBmwbW3ss2+Xn9d+RD0ya7ZA
	 GqUcSfYtwystf/w7zBknjGt0ULLwYQcm1/cS2GkkqdxFA7GiR54QMv4zSjv3VUYnWP
	 svxB3a4hPt8+UV52rUrfb71bKpwutQXDLkOL21b5q/EMV6wGTSk3kKjk+2eZL6LPNu
	 EZLlRu8V3SW4Uupd9i5VmLZM=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E01BC40E014B;
	Fri,  8 May 2026 21:05:34 +0000 (UTC)
Date: Fri, 8 May 2026 23:05:27 +0200
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
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 02/12] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260508210527.GFaf5QFz61RmSRBqKT@fat_crate.local>
References: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
 <20260422-vmscape-bhb-v11-2-b18e0cf32af4@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422-vmscape-bhb-v11-2-b18e0cf32af4@linux.intel.com>
X-Rspamd-Queue-Id: A967E4FBC0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285979-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

On Wed, Apr 22, 2026 at 11:15:15PM -0700, Pawan Gupta wrote:
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> in the kernel.
> 
> Now with VMSCAPE (BHI variant) it is also required to isolate branch
> history between guests and userspace. Since BHI_DIS_S only protects the
> kernel, the newer CPUs also use IBPB.
> 
> A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> But it currently does not clear enough BHB entries to be effective on newer
> CPUs with larger BHB. At boot, dynamically set the loop count of
> clear_bhb_loop() such that it is effective on newer CPUs too.
> 
> Introduce global loop counts, initializing them with appropriate value
> based on the hardware feature X86_FEATURE_BHI_CTRL.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S            |  8 +++++---
>  arch/x86/include/asm/nospec-branch.h |  2 ++
>  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
>  3 files changed, 20 insertions(+), 3 deletions(-)

Simple and clean - that's how I like 'em.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

