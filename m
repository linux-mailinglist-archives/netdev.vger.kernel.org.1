Return-Path: <netdev+bounces-150398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0079EA18D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCAD16650B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB719CCEA;
	Mon,  9 Dec 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HIjMhimM"
X-Original-To: netdev@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49E46B8;
	Mon,  9 Dec 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781591; cv=none; b=Ddri+Gi9jSp2eeIx0zUCKPItw51KcuB+kjxHYhPXHG7BjDRDKhiV7lNSQxpfUSyKzCE7Ke7elhH2VqHfu9Bynlfu3lk59zdMnUdk1NbpWa0Kr5eP8FzCSI7tHv8C4HRSuRExNcKHd27V7bTX9EXF3e9PxsAfsj9i+mZbqiVy0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781591; c=relaxed/simple;
	bh=xW7ZmK2B0htEycOpCVgUY8dcJBraRFu06QHIgAgRS74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5YhJIkCOQYCzw9Hy1nLnSGYHfwVg41fGNK+6reVW6K7/7Wbevb9wzaZXL5ikbmYcc1MSUQLbzTRU1q6UKSS3mQCILl3odz5L/GBxkQiE/9kaOZm9KyioK8+hf+3qQd9RpC7Cut+nsf7+yBFs++OH/VD4yzQQWZaY8cjX3IBcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HIjMhimM; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:df8e:0:640:17d3:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 9042060F09;
	Tue, 10 Dec 2024 00:54:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wrtY5C7OkOs0-IdUUzKrN;
	Tue, 10 Dec 2024 00:53:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733781239; bh=SmV0sEeOxNWdfnUsqBc8E3RnQowYN4KxbN37yd34Omk=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=HIjMhimMoBXuxmsVNQoNa25l8d6z1/dm2UK9jcBYoaCseYR34yKIZMYOJi5YKz05/
	 1nXydnBaccaYP7cuKDh1/8esqYaWwfgpabgLJiBBNTwveMxF3ek/yfSB0c4SpmAYOh
	 PaqSVCDauoxdPm+ncN0CVIHkD2LmTTdylF+yNMBY=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2472c4bf-c089-4c80-bb45-31014f4acd9f@yandex.ru>
Date: Tue, 10 Dec 2024 00:53:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: fix group permission check
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20241205073614.294773-1-stsp2@yandex.ru>
 <20241207174400.6acdd88f@kernel.org>
 <062ab380-ee73-45ad-9519-e71bb3059c13@yandex.ru>
 <20241209134430.5cdefa09@kernel.org>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241209134430.5cdefa09@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

10.12.2024 00:44, Jakub Kicinski пишет:
> On Sun, 8 Dec 2024 09:53:40 +0300 stsp wrote:
>>> I personally put a --- line between SOB and the CCs.
>>> That way git am discards the CCs when patch is applied.
>>>   
>> I simply used the output of
>> get_maintainer.pl and copy/pasted
>> it directly to commit msg.
>> After doing so, git format-patch
>> would put --- after CCs.
>> How to do that properly?
> You can have multiple --- markers, you can insert your marker and let
> git format-patch add another.

Thank you.


