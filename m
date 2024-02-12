Return-Path: <netdev+bounces-70991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC758517CB
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958A4284549
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73583BB55;
	Mon, 12 Feb 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="V+SjbSWU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lo/8IQzK"
X-Original-To: netdev@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D13C694
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751095; cv=none; b=B6T+H2VWolTY30aFcivN7U/z9QgnyX+1Hl7PZ1sGUOqiQ3QxeDij+abiubJW62Ky7qfTqBlyCtVaTGQH9oygIt0HMC6SUSGt++UJU2STG4RolnB51CRFLL0bpVywhA67lb7LSC/J8q4PI1FFiKb5mtPAOdVhnD/3Nv0osBX7xIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751095; c=relaxed/simple;
	bh=PPq9tCVoVHKzwBqLl3xMkedjjMxKUjpo3s8e6wU3ZqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFbqUlqIYglGix8HdFh4yX6EBjIqwZq52Te98eAlpqECVvDt1sD8r98y4cLJwrMlY58xnOeTMHCB8htPO6iWssIitZezqKbtYMyfUxbli6fkxngRr/SZzgQxHh3yC6ZeHqkpYniEBNXjqC94ha+NR+apFW9LWJwWJ/9y2MnJb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=V+SjbSWU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lo/8IQzK; arc=none smtp.client-ip=64.147.123.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.west.internal (Postfix) with ESMTP id 08C692B00950;
	Mon, 12 Feb 2024 10:18:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 12 Feb 2024 10:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1707751089;
	 x=1707754689; bh=nEJKXZshMmrw+OIHDAICOJ5mmFhosD6elSksAcN+XP0=; b=
	V+SjbSWU1hEDrKQRk78voZqOIdShdcY3XxwQRS9QUBu0ZRZ4z4iOXbKUssgb0QDw
	yiFA7yvC+icMo9eP1zciuTEjAVK+WG4NB/m0jh1pfycJZaAvYTEZXjGW1cI4ZbLC
	eWr6ido0qfZRI1YzmE9/jEzHGY2m9HWZqD/xEEB8Yq1cg45/ELQNaxvCIsRkJWZ7
	a+iume5EoiI6n5ApI2khPREAoXgQqNQgoRf44KALutR9TiZ5ORMGN/g7g3NfiXYh
	l5E5YtgdD4kmYciUZmZjK2+p821QvxNBAZk4Nf2rm+c+OtO7EiIeU9zzcwOstVdd
	XuPtRSm7RVllFaP6B4TUdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707751089; x=
	1707754689; bh=nEJKXZshMmrw+OIHDAICOJ5mmFhosD6elSksAcN+XP0=; b=l
	o/8IQzKl2o/9HFUtjAW+2s9WIQ0wha6FspcffUsylWGcasf2Ck9J2DndHi46DsPl
	ppFsQOtbYqvpX12HUbEgg8qCyefiOTHQzrIrPv3ogSIIekmyvgANwG3qHi3MpTUb
	o+QTYnYnvlPiODomdZ0siDXCvMepjFcNj1wj6qPnGqdccvCxFSpDiGpdyZQ4bvQQ
	C+z5PccWc3kfI7jU3aqEIIhcUXMKc5Aa946ashmTFXTyinleEEhHExz28J8E/kxx
	Z+SDn7/sjqUOjGfnwJ2kZHrYbgxKK21ZztVRYFnVIyS2CIZxWhkobp1rZN3Ov+3i
	HLIvapoVFEVdb61LE162w==
X-ME-Sender: <xms:sTbKZdOwIIsZN3j6oMdT3ULIW_Ab_uIi0Xwl1FKe3PPeoAmunet5jA>
    <xme:sTbKZf_3QuBBoZU9Oqjl7sh-BGONO7Uh5wBqtuw5wKPSCK-Mpa4h9WdJ5GCVe6Khz
    DY3XLPu4Pk5VFIVR6A>
