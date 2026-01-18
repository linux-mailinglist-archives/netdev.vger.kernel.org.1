Return-Path: <netdev+bounces-250820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F13D39390
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 10:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E783D3003FEE
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E82C21FE;
	Sun, 18 Jan 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4p+tKwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EB284684
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768729397; cv=none; b=WakwhqKA9JTXcBzXJE7t+drvPUV0Lt2uusfutYVmMVOvCl/QmxpDhPy/9iqRy3UpBOnKFHhBIE5CzA5ayFUqn9/C/mmSUkaRWn/BvDckIHxqRomnmaoZptDG7s9rfhwGNUtKQDoDuG0hTu/vvDwdi7Fw4KMckcmzu5zJHuaqGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768729397; c=relaxed/simple;
	bh=TrjkVzk1MHyHpFRUFUd0soEnIUy8nkBQiLAN/PLwf08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFtfyqoy+8m8rt23WMtxn7cidb6pZ8WdSwoEqeNA4MCSNQeCnrXu4s777QJcMDHsCxX4/3bFljFTIscYGyA6BIG4AGghOrm27fLz3TmjyWcs9ITAw6UGYrHmAfMALqG7SjGcf8xhaH/A7fHfFHP6ETiRYT4P5shCFVucjmIqMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4p+tKwG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so6425939a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768729394; x=1769334194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrjkVzk1MHyHpFRUFUd0soEnIUy8nkBQiLAN/PLwf08=;
        b=k4p+tKwG/EN9fB5tH/XShTksNXl68oIriMHmpLwae+qM08FWfyrsf9kUfzyah5qN7P
         itphn/nu6SBVCHrRQoih2NIpSVMUqffTMHXdpzkjt1bBhhYowW5aVrIP3JhCyqGVSoqz
         MFnHjELsS2jZjuIbLW9xhSOtsFQcudrq3mUPZQvu1gPVEVwNSAIh9zycHnU7TJIaO2b5
         BNdiV8ENk2b5y2xkgPyzECr4ZbRVpo5/XINS7f4rbbiy5DVIgDlRsPoo4++gRqVb7I+t
         67X5z/qXk5TCPKnMbVAC7bRjb+ee15D+RKzI0HTrq1IS1oF2LvrBsAWSzmcRUODualxf
         YU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768729394; x=1769334194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrjkVzk1MHyHpFRUFUd0soEnIUy8nkBQiLAN/PLwf08=;
        b=kxX/UfJWjQKnt7IjujeP1pIfObmwQKauIQ7b6uP6e5u0S2pAzfJsXAQjOg80Nw2Oc7
         l5fnDQW3hTc8GzAEWbbLHjKYjCTt6b/KAAWaC5lsDdiv9ovXUpAEjiFO+ZfUcAEMLIw+
         ZEHlkl5i4ZjnfemtA6brelW9poH/J0bDLBxPOE0cIINjNBZ+bO0qxQh+p9J/new94ocJ
         y8cYUhSpieNhYv62lgHeAEUoASKFk9/KPBVnaevRPxLUesZmoZSlf+QOm6Pifj92zZtS
         2Qflq8HQb0etQRRT1Oi7GTr2/SLGR5bWZPUGlBg5o3WH2AMQYfj+o2B+22DMqYHiiEg6
         DjLg==
X-Forwarded-Encrypted: i=1; AJvYcCWtZNXyLyqFxc0c0k8mmlo9jfda/P6usS74dScyaKCY8jtP6fgU6afmaVIfgVCrizrTGPKdNHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1FcK6CI1NBbDt9TV9DBV3CPHm5irJGi7F/okp4dJ4RzpkMtJ
	rlNfr4ssYatrqzeQzV+vAX8xfezqAagn9BWgRFWCU5JhSO838f/x3Sac
X-Gm-Gg: AY/fxX5srjgmQlbak5LY8PXeT8HViunSpf5ph5f+0JWDovfqIJidsTJyjttrHOJcYpy
	c8nQ6yM9RY/+HiQY+qPPZQwNH7JfM1t7cRRREOF32f8Hs35yRMauZJZriK7MacIB+2pJXuLiRi2
	N+NeZSBp2nXjIrqixqbHW14tEDaIxINHiE/0QAc/UWmdwKhmNe8r+x1KKZXUsJYFB3RKeWusIAG
	YabgLF6kCZ1ZZq6mCSIHOrP6shU6LOfH1l/T6TvszboyU4H6b9svKY0wd0saOoSI4CjfEaIlKv0
	LP+/IkyIFfNGHNCh87lay6vZNZeYkLYiRyDhMB+GXb5d1Vo/WOASckFNksveOB+dm4isllyqrGh
	KXbVoM7vVNhfAcMdPPNZTZ0FuGm/bU40ofg9y/tdNVjsnBl9ZY7oPrnsVgbmtqIMEXyp3vPR5oG
	iIW4kHEY5Pwb5oqhb17NdY03OUz8mEmFsq4eE8TC8G+IVLA6TeDYGgV0LQUaA41JEuVgUCWET4z
	M4czBiJVVNzVw==
X-Received: by 2002:a17:906:6a1b:b0:b77:1166:7d63 with SMTP id a640c23a62f3a-b879301684amr718338066b.40.1768729393702;
        Sun, 18 Jan 2026 01:43:13 -0800 (PST)
Received: from ?IPV6:2001:9e8:f10d:9d01:f9bb:2216:3277:25a0? ([2001:9e8:f10d:9d01:f9bb:2216:3277:25a0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e9f3sm782515066b.10.2026.01.18.01.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 01:43:13 -0800 (PST)
Message-ID: <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
Date: Sun, 18 Jan 2026 10:43:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
 <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 16.01.26 15:25, Andrew Lunn wrote:
>> But let's first figure-out if word-only smbus are really a thing
> Some grep foo on /drivers/i2c/busses might answer that.

Did that and haven't found any driver in mainline which is word-only.
All drivers with word access capability have byte access too.

FWIW, I briefly looked at some specifications. SMBus doesn't seem
to require any hierarchy or bare minimum operations, so it's up to the
vendor which operations are implemented. Though one could argue,
byte access is probably simpler to implement and if a vendor implements
word access, byte access is usually implemented too.

Looking at the SFP MSA [1], some sentences sound like one could assume
byte access is needed at least for SFP. In Section B4, there are statements
like:
- "The memories are organized as a series of 8-bit data words that can be
    addressed individually..."
- "...provides sequential or random access to 8 bit parameters..."
- "The protocol ... sequentially transmits one or more 8-bit bytes..."

But that may be too vague and I can't judge if that's a valid argument to not
care about word-only here.

Kind regards,
Jonas

[1] https://members.snia.org/document/dl/26184

