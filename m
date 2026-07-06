Return-Path: <netdev+bounces-305042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jpSCDhGyS2qrYgEAu9opvQ
	(envelope-from <netdev+bounces-305042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:48:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBC971175C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:48:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=O5S+1vau;
	dkim=pass header.d=redhat.com header.s=google header.b=gr4VmvyM;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305042-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305042-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8068D30E216A
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD270432BD2;
	Mon,  6 Jul 2026 13:23:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDA4314BB
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:23:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344231; cv=none; b=m1GAIYNlacD/AeDusuRWYFDWAJc7IfeHYfVwVSGV/wXhuM4Eq3CMRoPNpmjB9+vprwiSQK/ode/6EvWTwAwzvBDW8aSeEuXJS4VIkho/HerZQMapvUXf+dSySSywA93wQseR9Oz63I4YhbcIUAlx0/5NSqltIrpjwhJRi5jc4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344231; c=relaxed/simple;
	bh=N0QGuvm6HyGdu49K4Td11hFP4tn89+ZNKW65vJ51WLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbN3AkeZzwGzmQpILVZJK8EmypRsyuij78N3OiS1osqJqZa9BE4Mmw6OvtT9SU64EzXF5fxCajQNwboutbVZNMgrxecLW6E9zjzQMJNea3TVHM3yBzdbYu/H1UiwG9rqQanNfhdNYvrKllOkC3IDpNU0ROlTzrwxKH9/O6V2Roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5S+1vau; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gr4VmvyM; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783344228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwaVaSQ5TrM+UFp0WZFnLdkXUL3cYc/gcLsGvJWd3Uc=;
	b=O5S+1vauKA7+XQ9M1GRiTlre7jtnaOtLM4/5Y49GQXcgE0fQRCK1ob/y4gyy3zxKf3oKrv
	/TbuuE4aT+XE+fsiiD8iRqFTPj8hbAKqUumFwYTDYVS6XCx47g6L0ExJUri7m+YpBwz+RT
	ogCAug1EChPZr33tueeYWX3RY/MUFag=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-_jrxpeU3NpqlHOcmPiJprA-1; Mon, 06 Jul 2026 09:23:47 -0400
X-MC-Unique: _jrxpeU3NpqlHOcmPiJprA-1
X-Mimecast-MFC-AGG-ID: _jrxpeU3NpqlHOcmPiJprA_1783344225
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4629f312a67so2802721f8f.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783344225; x=1783949025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwaVaSQ5TrM+UFp0WZFnLdkXUL3cYc/gcLsGvJWd3Uc=;
        b=gr4VmvyMrtRLBnl5WQXAhAg4GBCKakKO/7NFJYJoCN49Im7ZcfvUA9hq4KLZJS9Cgd
         9DwMj9+rcsbBUNtb2Ca38dTpUcvNvcgpMDwvYJDm8toHIPJNAXYMK5oe+qQG30wPQia8
         Am1G9XrgAtUeIZmo1q/B8IU0KlyxvNkKkjWDJkwpVHuCFSMXrwwwEvzDfTbwZKKJ4J/a
         nOIuTDV31bsIB4NPZdLA2YwuhYhew0vzKkzN2hl36cjSIbDqCCsj3um1QiZn1x8cWSmd
         Iwsog+XOMWZkUtu0wcTdRqjnirm8jTo1lm1yDyW0YN6YgjUgE7rNmpH6FGFUgBk0K3mH
         HtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344225; x=1783949025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwaVaSQ5TrM+UFp0WZFnLdkXUL3cYc/gcLsGvJWd3Uc=;
        b=WaG8Fwbmss5VMie7goqAufCB+Q4jDG12TbALqTyzRGhgSoI9d0ePrPF0tFtKNfInhy
         RxARdzh6382b58PW8bmes2Lv6goqKTTFicBW+e1cVPDyw1OV+6gzr3KZD6Nm5/amhqV5
         vqmCNfoVQeMlaKR/xJyD483JXy0vu/mOqJhFWNZx13OsT8JTGHUcYw7NImW6eVHQ3nzn
         B+fVftq2jQKllyiJvvHJ74xZOX+c2avrIJdyb/SfSZUxRBZAohKROimNH6NKGk85V3qQ
         aiXgSXavop8vxpYvh4eju3lnHXECMHtz9dHuHLnR51W4/WtzpsYg5NOMJgMJ67SKdMyu
         3nsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOyj4jb/9KJtMB3CNauH2pHOyjniW2mmq+lZN3DhLP4ZVoY9WsVixFJa6vBKjigKJlCJGztpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsw/c2t8RQwKjvM59E3cFk+MDTQoBukJJmJzr7HJR8wCT8OkbW
	+hTuVVGnJvMIU9nkunWMw9oHjWwAo0aWfxYklWlkqTyU7pQmxhzDXIghftwlGJk8dCROp3k88Kh
	cN1TBDQ5Nbl9WwJv48d1BWYDbIk6HFFSGy6znUz/HyiGEJEefNr6L96V1jg==
X-Gm-Gg: AfdE7ckPXxdNdSY/wu+a77RFw0/hAy6XXA4zWmlXJx/BK585XCVNh4bn0SOa1uxK7Ig
	WJIlP9pc8YiTkV1XALjQWYf37K5PekUSnUHQMtNtxXOignVO9eXKsjk3vDpxliOyqh2FEDOmAFM
	BdEhbewcUUROCCoKc/4cusSienVgibru6JOf+mCNuD1BcKJxmty6yXZqZ51IIYN9X6wOoWx1ZnK
	ozpdsWoi7HYQm9qoL4sbupIjJQYfmSi7u2OiF+UwemV3PqlDyFWMD9NFJskkZNQeJKJRgAzleRP
	sVfyFllm1WnPInEKftZ+T3XIqPpEsN0TAmydYPB62z3oc9UJCJSzdF4QAVBRRxcG+vNo8fTyNx/
	wRwtMwjEseD08/qKRUrhjJuu6RpjigUsU
X-Received: by 2002:a05:6000:82:b0:472:90af:e406 with SMTP id ffacd0b85a97d-47de66ce06dmr154905f8f.37.1783344225271;
        Mon, 06 Jul 2026 06:23:45 -0700 (PDT)
X-Received: by 2002:a05:6000:82:b0:472:90af:e406 with SMTP id ffacd0b85a97d-47de66ce06dmr154861f8f.37.1783344224726;
        Mon, 06 Jul 2026 06:23:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d7801sm25370218f8f.16.2026.07.06.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:23:44 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:23:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260706091706-mutt-send-email-mst@kernel.org>
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305042-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bacs@librecast.net,m:simon.schippers@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[tu-dortmund.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[librecast.net:url,librecast.net:email,brettsheffield.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBBC971175C

On Mon, Jul 06, 2026 at 12:11:15PM +0200, Brett A C Sheffield wrote:
> On 2026-07-06 11:42, Simon Schippers wrote:
> > Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
> > when a qdisc is present") did not show a relevant performance regression
> > in my testing but on Brett Sheffield's librecast testbed it shows a
> > significant performance drop in a IPv6 multicast testcase. The regression
> > can be pinpointed when multiple iperf3 UDP threads are sending. For 8
> > threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
> > the reason why this patch makes the qdisc backpressure behavior opt-in.
> 
> Your v1 commit message was correct.  The iperf3 tests were TCP, not UDP.
> 
> The original failing test that alerted me to the problem was IPv6 multicast
> (UDP), but the reproducer tests I provided stats for in the regression report
> were TCP "To eliminate my code and any multicast weirdness" and also to verify
> that this also affected TCP.
> 
> Sorry for the confusion. The command lines used are in the regression report.
> 
> I've tested the v2 patch (with IPv6 multicast), and verified the
> previously failing test passes.
> 
> Tested-by: Brett A C Sheffield <bacs@librecast.net>
> 
> Cheers,


Just to clarify, it's more of a work-around, not a fix.

It's not really great to have a flag that says "change something
opaque in the internals of the device, it affects performance
in some way, we can't predict how".

So maybe we really should revert for now, and work on something
more coherent for the next linux.


> 
> Brett
> -- 
> Brett Sheffield (he/him)
> Librecast - Decentralising the Internet with Multicast
> https://librecast.net/
> https://blog.brettsheffield.com/


