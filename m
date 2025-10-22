Return-Path: <netdev+bounces-231574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C522CBFABA0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57A11504DE2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7D2FF16B;
	Wed, 22 Oct 2025 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gaNqaGBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3B2FE59B
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119943; cv=none; b=rW2kIWCctZG23lOmV4o5uojcWjbAkTxijzQW+9s9b7sqKiAnwQblySy4TZmo6TJ3jQwWHKpuy+wEnoi9Aqac1ImX7ss7fxFr8nKWwO2EhJzAenJVhow3CZGvu+2o86hJtNFqlcZN7xKxjB4hKFAb0aEBK1HR+vm94AWtIfB9Re0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119943; c=relaxed/simple;
	bh=KaczBMCVSo8E8GAhgih1ppyG0a1tcQb6nFPNBNW7DRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1dZCeQoG6mnhzLhC9zXavOFv0jmgpxgHgnmw/wlyloUTZjlfzn+Qjcg4+Fp5Of1V2vrvsr2UOGtlSEzMKtKA0iC2C8a3NcwS+setwfG4lpp5o/te78oVkJKspmkIYi6Hj0NuK7j9Vm2BHsSmWyuPmkuP22M6U7sWfSmgPQCEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gaNqaGBX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso47888745e9.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761119940; x=1761724740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFYdyU/glg7sl7RbwsHpqkuatNUumTfQgUBn8W9ze4k=;
        b=gaNqaGBXDaXbduMQ0VNaYdzAQRxZ0Uagbe8MbIvebahOJX3q49dhoGI+3ITn04OCnM
         oZxvzWZhLkvEl+hzVTbyZcJXP1dyRyJYsbe6Nt9iSn1CEPgRemwvoy00BH2v/TikQI3m
         R6nx9N6CFXUsOdFR3OptsLrHh6jB/g1/dIcZONmAJoZgB+5qCaZviKw56V/mjWsu2P86
         qXiie1Vwot3B7IeBDy/1h4uvl3biKPepdJTBWb6y/yOSQNuoK3/BuFoEbTwHElb8NzeJ
         jR/VfukkKMJrrtUjp76mGQfdMimYQLIr2eye5cPrEs9CNxPzqc73Y1/ElGiqemwAO34X
         YwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119940; x=1761724740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFYdyU/glg7sl7RbwsHpqkuatNUumTfQgUBn8W9ze4k=;
        b=itZKIfdT97gmfrZCjga/HDvGpAPIYnZfR4Yg3Hzbd5Vppr8BoNfbjJkQky9ekngbWI
         lHAxrjHgEc83meVYqbnI9Y9i6Dtd/f+1oJ0UHmzcsg+2Uwwx52Dq9s2ILcFKEaot2PiY
         scna6E2GCwwWXxla580cFBeYb3SrYxyl3/97rzNczhmd5XOo1koSpLqXNyDYhmwBat8y
         yYE+w5DW9Jv6uNwYPJRSAsXkM3f7cZeC9C8qmu7K3fqwOvAeixMlvBOazsWau7XexBNm
         8pxSBsuwVRcCvra+tl87GOZ+DfXoJZmDVT58xrufSElrPJ/GRuq0DJCZi5zfAwWjKhZy
         iOiA==
X-Forwarded-Encrypted: i=1; AJvYcCWm3g0jTz33TioA4DxC72ALayy/oDUsqds6ONAlDnf4E4iAhEq9coi7WazrFiPjFgu5FZRjRMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3OP/ZulofT58ublBUrL0tn1FDWI3lQWBddbW6+rX5oyFTn6w
	WpJLCEnGq25x+qnENmMPHd/f0BvSDQ876j+KqAQcVqEwWEyo5nzsTf3VQ0h/4YMRbxw=
