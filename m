Return-Path: <netdev+bounces-172801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC60A5618B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD12616CDA0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B450D1A5B90;
	Fri,  7 Mar 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAIKEerl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F51A3A80
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331273; cv=none; b=LdILs/8KKyNj/C5jE7kRVVquL27OdpAG0nxhzbGZaXW+RAZ0DXYbwpoZBv5Dg09MlooF5ZjP9Mgo8yuC0HYXR+E2oCQFELnXPPD8j1o73aE6Myyd0tkiupvmgrM270w1GKTUFphlXs3JrApH0TgMwphfAPjmBRLBV/5JxFajfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331273; c=relaxed/simple;
	bh=wePpUPbk++pPcuiUHqfa9F1jtCjeQTZHbltHqJMMpBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Op646XUFpONZG04f0rU00quyGwNU7+5KDE9Zs9A0K2/SWOseXc8V5u2Sz+CnKgeD2jOlQ/AJnvV2jKyWxw7Zy7FBb3f/d6uQwjLwebA+mxEYBNYV/uwUwyBc1ErskxpiQH4DBbTqLTAke1w9MeuvFF0CGcUycQKjgwv66MY+7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAIKEerl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso1899369a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 23:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741331270; x=1741936070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ESvQZtgu+YQTxB4dRbtx7Jo77/vOU6PYW4qQanaDrO8=;
        b=fAIKEerldsqvqseaoU2GD5VenThqEnBgFGI2zow0+LK6B4OQU5MBFu0dWs2+60iGpq
         m+Dd2mWKHHQHfISyWYcaYhUdmuj1KhPGILbHrjhN78luGoRM2/l27PgGjujQqzIrpXvu
         qJ3Qd7nH9iWF30lbZKbzNmP4tBMS6Y2TBKXeqzR9XcOgkVLSx53MhKPN9YojKfbQd81I
         HaGGoSiagLuLak0JL+cHrT9DCylr5OdtOFLBwQbFkgnZNS3PfE5bl7vg5mgsvA2/kRBe
         Edy876Wrk8zQ3h6XXvM7LF4lowb+DMTRqm3EO++W9EKBqxBYA3PY+BjCmbcSiQpyHaDJ
         tRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331270; x=1741936070;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESvQZtgu+YQTxB4dRbtx7Jo77/vOU6PYW4qQanaDrO8=;
        b=siNuuBf3PC7f6nZ9ZaIAlf7dlQdVomRceiZSVvc2NYSngz8bKiJsZtxaYGHXYxdJAw
         rv3gEUhQyfs9V1wLoBVJZF7/S0fNn3O4VAnkOqXtfr2SKX6GV4923J5LRZRJNdM+rm2Q
         pf8urvqllDc4Al1uT6j3lqbvXLhU3Y/Z6AfqeLHqV5VwZ5XB29VyWypus/TpAio32Kqh
         8tZ7/HeENKg9UiznvH1Yn1hfypizNKuR4Qw4pzFxQOqmkGbafOuyx8IWXtwL5RuOjPJu
         oRx6jgWLgyVQBxHNH37je8jsxMtnYLfFBN6mKdhb+B4+8wPXYLu1mdbdXwwIprbWSbqE
         Tk/g==
X-Forwarded-Encrypted: i=1; AJvYcCW624f9q1W1RRjmGSnWtw8RLAWQ/fFpYE0jv5eaMU43PWLRhAD7AfLik8XsLigYMmNFufuLtbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5V2zLHEtWMDJtjhcoPh7/z2EiGWa1YNt0pfc8tGKs8FXreMnx
	4Cr2HvN65+ZPfQu1onrQaB3lVxpZW9l2sLMJpY9XIBDRSCpHHzBi
X-Gm-Gg: ASbGnct/WJQ5Heo+kVZzV3rNQygKN2nN6R18wxXI9QnyxJL/1/rXc+zF/A+s3PPlMu6
	CdFZyiHceNacgmfgya6hbXbjWz13VC/9wOUzZKE3ff6OArOVBZQJ9UPbkzoTZcOxWlkxnhG6Bwg
	R/MgVtWkSHjJ9d9WwWxc6wdQ28WUS1YnEz2b295ar1UA3ZKNs4nyA5rTxrnQKyzbI8h4HQ5/PDA
	b5uOE2u1VgVEKAIQcgTToZE14nP3mlzY1Il7xO2dNQ+abwKZjcfmsatOqQhCAjR6Pf7aMoWZFMn
	5Y6sC+aiYZy9oKUzRkW+ONpG5CM3gFHf+D9DooOoU52k1Qr3Y4+5wKftynUqk8uzVAoVT1QuvkU
	e6dJU4bCZ40XBwUAG7q2O6Re/TejezhghXhDG1qvDkQiTJIECZg4Y8BMKcIQfIq4YF8kUcRYRcX
	ZzTXfA97XZbZUiZ6XahCbePAbCUro/Bh2MDJ36
X-Google-Smtp-Source: AGHT+IEJCZeumg1IOa9asPPp1rLxzm41E9zVgEXPacelPCEN7/pD6eWH3cAlFHqOqp2wje+JwB6r1g==
X-Received: by 2002:a05:6402:1e89:b0:5e0:8b68:94a2 with SMTP id 4fb4d7f45d1cf-5e5e22cbc84mr2207647a12.14.1741331269778;
        Thu, 06 Mar 2025 23:07:49 -0800 (PST)
Received: from ?IPV6:2a02:3100:af19:6300:6130:87d0:45d8:3247? (dynamic-2a02-3100-af19-6300-6130-87d0-45d8-3247.310.pool.telefonica.de. [2a02:3100:af19:6300:6130:87d0:45d8:3247])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768d1d8sm2046928a12.67.2025.03.06.23.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 23:07:49 -0800 (PST)
Message-ID: <c79d263c-5fe6-4963-9bdc-7558f1bfebb9@gmail.com>
Date: Fri, 7 Mar 2025 08:09:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: add support for 16K jumbo frames on RTL8125B
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rui Salvaterra <rsalvaterra@gmail.com>, nic_swsd@realtek.com,
 netdev@vger.kernel.org
References: <20250228173505.3636-1-rsalvaterra@gmail.com>
 <20250305175921.132b10ce@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250305175921.132b10ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.03.2025 02:59, Jakub Kicinski wrote:
> On Fri, 28 Feb 2025 17:30:31 +0000 Rui Salvaterra wrote:
>> It's supported, according to the specifications.
> 
> Hi Heiner ! Are you okay with this or do you prefer to stick to vendor
> supported max?

I got a feedback from Realtek that 16k jumbo packets are supported on
all RTL8125/RTL8126 chip versions. They just didn't extend their vendor
drivers because there hasn't been a customer request yet.
I'll adjust the proposed patch accordingly.

--
pw-bot: cr


