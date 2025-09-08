Return-Path: <netdev+bounces-220781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE61FB48A3E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897D8167AA5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D832FA0EE;
	Mon,  8 Sep 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvxBQkPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F172F90CE;
	Mon,  8 Sep 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327707; cv=none; b=JDb8oZJC4LMBRODCdt0NZgyg6vmkGoW8cVDecs1SBDwSbw3Ck/irV2W8DkQ2yjKxj5FVVAT35FasU4eHLiHi9D5pKVv7+qwGYUc4d/Hvjtlm45o5Cj6f1NF7hlfB58wO/T60cU3uZxr3c6VGZN/+W0EwsDPk+bmSv8D6NULhBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327707; c=relaxed/simple;
	bh=P8+azPFD3IlzvZwU774Lp97SpbVybyxPP1U+m1uWN0M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UmtkZoy2/NnFfEKxpaVczPtRhgRBoY+kmZ79qH0x9+j/kXPjh8NxgwE4leYSCr4p8qQhvLSaS7e3lmfrODhDxxz/GJBva9VnnvE5z7Ya9GFPz//ksEck1fYJzKg2M6FV0RqKP4ClmbO5hKM/TCA/qEbAVqhSLv4krpgFK+twnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvxBQkPC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45de1084868so6608705e9.2;
        Mon, 08 Sep 2025 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757327703; x=1757932503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5iDY+Vi0EdOqRjdG+5WCOpNIgHMMJTkV6QF3KBvr3ao=;
        b=IvxBQkPC8fAht8lk3ep+UCv3XIJhHwHavPQAMqkwcEzcqEXa3kjIGBuosXo1+alo5w
         +EhsZRVayzGDXPSKuhrU58dWH6zEKZgpSjzzTmf50s4xRc1dSq04ZHi3l75YWDYPTWaW
         KHPHz/OutCGF27d9asVfH6Ev3//USZtMrMmyNwDgY4Mwstl8UXkU5pmBDJHo+ziYqa14
         wWkEcWtvKzw9k2eg2ag3Y+e8Vl04OywTwFChvT0+4JIxvmR/zlqvN9TtrXD04EIdGjNK
         B6iHpCP8+X7NRb/mqNFNvCw3zWRSNZK09Nqii0tyjiy0B0L309RTr4tlquXxuU/8+00P
         zQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757327703; x=1757932503;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iDY+Vi0EdOqRjdG+5WCOpNIgHMMJTkV6QF3KBvr3ao=;
        b=BCdPf6w7hMXbDMnDOUV1D85cUuV58v3INuWEti1TGpfoTfsqcPl+UPqcZLC6rXFOON
         IqLpujzmJ7/un2NPOv8sDXkx7YlhiO7ko0SJ7NsLEcZ1mfSxOjzCuKRGqR46/832VXAL
         a5nXvineqJz9QkgH+veq/o6PpYMz80lpLhnHuo4CZdUnZ6Ke4ydt5fC5NuyT53g0KYOc
         pC1QuIvIPQco9kTvfcpmV2mkqmqNGWzuzbcDtRtIRMllayuAyrtlYc4KiJQPjggCquX9
         I08St2jVfMchTKj8Bp0lR44LxiF0M2Gu0rzAt1mvriLl1oGKQTFqCAFocX3RZbpuz45D
         5JVA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+COoM6+coxeQpgcL737GynBOoVU3Ve1P0HALg6od8FC7gbEYYrLu33jIBCeGThhiCu+Z/7byDyowF2M=@vger.kernel.org, AJvYcCVtXxCdKAES0rqiVExXQ4Gkb+rdECTEapZpuW8Tqpl4wPzn+83wI+Ib1+yrWbck1wHyObVO+SjV@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJbPKrsLBK1bPbFsasK5R4jadusGJTC1znTnccRDbewdndlYl
	hSJSNniDcF3ThhRMttxbVuYB7xrF9HJB+FFq/7g3rcy84yQeBxSomUxvxoz8R5lU
X-Gm-Gg: ASbGncvH7J47S3QUbAx1z34LHpbm73KrnaEDlzZk13etxpEcR9waqe0R39BBQk0CKHk
	8Vgwef9Euux7OsnPe3bjDn2ihK7EunOtL47LrBk0xvwwawN5hi5bCCja72XCUML3Wz6pdiJv3KQ
	7HbOmzOcHAcrGcCUWsZmA0nZ2Tvmn0t3n2VfmOwE7oI/+q6Hle7hu8PjO0A/lBHvlwXDc3x/tIJ
	O3iFtIa/wDg2cp7tjx5Ne5W/xy6AktG9ieV8n67i8Xd5cMfQCZ0z/ZjhbItRMAR1N4WScgfukl8
	jbiBKejkcSCDZ10MAK9HEFhbUM78b30uJG2uzxDyr++0xUWiYjk1LJn5DBk9LAzgdLsUC9osUtA
	JusXhaTLKj/I7tjRPFjLfC6DiLCTTS32rHLYpaK/6yMV2Lw==
X-Google-Smtp-Source: AGHT+IFA1bYE54JJaTFNePXQZmaaRtj5UDlgcqlwzpgBxMXl9p8+4+og96mcgEoXG8/un61iG2AtxQ==
X-Received: by 2002:a05:600c:1f16:b0:45d:d5c6:482 with SMTP id 5b1f17b1804b1-45dddec845bmr63293325e9.18.1757327703349;
        Mon, 08 Sep 2025 03:35:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:4171:ec50:b666:2385])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm242509545e9.0.2025.09.08.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:35:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  "Jason A. Donenfeld"
 <Jason@zx2c4.com>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/11] tools: ynl: decode hex input
In-Reply-To: <bf530a9a-dca8-4df7-b9f2-9f2b3a1d2ce1@fiberby.net>
Date: Mon, 08 Sep 2025 09:28:26 +0100
Message-ID: <m21pohwdp1.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-10-ast@fiberby.net> <m2h5xhxjd5.fsf@gmail.com>
	<410d69e5-d1f8-40e0-84b1-b5d56e0d9366@intel.com>
	<bf530a9a-dca8-4df7-b9f2-9f2b3a1d2ce1@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> On 9/6/25 12:27 AM, Jacob Keller wrote:
>> On 9/5/2025 3:51 AM, Donald Hunter wrote:
>>> Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:
>>>
>>>> This patch add support for decoding hex input, so
>>>> that binary attributes can be read through --json.
>>>>
>>>> Example (using future wireguard.yaml):
>>>>   $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>>>>     --do set-device --json '{"ifindex":3,
>>>>       "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
>>>>
>>>> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
>>>
>>> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
>>>
>>> FWIW, the hex can include spaces or not when using bytes.fromhex(). When
>>> formatting hex for output, I chose to include spaces, but I don't really
>>> know if that was a good choice or not.
>> I also prefer the spaces for readability.
> I formatted it with spaces for clarity, even without spaces it was a bit
> long for one line. Spaces also has the advantage that you don't have to
> think about endianness.
>
> Should we define the display hints a bit more in a .rst, or is it OK that
> they end up being implementation specific for each language library? Do we
> want them to behave the same in a Rust YNL library, as they do in Python?

Yes we should probably extend the existing doc to at least describe some
of the defacto behaviour.

https://docs.kernel.org/userspace-api/netlink/specs.html#display-hint

> BTW: The rest of the key used in the example can be found with this key-g=
en:
> $ printf "hello world" | sha1sum
> [redacted key material]