X-Gm-Gg: ASbGncu9d7aMnEMnBYEw3+xLtQLpoqbba1zmC4goA+Xe0+xkviYteGap2srmqS7gHlq
	kTaG3kd3yW0pQBwYYPsA4JU4xQIZZsNq+HowoJvkevUnZ51efUZ9hz+Y7RzeRMqNPL1YTP1vMdK
	LWG7kxH49oNS17o7VR0A1dYjYNRjRh4GEexEddwPp/zBRFM0qBjR9z09Lkf4HC65AEK7Wcln2es
	pLzgEOWKMXb9E1wM0ENoGeEcpp/28t6CZfpnAE8PjlFKSlJ0Q4qXZqny7PKSvjqa6e+mhEdxhXK
	JW79pQlvJUzz1WG8en/fzv1gczSlVDtXh7E4soqEjhGUWlegmAB56uqBkk+DW77WkSTwb9lrpij
	wz6x04X0xouCnhthrM6JjJhROZiEE9WizvF1TnUyr6yQmnm3oe6bZz9wYtyC71xc6J9uBU68MuE
	3VrOlwQ6t/eJhtKRdE3kxr8e47kRzI9Xf530OKQ8Oi6qI=
X-Google-Smtp-Source: AGHT+IGpOXlGpshXPJscBFg3kXgTW2ZV1U65opkxir+ofQ9dHjoYOdKb0EQ6iu2fUKVd00yHCcNGkA==
X-Received: by 2002:a05:600c:4ec6:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-4711787bfe8mr152128615e9.9.1761119939787;
        Wed, 22 Oct 2025 00:58:59 -0700 (PDT)
Received: from ?IPV6:2001:a61:1373:ee01:2756:594b:8e92:5d4b? ([2001:a61:1373:ee01:2756:594b:8e92:5d4b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c2c9dasm32452465e9.4.2025.10.22.00.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:58:59 -0700 (PDT)
Message-ID: <b3eb1a6f-696b-4ece-b906-4ecd14252321@suse.com>
Date: Wed, 22 Oct 2025 09:58:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Michal Pecio <michal.pecio@gmail.com>, yicongsrfy@163.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
 <20251018175618.148d4e59.michal.pecio@gmail.com>
 <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
 <20251020182327.0dd8958a.michal.pecio@gmail.com>
 <3c2a20ef-5388-49bd-ab09-27921ef1a729@rowland.harvard.edu>
 <3cb55160-8cca-471a-a707-188c7b411e34@suse.com>
 <fe42645d-0447-4bf4-98c5-ea288f8f6f5a@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <fe42645d-0447-4bf4-98c5-ea288f8f6f5a@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 18:33, Alan Stern wrote:
> On Tue, Oct 21, 2025 at 11:13:29AM +0200, Oliver Neukum wrote:
>> On 20.10.25 18:59, Alan Stern wrote:
>>
>>> Another possibility is simply to give up on handling all of this
>>> automatically in the kernel.  The usb_modeswitch program certainly
>>> should be capable of determining when a USB network device ought to
>>> switch to a different configuration; that's very similar to the things
>>> it does already.  Maybe userspace is the best place to implement this
>>> stuff.
>>
>> That would make usb_modeswitch or yet a new udev component mandatory.
>> That is the exact opposite of what we would like to achieve.
> 
> In the same way that usb_modeswitch or a udev script is already
> mandatory for a bunch of other devices?

Arguably broken devices. 
> I agree, it would be great if the kernel could handle all these things
> for people.  But sometimes it's just a lot easier to do stuff in
> userspace.

Well the kernel does handle them. It just handles them wrong.
You are not proposing to leave devices in the unconfigured state,
are you?
>> That is probably not wise in the long run. If the device whose driver
>> we kick off is a CD-ROM, nobody cares. If it is a network interface,
>> we'll have to deal with ugly cases like user space already having
>> sent a DHCP query when we kick the old driver off the interface.
> 
> Doesn't the same concern apply every time a network interface goes down?

It does and that is why spontaneously shutting down network interfaces
in the kernel is a bad idea.

	Regards
		Oliver


