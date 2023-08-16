Return-Path: <netdev+bounces-28080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933277E262
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C3A1C210A4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F211198;
	Wed, 16 Aug 2023 13:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2F11192
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:19:55 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB7E52;
	Wed, 16 Aug 2023 06:19:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so60427845e9.0;
        Wed, 16 Aug 2023 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692191991; x=1692796791;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pNaNHlLOAv00m8IjcC0NfScI4U9ELpbgihpd7PFRFY=;
        b=gtrDdH7ceQE2umGzXWMGztJHRW37L33LLif58fmsaSNTBtOURQ9/hq9YZkfnQd1NM6
         bEwXNdKE4nIvez7Qa5jsberIL3AYezffZm8uhCsnoWBS0520ZZPLYki3hRl9Y6YDn8mY
         9sufTZcwbWAeQVOwZ/80byWV4jgji8jmHhRuJ7L3Hqrsmg947lCt4wV1izbMETIH09Ry
         new9af/r1mwktvu00JVBsIIEwLAKErRf22WIuvpfuKveheM4NJQuoqXnCxMsXguvs9UJ
         uJCQiXAcnh8hWY+upzx+G6pv6j/Mt/5YDs/mS0tvd7qhDucdsYAVgdbIVDGGQoz1BEuI
         X/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191991; x=1692796791;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pNaNHlLOAv00m8IjcC0NfScI4U9ELpbgihpd7PFRFY=;
        b=b6HDJqxrgKzlL/WPrS+ekZVdGn+fqmpGhop/YIud2ajx0JAtxxoH8RCGQYQcRNyR/v
         VlD76JFAOarjHIQ0s1GGHfZjSofFt4g7e9CqHT6TxH+HiWmsZjpfvLyozlVQWiSqYLDR
         k8IB59WvlKHtgc+6zrj6+FrXUKZlNN0S9ZJMfQUK8pYNUNyS47x8E6R/CrVYKoSd13aR
         TfKiUtwaq8D0oCm9BUupW8Q/pieX3DTqtduSm6P4sFuqF/qQiId8S6yp22+6BdPN0bAM
         A1umNRnM9+8a56e36ljwlKVkDbGfOwVECnJbOcIMJaHrOzjUO9+Egl7xwfO2dNCWovjj
         Sl8A==
X-Gm-Message-State: AOJu0Ywv9qwP6m/E9MnDoOqz49PD+OwlhNOCVZkP+ijXcTFUfYDSTxjG
	IrpWOT4ah7B74JmUBGO2wAE=
X-Google-Smtp-Source: AGHT+IEHs3dUujv58X9WeLbFbskPpx9lSyfurrbMMNu4w68efv2+Xz37tNK1kyqMHRt7b2eQ888y5w==
X-Received: by 2002:a05:600c:20a:b0:3f9:b430:199b with SMTP id 10-20020a05600c020a00b003f9b430199bmr1527781wmi.15.1692191990457;
        Wed, 16 Aug 2023 06:19:50 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:79ba:2be3:e281:5f90])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fe61c33df5sm24362340wmh.3.2023.08.16.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:19:49 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Stanislav Fomichev
 <sdf@google.com>,  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 02/10] doc/netlink: Document the
 genetlink-legacy schema extensions
In-Reply-To: <m2bkf7jswr.fsf@gmail.com> (Donald Hunter's message of "Wed, 16
	Aug 2023 09:25:08 +0100")
Date: Wed, 16 Aug 2023 14:16:33 +0100
Message-ID: <m2ttszi0um.fsf@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-3-donald.hunter@gmail.com>
	<20230815194902.6ce9ae12@kernel.org> <m2bkf7jswr.fsf@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Donald Hunter <donald.hunter@gmail.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Tue, 15 Aug 2023 20:42:46 +0100 Donald Hunter wrote:
>>> +
>>> +Globals
>>> +-------
>>> +
>>> + - ``kernel-policy`` - Specify whether the kernel input policy is ``global``,
>>> +   ``per-op`` or ``split``.
>>
>> Maybe a few more words:
>>
>>  Specify whether the kernel input policy is ``global`` i.e. the same for
>>  all operation of the family, defined for each operation individually 
>>  (``per-op``), or separately for each operation and operation type
>>  (do vs dump) - ``split``.
>
> Ack. As an aside, what do we mean by "kernel input policy"?

So I've just spotted that kernel-policy is already documented in
core-api/netlink.rst and I guess I shouldn't be documenting it in the
userspace-api at all? I could add a reference to the core-api docs so
that it's easier to find the kernel side docs when reading the
userspace-api?


