Return-Path: <netdev+bounces-147321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD959D9112
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 05:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3650BB2149E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 04:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB084D0E;
	Tue, 26 Nov 2024 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un4nGw2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C791B67A;
	Tue, 26 Nov 2024 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595990; cv=none; b=H49DUdIBPyLEPZe61SxcqCShQ76zr6ls33f5tgVdnVBnFWw8lGz804PFDleYAOx031gN9nTPfAiF9OiLHxQwLy8yF3eSEQI8lp6hXovMce7zDNvSgi6MiDAqE3kr+Z24kPM5PtxczROUmJl1j0DKPrEeHO06+1U+uBmA77Hn0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595990; c=relaxed/simple;
	bh=IyglBLr92LzElKGe/wofQObJMo4mG/29tzaXmIAEd6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnfi91WcLBgvzHz8/c0lhD3pVVDzmWeu2TvATe95yJMoyS5FXjcJRM4PzK6akcoJ793XVz83F50kp2an2hAAbePd4BQsH30UjvHjEClbN+IRR1k7+2AM/eckwfokc2bceYskAGIYsa5YtCj5j2EOEbRg/u9g1/glsqLM3fFKPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un4nGw2U; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f1dbf0d060so852921eaf.1;
        Mon, 25 Nov 2024 20:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732595988; x=1733200788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHWS282O1WI6oGbJviU7SYWgq+ifBwCWP8rd7/Rjnp0=;
        b=Un4nGw2U0MFxUIohMCpznI+C8x41/TodzFkfqttNfm3rIcQvcDHQZSk2G23cijb0CV
         Jhr24nRzU5DJZimGzKTy6i7agesoFKm5HRtc7dK0HuDliZ1rGAQIlJGKJMCegxPS5vkH
         ebshfZbETianqU4dMqKNh6obW0McB9xz12qoBmNSrCq8z6K6SQQJrWx6b9e7EIxph5KM
         xV1P/rVGauyas29c+R+MhaYvwv2UjUBkTDJ2ewxV2R7hAxCYqFWsGVLk2XYY8LyaQQac
         0O1OgTxJWhp4ZxCAOWNDhq7Q+jc2c0kI7gLvYp9zUxOydK7xdZJas6ITLy1dgrSHbwsQ
         9V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732595988; x=1733200788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHWS282O1WI6oGbJviU7SYWgq+ifBwCWP8rd7/Rjnp0=;
        b=U9v1CtIhopeYzxQfjFjY3+4E3+g35bqQSPoV5HVkXkpc0aIriw0J5Zb2fwWPifHVHt
         BGJ5qSFXFnmRkZvXqqxvzoek1G2sd6Wyrub/P0BdsXrVmjdcf9zqJdSwsyLTQbZfVhMu
         kSN3IVl9r7ng+Fg+SvbLgm21dS8KgDOxhnRS603pLAwuGhNoPWWWYipb+4s6eEUxyOGw
         Dy7F8oQCAJc9bziVc3I6XnWDGO8SCa6yidNaqkBM5CUtVvZg1YX6PSAOzVPgACqMQqfw
         ejb89U9YYRUxA/8gljojrGvkxGTcqfBgNsstFnTkqP15QYQmfZ4iPLPjfsd2XsjmmOjP
         ELgw==
X-Forwarded-Encrypted: i=1; AJvYcCX/4OmDV8jUDfGjX37PBmBUObKZTZ9oADQsBVzt9KszaApXoVtIgd3TGbHnUzY++2S/xiqbhaeJTEE0j3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvaaOnvqASnma6PXvD+VYVkNy6Qwf630cF8Jgvr0Bgl8icR3UF
	isMkLsQ93MoC80ooLm4zRza6c8UsuA5Wd36u9gc+2XPK2xNogBAE
X-Gm-Gg: ASbGncsVlaUF/lbkQ1cK13NTA5k0Xt6c4f9k1OhyyLklYpRSesPawUkRuJ1jTLAYk/M
	v+uu0x1TrkDxxbqmeIQM2ppDdscYCbfHngcMPPwK+SjqddMJnmaL7JfcJzlvF+fTlSICu4OptR0
	/4vmOsdpur7Mdnhe+PmIVmHX+CvmKjoAfiVMEIsM9NRc7Z9pjzuH4+zOiIvwrt8sN24cU82ZjAW
	AqOFEYvJR4xTqY6IJVkSNyavG9nXgCp294cTWpBzanNJqlvEamqxEwGCURSl4bigAHq63hOtHDh
	hD0EBOQVMR2DPFQcL7+yAss//OoUFiF5CpWJbpT9
X-Google-Smtp-Source: AGHT+IEJzacFicm5maGwBtICMcvpDwiu2y1vNQKKYUy+2tPB01Fe4AgneOA02iX3OckJIZuHoBhs5g==
X-Received: by 2002:a05:6871:3312:b0:270:4d48:6be2 with SMTP id 586e51a60fabf-29720dcd8ddmr15701868fac.26.1732595988513;
        Mon, 25 Nov 2024 20:39:48 -0800 (PST)
Received: from hoboy.vegasvil.org (108-78-253-96.lightspeed.sntcca.sbcglobal.net. [108.78.253.96])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d56e5ecsm3727060fac.7.2024.11.25.20.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:39:47 -0800 (PST)
Date: Mon, 25 Nov 2024 20:39:45 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	nick.shi@broadcom.com, alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH]  ptp: Add error handling for adjfine callback in
 ptp_clock_adjtime
Message-ID: <Z0VREVDLnYhIy0UH@hoboy.vegasvil.org>
References: <20241125105954.1509971-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125105954.1509971-1-ajay.kaher@broadcom.com>

On Mon, Nov 25, 2024 at 10:59:54AM +0000, Ajay Kaher wrote:
> ptp_clock_adjtime sets ptp->dialed_frequency even when adjfine
> callback returns an error. This causes subsequent reads to return
> an incorrect value.
> 
> Fix this by adding error check before ptp->dialed_frequency is set.
> 
> Fixes: 39a8cbd9ca05 ("ptp: remember the adjusted frequency")
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

