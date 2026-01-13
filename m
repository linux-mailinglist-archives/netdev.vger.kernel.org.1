Return-Path: <netdev+bounces-249478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7176ED19B83
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F81A301AE16
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A62D94B2;
	Tue, 13 Jan 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfLa5wwy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqCr87+z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E772C21C0
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316773; cv=none; b=gNvTzCgtlXbYNQ01+wj0tkWployk9Jc+KozLLWdxtO+ydxOmUclDMhE7MXGzKOZpy51QerbhudW+VCQIfR23EJ9ir17rMYlJGIKIn+gkM29sA6SanW3/GAGXpOAekQUbZWi29EwWJ6BGmRqAGVmbYwSWpflTHCPe3HOLzHA5Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316773; c=relaxed/simple;
	bh=s+CuNh8nN+c3duGNNJwpTmjqk55xK0VXgzFyC6AyLv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5U6ZrcmPW3QU9SzFMnSUTSGbPdqD9FYgqnr9nh3jQDlmo494x/vZjcPKkaEJJv5KCbPbhvEKxTq0HH60mwbbjnpbBp4A2ZWBl8QVUb9Fv9nrkjhvOXY1grB8C7YtgMtvsfPVhJRFXlcLSA0pbapQo4Yvott9uN8BmCwI7zJye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfLa5wwy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqCr87+z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768316770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDwCw69rb94qC+LZlvI4uRVvjhNJWGT4TLlWN2hOUDk=;
	b=QfLa5wwyjdgveQkQcnLwvBJESnm3VPjQpzyYlI5HhI8X+NnnmBfd+LkYufa5uq5sMvKtJ2
	eFbSeMhO1J/Eb953raSf+6REVOQwEC2PTU8JdpwRp9DM4GdYy/aRpLd6m6ImGE1OLckxKZ
	V4P90qVKCyN5HCtFhyR5v98ukYI/7ZM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-VC9IgKsdNVaBxkTI9c1qlg-1; Tue, 13 Jan 2026 10:06:09 -0500
X-MC-Unique: VC9IgKsdNVaBxkTI9c1qlg-1
X-Mimecast-MFC-AGG-ID: VC9IgKsdNVaBxkTI9c1qlg_1768316768
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso59656975e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768316768; x=1768921568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDwCw69rb94qC+LZlvI4uRVvjhNJWGT4TLlWN2hOUDk=;
        b=aqCr87+zwyj2GnwEHpnEbnGq4QhxwM5kFXyv43AoNfNwnVrZElvRjvUBAuzpExUFcF
         kdy8Fo0sv8HZd+l8wSYA/oH4X/rBhrVBq3oqopvD8vvrJIhFuTjQ/3POhQ0FCyYqET6t
         j47fTm2/AmzFIjaxpSa6SNNCfOyU7coiGxk/56vLRenPsbv/0HOeER5/ib1raIRLQfak
         jHnla63HZju/YMvKGCTZpGcr/PeFfMOhKIVhH7gWRbVk77IUfo9EW62nTreW7kadj461
         lBsr88h0J7ctmgKoZ4tCxKhLokLSo+ilB6+6rUU8O+BjfN53X5YLlWduAuhWTDWz2Qkg
         gQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316768; x=1768921568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDwCw69rb94qC+LZlvI4uRVvjhNJWGT4TLlWN2hOUDk=;
        b=nQhGz9aYKNDT+w8ezZcW3m4JOn0RhZL5xOprt2SdQjwRN5eTARDhbmyyRQ/TnVQHs7
         A/tCnKTwchQKN4m/GVXtrFyEYbfyOSm2YhfDsL9m9+X+aG8rCLHCjtlaL+degSIP8+Zs
         fGm+W1/xms202sa4k1ko9rA0bFMkwjJS0OyoYLi1JgLZMHE3DNXywFtbrfHl4kU01zou
         LehO0bGIJIWxACEcF5MAZqKUuFl8DBsIAMntT5pkztrQM7KxxPNG+xbZst4wYxn0Nqn8
         06u43JKoz6m3IYguRtHOFNBLBOUq43qE/9Aywcd4Z7omJwkx2QvGkBl9KUUHKrpQMryi
         veRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDfL2mb7b90A3pTU9U6ni031JOiPDdEe1NLGH03VD8grtB5xOwI1UJWJh4y4OFqi/OZ5Nfm8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZeQBj5OLKAPRRkw7sDNMelNJiq9+kTCaRfhEaw2d1GSqRmvy
	PrTg7GTQVXHc87MFcKSMM3KWvvP7xFBLbbtuOCHhhFtCT0UiVtjWtVedRjSik0R88xMG4vhEdWh
	s78qEcx2rW2ZjXMGC0p4zWHV275ZoNknN8VoN1S1FPoE2fACCkySCWbjbaQ==
