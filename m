Return-Path: <netdev+bounces-174962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A6A61A55
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14171463878
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22069204C09;
	Fri, 14 Mar 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0/O1cvx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F192204C3E
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980158; cv=none; b=Hzm16Q2b4tOHUkxdpBFV+wdrXQFSkRddHUlxv61QtU34Nzw6eya9EHgHf2203o6QbwGB8eSGW0pHukU+DpHJ9+lLBQjIUcVHsEwQGXyaDv5S+LlRb9rz+5wU92bMhTngJHli3E3G5FTaIy8tOBn2EZyfh9hzuQ6yYxRK3jM2m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980158; c=relaxed/simple;
	bh=6sQhY1JyGtXH5LD/TNvFC3dbVPecq9uLO18TekljegQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCE5yePnawWV8ii8p4boAf+fDpjAAVbkUlZbQMW4rZ9lr9YKL3tSIF584Dyp5qVGATC8chG43f2ljzziB8DqsfrPi7Y226D79/5t2x07OaljrTDka2lEQhqGdWk/7qTQaH0CbHeUBCIIdQWULpRnF+oqCIpM8Aa8k7ftALE0en8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0/O1cvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741980154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RKn53hSC56G7J0ozEerZDM9YRLjs49p7E3G/fFlS+oM=;
	b=h0/O1cvxnItdfLpyeYhTR9fV9JPGjoBD71niEnDErQ+e+ozqC2dvN8JwC48taoygMqGcM9
	jZx7zBgAE4OUsJ7Fb1aTIBpnhYzxXb0l6kJB4W0dv7UcqzlYFCp8ch2M55Q/qWK95c325S
	vHsTTDMRZosOLJ5jrYwb4AkRi+Zx5ms=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-s0isfIimP4WPzXQvwu3dcA-1; Fri, 14 Mar 2025 15:22:32 -0400
X-MC-Unique: s0isfIimP4WPzXQvwu3dcA-1
X-Mimecast-MFC-AGG-ID: s0isfIimP4WPzXQvwu3dcA_1741980152
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c543ab40d3so415625285a.2
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 12:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741980152; x=1742584952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKn53hSC56G7J0ozEerZDM9YRLjs49p7E3G/fFlS+oM=;
        b=l9uGVxcxLKAWmYPTBDCXnstl9RoZbp+pttFUr4nk026/LOPrVPxcyWVoqOnQRuyBo7
         Ttjr8z6iGlVjnIjsBR5IO6hwDpeSP6O5E1adbfENcIEoEAN0QjGEzQc+I2S2v2O6m/TN
         lCN/laF5jj3YrZy4be6+5U1cDdBvcfrWWDYS3DI4YMS1ZRAdI9uZuCY/YN3QCn8jaipJ
         k9Z0kIZVfDn26c45KbXPL5pfXp0AxjDyEx1q7iqygZtLdoSyq1YyVaTJKz460bJT8FqJ
         qPgaFi3Yr14rVk314d9fjuK8Y9KvLFNvmPEnb9oc9rKlHiM6cRa75o+3DUSXuwjNiPqm
         p2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTfIevGt/0+FeB+i+PadMTZiIVukQnOtkxYg5LhwAMkczKnXYPb4UFkoVKU2fTkfdaLmxnIbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITFnv4/lkNElQrTLaH7wU9VdJeARIFqgbzqkMPjLlQNs5ORVF
	uGlxWzlTjqbi99PNAToPg2qkXUqegMT9a8D2GDU3rWcVQutDtoSFIJo8vHMKQLvZ18zCT5uojqL
	DStXf8qRch43slZqKXckgX9ludmmqvHyqsbz+nAZTIN0lfp/ViLIIbw==
X-Gm-Gg: ASbGncv6fKLYYUhhrUGx7LZ/jxZeQyKcwpoc5+sra3/0D6zhDL5B8KSECpWA2GaVCX1
	ISwBgBGJqAAlH7BwHXwPMcVBwEY4x0Mnrb8pgVv/QSOHLqitMAY780pfxviIvjDkL0fOCukxZfA
	y47inyLbhoNZzohOpB2NgFoC405rt42QeUw1I4MXiy/RYI1yAffiT3RM1X0EXBqiKWdqEN27+WZ
	IIQKXtsWxD7GmqQ+2KoI2GtknxaL+p6jymz8dt0Ve8Zm2/O3e3ayriyDC+bpTwTA3J7B0B2yuWV
	kL26oqrwq0zkEMbTdKgmTcs7Xt6C4s1gkOm6Po4o0C6mazcRf46rrU0NCQK+I79DuRBNeSM=
X-Received: by 2002:a05:620a:28d4:b0:7c5:4a8e:b72 with SMTP id af79cd13be357-7c57c8f0becmr518307585a.52.1741980152330;
        Fri, 14 Mar 2025 12:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGovqHM1xDtPGXHnmCC5kA808LsUmFtddxVfR/PI0ME0aIL2TTF/2+i8aOdK9Ct/oWDw7A7fw==
X-Received: by 2002:a05:620a:28d4:b0:7c5:4a8e:b72 with SMTP id af79cd13be357-7c57c8f0becmr518304085a.52.1741980151935;
        Fri, 14 Mar 2025 12:22:31 -0700 (PDT)
