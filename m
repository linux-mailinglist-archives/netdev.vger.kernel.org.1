Return-Path: <netdev+bounces-299053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id juAlLgbLLWpskAQAu9opvQ
	(envelope-from <netdev+bounces-299053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:26:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C867FC85
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:26:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=BHISyfx5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299053-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299053-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72EDC3011EBE
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50738E113;
	Sat, 13 Jun 2026 21:25:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000A38B133
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:25:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781385941; cv=none; b=LPn1f6SFmV6yMoRF9izvhd4wggGzB9DLfKOScAEothPEgSwxBK9pvdGR51EaSoGsPsFZPLbDuWGMspeR6E94p+ZIgO8mx8fvYJFzWe77SIwhBBfhKa/g9NPvtbk4LCliJbNYTThc5+a7pFa2GhCjSZB12BFSEdhJ+2Tw9tFO2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781385941; c=relaxed/simple;
	bh=sUW26/GjdOj1Qq716n0nbWsrEvJOhcLVVVNk0Yh/U80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT4BMJ3I2HHZ+XycRZm0fXt+1nTxOEm6V3Xj8JBr8DVzU/q9v7eD3vxr/ei3gYVUXMLpPSCbBuM59xi0pmJ3qRjm2xn/1Hk52GuL4QKHE63WOlXT8toYwcCBP3ob0dFUeME/tLTm1JD4qo1QCC4zj0wP289Gc6nD6U3PaYlF1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=BHISyfx5; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1384ebe7a10so1749779c88.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781385939; x=1781990739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8RVh2EafPzCmCimjzyybRSe3Diu63saSE546mxfPho=;
        b=BHISyfx5VmPeS35iXRH8apZp8aWFKTyb4hmP0wNq0Yz5O11xLjkBWFQFh2HZ/MJCbS
         3MHqjkkLv38ysjPFW1o3rBq8yunJPekHcqerVqoJWcg2elCA8cy/ecvF3Zl/3NmyqwIQ
         Syx+1LkOoTUJe4kkYJKGx7iIAx9FpC9dyAx++E60TidPLtIqEPM3qWfy0i2r195ZnIae
         3zJbVoYWubx0v63WuImZhorq7w2FdF2Rcu7l7Iil3WILrNT/dYtquF9SRiK+yKX0+Gm5
         ux54pbIBivA3iFViikm9gON67J6mp8E/yPrngmnxhvLeDlglgz+NyrSTksrHGYMpQc4+
         nU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781385939; x=1781990739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8RVh2EafPzCmCimjzyybRSe3Diu63saSE546mxfPho=;
        b=JNADF+hqY/HICZD5nVdtE8ljm/+tuUc4rrCO66tfwaCkvRI+qTWfvZyMxLYOtHxaCH
         zKJFTAPEQh40bH71v8NX58kGUUgh4v/5C6cB3Nh2sKrNHaay4/WuDiRTSf5JRCRe4nFt
         FaQz4lv701dSxaYQ6LTiOebsECrXNVjjc1sdFIZ8zce3VGzHJGvtPNQ3jRihu7q5jP/M
         usxKsHNXn7ZpzFVquiahCShqv50X7q90YAcGroh/MeWDjAsqjX6u26cyxTAfYin/yoII
         pNLamHMx8Zg/yWr3RA2Y0fFLaspLLI1wtfHlSDCocVi3w0+IS011Ow7nRJjUI+KXBIDw
         ZfHA==
X-Forwarded-Encrypted: i=1; AFNElJ89kfw+SipP5vkEVNMaZ5XTjjr568Qawh3VIwxxD5F9oD+vfFcSEwd4pWgICmpTQVpyvDSJrl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTWHig8K+mNcDGoW5pukTwk58scHOqaoSKJuUILF28gjtc34n
	HAD7rgdT8z5TPeaDLdEvAyHU7IQk4dsoU8EaX+iYM6Yylwvn98MGT0OMYS3cl5PIfno=
X-Gm-Gg: Acq92OGK8tgFtBsvwnNQAJujK+8BgFqDZzWaO/X2xWXlKmHH77VQWUCHsbbXj8wjrG0
	VFuVy6urWUq44vVRT6LZXTYee1kQZQYh+zHN1pRGTkwYlHy5+FESJ0166/iP1bVVJp7oDCkcv9/
	dBY6t84+8LabmIsLxM+x+IBdbaY/aUw5XxET7hIX6oT5WvpWo+be9AldZjftn12Kvd93XCCHSKy
	2tWMEaMEE85jGJoSom9VMKP58yenF3alyJG1Ku4uVsvhL9+GMdjvQNqvnhKMegXTzgjdQZzp3wy
	MlP6vyaSyXeZ8hg3NI+H+M3iGHxMoIqn/tnaXPvRG9ZEnhPFVOIG5ErAD8OuyzCCA8soMKlIKLb
	fYjo23tszIlTcZFlFlsZQYdJDYPXuLLiQgG8O8Rt5aCM6y8PagU4MIwB5+LGWe+isH3Wlhfmm/i
	hU4l6hKqyfcG5JFTYtIcq1vgdUeDQ+C9PJQA91PBZihcGe0LeqnErjr+mj
X-Received: by 2002:a05:7022:6183:b0:136:ac69:b0e8 with SMTP id a92af1059eb24-1384bb37863mr4425156c88.15.1781385939038;
        Sat, 13 Jun 2026 14:25:39 -0700 (PDT)
Received: from localhost ([2601:647:6802:dbc0:56d6:c5c3:3b81:a8d0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b964853sm6012730c88.11.2026.06.13.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 14:25:38 -0700 (PDT)
Date: Sat, 13 Jun 2026 14:25:37 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Hemanth Malla <hemanthmalla@gmail.com>, zijianzhang@bytedance.com
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
Message-ID: <ai3K0dBQaPqDGl6X@pop-os.localdomain>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
 <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
 <20260613105730.0ca1ca07@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613105730.0ca1ca07@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299053-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,cloudflare.com,linux.dev,bytedance.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:alexei.starovoitov@gmail.com,m:xiyou.wangcong@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:alexeistarovoitov@gmail.com,m:xiyouwangcong@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A4C867FC85

On Sat, Jun 13, 2026 at 10:57:30AM -0700, Jakub Kicinski wrote:
> On Fri, 12 Jun 2026 09:01:43 -0700 Alexei Starovoitov wrote:
> > Just saying that the code is free nowadays, so whether it's 1k lines
> > or 10 lines is irrelevant for the discussion.
> > 
> > As far as the idea goes, I think, it would be interesting in pre-AI era,
> > but today splice and friends are a prime target for bugs and more bugs.
> > skmsg and tcp_bpf are reeling from unfixed bugs too,
> > so my take is that we should not add any new features to skmsg
> > and instead deprecate what is already there.
> 
> 100% agreed. There are so many unfixed skmsg bugs it's hard to know
> were to start :( Kernel "intelligence" to help unoptimized applications
> is particularly unappealing right now.

You are absolutely right. :)

Thanks for offering opportunity for me to make profit out of it.

