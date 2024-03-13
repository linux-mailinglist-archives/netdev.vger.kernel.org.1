Return-Path: <netdev+bounces-79719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74087AE8D
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFAD9B260E1
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0AD60269;
	Wed, 13 Mar 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="rtU0sIod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06225FBB7
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349129; cv=none; b=eGZAjXUPh7VyqrvOsuxU0q9vsoyuLvN+hSD3h2RAxlmnyu25T2qf6ClCVoFV80HFponz9oJtZ8qvnnihnWp4KzgYHh2QjZxEwf2+wgvJIXStGbZBZlZA4tP8b66bWrQD/PxKQ0ZKBhIiM5Uhcl09au8bSJemFIxwmQklJrcmPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349129; c=relaxed/simple;
	bh=Kvr//MqVhiOJN+KvnnlFv/ncKep8ga2do2SmFwdts5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoL7GFTdsfbluilgNLRpLSjSViR+1Qpo8HtNuZlMrOLLJ11TfLuQsGL9bF7GFb9TDrAgA0H5zb8oyoRS9laCB/H3GaVt8Kq1qHJ/TJQ7GNyigmG8XEl/O2z5GccxoSh3OLMJ2w2dIfEU1Ov5oosuJlfAy+QlHgD/5D54D9BSv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=rtU0sIod; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e959d8bc0so3518391f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1710349126; x=1710953926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUSY8VOhsnHhhVX66Hs77t3JZJvvVaxYdtkEfIfHjT8=;
        b=rtU0sIodivpfguI86vx4N1xw16NYk+R4swL3gvWwrqe5gHDKsOKqpAMTF4H2tvz3eP
         aBpZZjY+/YPcF+imZiuya+MUwUzYqzE5i2MirKbOe62cppgAAa0swp4AOIfHo3rtwZqG
         XmYRh6OooIZeS0XLfxox1NQzEWaAkg3zzjuGYaX46268d3ynk/wkFy3bd1QLiMFWr2S2
         hGREvD9oTSdsgIjR0lDmzH/1uebtthpeEj1f3sgBGvHtA5WrvoqGNBoy9QpexSJKmCwd
         gjuh8blHrsF4Eo5TwiV6L10sUPOoAxW+D1VyNBjgTbEhoyBLuRRxSss9Al3fJNP3PX0m
         biag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349126; x=1710953926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUSY8VOhsnHhhVX66Hs77t3JZJvvVaxYdtkEfIfHjT8=;
        b=DhhOfvfk4KohXAay/JRWZN+LicYpNCOY5pJeEVsCv2sJQ+jnb4QPZ4rY3ODOfcvVkX
         PBHO81AAWmdij0HUgP5L3VsIb47/uJrAhBnI/CtBPc8APKMqfKVA5UmrQZFlEop64tsh
         EDRylaZcSR2IF+uVQhN6bcdLC1UaolNhAYOQwR5bwIa9VyXgtRXJJuNktZe3CofvXNg4
         uGO0uPGExfIzj/CFkefF0K1H7a9nwu8iX4RSIjGZwBAIAdZn35VuKA7Z68F8iyKl6IJ1
         8yP3lLD2J+41HMOuJOEU1syV4mUip3+X387L0ekMx7Rm1Rg4lhOJ9ENx2jpJpErUtwO8
         JYlw==
X-Forwarded-Encrypted: i=1; AJvYcCXhiGgsf3glmrr4OfxfHmuOHtcqLcCB+WGzIgLujFda/CM77PeEKCtu/qUSMjevHwMEi4dd2JuloUk+1w2xPHbK8KnhMZQZ
X-Gm-Message-State: AOJu0YweNQFevhn1Ce96Q2p4Ljzop/lK9EK8yaLJsPrU32yWPW3j1C9z
	PyIeiGfC4pFPnShTXQ0/FAsCp/x6hl9KnC8eLDt0YgKFz1/FK9r4kTBWa11cZfQ=
X-Google-Smtp-Source: AGHT+IHGl9A4GLGQExuyiiqVGjbS8yK+eCwPHbMACV2mw+hezse0FPAgyBEdstc8ZNKlg6FW6zjAkQ==
X-Received: by 2002:a5d:59af:0:b0:33e:b758:a039 with SMTP id p15-20020a5d59af000000b0033eb758a039mr1769471wrr.28.1710349125687;
        Wed, 13 Mar 2024 09:58:45 -0700 (PDT)
Received: from [192.168.0.106] (176.111.179.225.kyiv.volia.net. [176.111.179.225])
        by smtp.gmail.com with ESMTPSA id q4-20020adf9dc4000000b0033b6e26f0f9sm10344891wre.42.2024.03.13.09.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:58:45 -0700 (PDT)
Message-ID: <6f3a60a7-db29-4a7b-afec-aa5c5fa78c93@blackwall.org>
Date: Wed, 13 Mar 2024 18:58:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VLAN aware bridge multicast and quierer problems
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev <netdev@vger.kernel.org>
References: <123ce9de-7ca1-4380-891b-cdbab4c4a10b@lunn.ch>
 <5f483469-fba4-4f43-a51a-66c267126709@blackwall.org>
 <0f752b89-bc4b-40cf-bd4d-ac4e7d3fab2d@lunn.ch>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0f752b89-bc4b-40cf-bd4d-ac4e7d3fab2d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 18:56, Andrew Lunn wrote:
>> Hi Andrew,
>> Please check again, br_multicast_rcv() which is called before
>> br_multicast_querier_exists() should set brmctx and pmctx to
>> the proper vlan contexts. If vlan igmp snooping is enabled then
>> the call to br_multicast_querier_exists() is done with the vlan's
>> contexts. I'd guess per-vlan igmp snooping is not enabled (it is not
>> enabled by default).
> 
> So i have the test running, and i see:
> 
> # bridge vlan global show
> port              vlan-id
> brtest0           1
>                      mcast_snooping 1 mcast_querier 0 mcast_igmp_version 2 mcast_
> mld_version 1 mcast_last_member_count 2 mcast_last_member_interval 100 mcast_sta
> rtup_query_count 2 mcast_startup_query_interval 3125 mcast_membership_interval 2
> 6000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_respons
> e_interval 1000
>                    100
>                      mcast_snooping 1 mcast_querier 0 mcast_igmp_version 2 mcast_
> mld_version 1 mcast_last_member_count 2 mcast_last_member_interval 100 mcast_sta
> rtup_query_count 2 mcast_startup_query_interval 3125 mcast_membership_interval 2
> 6000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_respons
> e_interval 1000
>                    200
>                      mcast_snooping 1 mcast_querier 0 mcast_igmp_version 2 mcast_
> mld_version 1 mcast_last_member_count 2 mcast_last_member_interval 100 mcast_sta
> rtup_query_count 2 mcast_startup_query_interval 3125 mcast_membership_interval 2
> 6000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_respons
> e_interval 1000
> 
> 
> The fact that 'mcast_snooping 1' indicates to me snooping is enabled
> by default? The test case does not change any snooping configuration.
> 
> I will send you off list the test script.
> 
>    Andrew

Oh there's a misunderstanding - this is the per-vlan control of
snooping. You have to enable the global per-vlan snooping for
these to take effect (mcast_vlan_snooping).
e.g.:
$ ip l set dev br0 type bridge vlan_filtering 1 mcast_vlan_snooping 1

You should verify in ip -d link sh dev <bridge> that mcast_vlan_snooping
is 1 (enabled), it is 0 (disabled) by default.



