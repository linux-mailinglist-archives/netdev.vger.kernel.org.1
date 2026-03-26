Return-Path: <netdev+bounces-271963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBP9NaEJxWnn5gQAu9opvQ
	(envelope-from <netdev+bounces-271963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B5F33348D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1246031FF122
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36963BC66C;
	Thu, 26 Mar 2026 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ijMJ9dSk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F343DA7E0;
	Thu, 26 Mar 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519337; cv=none; b=i48molvcGsAOMoqsgYwkZRQ2mP/hLb7a+1Sl0DXjR74+Q8D76l4Cpus7/2vV26UAyHoxnyieBNoybmofev0b8BV3FelY1DMn5tyV4b6AYRJowoUWW/YzDyacjQxP7cI3Q9e+0/WdAultYkN5m0syEh9fP/WMnyrGHObX26ooBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519337; c=relaxed/simple;
	bh=UXJmkilgCUI/u+gPAR4mHLGMXteOiBgjgCWr/Gty7iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjLNwmb5JR2YXoMK5ZWIwmBuq7cpiBJ1Ya8OD3hrBPaSqfglZHPh6kKkUUcJ+fjz+qSPPj6BSXTeeDmLcMwog9vkNNPnW5la3ibw+P/irrLFPHsuyK54yc4ZK/mEzokr+xPrf9yX5LOGCrG5BcR9gROUd03cAqrRt3gXgJPwvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ijMJ9dSk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8492640E015B;
	Thu, 26 Mar 2026 10:02:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MsheAMuzPrx7; Thu, 26 Mar 2026 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774519325; bh=C2mWFe1qNi3PMZA4pOcAbJW8lmILDzuIi8XH3/XIOf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijMJ9dSk7+FFkbX12jIwy02uXnJL10wiFXoCPlwyUqT13WtlMZYKjbxhSv6iYc2V8
	 nUsd00ftkQEUSwaK2E8alb0ef0/Xupyc18HwfYLnMtaijlwsn+75oPXw9IfCKIFI83
	 RHVX7eE26VoJ5RkSC25P344LGu7gvbWuaxieYQirZGWgh6SzurTshnpHRQ00s4d5nj
	 CNbq3g4A7hcApqUVqYTdPUzLrN8f8Yz97R8rmza03yD0SKlewWB23DacOnI3rnbs+e
	 OfLHcLTgKyi0xISxpH6ZxdE0XoT4Tg98OsWAocu4lxrtE/noMbsP00NjCt77wGW0BM
	 LlodWonuMOXUtG/PQwiUnR84xAs9n8OB5RedkQC/v7W6YTECWY+QjdAXmMiwddEYnS
	 HckdK7FGeZtdMD5SWlmZ7HEIyCFn5WEHYx0OEe94m7OecMA0vBubPauJQrCQFzxUHm
	 c2kAHHiOlnKIdCpDEFfvGX15hQ/NbwV5R4yxFdmd7+RLQSbY19hvOVAXwGQrz3SDbn
	 ioNRWPdf69PAI3UX7KuhcQ63egfggLs8jKUJfW5mx7c445PFGK1T3Eud9r2pJisEWG
	 /xTdFmPl3sUGISDldtEsZehMg3aiW1BhxxDgHb4cJUS1Oc+kD8NmUhVFtMLfP+6SlB
	 XQ4dP5hDqOLsb+WVplWrz9TE=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BF59740E0140;
	Thu, 26 Mar 2026 10:01:27 +0000 (UTC)
Date: Thu, 26 Mar 2026 11:01:20 +0100
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
Message-ID: <20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
 <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
 <20260324221308.7sh6afdy6r6tsf4w@desk>
 <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
 <20260326083934.fk4wyhe6rgiss34z@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326083934.fk4wyhe6rgiss34z@desk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271963-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:dkim,fat_crate.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60B5F33348D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:
> I believe the equivalent for cpu_feature_enabled() in asm is the
> ALTERNATIVE. Please let me know if I am missing something.

Yes, you are.

The point is that you don't want to stick those alternative calls inside some
magic bhb_loop function but hand them in from the outside, as function
arguments.

Basically what I did.

Then you were worried about this being C code and it had to be noinstr... So
that outer function can be rewritten in asm, I think, and still keep it well
separate.

I'll try to rewrite it once I get a free minute, and see how it looks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

