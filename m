Return-Path: <netdev+bounces-146306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 572389D2C49
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C1B33E02
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866B1D6DA3;
	Tue, 19 Nov 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="g2GzuZzW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950791DB375
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034754; cv=none; b=MebHCtbZZQ5MqPVplaPxRBXKDh9PgxKjVdCUxw2UZBj78oaFihaOKXKNOONwPHV2qkRf8kDFtx4/CK/gzeEEiEo7Ijrqn8J+dROwb3AzLCdiA85nYoDvruog5uSIBK5QabHRNLM2964SrS7L/siWAq9OM4yR6ZInTTSv6vJSDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034754; c=relaxed/simple;
	bh=1gUMsbry1kZAFsCVMvOf2qkuZvcS20EhOXJvdZD/54U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzhzbJkBD/unjTQJYHo/7txrTGKim4dUJG644hiqU05HR2wK3/T6Z6MNSpjpukYQMs+Ep0280qyVJGE2HvDpnLwBFMNeTyhS4MvzLlGzDhXR5HkZOj8MqDKZZPblCGO/FjKZFOeM3VGt8Oa/HnjbRMn3AL56ja7ICiIZhhV3ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=g2GzuZzW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21260209c68so4146395ad.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1732034752; x=1732639552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+w35H5WeqvGPlEcskjNWeC4Y1SWKF0Hufj6v/wv/Gq0=;
        b=g2GzuZzWPQRHCZPzfafBaY6R8xSw7+qmwsh84Z4xwgde2SBUsn+10505Ue8oFyz2Kj
         s1q5HVeN4JUSUlu2TJw2LEu56xdvULwIm3aobIHonBU3ZDSnmDR3Jzx6+Syc7orEjV5n
         AzNoAIzb86zGQLvdGacDOih6bUINL/8BsWPyfUW+OMJwkxCJXReQ+oIlAxmFQtH0q9Hb
         SOAmhfH6OBqoUnGaTNcpAx8gdPac9ybvGVE5chFToFqg7gRKlI5ysLP3qlwfZC8wOTIA
         SSYpvJ1ic/v/AzE5n+nO5ISkG9p+L6hSA+yy5xsFcREV6GSgQ4CUux8yF+g7V6TMYHUl
         yp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034752; x=1732639552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w35H5WeqvGPlEcskjNWeC4Y1SWKF0Hufj6v/wv/Gq0=;
        b=V6j3fgkz9RLPvklGZHJJvUvpoqnJMRZvH2fBY+XgIDv+j8ZfPYQA7u3M8SkqceaBwc
         eV+Gtny83kzaAJdnXb8GO492Qe9jc2JYM29IiStCe8fxwj+Ql/fRO07lyDuHS1gjC7Xr
         uVLdogBIk4c2panw2olLw47U7Au6HwelQdRuoWnE1Lz/jLPCrhVps7aC2M/5RNa4B04R
         OlgMBQDQBbnwm//6SLlNmkpn2NVVKUHSEyU66FsJ4a60QBkLuVD+8I7V1u7a+6tGawRQ
         q5H51COF1LT96pbMFCizkl59ZrJpq1bTKt646zf9J952SU+u5h+wLDFqkfJ8JTzzrl1I
         68oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5NuOyhuVM2yWRnNfC8qJ/2ouL7KYO/ulEk3k2AYusLQ7xiK8Wk2hpP3oT1z6cGOAeIBmjfOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwfek/vUeme8mwh4cchLHl6Rka3P8H1lQfXnUSh1xNXkq8hv02
	zfSFkGe9Qc9OSWoAWLQ8bGuSh7+mdqF0CVGDrFhTKlSxGN74atMQD5uSqIOC3vo=
X-Google-Smtp-Source: AGHT+IG42IeHRA5wWx6fkDvksPhwPIGHRuvXP/XgORmQ7kyNls+dTBoU/UcMlg0AfPXWSAXf8J9o2A==
X-Received: by 2002:a17:902:f690:b0:211:6e93:9e5f with SMTP id d9443c01a7336-2124d0c8c9dmr59643615ad.22.1732034750220;
        Tue, 19 Nov 2024 08:45:50 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21243eb11c2sm23961725ad.276.2024.11.19.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:45:49 -0800 (PST)
Date: Tue, 19 Nov 2024 08:45:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Saeed Mahameed <saeed@kernel.org>,
 David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] bash-completion: devlink: fix port param
 name show completion
Message-ID: <20241119084547.4285a0dd@hermes.local>
In-Reply-To: <ZzhQjYrQmR5XHcLA@nanopsycho.orion>
References: <20241115055848.2979328-1-saeed@kernel.org>
	<ZzdFZ1C1te_eEQ5P@nanopsycho.orion>
	<ZzeWcUnoUGpIgNbk@x130>
	<ZzhQjYrQmR5XHcLA@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 08:58:05 +0100
Jiri Pirko <jiri@resnulli.us> wrote:

> Fri, Nov 15, 2024 at 07:44:01PM CET, saeedm@nvidia.com wrote:
> >On 15 Nov 13:58, Jiri Pirko wrote:  
> >> Fri, Nov 15, 2024 at 06:58:48AM CET, saeed@kernel.org wrote:  
> >> > From: Saeed Mahameed <saeedm@nvidia.com>
> >> > 
> >> > Port param names are found with "devlink port param show", and not
> >> > "devlink param show", fix that.
> >> > 
> >> > Port dev name can be a netdev, so find the actual port dev before
> >> > querying "devlink port params show | jq '... [$dev] ...'",
> >> > since "devlink port params show" doesn't return the netdev name,
> >> > but the actual port dev name.
> >> > 
> >> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> >> > ---
> >> > bash-completion/devlink | 11 ++++++++++-
> >> > 1 file changed, 10 insertions(+), 1 deletion(-)
> >> > 
> >> > diff --git a/bash-completion/devlink b/bash-completion/devlink
> >> > index 52dc82b3..ac5ea62c 100644
> >> > --- a/bash-completion/devlink
> >> > +++ b/bash-completion/devlink
> >> > @@ -43,6 +43,15 @@ _devlink_direct_complete()
> >> >             value=$(devlink -j dev param show 2>/dev/null \
> >> >                     | jq ".param[\"$dev\"][].name")
> >> >             ;;
> >> > +        port_param_name)
> >> > +            dev=${words[4]}
> >> > +            # dev could be a port or a netdev so find the port
> >> > +            portdev=$(devlink -j port show dev $dev 2>/dev/null \
> >> > +                    | jq '.port as $ports | $ports | keys[] as $keys | keys[0] ')
> >> > +
> >> > +            value=$(devlink -j port param show 2>/dev/null \  
> >> 
> >> As you only care about params for specific port, you should pass it as
> >> cmdline option here. And you can pass netdev directly, devlink knows how
> >> to handle that. If I'm not missing anything in the code, should work
> >> right now.
> >>   
> >
> >Nope doesn't work:
> >
> >$ devlink -j port param show mlx5_1
> >Parameter name expected.
> >
> >$ devlink -j port param show auxiliary/mlx5_core.eth.0/65535
> >Parameter name expected.  
> 
> Okay, so fix it :)

Holding off on applying this until some conclusion is reached.

