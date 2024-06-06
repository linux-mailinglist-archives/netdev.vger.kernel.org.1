Return-Path: <netdev+bounces-101453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA358FEF9C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311601C2521E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880CE1AC426;
	Thu,  6 Jun 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ilP/R8dN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186F196DB4
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684272; cv=none; b=ZZZ0p4QWMQB0H38+hQ+Gg1OFRgxH6q62H4sPSH0xiyDC/UUbAV/0Wt7L87tYjS4YgEQAHfQ7r3BjND1RRzcqB7dD4R+TRygOJBDIwY8rE0rd3WpvjJXQEnYn4RdU2PoYcLuYDA/xRluUChgvycTxcVvPx6qEbkcmbQxdUDPOXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684272; c=relaxed/simple;
	bh=Q9hNx3MC9qIV67ExxyFR040tvh0THXH2b2lqOk/NUcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ssyLwvUM0T/N8PRDGLNdrcKQ12shtA71swfEIzcvSVfB15ROZTD+rw0MOZnThCF0FXbcRZPksXyOu47FyNF/4gkpMSTpGmIioXMsA9Jmf5fICxB2zWQWDMHVdWrs7S6hsMlWqsFiZxrBuqW3SmmQ1XKTd73lcPsqphEq2D7ie+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ilP/R8dN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a690161d3ccso103663066b.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1717684269; x=1718289069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktj6aT/4mxxGwsRnUn5pU5ZN8m/vlGHJg1jius/H1IQ=;
        b=ilP/R8dNh+onNOBY++aRbraoRtflYvhEUvmBPh9nMphrVhsNkTVOFme5dGFdxM2ihx
         L+17PBuOGrm3D9AkuNyO1XUpSzj26ElSTs06MUbbqrE+ROuF88J0ulGK2dHL66iZGvFZ
         SSNsebfBvefBQ3DUbvB5lN/n7QVnPeP1ra+hSDBlYVxglWCQDnoFIN7TXKpcCUoxdWAJ
         p86j5isgaUkkA7oKmqnO75NuCbgMz0lhgLZHWs/3v5Fa+AfjyHMpobbRcd0V2zFfRVew
         Wsr3AkQtFk2ae5n9BZj5OucddFEiCowd09de/7woINUSyb9erzcAmoBtV2WhTD9y9Puw
         9a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684269; x=1718289069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktj6aT/4mxxGwsRnUn5pU5ZN8m/vlGHJg1jius/H1IQ=;
        b=ZEeDxd6AZEzydB+NLBVaJljtKHWq7n4LfFMKZEZml8/yX/SDK7owc0HJi6A/ioPlp8
         Kq1XFDaZ96xSCZV24Z+uSgkdFoszRebc2soF7zwjqi26ren3W91QREI8VKDAP/E3Sfkf
         trItHxs5Y68c9VkqZvLay8HM78VEPXJzk8/2gvAEuq9bAF9SzXEH53dM+hzQd1EqPznD
         +66mdq4quwGQemfMmYCxwuda183DSbh9qeGAvnUE6szSN7sfU9O78KFesxkSefJkMnY+
         e/stn39WRptW2iP8UcjJ2tmVoTcAkfpqAoc+3/TH0Gg8EAjf8zz7Pp42qgXTvioAC165
         w2nw==
X-Forwarded-Encrypted: i=1; AJvYcCWzypuTu6S6wWSJhr91/VJvvEWqEEdXU6SDY3LPs9xrn4NiowIQD7GeFDjpXBTZTN1fTX+A+XtrSi4OKFXXLT2tJ17nRTLm
X-Gm-Message-State: AOJu0YzzWRo+3iqdYs2jLip63AW0rFugxR33F8wrv0khEs5EMRjHLTPo
	8CAjBsmGfPRF8Tku0u9wi4VKhaff9zbGeKyqnyBtreg5XWirTmc4i2KFRIORduk=
X-Google-Smtp-Source: AGHT+IGfxO5oNkFoxTpRUdc5ZfmrzS6F9lQcbjQ7NCK9BZZjdnPZSUfJI1Ldh/IvgobuKe+ik9leGg==
X-Received: by 2002:a17:906:fc01:b0:a59:9dbf:677b with SMTP id a640c23a62f3a-a69a0022d72mr415399666b.48.1717684268909;
        Thu, 06 Jun 2024 07:31:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:82d:3bb6:71fa:929f? ([2620:10d:c092:500::5:a296])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80580f71sm105677966b.26.2024.06.06.07.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:31:08 -0700 (PDT)
Message-ID: <a8ac00ed-4ec1-4adf-ad37-2efa1681847d@davidwei.uk>
Date: Thu, 6 Jun 2024 15:31:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] [PATCH net-next v3 0/2] netdevsim: add NAPI support
To: Maciek Machnikowski <maciek@machnikowski.net>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <urn:uuid:d06a13bb-2b0d-5a01-067f-63ab4220cc82@localhost.localdomain>
 <708b796a-6751-4c64-9ee6-4095be0b62f2@machnikowski.net>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <708b796a-6751-4c64-9ee6-4095be0b62f2@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-05 12:38, Maciek Machnikowski wrote:
> 
> 
> On 24/04/2024 04:36, David Wei wrote:
>> Add NAPI support to netdevsim and register its Rx queues with NAPI
>> instances. Then add a selftest using the new netdev Python selftest
>> infra to exercise the existing Netdev Netlink API, specifically the
>> queue-get API.
>>
>> This expands test coverage and further fleshes out netdevsim as a test
>> device. It's still my goal to make it useful for testing things like
>> flow steering and ZC Rx.
>>
>> -----
>> Changes since v2:
>> * Fix null-ptr-deref on cleanup path if netdevsim is init as VF
>> * Handle selftest failure if real netdev fails to change queues
>> * Selftest addremove_queue test case:
>>   * Skip if queues == 1
>>   * Changes either combined or rx queue depending on how the netdev is
>>     configured
>>
>> Changes since v1:
>> * Use sk_buff_head instead of a list for per-rq skb queue
>> * Drop napi_schedule() if skb queue is not empty in napi poll
>> * Remove netif_carrier_on() in open()
>> * Remove unused page pool ptr in struct netdevsim
>> * Up the netdev in NetDrvEnv automatically
>> * Pass Netdev Netlink as a param instead of using globals
>> * Remove unused Python imports in selftest
> 
> Hi!
> 
> This change breaks netdevsim on my setup.
> Tested on Parallels ARM VM running on Mac with Fedora 40.
> 
> When using netdevsim from the latest 6.10-rc2 (and -rc1) I can't pass
> any traffic (not completing any pings) nor complete
> tools/testing/selftests/drivers/net/netdevsim/peer.sh test (the test
> hangs at socat step trying to send anything through).

Hi Maciek, I'm trying to reproduce the issue.

Can you please share how you're setting up netdevsim to pass traffic?

> 
> Regards
> Maciek

