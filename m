Return-Path: <netdev+bounces-236840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E1C409BA
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF401A445E9
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9B329C58;
	Fri,  7 Nov 2025 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBjXHOYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DA329C4C
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529714; cv=none; b=l50uzZ5NWukRArgxjDkllOYcQEgcfjrfRR358epmqRujcISCffxE1GGlhkDXwJfYcci2KGPSZVBBPM/pa5ZC2Xe+v6G7tpJuSQAWk8RN5i58Tz32Br6aKmk4EUYkghh7l9M9XmmZHVr9aIHyS9ipZzAV+mVjkWlGpHQMoGrTHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529714; c=relaxed/simple;
	bh=7m90U4fRlmTtbaduAz/n40bucosBtxg2Nlzb525AIWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aySE8UQABkqY8Re4WtmwwXc28Sava8dq0m0dl8bRYmTOq/E2NBu4BK47oOgzqmXzohN9te8Yl01lMmEX22pX7zOFCqNMAmC2NDWPxK55Eu7OpNi6q/gIOUW7vvPgh/eJ09mG47Qj9oD/4vvTKofCwJ9gaqN5Xr7NxwEphaR7Aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBjXHOYy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-786572c14e3so8896217b3.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529711; x=1763134511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=CBjXHOYykeExWbAdUzaTfxbv+hYeDnJ4OE6LMEsIQ+j1HllMQbTwIrF1ZEDn7jXbaG
         lDM2Uj71u4sDtbD+vGnxUFHY34GPfx3h1iW1JsUxF8CYD3oxAyQxZbZplmBquMOloTwP
         oRPywO8QmaIR6yh3L4Hcuck/OkBnD05U+hfOWzV/GEhqkGUyL0NYgE2trQfhP5MA7DoZ
         LQpahZrpYOlvRREH+zpYiz2WBgdGz4j+YhGxFHwBjcPyqqb7GU/IMiM7XEpmL1F9pPbk
         H1bgVT9cQsFpWEguqlEo19mGxZbreY0161jBsEn/zIuo0yFqfn26o9DZH7p0Aat4utdn
         RyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529711; x=1763134511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=SeETxFvUxc75iFEGIIh9hw7sVikDTfAHvDBrU9EALwt9wx1hIUgAdUDGbysdhZbw0v
         H2iJVs9K21JBs5Hb+drIAsSPcE21FKa6PwR9LInf36G/t6ZOjEjZQEy17rS2G0CY0pWD
         gzKTfljVLgxVKFHTCmfUqIAz1mHtmMJCDKtUzaC7+0KZBicv+5OZlySQEbbTZP9qg8B5
         1vxT3ZGDly3xrkY1CUMQXXaAWBvqu35i30cz+TWunvHtN80tQsog93Nvd+UB6GKp4EPT
         789DAxcfASDgo3JJwprlxC/L4J8MdMXG7XaI+nzw3mpw/vNsQ6CmWP2MjvNPA8ZkzoNE
         D3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqONXlFRQuhXMWk1otATrUQcwQcxD68Mr0Xkc9A47SplqZ+067uzTKtadNMlkxW9cKjx11OTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1IAkWpaHq3y1W6tZC2Xl7EPOEuLBDrnnGELsh4bb48DAEXWuh
	TwWpvVIEcU7x+EB0noV8zpqxoNf2Vv8uyx4mDoZSSDwLWxRfeRKb096j
X-Gm-Gg: ASbGncuyGv65cjQosDk9Rzzh6vuu+a6SO7FKa4rZ/2QrwHk1iZeCDEJa3C4mN6QMP85
	nnQzLA99WN2HvMYv72RmFX9Son3l5/VoCMLCJlrHBon8NpFHJ7Rg0FQx6BTOFhPrXysG2uhrUgH
	cR9H8Jo/eshrUwOYM66HV3DSqs9fi8PGFyj4oTugbsFH4FA3IZd8nVZgXorMr/aZd4D08k21E8c
	i4bo4steAlpAo/MdHqCZc9fUWQx6hXo2FIPUZbVQxPghuO1x1GuEUDBQgy8I4bVZ9o2ej3MfdEr
	rW9etnWgx4BgZSZGK8qdkzc7zH32CLXVdyViokpQcdqcHk6IdNw0aPYxJFH+cpr6GvxjN03aj6M
	mFKr4oB+CAZ8aiI81hhWnIckRSAlSiTJrXs+1G2nVvFffiYQga3p5olAAFZZwdvZHbGOcOVxyAK
	o/OqiYLarcIEAbRszrpuCaxRbT6YZrJHiQYTYY
