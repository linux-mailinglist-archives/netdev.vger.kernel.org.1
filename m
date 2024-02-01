Return-Path: <netdev+bounces-67885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1B84530D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A877B2A049
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D17215A48D;
	Thu,  1 Feb 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZLBBjkA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F8158D73
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777206; cv=none; b=ttWW/JPwYignYlWIJMQ0H7jficvkpYjYmP2OVQ3f01BP7uimaOpVk0qUHZbK+fUpk4FXIrmR0t9Rb+AVl5KVPjYkJRRWZR/x931FwXsReB7tbLg89tc5K1tFoxDlJ1sSjNZru19SBJ42RPhQ5Tal7KS9zu8Wq7u7hyRPAWRoXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777206; c=relaxed/simple;
	bh=HDDgc3DYIvJlEAf/HDIklfJjlAmF5ag2A5F2hGaSdKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucAllt8eAx7mb6LFiYvaOu/3QR9+RE8ChgTT4Ecczb28xYO+UgQaJbX7qll1VMswlY3RLAqPBAT3YgTKZL6wXD4lb9zN7/eazvKVlEpZc6OWVKbhAJ9tWdr7ZCjJpPC0GQztAlOeopPpUfXkzbJJN1VsUkTLRrYFG0z/DJY3OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZLBBjkA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso496278b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706777204; x=1707382004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQqTHiB8TMg4U5jsMXf86q3YGCcW661kV46ANIgPBU4=;
        b=mZLBBjkAxwEdCcLMGW8d9bpwfTkUfo4mcZJ9nwS4Lyt83LTIOr0cNARwdXgjpkVww2
         SX8un3BVgL04T+PFlTn2ByDpKOqCpNss4m/hcRum7NFnZzShxAsmiv+Q2k4AH88m7Rzz
         jj8jU1mRXj4w73B3vABhngAkFQrSYUrF1clAn704tmFMCpIc7cSUgXax04lE/u2h+BW/
         bpekLbZ7kLn79x1DRTR5QUjcRHUhuDu/7eQuEMv9E5xlnhRZNdvIpJTCayxqLwvvP8fK
         uNfYI/zOYCO3Dy8OD8fF6JGf6pfC3iRnP6tqohiAD70QqOP3wksqh0d1Pfa2x0GZz8Jp
         9fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777204; x=1707382004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQqTHiB8TMg4U5jsMXf86q3YGCcW661kV46ANIgPBU4=;
        b=qSGvtIVQjwwiqgKj16c0YqFoWEZ58+Uo7aOKgcGexYWj85u3n+piv1wJ9G4yJijG2/
         tApFj+N3DuvXROCwUV7+OqGUSdZidvQhhHNfBy0U5yJReCdZtKvaXlRwu07xQ5Ae017I
         8FVjus0q1ewgXFkthFOdVtG5f4aYVy/qAA7lTYZQbzEskwSHyYgENIAlzLoXFsRlAZm8
         rMgtqTpreFG+POdyKYtlgq6EqdaeimCTcFsGK8cOsgGo1m0RsVQrA4DrdyDE112qL9Q8
         FQPaAR0saRMYNX+AHqoNd858vihV20YuwHfuErpqzlIBMwVk1XIdMlDsLm2JMwrjUgi1
         zEIw==
X-Gm-Message-State: AOJu0YzxdIo2j0MKaMOF4vHK7wYwsVbrZXr5/mn3EQKZ27Y6JjSEHZlh
	dy9bpzJQXQmQzL0BvvYDkiT/mcH+HFptQZYXVp1hirx+K1TqKoRl
X-Google-Smtp-Source: AGHT+IFVsiXdFjtp54d+WFJoYiMWiJItXs6EiMGbEbUqjiaIc2ZCuFgK7Wp64QzQAF9SqiOtPk+8xA==
X-Received: by 2002:a05:6a20:252d:b0:19c:9a96:e68f with SMTP id j45-20020a056a20252d00b0019c9a96e68fmr1296062pzd.61.1706777204379;
        Thu, 01 Feb 2024 00:46:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUAUXdYL/bYKANbRAzg1IyQ9K5zsWcYCvutsLL6kLYWaZz5qrXE+Y5qaA9jKS0Lzm9hFQicoEEj+o1HWhfYqVr1VSDaoDg6/EuwdbnPN1VJSmamCGBkLCflXZgA49wB+UBdg/C7Oi2IZXt3KZb23ZmkTLhQa2X03VC2BhQm+1T5WhoDEaY3255X7hITEimnadoHT3+hD7SPUn4GebMM7VlEKR0AZSMXhrpID2ww2/7wKfEF53VQuvsm2weDji/HVj8NnaDJMW3mHBAh3G9y/HmfdiO1gWt0fIa46CeLS57zel5Yl+QyG5Z03OLSSIFvTQpNrCU=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902e00b00b001d944e8f0fdsm1178112plo.32.2024.02.01.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:46:43 -0800 (PST)
Date: Thu, 1 Feb 2024 16:46:38 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Message-ID: <ZbtabpEr7I6Gy5vE@Laptop-X1>
References: <20240131064041.3445212-1-thinker.li@gmail.com>
 <20240131064041.3445212-6-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131064041.3445212-6-thinker.li@gmail.com>

Hi,

On Tue, Jan 30, 2024 at 10:40:41PM -0800, thinker.li@gmail.com wrote:
> +# Create a new dummy_10 to remove all associated routes.
> +reset_dummy_10()
> +{
> +	$IP link del dev dummy_10
> +
> +	$IP link add dummy_10 type dummy
> +	$IP link set dev dummy_10 up
> +	$IP -6 address add 2001:10::1/64 dev dummy_10
> +}
> +
>  fib6_gc_test()
>  {
>  	setup
> @@ -768,15 +778,19 @@ fib6_gc_test()
>  	    $IP -6 route add 2001:20::$i \
>  		via 2001:10::2 dev dummy_10 expires $EXPIRE
>  	done
> -	sleep $(($EXPIRE * 2))
> -	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> -	if [ $N_EXP_SLEEP -ne 0 ]; then
> -	    echo "FAIL: expected 0 routes with expires, got $N_EXP_SLEEP"
> +	sleep $(($EXPIRE * 2 + 1))
> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
> +	if [ $N_EXP -ne 0 ]; then
> +	    echo "FAIL: expected 0 routes with expires, got $N_EXP"
>  	    ret=1
>  	else
>  	    ret=0
>  	fi
>  
> +	log_test $ret 0 "ipv6 route garbage collection"
> +
> +	reset_dummy_10

Since you reset the dummy device and will not affect the later tests. Maybe
you can log the test directly, e.g.

	if [ "$($IP -6 route list |grep expires|wc -l)" -ne 0 ]; then
		log_test $ret 0 "ipv6 route garbage collection"
	fi

Or, if you want to keep ret and also report passed log, you can wrapper the
number checking like

check_exp_number()
{
	local exp=$1
	local n_exp=$($IP -6 route list |grep expires|wc -l)
	if [ "$n_exp" -ne "$exp" ]; then
		echo "FAIL: expected $exp routes with expires, got $n_exp"
		ret=1
	else
		ret=0
	fi
}

Then we can call it without repeating the if/else lines

	check_exp_number 0
	log_test $ret 0 "ipv6 route garbage collection"

Thanks
Hangbin

