Return-Path: <netdev+bounces-151951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485B9F1C9D
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 06:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB37718879B4
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615854782;
	Sat, 14 Dec 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLYntEaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6926AC3
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734153248; cv=none; b=ZEpOsfXLSQY/bkJamOy0KY27/TfnQTRbLECxo+i4yMT5Q9Eibpe8M2d+PIkIQihJENnffmbV8o8LFvUOxrV4z+HHLFWbOYU0CJa4ro7K3eZy0o4MakqvWUxx87VIr1BHzdbhizTCqGI8y0pliE8Lumh8oKtCAxNhcbPoNrxj5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734153248; c=relaxed/simple;
	bh=uhvKlY2B3aYGbFq88uUcTnaCwQ5g8MUH8ABiEOujb80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njfvt5APhE8ZHn8YNA3mDt9WEc0JBcfw8neOC30Ezh6kMgyTpTxxvYHTHnKeLOFP78USa8FOYjYixTyG3QuhE5u3FtZVSr8KckH+y0g/sOui59mFxZO/tA9gdrWa3xssu4qfPO8mrv1jlR7wzxqJI1LufmVwzP64NoIjuUx3GuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLYntEaZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso25998175ad.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 21:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734153246; x=1734758046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OL6S1ZSCA0kkPSvW2fTimWqff1iO82uQdBWgyGJjq4=;
        b=QLYntEaZMNzBiUCGLYOyeE6rCRkwjZwano4tsTJfePefPi5gnULg6HF8tGkIbdM0cA
         c2gTf/zYfBQl8FfoorEqQgegEtlS8KA5maSzRfUIs7OZ/sxtaIlCUWzBuEZIwh/0LaK6
         HCF6lg0cMBTLdMUt6deCYCTYo1fyzg+GftBAtZCGaZXy0humQClOkd5BUYF1Jx6Ena+O
         Zqr1VT0JUnHEdsoAcTH/wy5ZJ7zuAmB44EwilLovBUiZ5K+Suus64aPNzOmh5xqpIqab
         /btc9uYm2d7pNG8qR79SpohSuB92rFk1fDXgFcAW9kKd8XXat8z5VgPkcKDzaFkoSeNX
         JRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734153246; x=1734758046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OL6S1ZSCA0kkPSvW2fTimWqff1iO82uQdBWgyGJjq4=;
        b=AemeAuifWT96AiyX/dGpR2fnbda+MnunxEpHn7Lk+NoimVnQ59yVlSqaz1DRUYmsA8
         ekNaeVpaIBG5lYiWRXtIW86hAaTD3bJe309w1EBYocbHnRIQfaIADumxxNCgnlfh+lde
         8kAt95VBHLU24APHz0ee5MVZJtkYkB7Q3OaXEadMFc1a5X7GHdLyoKMUywUmd7XdwTQu
         Pi6ETc85gK6D5LgwPg3qO7yee9WwlU95c2cZjhi5hGH9XqjVGz0QbNEYIaFdn97VCxg1
         Thp2hY+b1bWvAAfOl+k6MkqwGlEv3A621v82bUCgFvMQur91FOP/ozNRg30h4RlIiiqi
         m6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVygfAJnz4rKlvImK5TE0k9QLqeylULxubDvGSOZdJZa09MIu4GLc8uygAscQH+jUHGvk2U31w=@vger.kernel.org
X-Gm-Message-State: AOJu0YynMHBXGzuYNUo+9GNWiEygMBPKBgUfqiGQWvA3MuJFRLxJbVok
	6Ba5KoyEHugwnjO2Mj4r3p66VYEhERmEaCrn6Cn9qyY0xFzoT0HB
X-Gm-Gg: ASbGnctsAbHWK91+hVS6hRfvovwvlgG5G+Uz1XqNmS2H1XyOOZvmLzr3x5bHcK9GQBN
	g2SvtDEhBstbRJHzU4CniAw4YMdJwItvTBbhuK0OXfVlKX7Zcv0aj1/xi5NgRqkxmIplWaE/Kzw
	NQtvsH8CdSqJ8Ek3+UP701kZSaTQJsULlGcXSkLgWK4SREez1gwRY2Zk7AxPsa1EXQbHSKcrqEK
	rEVSVcDWzjGQBYpVsvh4fWwJh6CeloVzo7CPbUIHQDOLmvPHBUEEvDbPQ6yFNAc9+fw/bCEvwn/
X-Google-Smtp-Source: AGHT+IHreO8hREPHaesKW8h+P2SNEpKQGEQ35pHBXJrQzE19P8g4egaZJ/UFa4T91/hoojgK4AAh5Q==
X-Received: by 2002:a17:902:dacd:b0:216:7ee9:21ff with SMTP id d9443c01a7336-21892aea39cmr76148835ad.49.1734153245822;
        Fri, 13 Dec 2024 21:14:05 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6c110sm5801285ad.257.2024.12.13.21.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 21:14:05 -0800 (PST)
Date: Fri, 13 Dec 2024 21:14:02 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mvpp2: tai: warn once if we fail to
 update our timestamp
Message-ID: <Z10UGg_osMZ6TZrc@hoboy.vegasvil.org>
References: <E1tM8cA-006t1i-KF@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tM8cA-006t1i-KF@rmk-PC.armlinux.org.uk>

On Fri, Dec 13, 2024 at 04:34:06PM +0000, Russell King wrote:
> The hardware timestamps for packets contain a truncated seconds field,
> only containing two bits of seconds. In order to provide the full
> number of seconds, we need to keep track of the full hardware clock by
> reading it every two seconds.
> 
> However, if we fail to read the clock, we silently ignore the error.
> Print a warning indicating that the PP2 TAI clock timestamps have
> become unreliable.

Rather than printing a warning that user space might not read, why not
set a flag and stop delivering time stamps until the upper bits are
available once again?

Thanks,
Richard

