Return-Path: <netdev+bounces-175796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E5BA677B6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7804C16F07E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68FF20E6E4;
	Tue, 18 Mar 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WCFa6GzS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7E42AA1
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311580; cv=none; b=hEa3r+xiZiHIs6ohdevHRF647VrcjjEe4E8vAQYoIWTaCP2oPINxp4xGom2BPJlB24qNR9BV6YXvYP2lbqD6nG1DvTGeAwt37ZXp783mnnGAryqaQDRoF4eV4jf4d3JizYrmpzx9kuEkFZt9yV/LJ2v/8VXGs1kFtAUAzeXYvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311580; c=relaxed/simple;
	bh=Xino3bip7/39Mo21Qt2agVQ6aBgyHhTW8dhnz2VwC8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkHoL4biH5zYeDyWBuSKPC9yYFVq/aUe2/DxYTRYWey1Ed7h4g3I7EyXRU1DkAol88BzE8XSWf0Fqd36yLptMEOUBYcSS/CXqGGGL1dqBUsND0k+pSDBt6xHcC24eh1v+jN5XRSe9xJAX9RukPzmMB3/Gh5v46XgfH4TMezq4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WCFa6GzS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so23813265e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742311576; x=1742916376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKabdXYryvecCMCJuTILRmeVZYwFv5r99wEjpGSayRA=;
        b=WCFa6GzSFqpUx9CGe2CYuWOdBYNSAxJh7fxO7S5A0KcLC3PRhEGa+m95hmeGu+3PJ9
         nOG7r36uIZXF0krPeOfHdwAjhWidyeBpmerKOHfMlDgMJ6fSehQTmANoFIGZIrG1TLMp
         R21U3A/rzgoXES6SmhyqxlNHdRv+CjZHXrL3JULpz02TMOywI1i3Zj1RMzP2zrj0Yrjq
         zjRcpRoYNjmRhveVRPtcKYf2hZ2kX6U3TYfWkjfl10fA3xvS31EcXVvuhcFGZzChKJTS
         a9MDjeij1fcQzsgCHpE35dCQLgZjajTnKmri9Z+Y+MUNHKyCqpFVeH5JKD5ZMFmeCMj3
         8miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311576; x=1742916376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKabdXYryvecCMCJuTILRmeVZYwFv5r99wEjpGSayRA=;
        b=X/TOhCkzBq/0MAHXW6bBxFzYOnp0VyxTfk50spOaMoaH7n/Em8BE69Ii1X5dRQBYST
         OFTWBo9vb7A/UvoTdJv91nsG9ZFy6s3nAv5pSYxXjCBeaU5UEIvlemMLnOw37/Uigs+P
         lGJMKgntV109WgCmntbWtkTx+hhdDEmw5p8QCHoeYR3EY43+VIrJotWQOehJsGqfUNj3
         Me1V+H/UzqofY78KCr/oEUkghrYf8Blu+0jDyJvOpmk9L+IZCJllNTEesmuZ0xcY0Hxq
         7T5sPFp84oP3U/OgATe4UUk+oCBXr4VNmN7QRA1XhcqQH/l6IkdcS8fcYNvalRWv0/Mr
         19WA==
X-Gm-Message-State: AOJu0YzFVgSj2GZyTOAvQULjOz9p3s0aARiWP3xu5/LpJTKhaPX3FCXJ
	PdR/eHDo2VH3XFhfRmw3SnDaRHIZV4CzydDZt3MN30PaF4/o7iFwSZT/D+VBNfc=
X-Gm-Gg: ASbGnctQZTCBIm7Lze7rY+JWt7I0lQxgN74D6a3wPQ8kv5jj0NkH3zQjH302X7au1ef
	YT35/1Lv9ebv3xdV9/N2hCAPc5dNe9fA2FF3LcG/ToZlSeWL9to6u3uVWbEib3/XnuB7XwZ6Id5
	ihNhl7ajga5S1vEhOeCa/gxuI7tc1LISz0g3jpTSboT14c8iI8cM7LeF/KmuI7nT7jh4TtW/Lbx
	XeuRyORZH0Fq6ZqttEVvB1HgoGxPcTp5Nw/3NT6fMzOoqV4Jccs9LhEdZ0IWYDldmK5LktxJ+c/
	aemAGVtoMmY2bWbgeX161ixDljFpShfV3iIbehbT2atvXlZSA8t//I5NJZlm92hCfxUm23dSdT1
	FHkQ92TVL/e8=
X-Google-Smtp-Source: AGHT+IFIyMN15Zxwmf3HUEzuEzsz4vayH76978RVYh2LcH12ZLZjRDya1gYN1C8rHeueyC6mfZtI4Q==
X-Received: by 2002:a05:600c:5246:b0:43b:c878:144c with SMTP id 5b1f17b1804b1-43d3b98e5c8mr31013285e9.12.1742311576032;
        Tue, 18 Mar 2025 08:26:16 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb627csm137803165e9.5.2025.03.18.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:26:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:26:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, andrew+netdev@lunn.ch, dakr@kernel.org, rafael@kernel.org, 
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, cratiu@nvidia.com, 
	jacob.e.keller@intel.com, konrad.knitter@intel.com, cjubran@nvidia.com
Subject: Re: [PATCH net-next RFC 1/3] faux: extend the creation function for
 module namespace
Message-ID: <6exs3p35dz6e5mydwvchw67gymewpzp5qyikftl2mvdvhp3hqf@saz6uetgya3l>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
 <2025031848-atrocious-defy-d7f8@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031848-atrocious-defy-d7f8@gregkh>

Tue, Mar 18, 2025 at 03:36:34PM +0100, gregkh@linuxfoundation.org wrote:
>On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> It is hard for the faux user to avoid potential name conflicts, as it is
>> only in control of faux devices it creates. Therefore extend the faux
>> device creation function by module parameter, embed the module name into
>> the device name in format "modulename_permodulename" and allow module to
>> control it's namespace.
>
>Do you have an example of how this will change the current names we have
>in the system to this new way?  What is going to break if those names
>change?

I was under impression, that since there are no in-tree users of faux
yet (at least I don't see them in net-next tree), there is no breakage.

>
>I say this as the perf devices seem to have "issues" with their names
>and locations in sysfs as userspace tools use them today, and in a
>straight port to faux it is ok, but if the device name changes, that is
>going to have problems.

Got it. I didn't consider that.


>
>Why can't you handle this "namespace" issue yourself in the caller to
>the api?  Why must the faux code handle it for you?  We don't do this
>for platform devices, why is this any different?

Well, I wanted to avoid alloc&printf names in driver, since
dev_set_name() accepts vararg and faux_device_create()/faux_device_create_with_groups()
don't.

Perhaps "const char *name" could be formatted as well for
faux_device_create()/faux_device_create_with_groups(). My laziness
wanted to avoid that :) Would that make sense to you?

>
>thanks,
>
>greg k-h

