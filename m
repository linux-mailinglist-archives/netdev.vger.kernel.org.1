Return-Path: <netdev+bounces-20687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE27609EE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63711C20DF8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F5D8C0A;
	Tue, 25 Jul 2023 06:01:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4468F40
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:01:39 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4AE69
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:01:37 -0700 (PDT)
Received: from [192.168.1.35] (193-154-248-35.hdsl.highway.telekom.at [193.154.248.35])
	by mail.svario.it (Postfix) with ESMTPSA id 07F3FD94D8;
	Tue, 25 Jul 2023 08:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1690264895; bh=fvxeHvaBgd5YTQGff8UMeQlRzwY7V7xvfIjHaerf0Z8=;
	h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
	b=tppB46llavH/U6bCwxy0NumSqUDFkr7Fg8169ElMIFGBCXMMnhPq5R7z7kChHjtzM
	 FJU33s+GS9LEOlMwwG7sFwLa/P+x5FcNoquAC0a07ATAQ8HIxebdDFmHwjda+1Pdxm
	 hm4hfeoYvI8BPtQ09D9bvHdnJF7RE/1zyp/yZaejaJpTKOCLWfJ/pbQYDY55Y/khp9
	 cofCz07to4TP6Sm8SKYZEX5KkFojOZn/A5UpKmJvdpetfU8J93lHB7KdB5EigqWN40
	 naZ5XiboECpde9I2R1Fo8PBzZbKKuX3O6cfBUqKD7hyuUEEDkgPVVpNVT4k4TxHTcA
	 Igq2KD6ynyTeQ==
Message-ID: <a28d60f7-0bea-68aa-5c86-2a141cc81bf3@svario.it>
Date: Tue, 25 Jul 2023 08:01:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Gioele Barabucci <gioele@svario.it>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>
References: <20230719185106.17614-1-gioele@svario.it>
 <20230724184020.41c53f5f@hermes.local>
Content-Language: en-US
Subject: Re: [iproute2 00/22] Support for stateless configuration (read from
 /etc and /usr)
In-Reply-To: <20230724184020.41c53f5f@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/07/23 03:40, Stephen Hemminger wrote:
> On Wed, 19 Jul 2023 20:50:44 +0200
> Gioele Barabucci <gioele@svario.it> wrote:
> 
>> Dear iproute2 maintainers,
>>
>> this patch series adds support for the so called "stateless" configuration
>> pattern, i.e. reading the default configuration from /usr while allowing
>> overriding it in /etc, giving system administrators a way to define local
>> configuration without changing any distro-provided files.
>>
>> In practice this means that each configuration file FOO is loaded
>> from /usr/lib/iproute2/FOO unless /etc/iproute2/FOO exists.
> 
> These files are not something the typical user ever looks at or changes.
> Please explain why all this churn is necessary

Dear Stephen,

I fully agree that these files are rarely if ever modified.

However I assumed that you wished them to remain configurable given that:

1) these files are in /etc, suggesting that they are normal system-wide 
configuration files, and
2) the const is called CONFDIR,
3) the man pages refer to these files as modifiable files, for example, 
ip-link: «GROUP may be a number or a string from the file 
/etc/iproute2/group which can be manually filled.».
4) there are a few guides around the Web that suggest to add entries to 
these files.

If these files are to be configurable, then they should follow the 
stateless pattern (default provided by distro in /usr, local sysadmin 
override /etc).

If these files are not supposed to be configurable and are just 
convenience listings of settings to be considered hard-coded, then 
changing CONFDIR to /usr/lib/iproute2 is the simplest way to make 
iproute2 stateless (i.e. working in cases where /etc is not present).

Would you prefer, instead of this patch series, a patch that simply 
changes CONFDIR to /usr/lib/iproute2/?

Regards,

-- 
Gioele Barabucci