Received: from debian (2a01cb058d23d6002a5d77a6179e8e9d.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:2a5d:77a6:179e:8e9d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c6fc46sm291000985a.26.2025.03.14.12.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:22:31 -0700 (PDT)
Date: Fri, 14 Mar 2025 20:22:27 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z9SB87QzBbod1t7R@debian>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
 <Z9RIyKZDNoka53EO@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9RIyKZDNoka53EO@mini-arch>

On Fri, Mar 14, 2025 at 08:18:32AM -0700, Stanislav Fomichev wrote:
> On 03/07, Guillaume Nault wrote:
> > Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> > devices in most cases and fall back to using add_v4_addrs() only in
> > case the GRE configuration is incompatible with addrconf_addr_gen().
> > 
> > GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> > ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> > address") restricted this use to gretap and ip6gretap devices, and
> > created add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> > 
> > The original problem came when commit 9af28511be10 ("addrconf: refuse
> > isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> > addr parameter was 0. The commit says that this would create an invalid
> > address, however, I couldn't find any RFC saying that the generated
> > interface identifier would be wrong. Anyway, since gre over IPv4
> > devices pass their local tunnel address to __ipv6_isatap_ifid(), that
> > commit broke their IPv6 link-local address generation when the local
> > address was unspecified.
> > 
> > Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> > interfaces when computing v6LL address") tried to fix that case by
> > defining add_v4_addrs() and calling it to generate the IPv6 link-local
> > address instead of using addrconf_addr_gen() (apart for gretap and
> > ip6gretap devices, which would still use the regular
> > addrconf_addr_gen(), since they have a MAC address).
> > 
> > That broke several use cases because add_v4_addrs() isn't properly
> > integrated into the rest of IPv6 Neighbor Discovery code. Several of
> > these shortcomings have been fixed over time, but add_v4_addrs()
> > remains broken on several aspects. In particular, it doesn't send any
> > Router Sollicitations, so the SLAAC process doesn't start until the
> > interface receives a Router Advertisement. Also, add_v4_addrs() mostly
> > ignores the address generation mode of the interface
> > (/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
> > IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.
> > 
> > Fix the situation by using add_v4_addrs() only in the specific scenario
> > where the normal method would fail. That is, for interfaces that have
> > all of the following characteristics:
> > 
> >   * run over IPv4,
> >   * transport IP packets directly, not Ethernet (that is, not gretap
> >     interfaces),
> >   * tunnel endpoint is INADDR_ANY (that is, 0),
> >   * device address generation mode is EUI64.
> 
> Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
> It seems like it started falling after this series has been pulled:
> https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout

Hum, net/forwarding/ip6gre_custom_multipath_hash.sh works for me on the
current net tree (I'm at commit 4003c9e78778). I have only one failure,
but it already happened before 183185a18ff9 ("gre: Fix IPv6 link-local
address generation.") was applied.

# ./ip6gre_custom_multipath_hash.sh
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
INFO: Running IPv4 overlay custom multipath hash tests
TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
INFO: Packets sent on path1 / path2: 6350 / 6251
TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
INFO: Packets sent on path1 / path2: 12602 / 0
TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
INFO: Packets sent on path1 / path2: 5400 / 7201
TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
INFO: Packets sent on path1 / path2: 0 / 12600
TEST: Multipath hash field: Inner source port (balanced)            [ OK ]
INFO: Packets sent on path1 / path2: 16458 / 16311
TEST: Multipath hash field: Inner source port (unbalanced)          [ OK ]
INFO: Packets sent on path1 / path2: 32769 / 0
TEST: Multipath hash field: Inner destination port (balanced)       [ OK ]
INFO: Packets sent on path1 / path2: 16458 / 16311
TEST: Multipath hash field: Inner destination port (unbalanced)     [ OK ]
INFO: Packets sent on path1 / path2: 0 / 32769
INFO: Running IPv6 overlay custom multipath hash tests
TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
INFO: Packets sent on path1 / path2: 5900 / 6700
TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
INFO: Packets sent on path1 / path2: 0 / 12600
TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
INFO: Packets sent on path1 / path2: 5900 / 6700
TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
INFO: Packets sent on path1 / path2: 12600 / 0
TEST: Multipath hash field: Inner flowlabel (balanced)              [FAIL]
        Expected traffic to be balanced, but it is not
INFO: Packets sent on path1 / path2: 0 / 1
TEST: Multipath hash field: Inner flowlabel (unbalanced)            [ OK ]
INFO: Packets sent on path1 / path2: 0 / 12600
TEST: Multipath hash field: Inner source port (balanced)            [ OK ]
INFO: Packets sent on path1 / path2: 16387 / 16385
TEST: Multipath hash field: Inner source port (unbalanced)          [ OK ]
INFO: Packets sent on path1 / path2: 32770 / 0
TEST: Multipath hash field: Inner destination port (balanced)       [ OK ]
INFO: Packets sent on path1 / path2: 16386 / 16384
TEST: Multipath hash field: Inner destination port (unbalanced)     [ OK ]
INFO: Packets sent on path1 / path2: 32769 / 0


