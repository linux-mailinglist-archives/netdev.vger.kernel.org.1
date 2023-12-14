Return-Path: <netdev+bounces-57220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497C28125F1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2636282221
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EE1FA6;
	Thu, 14 Dec 2023 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npqAUuSN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD7111
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:32:21 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b88f2a37deso6101871b6e.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702524740; x=1703129540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaGxa3QJFvIw4TL1TAOpjq2XjcZQjJla7h8Yk1rgyaA=;
        b=npqAUuSNQMPzCRlj241TQuB3g05oROWI04DLK2+LvCMi3GYnG1XQfjUpslm3yoRjSV
         2GugMkAirECnQ1Bb6I+vxldXXm2TuVinj6iSJ0vavrV7SBwT4gowP7K3DqLVahBhrOH9
         Fnul2izRf8YBmD0HeFDEqcPp1jJZikC5CDIqN9yCnwpj4MwDJKGX/T+z+4qzy6rv/aQ/
         xEbr3Wt6xnlUyyo8itMojsyI0Me5RAA2l8LojnoZ8NxnkDLDld66jSACUEFrGOdhO288
         UMsapA1NYiQT5RXlDOSX4hfmMhFijBiW8NOSgqk1qD/2jxBMN4Pj78uZFdcdFKEW+4DN
         OPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702524740; x=1703129540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaGxa3QJFvIw4TL1TAOpjq2XjcZQjJla7h8Yk1rgyaA=;
        b=NJSuj1hiO5ddYm8Wg333syNzePx1koeTE+W5fSNnCdz/t+jAMuWd9nc6jGIASj5vPi
         ckQw1wYd/YBNMcxhX3KX4OTuwFKj4mtljSZUObPZ0teS4hDAD0GlqcJR8vK5O8f3t2Km
         X7DLB0F+e7Jmb+Ms4sgzx9myMuWKW116JDOJWh8AIHculsvbBCYE7SzrLeLpMfvmJ4I8
         ZeSVmmzKlKmf4VLXJAWSBEmw2TCBCatVJxWYyMf9s1g+eKWp82LNvynXrsOK8uggHEal
         h0D/YkOw3yigxGDFtoRVMKKlpw1HH+xiIYWR1ofr28i7eo8VvwvqZb0evzI1zikTvmuh
         KhlA==
X-Gm-Message-State: AOJu0YwAmKUirLh9qsu9bKWA+nao2DQONITGfeVETcZ6w4qTyCQupUHG
	pYt5B2BIdrT/4svKiZKqgEk=
X-Google-Smtp-Source: AGHT+IHhq35rDJNb+RGjH/dohURFPOeSYGsUZfP7BXK9pN7QkxBVCaUJbB3OCC7vW5GiXJH7iZAYUQ==
X-Received: by 2002:a05:6808:2201:b0:3b8:63aa:826f with SMTP id bd1-20020a056808220100b003b863aa826fmr13601733oib.25.1702524740210;
        Wed, 13 Dec 2023 19:32:20 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k13-20020aa792cd000000b006ce273562fasm10672588pfa.40.2023.12.13.19.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 19:32:19 -0800 (PST)
Date: Thu, 14 Dec 2023 11:32:13 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, edumazet@google.com, sinquersw@gmail.com,
	kuifeng@meta.com
Subject: Re: [PATCH net-next v3 2/2] selftests: fib_tests: Add tests for
 toggling between w/ and w/o expires.
Message-ID: <ZXp3PYOBji7AArUG@Laptop-X1>
References: <20231213213735.434249-1-thinker.li@gmail.com>
 <20231213213735.434249-3-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213213735.434249-3-thinker.li@gmail.com>

Hi Kui-Feng,

On Wed, Dec 13, 2023 at 01:37:35PM -0800, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Make sure that toggling routes between w/ expires and w/o expires works
> properly with GC list.
> 
> When a route with expires is replaced by a permanent route, the entry
> should be removed from the gc list. When a permanent routes is replaced by
> a temporary route, the new entry should be added to the gc list. The new
> tests check if these basic operators work properly.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 82 +++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index 66d0db7a2614..337d0febd796 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -785,6 +785,8 @@ fib6_gc_test()
>  	    ret=0
>  	fi
>  
> +	log_test $ret 0 "ipv6 route garbage collection"

