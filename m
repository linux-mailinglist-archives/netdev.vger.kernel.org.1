Return-Path: <netdev+bounces-251691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jHWSOQIvcGkMXAAAu9opvQ
	(envelope-from <netdev+bounces-251691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:42:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6764F42E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0907198FDF1
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C61310635;
	Wed, 21 Jan 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkmHKLyC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569D310631
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959699; cv=none; b=WS0Qk0KMZQzQP76m6Cy+1fUuCOSahdEbmf5JaNC+o08C+JhV8r3AesQry+1Pg8BVHxqLKmDVagSspqSjOSh5Ytq5w4DcGN5qfq1jS7dksN2QSQekKAKO8qRsnjY2Wu6EGdXQtJ1XJBgbjK3BWoDgbQR+gzfjOBo0Q4Xiiol+bPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959699; c=relaxed/simple;
	bh=qzNaz3Q5oVarjJ/0tCQUpR47z40hmKMjNfdlTnOMDds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+YDwITT8oropUZOpyogUYHhCz5ncKgxXJWUOlgux61DssmTE87LBbpXK0EADRDBI7KlDsvuH2DFL95qWrolJyPZPD0Zo+ShYm1ABeQ/ueb91s/1ej8ynstnRmyRAreV9itJH9Dhf+zwOXFbx2mqw8uhY+8jk7cn/pePSCG5ZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkmHKLyC; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649488dc7bdso25688d50.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768959690; x=1769564490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0gPyzl3flI+QLK9YSJSXFLXlGP49FWWM2rxD4Oz2s0=;
        b=ZkmHKLyC/WLqo6o/mGPeAQqCceLIevx6JbsDPL5iR9Ed10MLwr3pvwPGVAui0R0wqd
         O3foAJzBFxpO0MN74JR41sccEVcjFTahUh+Yi8VSpCtobcpgAta+pBdObhmo88mg6ZAW
         MAwODSU6ljoF8wMNK0mr9BS8rf0fZlMxHrC1JREKWbNBWQ43PhcMGlYgX4F63KWqIAi7
         aBbNHtWGtbeHVfPh8culwtbFiCM8DDxjRaunDgC5hzSS1EqB2DjSDDRwlI/+kix8+9z5
         3ppUVOd8KMzNrrFx5P4Iy5Ad0eq8gu/jUXFz6gYM4h8EThbAlut6s1reNMe3t+d9CiVt
         WQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959690; x=1769564490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0gPyzl3flI+QLK9YSJSXFLXlGP49FWWM2rxD4Oz2s0=;
        b=e4mEpljx/c+XtVE2RhQRX4QmBqtMb8VEn/iDEr5lfpB0JkbAVaM0uPid2fh4cdw+3K
         c9jBKhXdnRWXbms69jKoAUrU2yK9IqpZi4zIZQnXcofRkJ+7pOeoMzy42DR9jh5V2YfG
         DbbAbAw8pCUyyjbD/LL1Cx1pnXdsu5H6DID+Q0UcQXUCogMs6B/6kc9d04om4swJkkp7
         wjzNff22tP2psAEtUeknBSV0XSLZClUJHtQhtyeg9P/tv3wwEvOUzFVSRwvOjQtCNvPb
         9JFrxmCzuROSy7paV7nV4DLFyNPV/a+9nUC4CzPxDBRx7/zZcTgQGInRVVnH4HlylAYX
         ycmw==
X-Forwarded-Encrypted: i=1; AJvYcCUasLEVlvHW1dvfsGRfmz04mZjZQnFF/+P6C5OpuoqUAT8zcjf3Rrrb8TG97NnaWRNCCwcDyOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIjq6g0y0kOJ/f7PutZt+76vS4mrhxZU+SRZow8m6EDZoiv4C
	H7WIawzwzK+MIr6MvtEppsq6fAFYQnq6rkoGTj665bGRWVnOrN5lnmYm
X-Gm-Gg: AZuq6aKvxMMCBFK/fhcCHGNVqVpww+I45RvH1tRL4RqNX2QvrGUFSYNeWDPhZ+RfSSn
	4ZcGzNsnsBc1Kn2c2qCv6czbs6wGhGboytCDKTMIwaAhn9bEKXZNciWKgr0frnxyxrmRwuwmE92
	I903xUBGM2D65WI3KXgBD/OPbsozZQuF7pPcBEPBcLFin4GTu1exQ6ZVPO04apVLQKjEwHGZwyp
	D2TtpDnOLtJZ3fSIjPrUrxGw9YGSxQnY57rBj4xJk00cNS2BKKFhKscdNFb1/+A4IJNxqpSFZtn
	yBerOa9fsJIUvyld1+XG6TPL9RsMnwc0qjcYJx8vUteFsbjjMHcEWX4tDJscUMWe4LUc7O/lKOK
	tlDWQZE8oxbkCqEoLZT2nl0xNabfIEfEiEy2HQlvzj4RxI4pTotc78palXtSDfI9T1Gm+X6AIlz
	9AVamiZ64c7mqSIZW6ivZyBMOoRjYaV4tRGW8f5duwSikkvA==
X-Received: by 2002:a05:690e:d8d:b0:63e:b41:cebc with SMTP id 956f58d0204a3-6491648c379mr12616986d50.17.1768959690075;
        Tue, 20 Jan 2026 17:41:30 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494080138fsm1106822d50.20.2026.01.20.17.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 17:41:29 -0800 (PST)
Date: Tue, 20 Jan 2026 17:41:28 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: forwarding: cleanup veth peers created
 via NUM_NETIFS
Message-ID: <aXAuyPwez4ZfuFT7@devvm11784.nha0.facebook.com>
References: <20260120230905.328528-1-aleksey.oladko@virtuozzo.com>
 <aXAsb+sCbyeD/xkL@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXAsb+sCbyeD/xkL@devvm11784.nha0.facebook.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-251691-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm11784.nha0.facebook.com:mid,min_max_mtu.sh:url,lib.sh:url,bridge_activity_notify.sh:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7D6764F42E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:31:27PM -0800, Bobby Eshleman wrote:
> On Tue, Jan 20, 2026 at 11:09:05PM +0000, Aleksei Oladko wrote:
> > Some net/forwarding kselftests set NUM_NETIFS, causing lib.sh to create
> > the requested number of veth peer interfaces.
> > 
> > These interfaces are not removed when the tests finish, leaving stale
> > veth devices in the system. This can cause subsequent tests to fail,
> > for example min_max_mtu.sh.
> > 
> > Ensure that veth peers created via NUM_NETIFS are properly removed at
> > the end of the tests to avoid interference between test runs.
> > 
> > Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> > ---
> >  tools/testing/selftests/net/forwarding/lib.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index a9034f0bb58b..ae7699c0c7e5 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -597,6 +597,10 @@ vrf_cleanup()
> >  	ip -6 rule del pref 32765
> >  	ip -4 rule add pref 0 table local
> >  	ip -4 rule del pref 32765
> > +
> > +	for ((i = 1; i <= NUM_NETIFS; i=$i+2)); do
> 
> I'd suggest 'i = i + 2' here instead of "i=$i+2", as it seems closer to the rest of lib.sh
> style.
> 
> > +		ip link delete dev ${NETIFS[p$i]} 2>/dev/null || true
> > +	done
> >  }
> >  
> >  adf_vrf_prepare()
> > -- 
> > 2.43.0
> > 
> 
> I see that some tests that set NUM_NETIFS do not seem to call
> vrf_cleanup() (e.g. bridge_activity_notify.sh), so I think those tests
> will still leak?

My mistake here, I now see there is a more indirect call to vrf_cleanup
via defer there.

Best,
Bobby

> 
> Maybe lib.sh needs a remove_netif() to go along with create_netif(), and
> then tests can call it from their 'cleanup()' EXIT handlers? This avoids
> the mismatch between vrf_prepare() not creating devices but
> vrf_cleanup() removing them.
> 

