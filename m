Return-Path: <netdev+bounces-49419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B77F1FEB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A43282174
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60676374FB;
	Mon, 20 Nov 2023 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YQy4UQfa"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697BCA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aym3hi0ax1r7gZnj6fQ6i+ZPuFL7An7Bxd7dEj+Rbyw=; b=YQy4UQfaF2WIDXnDMMxHfhGYLE
	ImTvn2ACxYOqhqaDiOpcFDg5lsyr8Uu219Yphz21WlFxRugjGTAxxHCMP2pDYvGNlD1aRl6hrKrmi
	LEbZ2CLNhX8dMlsfLXWjxkObOd9Id3fdSw/nEFXhdsbpnDIGs6bYFYpVdczEyL7IA90uMd3iwz8Ok
	DoH20s97s0kjwp6zcq04bRpxtxLHBXrghU2YI19M1uxXdeYfgaeewmKpYB8b+BZb/Vwddw+jHfN99
	cVTJhxWI08azywNyKAqd9n9rrmQwSR9H5x6XlLFngU7mvLE20AyMpRIvfHbVix/xDbQdDWndDim6p
	KcYzYpKg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5COZ-00060a-KR; Mon, 20 Nov 2023 23:05:31 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5COZ-0005yu-Cr; Mon, 20 Nov 2023 23:05:31 +0100
Subject: Re: [PATCH iproute2 v2] ip, link: Add support for netkit
To: David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: razor@blackwall.org, martin.lau@kernel.org, netdev@vger.kernel.org
References: <20231120211054.8750-1-daniel@iogearbox.net>
 <20231120133037.7b86ec78@hermes.local>
 <40a74dfd-e7cf-46fc-9c79-517ce2d6c51b@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8d172a00-00a1-c636-4471-4b1a131a8975@iogearbox.net>
Date: Mon, 20 Nov 2023 23:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <40a74dfd-e7cf-46fc-9c79-517ce2d6c51b@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27099/Mon Nov 20 09:39:02 2023)

On 11/20/23 10:40 PM, David Ahern wrote:
> On 11/20/23 1:30 PM, Stephen Hemminger wrote:
>> On Mon, 20 Nov 2023 22:10:54 +0100
>> Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>>> +static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>> +{
>>> +	if (!tb)
>>> +		return;
>>> +	if (tb[IFLA_NETKIT_MODE]) {
>>> +		__u32 mode = rta_getattr_u32(tb[IFLA_NETKIT_MODE]);
>>> +
>>> +		print_string(PRINT_ANY, "mode", "mode %s ",
>>> +			     netkit_mode_strings[mode]);
>>
>> What if kernel adds a new mode in future?
>> Probably want something like:
>>
>> 		print_string(PRINT_ANY, "mode", "mode %s ",
>> 			mode >= ARRAY_SIZE(netkit_mode_strings) ? "UNKNOWN" : netkit_mode_strings[mode]);
> 
> that is why I asked for a table driven helper. Helper handles the mode

Ok, fair, will add.

Thanks,
Daniel

