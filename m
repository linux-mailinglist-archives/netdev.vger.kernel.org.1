Return-Path: <netdev+bounces-155286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC9A01BC1
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 21:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283797A1686
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BE156228;
	Sun,  5 Jan 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="losmFxUw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04023DDD3
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736107830; cv=none; b=BWdUY/QYCabe75/nvYCBR+su+3sQTuv9mz81FGKPVWkm6ejT0tl7Ca3zHS3lO1hjAHw5PgHZhGSqSYOuwADTYdsVJSI+nWaQ+WRijEhnztRkTpBPiB7x3rljbc2Vh3j03kI3LwcsgbNpkbh4EJAQSa6xEHoqxkGDoStE36/0Piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736107830; c=relaxed/simple;
	bh=tXFovJCQjdgQH1QFcWz3YNmT0SBvxs0AWlnTdPq5Cc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMML121ZLGzrSzmvY5v5KK2L3jk9QzZKy5u8S5LTkOV22JWlxlhK3xJR3lIpNFeiONdl5YziX+7yp5qGMNsYPiFU7yZ18eXiUoewWX2IpDfm/oxxfXXug0X2Js7KitJyrfv9f3XhDiIpEpYCvuKYcriUUyEhopiuUK56/uCc+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=losmFxUw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4679eacf25cso74629241cf.3
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 12:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736107828; x=1736712628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3LI8elsJDues6Jb5XTk/jq8UBUtSXF7KF7YPeO0rOw=;
        b=losmFxUwfpCwEdYksarlrap3ayP/DNz/AfUYc1h+QEVTMGOD0icqNyBwRppgbPhXmH
         pvBf7eb4jN1XvwbIlu/4eP+rKNEwBFc4ln7kvGbpfAiA2h0rkSN8p4bepvZaVNVoYXV9
         hsgD4Nab1zErNRxTVroZERGiJwG/G6uuka3BIxkgVeEioeiQCtXvj8htmcxDz0Ppeoo6
         nKdE/MMpGtUd+70XWarT/8BejqZLNtE/dLyFp8EqLYR6p65dNCS7mXzDO6mp59gLolEj
         OvgfTj9GO8yXYZ+t0Aw558OqzMUJe/ocSgELL9k0WyQvu8XsHo7Pr5xFGScKRlmAOB0u
         fCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736107828; x=1736712628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3LI8elsJDues6Jb5XTk/jq8UBUtSXF7KF7YPeO0rOw=;
        b=SxaY7IHJIbDga7Cn6xbVW/KhrvQAZXLA1L9T1X0wur5B+GpmEJ385mMEdp1CXAbkCY
         Eo1OBXxnO0xe1aXwzGZtqymjrVLddGD9orD7eZJc+lKvlnTwCo5j7DRLJxGLNKkXMJZo
         wtJlquSWROmKqtThreNeo/gx4Qhr7PrsMLDI2gMHZ9Le4QSjCKR3fsaaQ2Fu+vzl3QDE
         3W7zJu3oMNxtxn1ixJmX4OL3a3QppD1bi/101nRO550DaR/KVj3TTsQxJLK9N3PqY6zR
         bWDfpKt/dV0JysEy6sqADtLGazKZcdgL5WH5AhwGCcpgqtXbl0rcVGSLV1h8IfuTNCDu
         ukjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3bcjvjzicMblwd04p0+cUfRGDmB0gSxaJdSSQ+0KDy3Z/6P95VwLMbT+HhLiFJFQJw865+iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC68bsFMg2/ePVy1ZZOoy5gcjBKEzOwp2T1U/CnnA1eQOeNpnj
	M375HTD13xnhiYe+Ku0xbRqkBWG/nOFTDd4RYyVBDMzBgJmh6Uy5
X-Gm-Gg: ASbGncvBSvzB4zknmDePrgxNo3eTHI5eYxdhR+EhWk1XDEwRChGwc/iTdDoPslGli76
	LuE8k28URVEfi3e6egQPZxpNPXMMO5rBlL5I5ahRdQeRxm9/v+fi1raDnurGdA1r4G/qpxxegz3
	H4LoFzrAMYylKhq5yx0IcxEBQQBe9F+wxxKlgwqwJUO6p3MY7fgfQxCQnybz0IlSd/x8RSBQYz8
	GonR1FYUlnDtauaad7n51LJSQI+zVz7oSFSmxLrvbbtHkYArbScwm0wP5VHeZx5/hptHxcyyZqC
	dFk=
X-Google-Smtp-Source: AGHT+IHbNqJdZYUOyHVBJxjToMgWhLV96YMfjISh3rNJv7Mxm2Zi8DAYf7DgFzC439EhDT1ow2DE5A==
X-Received: by 2002:a05:622a:341:b0:464:c8d3:30c0 with SMTP id d75a77b69052e-46a4a98a00fmr828191861cf.35.1736107827827;
        Sun, 05 Jan 2025 12:10:27 -0800 (PST)
Received: from ?IPV6:2607:fea8:1b9f:c5b0::4c4? ([2607:fea8:1b9f:c5b0::4c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c13b6sm162842086d6.96.2025.01.05.12.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 12:10:27 -0800 (PST)
Message-ID: <85830760-63a2-46f5-b1f6-5f1233306497@gmail.com>
Date: Sun, 5 Jan 2025 15:10:26 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipvlan: Support bonding events
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20250105003813.1222118-1-champetier.etienne@gmail.com>
 <CANn89iKb+T3cZLJUwRNZah6hKHn3XbUyw29PsEAif5LC96NRoA@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Etienne Champetier <champetier.etienne@gmail.com>
In-Reply-To: <CANn89iKb+T3cZLJUwRNZah6hKHn3XbUyw29PsEAif5LC96NRoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 05/01/2025 à 03:15, Eric Dumazet a écrit :
> On Sun, Jan 5, 2025 at 1:43 AM Etienne Champetier
> <champetier.etienne@gmail.com> wrote:
>> This allows ipvlan to function properly on top of
>> bonds using active-backup mode.
>> This was implemented for macvlan in 2014 in commit
>> 4c9912556867 ("macvlan: Support bonding events").
>>
>> Signed-off-by: Etienne Champetier <champetier.etienne@gmail.com>
> Which tree are you targeting ?
>
> Please look at Documentation/process/maintainer-netdev.rst  for reference.

Sorry about that, that would be net-next