X-Gm-Gg: AY/fxX5Bs4tYrDGqIhUNaP3VarJbxqhUHKy2EHxWR6CzQjjOoKSBTK08a42pqTctr/L
	wAiIMq2qMHlbNHaC1V9k+nNnIX8e2DilYHJldlrPh/Uon2YPYn/RS4a2d3AMzgegGmyv/SgGLHL
	vaBaeJSnd5vsAD+DCsXwTuDhaXV36r/fZ+vLSDsiqt1MWUB4fxkoLt9FjcCtBdIcOQ/SwubAEtu
	xJ5oBgTSqjqyUMXINzohdXEFmiZrVf81MlyjzQP1QrHkccu/j2D05WCHjdAtNlHyxx6J+0IfTbf
	SXv5ga0aR9apdJIBOkc994pAX4wRVdcNkAiBSjpUj8VpgRY1XYkDQ2tNOlBi0KkMLf5QROcS1Pu
	b93NABx8g4+aa
X-Received: by 2002:a05:600c:3556:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47d84b3b4eamr286985125e9.17.1768316767873;
        Tue, 13 Jan 2026 07:06:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSrRyHk6thUAyQczy6/cI8N/GQqeafVlq48pG73G8dfSC1NPPmKMlwELspqzYKhAl9nUej4w==
X-Received: by 2002:a05:600c:3556:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47d84b3b4eamr286984645e9.17.1768316767454;
        Tue, 13 Jan 2026 07:06:07 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee1189f5fsm2255445e9.2.2026.01.13.07.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 07:06:06 -0800 (PST)
Message-ID: <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
Date: Tue, 13 Jan 2026 16:06:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
 <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
 <20260113093839-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260113093839-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 3:39 PM, Michael S. Tsirkin wrote:
> On Tue, Jan 13, 2026 at 03:30:00PM +0100, Paolo Abeni wrote:
>> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
>>> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
>>> along with the following warning:
>>>
>>> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>
>>> This helper creates a union between a flexible-array member (FAM)
>>> and a set of members that would otherwise follow it (in this case
>>> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
>>> overlays the trailing members (rss_hash_key_data) onto the FAM
>>> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
>>> The static_assert() ensures this alignment remains.
>>>
>>> Notice that due to tail padding in flexible `struct
>>> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
>>> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
>>> offset 84 in struct virtnet_info) are misaligned by one byte. See
>>> below:
>>>
>>> struct virtio_net_rss_config_trailer {
>>>         __le16                     max_tx_vq;            /*     0     2 */
>>>         __u8                       hash_key_length;      /*     2     1 */
>>>         __u8                       hash_key_data[];      /*     3     0 */
>>>
>>>         /* size: 4, cachelines: 1, members: 3 */
>>>         /* padding: 1 */
>>>         /* last cacheline: 4 bytes */
>>> };
>>>
>>> struct virtnet_info {
>>> ...
>>>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
>>>
>>>         /* XXX last struct has 1 byte of padding */
>>>
>>>         u8                         rss_hash_key_data[40]; /*    84    40 */
>>> ...
>>>         /* size: 832, cachelines: 13, members: 48 */
>>>         /* sum members: 801, holes: 8, sum holes: 31 */
>>>         /* paddings: 2, sum paddings: 5 */
>>> };
>>>
>>> After changes, those members are correctly aligned at offset 795:
>>>
>>> struct virtnet_info {
>>> ...
>>>         union {
>>>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>>>                 struct {
>>>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>>>                         u8         rss_hash_key_data[40]; /*   795    40 */
>>>                 };                                       /*   792    43 */
>>>         };                                               /*   792    44 */
>>> ...
>>>         /* size: 840, cachelines: 14, members: 47 */
>>>         /* sum members: 801, holes: 8, sum holes: 35 */
>>>         /* padding: 4 */
>>>         /* paddings: 1, sum paddings: 4 */
>>>         /* last cacheline: 8 bytes */
>>> };
>>>
>>> As a result, the RSS key passed to the device is shifted by 1
>>> byte: the last byte is cut off, and instead a (possibly
>>> uninitialized) byte is added at the beginning.
>>>
>>> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
>>> moved to the end, since it seems those three members should stick
>>> around together. :)
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>> Changes in v2:
>>>  - Update subject and changelog text (include feedback from Simon and
>>>    Michael --thanks folks)
>>>  - Add Fixes tag and CC -stable.
>>
>> @Michael, @Jason: This is still apparently targeting 'net-next', but I
>> think it should land in the 'net' tree, right?
>>
>> /P
> 
> Probably but I'm yet to properly review it. The thing that puzzles me at
> a first glance is how are things working right now then?

Apparently they aren't ?!?

rss self-tests for virtio_net are failing:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/471521/15-rss-api-py/stdout

but the result is into the CI reported as success (no idea why?!?)

/P


