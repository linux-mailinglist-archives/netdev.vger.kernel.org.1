Return-Path: <netdev+bounces-27974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93677DCA1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1A828186F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6436D523;
	Wed, 16 Aug 2023 08:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7139D521
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:46:27 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF51980;
	Wed, 16 Aug 2023 01:46:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso58765155e9.1;
        Wed, 16 Aug 2023 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692175585; x=1692780385;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LThw6O09LKod8hs5Ia5G/+pdxo/bQPv6KrOfoWEbepM=;
        b=mmj8mO8NmSULLpcE1mHfPWIMs/MBlPv7UlMbh2ogx3sKaB6Tez4ASL49IET17C4txn
         9zx/8gDVqPoHx0ALGRAOgOzvKamztQIOh7Ulo2AQEmH13qXBIveTm4yE+kAnbLPjsgaa
         WPeJzVJpYo2fDw6z7Jhnx4wKzLmlplzsWvs2hKTgYomji6I9xgurQHBc8H4H+nm875eR
         2BrvCIgRHumX1rqV1HH9Xk3HO1E3FUuBaEzhh1sdBMJEkp6IenNye7IfbwRc4GIicnjS
         H07TyYBS4GtGYSJGBUaYSUebsmdLP0z1N5U0xrl42NsNtuPYqF+jud67waflFdyt9G0k
         tnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692175585; x=1692780385;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LThw6O09LKod8hs5Ia5G/+pdxo/bQPv6KrOfoWEbepM=;
        b=gcOqu9AX38TzPCKDCOSKkJx64sRxgbjTlciv2EQ4/5wRn+ghbmX9KUuz49xpeGB6OL
         DGe6N43rK+/Mv2TQQInyET1b8Dt9WLtA3qRPoaEdW5e5qF+shh3yIPqkjIsScySRlDd8
         4Owc3jcW1Xu9DnRtx5kaSZhKyfW2hMfvYcQIQEywyz48Zff+bqVVwURNRgUoT8bCahvq
         q74txPWznzapRLqqmqsjnbGdqGSX3dfi02uJFfG+YvhGg36rWjhgf1lXYw3T6FsGLITX
         tvsXkATe/HG3tWCfnCSyuw6coH+imamGsrwHRzCoEB8HYzygvCNJsx3ZimcolnC4xKy6
         wRqw==
X-Gm-Message-State: AOJu0YzJ7Zo/CWLIOHUWQ4gMv318IC3R+OjKLnMRX0ZyCPXX+6J28Tss
	/TviptsPL9a6xLMtZrt6Qmo=
X-Google-Smtp-Source: AGHT+IF1eauyh+yxvqeCZIlQ/c/CVx92twUDufHoHZwPEfNgWbQwidnyVQEVFBzp0wSrcg1fhRwkQA==
X-Received: by 2002:a7b:cc8c:0:b0:3f7:cb42:fa28 with SMTP id p12-20020a7bcc8c000000b003f7cb42fa28mr861261wma.28.1692175584868;
        Wed, 16 Aug 2023 01:46:24 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:79ba:2be3:e281:5f90])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c22ce00b003fba2734f1esm23496561wmg.1.2023.08.16.01.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:46:24 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Stanislav Fomichev
 <sdf@google.com>,  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 03/10] doc/netlink: Document the netlink-raw
 schema extensions
In-Reply-To: <20230815195236.3835a60b@kernel.org> (Jakub Kicinski's message of
	"Tue, 15 Aug 2023 19:52:36 -0700")
Date: Wed, 16 Aug 2023 09:32:02 +0100
Message-ID: <m27cpvjsl9.fsf@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-4-donald.hunter@gmail.com>
	<20230815195236.3835a60b@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 15 Aug 2023 20:42:47 +0100 Donald Hunter wrote:
>> Add description of netlink-raw specific attributes to the ynl spec
>> documentation and refer to the classic netlink documentation.
>
> I wonder if we should make this a separate doc, similarly to
> genetlink-legacy. Keep the specs.rst focused on newer stuff?

Sure. I could also include examples, like genetlink-legacy does.

Thanks!

