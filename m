Return-Path: <netdev+bounces-50628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9E7F6609
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E382819FA
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31594B5BB;
	Thu, 23 Nov 2023 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YZOq+NA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE3B18B
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ffef4b2741so152788466b.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763322; x=1701368122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTg9/NNZBMLZtAkv1MI2zSvlUaZGK/O1RTlt+dC1O7k=;
        b=YZOq+NA2OtoBFhXgquW9h5OIOeAnEVC6Mv7uq4C0rZo+g+8rVxWn7UPWEJvvF/3LTE
         QBVIOML6OsWZe1a+czZdvaB55WjoxgTsSxNRrQJHAXrfNE0n6gdFiRWaknOjgjNjjFPe
         IwSFipm281nUP/whrEzJCTgrF1L7/e28H7hm8+V+jYL+QOx9Xg5xYWph0ceOSXDfon82
         grZmnt4jZM4nLFI4qo54tDlMPIXPOnD79tvWzk1KSCcC+E2ZD5IdnYCTSIbCzkzT5Y5J
         iKvA1mC8/ReAFxLvqn5p9dn4SPwmCdu5hvXgb32GOT2Fs/1JMTU61lx9cHblMCA52hyT
         vLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763322; x=1701368122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTg9/NNZBMLZtAkv1MI2zSvlUaZGK/O1RTlt+dC1O7k=;
        b=XK5YpU3MXkZNX2yzubCg1tEZpsIiha3yUIK/2Gw/X3Hb36Py9Rb/Dswkmac5U/Iut1
         ShpZI6AA8FORqhQqh+RCEG5rOkhIyxwNMGz9NubBiCGXEJIZ2n0rQfZaQhTppLy0SOgb
         FrOs5UG3JFMqpjMoNhdj2CjqgzrHFoNFhE8RW5Zq5D3rtWYECN+EJJ1WXDRRJNnzSWHO
         iIJ7OxrKc1rUFHZfTmq6Le0SipZGXd5mBtPPhh/QRRYLnyYpd12rxkwKmD+9UY0IZcDk
         zis/CF0LiEGyz/Hj0cz/EBOLlOCvvqDv4xsVhbvhQ7jyKC3svSBGqus49WG/u91bFvCK
         jbcg==
X-Gm-Message-State: AOJu0Yx53S4ajbRXQtk9Rk/PxkLJsvTicU+EL1ZsMaium/vctyMVcmX8
	eMnwN54dHumNUHoUkgwpkdmnDg==
X-Google-Smtp-Source: AGHT+IFhTRcigICH4DZrP5h/NtNQIkWD66iM2JYoZPmL7PNXFy0ysaEr+1AtehXHTiPeYDa1SDf2+w==
X-Received: by 2002:a17:906:ae8c:b0:9fc:9a03:cc23 with SMTP id md12-20020a170906ae8c00b009fc9a03cc23mr86898ejb.21.1700763322253;
        Thu, 23 Nov 2023 10:15:22 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906560400b009fcb5fcfbe6sm1057278ejq.220.2023.11.23.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:21 -0800 (PST)
Date: Thu, 23 Nov 2023 19:15:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: swarup <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v3] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZV+WuPT9f5pDiHft@nanopsycho>
References: <20231123100119.148324-1-swarupkotikalapudi@gmail.com>
 <ZV8lf8L8Me+T7iIW@nanopsycho>
 <ZV9FnjRH6VTwWaaX@swarup-virtual-machine>
 <ZV9MpLBwS1ndszzf@nanopsycho>
 <ZV+UDY0B8AEkdVxc@swarup-virtual-machine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV+UDY0B8AEkdVxc@swarup-virtual-machine>

Thu, Nov 23, 2023 at 07:03:57PM CET, swarupkotikalapudi@gmail.com wrote:
>On Thu, Nov 23, 2023 at 01:59:16PM +0100, Jiri Pirko wrote:
>> Thu, Nov 23, 2023 at 01:29:18PM CET, swarupkotikalapudi@gmail.com wrote:
>> >On Thu, Nov 23, 2023 at 11:12:15AM +0100, Jiri Pirko wrote:
>> >> Thu, Nov 23, 2023 at 11:01:19AM CET, swarupkotikalapudi@gmail.com wrote:
>> >> >Add some missing(not all) attributes in devlink.yaml.
>> >> >
>> >> >Re-generate the related devlink-user.[ch] code.
>> >> >
>> >> >enum have been given name as devlink_stats(for trap stats)
>> >> >and devlink_trap_metadata_type(for trap metadata type)
>> >> >
>> >> >Test result with trap-get command:
>> >> >  $ sudo ./tools/net/ynl/cli.py \
>> >> >   --spec Documentation/netlink/specs/devlink.yaml \
>> >> >   --do trap-get --json '{"bus-name": "netdevsim", \
>> >> >                          "dev-name": "netdevsim1", \
>> >> >   "trap-name": "ttl_value_is_too_small"}' --process-unknown
>> >> > {'attr-stats': {'rx-bytes': 47918326, 'rx-dropped': 21,
>> >> >                'rx-packets': 337453},
>> >> > 'bus-name': 'netdevsim',
>> >> > 'dev-name': 'netdevsim1',
>> >> > 'trap-action': 'trap',
>> >> > 'trap-generic': True,
>> >> > 'trap-group-name': 'l3_exceptions',
>> >> > 'trap-metadata': {'metadata-type-in-port': True},
>> >> > 'trap-name': 'ttl_value_is_too_small',
>> >> > 'trap-type': 'exception'}
>> >> 
>> >> 1. You have to maintain 24 hours between submission of one
>> >> patch/patchset:
>> >> https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html
>> >> 2. You didn't address my comment to last version
>> >> 
>> >Hi Jiri,
>> >
>> >I have read the above link, but missed the constraint
>> >of 24 hour gap between patches.
>> >I will be careful and not send the patch again within 24 hours.
>> >
>> >I could not understand your 2nd point.
>> >Does it mean i should not include
>> >test result e.g. "Test result with trap-get command: ...."
>> 
>> Does not make sense to me. If you put it like this, it implicates that
>> the trap attributes are the ones you are introducing in this patch.
>> However, you introduce much more.
>> 
>> 
>> >Or
>> >If it is something else, please elabroate more, which helps me to address your comment.
>> >
>> >I will try to clarify review comment, henceforth before sending new patchset for review.
>> >
>> >Thanks,
>> >Swarup
>
>Hi Jiri,
>
>I will submit a patch which has only trap attribute only changed.
>
>Thanks for the clarification.

Better to just remove the "test result" from the description.


>
>Thanks,
>Swarup

