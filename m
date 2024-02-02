Return-Path: <netdev+bounces-68528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0939847180
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D761C274F4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D9C47796;
	Fri,  2 Feb 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Y/uBK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8263140797
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882108; cv=none; b=dhhGsySDfUmpriGDVkAjkglXTUQXUAaS+JsAXamm7uqtQ83C2HQewy64P8Wkoggv23p5XPcRqnEt+PR0a3OSzy2dfDHOgCKvMeBgqlisBfD2ALhggI0fBiUiYOjUW6vS6BTtpqv0DAVnskttSudvczY9zN2w5zXKLqKB+jk3si8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882108; c=relaxed/simple;
	bh=yf7R/Pjx9Rq20DlVIzyYbPPbHxBEJJCBWasz3q5qLGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksgUzcW6pfEFVdkfwOO96P9GShBlEjFdBeu7RdeRYWpldep6qP997TilHYEwbOeocdTVwhr1s48P5f8YHnDdB1Yu3FL0xeJ1mq0lLUilPA6mgt367etalp3EVvGCEttKrVXDPpsHGZQgFveA9bR5mru8JqVdpTQwtgMFmI2Jigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8Y/uBK/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33aeb088324so1433171f8f.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706882105; x=1707486905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/uaC+Smw5kif6ElHSolQkOhaPRjlx8upVixk8Wqo3g=;
        b=I8Y/uBK/VYC8A1shOnyr/lFhK2p1jtH65YaAD+l/f1pffm0pjGnT6VjFtqGBKPQ7en
         qchN5ZiOeqj/e7oNVsecKJ1FyKuOqB7JnKW7nyQ/7+cnf5C43sZQnYQvbwwyqelbfgr7
         1qvYKX8ix2bn0611Ux4USJLmX4rHBuH6dfH2ecCwvFRsLRUX9hEXpvx96ohquUvt0dpK
         kD6gz8j0hhSkP8JZgNB96dfu+bH4RBxuV4lG5jQq/gXctUXOu1xZvlhXYLH9/n4RIDqW
         hqqxHwtClaUKxEo4pwauel6g3LKfBFnlwL6mdY8I2RneF3dOUhNfURQQCoShWZC/aKKA
         1dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706882105; x=1707486905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/uaC+Smw5kif6ElHSolQkOhaPRjlx8upVixk8Wqo3g=;
        b=lJuE4TCy4kMturOdoiaF4jAfRpJGjIbxSBvV+rspaAvJ6HpG2Podslxi6tmBwKmSJH
         dFK1XLld5N2hdv286z+UUuRlId+jkbOortloBQBZJcSMlwdR2ndA7PNpYKcT7csdicm8
         3bs73P1aMJ66AzU9NahqRvD0fG9EUEwMgmgjKlZs0p7qy9dlbMuB0AQFrMqnUWRfMGky
         WPzqHSfA78cdK9/HwZq+bk4FCl18GigTLaGypYcEkkgxoG9okigcX/UX7l9JPtA9muZn
         0lwqy6ZTOuweVTT2VS3vRFjccfqSWjyjNKtxXN9f5Xqs93TYtIVFib0TmB9YRuaxYWQM
         Yhnw==
X-Gm-Message-State: AOJu0YzKswA1zkLC5pevJ+S2l1OBhBsWG/NZ0MiGd24WpYjblgw86yLe
	1i4e8ZDm3hmb9GRPODM/dWbVa97EElLURe+QkncFFhpVuKoxAmvm
X-Google-Smtp-Source: AGHT+IEriKFxH7h277sfH1mXeb6P0ji4eJtySqSOnawExF2YQew2TvznsYwCAb6ICstlbobQNhIXVg==
X-Received: by 2002:a5d:460c:0:b0:33a:fc81:49f3 with SMTP id t12-20020a5d460c000000b0033afc8149f3mr7027303wrq.59.1706882104794;
        Fri, 02 Feb 2024 05:55:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpEFAH9F912wpW40Cx5JqZK/taJKamoxU7avOyaTIpQNGJBEKAu0mLry5YWuUpBmYI3sRm7sVOSn8AoBoFoI7ybluYuLTema7gLwzFFamHG3m168p5gR6pn/dwaemMKkqRKaaaQ+XNPachvZHZc1ZsrrNo4IvWrIDIbEglYnyioWFheyw6UhMlzCCJU3XO27zOe+LtBraKOyZEt4IQToSfWjas/X2pimguxwVMHnzb6+IIFOhzFq7bS+HAuqvNUveIPpCbwG/XA2T45MKRqGLN3EO82uUSDt2Bzh3ud3C1S3+gcaLNXgdRbZ3q
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d4092000000b0033b075e92ddsm1999790wrp.6.2024.02.02.05.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 05:55:04 -0800 (PST)
Message-ID: <8c9f3be0-5e27-4642-b178-407b3bfdad47@gmail.com>
Date: Fri, 2 Feb 2024 14:55:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] tools: ynl: add support for encoding
 multi-attr
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, sdf@google.com,
 chuck.lever@oracle.com, lorenzo@kernel.org, jacob.e.keller@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
 <9644d866cbc6449525144fb3c679e877c427afce.1706800192.git.alessandromarcolini99@gmail.com>
 <20240201172431.2f68dacb@kernel.org>
 <2b3ec0f1-303d-4e0c-92de-5d0430470c33@gmail.com> <m2frybum6z.fsf@gmail.com>
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <m2frybum6z.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 12:42, Donald Hunter wrote:
> Yes, if your input matches the ynl output then you should be good:
>
> "sched-entry-list": {
>  "entry": [
>   {
>    "index": 0,
>    "cmd": 0,
>    "gate-mask": 1,
>    "interval": 500000
>   },
>   {
>    "index": 1,
>    "cmd": 0,
>    "gate-mask": 1,
>    "interval": 500000
>   }
>  ]
> }

Yes, I confirm that this is the input I'm passing to ynl now, thanks! :)


