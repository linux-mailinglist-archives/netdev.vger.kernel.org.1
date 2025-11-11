Return-Path: <netdev+bounces-237727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDFC4FA28
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 20:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64B6D4E8EF1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF031330D22;
	Tue, 11 Nov 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keUp0W7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DD32ABFD
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890297; cv=none; b=fY/aWvQLBHuzqsMBH9x2+kvU6ULYe2JB7XxNRMngu6GFNnlHzLww192ptRlbXT9AcL7E5QZuuy7objohRP38FGl6iqTHnap98cYHRxZkva3Lv4EbjMSW7AOU7+yNSVdRblqonS2VFmioqPgln4A09im3LGc1Q/Ld8aRkDL+7XB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890297; c=relaxed/simple;
	bh=7oWpdWjh8bUsjMbqkolVny17Ncf5rKANuor1AjH+n/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsYlIEOdBcTCTImo+UloMdThmJ4War9jmeeH/fMA4GGaVrVix2YcdFyTSGuPWxjXHlFIhzEKm4+h2Qp4/K5WSkHoLMyU/xBupRMDa3oz8yBerKK/myLpAuOnaF3n34peevIapOhzh3lgpF7IA29OrLVJvtBQ++Z8tZ77NUpkKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keUp0W7R; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c82bf86bso20265f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890294; x=1763495094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vL8T6v//WK5ms8HtdFj+QIL7sFTl22SJ6QXIGnOjBo=;
        b=keUp0W7RWwNrWaLT9DesESq4xUlrgnG73P1bYhcACh+Ay3B0aLJ0FJGx1xRtwZvWtU
         yeaOfE+OVLk/8quh1jcBWAqY0lBcoSgCSvdH46cY5+hBaLWtmf5RB9XzOBO6txhICV7y
         iK3hZimEXtl2JCqNZ+sGKK0MpOjew8U1wE0yaXwS4aB7zNNyEtWd0IhXr3x3jYQdFbeG
         9gQAfIfk5GuQH/tsG3P8VLhj6hw3/nGUqYS1KHEiIAnGTR2hWZLg8CjLF4VyCv1xGx73
         X73WjRkb8vWVwoQcKnUr0+IG4rCujwDuZQk3bJ4iJ8FABS9pqvcE5kuYvqkB446rpW4M
         OGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890294; x=1763495094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vL8T6v//WK5ms8HtdFj+QIL7sFTl22SJ6QXIGnOjBo=;
        b=UA7K5QxNaVvQb22kQysjRP2Cep1klnF6+/LGsQK+bV766tm9d+hNcnhGtLlHC4AhNE
         Sa64b5Jq7vtxLUA+BYbEHEavzd5mYdEqvx+t+IUnGWrj51ajZe01Ts1+IK1ZootI6r/8
         Pgq2vWE6afOE7mqhefCpJRJASZ5JOLmZBPo6KByYk2WEJ1T3xKitr1rambhm85umlHp5
         Qykm6BoVsjPnhxvNLdq1KasgKwQED0KQHBADtJZWPCjHVu6d3nXRadfuUH4UWT4KRKh2
         ILwx+6hh33kd3nFx46GjQGVlho0f4S0mZUOMyDzhOwRVXskn7O9/P/sd2E71HSOMd5O5
         MlvA==
X-Forwarded-Encrypted: i=1; AJvYcCVxexA2KE9h9Tup8XIOTCzzZXr3/XOhUh6WgwSneSOAnGxjuNKx4lwSq9fxPFtK7SQyln7Ofug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1BSlGoIJbNgrrKuaSotRnccH6iP2Fi3COy6a53KWJti9siLo
	0++bNZ6SDgIem3sp+K1ZonOW5DhaHSHRPoyDa5IUEZqzKa8kDGkjYtO8
