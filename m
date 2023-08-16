Return-Path: <netdev+bounces-27973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F03677DC9F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC381C20F8A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D49D307;
	Wed, 16 Aug 2023 08:46:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D123C2FA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:46:26 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B0DB5;
	Wed, 16 Aug 2023 01:46:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so56949435e9.1;
        Wed, 16 Aug 2023 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692175583; x=1692780383;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSK93UPnB6Klvi+jilJNrTTSvrIQXWHyoQFvggFE/hg=;
        b=rSSedRXS3WSPaQZ47aVCKfhIbwcK41++sEDaezZKNQqEUjPHGtz2aWn7N7cr76k+Aa
         KgcUk+0AUzlHNTtX3OU9m6ukcTQq01+jcwsc6tFR9Es8E9bJD3ZeJIyFhXaD0hSKasA4
         FTab1gFI3yeJ2O81u9Qn/NZRMylMYkolNllT58X75sw9t5BIgrFMV/flmBqfoQ0m0jLV
         U8aPUC8QTg5Rlr+yv7zfUu1tvbfQJ8Z/ShCJ1RR+jRbH2ArysIyMEM9YrhYKhVpuyDZa
         4Di4IynbWtE2gVB+dybVEhUwMASie7/oQRtZ5zteqqTlDwHc0FTTgKg38osP6EMMUKW9
         VS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692175583; x=1692780383;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSK93UPnB6Klvi+jilJNrTTSvrIQXWHyoQFvggFE/hg=;
        b=PlS32euLyr+RQgYGj7/yVZuUC8wIegu8U3hUVJFroUe1n85UmirYT+dB2Sd9VqeoCW
         03OnPjmoQSAD77wTnRdL/1xmh8HklK/m2P53VE3rsDMIC2QvN5CQMBLSDIj9pAj+4MFv
         KIEmo4jMZ+W0RJ8WQOyDZaNUlcNQoyCzm6GtFRjutaTnnVSd3U0aVYOMlrNjxdh4YpzF
         dd5K2vovclpvz94sn0XBk92qbgfkDVzWj8TacgTxM5XKSKY+3hugnM0/24OGsq+m8CW7
         2hhK9svA+sIbXY2MxjA/JP4y7qvourcYN1IVPQJxLrnwNoqYEte3NePwPgW54Gbbc67u
         BX/g==
X-Gm-Message-State: AOJu0YxzVmfVvRKn4N7VKSQwctZSk5Eau9qZfzKA0URjif7AS3vlGvcx
	JgTMdeaqpeiCOKuTEzTWIvQ=
X-Google-Smtp-Source: AGHT+IG2RhXsUTXjDF+NstrUD7qep7ZpNhnN6QlRrOe32iBS9XdpxJ1MAN2JqXN5hfrT58J1pRekoQ==
X-Received: by 2002:a7b:cbd0:0:b0:3fe:34c2:654b with SMTP id n16-20020a7bcbd0000000b003fe34c2654bmr889606wmi.14.1692175583257;
        Wed, 16 Aug 2023 01:46:23 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:79ba:2be3:e281:5f90])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b0030ae53550f5sm20735867wrs.51.2023.08.16.01.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:46:22 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Stanislav Fomichev
 <sdf@google.com>,  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 02/10] doc/netlink: Document the
 genetlink-legacy schema extensions
In-Reply-To: <20230815194902.6ce9ae12@kernel.org> (Jakub Kicinski's message of
	"Tue, 15 Aug 2023 19:49:02 -0700")
Date: Wed, 16 Aug 2023 09:25:08 +0100
Message-ID: <m2bkf7jswr.fsf@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-3-donald.hunter@gmail.com>
	<20230815194902.6ce9ae12@kernel.org>
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

> On Tue, 15 Aug 2023 20:42:46 +0100 Donald Hunter wrote:
>> Add description of genetlink-legacy specific attributes to the ynl spec
>> documentation.
>> 
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>>  Documentation/userspace-api/netlink/specs.rst | 47 +++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>
> Should we merge this with genetlink-legacy.rst?

Sure, I can do that.

>
>> diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
>> index 2e4acde890b7..dde70f9674d4 100644
>> --- a/Documentation/userspace-api/netlink/specs.rst
>> +++ b/Documentation/userspace-api/netlink/specs.rst
>> @@ -443,3 +443,50 @@ nest
>>  
>>  Attribute containing other (nested) attributes.
>>  ``nested-attributes`` specifies which attribute set is used inside.
>> +
>> +genetlink-legacy
>> +================
>> +
>> +The genetlink-legacy schema extends the genetlink schema with some additional
>> +properties that are needed to support legacy genetlink families.
>> +
>> +Globals
>> +-------
>> +
>> + - ``kernel-policy`` - Specify whether the kernel input policy is ``global``,
>> +   ``per-op`` or ``split``.
>
> Maybe a few more words:
>
>  Specify whether the kernel input policy is ``global`` i.e. the same for
>  all operation of the family, defined for each operation individually 
>  (``per-op``), or separately for each operation and operation type
>  (do vs dump) - ``split``.

Ack. As an aside, what do we mean by "kernel input policy"?

>> +   ``per-op`` or ``split``.
>
>> +Struct definitions
>> +------------------
>> +
>> +There is a new type of definition called ``struct`` which is used for declaring
>> +the C struct format of fixed headers and binary attributes.
>> +
>> +members
>> +~~~~~~~
>> +
>> + - ``name`` - The attribute name of the struct member
>> + - ``type`` - One of the scalar types ``u8``, ``u16``, ``u32``, ``u64``, ``s8``,
>> +   ``s16``, ``s32``, ``s64``, ``string`` or ``binary``.
>> + - ``byte-order`` - ``big-endian`` or ``little-endian``
>> + - ``doc``, ``enum``, ``enum-as-flags``, ``display-hint`` - Same as for
>> +   attribute definitions.
>
> Hm, genetlink-legacy.rst has this:
>
> https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#structures
>
> But the larger section is called "Other quirks (todo)"
> I guess you have tackled most of the items in this section
> so we shouldn't call it "todo" ?

I'll clean up genetlink-legacy.rst when I merge these changes.

Thanks for the review!

