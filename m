Return-Path: <netdev+bounces-175467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A2A66040
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9023B139B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D61F5852;
	Mon, 17 Mar 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAFywMA3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C801DEFEB
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245854; cv=none; b=LCHV7SmGw1yad7FpXyunnA2Jk4CDTBwGPKJ0i+yyYpB1sK6sj/q8suPFlPXPZqGWLSa4nX4hHQ5gGU7i7MFmJ/XNG1FjH4HlN+rQQ97SpRZUsQGp3bP+gvVXBVN81+gOlhpQNGM0pscTst/NDcwJvU4CstYGU5Sgo4F1pk1Gxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245854; c=relaxed/simple;
	bh=HS/z2C+/sH92DY1GJS+XHzlEZD96WZB3FX2Hmb2y7Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjsj1zm8vnI1b2vepejAieVbMrW/FrKfvZv9RNzLFZGLjWOXBktVDeoYoWhiZTqdksDTbnDA/p55TaPtF0xqOymzLVijwIiSuqgIgkqNU8lpwWt6W6hLVn9sU9FhKn2oYhGPKzme7W1M6ET548BO8AZoGA1qkHD30ZAyRcSZbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAFywMA3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742245851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4QETzZW/o92tvI3mddAguyCKLIgiaxRCUuH/GA30VC8=;
	b=UAFywMA3T0Qpd1pYM45cf/i6Niru6sXPSS+T1AnMKFCk6ZjM8SNyDiQatM19agRN7mvGpH
	aYZ8j8zEzALauW6WvCVQLL/+AYFgzrpR4ThIhK3lMahSuMcNhoXBM4HkokPMUPCakUc0RV
	o1Q5I5JtBLdJ7eo5GgTcWfREDhzYhAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Txwdty53POyhDKyGBDLKQA-1; Mon, 17 Mar 2025 17:10:50 -0400
X-MC-Unique: Txwdty53POyhDKyGBDLKQA-1
X-Mimecast-MFC-AGG-ID: Txwdty53POyhDKyGBDLKQA_1742245849
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so18911245e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 14:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742245849; x=1742850649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QETzZW/o92tvI3mddAguyCKLIgiaxRCUuH/GA30VC8=;
        b=bwEgB77M9gop4rswVpqzYObjh+tsxX+lZbwq2ppTiwb9rhz/V/o5lrjTLEUn6hWexc
         qdVh9oAULexNlgIZ6dVELdW+Q0OGopvhLKz3ky6znrdYqT3BJjkQHAxZFM4MfnDpHIqV
         7bFqnYxK0Fjjwc3fjPfMRnqVVOOcwkAHrIwMKNnJ93Mei6E3dVzat5bHt7J04EVYoD4p
         s2+05ETDXxNIRa8DmULpllvsStxnpHz4MUmyEB1Mc14G0v+cTYApqvZ94x1uuF6kmqB1
         tx0xrxq30b12JPMpIrpYqzeBHNDtbL5kQ8EKYTF7fnfm8h/1kJtHfhOAA7UMaCauug6m
         w6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUyXPjCUU9M51Mx0jXoAseph3WWO2X/3NcSr2QI3pjPuGLr0JD3sJWp+Cqr4zQ8958qGlifOkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MoYGp1BcwVWR8+XtWONLPPc8u5TLmmZZMttE8RA/lC63Lh3g
	NonMkLvA4YvOpqEUgpgnyQY488UuxhSTDZGOpwE4idAv22pk3dkoCJo9cCIjzxmurqlH7Dm/i9b
	bjZW65zDJ/c77AwQRvl7efksKCafHfpoWHb1xPu0wjtuNUXUeHa5RcA==
X-Gm-Gg: ASbGncvh049P0pyFDfxqI4gFvgQBiOXqnOrynpypKGFHLR8A+sgIlPRCWi2xJ1Hzetg
	WJO14XkuNnPH3RZhkzYNXCeOul6qurlxRtMaFEEEnJz1+dD6+IV5ZcSvopcMGT+FJGGnXri3O0K
	QHwZWiSmW1mmbr9Mgz7U/QSID4wiq5Jgv/Ql71pJgmfzqfaM/d9pwImUIdVt6Aigo2tqFuBdFRB
	a8zDrQL7PSTotS6W+HXedrrDhWm1sHdTqWXCsnbmhG69NyBjw5JwYUqWBYtmUmCOLKVXEy7MZ//
	dEywup++9pDss/CiRCkzEo+hL2hsy2KhBWBOlRnCcJlbieuh1JWlXUEalBBh2Ht/h+r3Vg==
X-Received: by 2002:a05:600c:a0e:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43d389ae799mr10815615e9.26.1742245849200;
        Mon, 17 Mar 2025 14:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpVIeDIDTnRM0X+iSR2LI1s9wbTVYCHbyoPUwxdXTUmYZxXQd6SLok/RTQ8xDE5as6+Wy3mw==
X-Received: by 2002:a05:600c:a0e:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43d389ae799mr10815425e9.26.1742245848813;
        Mon, 17 Mar 2025 14:10:48 -0700 (PDT)
