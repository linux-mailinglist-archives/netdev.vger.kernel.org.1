Return-Path: <netdev+bounces-80476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A618387F06D
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 20:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E17B21019
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5B56767;
	Mon, 18 Mar 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRVv8+Js"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43456755
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790159; cv=none; b=uWK05hENp9QALNV5XIJ2XD5zhPL9GT/oAbeUk9Gn8fJqZJhIQvo/AIva1lSJ12PLTym6jW/Ruiu+D8LRzoJTEN97AW4F+kQb87mZz+8LXeW37t5FreUI7zerDyTNOuk5gQ0pZTfmeicjqzfHzAs+FEmRccFe+Rgsgkad2/qqzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790159; c=relaxed/simple;
	bh=9B5+PbH/lzud3TnNw/UNcvw9W2yFSkK2v1DvNMKypCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpK9GqySZBUn4EH9tuY1tDAeyeAcdoKxYaBgL6BzNLaFTkyvMMHSW9epN8mlsHQenOVaFx3FHGHJuj6RpABqzhTZPnTRdzOM7X1CCklfw/omaZXcFQm5qi4oZXC/d2b5r6pcJUilE2x0gnJJfvx2B9QzuzOB3v0uq7fBrOn/nnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRVv8+Js; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc949f998fso3547122a12.3
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710790157; x=1711394957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN09v//x59Hz3OYqOq86iV40wL9tkGH0gDwo/zxn29E=;
        b=SRVv8+Js3eersDzI90JVHxO5mZO+DnrjT4bg7QUUi8qXXH+C6MxKbWhlhr4DXAWNge
         5Rp4VwmmKPNbNwy4Yade6tEaE7UL9N/LCwEMXWhUIGO88OB9SjO27HyquT8EMvO3fkor
         EFeNN0z3F5mvD9nUPjWH1HrmCqIfSAXN7PJTssM1Rzrtkrztlg+l8XskfpAe9IpmXO3q
         /UgUTV82AW6LDHvoSB/Y4QkZ2O+wlhsjm6eoC351hBUh+2UAMojBB5I8/H15vIcfCTdK
         sR60Ucx3EbwCgGXuPMnYdWiFRr0/I+iGYmCiVxNMRp/YdiK5i4BwlVCTIoKqUALIgzEv
         j7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710790157; x=1711394957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN09v//x59Hz3OYqOq86iV40wL9tkGH0gDwo/zxn29E=;
        b=C2MKjaKKywVMzpL2zVgWAs4D2U3GG+SAvbfFzErIKS6I+iKti3ec9Nxjl7kYk2bJdH
         XSLNlAgxHkza+JVrGi3CDp+8+vLLNJt9vu3GCFWHy3HhJGCep+ebw8UU+Q1SNyYWMoF1
         3UCW77JJ+F+ki3FEkfMMGXPJiNLH/nA5BW99dS53pueqMz2n/JDWZq3AkGTxNrxLkcUZ
         CdbfGfGBqevE+STIs17iIgycMWtGKUw6aLPHbHhHYjs9LCg8ArzHyyDxGoRcGTgwqnLa
         ukBZ/5SNM3e4IuD+TYCbL6eP++mbyhbyRLag1b3ChYeAQNK2jBMbwjWm6wyLrJB1SWxf
         mEBg==
X-Forwarded-Encrypted: i=1; AJvYcCWr/UYV5c86YB2mnJWgFgv66e3sCzknA9WJD7h0Si8UBDxKKp1E++AeZ+f/9OwMLskAnIcuuenQKVCtalZaIRyCiKRHBa+k
X-Gm-Message-State: AOJu0YyOBuNU5d57rRVCyWYv3wsctgR3HdQIxXR/8G/3yXcPtSvJ8j5c
	8Bc8qJDxpjxmiWQIXGCDIDH0p+gaAiDfMQjUh8qsEPVBRsBy38zf3rl2Knj+WZvVLCCZShi1toX
	oooCy7yL6wZXx+26wsLv4SrOcWw==
X-Google-Smtp-Source: AGHT+IGvZfnZ+Rky0Oh/Gsn5g6WhTcakpBOS3Ktw8XVis6xgJg1tYb8wfhJIJC8i856kKwwm3a8vqxrEPp9TbQ2uiN0=
X-Received: by 2002:a17:90a:c592:b0:29b:a509:30aa with SMTP id
 l18-20020a17090ac59200b0029ba50930aamr660387pjt.14.1710790157090; Mon, 18 Mar
 2024 12:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfZcDxGV3tSy4qsV@cy-server> <ZfgHkApgxX7DybHx@nanopsycho>
In-Reply-To: <ZfgHkApgxX7DybHx@nanopsycho>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Mon, 18 Mar 2024 14:29:06 -0500
Message-ID: <CALGdzurhU95jn7q71fb5Dq0QZ2dB1hHLNbX2zR=32gB6nRHjmA@mail.gmail.com>
Subject: Re: [net/devlink] Question about possible CMD misuse in devlink_nl_port_new_doit()
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, zzjas98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much for your prompt reply and fix!

Best,
Chenyuan

On Mon, Mar 18, 2024 at 4:21=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Sun, Mar 17, 2024 at 03:57:19AM CET, chenyuan0y@gmail.com wrote:
> >Dear Devlink Developers,
> >
> >We are curious whether the function `devlink_nl_port_new_doit()` might h=
ave a incorrect command value `DEVLINK_CMD_NEW`, which should be `DEVLINK_C=
MD_PORT_NEW`.
> >
> >The function is https://elixir.bootlin.com/linux/v6.8/source/net/devlink=
/port.c#L844
> >and the relevant code is
> >```
> >int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info=
)
> >{
> >       ...
> >       err =3D devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
> >                                  info->snd_portid, info->snd_seq, 0, NU=
LL);
> >       if (WARN_ON_ONCE(err))
> >               goto err_out_msg_free;
> >       ...
> >}
> >```
> >
> >In `devlink_nl_port_fill`, all other places use `DEVLINK_CMD_PORT_NEW` a=
s the command value. However, in `devlink_nl_port_new_doit`, it uses `DEVLI=
NK_CMD_NEW`. This might be a misuse, also according to https://lore.kernel.=
org/netdev/20240216113147.50797-1-jiri@resnulli.us/T/.
> >
> >Based on our understanding, a possible fix would be
> >```
> >-  err =3D devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
> >+  err =3D devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_PORT_NEW,
> >```
> >
> >Please kindly correct us if we missed any key information. Looking forwa=
rd to your response!
>
> You are correct, this is a bug. Thanks for report!
> Here's the fix:
> https://lore.kernel.org/netdev/20240318091908.2736542-1-jiri@resnulli.us/
>
>

