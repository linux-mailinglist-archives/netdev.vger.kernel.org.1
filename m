Return-Path: <netdev+bounces-293606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGQQH18+HWq8XgkAu9opvQ
	(envelope-from <netdev+bounces-293606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B661B463
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F653019134
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41094385535;
	Mon,  1 Jun 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buLhOY/o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJx3fs01"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E833ADAD
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301320; cv=none; b=L8pMGibQOGav60E1WCPq5oJoUTVnHK0Hd5THrlOCM4p1GiWAdvhT3vlk8v61FdFBjZpn7Vgk5NXiewMYrA1cxizvoEnEYdaTOo6nkRFdQpNlymgDrnsKy++wrYIf7DZazRURsuza+F3EE0YuPI26bjAAa0b0sMax4c2VN6sN3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301320; c=relaxed/simple;
	bh=b+nopWGySZSG4HSj92DLc8KguQVIEmiu6zxkNPrmY30=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=L/26N6pXwsnIL7PMTvfKQjHxniImNuucME7+ZJFhFiwAAPg+hUkMFhX3eib7xA6yCn0U1hKJ9wG+yqlNTrdkwiadccsYVIw5pZ0FeIvJzMuzghNp02nKNd87/q5O33inuOjD4sCc0xru8T89/SnMcIanoroHP4s8rvk5ddTUjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=buLhOY/o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJx3fs01; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780301318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeUIBK7Vustv5ZHBT+eRjJp5ScQX69uAYSjeAGRkkxE=;
	b=buLhOY/oubiCQKPc3PPb0YQChMYmUlOa4mhwNJf/kMNZHhuVnMR/bY0Gg2WMNJ7CVHdGAC
	9gUix6NJUGTR5Tt8mDXqy4AlrRo8MN61TwM44XdiX58TmpG7HD4bnLffL98EbgrZr6jmkN
	OwtPwyqBGgC52VHdDmYQvKNQBsfkzKk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-uxgndXTkOsCIB1FiETwPIA-1; Mon, 01 Jun 2026 04:08:31 -0400
X-MC-Unique: uxgndXTkOsCIB1FiETwPIA-1
X-Mimecast-MFC-AGG-ID: uxgndXTkOsCIB1FiETwPIA_1780301310
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so78236175e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780301310; x=1780906110; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeUIBK7Vustv5ZHBT+eRjJp5ScQX69uAYSjeAGRkkxE=;
        b=fJx3fs01aH891MCmM/LZN96Gi6Dnlt1/DIBFDRBIAymogLwAo2JxtuuXHsF7aiTtxs
         L5XMYhAjh0gig7tMD06Muvl9PrOr3KhyoQEooYhzTXnntGJloHUucvM2qGig/SkAafGo
         ofG/+ZEqaXa4fcBiqGbKUMOl7Mp1DIFVRjv3Et3EUbCobhgn985+dBQ44YLRWHHu8Fp/
         7kXc4eYvY6UtrZATmDjnQS0DBUXauWyT03jlF3RzpmIIloNKYR2njnxuNYmjphyD0rYg
         LpdYKDut7Rjn109++M+i9uw20qKpnCUV7tdHfjUpPM1FT/9a9ADe8nXBZKe3j3z1kYEF
         /ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301310; x=1780906110;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeUIBK7Vustv5ZHBT+eRjJp5ScQX69uAYSjeAGRkkxE=;
        b=c/JgT3H7qE2WQAVNn2msKkR+acQ2YSlJVte1CmK+iRDTNC1q4UC0P/ot6CA3mTh9AV
         twJsETrp3jE/DPavY/fMPsnHB1B6rmHIaU1klkDmuOtrKw5rRjF5S5HoPtlKglCkvASH
         CTul9Z1svzK/xh2bnA1PcQWxoOKLOSm/7+WCF9G7tcKTiciA0dx2BVlyvvBMfJPD4NQ4
         pDKu6bZNMke2f2GHUQNKa5QbvgGKSYMSiHIVFaxDVa0LcVy4OwT9fSLgTGIvFhLklISo
         01kvD0EV8rhZMyZw0Rl3/jpgGjgdjvfIrV3DvdIsfZ1DT3XSRj+NHozz04WIDZqfox/8
         qRbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OlNYlk5TK9DEucRILznISpietz8xKc19JpcEQm3bF5CnZjFgriUfdFp0+0ECXK2F3tpfSGLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJ9e1F3eJy7S3GrbhbrmsX4zX5O5CjJ8DWJuQVujlq7sIOWBa
	LUGpjB71T+gCa8ZpIMt9+jDTy9Wnr1MqgaRsS7To5ENWwIwFVsLT3FVakRC2JRVhiIWEZ1QF/EI
	TBKMAvFSlRQnyDPHrVPQYMdAQF+fOkARn9RdmMCefpJMdKM/ZstOkYDwAHQ==
X-Gm-Gg: Acq92OH0inCJG2QdiqAR0IR/4hbz2b8EcmmJsisAvDWrQdnzrPdxyCemuNSoQbIqt/6
	1pzljKPFaj/W38Icxj89dk2jbScu6Qzd6gph2hgc36A1iPeLnPEI7slaQTDlUzVrsF8yG/2FY8s
	wux8XLIRjgLzuLwYjlJHcxeBKcmZN9n7iY7zoWJk5xVyh030qwqBEpH7C/YIY5sXvvSCn1LXtdc
	bfnKYT47nvMUwFxye/2scrXR9PML5Cs+SkYBSWwknXoUVFC1wPiyZiMjGKzgpKdEa5DuXEWKSJu
	O/UPCKP9Ft+kA4pd93Js1H1X3IhzjJd+FesyF2vBxjGN+W/SlPn35f7LjTywJ6a9Jd/MWCtBeLP
	sJgNSgEMAQA+jNn+OmaIa73eD17Vc542ovd7rJYqZM9A=
X-Received: by 2002:a05:600c:1989:b0:490:51b9:2309 with SMTP id 5b1f17b1804b1-490a297e1e1mr209816435e9.29.1780301309978;
        Mon, 01 Jun 2026 01:08:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1989:b0:490:51b9:2309 with SMTP id 5b1f17b1804b1-490a297e1e1mr209815505e9.29.1780301309332;
        Mon, 01 Jun 2026 01:08:29 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c1035ebsm104407205e9.5.2026.06.01.01.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:08:28 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Tj <tj.iam.tj@proton.me>
Cc: =?UTF-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Fernando Fernandez Mancera <fmancera@suse.de>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, Linux kernel regressions list
 <regressions@lists.linux.dev>, Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260601100826.4222a657@elisabeth>
In-Reply-To: <3f0d5431-60b0-42dc-8192-2f8a3c6da50e@proton.me>
References: <ahnaz3ppxyVHl3xB@mail.iam.tj>
	<20260529220415.22d0be8d@elisabeth>
	<3f0d5431-60b0-42dc-8192-2f8a3c6da50e@proton.me>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 01 Jun 2026 10:08:27 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,leemhuis.info,suse.de,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-293606-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,proton.me:email]