X-Gm-Gg: ASbGncu/qZ2jYD9aZ8Sg/amrWiOpXco3NAheNW14ReDe11Y5Om/Nad+O4aaXHjidnqi
	eJb9duWMIG3cxxWiHHg8VNz4sXBl79tQ0z3bwn7jXi4ptUr7qs74+Q9FRTOljDjFyo20ckytCaS
	RRDmDeIIGkpfwr2YirOoW6/6V24LK5arRuqcJ73gL+cNsh4+mLWWTt1DVmtm24yof5aphji/Zbe
	U/L6Wep1CNZO4E2vEmvsByxvTQlxxi88DG+6AXbP3IZ+7toG+VYRjT8fwkn65ghOA0fmDxuOBbj
	tkW2hUis52morvzdyZXltasZrXWs01TYmq4/NCg4d7hF3N4z6ctxL/6lsksgB1YQViRp2HaE/B4
	nQlLwVbHABytx0HZneuhW0zKM2JGfp1tORj+BjL3C45wY3nkGGzq1Sl38GiFiePWTo4od9qmf
X-Google-Smtp-Source: AGHT+IFaIln3yiGIh9seHXdbbc3BGtrHgn26mO1mY0X8kAuJekH79JQX+ckG0i3gu/pYK/9GFm+SlA==
X-Received: by 2002:a05:6000:2509:b0:3fb:aca3:d5d9 with SMTP id ffacd0b85a97d-42b4bb8ed31mr286811f8f.1.1762890294369;
        Tue, 11 Nov 2025 11:44:54 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm28841586f8f.9.2025.11.11.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:44:53 -0800 (PST)
Date: Tue, 11 Nov 2025 19:44:52 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] selftests: netconsole: validate target
 resume
Message-ID: <nb7mfjnisgeenoazh5wi2e2twt5ooxfg225oqq3tuq5iqezi3r@mm6z3s4npsrd>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>
 <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>

On Tue, Nov 11, 2025 at 02:27:53AM -0800, Breno Leitao wrote:
> > +
> > +	if [ "${STATE}" == "enabled" ]
> > +	then
> > +		ENABLED=1
> 
> Shouldn't they be local variables in here ?

Yes, good point.

> > +	else
> > +		ENABLED=0
> > +	fi
> > +
> > +	if [ ! -f "$FILE" ]; then
> 
> 	if [ ! -f "${TARGET_PATH}" ]; then
> 
> > +		echo "FAIL: Target does not exist." >&2
> > +		exit "${ksft_fail}"
> > +	fi
> > +
> > +	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {
> 
> 	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${TARGET_PATH}/enabled\")\"" || {
> 

Ack.

> > +		echo "FAIL: ${TARGET} is not ${STATE}." >&2
> > +	}
> > +}
> > +
> >  # A wrapper to translate protocol version to udp version
> >  function wait_for_port() {
> >  	local NAMESPACE=${1}
> > diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> > new file mode 100755
> > index 000000000000..404df7abef1b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> > @@ -0,0 +1,92 @@
> > +#!/usr/bin/env bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# This test validates that netconsole is able to resume a target that was
> > +# deactivated when its interface was removed when the interface is brought
> > +# back up.
> 
> Comment above is a bit harder to understand.
> 

Agreed. What do you think of: 

# This test validates that netconsole is able to resume a previously deactivated
# target once its interface is brought back up. 

> > +for BINDMODE in "ifname" "mac"
> > +do
> > +	echo "Running with bind mode: ${BINDMODE}" >&2
> > +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> > +	echo "6 5" > /proc/sys/kernel/printk
> > +
> > +	# Create one namespace and two interfaces
> > +	set_network
> > +	trap do_cleanup EXIT
> 
> can we keep these trap lines outside of the loop?
> 

Let me try to do that. I'm using different handlers depending on how far we are on
the test but instead I think I should be able to use a similar approach as you did
with cleanup_netcons() in https://lore.kernel.org/netdev/20251107-netconsole_torture-v10-4-749227b55f63@debian.org/.

> > +	pkill_socat
> > +	# Cleanup & unload the module
> > +	cleanup "${NETCONS_CONFIGFS}/cmdline0"
> > +	rmmod netconsole
> 
> Why do we need to remove netconsole module in here?

We are removing the module here so we can load it on the second iteration of the
test with new cmdline. This is following a similar pattern to netcons_cmdline.sh.

> Thanks for this patch. This is solving a real issue we have right now.
> --breno

Thanks for the review!

-- 
Andre Carvalho