X-ME-Received: <xmr:sTbKZcQJx19cpkBxd_yZRptinR5n_YcPuGpbsUuM9iWED3oHeZXKbus6dGcSyiD77b-_sE_irC5WNgbPnjBq3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepheefgeeigfeghfevffefledutdduieeifeeglefhffefvdefgfejgeeileej
    ueetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqh
    guvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:sTbKZZusGNgZvPkWPsofzAjCu2NiR7BaI-6fHNqKVo8vFznjc1a6rw>
    <xmx:sTbKZVeEvPK7oZevfPwiMc7YLVqbRePCbpWo8_XG6dn8gaKe_mWQxQ>
    <xmx:sTbKZV0fRaztqHvIw-1-XobIOvokLiGJfHExPF3tU_M_ddPGZgKo4w>
    <xmx:sTbKZeFqdgwbYYxClibE1Qjrud_OfDzP8wFJvMYAErS8TmzNve1lOIk0eiI>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 10:18:07 -0500 (EST)
Message-ID: <b8297ad5-5962-4d9f-acbf-0bb70a3035da@naccy.de>
Date: Mon, 12 Feb 2024 16:22:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC iproute2 v6 2/3] ss: pretty-print BPF socket-local storage
Content-Language: en-US
To: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel-team@meta.com
References: <20240118031512.298971-1-qde@naccy.de>
 <20240118031512.298971-3-qde@naccy.de>
 <fcee4777-4e46-46c6-8ffd-938b00841958@kernel.org>
From: Quentin Deslandes <qde@naccy.de>
In-Reply-To: <fcee4777-4e46-46c6-8ffd-938b00841958@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matthieu,

Thanks for the feedback, and sorry for the delayed answer.

On 2024-01-18 11:49, Matthieu Baerts wrote:
> Hi Quentin,
> 
> Thank you for working on that!
> 
> On 18/01/2024 04:15, Quentin Deslandes wrote:
>> ss is able to print the map ID(s) for which a given socket has BPF
>> socket-local storage defined (using --bpf-maps or --bpf-map-id=). However,
>> the actual content of the map remains hidden.
>>
>> This change aims to pretty-print the socket-local storage content following
>> the socket details, similar to what `bpftool map dump` would do. The exact
>> output format is inspired by drgn, while the BTF data processing is similar
>> to bpftool's.
>>
>> ss will use libbpf's btf_dump__dump_type_data() to ease pretty-printing
>> of binary data. This requires out_bpf_sk_storage_print_fn() as a print
>> callback function used by btf_dump__dump_type_data(). vout() is also
>> introduced, which is similar to out() but accepts a va_list as
>> parameter.
>>
>> COL_SKSTOR's header is replaced with an empty string, as it doesn't need to
>> be printed anymore; it's used as a "virtual" column to refer to the
>> socket-local storage dump, which will be printed under the socket information.
>> The column's width is fixed to 1, so it doesn't mess up ss' output
>> (expect if --oneline is used).
> 
> Do you really need this new column, then?
> 
> Why not printing that "at the end", in the COL_EXT column, like many
> extra and optional bits: TCP Info, CGroups, memory, options, etc.

I think it's an early misunderstanding of ss on my side. I thought ss
would contain the same number of bytes in each column. Hence, if a column
contained a lot of data (BPF socket local storage for example), every line
of output (even for socket without BPF local storage) would contain a very
long and potentially empty column. This explains why I was settings
column->width to 1 for BPF socket-local storage.

> Here, it seems a bit confusing: if I understand correctly, these extra
> and optional bits are handled first, then back to the previous column
> you added (COL_SKSTOR) to always iterate over the BPF storages, and
> maybe print more stuff only if the new option is given, optionally on
> new lines. Would it not print errors even if we didn't ask to display
> them, e.g. if the size is different from the expected one?
> Would it not be simpler to extend the last column?
> If you do that, you will naturally only fetch and iterate over the BPF
> storages if it is asked to print something, no?

Absolutely, I fixed the patches to reflect this: no more COL_SKSTOR, but
appending to COL_EXT instead. If --oneline is used, the BPF map's content
will be printed following the content of COL_EXT, on one line. If --oneline is
not used, then each map is pretty-printed starting on a new line following
the content of COL_EXT.

I'll send a v7 very soon :)

> To be honest, it looks like there are too many options that can be
> displayed, and there are probably already enough columns. That's
> certainly why no other columns have been added for years. I don't know
> why there was an exception for the "Process" one, but OK.
> I do think it would be better to have a new "--json" option to structure
> the output and ease the parsing, than having workarounds to improve the
> output and ease parsing of some options. But that's a more important task :)

This was suggested at some point. JSON output would be great, but both
features are not mutually exclusive :)

> Cheers,
> Matt

Regards,
Quentin

