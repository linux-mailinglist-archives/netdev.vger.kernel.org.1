Return-Path: <netdev+bounces-50510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357177F5F9C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACECAB2130A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3824A04;
	Thu, 23 Nov 2023 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VHaR3lwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F19E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 04:59:19 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548f74348f7so1214184a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700744358; x=1701349158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3lEDfMbf4/5n8hKchOxqlgfXgkFHsFTDF69zq4AYLI=;
        b=VHaR3lwaRXGtHyPaeY+ocfdTtejaTa/BcGf03XqFTDnSJp5ED/vsqveJuyQG9HWz/Z
         yZT4npUH4+MM+suM9P0wHE3CF5nVFp3cu6kh0XzokmM3KM4X7nDz5/ny1Be8pNCnK+Kj
         sEWXdlz3cRhyhjZ6G4DKZg2862MAD1gasPFFQa42E/gjdInM6JWWDCrfwdjzW0m3t4yv
         lp0UWfnkEehij6P2FvnorbXwaHuO2goEuJyYktJj+JA/zB6qH1xWRbtCGuGHst2CrKCJ
         jhdR4CmmW1lI+h3nKs/bSPs+reKMGvz0l3vJAJ+zyKcxPNP1T4nDkxekEA1o+bRkRV5L
         PBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700744358; x=1701349158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3lEDfMbf4/5n8hKchOxqlgfXgkFHsFTDF69zq4AYLI=;
        b=brUiUP5CX8WBPaO+qad3PVZFmDF9S8c/7tfo1Y1xNledetUTPO1TrxizYgOkTNtyEX
         WyyHDzL44oUkkG1V5EFgEAbp4fx4zNdBxzc6p+uMcMSCTS820ftc4vN7UX1C9pPPN9xQ
         mfYc4YRNp1gOH1ZHzgjPoYBI3NdJASQYP5LITaPoH7r0EMSU/snYtsPiREAf98t5fPiy
         U3WGzzLAMIUj90Xd6e9eMszko8qlDfzQbG559O9fbOn/9YdPol+f40grm3Z6XsK77kDE
         VALU4R2METi4pqbuVJeLpEhpqSlTqn1zb55OfSujqqFsFK0tcl01thWf3vJXdnljB5N1
         xRog==
X-Gm-Message-State: AOJu0YxQow7oxteIt9BZsAonom4IBGbUDQDGzpES7WTzW39j5lRVKp6i
	QbGxhFVxDL/H2C/3d2aNHPgF8w==
X-Google-Smtp-Source: AGHT+IEbbo+OCSVPb1MOZP7avY+hyd5lsGE7mpvnDA3Rh4qtJkO8g2wvOdUN7rUznRa1G2yr+69jZA==
X-Received: by 2002:a17:906:6958:b0:a03:cde5:e02f with SMTP id c24-20020a170906695800b00a03cde5e02fmr4192652ejs.38.1700744357954;
        Thu, 23 Nov 2023 04:59:17 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b009de3641d538sm747565ejb.134.2023.11.23.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:59:17 -0800 (PST)
Date: Thu, 23 Nov 2023 13:59:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: swarup <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v3] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZV9MpLBwS1ndszzf@nanopsycho>
References: <20231123100119.148324-1-swarupkotikalapudi@gmail.com>
 <ZV8lf8L8Me+T7iIW@nanopsycho>
 <ZV9FnjRH6VTwWaaX@swarup-virtual-machine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV9FnjRH6VTwWaaX@swarup-virtual-machine>

Thu, Nov 23, 2023 at 01:29:18PM CET, swarupkotikalapudi@gmail.com wrote:
>On Thu, Nov 23, 2023 at 11:12:15AM +0100, Jiri Pirko wrote:
>> Thu, Nov 23, 2023 at 11:01:19AM CET, swarupkotikalapudi@gmail.com wrote:
>> >Add some missing(not all) attributes in devlink.yaml.
>> >
>> >Re-generate the related devlink-user.[ch] code.
>> >
>> >enum have been given name as devlink_stats(for trap stats)
>> >and devlink_trap_metadata_type(for trap metadata type)
>> >
>> >Test result with trap-get command:
>> >  $ sudo ./tools/net/ynl/cli.py \
>> >   --spec Documentation/netlink/specs/devlink.yaml \
>> >   --do trap-get --json '{"bus-name": "netdevsim", \
>> >                          "dev-name": "netdevsim1", \
>> >   "trap-name": "ttl_value_is_too_small"}' --process-unknown
>> > {'attr-stats': {'rx-bytes': 47918326, 'rx-dropped': 21,
>> >                'rx-packets': 337453},
>> > 'bus-name': 'netdevsim',
>> > 'dev-name': 'netdevsim1',
>> > 'trap-action': 'trap',
>> > 'trap-generic': True,
>> > 'trap-group-name': 'l3_exceptions',
>> > 'trap-metadata': {'metadata-type-in-port': True},
>> > 'trap-name': 'ttl_value_is_too_small',
>> > 'trap-type': 'exception'}
>> 
>> 1. You have to maintain 24 hours between submission of one
>> patch/patchset:
>> https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html
>> 2. You didn't address my comment to last version
>> 
>Hi Jiri,
>
>I have read the above link, but missed the constraint
>of 24 hour gap between patches.
>I will be careful and not send the patch again within 24 hours.
>
>I could not understand your 2nd point.
>Does it mean i should not include
>test result e.g. "Test result with trap-get command: ...."

Does not make sense to me. If you put it like this, it implicates that
the trap attributes are the ones you are introducing in this patch.
However, you introduce much more.


>Or
>If it is something else, please elabroate more, which helps me to address your comment.
>
>I will try to clarify review comment, henceforth before sending new patchset for review.
>
>Thanks,
>Swarup

