Return-Path: <netdev+bounces-70611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3784FC7A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 19:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563F71F2645E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8880C16;
	Fri,  9 Feb 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v9qjnWvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491574E09
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505159; cv=none; b=rH8o+BMLU50DW9rpQEwUjtLn4PHvwCTKEtqGJ+zMjEFIXtSuOYTBp7NAAiWvYLD/IINozaqpqnwdIVP0JUDarAujY88YwbHq3En0NyMNHDNlg+VwhRumxieqU9yTYd8SRXOWeI29HLtzagXtsTKJwwJf6/SPs4qJiC6+ddXke1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505159; c=relaxed/simple;
	bh=FuKeRVEHvqr0Ai9dEH/ibDBBYFeDaC7JibLB1iKI/OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcARSPmqMdOIPBLIejAKZBF5wpp9UbOfMb0hbFXn+Bj2jaaR4BP1fPwLYOHCA2bTmj4hG9fGvsuVXsoPbGjMBeVtGaTMzeL6hnbDlqv9H813PPkxdpyx1a5bAq7vt4HNjEsegqUcMunNTL4Yla+fYbB31bbi+FVwquOSw4TzajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v9qjnWvG; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so12503939f.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707505154; x=1708109954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCFSfPTt9vhKr7HB9Bbes7G77291Y2duWn7XOAn95uc=;
        b=v9qjnWvGPQvAknFAQgpUkojaFYIuUSEFLV49N6gk76lgBODoT2QvqiQwztAym6bj8r
         +yNYFG6pNA3p29IJdpwMZgQQIBF1tPC+ApT6g7DtOsG2lbiHuuNepI9W+gymXm9vG6Ap
         PIH3lPBS7rVHogbLBlR/OAKM4q3eCt1NF08LGhL2DzGDgHxfCNLmuTB/RDMH4KMMtBOs
         GFIOwjAp97uxdhS5SxFVcpgz9Jh4yrgA42yvxtxqOpbMZOsYeJhqT5DLnqPDnzHrTUyF
         Kqkz2XoqxfATZn5OKDMNLy2RfKG6kYsjexUfRuj8g/1i+ICFu+JQ5+y01Lww35mO7+ah
         wPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505154; x=1708109954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCFSfPTt9vhKr7HB9Bbes7G77291Y2duWn7XOAn95uc=;
        b=Pow73l9mqqXKOdm/qhNGbXEyQ0SRJXhrmgSdhiwpc2hUgZ+kdqyCfTLcHzHrKA0bfs
         DIecFdXWOHb/W+WKNPj3L5o/Ii9PaFWARjMwA80GHQS890EEQblncUoSSpR/lA/GHuO/
         rw/VoiVb152a7/4PftN567HByMqVEg1nkdvDW7hgFOGSxklzLXIBlf9U7rnYCPeXYm27
         DcJbtYPi3y/R47tpolVenrLWAOmfjpQ0pzsfqS5sY0go8o47OI+cPV+mE6R8V4jsSfsc
         jCSC4fxatFkfjcchpWtfWkM7cEeu0UA4hkrqydj1swrZvEcuFjfrQblLrc4SZ/T04ko/
         tSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYGnyXrHS13JTmJMdhgcreLH3+jf44e//3GGrD+Foi3IUc7PTM6+kvPc2RvxfRDe/xr9XRNYe7AosmZGQHDjVfhzkspeAv
X-Gm-Message-State: AOJu0Yyo2QikWKubvBB3Kx77MS7UioGBhXMZfFdyFV3fPF+10BXqe+6e
	eAVwzB9Rwz0rUPbOwjGMm6A5dhH68lrNxOPZt4nszCQVTEkvBfbUHhY6YPROaF0=
X-Google-Smtp-Source: AGHT+IE+ark8q4Z1GehIUR8/gcq3dRKNUEMfvhBqn2eiTkZRByPPkl8ZeYlzrzmOu+hgt39LmrGIgA==
X-Received: by 2002:a6b:3f08:0:b0:7c4:655:6e05 with SMTP id m8-20020a6b3f08000000b007c406556e05mr221669ioa.2.1707505154202;
        Fri, 09 Feb 2024 10:59:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAfPTmBIDas0YsE0TgGAHGG8+3yoinx8HkwMW6/P5gr9MtNPew9o0ZBLbuo+kXZFHVSsNost6CbVMJ9IL/640gdPJN8ShcRIqSxjFyCkVCeGFZ4gOQ7tkbo2ljYGcF
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z26-20020a056602081a00b007c0126a5a38sm565975iow.46.2024.02.09.10.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 10:59:13 -0800 (PST)
Message-ID: <0da3e548-1b20-4ec6-8de3-e2c4d1c86d47@kernel.dk>
Date: Fri, 9 Feb 2024 11:59:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v16 0/7] io_uring: add napi busy polling support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, olivier@trillion01.com
References: <20240206163422.646218-1-axboe@kernel.dk>
 <20240209105105.114364e7@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240209105105.114364e7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 11:51 AM, Jakub Kicinski wrote:
> On Tue,  6 Feb 2024 09:30:02 -0700 Jens Axboe wrote:
>> I finally got around to testing this patchset in its current form, and
>> results look fine to me. It Works. Using the basic ping/pong test that's
>> part of the liburing addition, without enabling NAPI I get:
> 
> Pushed the first two to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git for-io_uring-add-napi-busy-polling-support

Thanks Jakub, I'll pull that branch in.

-- 
Jens Axboe


