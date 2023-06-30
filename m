Return-Path: <netdev+bounces-14768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB2743B56
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 14:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C0B280BE7
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49314A8E;
	Fri, 30 Jun 2023 12:00:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D5134B5
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 12:00:41 +0000 (UTC)
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 05:00:40 PDT
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1BF10F8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 05:00:40 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 8B3E85C07E5;
	Fri, 30 Jun 2023 13:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1688125886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kAWbnLhfLrWH8lbXCU9besEQHlswAdYILd+P4iFqpA=;
	b=meH9qwt2jIvyxNVTC20Ih0TsySycDwnYVd+Xkgw166sLfVQkdKdntVBrNlr5mwDO9kWWXk
	9ZX0IgZGYDp8t8/gBXfFumQXkrL4mUINEftUNZyBeLvrxNhvikmMWHoHpS0vPDx22bPM3m
	fWv8P4hJFHJAv1VpJkGn0GQT+Lr91U8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Jun 2023 13:51:25 +0200
From: Stefan Agner <stefan@agner.ch>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, john.carr@unrouted.co.uk,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ipv6: add option to explicitly enable reachability
 test
In-Reply-To: <CANn89iKxcqDO3-LyuroUkFUfG2dtZOLE4n2UJQ3y-ft5BRm30g@mail.gmail.com>
References: <b9182b02829b158d55acc53a0bcec1ed667b2668.1680000784.git.stefan@agner.ch>
 <CANn89iKxcqDO3-LyuroUkFUfG2dtZOLE4n2UJQ3y-ft5BRm30g@mail.gmail.com>
Message-ID: <f2b8dc05f1c73c0f0625a695b25c2886@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

On 2023-03-28 19:54, Eric Dumazet wrote:
> On Tue, Mar 28, 2023 at 5:39 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> Systems which act as host as well as router might prefer the host
>> behavior. Currently the kernel does not allow to use IPv6 forwarding
>> globally and at the same time use route reachability probing.
>>
>> Add a compile time flag to enable route reachability probe in any
>> case.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> My use case is a OpenThread device which at the same time can also act as a
>> client communicating with Thread devices. Thread Border routers use the Route
>> Information mechanism to publish routes with a lifetime of up to 1800s. If
>> one of the Thread Border router goes offline, the lack of reachability probing
>> currenlty leads to outages of up to 30 minutes.
>>
>> Not sure if the chosen method is acceptable. Maybe a runtime flag is preferred?
> 
> I guess so. Because distros would have to choose a compile option.
> 
> Not a new sysfs, only an IFLA_INET6_REACHABILITY_PROBE ?
>

Wouldn't that be a per interface config? From what I can tell currently
the reachability probing is disabled when IPv6 forwarding is enabled on
a global level only. So I'd need something which disables that behavior
on a global only as well.

--
Stefan

