Return-Path: <netdev+bounces-201139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524AAE8393
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FE516A950
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BDF25D53E;
	Wed, 25 Jun 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="SRZtoZyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC543A1BA
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856611; cv=none; b=PTN/tblIcTcIp/uOvo0PVxsHOO8hxrQsQq6vF2MhJy130CUkg93vmcWnYob7ualOjqHicQuOsX9HpGAGQN3IMtOE5KNRuBs2vKldKK3XQhP8tM0ZE5WyXeNl29RPp8EfoYTgmldSXCq5X2/Ueoz27I11nokjzeU4c53fMFyv5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856611; c=relaxed/simple;
	bh=X2a6bqPFcCqZOdUd0nAAfcySHkqblc2JtB5nNaZZass=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G4pQyeyeSiMhHX+Vzl3IZ9uqypLWAOHogkRqXzNAhzaZHIqZtYSzRnh0N5qyIxElQeExAa2nmtU6k8nKMPK8mwTaFKTpaDACbHt/6xRcv6oHDEbfM/lvw3L9RFOHcPHvmUAscaDeNFArTUjSut92XOTpLUjKkBcf41U6c8DL078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=SRZtoZyb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so1527602f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750856608; x=1751461408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R67vbOcUZfWm73DIVUMK1L7ghH4UOTOk4lzaOIIxPrs=;
        b=SRZtoZybsEUzO2clrhTmINgsU6cevKwEwVVcvlh9eyiP1+Co4Aar74t366p44JvcUY
         bPsI4oDM90ISY0NHQi47k/vtv+Miqe3uylbUp3BEsiD0uxAtQDicz0qQ5y8tzbBWjDXu
         zrroXO1TVgHwwvP+58PGm9qdb+SLNsSPVA0AO4mQp+151ThY8qIBl+oxwJRlHRwCqYa8
         OMgxRspppNlwcB3lJwYq//4VfqAS2jsMBW7KV7A2Myih/O50DK1320HPcHbMKfIkfB1Q
         DzdAD56W2tcBt+HrlDNr1GhbFFwQDU2DGEVayr8NSamaNI9GuAVh5jLCxMUENJCzHrjX
         u2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856608; x=1751461408;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R67vbOcUZfWm73DIVUMK1L7ghH4UOTOk4lzaOIIxPrs=;
        b=Id7HybenjF4gsdu7j9om6KHf6PYpiaVOW5n1X7gmx9NETSOj3Np9tQo/KhweQJSzx0
         WMr3VPkOtRnAf5ycLLipkod19c3Pxflrc1sCcxyALBiWNLRTzKyzNN4B06fhqHRGpITh
         aifE9iXsv4a9sT5Jhd8HAu6NodjQIukgE7NtDDvN9ZZHKIHSFV9bpCM7sUqw2Q7KWnda
         FOGcty6zulCtX7NpjZomky/aJXrtsiBTby81pIORGjQuoZVS0CKaSmXK7OE6fMdJO2vK
         36yWNCOmKxeBB5zyMfryr4/saUBdpCAAgul6lKKdLPD2V4pgKpXTB0qWcOVP+xTL+2G+
         yjqw==
X-Forwarded-Encrypted: i=1; AJvYcCXGR4XjgocUFhY0ACxAa8PC/hQ0sHq135xfIIwoSxTNIdAKYevnG4PCykU9tgqstT0uQ9Cx7BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqxXjrNwY943Uor9gh1YEiYt5MlRA2ROvo5b5OQ6bTBZLuZQd8
	7Y06mHJbbi7BnmuXehphdEclXUmpDH6nyGtzD7KS537wcrit5YMJVJsz4el6GrI7IDP/0dnNhWU
	V5p8E0w==
X-Gm-Gg: ASbGncu8KZR0tJrE5WrhZ6Zo2Tc33ax3jQaBuByV9ceHqmie6TJhNFvOL4WXPl4FhA6
	OqrW8jobONYGWc8X4E73nb4pqjnLjCYE/tJDXT2asRPGA7y4H6KLEWQVezXIjTCxKJbpbklcREI
	xT9bi+UJvOaljk8F70hTWvLmJMaZ+5CJtzIc6AqJ1vXH87/PsjPmFwD9gIHz0eXElpefHXNadyO
	HTf8lHfEtYajY6lghiDUIOkEMkKAHanEUkttCx1vPdoNzjn5mmjCeqNjkFl8m3C6JgRbg+C+7ZA
	WVKnWAwn2zMjZGQ4u/rJS2xX3d29JMfKtXA9TgkFU5cLQwxhBm4CSYQwSabD2cUq
X-Google-Smtp-Source: AGHT+IFgMJIq/eGyoizczszmR53QE4J3SMmdHR+AgUSfMQ6K9taH4rprzgWuCxaybgUuO0JGEwa4hg==
X-Received: by 2002:a05:6000:2406:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3a6ed5da5bdmr2064474f8f.16.1750856607388;
        Wed, 25 Jun 2025 06:03:27 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0bddcc68asm151660966b.174.2025.06.25.06.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 06:03:26 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <41ea8706-ffb2-48c6-8a2f-5c4c51dc1a0e@jacekk.info>
Date: Wed, 25 Jun 2025 15:03:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] e1000: drop checksum constant cast to u16 in
 comparisons
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
 <20250625121828.GB1562@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20250625121828.GB1562@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

> 1. It's normal for patch-sets, to have a cover letter.
>    That provides a handy place for high level comments,
>    perhaps ironically, such as this one.

I'll add it in a second iteration.


> 2. Please provide some text in the patch description.
>    I know these changes are trivial. But we'd like to have something there.
>    E.g.
> 
>    Remove unnecessary cast of constants to u16,
>    allowing the C type system to do it's thing.
> 
>    No behavioural change intended.
>    Compile tested only.

Wilco.


> 4. Please make sure the patchset applies cleanly to it's target tree.
>    It seems that in it's current form the patchset doesn't
>    apply to iwl-next or net-next.

Just to be sure, iwl-next is this one:
git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/linux.git
refs/heads/for-next
?


> 5. It's up to you. But in general there is no need
>    to CC linux-kernel@vger.kernel.org on Networking patches

I've just followed get_maintainers.pl output to the letter.


> As for this patch itself, it looks good to me.
> But I think you missed two.

Rather: I have not touched subtraction on purpose.

But checking the compiler output - yes, it can be dropped as well.

I'll prepare an updated patch set with subtraction changes across Intel drivers included.

-- 
Best regards,
  Jacek Kowalski


