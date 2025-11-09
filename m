Return-Path: <netdev+bounces-237028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E084C43ABF
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7728A3ADB5F
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C62D3220;
	Sun,  9 Nov 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJSKXDRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768613D891
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680711; cv=none; b=XgQzewOBmYjmURI5heRnXqNuFSMLppT8RjuVteyQMFoXfZTMoQ9+k3uix2qNO0jy7ed4Xn0Fgy8T+bFklLWsc4jWEoYlE0wMDtCNU3lHqU768RAw5gwZTW6ofFCgsPfq80FNT31MEca1SIJBzDjJznl8QDPoA6oSxDPfRCjsXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680711; c=relaxed/simple;
	bh=hPkTgHP3Hv2/6rXe/RVYEDt2gVMAEwcWMjbjOLLoAtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWKrhq48aefhw2jYKJ420mRc+wzgB7NpmJJKL2xgtTP0yzHCuZgAGVYyZM/wUQorzXebCEpLCuzU+K67Ynu4siWit8mXpMFCOq5M/fGra/KJVAdHCfOF49ITc3IV788De96Qztud4uzlY39+OlgvH8G55Hx5tzEMx51sGloNy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJSKXDRp; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f996d4e1aso1797956d50.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 01:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762680709; x=1763285509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HZaElzEJkraTHYapSKRSbW0h0uFmQOHcb1D+rqS6Ts=;
        b=lJSKXDRpkEsw1GFhUmYjUNX87MS0KbRU6xSqkGc5dTBUozBhxg9McCUERk0otTXw7b
         5cmTcKH1CWiw4Qd3qNod8cVlB6MdD7ggbKHR4pcBFicFl9NX5fptuI4MknAwG26Hk5yi
         cWEG7YjJ7rUyF1sFRP/8HpVTZZnaE5mx/vZd8xtxkt6HINSzymP0IydCnn6nlfxRbiX+
         k3wE10YYqUcxc4xG0ohzRCiRUNUMgb2U6FNJ6sGaUrBKOo01mSzcTo0Gwsx2P0zQysmS
         V9M8iFRSgYK6vqh7Sr9iPsdamyRbGtY0NLdwjkkjGzSYb32gAmSokXruGofTBP1gw3fW
         Q2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762680709; x=1763285509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HZaElzEJkraTHYapSKRSbW0h0uFmQOHcb1D+rqS6Ts=;
        b=FG4kzDmd3/a8dfOMEMEXIQ8kng/wx6Aop9qF7klbAHkOnd6xflHsLev5OpNTBUXsiV
         gu8BTMDs0jPUdlp0sOhPTHc+gfa1V4Skas1fHKx0jloP5ScDAqo2+YNN6JZ/fBbnBf8I
         iT9GHitULA8u7wvXKCpCZLZPo50LwexpaxkVwlNampCLFXxeLj/2pJdG6cU2ZJrh5Ojr
         3D/otDSqnZahobBJ7Hg+hAO6yAM4C+APdNcHfVGs2XwpvLzSD/Tw1cUklsAwqHgzGK66
         QxY9hjbbJWEmYK/ncLuOQRw7h4bWIF9FL221CwysZ9i5683N/s+mbvna7l+TWlyhZS6O
         hLKw==
X-Forwarded-Encrypted: i=1; AJvYcCWrtu0MvuyaySjeshbS+ehuCr9vgjgDtl3AwMdf1F/XCAg4rJ+7v1KIkt4p29+heo1Erbzg0xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHkbHJx14jVcEGbaQOaVsEat01EnXFEuw8ZOcSCvAYijyPVEZ
	2S1O3GeIoM1LUbA/l/mmF/JjO2ufLlzcrbzclciXqGKTf0YgccMQ5l3fse5G32sE7NBgV3oR5pc
	zUIW1JMq4mT7d/D5GHl573cgINLcjCQj4Z5jsNtbq
X-Gm-Gg: ASbGncs+dnr43QOpjKJpvMlci0SFXg+hVhyAnVRM2wRKPkbM/AhPih0anWSKvaaVDoE
	HKKAEvPPgq5p8AHIxUKSCiNblX6tnar0Zu9MEaphNIt9IVrBgWZekaEEfXde4JGyj0vf7z+fHS6
	8YOe+UmLa8McV6fjTaTy0YTZo2+DLzI3Y6xYHEP85WWGysQy0yze8mnCZOB+1TOb8mL0QRqcGsn
	agsW8QJrsvHAlFVq+s89nOVK4TdZcvdi2XLws9GjiZI8pRl7VvWCYYii28=
X-Google-Smtp-Source: AGHT+IHExbmd94XODd05iEGCcQd1srrzSIN7UIH14jyUM1RImV7jgMoSkQu0PXbe0bo1KRvomjWgEXQIwiUIddDQ8J8=
X-Received: by 2002:a53:d006:0:b0:63f:b6df:d672 with SMTP id
 956f58d0204a3-640d4565047mr3902580d50.30.1762680709264; Sun, 09 Nov 2025
 01:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com> <20251109091336.9277-3-vnranganath.20@gmail.com>
In-Reply-To: <20251109091336.9277-3-vnranganath.20@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 01:31:37 -0800
X-Gm-Features: AWmQ_bkQKxm-BD7yPuJFkaqgGgeGWRR70rJTDtuxqOaFYHjh4bzsQyH8YuV9LN0
Message-ID: <CANn89iLZ6yHEga7zK7Ekcn=pPjS_3LZ1ixWbXQ_hmKtF9cmqcw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, david.hunter.linux@gmail.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, khalid@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 1:14=E2=80=AFAM Ranganath V N <vnranganath.20@gmail.=
com> wrote:
>
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
>
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
>
> This change silences the KMSAN report and prevents potential information
> leaks from the kernel memory.
>
> This fix has been tested and validated by syzbot. This patch closes the
> bug reported at the following syzkaller link and ensures no infoleak.
>
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Fixes: ef6980b6becb ("introduce IFE action")
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

