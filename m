Return-Path: <netdev+bounces-74650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C807F86212B
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501111F256C2
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742EFECF;
	Sat, 24 Feb 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nwx3sIlT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED364D
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734410; cv=none; b=AVeHqIdAlys5giX7J9C0eZVkAqMUPJYLSKCUwe5NzpH9F/tHelMiHfWOnhYOU+SJHGC4FWSb9jEmwXuFtrWjG+4HA6W399XA41MpxoxnIn775Jt++DCopSnkJakeVe/0stF/j9f1Kvn6lYGyw691+Dws5ZhbGBlVm05b5XD7N6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734410; c=relaxed/simple;
	bh=89gfB0d+BJREK94VWt9BdGlk8fqarMCLKkJpNTQiYVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX+cPvEAMAfxm42N+ZGxVakl6TNDlM3/LezC6ATUBuTctrzGRv3TMUyLON9qHHPAmyiAl18RyfHYm6qWHPjKT1Tbxs5taASfPAeTWH85Txdgl+hqBc8DbjOhqkmatu8CMN5KbNoP9s5wpz0b56rrECH31xMbB9cwoDamxazodew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nwx3sIlT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so709054a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708734408; x=1709339208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6k+51jbRVVMRx/YTEEUvH1e+s7J14iTbluUWT/oq6hw=;
        b=nwx3sIlTXije6cmCHkgws1LzyToQrGylwTwiQnj9UHnl33EYRYKAGA6IP9Wl22TTyn
         cS+m+ChFkyfRM0M4b0AUV0fcr0Pzl7DK6ZYtBlX55AyVAdDJ3e7epGRLdk7VTb2mtme1
         oltKUbUEfQmejwko6zNc4AujJB2FmTWag0g0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708734408; x=1709339208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k+51jbRVVMRx/YTEEUvH1e+s7J14iTbluUWT/oq6hw=;
        b=XhBylCgmbJTp6tO6l6wrRUT/7kw5isdMKiw95MvucMKOF3oj9/83zUed+HrpF4P70V
         vyGz//BfKjWg5GodDjpCL0bb/4qhSBgg23vD5wT+LOBgPP3TsqouO5GWh7KXMPf5ub6R
         5RTeLj7HtCm0rf9LkHoaj6sLNn1FeIxZ+PXEf17Pha6nnXbRQvSko7MRdjfRJy97kXe6
         pKLgJgOTmACrXbHuzkhkettYxAnSpzoo0hUWQGFSi7c9bbPtcLRkE9c5qOn5mM+T2v+4
         wGX8DA00qduQ7+5k8XnGcHu/mpK8mY1Eo7qtDLGBCkl/ApOX1hQc8M7WytkC3sIDHjKV
         IFyA==
X-Forwarded-Encrypted: i=1; AJvYcCX/DlzzolIRq6Xx68oluYVMmIIrE6lGc1CmIoWKNjgFiUNsIP4rjR45zpRFo55bp7p2wA1rS4Jku3LNNhx9KQa7OvMSmzpo
X-Gm-Message-State: AOJu0YxucsgTcSh4nYiu25ZnNppFxx2t+6rLHbSCirkN9P7XgpHJUyIY
	TOR/THgFFOMhK9CEjiEN7Fsa7ChDm6uhwWu9AV+wBVZArSmk031wUdjpLrdZUQ==
X-Google-Smtp-Source: AGHT+IHqqByA9RSEB3GXMAbMamhab9AoXKYL3v8UVitxmQZRj5Za8VGsJ6Bh42u273xtu3ctiuMp7w==
X-Received: by 2002:a17:90b:358b:b0:299:544c:4933 with SMTP id mm11-20020a17090b358b00b00299544c4933mr1481060pjb.14.1708734408218;
        Fri, 23 Feb 2024 16:26:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a640800b00298975077d0sm2070777pjj.19.2024.02.23.16.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:26:47 -0800 (PST)
Date: Fri, 23 Feb 2024 16:26:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH 5/7] scsi: devinfo: replace strncpy and manual pad
Message-ID: <202402231625.0192BA6F@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-5-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-5-9cd3882f0700@google.com>

On Fri, Feb 23, 2024 at 10:23:10PM +0000, Justin Stitt wrote:
> Depending on the state of @compatible, we are going to do different
> things with our @to buffer.
> 
> When @compatible is true we want a NUL-term'd and NUL-padded destination
> buffer. Conversely, if @compatible is false we just want a space-padded
> destination buffer (no NUL-term required).
> 
> As per:
> /**
>  * scsi_dev_info_list_add_keyed - add one dev_info list entry.
>  * @compatible: if true, null terminate short strings.  Otherwise space pad.
> ...
> 
> Note that we can't easily use `strtomem_pad` here as the size of the @to
> buffer is unknown to the compiler due to indirection layers.
> 
> Now, the intent of the code is more clear (I probably didn't even need
> to add a comment -- that's how clear it is).
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/scsi/scsi_devinfo.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index 3fcaf10a9dfe..2d3dbce25629 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -293,14 +293,16 @@ static void scsi_strcpy_devinfo(char *name, char *to, size_t to_length,
>  	size_t from_length;
>  
>  	from_length = strlen(from);
> -	/* This zero-pads the destination */
> -	strncpy(to, from, to_length);

A rare case of the padding intent being expressed! :)

> -	if (from_length < to_length && !compatible) {
> -		/*
> -		 * space pad the string if it is short.
> -		 */
> -		memset(&to[from_length], ' ', to_length - from_length);
> -	}
> +
> +	/*
> +	 * null pad and null terminate if compatible
> +	 * otherwise space pad
> +	 */
> +	if (compatible)
> +		strscpy_pad(to, from, to_length);
> +	else
> +		memcpy_and_pad(to, to_length, from, from_length, ' ');

Yeah, this is much nicer to read.

Reviewed-by: Kees Cook <keescook@chromium.org>

(Some day I want to rename "memcpy_and_pad" ... the "and" seems
verbose...)

-- 
Kees Cook

