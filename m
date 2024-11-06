Return-Path: <netdev+bounces-142417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B79BEFF9
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DCF1F222CC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CDE2010F2;
	Wed,  6 Nov 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgFBXw8x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456931CF2A0
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902772; cv=none; b=CCFOAPxnBf+LE3dxvcCR5MsMwErLs9pgm1ngfV1TDQPCuc10YzHfuPzxA01WxuexH9LqAhObEVwkSfAl35XXkoOY4+sM3joQnKveYglnRvBgg9lFVIqhuvoYAZv7TJCITZst9+3o1eoSFfQWV4pnFzc4RRGKBf9Ee11882D+mfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902772; c=relaxed/simple;
	bh=oiZFuhIF4QoiUNWgqbOD3mWFkvRKU+gcd45dtB8AByk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnufdCCB2brPbMBxrJF3hSeFB3wcj3Bz5uTQND58KELizSnJvMaaXRjKGAFHw8I9kGRvSLd14bHUOmdvrGgXeCfF3hwwLFS0f+99fdxb3CkmyaifQOB+VS1FqmLrGYvMAkp/pJ9FkSg8cELnnEA9577nHK3Vt7JweFfl6CEfAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgFBXw8x; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso4926424a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 06:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730902769; x=1731507569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoVh6I+sgW0HCrktUilyDaZ92RmL1a324ePT2UFI6EI=;
        b=JgFBXw8x9mF5/e6K+oxgHwi3o4wdM74FUZLFszm5J8Bt9t2ma1KidckzXZ62XDRURe
         vD9d0AU57gF6cB55rIpyL36GX4lnSVUUp19Q/zyNVE6qNaPGQ9VXtjErgAVi4X/fbFfP
         Exe4CDhLcdQ3SBYnx6UR5XnTOzM0d5GD7Ds6sR3MxIUtLW4d1tbQf3oA+xFsIoWh1O81
         38qhcbBYwa+Mi+q0n9sJ6Sbla/qTLcBYVIzj3JgyimNSrRDqiDXrK8ueLSWWjvyn/ysC
         8laWeE5K4VVXLYJJAQxrsRxWhLyBjMVTe4GMoKxMnWO+K1wv/T5xve76xiEBgZvFWTyA
         Vq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730902769; x=1731507569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoVh6I+sgW0HCrktUilyDaZ92RmL1a324ePT2UFI6EI=;
        b=VaMZEPiMQPYvX8v+DLf3iBaP/SVqzkjoZnTIfZ1PRSB6xzfe8ICtdW124y/lclreMA
         idjOhDh7tq6MnNyDYrb93lcgMac7QeL+L7yz64PP2aoORV2NrFytB/zPKS0Fjc+8I1Zu
         tQ2YzFqw7DSrfkLJjj00829pQAdGkRSC+l2dQPBzlESQiwJqabfYOWK6x9HzB9IyNQ4Y
         GGdYUwu0ctSfoeAANdTADFDqGLP39KQ4/5RgAcbKFkRIjiufsii0r4fzvRTQfpTlloXg
         L2QnAM71nwaz0js+SgDb/852e1KeMKhPmultMmpC1gjRks8VwjmJ8YaJSxBulvEkXG3z
         53qw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0QX+kvgG1Asv+jCca1eDrRfzuo2MR89WDoKBso5SM/0Bwbb19fnjW0bcI1OyVuYfRpBM+r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88ZpQ+vIfYXXHEXSS+udSfE+2Afe3rOe6kwLvsz2N1V5lcgAq
	G2fQ38uiRVqfr35xx/qjzuUNQMS0rm1Yv2f/9/MgGCR6GEs30gy2KzUi2iE8cH0UJdEjpx3GTw6
	bwszCON08jCq2EVgUXOzkbQ/ohGEam48NtADd
X-Google-Smtp-Source: AGHT+IELMvKRoMEathSk4KOTxObc01aIRc3ra1YOgb4K//tGX1ypzTzZjAVLCjuGJUG5SFy6NgXKdHxD+C4kM3oB2Jg=
X-Received: by 2002:a05:6402:2187:b0:5cb:6718:7326 with SMTP id
 4fb4d7f45d1cf-5cd54a958f5mr18429867a12.21.1730902768471; Wed, 06 Nov 2024
 06:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106135357.280942-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241106135357.280942-1-alexandre.ferrieux@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 15:19:17 +0100
Message-ID: <CANn89i+Lu_2q7_onZcrZhqu6NY9=rxAi9jopZW053dRH_7qojQ@mail.gmail.com>
Subject: Re: [PATCH net v2] Fix u32's systematic failure to free IDR entries
 for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	alexandre.ferrieux@orange.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:54=E2=80=AFPM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a structured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
>
>   tc filter add dev myve $FILTER1
>   tc filter add dev myve $FILTER2
>   for i in {1..2048}
>   do
>     echo $i
>     tc filter del dev myve $FILTER2
>     tc filter add dev myve $FILTER2
>   done
>
> This patch adds the missing decoding logic for handles that
> deserve it.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> ---
> v2: use u32 type in handle encoder/decoder

Note that the patch title should be more like

[PATCH v2 net] net: sched: cls_u32: Fix u32's systematic failure to
free IDR entries for hnodes.

ie include some tags to identify the subsystem [1]

Reviewed-by: Eric Dumazet <edumazet@google.com>

[1] One way to get some common patterns is to look at the output of

git log --oneline net/sched/cls_u32.c

