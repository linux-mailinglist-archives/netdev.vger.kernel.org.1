Return-Path: <netdev+bounces-214990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF8B2C822
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F6F188746E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBF279DA4;
	Tue, 19 Aug 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAxUv4MU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1F2737E8;
	Tue, 19 Aug 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616184; cv=none; b=YHS6RnC2v+FtX5OPAhfpEWrTWM6bxQ162WCVNBRrwibIhy/6nZKA0pE5y4IQFepQKWKxoXZAJVX3c0ukJwTvzC4UztREua4ijMnTRm9ZJfNtAy9hMtGja5IHduJiO0UKK8Gn8gMxdD0BiTPAp0A5AauozOvthz5SaIg2R9pluz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616184; c=relaxed/simple;
	bh=ilXPQf07vYnOE5RDAjQYMqEV2dFjwgPCc1hikj9TGVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L24/g/M4ePe/HEZQOf8WYPQ2tAs/EBoGP/Eg5vdo6/mPYLwlU8njIjkA39LJkF1LxUBQvWRwQg+NRdPf84ZumhHErm0mOkKa8DksRW7YjnspX3egZSBsbbZJxAWVC7idnQIXFncb7fN/5snP9+2zMX+R0HKFcBBpPg56h1ve9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAxUv4MU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so30696055e9.3;
        Tue, 19 Aug 2025 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755616180; x=1756220980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1feyKQYc1oRZQ3DNkLI+q/wD+PrGaOhN6OQFFDtem4=;
        b=ZAxUv4MUm7rLD8ja3TZh17hl5bOHxDnyAXXRnFEJBVH70Xf2p3roPAyZN6FS78xW40
         JLkorpAa6w8o13qywpZim3CazY6pW3NPXHwOxDE9i2fkFWqb64TgPWzsFUGGkp4qHgSj
         ILF5w3I+ouHUeUCN5GVd4eqxlNZjzpI8NuPihqxI9XdNBb5y0pSakmXLiwBZ5G82IqoD
         KgZbAqj3r8A06ZJJob2VJTo9DpFKeV24c7mruSBzI5z6O2CPFo2UmPFEr6NnQj+bcNeJ
         Oj9qgxr1WuaX26YjfyTpjHGVIcmyKik9oiCFEY88e2EFYnUGkGRIk84XlTDdhZ9zdRI3
         m/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616180; x=1756220980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1feyKQYc1oRZQ3DNkLI+q/wD+PrGaOhN6OQFFDtem4=;
        b=itFJOtYX8hsnejKN0yAuZR5LHj4tGT59MhgKJ4Guv6vkR9Wpwuxd8HNjDR+SElGkLo
         3Lis4V+XSCZrKyyh/A7h8LvSlY+RwtRk3ZRXOmn9rDY36utIBdEYDOXG5s+sbwvBvoXX
         h1wScPoVVK1ZONIZHa8tkq3E8bfUk0Id7xxeqvuqrxEEsjzIwqwEA41YbKiA8YbI3Vor
         82i/IWejtjLZVA8PiZ63VmTkHtT3flFw1a4lAVBrdfmFw4TpFLtnbC/r/3wxqnm3zKwr
         OQ3tfyizPK3lwB6vgIgNQgmOmgjK6GnriUR18VP0eWDvhq9MCGsRnul5xCpQuw5HsBMc
         iveQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU4y1x/Kvr+hpWBEIvcryL850Tb4Yp/q3MuE6S86T8OuuBCo3oF5f3xV+0Zi0B8jz3R2NxRDZrBZW5jXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCr0GNnmfeRGqCcHCg5bwrAfrfdFtTSv3tW+6OXAhuPlgRCurS
	RDt/BJzjCkDIQrcZKZGzB3nhSjNt2L/JSu4t1V5Tv6+PwEsLBtYXbbnEHrAo8A==
X-Gm-Gg: ASbGncsrMw5rKTZPN68bODTUMBT9zUHrht1ZCkFP7l/1bafsu95zytDPOxhBWk5BORL
	u7k1XXt5zJ55eMYmOZwDpnEsQK/ywgz6Q82MHFi/92KbB4vsk0/MK6B0+jZmGPgLCnTMKAjre/T
	cmHXsjuG+PE2B0T7p51wDD7ksLL7JKJNz26NHFcRq9445DeNXDczLgjupbxc0BUt/515ZTkX92w
	V5H0KbhAps11NGznhqDMRYQZNnMB8XxxGvRXGhDSSegC//lWDgdhhLR52MWSCyKm17hqIaqcvIN
	W8pBcYSPWDMgeU/+S9xBUKGG4K+rm1Goy9VcFHcWt5bH4r2CIcDyDkT3k5KmekuSYCc9YEHHuJy
	+bQSzdpmVmR8QWbrAwr90yAzX9Gmvx14ceeUkbDECA1d4Hw==
