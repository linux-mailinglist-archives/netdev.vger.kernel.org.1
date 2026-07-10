Return-Path: <netdev+bounces-306563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lFjxKKn0UGok9AIAu9opvQ
	(envelope-from <netdev+bounces-306563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261373B49F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:33:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=YVmQEGeK;
	dmarc=pass (policy=reject) header.from=canonical.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306563-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306563-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8994A30156C9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99117311C2C;
	Fri, 10 Jul 2026 13:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030F1E0E14
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690323; cv=none; b=BAHbAzUPKeLvAIarqU46i1fs2heQcMNkVHVnEvndhvnk0i2lWkM6IgHsowTzlkNXW1V6wz95UyIz+ivN9CC+JzY5SHJgQT/z5ThgbcWORSpKCAO9Hb6/ce8MLSZMKy2ksFXJUogyQhpnIEASDbqpvXb4SRDJlWjlRE3UWUvpAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690323; c=relaxed/simple;
	bh=0kCTodwMNybNFHvFl8c20+Pfoq3qaWcGnR+gA/Fw/Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ennI7rMdQwV6qWa6Rw+eh0RfFPXaa1uGB5dr+FRyfmXHdrrZLwXbjvoYckdZBhAntIxAWD7DsF2iPpCrRHa04ZhsHcUhT5jFB3qg8SgecVnfN8ctPjFGHZ/xW0wv4N8cxaQYVsO5AbiQ/BLZjVpiMjz19cpuI0DVlCd0Is9Ec+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=YVmQEGeK; arc=none smtp.client-ip=185.125.188.123
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A6073F85F
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783690313;
	bh=CRjw6u/TimhdsdLAKCBwY2E0h0Xmbg9SBDdL+xLx6es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=YVmQEGeKY5DNRktZoKSqGEt8BiPYMVyZMYXPgU/duGMIcAGT8so5ZTKE9pQODcdxN
	 uq4uZoAwgapyNhL1DxwOkT22AcOAXxTjTEl5EhEou+iMbA6klRphIfmU/b1mCjO7YS
	 fBXs7N9iSaiVX3MFqj0bo3BtDMSxohPzMLqNhTMHXKMwrdK77/39wGakakqEqLu8N1
	 ncVK3i4ufqzAbNXjLI8Hob+DmDmG0JY6QhhbSjEborizmi+8Nmi9ZHyaFRX8gd8/8l
	 lY4GkRR/qCsF6B8S4kr4CDh6NXmYQxrq7CoBRAWoDuhnkAeIZzIQHFbTdUl3xnGUQl
	 ux/4ZH+7UfKlfh84CiKUMIp3mCbxeV452p5uAv/+fHv+jCD9o2h2b71vUPP+NLvZCg
	 fANV4XgU2Mkl70mFvYL6Kjkg9MTCOcXbXdNB1GEBhFo46Ax0ipoB81Dv3gsImEgTYb
	 dae5uye8XvblBKttKflPEw6JRph5zRunfaxD5lrIDYWUljGIX2kaApGBtM8hgd1DX2
	 qr9FFltEubEugJ11dYGKZk9vCNzoBuR+H1CQytRDAJEV1HJ4dJBtpe+CnE8vy50qgk
	 T11LuQ4T5AigknyEQP8+CLIqI3Ynlr0mug9u++JHcjNzBn2hV0HvZiHtpCyeuAXOFf
	 ShSveZyy8NtOnks/5MG897C4=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so8754185e9.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 06:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783690313; x=1784295113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CRjw6u/TimhdsdLAKCBwY2E0h0Xmbg9SBDdL+xLx6es=;
        b=DvH0luWexfLLf+PFuTFs3Iqu8yaX3nioV6n05YQTTBEpx+CBMbOYUW2PnDJeCWxNa2
         ua7T0E210dnakO9JqfbIvWJKwqjpWS5FBHp39O/K0PI3aGJdA9afflOa/i6n0wOIQe28
         9zFzuXFRjbn5F9J15YsUp6aB5vGVgfXifiSFNpUV/mIugaiihfCdBNN9wItchrA22tGw
         k/sPvkvulz2FzLsOhBcLvn1mXYk1dzzZYZy4dkxaKt13wJ9uHtvRCkDgG1sLVCnIucdR
         A3zDbXVgwj2T3ppAsab3BtirBy3al6xZrfVaRYvDoWRL9pm8Z7jFXO25Ek6sd/ab4MWh
         yBZg==
X-Gm-Message-State: AOJu0Yx+VU5eFmqrHVQsVhzPIX5mA39nYGyXPNoXgxY2JRa83Dg8cwto
	RVSzwo2eKapsQV5uAufOtH8jkc2IAPhsQ4+0qZF10EqYN8wp5QUM9obf2RvqhylBJUhP7SnvZ79
	zGOaPkXcuecqLlOgvqW71LoNpXwKVJ1ICPhUUzctV1vcpT6C7UbNffLPwTDarMR6K94YF0vsMEw
	==
X-Gm-Gg: AfdE7cl5JVTmbx2XVYHpmoDjwHBPYyQ00a+0dok+lYA2/6gJcb/SQlftvT+rhpyhl8q
	bkYAs+33IT2hEuT5m2vpvgCat9osHbsS4Oy921+5X0s4q5zvEof7n/gS0qOmgoXE474fHnVQ+ra
	kcgvHDFZ3Y/G3Nk0jQtK5ojbhlHHkf/a9jsPN0w22etZPZXSNJkvq8h1tozRm5Z9zMJmAw0qWeh
	BAUDuXU4rYJeIaEAEzUtPRwySTq7sMIpnzngN1FcEmUt6GQCPMpZIqsfMk3ne02zavm3ujtvS8a
	ZauitcD8SuqAu0yIGGXjjh9U3T6MqCVwrmFGhjSW/fDy+YAa77ZhNYpylWhOpmuA2ZrHRNpPU49
	nWrHZLGTL1HRgvxyzLo++m5/13t/sR0staJH0VetW0D/vDK7kWn3c2BhbGTIbUMfzSIiPKS+KcQ
	kbNoYRqw==
X-Received: by 2002:a05:600c:4692:b0:493:b750:bd20 with SMTP id 5b1f17b1804b1-493e68a5f91mr120361655e9.15.1783690312836;
        Fri, 10 Jul 2026 06:31:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:493:b750:bd20 with SMTP id 5b1f17b1804b1-493e68a5f91mr120360905e9.15.1783690312205;
        Fri, 10 Jul 2026 06:31:52 -0700 (PDT)
Received: from localhost (93-40-74-111.ip37.fastwebnet.it. [93.40.74.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f567eadfsm37394065e9.6.2026.07.10.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:31:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:31:50 +0200
From: Alessio Faina <alessio.faina@canonical.com>
To: Andrea Mayer <andrea@common-net.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	stefano.salsano@uniroma2.it,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next] selftests/net: Skip
 srv6_end_dt46_l3vpn_test::host_vpn_tests if iproute2 too old
Message-ID: <alD0RtS0XKiXbDPf@cicciput>
References: <20260708152745.2430714-1-alessio.faina@canonical.com>
 <20260710152211.63eb25d604ea0aa2b3707d68@common-net.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710152211.63eb25d604ea0aa2b3707d68@common-net.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea@common-net.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:po-hsu.lin@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:stefano.salsano@uniroma2.it,m:andrea.mayer@uniroma2.it,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306563-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:from_mime,canonical.com:email,canonical.com:dkim,srv6_end_dt46_l3vpn_test.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0261373B49F

On Fri, Jul 10, 2026 at 03:22:11PM +0200, Andrea Mayer wrote:
> On Wed,  8 Jul 2026 17:27:45 +0200
> Alessio Faina <alessio.faina@canonical.com> wrote:
> 
> > In case iproute2 is older than version 5.14.0, released ~Sept 1, 2021,
> > the End.DT46 support is not available and the host_vpn_tests test contained
> > in the srv6_end_dt46_l3vpn_test.sh file is failing in some kernel backports.
> > This is the result of those tests:
> > 
> > ################################################################################
> > TEST SECTION: SRv6 VPN connectivity test among hosts in the same tenant
> > ################################################################################
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> > 
> >     TEST: IPv6 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> > 
> >     TEST: IPv4 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> > 
> > To amend this, check the current running iproute2 supports the required
> > feature and, if not, just skip the test to avoid a failure.
> > 
> > 
> > Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
> > ---
> >  .../selftests/net/srv6_end_dt46_l3vpn_test.sh       | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> > index a5e959a080bb..406c6a3d253e 100755
> > --- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> > +++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> > @@ -510,12 +510,15 @@ host2gateway_tests()
> >  host_vpn_tests()
> >  {
> >  	log_section "SRv6 VPN connectivity test among hosts in the same tenant"
> > +	if ip route add help 2>&1 | grep -q -i End.DT46; then
> > +		check_and_log_hs_connectivity 1 2 100
> > +		check_and_log_hs_connectivity 2 1 100
> >  
> > -	check_and_log_hs_connectivity 1 2 100
> > -	check_and_log_hs_connectivity 2 1 100
> > -
> > -	check_and_log_hs_connectivity 3 4 200
> > -	check_and_log_hs_connectivity 4 3 200
> > +		check_and_log_hs_connectivity 3 4 200
> > +		check_and_log_hs_connectivity 4 3 200
> > +	else
> > +		echo "SKIP: SRv6 End.DT46 is unsupported by the installed iproute2 version"
> > +	fi
> >  }
> 
> Hi Alessio,
> 
> Rather than inlining the check inside host_vpn_tests(), I think it would be
> better to follow the pattern already used in srv6_hencap_red_l3vpn_test.sh,
> where test_iproute2_supp_or_ksft_skip() is called before setup(). A similar
> function here could exit the whole script with $ksft_skip if End.DT46 is not
> supported by the installed iproute2.
> 
> Thanks,
> 
> Ciao
> Andrea

Hi Andrea,

Thanks for your feedback, I will send a V2 with the requested changes.

Kind regards,

    -Alessio