X-Rspamd-Queue-Id: E92B661B463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 20:18:55 +0000
Tj <tj.iam.tj@proton.me> wrote:

> On 29/05/2026 20:04, Stefano Brivio wrote:
> > On Fri, 29 May 2026 18:28:58 +0000
> > Tj <tj.iam.tj@proton.me> wrote:
> >  
> >> I believe I hit this on a router using Debian 13 with v7.0.* kernel this week that
> >> uses systemd-networkd to configure IPV6 RA and prefix delegation after
> >> moving from v6.19.*.
> >>
> >> Symptom was the router could no longer reach public IPv6 addresses
> >> itself but forwarding was unaffected.
> >>
> >> The ISP (Starlink) provides a /64 prefix via RA and a /56 via DHCPv6. networkd
> >> allocates a static suffix address from both to the WAN-side interface.
> >>
> >> I discovered after much experimentation that instead of the usual /56
> >> address being the source it was choosing the /64 and failing.  
> > Do you really mean an address configured as /56, or a /64 address that
> > systemd-networkd derives from a /56 delegated prefix?
>
> Apologies - I should have been clearer. I meant addresses generated 
> *from the* respective prefixes - the addresses themselves are /64, yes!

Thanks for clarifying. Meanwhile, Jakub applied Fernando's revert patch
(I'm actually relieved, thanks Jakub ;)) but I had a look anyway into
how systemd-networkd handles these two cases.

They both seem to be hitting in the same way configure_address()
(src/network/networkd-address.c) with no attempt to define a given
order. After all, the only way to force a specific order would be to
remove and add addresses back, which systemd-networkd doesn't do.

So, whether the setup worked before the patch (and after the revert)
depends on the order of events / configurations, which in some sense
makes it even more important that we keep a stable order by default.

Contrary to NetworkManager, here, there's nothing we could really "fix".

-- 
Stefano


