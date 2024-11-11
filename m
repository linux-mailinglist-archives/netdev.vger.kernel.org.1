Return-Path: <netdev+bounces-143717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640C9C3CD8
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B90C1F21050
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94A1553BB;
	Mon, 11 Nov 2024 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4hcjgHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2D13C670
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323866; cv=none; b=QR/aWmZbunDGqYQv2kjlG4AW61zw27Cfvppd8G9Dsfs/ObA4xud7CCfDyNXphUes0poTxIMwy7X6dym6xzB4wrvQ7+1z9bXuHxwKcyh7ko8lXpjrvAjLciY7W5zLXX003OAWNUONJxhqpNwaMknleu6jnDtRCAQz57mpkh9w/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323866; c=relaxed/simple;
	bh=4oDl4B4/ux8EYr2lp2RkqSAdwLHUg7QL98FibLVFy5I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RWbDrpJopBPTBvo2w3ukaJ4l7XGImGcnVT5JW4kAmH5rw8CMeqoJ6L03rsbLsruxmzzPQWPxIGjbIyY32GBLN6pBe84noEYlKU6mQzg1lv9L0fjRaOX+ZWdunOX8ZT/yzzNRLCzTkN6uqfjNy/U0RwcdfqGw8LyZUeAD6yO7Atw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4hcjgHs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2896371f8f.0
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 03:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731323864; x=1731928664; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GM7VxP1BLjFEwOuCCE8GDFmFjQcazMuTWw21G92i1CQ=;
        b=H4hcjgHsfTbMf8BhRA+RnFvSCVo4g53js0lgBpsT+uto5XPGnd5g95bRYCxwaEuouy
         JuK348JNSw6q4Dvcczfo7Z7OEdmu9NT8dwG2rX6DFsOGsZXYa3cEfN+FYkgrgzxtx2zp
         rdsYl5db0L3WmELmWLsWXmXgoIgEXXcEW4c06ylZAFYjIGXQEmSYmMMsbGlPIoBA9GuE
         rk/49kTiIcxEeWLqYH3n+fqK6W1OkKYC/iPGLxjaye3c93C04rymZe+aNehJb0vNGUMT
         5iZNVV9e9CR3G1CL2xt3qfZ/kQhFIddBg7SoQM9xU2Ge91o8D0Pd3PhNgTT9Bj2BNXY9
         LgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323864; x=1731928664;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM7VxP1BLjFEwOuCCE8GDFmFjQcazMuTWw21G92i1CQ=;
        b=tl3SBc3nsK5F8CVdSCEqw90jk3a4ghxd4uVHBKAMrLJJ/85+Kk2Opfi3uJOqx7ZVc+
         zTxccEnpnoXWj1nsPED/ztIJ3eYL9Fy4JXmt0K7yQkH48w2KdSFFTAZ1GgAlPSLkG/lA
         CcGk1/kMYGPKWj2IsJ8/Imqnv0Uf3jAlOTC2mc9q7sGu2g28Yvz0wlcXiuR2reqT2bM1
         S1LgtBVzyktUAJQ+cgghi8Tml/mk7Jt9HyizVu8TMPlsEOKC0auVo/JwNVbBhJ0Mbuzu
         hIZP/s5iCa1xB3yvHRKaMOpefGKC9KsNRMyilL5vdvL75mu0sSfVL8lIPhNaMozilSci
         71yg==
X-Gm-Message-State: AOJu0Yz8ks/JAj8u/sfhY1N9kwddNEVo6pM7FR8aPcK+1+/tVlKbjbWe
	mPeRuguA2Z9UfKsBoRFsP+yF9Sd8MSS8t96bVZLDDC4/B6Ye7BIc
X-Google-Smtp-Source: AGHT+IE/3+ztNrqp9qNyti99WutlLHxZhOuFO4mllOygrzlLIPCRwI4/cIrFTb7o/F0vaXDk7r4w1Q==
X-Received: by 2002:a5d:6483:0:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-381f1726226mr10677491f8f.10.1731323863518;
        Mon, 11 Nov 2024 03:17:43 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:b5f4:2297:43fd:c165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ceasm12440017f8f.102.2024.11.11.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:17:42 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Xiao Liang <shaw.leon@gmail.com>,  Jiri Pirko
 <jiri@resnulli.us>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: add async notification
 handling
In-Reply-To: <20241109134011.560db783@kernel.org> (Jakub Kicinski's message of
	"Sat, 9 Nov 2024 13:40:11 -0800")
Date: Mon, 11 Nov 2024 11:06:18 +0000
Message-ID: <m2cyj2uj11.fsf@gmail.com>
References: <20241108123816.59521-1-donald.hunter@gmail.com>
	<20241108123816.59521-3-donald.hunter@gmail.com>
	<20241109134011.560db783@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri,  8 Nov 2024 12:38:16 +0000 Donald Hunter wrote:
>> +    def poll_ntf(self, interval=0.1, duration=None):
>> +        endtime = time.time() + duration if duration else None
>
> could we default duration to 0 and always check endtime?
> I think we can assume that time doesn't go back for simplicity

I don't follow; what are you suggesting I initialise endtime to when
duration is 0 ?

>> +        while True:
>> +            try:
>> +                self.check_ntf()
>> +                yield self.async_msg_queue.get_nowait()
>> +            except queue.Empty:
>> +                try:
>> +                    time.sleep(interval)
>
> Maybe select or epoll would be better that periodic checks?

This was the limit of my python knowledge TBH. I can try using python
selectors but I suspect periodic checks will still be needed to reliably
check the endtime.

>> +                except KeyboardInterrupt:
>> +                    return
>> +            if endtime and endtime < time.time():
>> +                return

