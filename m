Return-Path: <netdev+bounces-305599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AOfGDvN3TWrF0gEAu9opvQ
	(envelope-from <netdev+bounces-305599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:04:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CE71FF7B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:04:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Em/IJI87";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305599-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305599-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1EA73049731
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898E39D6EE;
	Tue,  7 Jul 2026 22:03:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0739989D
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 22:03:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461788; cv=none; b=hdET5pXapzqsJgH2cETcF951Z4Mgh3pjf1EQeGu6jpMWTGDTfbl8kPiMg+jGmMeMq16AO8RQHQauzGxW+x4QGbU1Ur4o+bdRPFqrKH3OhrFvdpxVttN+bk4leukM7FCFVoKIpvCEiVwoLitc5+7Zq3HY/YYopKQyHWhKgBQh5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461788; c=relaxed/simple;
	bh=QmI9y7LXjUNRevCboFwnS/cW5tvcm0xYKqsCkpJJyGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHOLKREy2l9ldgDint/rzfjsF0uVncNMAdlDAZDnXydk8MJfrwA/1FK137qcYG0LSjg7bTnaqBEkvevzVlVqQWdv5uU45OR4YkLgs6HsOr7cPCKd/HCFLy7vt0oSy0oW6lmnv/uO1+eXlLwRwapPm+q/CQihw3nUC4KnybbBoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em/IJI87; arc=none smtp.client-ip=209.85.160.43
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43bf9548df4so27095fac.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461785; x=1784066585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+Cz/DGzX9LixlJM1WDO9JL3XKhxalEZ7sqlBmeIS0k=;
        b=Em/IJI87bp0t1EKPL43O8QKUQ4CmWOXAeaCpkZ50fE6f2RPV8E8rMvN8xdW0AhABoP
         oDoAwmqbAQdB8ok4+W/73MHbS7URPWQMYPlU2sqjxukkTR4oJV7Zt4yKvUoAj4OWiGFg
         n0GYYgxDbcYI2RBr6chVeOinPPhYfebLkpKASmAZo+1MCnm4a1UlsWZ6iIZWRB4zjZTY
         eiySEQ5FH04tlDFau/5YfaXXu1Wep6i1EQ4TIwHOoaYHqW2jFzFkA7BhFaCkJMisAshT
         DZqQ6+JvV4BwNMXvabtagWBOKhex70nZerdcOgdo7EVckxyyrFgedMFiwjOZV6kepxv8
         SHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461785; x=1784066585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r+Cz/DGzX9LixlJM1WDO9JL3XKhxalEZ7sqlBmeIS0k=;
        b=HB2x4OqtottgOnTBoAYmhCarD3M/Cp9sOcsVFAc4EOC4+0zv4S4029DS8TkyD5wrmB
         C3K+RsTzTxZr3dQrA+Tyt+OT27BAfkl3T47u2Ze1kgxiysnpmUizoA53ZlSuAN94Njsf
         4RUgASC0UHDKvEJwDH91sevf9nmxNtK+dZKnpqW78SssjYNfXjEe+ODhbtiKZTHf5O4d
         VcUp6nNCOXGg0P3RRLe5pqEAFqDwyTXdRR0K/FHybXJ4/ruNnP0VnLbGv6asSkr0zF4k
         NLTADFNtsvmzEI6IZbQnjvPDJm8SwRhoov0NFtaT2BraHMBMBnV3piA7cpS+WXqJyAE8
         21cg==
X-Forwarded-Encrypted: i=1; AFNElJ8u+xkNzfTlz7VLKV6a1KSZqzewNyLyTc6b0iZStt13+zMsOi3Lp+wdAhgLFNuHmt2LtoW4UxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxei70Td5cRYO0DlesrYZ7YIRvAjiejUe+gPuPUaMqiK9Vr2scX
	Q8PRZFY5i2AhtPCwpdxPKki4P5T7Y1gecKuhohoJ70Suc6xJ/aFNoNxF
X-Gm-Gg: AfdE7cnZooZ3RLcVwuyeU8/5o03ADkTw9CATUZfbACnLW+CJcCo7Y7qdxgMvK7jHA0q
	T08IWIG8DRkKz2aRY1rPVhHvTBBFTA5j1jqE6LxUWK4KQDsPwbz0MxhLKSFp4qdm11/vZJ9QKsw
	ZW+UBwNorwCNRWWa0Io/mmTJo6TzVcnWWJbog1uaLGhzMac/i802rvg6bpRwC2fng9iIFpy57sw
	jv4vNx6Ya9dhHb5bQkb3ugNf9GywJy6PCYH38NNx+vteTN7DMTnwZ5H6PDNa0RLe8UpfG8b2jTN
	Egqt3AsBzm6iChr+Hf9fw+OTCE2WBWaaOV0bS1IGmdKXkvIMsdfEpitnos4/1Tq/E5Lc3WOsD90
	IKLNqtJr3MvaaR64II2t58GXQngGVahVEdHLl1lwKBGuVw0gw+ecLxSpAm1uPZrS9tQn1PMkPOq
	6WOWtlVUoElFB3w/mdlvjFjZZn+EY8AFU0
X-Received: by 2002:a05:6808:5393:b0:489:f199:42bb with SMTP id 5614622812f47-49fdc040ab9mr5109894b6e.8.1783461784688;
        Tue, 07 Jul 2026 15:03:04 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm430555b6e.3.2026.07.07.15.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:03:03 -0700 (PDT)
Date: Tue, 7 Jul 2026 15:02:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, matttbe@kernel.org,
	skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 0/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per binding
Message-ID: <ak13k4XZsHnGKIOb@devvm29614.prn0.facebook.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <CAHS8izOmA_U=Q6WOO5mcoi2vBps_JFEtAQa3gXk=JcL3rqE1BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOmA_U=Q6WOO5mcoi2vBps_JFEtAQa3gXk=JcL3rqE1BA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:almasrymina@google.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:joe@dama.to,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,intel.com,linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,fomichev.me,blackwall.org,iogearbox.net,davidwei.uk,dama.to,meta.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 831CE71FF7B

On Tue, Jul 07, 2026 at 12:24:21PM -0700, Mina Almasry wrote:
> (I'm kinda reviewing this very late here. Some suggestions/comments
> but feel free to ignore if not useful).
> 
> On Wed, Jul 1, 2026 at 12:22 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
> > On NICs that consume one descriptor per netmem, this caps a single RX
> > descriptor at PAGE_SIZE and burns CPU on buffer churn.
> >
> > In this series, we add a bind-time netlink attribute,
> > NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov size
> > (power of two >= PAGE_SIZE).
> 
> FWIW we may be able to support arbitrary sizes with devmem. Because
> the genpool supports byte-aligned allocations AFAIR. Also the
> dma-mapping happens with the dma-buf size, so the actual niov size
> doesn't matter. The only thing I can think off which may not be
> flexible to arbitrary sizes is the driver itself. IDK what happens if
> you ask the driver to dma into a buffer that is frag size 5023 or
> something like that.
> 
> But that is something that can be relaxed in the future.


I think at least for mlx5 there would be some issues, as it splits the
memory region into fixed-size strides (256B), so I'd expect it needs to
at least be divisible by the stride length. The mlx5 driver seems to
guard against this by checking for sz > PAGE_SIZE && is_power_of_2.

> 
> > Drivers must opt in via
> > queue_mgmt_ops.QCFG_RX_PAGE_SIZE.
> >
> 
> nit that probably doesn't matter: ...QCFG_RX_NETMEM_SIZE, or
> (...NIOV_SIZE). This doesn't actually work with pages, right?

I probably could have worded this in the message more clearly, but this
name is not introduced by this series, so we probably can't get away
with changing it.

> 
> If you decide to extend to arbrary sizes, I would add to the
> queue_mgmt ops supports_netmem_size(size_t size) function, and let the
> driver enforce "it has to be power of 2" if it needs to. AFAICT core
> doesn't need to.
> 
> > Selftests use udmabuf, but udmabuf sgtables were previously hardcoded to
> > PAGE_SIZE. This series modifies udmabuf to respect folio sizes in its exported
> > sgtable. The result is that when backing udmabuf with MFD_HUGETLB 2MB pages,
> > the sgtable is populated with 2MB entries, allowing devmem's gen_pool to carve
> > out large (eg. 64K) niovs.
> >
> > Measurements
> > ------------
> >
> > Setup: kperf devmem RX/TX cuda, 4 flows, 64 MB messages, 60s, dctcp,
> > num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov size,
> > mlx5.
> >
> >    niov       RX dev Gbps   RX flow avg Gbps         app sys %
> >   -----  ----------------  -----------------  ----------------
> >      4K  300.63 +/- 53.21    75.16 +/- 13.30   54.15 +/- 10.23
> >     16K  321.35 +/- 28.20    80.34 +/-  7.05   41.05 +/-  8.87
> >     32K  347.63 +/-  2.20    86.91 +/-  0.55   44.54 +/-  3.51
> >     64K  332.11 +/- 14.26    83.03 +/-  3.56   35.47 +/-  3.11
> >
> > RX app sys % drops ~19% from 4K to 64K.
> >
> 
> Hard to read the columns for me but seems like good perf data. Did
> performance become worse from 32K to 64K? I wonder why.

The drop off struck my eye too, but didn't investigate further. Given
the wide stdev, it appears to me like the trend is positive but probably
not huge. The cpu util deltas, on the other hand, look stronger to me.

> 
> I have some devmem performance fixes that are very critical for our
> production that I haven't gotten around to upstreaming yet. I wonder
> if I can send them to you for upstream submission. Are you potentially
> interested?

Definitely interested!

> 
> -- 
> Thanks,
> Mina


Thanks Mina.

Best,
Bobby

