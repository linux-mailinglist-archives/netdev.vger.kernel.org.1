Return-Path: <netdev+bounces-233264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26813C0FA18
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 010844E1C8A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8343090C1;
	Mon, 27 Oct 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3RNxoTo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943A27A122
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586124; cv=none; b=i4AJnniuQbQz+2U5tE1zD6qZbzRnbhHe3zYApcFRZgVjOaDKwSAxSiEK/6KRLVsoRju4fQBJDrTlau5wtvOBxTCkYIOmRugxpGF+G+mss1RceRCjaAFgFeGQaPLPi4HcLy7XcIdgVBzsb4j+RN0WmwNdosdZo7gK1QkdRA9da20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586124; c=relaxed/simple;
	bh=n15GkVGRlM82y8bsXWGWKv4Ru0ouDE1mhKQda2Lxd3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZND0E3wzzEfaL73kx45GIrbbM6f4yYBLPKFp7ZQUb+ktEZ1Kf0cUw7iXkUfJ+Fdls8ApTohcSXxXW0NjK4aBup2Pt/bjn8KloSqkzEyGYrl8ynlfM3Y4PRiOvT2EKxcmRvy84NiXMVl+YO1EUoOBCmz3Z7npoaDZXO51zCDw+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3RNxoTo; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-784a5f53e60so58755627b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761586122; x=1762190922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=W3RNxoToAcmeXPfx5Lef5kG3LqvhP2a+x4eCRJPsXpSfbugs5gw9pvySwndsflcKcg
         /SrF0fVltryWnZcR6D4Bs4EWseD+5ykSuK/w6UAdRfwPZXWIOGzB3i7AmttfXfPdQeGH
         ku9Gv0V3No0+pBOG6Tya++NPkhOG+m5zS+31mU4GPUR09KPCnJgiqfLnddZQdia1KPU2
         +GxBaZ+qiLqBpvxfhw9YsvfIxsp637zlJnMfCL/jOUW9HrjKU1BqOFjvifVX7YmipqRM
         E3aDLz5nLDvmsLKLY2Jx3XItKcViG+Q6SnACPK+9QWTvXChaG91Ae6Raq40cafssBS7s
         q+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761586122; x=1762190922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=ZytiX9wSM59nS/T8Jp3OFPYkLb7SFJn/qI+c91E63Nb3MbAQET+KY9IJrK/sLHcLJL
         dNgEFodrHdFNw838lCll6VqbiNlSuePcVy14dasQOaMc13IgdKFLXQrCoz1IhW0+QGdJ
         7tb5VoB9FXMFbozULQcFl0IGLPo5eO9HONOp61bQyxFc0RnshOxMTcoGeV7DyqeLquoc
         T70mYkY+RIoEnJpDrY68BXfs1opGDxeaRxlzfEJtl6gKLoy8ZBozZZondq4K6PrW3zKS
         z9eZXahWPNgbytkxmk4lJFwFM+yPVEM9qtbGFfeVJGpyRaN7ACdk6+0wedUgZRsojEx2
         j6DA==
X-Forwarded-Encrypted: i=1; AJvYcCX7dawCoSCOKuynxYA1zknmtcZYURyr7on6JoYaAF9eAMQvv0CvMkMTl9bWCGBot0ri8EwwKvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtkudv75ji6xG8cNvD36AUi6lF2GzsUmbguEzEcYUzZPjGasA
	t9NP3vQkZDDIlNds7ZoQ9uoRhe1hWNjxO6RDh10Xx+yzJTmjoSeUOJraA+M+S7ts
X-Gm-Gg: ASbGncvI1q/mua2CPjwrdvP+nJvOSBQahn6SSljSPBmkYCarolco9mLh+3/vJoy7Gxr
	8t/4eUfB9bXQPji/4asXyEPQzqbiivV4UDyU1XfJag7CVbamo30EPSa1PFfYqZbraI81rJUCpU/
	3cYkE7+lbU0AVxgPlc3O7Wq4Vvum6e/L3JNEsc3tdmDGpuLmONcv0LFjWPbrZlCTXatfhq39gBi
	9Seocbyfg2R4060sqDyjiYy3UrfNLoy81MH3NK+mUghoS+HconSscWtP9PQvrX8iirmGRfRu4TU
	czS/s7cS06xXc6nkLSyrSnRfcrl1RmO39OQL0MvCqSviRO8k5QuwKACG9VzikOPV5ptI3RoX2bF
	zsyN396BD+iSmqRDHEZXrBVLiIAR0bq3HPZXiWC56JGTYlwFwRtk53n4BdndO36xdiF38YQoawr
	d6KTKjEDZeKrNOIdRVM5zzxfF3b3pHIyibyzapsSraZ8Iu8zc=
X-Google-Smtp-Source: AGHT+IHM1NI9jlgl7YyHEw6xfZ2NvWKARzYo9jjqycdlEoc48MLVHrBBixAozXkHMEqVBYRHZIgJww==
X-Received: by 2002:a05:690c:9312:b0:785:eb11:647b with SMTP id 00721157ae682-78618357840mr4674427b3.33.1761586122152;
        Mon, 27 Oct 2025 10:28:42 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1a4391sm20417647b3.33.2025.10.27.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:28:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:28:40 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aP+ryNxS2A45WT7f@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-1-edeb179d6463@meta.com>
 <aP-hpxMgB5tN7KJ3@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hpxMgB5tN7KJ3@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:45:27PM +0000, Simon Horman wrote:
> >  log() {
> > -	local prefix="$1"
> > +	local redirect
> > +	local prefix
> >  
> > -	shift
> > -	local redirect=
> >  	if [[ ${VERBOSE} -eq 0 ]]; then
> >  		redirect=/dev/null
> >  	else
> >  		redirect=/dev/stdout
> >  	fi
> >  
> > +	prefix="${LOG_PREFIX:-}"
> > +
> >  	if [[ "$#" -eq 0 ]]; then
> > -		__log_stdin | tee -a "${LOG}" > ${redirect}
> > +		if [[ -n "${prefix}" ]]; then
> > +			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
> 
> FIWIIW, I would drop cat from this line.
> 

sgtm!

> > +		else
> > +			cat
> > +		fi
> >  	else
> > -		__log_args "$@" | tee -a "${LOG}" > ${redirect}
> > -	fi
> > -}
> > -
> > -log_setup() {
> > -	log "setup" "$@"
> > +		if [[ -n "${prefix}" ]]; then
> > +			echo "${prefix}: " "$@"
> > +		else
> > +			echo "$@"
> > +		fi
> > +	fi | tee -a "${LOG}" > ${redirect}
> >  }
> >  
> >  log_host() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:host" "$@"
> > +	LOG_PREFIX=host log $@
> 
> shellcheck suggests keeping the quoting of $@.
> This seems reasonable to me. Although in practice I don't think
> it will change the behaviour of this script.
> 

Ah right, makes sense to me.

> >  }
> >  log_host
> >  log_guest() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:guest" "$@"
> > +	LOG_PREFIX=guest log $@
> 
> shellcheck also points out that log_guest is never passed
> arguments, so $@ can be dropped. If you prefer to keep
> it then, as per log_host, it seems reasonable for it to be quoted.
> 

Quoting it sounds best to me, in keeping with log_host().


Thanks,
Bobby

