Return-Path: <netdev+bounces-221131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F8B4A6B9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4190E543004
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD427F4D5;
	Tue,  9 Sep 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Xdh0SBrn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067B27C154
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408870; cv=none; b=OYkhF55RFJ/VnbQGwgHgLEqA81iAnI1B5+tPD8kZXRa2iuzenlkeKrEScrRmcqi3VGNQVwLPujgQvq9x+MsLUfy4WBizQTTj0Zpwq19lVy79UrPTyMst0gIRXlmCOFt+4mJjJGfS2t38zb3RADvTBcQNdUA4FZsQ65PbKxJemO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408870; c=relaxed/simple;
	bh=B09GrDM+Gl2PH3qjxQkF8GMC+ho4Vz4J3tbOnPVxw+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm0t97fmUgKvWtDL2uPV3RpW0+BxO/lsx74WdtL3OvzW21aViVEcfPucbDJeV0kZkZFJmKkRE6OE53mTFsA/7ZywIVYZWlS6ADZkkS/GGrmZJ/mGXGuerJeaVaOvbpquCEiYptZDv5Fy7aKyApkX5lbm0MrNzPoaKzffTloWNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Xdh0SBrn; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f74c6d316so2874969e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757408866; x=1758013666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXS1CYgcUklnGpIeCza9yYOT777kwRmP6OwfUG9WUvs=;
        b=Xdh0SBrn2tqu/4T+8UYEyDEl49EdAnABBKthz9x7JKUf8ZE08vYQj1Fx0E3z09pf0n
         JR+hKzbVOMxuZKxuUoM6o7L81JaPl83pLzukN+GMEKt/vFkOcrBndr/aO0fqABKjbrHZ
         eP01TrPS9nNW6r7aH9IZDGg4wqJz2iWp2n1xS74pc3xLfz8hS9ia3ieRGzkUNJC8Yfca
         cubWk97wa31vIJRCFyCu0pi4HY8LM1pkainBUKhPdT//+IMNx9sm2GRIw8GGcdhTr5So
         XDdkZXZZM47BDo9/XOtMldtsm/zZ46eZlKFAFXeeZF4BV9Yx9l+qTNjzSINP792VG0SR
         YB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408866; x=1758013666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXS1CYgcUklnGpIeCza9yYOT777kwRmP6OwfUG9WUvs=;
        b=bJHRKtRumqM2TVTUD97xZdjqId8EJvkqM2zuf8bwgRHfP0Nn2EMsJ/BIY1E7mWPPyT
         cRvmkaqTlr84MMhU+Q3CBAsNMfDIL8ciojhF38OpjPkIgWmkXXhrGTePFL9xj4ei4Vjr
         iUuCVR0Tlscs9SSeJ29WDCOTNfT+fJH3PBNfD0pIZvRY4bBjikKUiHeEGGQ5gper/hQw
         7ZdvtZOwzkd1eYcqso++HIUfdhdciVv7JbpCOXKDpsGhwKK7sKH3E8R8jbjmIokSn+GO
         HosfFruh2zB0S6WthF6QGc+CWpHiKtmj0rR/Kilfv6F0ViyT9N50t+qNZfwpmqGSMgX5
         LPPw==
X-Forwarded-Encrypted: i=1; AJvYcCXoTK5ATj3lIBAhsEqKsg4SEkndEhfunbYDPlKSPvSQMzkP8gudYLITe8/h9G+RvD1w/fdfBCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtL0UIxMXx+YU7XGYIkaidqmeTFKAaJF70vS1PbKVbfl0cPEvQ
	WlKS8ZQRUj1DnnYwr8Qowpp/44+nygZ+uwJ8XcXodQvEPWjCcoq4p07NY9jYZAFQtHE=
