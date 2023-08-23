Return-Path: <netdev+bounces-30138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D199786242
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEF41C20D5C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB2200A3;
	Wed, 23 Aug 2023 21:25:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE2399
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 21:25:24 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641CDCEE;
	Wed, 23 Aug 2023 14:25:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fef3c3277bso30174585e9.1;
        Wed, 23 Aug 2023 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825919; x=1693430719;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpEEPZmrCPCqgC5T/1i+GwHqJ4iLE4jDzYi6rzURs+E=;
        b=HOkQvCobvX9x7ulu29c55ytxc1OGYiGtTPbbh5HtJy7rN6uKauwkiOcgYwr9V1oIFu
         D82xul/e2nXtHr/GLUt+rYvMgD1tApOp8529LdCGORjgksy4IrMFW4PxmkK2cHPfRUWd
         qgQVKYFol4dDNU4fiLGXRWRzg6nFYgspxfrmCmLdYW905ecs2MZs++T5Kg9HgmxP0lq6
         GuMgcsnMRvFMiQgRB2sxFhvSZ/0iopIc8piPGi322XPP0DOBVICgLvwHJ2Vsd4ITsOZ2
         c13AkmY81jkreZ6rYzD/65b+3kPfsLuPaqXvFbJZ37UoSIisHaYQH+Onq7KTJxRUKzHU
         IClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825919; x=1693430719;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpEEPZmrCPCqgC5T/1i+GwHqJ4iLE4jDzYi6rzURs+E=;
        b=fPIpP1kDGYb47PZ1msD6hPn7D3O1TULfFYXSvA2iU/zXD9xglhr5ZWO+aRts+vIAy8
         8I5WV5OFGBdFXZuoVKu1OCjcfAuRLlKUsmldJCY3rZe5v7r4Ysb2T26C5QT7NIkdfrH3
         URrvSYY+UZZpr4ubfii2eq+EJwhvanB5I9kZbcOoJ7nwiLLZGrQY12KJhoYL/dWqkKPr
         kRt61EhGMjnnYR/MsuIldAyiWJY6lj9IP0p/hPUMnzE+ZrtILMFXHkH2UiYgRb9T5s0l
         dQUxdiDJxSCsFNqzYgafOeJeEwZt4khcBpxKHq+pKxGUCZeg0IQgDQJkgOFAPpo7q3bH
         YmYQ==
X-Gm-Message-State: AOJu0YwXTkLB+g5qOVpu+TRPFkA+GO1rw7GNP1dfaO4yTfdAuUDD4Ehs
	XzP9WlgWYovw8zg38nPgsP0=
X-Google-Smtp-Source: AGHT+IE/5XU5oCGdgY0CogQYbKgKek+oWdnVGern9hnv3jEdck7Fb/r5UKfUjbthF70JRTKwfPuhdw==
X-Received: by 2002:a05:600c:2218:b0:3fe:ad3:b072 with SMTP id z24-20020a05600c221800b003fe0ad3b072mr9995370wml.17.1692825918588;
        Wed, 23 Aug 2023 14:25:18 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id f10-20020a1c6a0a000000b003fe407ca05bsm651380wmc.37.2023.08.23.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:25:17 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <netdev@vger.kernel.org>,  "Jakub Kicinski" <kuba@kernel.org>,  "David
 S. Miller" <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,
  Paolo Abeni <pabeni@redhat.com>,  "Jonathan Corbet" <corbet@lwn.net>,
  <linux-doc@vger.kernel.org>,  Stanislav Fomichev <sdf@google.com>,
  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
  <donald.hunter@redhat.com>
Subject: Re: [PATCH net-next v4 02/12] doc/netlink: Add a schema for
 netlink-raw families
In-Reply-To: <005940db-b7b6-c935-b16f-8106d3970b11@intel.com> (Jacob Keller's
	message of "Wed, 23 Aug 2023 12:32:49 -0700")
Date: Wed, 23 Aug 2023 22:19:53 +0100
Message-ID: <m2edjth2x2.fsf@gmail.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
	<20230823114202.5862-3-donald.hunter@gmail.com>
	<005940db-b7b6-c935-b16f-8106d3970b11@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jacob Keller <jacob.e.keller@intel.com> writes:

> On 8/23/2023 4:41 AM, Donald Hunter wrote:
>> This schema is largely a copy of the genetlink-legacy schema with the
>> following additions:
>> 
>>  - a top-level protonum property, e.g. 0 (for NETLINK_ROUTE)
>>  - add netlink-raw to the list of protocols supported by the schema
>>  - add a value property to mcast-group definitions
>> 
>> This schema is very similar to genetlink-legacy and I considered
>> making the changes there and symlinking to it. On balance I felt that
>> might be problematic for accurate schema validation.
>> 
>
> Ya, I think they have to be distinct to properly validate.
>
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>>  Documentation/netlink/netlink-raw.yaml | 414 +++++++++++++++++++++++++
>>  1 file changed, 414 insertions(+)
>>  create mode 100644 Documentation/netlink/netlink-raw.yaml
>> 
>> diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
>> new file mode 100644
>> index 000000000000..ef7bd07eab62
>> --- /dev/null
>> +++ b/Documentation/netlink/netlink-raw.yaml
>> @@ -0,0 +1,414 @@
>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://kernel.org/schemas/netlink/genetlink-legacy.yaml#
>> +$schema: https://json-schema.org/draft-07/schema
>> +
>> +# Common defines
>> +$defs:
>> +  uint:
>> +    type: integer
>> +    minimum: 0
>> +  len-or-define:
>> +    type: [ string, integer ]
>> +    pattern: ^[0-9A-Za-z_]+( - 1)?$
>> +    minimum: 0
>> +
>> +# Schema for specs
>> +title: Protocol
>> +description: Specification of a genetlink protocol
>
> If this is for netlink-raw, shouldn't this not say genetlink? Same
> elsewhere? or am I misunderstanding something?

It's a good question. The schema definitions are currently strict
supersets of genetlink:

genetlink <= genetlink-c <= genetlink-legacy <= netlink-raw

As you noted below, there's only 2 additions needed for the netlink raw
families, protonum and mcast-group value.

I would be happy to change the description and other references to
genetlink in this spec, but I'd like to hear Jakub's thoughts about
minimal modification vs a more thorough rewording. Perhaps a middle
ground would be to extend the top-level description to say "genetlink or
raw netlink" and qualify that all mention of genetlink also applies to
raw netlink.

Either way, I just noticed that the schema $id does need to be updated.

>> +type: object
>> +required: [ name, doc, attribute-sets, operations ]
>> +additionalProperties: False
>> +properties:
>> +  name:
>> +    description: Name of the genetlink family.
>> +    type: string
>> +  doc:
>> +    type: string
>> +  version:
>> +    description: Generic Netlink family version. Default is 1.
>> +    type: integer
>> +    minimum: 1
>> +  protocol:
>> +    description: Schema compatibility level. Default is "genetlink".
>> +    enum: [ genetlink, genetlink-c, genetlink-legacy, netlink-raw ] # Trim
>> +  # Start netlink-raw
>
> I guess the netlink raw part is only below this? Or does netlink raw
> share more of the generic netlink code than I thought?

Raw netlink is, so far, the same as genetlink-legacy with the addition
of hard-coded protocol ids.

>> +  protonum:
>> +    description: Protocol number to use for netlink-raw
>> +    type: integer
>> +  # End netlink-raw

[...]

>> +            # Start netlink-raw
>> +            value:
>> +              description: Value of the netlink multicast group in the uAPI.
>> +              type: integer
>> +            # End netlink-raw

