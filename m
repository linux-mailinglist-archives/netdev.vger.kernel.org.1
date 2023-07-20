Return-Path: <netdev+bounces-19350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B9875A5FC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D5B1C212C4
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A03FFA;
	Thu, 20 Jul 2023 06:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A83D6A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:05:24 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78921985
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 23:05:21 -0700 (PDT)
Received: from [192.168.1.35] (81-5-204-164.hdsl.highway.telekom.at [81.5.204.164])
	by mail.svario.it (Postfix) with ESMTPSA id EEC76D90CC;
	Thu, 20 Jul 2023 08:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689833118; bh=GVlPlAzNtRa4dtsowkjWeeJgrx35hCVnETjP2lg4JF4=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=DUIwgZZZdeXeUNNJoqfwU9lqPtAwfr1Mn6be6jLQ+YlCz9CXeKcklLU9oxOp6yEKP
	 ewHWRLeXUZzJ9ilcWk/xfNAtkSAAy2loUG2s76S3EfskaLW79OOqWpPCxYQ0gsCbxN
	 cDQMHD2drZT1r/P6J3QTsnU14h1Xyy7gX4E0sqlOtFI0dv7lMnMyllD0yAP828AdWb
	 6Jjc2M6r1oYXExTxeTn/zG5habUD9bxE8U37XId2NXOsxAvAvRkIhbQOBN6FwC5FNm
	 grur88qdfp4aawdwApCDESkDHxszq4PsCQWTLgjBYQM9AtjEQ5HvinhxXWBCCrKMxM
	 52Jb6MLP0PU/A==
Message-ID: <6041446f-ad4f-1b5a-9b7e-b496de080468@svario.it>
Date: Thu, 20 Jul 2023 08:05:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20230719185106.17614-1-gioele@svario.it>
 <20230719143628.4ca42c3f@hermes.local>
Content-Language: en-US
From: Gioele Barabucci <gioele@svario.it>
Subject: Re: [iproute2 00/22] Support for stateless configuration (read from
 /etc and /usr)
In-Reply-To: <20230719143628.4ca42c3f@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/07/23 23:36, Stephen Hemminger wrote:
> On Wed, 19 Jul 2023 20:50:44 +0200
> Gioele Barabucci <gioele@svario.it> wrote:
> 
>> this patch series adds support for the so called "stateless" configuration
>> pattern, i.e. reading the default configuration from /usr while allowing
>> overriding it in /etc, giving system administrators a way to define local
>> configuration without changing any distro-provided files.
>>
>> In practice this means that each configuration file FOO is loaded
>> from /usr/lib/iproute2/FOO unless /etc/iproute2/FOO exists.
> 
> I don't understand the motivation for the change.

The main, but not the only, motivation for stateless systems is explained in

https://clearlinux.org/features/stateless
https://fedoraproject.org/wiki/StatelessLinux
https://summit.debconf.org/debconf15/meeting/276/stateless-cloud-friendly-debian/

In a nutshell: to better support factory resets, shared read-only base 
systems, containers & Co, all software should work even without /etc.

A nice side effect of adopting stateless-style configuration (read from 
/etc, fallback to /usr) is that it allows for distro-provided files to 
be strictly read-only, avoiding a bunch of common failures during 
updates and upgrades (Debian spends a huge amount of resources to 
correctly handle these so called "conffiles". The fewer, the better.)

> Is /etc going away in some future version of systemd?
This is unrelated to systemd, although systemd is probably the most well 
known software that uses this pattern.

> Perhaps just using an an environment variable instead of hard coding
> /etc/iproute2 directory.

Build-time or run-time env variable?

I'd say that run-time env variables (a là XDG Base Directory) are kind 
of hard to deal with in a command like `ip` that is often invoked via 
`sudo` (that filters and changes env in complex ways).

BTW, I strongly suggest to just go with this common pattern that is now 
known to all sysadmins instead of inventing an ad-hoc way to move the 
default configuration away from /etc.

> I do like the conslidation of the initialize_dir code though.

Thanks. :)

Regards,

-- 
Gioele Barabucci

