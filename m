Return-Path: <netdev+bounces-155554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E296CA02F5C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57EA164135
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264EF1DF26B;
	Mon,  6 Jan 2025 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQXKsraY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5171DF27F
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186434; cv=none; b=dBf0AgKzsBNXJIcfryxO16/Q5JPWjfwie8eOANfTbzZDtPxL+cRK9CUuCvXCXJAma26TvJGbqg2RoizGuAT+dQAlPO51/fD5wOkLRnN84CtB6JIAEXDrc3DWgFN96azq1QnBe/QhAi3CB+Bvx70yDjAYnPtr9HmP84eEyXPT6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186434; c=relaxed/simple;
	bh=XtEvhVqcuKqPdn2z+sHDy6S8zscaBcTOrRaimSFrwSQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gYp9CnHRU+ytrMAlKNuq5R8flQB8MMtUH+qCxORy1g2/IN7XaaQJxHQ76EM0NGAx06mpy61qlGe0iq7wXE7z/JbjXXSdrqEDThsjYDKDVrsT6KnZSDorVidsoEjRDzyqUWVbbRhwQnsUF8/Q6qQFrbcupyO4o+cbqonN8I6XqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQXKsraY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1675448966b.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 10:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736186430; x=1736791230; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nW5Vsxe90jgS3FjbDOHisquSbgKGez6K55jnLaEDQU8=;
        b=LQXKsraYHVfxUMf4HhH1sSKUHLDvMJ7JZ9yKMUbKlJ91+K/SJL8pBiQN0tukiyhwgF
         oY9m+Tf5k705tjg9ym+JjW1nclTUuucadxb8UiLhqtzKZ+HHZ6P9MQDoVFSJX1NlvNDn
         Gy2iqVBKT1d0f8cJL2tcfHjeRE3dHS90uX5ntXslDdEmZ+zrjgRachWMmghvfJ+qo+Gz
         jE6eiRBc52Bo/jqaQpv0N19+eU/4Oh5MeyZ7iv+qiVxbpeLvkr8exU6kEP+v75+AnozD
         5T33C0og3jgCiTigA0R5eIAo/RALllxWk/zCEhk77G0KQVScU6WTdMkA+V9qeSFB5xCL
         eimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186430; x=1736791230;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nW5Vsxe90jgS3FjbDOHisquSbgKGez6K55jnLaEDQU8=;
        b=KLDDjgMVE6olf1c+j7dnp+z5wrUiNoZlcqrgZQLr+I9ZtcJM4FIoowoAZN/LOngn6M
         Ig4b4kgF5ybDuQ2CTLdtIg/P2T0JnWnp1g3W2vX1vhycEbqhMIE1ryXyskSpDRjdr+tn
         q/rfvCofa3uDSpWZBrxEcwcNoXo1QRq/KHx8NRnc7cYmKDi8B5PzVPEBDVtk3yop5tmi
         HLO2mdNfFBLoNKpH9Eo1KblTZVccuzgdGDH1Q0qii1QBvgWkcDNQo55XPX3m4Un2ZgYW
         l6/+4Jd53OQdA769s2iWGYko2RUJcMEQBjLFdVr54EL0cAdXVyqGR+zNlsp9InJCphBd
         0ZrQ==
X-Gm-Message-State: AOJu0YyjXtDZh46nP5li15GJ0/suQUENtdd+xINoDPcJi7tBPCOURbqT
	cabaxIm8zL54TVXmuUzn4ObkR0ckEyudJ0A3wtH+LNihmHrTRaFe
X-Gm-Gg: ASbGncvTttF7rw6aMF4IA53sYTfMymU9MgoPWfMPq3GSWpc93q3nKYVHmUDW8ooqdnm
	SZWdY4ICCKYdwiVu+BU7885uMbVTDUIYtutNxgJWtYJSvFuEt9eNDSIThbLZAipaAh2qski+C8f
	dFMHrwpdAKAm5FoKj28F1WNp3s3umMIf5JJPlyhoHcSgow6RXaI6LKmhzWbl89lzrH8hW4ikPOB
	tlLHhzmQlkk4sJa20q0NQEilRC6lATExa0pivUfpyLeHdlH8vzkupWgZeM6FZ0B+QnozU7NXnwz
	lsr18UPpMBjgFniCsNs/jM9SmCq1KBbs8riJ34zTS0ZQJ/EysTCaNN4EBV0qizKpc4Plw6HeZdH
	0dmQNI4EZteXobzWjFD/vOjtkKe4CPEa3V/pHG6zR
X-Google-Smtp-Source: AGHT+IFOzPPS5+xEKYzlkK1qD2qttKizSbhszCd45mvCG4oaxbro2S3vq5xwo0kq3CT0W8ieQN7fSg==
X-Received: by 2002:a17:907:36ce:b0:aa6:7165:504b with SMTP id a640c23a62f3a-aac2d41ebc3mr6323409466b.31.1736186429759;
        Mon, 06 Jan 2025 10:00:29 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0e830b2dsm2274222766b.8.2025.01.06.10.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 10:00:28 -0800 (PST)
Message-ID: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
Date: Mon, 6 Jan 2025 19:00:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] r8169: extend hwmon support
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series extends the hwmon support and adds support for the
over-temp threshold.

Heiner Kallweit (2):
  r8169: prepare for extending hwmon support
  r8169: add support for reading over-temp threshold

 drivers/net/ethernet/realtek/r8169_main.c | 30 +++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.47.1


