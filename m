Return-Path: <netdev+bounces-269651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCV2Jn1jvGmLxwIAu9opvQ
	(envelope-from <netdev+bounces-269651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:58:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFF2D26FA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9745C3016880
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3061A3F9F5B;
	Thu, 19 Mar 2026 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cFf520aw"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAF347BC9;
	Thu, 19 Mar 2026 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953912; cv=none; b=mOweINr9/EbQzOjZs37IPoXI28S/Nz99kITK3Q4SLQyQupnx2853vOXYYR0n5svfyInuqNPBQqXps+if1+L6ca3KcDRaIHILBg3dxMpRa0EZHTiwZln4wdZRgvp5CFTxUhU6z0+PtvkDbt8lsiXm5LwqtBdJGWwgLdCdAnvew1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953912; c=relaxed/simple;
	bh=iqBXral7BgXV4bBHSPIa7H+kMBPsRpoDN2FgeDnqQcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd0PLhrV0EYW8AZLCqAtqixGa2EwtLOZsJHFpn+8clYpwnzYqavtmIYk1yJ10NlMMrwM/xmjHXLcNQmPVkpl9QGLSIG+CkUn14QO84h+weg/sQ7Gz+zQEnJODGeiBkdjkYJ1of568QA0wnZqSWb4oCgpacnzgBP2m9a8ULWJ0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cFf520aw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NGmSOgNeB1FXvQIqQTKt2rVV6pmaYTvcJ3vAUAdSCiE=; b=cFf520awxaoPx1Q5SlxcIAq7xt
	zMFTIJKJa8EAX3CoWJ55y8kCHtyWYNYfA4fcs/m375os/ifexTPOHUV59O39qRiTr3aYCXdeIu3gS
	M+lf0jguGwg2klBH04X5aa8PqwhLqWcKZF+lDHFHASDZkWNLF+0YkIWKLSlIhYGWzf121jQj8G4P0
	K5WvInIwfHuQTF3+1/LbA5BUadpbHo4H0xCYWuiUdSMwiew0CR6nIBzIXT7QUb+R6pFRB1KWmRdF2
	uHmMd8WhZsc0mWpLf4o+b1cL9VxoYGG5wfy34SwIS3bPuCkxYlvJ2a1uKc5zkgfz3J+OkzOA/SZXQ
	GLk6Cd1w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3KRQ-00000006hEr-37ql;
	Thu, 19 Mar 2026 20:58:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D39FD3004F8; Thu, 19 Mar 2026 21:58:02 +0100 (CET)
Date: Thu, 19 Mar 2026 21:58:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v7 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269651-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DEFF2D26FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 08:41:54AM -0700, Pawan Gupta wrote:
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 68e2df3e3bf5..b75eda114503 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -144,6 +144,17 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
>   */
>  DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
>  
> +/*
> + * Controls CPU Fill buffer clear before VMenter. This is a subset of
> + * X86_FEATURE_CLEAR_CPU_BUF, and should only be enabled when KVM-only
> + * mitigation is required.
> + */
> +DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
> +EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
> +
> +DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
> +EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);

Does that want to be:

EXPORT_STATIC_CALL_TRAMP_GPL(vmscape_predictor_flush);

The distinction being that if you only export the trampoline, modules
can do the static_call() thing, but cannot do static_call_update().

