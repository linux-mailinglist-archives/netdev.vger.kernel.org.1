Return-Path: <netdev+bounces-226395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D92B9FD8E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB30617D950
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC9289367;
	Thu, 25 Sep 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="c4GW14mp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A828D8F1
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808912; cv=none; b=B27ZhUgyEXnGp8oENUkz/2I++iGc0RneP3rGt0p9CI69P5lH7uGJ0ecqUbuN8QyVFbjYRDx14d309wGgWUf6aJpUKca4KSq/VpwtuKSLBzjrYGsTFavHNLcpwCpH28sVRqB/zcFJ+aTMEnbuX6BjUuo8mZOP3vZKOjI1/zUsnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808912; c=relaxed/simple;
	bh=PurwojXW42p1Ea6TjGCm66kdVtMgVLqRO+Vkan7WMsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBaJV+tHPfLqSBOHjrCsjYT6woZX0j2bEZQfFiq15JioPgojuZTSNghz4CoU0pKYfx0iLr4UAHQ/JE7Ps969DQyxGBhE1nqo+Mdb2tiEDWQnfl8lJkdEKHENNj0FnsikW50zPeoIi2Nq2IeoqvShPEv0JYt7tOxUFUI1IFo0btc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=c4GW14mp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d2c35c459so8699315ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1758808910; x=1759413710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PurwojXW42p1Ea6TjGCm66kdVtMgVLqRO+Vkan7WMsQ=;
        b=c4GW14mpDrDRWzvG3LyUi1dNNAU7bzgVLfpytfvMPRem+7W3afCALAs2KIMbygsMV8
         SGl4bumX3WnbRRoOzZerIyjKj8LTFpPZC38fpvO9f81BDSf3dpkHFjB1rxpnEn9dlbt8
         ef+8oQ9PKHIA36L8zJ77RZ5VBuYSKN1tQdA4gjPwLZJ0UNMiRautDqeuplugpGmjNHSx
         zYCpzoQU27tWEyBirCmK5HteXXw3V/DhsSlHiRFR24BJROKO/D+9dovvy0UuqlSKvmEc
         MS+Cso58xAibGEXfrX0hXTaWiqXxUMqxo8GcPmjKB1B+UacVyNms7YjNFc0dm5e0Miwi
         ufJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808910; x=1759413710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PurwojXW42p1Ea6TjGCm66kdVtMgVLqRO+Vkan7WMsQ=;
        b=EOLl06IEe7piAj79cVxaQhAHAGPr5/agI7FeRCBT4DdjQhx7NSA59MN5wDHRDVIto7
         PpQMkQII8Ogm+LUPQrBCYZmKN7xfcI6Ce/2IkE8PrdLFxsF4mlvU6Sa+pFHhwK39TWnu
         pYIPBNJAjTqa7eQypERrSI9OPlgg/Vc8hu8Woe+84VLoc/gR9zBHwEUJz134gpTbwUKv
         PgEVSRwCzMRoDtMXHWOTAMJJ5oufHhb3ZHQmUyKOs9+4GEZzoaFkpYgnNYHIFU8g3BmJ
         x2b6N5aSEH9bbnRFTg7zcYicMmq0rbM2I/j73hWeUKPlddM37W2xj/0TwXRaFX3jtNf3
         RRSA==
X-Forwarded-Encrypted: i=1; AJvYcCWKKH4CXyiXrcYaUN6GVU4ynlAxeJG+1pliz4UcH4vPfjxFGaa5psl7P16yXyusslAWUjptytQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyahzQiNc9K1rF12Xn0XNVSjYw41f4vjEbZLEZ0w/X98SVfb+F
	Vw+1RZlWLPqH00Rhvv565SiHnghGFidf9eozVOkaC8pVKcfR3iPrZIZIOvlmID2RZne/E94SEc1
	TF5mPgFkghlBjO8SJluePyBBOXQGcvFqZuFLOySLs9A==
X-Gm-Gg: ASbGncsIIw+jyXfsKtNcAecuy3gAwmYpoJniH/tFn5dP5t1sqf5unAzenP5B3xBMP1f
	AAsPgESCnU5J58IWi6W7dJ+VOtXs6FbdFl01VjNBn6CDqfsVq+wA9A+B4bjVZhIIJKV8PXnxHQb
	wUBwniTqczvE6zJvCid0EfDBgBMo9oKa3VXpPz7K/tWa51YZ1VZ6/ZNOZwHG7T1ukk0ZJiCNBuc
	xfWBb2S
X-Google-Smtp-Source: AGHT+IGmZXilWNxwYgBcKbc6hih4iARYQoqak7umqVJERuXyi1uPcrkBreRcdsoYZIR+u2B/o4PbjmPkIPAThYGDoRU=
X-Received: by 2002:a17:902:db06:b0:25c:46cd:1dc1 with SMTP id
 d9443c01a7336-27ed4a2d078mr38373545ad.33.1758808909364; Thu, 25 Sep 2025
 07:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923134742.1399800-1-maxtram95@gmail.com> <20250923134742.1399800-2-maxtram95@gmail.com>
 <06363f8e-c99e-4672-a02e-ec9b0c27003c@redhat.com>
In-Reply-To: <06363f8e-c99e-4672-a02e-ec9b0c27003c@redhat.com>
From: Maxim Mikityanskiy <maxim@isovalent.com>
Date: Thu, 25 Sep 2025 17:01:33 +0300
X-Gm-Features: AS18NWBzNkDKW0tnZfNtnqc6fduJY6DIl0AS_PQENClwpa3jNV0iojL33gqk8vY
Message-ID: <CAD0BsJU2XHk=PFs3h38t-R2ZThry0v0+sB1E1Dzh50Hj-2RXzQ@mail.gmail.com>
Subject: Re: [PATCH net-next 01/17] net/ipv6: Introduce payload_len helpers
To: Paolo Abeni <pabeni@redhat.com>
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	tcpdump-workers@lists.tcpdump.org, Guy Harris <gharris@sonic.net>, 
	Michael Richardson <mcr@sandelman.ca>, Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 16:51, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
>
> Only a single 'From:' tag is needed. This applies to all the patches in
> this series.

ACK, sorry for that =/

I had situations when git send-email didn't add the From tag at all,
so I started using git format-patch --force-in-body-from, and it
worked well for some while, until this time, when both commands added
the tag. I'll make sure to test it next time before sending, if I need
to resubmit.

> /P
>

