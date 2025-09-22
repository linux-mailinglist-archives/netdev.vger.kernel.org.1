Return-Path: <netdev+bounces-225412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1959B938AB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817404439A9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B062F49E3;
	Mon, 22 Sep 2025 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJRe8viv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8928B415
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582582; cv=none; b=NIYxp31tpW6Wkq9jxriBBCuT3sdwyCfamYHX7QkKAxtHpy1VriPheUrwqDhS22QM2dqkbjoZO8dw/rH3c42wSmzjnkazNgXxWkqfyLMHtPFmKmCWweLM5PzpNkXxzhWlfBzvmzns7C5UDKtG+0o6GHv1o4wP9tL12QqmuA1GAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582582; c=relaxed/simple;
	bh=SR1YSDVk72Ac79Rt62TaC+tyWYxevuFUSVR+M8wpmOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qvquns5FYcwLXcPhu9lIC8x1R4s20wzkNnRCJswANgAgjPyz5iN7tjwCEFWPgFIydbG3gnuME+g3ZCBtpGZ+oUvBwZBwtNcH85zaFQFnzXObhqrYRC8GRFns0H0CYb6yuhVZs36MQWdwkHY4+9tXolf0manMSiEQKUtz/G2+HO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJRe8viv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42571046185so13778575ab.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758582580; x=1759187380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+HFoKdy5W3LPvxQejufSUXVREww3CqDNmPOnTHZ5FY=;
        b=PJRe8vivVsrVwjucqnVTBKQbALdwh9qitqJj78FHWEsWaD8PFi8gsRNkO2IwIRi9QW
         XnKfVAWqX12HXJ3Lq3M8aTWPm/sR0HmKivBild2WHUUR/D6UzUBhZiWeFH5dp95n6bTm
         Z1M8lODrOWkb8bdeNqYnfot9qPFke1339dwYmAfyDb3P3dGxb9bTsWkiUFmQmqKAaSml
         QoZ+xzSerh/gRc+e6FTlQvXkCrvphIU+7GN4oGcpj9pHc+BFA3mgk+3UL8X3eWypxxAt
         ZIp8h3HpkjgLwr36Z0LDWPlRNX5X2qjNM430CGmY1W5vdKNsSwS+bQIF+713tkkza//V
         +8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758582580; x=1759187380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+HFoKdy5W3LPvxQejufSUXVREww3CqDNmPOnTHZ5FY=;
        b=s0+j+5oJ6KhBlueLoNQzNioEwnSPj1VxCxf6fZFu5aSP+FYtFTQJOJZ7k4vqRY84Bj
         mi9WcK4G/soKz1wM+t9oqyLPGZpYQBTbytwjxK4iZ6ooLFS0ACSRglScsCKCHteTsouX
         p905tDedvmDoq9hpAY9nYEOa0esOkIsd0Ofu5Y27fEhr5TCk9rqPA7+rUSlo9UMJ2H7o
         F6+42oNVajdZosrO3WvB3eHYkFXFZK9Lw+1G3gelW5RdFHXb+OzGUgaVuuRC2kmRdFlX
         fg/E5jwuVeT3kRYkvRRUm2qZ+VblHiOWJSmSenMhbMrchiwOsKH7nCz0MWWoU++/nb/p
         cvpw==
X-Gm-Message-State: AOJu0YxBVj4BQaUhQuivci0MQqexLhMw10uaA0buslFlUa4dreIbNITP
	Zcc323TrxO2spu9zY22/Pjcd1vbYRFnowiQvjTBiA3WJ+gK0eRPTVnU4
X-Gm-Gg: ASbGncvVjUZ9teP25eG6yS6KkhXUE9e0bt61WOdi91/HaI8v8dgW2nYwCIH+/45qYtp
	iqRM2vErVSB/MymAzF2vXuGFiGZ0W++mpTXkesuLPwbdAEb13i1dyx//uCNeKOAg/9VAKxN9nbI
	UpX7FjK0/3ZFtJxJj8+fptSL3rDQSvcTcIcE9ZYbw5lBB+xP6sYZf/3HEGKTDJ90sbsTAJ6//cU
	bPshW9OkIkBu/nnDtitp6TcRWCPg8G6RI9z8kv80gulaKO+5Mv20C5TYTxxgYeh8WHXDk8foMYn
	fYZPyshoduKPtrPVGjI3lr5kKzoDJVrZH6n4zNs54P7RDEXxqX60JHK58E6Fek5zItkgLFaCOT5
	esRBls/YjUrJ2QyhQsKjzcjrSjs04G3s7O9D31D0FCHKVPbiCePzwvjzLNjrfbB07zkp+gP2/GX
	zBB43kkNzm
X-Google-Smtp-Source: AGHT+IEwDrJvLj4EonZV19J9oMnOgfWowrItAnj4aJ1C1fBKonV5CHAR/86DPLhdiTZ6XMe4FtznXg==
X-Received: by 2002:a05:6e02:3e8e:b0:424:9926:a97b with SMTP id e9e14a558f8ab-42581e97836mr10365785ab.25.1758582579867;
        Mon, 22 Sep 2025 16:09:39 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:d15f:cc0c:4159:1911? ([2601:282:1e02:1040:d15f:cc0c:4159:1911])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-53d3a591031sm6343918173.4.2025.09.22.16.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 16:09:39 -0700 (PDT)
Message-ID: <25ea5933-e917-4852-8744-6351d45f9824@gmail.com>
Date: Mon, 22 Sep 2025 17:09:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND iproute2-next] ip/bond: add broadcast_neighbor
 support
Content-Language: en-US
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
References: <20250914070609.37292-1-tonghao@bamaicloud.com>
 <8eba0896-3156-474e-8521-c345d6d2e11c@gmail.com>
 <9DB0492E-33D8-4478-B228-CAE5AEAC2D2C@bamaicloud.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <9DB0492E-33D8-4478-B228-CAE5AEAC2D2C@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/19/25 3:01 AM, Tonghao Zhang wrote:
> 
> 
>> 2025年9月18日 10:45，David Ahern <dsahern@gmail.com> 写道：
>>
>> On 9/14/25 1:06 AM, Tonghao Zhang wrote:
>>> This option has no effect in modes other than 802.3ad mode.
>>> When this option enabled, the bond device will broadcast ARP/ND
>>> packets to all active slaves.
>>>
>>> Cc: Stephen Hemminger <stephen@networkplumber.org>
>>> Cc: David Ahern <dsahern@gmail.com>
>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>> ---
>>> 1. no update uapi header. https://marc.info/?l=linux-netdev&m=170614774224160&w=3
>>> 2. the kernel patch is accpted, https://patchwork.kernel.org/project/netdevbpf/patch/84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com/
>>> ---
>>> ip/iplink_bond.c | 16 ++++++++++++++++
>>
>> you need to update man/man8/ip-link.8.in under the bond section.
>>
> No option descriptions as follows were found in manpage. There is only a description of bond_slave. I don’t know where to update. 
> 

ok, looks like we are missing documentation for bond arguments.

repost your patch; no sense holding it up given the current
documentation hole.


