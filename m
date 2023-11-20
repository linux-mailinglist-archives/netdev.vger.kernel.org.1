Return-Path: <netdev+bounces-49415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C37F1F59
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F76DB210B9
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F6338F88;
	Mon, 20 Nov 2023 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddacDttk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24A36B0F
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 21:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C73C433C7;
	Mon, 20 Nov 2023 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700516443;
	bh=ZBKA/GCLs/tmb/zfGdWfsnHF7Ch0Fck3AdnZ1jAdNmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ddacDttkY4g1j6QzWklwDizHdosj6dO77k2YO3qkXTcixeik0yeVQcayye2ixYIYw
	 qeZv4MOWHdiuC7Q649y8tK/IbvYbK9Ld/+xoP7Nkfg69huvv9zal9tpPWnFejM087q
	 Bskyf0883tpoxQ4shkPsG+rTy6NGhdljI0Z4QC1a89IBFypqykpOzYvorIUQedOIUg
	 BgmSJMt87mGKtUN7PLiISRwNIttpnXZxvW7MbSdhuSD5YU5cp09LTIFTTIjXVf9Y/3
	 SOrM5G/8wZa9TOL5+HQq7CH96WQpADnn6TMEK1BybF5Bwyz73FU/hvnficeW07UqAs
	 134X3vdW2YpzQ==
Message-ID: <40a74dfd-e7cf-46fc-9c79-517ce2d6c51b@kernel.org>
Date: Mon, 20 Nov 2023 13:40:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v2] ip, link: Add support for netkit
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, martin.lau@kernel.org, netdev@vger.kernel.org
References: <20231120211054.8750-1-daniel@iogearbox.net>
 <20231120133037.7b86ec78@hermes.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231120133037.7b86ec78@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/23 1:30 PM, Stephen Hemminger wrote:
> On Mon, 20 Nov 2023 22:10:54 +0100
> Daniel Borkmann <daniel@iogearbox.net> wrote:
> 
>> +static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>> +{
>> +	if (!tb)
>> +		return;
>> +	if (tb[IFLA_NETKIT_MODE]) {
>> +		__u32 mode = rta_getattr_u32(tb[IFLA_NETKIT_MODE]);
>> +
>> +		print_string(PRINT_ANY, "mode", "mode %s ",
>> +			     netkit_mode_strings[mode]);
> 
> What if kernel adds a new mode in future?
> Probably want something like:
> 
> 		print_string(PRINT_ANY, "mode", "mode %s ",
> 			mode >= ARRAY_SIZE(netkit_mode_strings) ? "UNKNOWN" : netkit_mode_strings[mode]);

that is why I asked for a table driven helper. Helper handles the mode
>= ARRAY_SIZE.