X-Google-Smtp-Source: AGHT+IGss+b3FYfsgzJgXliXCak0TvMa0B/xahMOxT9XZ3nvbhNGMyKE5si/Gwd6SdDR545D76eaTw==
X-Received: by 2002:a05:600c:4f0a:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45b46029c49mr17538215e9.3.1755616180323;
        Tue, 19 Aug 2025 08:09:40 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b43e13eafsm15184845e9.9.2025.08.19.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:09:39 -0700 (PDT)
Date: Tue, 19 Aug 2025 02:11:05 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] selftests: net: add test for dst hint
 mechanism with directed broadcast addresses
Message-ID: <20250819001105-oscmaes92@gmail.com>
References: <20250814140309.3742-1-oscmaes92@gmail.com>
 <20250814140309.3742-3-oscmaes92@gmail.com>
 <98b7d1b2-843c-40c6-8918-1af431aedc5f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b7d1b2-843c-40c6-8918-1af431aedc5f@redhat.com>

On Tue, Aug 19, 2025 at 12:56:58PM +0200, Paolo Abeni wrote:
> On 8/14/25 4:03 PM, Oscar Maes wrote:
> >  tools/testing/selftests/net/route_hint.sh | 58 +++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/route_hint.sh
> 
> You must additionally update the net selftest Makefile to include the
> new test.
> 

My bad.

> > 
> > diff --git a/tools/testing/selftests/net/route_hint.sh b/tools/testing/selftests/net/route_hint.sh
> > new file mode 100755
> > index 000000000000..fab08d8b742d
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/route_hint.sh
> > @@ -0,0 +1,58 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# This test ensures directed broadcast routes use dst hint mechanism
> > +
> > +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
> > +CLIENT_IP4="192.168.0.1"
> > +
> > +SERVER_NS=$(mktemp -u server-XXXXXXXX)
> > +SERVER_IP4="192.168.0.2"
> 
> > +
> > +BROADCAST_ADDRESS="192.168.0.255"
> > +
> > +setup() {
> > +	ip netns add "${CLIENT_NS}"
> > +	ip netns add "${SERVER_NS}"
> 
> You can/should use setup_ns() from lib.sh to avoid some duplicate code
> 
> > +
> > +	ip -net "${SERVER_NS}" link add link1 type veth peer name link0 netns "${CLIENT_NS}"
> > +
> > +	ip -net "${CLIENT_NS}" link set link0 up
> > +	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}/24" dev link0
> > +
> > +	ip -net "${SERVER_NS}" link set link1 up
> > +	ip -net "${SERVER_NS}" addr add "${SERVER_IP4}/24" dev link1
> > +
> > +	ip netns exec "${CLIENT_NS}" ethtool -K link0 tcp-segmentation-offload off
> > +	ip netns exec "${SERVER_NS}" sh -c "echo 500000000 > /sys/class/net/link1/gro_flush_timeout"
> > +	ip netns exec "${SERVER_NS}" sh -c "echo 1 > /sys/class/net/link1/napi_defer_hard_irqs"
> > +	ip netns exec "${SERVER_NS}" ethtool -K link1 generic-receive-offload on
> > +}
> > +
> > +cleanup() {
> > +	ip -net "${SERVER_NS}" link del link1
> > +	ip netns del "${CLIENT_NS}"
> > +	ip netns del "${SERVER_NS}"
> > +}
> > +
> > +directed_bcast_hint_test()
> > +{
> > +	echo "Testing for directed broadcast route hint"
> > +
> > +	orig_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')
> 
> Likely using the '--json' argument and 'jq' will make the parsing more
> clear.
> 
> > +	ip netns exec "${CLIENT_NS}" mausezahn link0 -a own -b bcast -A "${CLIENT_IP4}" \
> > +		-B "${BROADCAST_ADDRESS}" -c1 -t tcp "sp=1-100,dp=1234,s=1,a=0" -p 5 -q
> 
> You should check for mausezahn presence and ev. error out with error
> code 4 (ksft_skip)
> 
> > +	sleep 1
> > +	new_in_brd=$(ip netns exec "${SERVER_NS}" lnstat -k in_brd -s0 -i1 -c1 | tr -d ' |')
> > +
> > +	res=$(echo "${new_in_brd} - ${orig_in_brd}" | bc)
> > +
> > +	[ "${res}" -lt 100 ]
> 
> It would be helpful additionally printing the test result:  '[ ok ]' /
> '[fail] expected ... found ...'
> 
> /P
> 

Will fix everything in v3 and resend shortly.

