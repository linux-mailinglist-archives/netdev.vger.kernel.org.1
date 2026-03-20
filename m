Return-Path: <netdev+bounces-269860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L7DGogNvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:04:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E082D7B25
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 640813006B62
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C034D4F7;
	Fri, 20 Mar 2026 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RX25+PQ/"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE31E98E3;
	Fri, 20 Mar 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997445; cv=none; b=udmEJxiMrMLJAcPd+T2Hp/8R8ORf6cSpXzOF6ZpCPFnKwdmx49u9I234I/YLEkB9KsCjw3QqhnIy2/Ag/T1Rp4oeR0IwrK7bzj5oFg2878XNh/S6UDRoQWp01AtNgrSsVUxQGOobWDAa1nlnL5ytriB+TzM51S1mE2u+M3CAZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997445; c=relaxed/simple;
	bh=tLRV6GWt0nIH04h46cD5fAI/puIETbeyPGCSNjkPhWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL7hvZbt292QRRLw7vgnsI7i26Wq/vQqFiGacL/KmriXThMJmoSwZlVyTJXbeimF2ciHGmqqSzR9X29D3xhSdLni2HV7KN5EDu0olS2skY9K1NTaDwit/VocaIhXlTX53+XpPqnZwRa5S5YteoIFFi+ktYbSRwkJGt53DDbdnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RX25+PQ/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tLRV6GWt0nIH04h46cD5fAI/puIETbeyPGCSNjkPhWM=; b=RX25+PQ//oLNIUwog0UzVIbDEP
	uQEotUlu63UWGNG7lcvdJFT2beO1gYq+/Qvr896xR5OnHaQCLVudBWoF2v6l+hrS0/RzZzRpdcccu
	fm+eBa7b22mZBFL5XFMn2S6+/vGbJH8Q3lo1DyYzBasF+rZOv79yMWc32W1tj00eTIe9ixzYixqEb
	A5Zz7rQV5VAIMb7pf698D6LwS4Kk864K0cRZvtlLWLhke52kWXWI3DcS0gJ2QF2r38g8/4iXZ9NNP
	zcvek9+l0a5HnoqZlql5Ciaxl+ISS/w7OAYXgmUA5Z2CpPGv/zfSLYJiJjaGv1NUEArV+zSnPukln
	2DyVOwwg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Vld-0000000FCA7-0OpM;
	Fri, 20 Mar 2026 09:03:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 37587301150; Fri, 20 Mar 2026 10:03:40 +0100 (CET)
Date: Fri, 20 Mar 2026 10:03:40 +0100
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
Message-ID: <20260320090340.GN3738786@noisy.programming.kicks-ass.net>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
 <20260319213421.br6na4dulrjm6eke@desk>
 <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
 <20260320062206.bdrnmnvho6lhmejw@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320062206.bdrnmnvho6lhmejw@desk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269860-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: 11E082D7B25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:22:06PM -0700, Pawan Gupta wrote:

> This plus extending it to support EXPORT_STATIC_CALL_FOR_KVM() is probably
> a better solution. Please let me know which one you prefer.

The EXPORT twiddling will do I suppose. I'll try and not forget looking
at doing the RO static_call thing some time.