If the ret doesn't affect the later tests. You can simple do like:

if [ $N_EXP_SLEEP -ne 0 ]; then
	log_test 1 0 "fib6_gc: expected 0 routes with expires, got $N_EXP_SLEEP"
fi

> +
>  	# Permanent routes
>  	for i in $(seq 1 5000); do
>  	    $IP -6 route add 2001:30::$i \
> @@ -806,9 +808,85 @@ fib6_gc_test()
>  	    ret=0
>  	fi
>  
> -	set +e
> +	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
>  
> -	log_test $ret 0 "ipv6 route garbage collection"
> +	# Delete permanent routes
> +	for i in $(seq 1 5000); do
> +	    $IP -6 route del 2001:30::$i \
> +		via 2001:10::2 dev dummy_10
> +	done
> +
> +	# Permanent routes
> +	for i in $(seq 1 100); do
> +	    # Expire route after $EXPIRE seconds

            ^^ These are permanent routes, no expires

> +	    $IP -6 route add 2001:20::$i \
> +		via 2001:10::2 dev dummy_10
> +	done
> +	# Replace with temporary routes
> +	for i in $(seq 1 100); do
> +	    # Expire route after $EXPIRE seconds
> +	    $IP -6 route replace 2001:20::$i \
> +		via 2001:10::2 dev dummy_10 expires $EXPIRE
> +	done
> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP_SLEEP -ne 100 ]; then
> +	    echo "FAIL: expected 100 routes with expires, got $N_EXP_SLEEP"
> +	    ret=1
> +	else
> +	    ret=0
> +	fi
> +
> +	if [ $ret -eq 0 ]; then

All these if/else ret setting/checking looks redundant. Either we can just return
when one test failed (so there is no need to check if $ret -eq 0).

if [ $N_EXP_SLEEP -ne 100 ]; then
	log_test 1 0 "fib6_gc: replace permanent to temporary: expected 100 routes with expires, got $N_EXP_SLEEP"
	cleanup &> /dev/null
	return
fi

Or, use different subnet for testing. So the next one doesn't affect the
previous test. Then there is no need to call "cleanup && return" for every
failed check. e.g.

do temporary route test with 2001:20:: subnet
if [ $N_EXP_SLEEP -ne 0 ]; then
    log_test 1 0 "some log info"
fi

do permanent route + temp route with 2001:30:: subnet
if [ $N_EXP_SLEEP -ne 0 ]; then
    log_test 1 0 "some log info"
fi
(Here we'd better remove the 5000 permanent route :), or just del and re-add
the interface directly.)

do permanent route with replace to temp route with 2001:40:: subnet
if [ $N_EXP_SLEEP -ne 100 ]; then
    log_test 1 0 "some log info"
else
   sleep and recheck the route number
fi

etc.

> +	    sleep $(($EXPIRE * 2 + 1))
> +	    N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> +	    if [ $N_EXP_SLEEP -ne 0 ]; then
> +		echo "FAIL: expected 0 routes with expires," \
> +		     "got $N_EXP_SLEEP"
> +		ret=1
> +	    else
> +		ret=0
> +	    fi
> +	fi
> +
> +	if [ $ret -eq 0 ]; then
> +	    PERM_BASE=$($IP -6 route list |grep -v expires|wc -l)
> +	    # Temporary routes
> +	    for i in $(seq 1 100); do
> +		# Expire route after $EXPIRE seconds
> +		$IP -6 route add 2001:20::$i \
> +		    via 2001:10::2 dev dummy_10 expires $EXPIRE
> +	    done
> +	    # Replace with permanent routes
> +	    for i in $(seq 1 100); do
> +		# Expire route after $EXPIRE seconds

                ^^ These are permanent routes.

Thanks
Hangbin

