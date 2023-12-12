Return-Path: <netdev+bounces-56377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B937180EAAB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA24D1C20C92
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96B5DF2D;
	Tue, 12 Dec 2023 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge+dpE01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D940EB;
	Tue, 12 Dec 2023 03:42:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c317723a8so46199105e9.3;
        Tue, 12 Dec 2023 03:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381375; x=1702986175; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkMi5XsECucibhGSAnp7TelBnOBpnxzR3nugb8GXnNs=;
        b=Ge+dpE01WYJ+/iL1gjl6dcpyg4uMbcnr5VfElJq7Q/iLQIpfBiQXPG4Mt2wPSPFYgO
         u5lclVCdme+nzAFiWHUqTdWZP1K4bIyHD6+5Li7affbj3622ExzlGSXkFMJeEPkLDCcR
         T3vF7bA92J0RQxWYY3VrTdpMhpdXRFD83cPP1S6vnfjf0yj6S6w4FA0JvGA+xDAuvjjm
         bhodE878sPlCeSO8QFk7jTxpkpLgRXZtxLOeyxQLcx3Nal4VJNXlHug5sWCNrzb5JT86
         T+KIUW1/fsaMabTLig339hFc4q9Z5osaR3DNxgg8JaCK4cc1005qzQKFanZEUyawkQPk
         TaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381375; x=1702986175;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkMi5XsECucibhGSAnp7TelBnOBpnxzR3nugb8GXnNs=;
        b=tgQnbwwfj0mtRyc6C25CLTPKm85jVWFqyN/tLlz5/IGDr79NIwuN0zZH6QL2MjcPgn
         qI3EdZQ1IUvt3C3CCIswga3r0ZB3ycED/L0lnmao+DcPi5LtL9f02fH51z5RO68d/DmY
         QGEnO8ylgWCIgbSTQcCyjtNqaUBo95/YPqf1Iboaejkmk+jWp4m4znonLLD7ACBr9duH
         BEhx4wmZtCeQCG5pyUIhc46DoSRulIrfdZgC4kEtmMqYsry8dtxd9fgTRpb+dLwSgTym
         Gci2CeC8mrWkjawbup9d/rBYmAK4cx448g7XZH3iUJJj/y2o+Xpx3fu7wmlMme6seIxG
         ow9g==
X-Gm-Message-State: AOJu0YzwAj4LqiYWEoePBs4+cGpVso88BavwUhRsAuTJQ9MS3rYMW/vk
	vm0OyuwHwf8Iu7Xn3A3zTIdpgtc5tZzyRg==
X-Google-Smtp-Source: AGHT+IGaQALHnVIFfcRh9sMD23gar/5ia/T/A6d3fD//Hhq9xktocTCi2RSwpijWjNp1rtgj3gIjTw==
X-Received: by 2002:a05:600c:45d0:b0:40c:4575:2044 with SMTP id s16-20020a05600c45d000b0040c45752044mr2088896wmo.174.1702381374732;
        Tue, 12 Dec 2023 03:42:54 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040b40468c98sm18059615wmq.10.2023.12.12.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:42:54 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 06/11] doc/netlink: Document the sub-message
 format for netlink-raw
In-Reply-To: <20231211175634.3ac1ea07@kernel.org> (Jakub Kicinski's message of
	"Mon, 11 Dec 2023 17:56:34 -0800")
Date: Tue, 12 Dec 2023 11:32:53 +0000
Message-ID: <m24jgn8xlm.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-7-donald.hunter@gmail.com>
	<20231211175634.3ac1ea07@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Dec 2023 16:40:34 +0000 Donald Hunter wrote:
>> +Sub-messages
>> +------------
>> +
>> +Several raw netlink families such as rt_link and tc have type-specific
>> +sub-messages. These sub-messages can appear as an attribute in a top-level or a
>> +nested attribute space.
>> +
>> +A sub-message attribute uses the value of another attribute as a selector key to
>> +choose the right sub-message format. For example if the following attribute has
>> +already been decoded:
>
> We may want to explain why we call this thing "sub-message". How about:
>
>   Several raw netlink families such as rt_link and tc use attribute
>   nesting as an abstraction to carry module specific information.
>   Conceptually it looks as follows::
>
>     [OUTER NEST OR MESSAGE LEVEL]
>       [GENERIC ATTR 1]
>       [GENERIC ATTR 2]
>       [GENERIC ATTR 3]
>       [GENERIC ATTR - wrapper]
>         [MODULE SPECIFIC ATTR 1]
>         [MODULE SPECIFIC ATTR 2]
>
>   The GENERIC ATTRs at the outer level are defined in the core (or rt_link
>   or core TC), while specific drivers / TC classifiers, qdiscs etc. can
>   carry their own information wrapped in the "GENERIC ATTR - wrapper".
>   Even though the example above shows attributes nesting inside the wrapper,
>   the modules generally have full freedom of defining the format of the nest.
>   In practice payload of the wrapper attr has very similar characteristics
>   to a netlink message. It may contain a fixed header / structure, netlink
>   attributes, or both. Because of those shared characteristics we refer
>   to the payload of the wrapper attribute as a sub-message.

I'll incorporate into next revision. Thanks!

>> +A sub-message attribute uses the value of another attribute as a selector key to
>> +choose the right sub-message format. For example if the following attribute has
>> +already been decoded:

