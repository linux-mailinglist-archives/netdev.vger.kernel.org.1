Return-Path: <netdev+bounces-44779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D977D9C03
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0101F23779
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF419448;
	Fri, 27 Oct 2023 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="MhD6tuwd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34B18654
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:47:19 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C8DE
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 07:47:16 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SH59F34qJz9skg;
	Fri, 27 Oct 2023 16:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1698418033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8XBlQ+VVXLiU+a3kVYca2o6wtonqUgf+Z2GJpiCmQU=;
	b=MhD6tuwdCS9Az/aa85OUDKVQZVgeYZskKiKliSQRTz/5tbC+85rpqiHhBM1eSQVKE0yyE+
	8zbZaompplyX68w3DHmHyZlZ2aZiPk08mMzr4YBRoRMcScPflbUHUkVyW23HRW1e3fJ67x
	brFWZoPwP5xKvUdE1LJHqOGrG47iaeZfvqHObSLqypOLkEbY5QkPDWFzhdx/voCRhu5N7I
	U0kwDC48GY95xvkMNkRuTHw+Zp5Oi9HZwHcwG/3ar8OhCapKXB0Ggmy+jEP6eGMY3Jqvri
	WGLL3KLLHEVq8nYIE5Qm1PfUUu7KTiTkq9QM5i2kE25vtzwYuW4aG5JCzZiyxg==
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-4-jiri@resnulli.us>
 <61a6392e-5d77-4f15-bcd2-7bd26326d805@gmail.com>
From: Petr Machata <me@pmachata.org>
To: David Ahern <dsahern@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 stephen@networkplumber.org, daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v3 3/6] devlink: extend
 pr_out_nested_handle() to print object
Date: Fri, 27 Oct 2023 15:12:46 +0200
In-reply-to: <61a6392e-5d77-4f15-bcd2-7bd26326d805@gmail.com>
Message-ID: <878r7o5dht.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4SH59F34qJz9skg


David Ahern <dsahern@gmail.com> writes:

> On 10/24/23 4:04 AM, Jiri Pirko wrote:
>> @@ -2861,6 +2842,38 @@ static void pr_out_selftests_handle_end(struct dl *dl)
>>  		__pr_out_newline();
>>  }
>>  
>> +static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
>> +				   bool is_object)
>> +{
>> +	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
>> +	int err;
>> +
>> +	err = mnl_attr_parse_nested(nla_nested_dl, attr_cb, tb);
>> +	if (err != MNL_CB_OK)
>> +		return;
>> +
>> +	if (!tb[DEVLINK_ATTR_BUS_NAME] ||
>> +	    !tb[DEVLINK_ATTR_DEV_NAME])
>> +		return;
>> +
>> +	if (!is_object) {
>> +		char buf[64];
>> +
>> +		sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
>> +			mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
>
> buf[64] - 1 for null terminator - 16 for IFNAMSIZ leaves 47. I do not
> see limits on bus name length, so how can you guarantee it is always <
> 47 characters?
>
> Make this snprintf, check the return and make sure buf is null terminated.

I was wondering whether somehing like this might make sense in the
iproute2 library:

	#define alloca_sprintf(FMT, ...) ({					\
		int xasprintf_n = snprintf(NULL, 0, (FMT), __VA_ARGS__);	\
		char *xasprintf_buf = alloca(xasprintf_n);			\
		sprintf(xasprintf_buf, (FMT), __VA_ARGS__);			\
		xasprintf_buf;							\
	})

	void foo() {
		const char *buf = alloca_sprintf("%x %y %z", etc.);
		printf(... buf ...);
	}

I'm not really happy with it -- because of alloca vs. array, and because
of the double evaluation. But all those SPRINT_BUF's peppered everywhere
make me uneasy every time I read or write them.

Or maybe roll something custom asprintf-like that can reuse and/or
realloc a passed-in buffer?

The sprintf story is pretty bad in iproute2 right now, IMHO.

