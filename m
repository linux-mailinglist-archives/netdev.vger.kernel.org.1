Return-Path: <netdev+bounces-55546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E580B39E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7BBB20A9A
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6DB11CBD;
	Sat,  9 Dec 2023 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aq5NcKj0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DAB10E0
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:36:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso3832845a12.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702118193; x=1702722993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45vtNh/FlxZbIOMitUwK/BeQ6VUKREjgXSBZIEcvvYQ=;
        b=aq5NcKj0KEZgyrkAerO9mFpYuuEEv7r9e08e1ZCSuVn/0btHWAbiP52Gnu5zAPJ7JS
         /cPIePBxcphz4+TPgytqgMkPRcoY5gAUG2A4R1OBZR7B0R5/5KHU8GyBkMEhU35B7TZH
         iQqiunuyF4TYN8eUec1u0ZSn0QV1nQFS8ovFULqxRf6aH16A/ucAPyAz0A5wPRViUVOo
         8HaOKKhVrpfm23pCfRDj1X/udor0c+2aAOyDsFmiAetPQ2/nenRJBD5UexEa5tROgCs9
         PuarXfeuut+y8SDIg8V577Aj1jgq4nqnmdmmJ6oEYCxfYD6UxqPyUUEYzAu9cb9yc0Me
         xtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118193; x=1702722993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45vtNh/FlxZbIOMitUwK/BeQ6VUKREjgXSBZIEcvvYQ=;
        b=BD/ajqzLPyz13mVPV+aJyamnYeUdnNL3TuKkXN+MBsIXnJaJePY/XW+WU5rNIQGQIJ
         T+/OLI6TEpjWQDtMD0/0ccsuwKXDa0gxC5umgXSZDRRW44+5Md9xydf3QJMJCI9OOPso
         OoF4nJJgrmfmD3b4eddyJ9Vpt+RTXkkx/XquEMXFqtXC2Tp4o4M1QGofmGuWhJh/UcJX
         LAjAWKBuBdxLiNO88++5nXRV4CGOiipEMNbbWx9ewWn0lmgYZm7rL27Xh2ubqseeR9LQ
         zOt5UB6Cvzui8UrNj2OTsrzkIOHzwD1IlswfQWcEwYohRRLyWqUWr4NjOaM0QjoraQVd
         ro+Q==
X-Gm-Message-State: AOJu0Yx/fPkeAk8axTYshi9iudlDeP9RppE4D3M6bEC89xFM4Qr56goz
	iPyccG1mkQ52obE/OIKmGykjmw==
X-Google-Smtp-Source: AGHT+IGw4UxnB449qBQnJvccyVpx+a5nyzLFlKlu6XVSbBA8fTbJv2F0kal1I7Xc+gKxposkOdz5nA==
X-Received: by 2002:a50:8581:0:b0:54d:1264:b28d with SMTP id a1-20020a508581000000b0054d1264b28dmr890480edh.61.1702118193435;
        Sat, 09 Dec 2023 02:36:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 27-20020a50875b000000b0054cac2a0715sm1622632edv.93.2023.12.09.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:36:32 -0800 (PST)
Date: Sat, 9 Dec 2023 11:36:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v5 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZXRDL/0fq77FX/0o@nanopsycho>
References: <20231206182120.957225-1-jiri@resnulli.us>
 <20231206182120.957225-6-jiri@resnulli.us>
 <20231207185526.5e59ab53@kernel.org>
 <ZXMmgJHPdBUFlROg@nanopsycho>
 <20231208081123.448e4c5b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208081123.448e4c5b@kernel.org>

Fri, Dec 08, 2023 at 05:11:23PM CET, kuba@kernel.org wrote:
>On Fri, 8 Dec 2023 15:21:52 +0100 Jiri Pirko wrote:
>> >> +static struct genl_sk_priv *genl_sk_priv_alloc(struct genl_family *family)
>> >> +{
>> >> +	struct genl_sk_priv *priv;
>> >> +
>> >> +	priv = kzalloc(size_add(sizeof(*priv), family->sock_priv_size),
>> >> +		       GFP_KERNEL);
>> >> +	if (!priv)
>> >> +		return ERR_PTR(-ENOMEM);
>> >> +	priv->destructor = family->sock_priv_destroy;  
>> >
>> >family->sock_priv_destroy may be in module memory.
>> >I think you need to wipe them when family goes :(  
>> 
>> Crap. That's a bit problematic. Family can unregister and register
>> again, with user having the same sock sill opened with legitimate
>> expectation of filter being applied. Don't see now how to handle this
>> other then no-destroy and just kfree here in genetlink.c :/ Going back
>> to v4?
>
>When family gets removed all subs must be cleared. So the user
>sock will have to resolve the mcast ID again, and re-subscribe
>again to get any notification. Having to re-sub implies having
>to re-add filters in my mind.

Okay, that sounds fine. Thanks!