X-Google-Smtp-Source: AGHT+IFwUXomSgFrXOP5T+Zd2zXzyVOrxyGJXDnXPE08lhO8nln1/YwLRBm5iwzEweMUqR/HaaHj6g==
X-Received: by 2002:a05:690c:360e:b0:786:a984:c064 with SMTP id 00721157ae682-787c53f0603mr27190947b3.35.1762529711161;
        Fri, 07 Nov 2025 07:35:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787cb4db618sm4770327b3.32.2025.11.07.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:35:10 -0800 (PST)
Date: Fri, 7 Nov 2025 07:35:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 04/11] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQ4RrcB0tzMWch1S@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-4-519372e8a07b@meta.com>
 <aQ4LaUi9wTnEN8KA@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4LaUi9wTnEN8KA@horms.kernel.org>

On Fri, Nov 07, 2025 at 03:08:25PM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:48PM -0800, Bobby Eshleman wrote:
> 
> ...
> 
> > @@ -90,15 +85,19 @@ vm_ssh() {
> >  }
> >  
> >  cleanup() {
> > -	if [[ -s "${QEMU_PIDFILE}" ]]; then
> > -		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
> > -	fi
> > +	local pidfile
> >  
> > -	# If failure occurred during or before qemu start up, then we need
> > -	# to clean this up ourselves.
> > -	if [[ -e "${QEMU_PIDFILE}" ]]; then
> > -		rm "${QEMU_PIDFILE}"
> > -	fi
> > +	for pidfile in "${PIDFILES[@]}"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		# If failure occurred during or before qemu start up, then we need
> > +		# to clean this up ourselves.
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm "${pidfile}"
> > +		fi
> > +	done
> >  }
> 
> Hi Bobby,
> 
> This is completely untested, but it looks to me
> like cleanup() could be implemented more succinctly like this.
> 
> cleanup() {
> 	terminate_pidfiles "${PIDFILES[@]}"
> }
> 

Oh right! I reverted the deletion and completely forgot about
terminate_pidfiles().

> >  
> >  check_args() {
> > @@ -188,10 +187,35 @@ handle_build() {
> >  	popd &>/dev/null
> >  }
> >  
> > +create_pidfile() {
> > +	local pidfile
> > +
> > +	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
> > +	PIDFILES+=("${pidfile}")
> > +
> > +	echo "${pidfile}"
> > +}
> > +
> > +terminate_pidfiles() {
> > +	local pidfile
> > +
> > +	for pidfile in "$@"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm -f "${pidfile}"
> > +		fi
> > +	done
> 
> I think it would be useful to remove $pidfile from $PIDFILES.
> This might be easier to implement if PIDFILES was an associative array.
> 

Using an associative makes sense, this way we can trim the set.

> > +}
> > +
> 
> ...
> 
> > @@ -498,7 +529,8 @@ handle_build
> >  echo "1..${#ARGS[@]}"
> >  
> >  log_host "Booting up VM"
> > -vm_start
> > +pidfile="$(create_pidfile)"
> > +vm_start "${pidfile}"
> >  vm_wait_for_ssh
> >  log_host "VM booted up"
> >  
> 
> > @@ -522,6 +554,8 @@ for arg in "${ARGS[@]}"; do
> >  	cnt_total=$(( cnt_total + 1 ))
> >  done
> >  
> > +terminate_pidfiles "${pidfile}"
> 
> I am assuming that there will be more calls to terminate_pidfiles
> in subsequent patch-sets.
> 
> Else I think terminate_pidfiles can be removed
> and instead we can rely on cleanup().
> 

Indeed, later patches will use terminate_pidfiles() in between spin up /
shut down of multiple VMs.


Thanks again, will incorporate your feedback in the next!

Best,
Bobby

