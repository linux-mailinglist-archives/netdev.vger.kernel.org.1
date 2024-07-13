Return-Path: <netdev+bounces-111229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC919304C1
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 11:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA321F21A64
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0C45BE3;
	Sat, 13 Jul 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cHDcSTRx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D2D2F5
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720863950; cv=none; b=om/pggDEVdfclr5ij3mPvc06VQd2CsIzXrfc7sQOknp7m6BjrlCqIKofm5Cj4ApoKZlTUkuRyU6ilAkk8oIbXJp9nRDuiwAlQC12adC3scy+gog6mPqi55selV5Vk3XrjnUV/JjtaE/D2gxD0s1eS21v4Tg/Fx5kpnCPZbSyNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720863950; c=relaxed/simple;
	bh=8qF7UPeRZhj/HTohlSa2VCmCw/D+IbTZFZb7+YXe6YM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=al/IaKZrHBdkejT6KtZPesDabqPulDjP8aG1yyMzHQKdg84tss0YdTBW+4MzoxQDcI9Urz6t8Phnn7fNzDqPviRHPRIKBvJgokpMltOxE/ubk6xXRpUMRGw17pY9jk8BUCP5FuorxyXiripDVOcXFWIm9D5s/FDE3E9a+OEc+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cHDcSTRx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77e5929033so380867766b.0
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720863947; x=1721468747; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nh+8YXuAxTLUPYSeGC7W1T0QQtjQ7blnhe3sgUvJW8=;
        b=cHDcSTRxUsjwYeKhUjJ/H2rcqdmwXmqP9JHyHsug5bD7pkfVmCpEaTNunUlsYwyM/f
         mhVQjLwZOvmO3itZSNo5doQPOsDsgPULiEfErFeRLzEUakxW7zWI26kI4AlRrrwW+ZUW
         2gUDAF7Jslk3wnWKVYi8s+mJBQ1avYj/PYM8/+IeTtkbCP+d5Ft+xswl9yPQa6Xqqm4F
         nb36UFWOI9ZKFxayKOlSO5I3EinqtbJGDg5Om4NeN2RQg0KPDjy+cbG9ExhgPhnE1LZ4
         XDctn7QGmnlMfm2kxntcUfzsNUZ1cEKnT609okxsy5OFeItYu0A9Qyzc3UyYAG2m5sBy
         HDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720863947; x=1721468747;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nh+8YXuAxTLUPYSeGC7W1T0QQtjQ7blnhe3sgUvJW8=;
        b=Ntb/uY0q1RRZ0x87ISUEttxG3UlxJJkOcrnSCmWfSyXO14NQiLsS10wtUNY4M/2FYa
         Fbf6LjfdYMHvKcEM6slRofLpDx9AQXbFFFM0XG619qOkx5sYy/Noe8Hm9vVjD2APYSK8
         yXfUZLGJeB0XEwwNr7tLwdOP29Nu0YWssGvkhyZfoPDQoF+TRu0+SA0icS5xJTgiZ4bk
         /scy2D0qoi3WXq9jswrG2QkRaQba1CVzQ3s2MnPWIRxzu70Eek3gP6t8nDarqKIpTrwB
         PKygk2pVet5qchnnTiwnINcIaKrJ3oQLRsoDGW6ZCSScxbcHTisYJ3i3h2LAirRBsvE0
         utbg==
X-Gm-Message-State: AOJu0Yzd/MlYRPhriuw75zNB42nMo7yjf8GJ5E5L0cDduAph0XSGh1Vn
	DpzC1Zov2PtXIxI88dfSNNL91PuGMglfpHkdpcF16mepaVX1ANeAcSHvG7dTqIE=
X-Google-Smtp-Source: AGHT+IFXtRW+ihxAl3u041y0SF2jGut4b+Mhn19tk41jsYq1JkTX9JRCKPwJHkjJuHOG0nSw5REeLw==
X-Received: by 2002:a17:906:e57:b0:a77:dbf0:d22 with SMTP id a640c23a62f3a-a780b89ca72mr860650666b.65.1720863947206;
        Sat, 13 Jul 2024 02:45:47 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc3cb347sm36959166b.0.2024.07.13.02.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 02:45:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
In-Reply-To: <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co> (Michal Luczaj's
	message of "Thu, 11 Jul 2024 22:33:17 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-3-mhal@rbox.co>
	<87zfqqnbex.fsf@cloudflare.com>
	<fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Sat, 13 Jul 2024 11:45:45 +0200
Message-ID: <87ikx962wm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
> On 7/9/24 11:48, Jakub Sitnicki wrote:
>> On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
>>> Function ignores the AF_INET socket type argument, SOCK_DGRAM is hardcoded.
>>> Fix to respect the argument provided.
>>>
>>> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>> 
>> Thanks for the fixup.
>> 
>> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>
> Ugh, my commit message is wrong. Change is for socketpair(AF_UNIX), not
> inet_socketpair(). Sorry, will fix.

Right. Didn't catch that. You can keep my Reviewed-by nevertheless.

> Speaking of fixups, do you want it tagged with Fixes: 75e0e27db6cf
> ("selftest/bpf: Change udp to inet in some function names")?

Yes, we can add Fixes if we want the change to be backported to stable
kernels, or just for information.

> And looking at that commit[1], inet_unix_redir_to_connected() has its
> @type ignored, too.  Same treatment?

That one will not be a trivial fix like this case. inet_socketpair()
won't work for TCP as is. It will fail trying to connect() a listening
socket (p0). I recall now that we are in this state due to some
abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
inet in some function names").

If we bundle stuff together then it takes more energy to push it through
(iterations, reviews). I find it easier to keep the scope down to
minimum for a series.

