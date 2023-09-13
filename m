Return-Path: <netdev+bounces-33666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12979F236
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 21:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D932817E6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255921DA25;
	Wed, 13 Sep 2023 19:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B51A712
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 19:37:41 +0000 (UTC)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C6B7
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:37:41 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34bae11c5a6so283705ab.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694633861; x=1695238661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhwqcJyiHRKzhkFLCqAMWqYlbatsaAzAVD8x6PqKtCw=;
        b=YT699XkY86ZlM0MOuldPSOGbn2Ah+9+OmoBnK/8XBwS6OmARZ02dNh4rKWnd0XpCbO
         QS3nWdDFA5MNBQy7CJYdlvJJXWyfPeiY38arccQB066IPyf4iNtdh0ushI5omZXL0jdX
         xRPSV3tDPgySipxyBxt6m6QEhrXOuq4y8LDeyZzM5Fr+KzdtqHY8ePHnl2tgUJDizS99
         XCRDMNIr4A5+Frwm1K+Omz4d8FUWurSULafeObEkB8xJT9spMHSHHkYTNzkuLXZPB/FT
         J4j8ILe9YNE8vXvstDYAb+omm7j8RzI7EhHBrLnarRiz3NEwulGWM/Ovi6jvUu5dVaIc
         6TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633861; x=1695238661;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhwqcJyiHRKzhkFLCqAMWqYlbatsaAzAVD8x6PqKtCw=;
        b=iWNmmq5J3xzo/k+1kPcReq+el5webaytd6cAQtigo3X9J2BTtLgiheraQ0IYHIZ8/Y
         ibL+BZ12trFvzZA3uefLTZmCZO0FStfHRYb95xdruDhvG4s/A0AxGc3Sty4WrhtAeGXd
         KGT6L/rv9TY2k/FnDTX132lKgAQcy5LZu2n/sCFES7vJexLmyrcI2AG1HsASMErnC0Fm
         BtyiRF3GtGb0hxensYyN7xt1IiCtEaUN+8vSf7Yi+kOldt5SBai5pfsyYyu+TptI17no
         Dc0iTIp3PL3jtDCf356dxbytzKKXkN3ImUG5TB8oyUoeTcxLqWQY0zZVgZmOvRC0QqFM
         isug==
X-Gm-Message-State: AOJu0YzDV9oq1VYKx7OQBeWxPQhdhzWzZ9A4n2kHFOSA9jZKVSY80zAr
	ABl2B+8TrzDC2Z3XytuPd6liEQ==
X-Google-Smtp-Source: AGHT+IFKIK6yKbRFFo+tMkqeQy0vMUFczzDENOs7bMO2ZcLHbVid1uXdEFQsWAaRQsk0w8Gj+rWROw==
X-Received: by 2002:a05:6602:164b:b0:795:172f:977a with SMTP id y11-20020a056602164b00b00795172f977amr4169395iow.1.1694633860859;
        Wed, 13 Sep 2023 12:37:40 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o26-20020a02c6ba000000b00433f32f6e3dsm3659503jan.29.2023.09.13.12.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:37:40 -0700 (PDT)
Message-ID: <3b56190a-e651-43e9-ad16-0d0797593904@kernel.dk>
Date: Wed, 13 Sep 2023 13:37:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Breno Leitao <leitao@debian.org>, sdf@google.com, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, krisman@suse.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20230913152744.2333228-1-leitao@debian.org>
 <20230913152744.2333228-7-leitao@debian.org>
 <d606f285-a31f-4b36-a7a9-bd913e1b0836@kernel.dk>
In-Reply-To: <d606f285-a31f-4b36-a7a9-bd913e1b0836@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/23 1:36 PM, Jens Axboe wrote:
> On 9/13/23 9:27 AM, Breno Leitao wrote:
>> Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
>> level is SOL_SOCKET. This is similar to the getsockopt(2) system
>> call, and both parameters are pointers to userspace.
>>
>> Important to say that userspace needs to keep the pointer alive until
>> the CQE is completed.
> 
> Since it's holding the data needed, this is true for any request that
> is writing data. IOW, this is not unusual and should be taken for
> granted. I think this may warrant a bit of rewording if the patch is
> respun, if not then just ignore it.

reads data of course, writing into the userspace buffer.

-- 
Jens Axboe


