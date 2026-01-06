Return-Path: <netdev+bounces-247379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990EDCF900B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094B23035301
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86271340D84;
	Tue,  6 Jan 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1YscHWNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822134029C
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712111; cv=none; b=pbc51yW9NG9pAPtKswrvZqdeR5lEj5JRWbl9pVTDlgSSnP78UCioJslGzUNw2ednMlpOBkibO3jCXiu4K/CAgSgNzr+0y5gth+uXFOEwI+iISn/fIUma5xtj37u4gbPy+e6c6cLxgTK6EjzmD5gJ0H3cwimeH6pJ4Bt9PZZSnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712111; c=relaxed/simple;
	bh=2D9VXICvKZXTMT+5gA3rn72FGvDblCKZDoXgV71TMb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/127eQA0xQ3Pdp7EPMQMjDcgAVp7puahdep+RxVIL1JphG7U5+Ch4MEnNjZYy1vkbgtK5aQXMwPRuvxMtQOySoR9f6GTDs0+Dc5tjw4W8eCpgMioz8RzocFG9qQx+PS1IW4uY+ktI5M1/ph0MtAhbRj5c9YoFkT1cFzhatzA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1YscHWNn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cc50eb0882so447496a34.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767712108; x=1768316908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0msI1TfCf/9Rk+eegzQnF/KlXWSIbpcdl+S1KgTmAo=;
        b=1YscHWNnjoSeyCk6sXkOfAfhc2iqECBHjs/QMB6o+K5pF/KVd6Hnm6TqQLdEt5bDrn
         aq29EerpJXscDQhz3iARSLMbnPtw2JW32ohPpdZu7sm6hJJnEc7s1xBGvRSuTXRUeplD
         HCQbH/3O10T8iQTJ3gsovKj8zuC0Z8m/chPZyovKYGGonZ9X47DrLuXmHkc1ohtXApOU
         OHgyvPLcvbuHCWUlw7oAooEtiGZSuaNzowXx3fckRNHgJLyqRbzke0iHQzu8EtcUGOg3
         /faRAL5QOIOnDrfgzH7C0GM9sXGYDYVNIv7HMO+l+E3vc5mB0nPw2xm9pLYopgo1sMGv
         064g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712108; x=1768316908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0msI1TfCf/9Rk+eegzQnF/KlXWSIbpcdl+S1KgTmAo=;
        b=M73SoFv71MdFPgHM+OgE7PgZ5rguqVyiIqeSUGxc8gSvETf1tfWOd3bPTdNvkEq0un
         wVE4sqmgchoHdvwIzBJjnsK6MsGul2+LWtHVdEZwiELudlhlG/tCvVbrZWQXkQpS+qMT
         TlrHZABRxCYFo/ON3eCHa7ZpcV2dwmMaDJN2r8MdBIsMXN3QQ1zDI4Ek2qDxWgZzTOu4
         jGCSbISjIPMjg6jzY+ng8VjL6TvHLo3pgUIdEiXFT+tAb65Qhnhy8XJEdumU2Sxbo70R
         r3ph3xHNf08EgviqIwxKG06hHpa4vNMYqipCkd/NSbylc7Kqth2dIY3BZWHIBSdLSFLS
         ESfw==
X-Forwarded-Encrypted: i=1; AJvYcCWUcYV8EiPFsuZXJ/NiGOdl2GTTyBIcCloVFUA+QmOyPnE8A0mMVlxzp3rZRooRJ1R/kOTvpsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEjN7ggQD/W1Mc3vXMJdORWtqH3NNFMKq5mjWoR5svs0yuEBm
	sYIHgxLn/4hDuc8kaaqOfmQz5zDI8b1+Dv6xLMiRf0L+0/WHjayF+XUp8RJvR3jQc/c=
X-Gm-Gg: AY/fxX4ypPVp4QLIolzv80wuND8E2BfAQcLBgAFS+9VXosvoiNJkSnMv/qWFNnqFBcV
	QTm2lIbC4UdKI/iBo4NdFC6ajxEdlxi2V4dj6FRC7jHBuZRHJA2wsfvhoWcDSLReOOSdeSeJ0O3
	urKnh2KaKbsQeP5Uc16R3cUKSuT2pypzdQQ4/cbLhrfCo59CL6uyEDQE7kELeFClRvCTWVBbnm8
	hz+NWNtcaDiSMJfAS/2MQ3Br97CmJ0YXw1Oz2QxSarfw7u1ZNsBw0VOe530/iBvIF5dh68yrCVY
	DoQS/CekrSS5trm4UI/Kclk9fLKaLqb/LjhpI+MtvBPVKwM38XAi66UcTissB+GIkWrDPP4A3dI
	58TTPlJ/curM9UcOLOO6eav0YPLVToWI1g8Y3dPz9HQez+UGQgJV3i23koeZJNwHCQWqkARoDho
	9sIXy4FvA=
X-Google-Smtp-Source: AGHT+IFjPiBLPajwzjq5MHGB+HObU6HlOdcwgRgvouUEiKnCSsLF+zJC/Wx91AHU7dJLuyDahtyZMQ==
X-Received: by 2002:a05:6830:2e07:b0:7cd:dc79:9f87 with SMTP id 46e09a7af769-7ce467429damr1618877a34.35.1767712108109;
        Tue, 06 Jan 2026 07:08:28 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm1553233a34.12.2026.01.06.07.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 07:08:27 -0800 (PST)
Message-ID: <aeaca3bf-b6e6-48e4-9493-6c200a49d1ec@kernel.dk>
Date: Tue, 6 Jan 2026 08:08:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not write to msg_get_inq in callee
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
References: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 8:05 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> NULL pointer dereference fix.
> 
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
> 
> This is a kernel-internal variant of msghdr only, and the only user
> does reinitialize the field. So this is not critical for that reason.
> But it is more robust to avoid the write, and slightly simpler code.
> And it fixes a bug, see below.
> 
> Callers set msg_get_inq to request the input queue length to be
> returned in msg_inq. This is equivalent to but independent from the
> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> To reduce branching in the hot path the second also sets the msg_inq.
> That is WAI.
> 
> This is a fix to commit 4d1442979e4a ("af_unix: don't post cmsg for
> SO_INQ unless explicitly asked for"), which fixed the inverse.
> 
> Also avoid NULL pointer dereference in unix_stream_read_generic if
> state->msg is NULL and msg->msg_get_inq is written. A NULL state->msg
> can happen when splicing as of commit 2b514574f7e8 ("net: af_unix:
> implement splice for stream af_unix sockets").
> 
> Also collapse two branches using a bitwise or.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4d1442979e4a ("af_unix: don't post cmsg for SO_INQ unless explicitly asked for")
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Jens, I dropped your Reviewed-by because of the commit message updates.
> But code is unchanged.

Still looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks for doing this!

-- 
Jens Axboe