Received: from debian (2a01cb058d23d6000b831dc06cb76332.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b83:1dc0:6cb7:6332])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fac7asm117195895e9.28.2025.03.17.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:10:47 -0700 (PDT)
Date: Mon, 17 Mar 2025 22:10:45 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z9iP1anwinOHhjjm@debian>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
 <Z9RIyKZDNoka53EO@mini-arch>
 <Z9SB87QzBbod1t7R@debian>
 <Z9SPDT9_M_nH9JiM@mini-arch>
 <Z9bNYPX165yxdoId@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9bNYPX165yxdoId@shredder>

On Sun, Mar 16, 2025 at 03:08:48PM +0200, Ido Schimmel wrote:
> On Fri, Mar 14, 2025 at 01:18:21PM -0700, Stanislav Fomichev wrote:
> > On 03/14, Guillaume Nault wrote:
> > > On Fri, Mar 14, 2025 at 08:18:32AM -0700, Stanislav Fomichev wrote:
> > > > 
> > > > Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
> > > > It seems like it started falling after this series has been pulled:
> > > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout
> > > 
> > > Hum, net/forwarding/ip6gre_custom_multipath_hash.sh works for me on the
> > > current net tree (I'm at commit 4003c9e78778). I have only one failure,
> > > but it already happened before 183185a18ff9 ("gre: Fix IPv6 link-local
> > > address generation.") was applied.
> > 
> > On my side I see the following (ignore ping6 FAILs):
> > 
> > bfc6c67ec2d6 - (net-next/main, net-next/HEAD) net/smc: use the correct ndev to find pnetid by pnetid table (7 hours ago) <Guangguan Wang>
> > 
> > TAP version 13
> > 1..1
> > # timeout set to 0
> > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > [    9.275735][  T167] ip (167) used greatest stack depth: 23536 bytes left
> > [   13.769300][  T255] gre: GRE over IPv4 demultiplexor driver
> > [   13.838185][  T255] ip6_gre: GRE over IPv6 tunneling driver
> > [   13.951780][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > [   14.038101][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > [   15.148469][  T281] 8021q: 802.1Q VLAN Support v1.8
> > [   17.559477][  T321] GACT probability NOT on
> > [   18.551876][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > [   18.633656][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > # TEST: ping                                                          [ OK ]
> > # TEST: ping6                                                         [FAIL]
> > # INFO: Running IPv4 overlay custom multipath hash tests
> > # TEST: Multipath hash field: Inner source IP (balanced)              [FAIL]
> > #       Expected traffic to be balanced, but it is not
> > # INFO: Packets sent on path1 / path2: 1 / 12602
> > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > # INFO: Packets sent on path1 / path2: 0 / 12601
> > # TEST: Multipath hash field: Inner destination IP (balanced)         [FAIL]
> > #       Expected traffic to be balanced, but it is not
> > # INFO: Packets sent on path1 / path2: 1 / 12600
> > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > # INFO: Packets sent on path1 / path2: 0 / 12600
> > ...
> > 
> > 8ecea691e844 - (HEAD -> upstream/net-next/main) Revert "gre: Fix IPv6 link-local address generation." (2 minutes ago) <Stanislav Fomichev>
> > 
> > TAP version 13
> > 1..1
> > # timeout set to 0
> > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > [   13.863060][  T252] gre: GRE over IPv4 demultiplexor driver
> > [   13.911551][  T252] ip6_gre: GRE over IPv6 tunneling driver
> > [   15.226124][  T277] 8021q: 802.1Q VLAN Support v1.8
> > [   17.629460][  T317] GACT probability NOT on
> > [   17.645781][  T315] tc (315) used greatest stack depth: 23040 bytes left
> > # TEST: ping                                                          [ OK ]
> > # TEST: ping6                                                         [FAIL]
> > # INFO: Running IPv4 overlay custom multipath hash tests
> > # TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
> > # INFO: Packets sent on path1 / path2: 5552 / 7052
> > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > # INFO: Packets sent on path1 / path2: 12600 / 2
> > [   36.278056][    C2] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1078005296 wd_nsec: 1078004682
> > # TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
> > # INFO: Packets sent on path1 / path2: 6650 / 5950
> > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > # INFO: Packets sent on path1 / path2: 0 / 12600
> > ...
> > 
> > And I also see the failures on 4003c9e78778. Not sure why we see
> > different results. And the NIPAs fails as well:
> > 
> > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/32922/1-ip6gre-custom-multipath-hash-sh/stdout
> 
> I can reproduce this locally and I'm getting the exact same result as
> the CI. All the balanced tests fail because the traffic is forwarded via
> a single nexthop. No failures after reverting 183185a18ff9.
> 
> I'm still not sure what happens, but for some reason a neighbour is not
> created on one of the nexthop devices which causes rt6_check_neigh() to
> skip over this path (returning RT6_NUD_FAIL_DO_RR). Enabling
> CONFIG_IPV6_ROUTER_PREF fixes the issue because then RT6_NUD_SUCCEED is
> returned.
> 
> I can continue looking into this on Tuesday (mostly AFK tomorrow).

I finally managed to reproduce the problem using vng. Still no problem
on my regular VM, no matter if I enable CONFIG_IPV6_ROUTER_PREF or not.
I'll continue investigating this problem...


