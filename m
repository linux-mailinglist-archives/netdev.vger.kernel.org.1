Return-Path: <netdev+bounces-145553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51399CFD1A
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 08:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D35287B28
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88E654765;
	Sat, 16 Nov 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IJc9CKqx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09F18FC86
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731743894; cv=none; b=N7E9lENY1s2lcq644J5wrk9gChcn8zSf1hf2yNsJbLqScnrS8+pnjNvXfkpEqwf6icy0PsFcn7a0Bb+h6X8PFweQq6yNaqeAxtHqzQi/SumaIaePhgcAgTp9N3uAQP6YNLCaYY3eNNPf5oukBwFk6AK17up/ucGOLuKK/nckiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731743894; c=relaxed/simple;
	bh=WBDVAdoHwfYrQuVAbgJ+ex4uYWPQ1hMBlrH8QxHygNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ4Jkvegc+1g+owCpEXjou/rCUsJw5SS9i0rpyTwqo2XL3qW+tHXUOzMN2HuA4gkW4hbB0PtSEYCxQID/eW1SIWF09mVZZindElhyx2yznYzOJ2PIqKtHBKaLFCAY/Mc+3T3YQJHmYekR4OyyJKdIpXVNcBDvuENl7R6f3k6W0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IJc9CKqx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314f38d274so5097175e9.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 23:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1731743890; x=1732348690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xaz3JG2gQQdrg04GxLvjUYpEC9sHE7VvBHr/vi0mAA=;
        b=IJc9CKqxoXVVbs/0K4dl1zDZ1rxhYcZirxCrs9zlayVUXaobeWYBgxhhBkktc/0T5F
         QU2z9nhJcYWpPh8MQCbcsd4q45HJgbQTURWqZmYpL8fWx91ccrf3D7lP1JA5mWzDnJza
         9O422oYrdRWqRa4eSoo9a8HWW5h9WPQbqSZKylWWohYw43XbK5BMkUmWvbtzi8ofDdeD
         7CZpIVOLb8ObZLd65twsX/QZd6QiCkj349flbmQa9EX95sAHiwYUjGHG05pt6+xWVK2s
         1mIH+89JW0mqn2Xo4kiAIRzM4Wa5YoquY6PNWvZrZVluxOeHmiG9S2b89nCaDyuFUZ/s
         mlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731743890; x=1732348690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xaz3JG2gQQdrg04GxLvjUYpEC9sHE7VvBHr/vi0mAA=;
        b=rSd9XaQc7sYV3YysDuqmWz2VHJzbHEA6Bh2k4q0YPCosTHQH8v7vO/Yi7VYVNTAf4r
         AKk/SXT/OvomTQDLhnFIG7a77KVikc6YcXlS4xnpPtC2SFq3B4WeNA8G8qUJnuRAdcCi
         5i3smLUIXX1/bCrwR7Gb22KSm28jrHRTeRwJNN7nxiOxu0D35mGBe4BO7kkw0CPHhK0X
         RMKFDBmoFMFWw4qP6yGMVf26J6lIOPawyD+rqMmBprpKCWj1PbXSY0ZIj7wKNVvU0Ub1
         HZbq7Y1nJ5tWg14Mwvtgw5eUM7euo6L7GCIcVBX1FWfORyC44f8KKghVL85b3c7OT0PP
         bdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG41KQ7yfSntBr3V3LRjeaQDOYJOsPhLoy3NHmgGpWm8PF8sdJMLSkUJmPzhnn0gIHAnuhbgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtoMgPMaVRNyGUfgVU2LoSoPCBQD4QFODneYTVy9klZo0wtyi
	SdXGLoUaepgnQbYGgN+QpL3vLPY/OP5gaAid+KKPOziN4ayuswf1F2wjhzuv9LE=
X-Google-Smtp-Source: AGHT+IHm97EKJ2KlifGaH5wV5M2bb/7vmN+ydN0LH33CUCn4C4y0ZLCEBpPdB4ntuSvD670VJtbcxA==
X-Received: by 2002:a05:600c:1387:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-432df742662mr52682805e9.11.1731743889853;
        Fri, 15 Nov 2024 23:58:09 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d4788c2asm83257185e9.0.2024.11.15.23.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 23:58:09 -0800 (PST)
Date: Sat, 16 Nov 2024 08:58:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] bash-completion: devlink: fix port param
 name show completion
Message-ID: <ZzhQjYrQmR5XHcLA@nanopsycho.orion>
References: <20241115055848.2979328-1-saeed@kernel.org>
 <ZzdFZ1C1te_eEQ5P@nanopsycho.orion>
 <ZzeWcUnoUGpIgNbk@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzeWcUnoUGpIgNbk@x130>

Fri, Nov 15, 2024 at 07:44:01PM CET, saeedm@nvidia.com wrote:
>On 15 Nov 13:58, Jiri Pirko wrote:
>> Fri, Nov 15, 2024 at 06:58:48AM CET, saeed@kernel.org wrote:
>> > From: Saeed Mahameed <saeedm@nvidia.com>
>> > 
>> > Port param names are found with "devlink port param show", and not
>> > "devlink param show", fix that.
>> > 
>> > Port dev name can be a netdev, so find the actual port dev before
>> > querying "devlink port params show | jq '... [$dev] ...'",
>> > since "devlink port params show" doesn't return the netdev name,
>> > but the actual port dev name.
>> > 
>> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> > ---
>> > bash-completion/devlink | 11 ++++++++++-
>> > 1 file changed, 10 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/bash-completion/devlink b/bash-completion/devlink
>> > index 52dc82b3..ac5ea62c 100644
>> > --- a/bash-completion/devlink
>> > +++ b/bash-completion/devlink
>> > @@ -43,6 +43,15 @@ _devlink_direct_complete()
>> >             value=$(devlink -j dev param show 2>/dev/null \
>> >                     | jq ".param[\"$dev\"][].name")
>> >             ;;
>> > +        port_param_name)
>> > +            dev=${words[4]}
>> > +            # dev could be a port or a netdev so find the port
>> > +            portdev=$(devlink -j port show dev $dev 2>/dev/null \
>> > +                    | jq '.port as $ports | $ports | keys[] as $keys | keys[0] ')
>> > +
>> > +            value=$(devlink -j port param show 2>/dev/null \
>> 
>> As you only care about params for specific port, you should pass it as
>> cmdline option here. And you can pass netdev directly, devlink knows how
>> to handle that. If I'm not missing anything in the code, should work
>> right now.
>> 
>
>Nope doesn't work:
>
>$ devlink -j port param show mlx5_1
>Parameter name expected.
>
>$ devlink -j port param show auxiliary/mlx5_core.eth.0/65535
>Parameter name expected.

Okay, so fix it :)


>
>> 
>> > +                    | jq ".param[$portdev][].name")
>> > +            ;;
>> >         port)
>> >             value=$(devlink -j port show 2>/dev/null \
>> >                     | jq '.port as $ports | $ports | keys[] as $key
>> > @@ -401,7 +410,7 @@ _devlink_port_param()
>> >             return
>> >             ;;
>> >         6)
>> > -            _devlink_direct_complete "param_name"
>> > +            _devlink_direct_complete "port_param_name"
>> >             return
>> >             ;;
>> >     esac
>> > --
>> > 2.47.0
>> > 

