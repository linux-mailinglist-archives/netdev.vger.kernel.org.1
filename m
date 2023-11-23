Return-Path: <netdev+bounces-50423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05917F5BFF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C65B281861
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D5322303;
	Thu, 23 Nov 2023 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0oC01OCJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF761A4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:12:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso90565566b.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700734337; x=1701339137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrbVCzExeu1jmL69CKkLWpl5xQODZACzz++8PqEDTow=;
        b=0oC01OCJ6NqvV1z13YNR+INAPNGkfY0hcbpt9ITLs2yopext3fMoJ8q60D91PWRMuC
         x+COyk0EtOFICXOFzxc8QgDwsjyPW6SCQoT2cn72gvOvZ5BHQTiak4iLjiAjKNa9VEyd
         wsYqgaxMFesM9+Tn2jm+pLHH+Gq2bTfl5eB+vQiTClRD36pPELNbV58ZAlxkqecytIWU
         X01zEE97xFFj40TKm1gXT02gyk1ne3+i3+ab43eX7Ux+uwxt9bn6edcagCqDIT+5BrEJ
         e/HeoW9d1tQzpF6R9pYFeFZq0YXPEHcWD8w7+wV+xXPePN+DU+K5L/aAXDaj8WuG5SIC
         mayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734337; x=1701339137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrbVCzExeu1jmL69CKkLWpl5xQODZACzz++8PqEDTow=;
        b=lTsd9nW9UC8GkjKUNERDuHNPkUzS8Rzp8ghas784bdW0pdvWPfEY4Mq74wg68S1BGi
         YCwozU5WnQk5gBLutLop3jhC1lYLGTpf1E+tigIDZ6vtIPgeT2wyTxNwTvHKnf7I/5Zz
         Ck1OK73gylyAdu34X8xiADPuc6FtG1vUTL4epml+5l+3aqGCOc5xJKIP3mqfEWZZ1Vxq
         52tkz9QtSl5l50fZ4aBXhAjY0R7noHZVjqEKR4b/daENPYzBv55KXDk+IF04UUKDLO4v
         D1BwUOq4MRTUSsSEn6CKqMTrC7CfEAOdelu9h9/Tfg3Kxo7iHaVFf2jKjB/y8XmsIY4v
         lJwg==
X-Gm-Message-State: AOJu0YybTNqfgvffSVWIs/epfLzeeq7U3m0gLRkz4y7qrZkWg59N92xm
	ff1X53lHm0VE77dE0YiVLpD/cs0QusCDBxqCDYA=
X-Google-Smtp-Source: AGHT+IHxnB/GPYZ1Xs7r1Id0QxLGCp5J6PxsMmSCDFQeIJvpgwLVa1o7mPCxK+V8oWy9MzpyMzgi2Q==
X-Received: by 2002:a17:906:290:b0:a03:d8ea:a263 with SMTP id 16-20020a170906029000b00a03d8eaa263mr3851152ejf.16.1700734336915;
        Thu, 23 Nov 2023 02:12:16 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cf16-20020a170906b2d000b0099bd7b26639sm584833ejb.6.2023.11.23.02.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:12:16 -0800 (PST)
Date: Thu, 23 Nov 2023 11:12:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v3] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZV8lf8L8Me+T7iIW@nanopsycho>
References: <20231123100119.148324-1-swarupkotikalapudi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123100119.148324-1-swarupkotikalapudi@gmail.com>

Thu, Nov 23, 2023 at 11:01:19AM CET, swarupkotikalapudi@gmail.com wrote:
>Add some missing(not all) attributes in devlink.yaml.
>
>Re-generate the related devlink-user.[ch] code.
>
>enum have been given name as devlink_stats(for trap stats)
>and devlink_trap_metadata_type(for trap metadata type)
>
>Test result with trap-get command:
>  $ sudo ./tools/net/ynl/cli.py \
>   --spec Documentation/netlink/specs/devlink.yaml \
>   --do trap-get --json '{"bus-name": "netdevsim", \
>                          "dev-name": "netdevsim1", \
>   "trap-name": "ttl_value_is_too_small"}' --process-unknown
> {'attr-stats': {'rx-bytes': 47918326, 'rx-dropped': 21,
>                'rx-packets': 337453},
> 'bus-name': 'netdevsim',
> 'dev-name': 'netdevsim1',
> 'trap-action': 'trap',
> 'trap-generic': True,
> 'trap-group-name': 'l3_exceptions',
> 'trap-metadata': {'metadata-type-in-port': True},
> 'trap-name': 'ttl_value_is_too_small',
> 'trap-type': 'exception'}

1. You have to maintain 24 hours between submission of one
patch/patchset:
https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html
2. You didn't address my comment to last version