X-Gm-Gg: ASbGnctgU1htiGawnCZh7HpUO6wr28wE8+/4gzzdEok8s/Y19hAH/fAFOoXac2R4KBP
	Dc0thdMnrliFMwsR0rA/8Qwd7rQMEn0OlFb7W9NfyOKdlUrWvlgrLOCW7hnP/eMtocFDrXO/gc3
	7FNwWsBQ9x855DsXV6kOQLKJcNuX1P6GpKFjrCT2SThg67j68CNQosGlfI5Fp7kNIE7HvtvzBbA
	HU88Ru61z7GsjXZQOa434ka8m3vUZmSzdci6ocnOdwGsAUXsKdUjCczb7MiH9Cir25Z51cEBxtR
	ftPAjPf4z12qjcCWrI31Stc2G5NezVmXEFGU5d1vEXYw61wZ/6v20vGjq+cPliREhMsnXxUj9gO
	DBXSDcK2o5ivqQBeCYtEP7mi2guQmISkGEMHsgOJOUz5IznyfwZXi49yQeA9i80ixuAvDO9/U6R
	TByg==
X-Google-Smtp-Source: AGHT+IF1YxMAnlg1qyBzbrHJljZUzCNBwbGGA/25YFm9LDOCgIfpPGjQ5Dcd3urek9oxqCQknz+G1A==
X-Received: by 2002:a05:6512:130b:b0:55f:3e4d:fb3b with SMTP id 2adb3069b0e04-562637cbf70mr3443518e87.30.1757408866099;
        Tue, 09 Sep 2025 02:07:46 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cfe2496sm394362e87.61.2025.09.09.02.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:07:45 -0700 (PDT)
Message-ID: <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
Date: Tue, 9 Sep 2025 12:07:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, mlxsw@nvidia.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Jiri Pirko <jiri@resnulli.us>
References: <cover.1757004393.git.petrm@nvidia.com>
 <20250908192753.7bdb8d21@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250908192753.7bdb8d21@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 05:27, Jakub Kicinski wrote:
> On Thu, 4 Sep 2025 19:07:17 +0200 Petr Machata wrote:
>> Yet another option might be to use in-kernel FDB filtering, and to filter
>> the local entries when dumping. Unfortunately, this does not help all that
>> much either, because the linked-list walk still needs to happen. Also, with
>> the obvious filtering interface built around ndm_flags / ndm_state
>> filtering, one can't just exclude pure local entries in one query. One
>> needs to dump all non-local entries first, and then to get permanent
>> entries in another run filter local & added_by_user. I.e. one needs to pay
>> the iteration overhead twice, and then integrate the result in userspace.
>> To get significant savings, one would need a very specific knob like "dump,
>> but skip/only include local entries". But if we are adding a local-specific
>> knobs, maybe let's have an option to just not duplicate them in the first
>> place.
> 
> Local-specific knob for dump seems like the most direct way to address
> your concern, if I'm reading the cover letter right. Also, is it normal
> to special case vlan 0 the way this series does? Wouldn't it be cleaner
> to store local entries in a separate hash table? Perhaps if they lived
> in a separate hash table it'd be odd to dump them for VLAN 0 (so the
> series also conflates the kernel internals and control path/dump output)
> 
> Given that Nik has authored the previous version a third opinion would> be great... adding a handful of people to CC.

My 2c, it is ok to special case vlan 0 as it is illegal to use, so it can be used
to match on "special" entries like this. I'd like to avoid the complexity of maintaining
multiple hash tables or lists just because of this issue, it is not a common problem
and I think the optional vlan 0 trick is a nice minimal way to deal with it. We already
have fdb filtering for dumps, but that requires us to go over all fdbs and with
fdb duplication the local ones alone can be a pretty high number.

The pros are that we don't have fdb duplication (much smaller number of fdbs),
we use standard bridge infra available to store and find them (the fdb rhashtable,
with local entries tagged as vlan 0) and code-wise it is pretty simple to maintain.
This solution has worked for over 10 years at Cumulus, it is well tested.

It needs to be optional though as it changes user-visible behaviour for local fdbs.
Any other solution would probably have to be optional as well.

And obviously I am biased, so good alternatives are welcome too. :-)

Cheers,
  Nik





