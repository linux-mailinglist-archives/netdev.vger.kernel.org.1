Return-Path: <netdev+bounces-114193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C022941442
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1019B1F20F4F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9681A08AB;
	Tue, 30 Jul 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGp79XZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B11A255A
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349496; cv=none; b=txfzgs3Q2ram3uOed9fkYI90Ic9Uwm7CamiGhP5cH4Ee7EksOhlGl7QRxd/rwW5KHt2aZ62i9RP8V2r+PzFuhRfRXwSlvcLfRPRr1gSmT25Yo9f495xIOwrmi/6bpi1j5SIC+MifQdqCjGDsW1eU/bc/IHXohp5/8NmPcQH0sWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349496; c=relaxed/simple;
	bh=a3Twj+tKrTN1LJBPahVQGDrXsQIIywZnRr9DiZA9QFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHVN1Loc0xU6/6Rpt43JsZk9WN2CL/ZOCOOtB+b9OEiLnOx+XHs+Jg1fqm8LruBnbMFO0WFLP5lJWVd0bnX3HG0kd7ol0YULAxma4phtDz/LhbdN38V3rKi/rTk5Lux5uKSdVenJvk+QFASzJzurEMeL26Ok+VWZBe9YI4EEQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGp79XZX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f015ea784so754483e87.1
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722349493; x=1722954293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI0EvaYxG+d4Jl2I65XudDL3wvLLwF4ro74qjIQZXeU=;
        b=QGp79XZXxos81aABWLrEksuWF4X800h5dwzA28HB8nx/U1nEPzMFZzT9NuPMewzJ0Z
         H8GmELydgWLGnTXSmityA0yFNj4U87hRP+4wDTzhlxH5gTnw9XQlZe5Euj5NXhNXXODn
         replwjLJhje9QlJ9EarJ/jBuHmLezswxwrvZDqHwXDQ3de8N0qKVv2L3G74iYaWgmkv+
         WKKfz/JmCyGucBZvD0spIAZlEh7HGUiYbBhT0OrgrkFz/QmTYxHl1oTBaA4ynDb1A9QO
         jClNNpahxEz1dxVbaepmwjLwr3y5ylSeCIFvYtazFdoErdqX2cLQ32i/DuOReD26AH+D
         3Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722349493; x=1722954293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI0EvaYxG+d4Jl2I65XudDL3wvLLwF4ro74qjIQZXeU=;
        b=sXYteOmvmXhD1EajqmlS+HqMdIJJ0l5+O9ObmS+TBOzWPfzg2TwjQH3tGlipelWGUx
         qO1YVcPA/aKu2CA4egJKM+PYvJymphq7P0WVgCmcd9JruBjEFhIaRyCsi9MMCzDcULC6
         9VVvFYBW2ZEUVU/IeT1sIZSmk9bTkp/2wdPse595HZIB4ykBXM5tDxn4Z9m6cXrTxmtA
         ZneXcjesGGBTgHN3TuGTMj532Tm/gg0yqJVo16wIo5HUQ7vkjpGcgqIzR3bcCXL3YbtT
         BKufKtLnLU8x2f4CXtD/uaQw7pCppYh1qW6N/69uwe0FaO+oWa1+H2PFYFglZnwuELbk
         gWog==
X-Forwarded-Encrypted: i=1; AJvYcCXRjVwNymQmXMqZ6OVRaxO5mwf9XlbUkJUfiolfMexwC4Gyeljw1/2vUS0uv40ofgFYsg4ieHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfj8wSpeA8yRkTKn7jLv3Wns92h3Z/ZZYyIUINS72+R7zUk9eQ
	fAMXTvDTHKl4azb6tm2CQPW96dTw4TnlMvfLY8pMzIH310oNamAE/gz2ZrXvvSF6Mhe5cJdNzMc
	HP+NNjSdu4oQ2juvaAtktHfr9vkE=
X-Google-Smtp-Source: AGHT+IGucEaqYkfcAVwIGhs+1afFiARN9Mts69V5eAmQIlo/GZTQ0VSTgfEO4j6H+7DBfLUB96Y5VVDdxavzl15My5k=
X-Received: by 2002:a05:6512:68b:b0:52e:ccf4:c222 with SMTP id
 2adb3069b0e04-52fd5351eb0mr6043791e87.9.1722349492174; Tue, 30 Jul 2024
 07:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729193527.376077-1-shenwei.wang@nxp.com> <Zqi9oRGbTGDUfjhi@LQ3V64L9R2>
In-Reply-To: <Zqi9oRGbTGDUfjhi@LQ3V64L9R2>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Jul 2024 11:24:40 -0300
Message-ID: <CAOMZO5A7BcFpMFQ_4wtQ5s8cVpUhCKMXScKkYvhq9gkrCQ3uEQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next resent] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
To: Joe Damato <jdamato@fastly.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-imx@nxp.com
Cc: Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:17=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:

> I'm not sure this short paragraph addresses Andrew's comment:
>
>   Have you benchmarked CPU usage with this patch, for a range of traffic
>   bandwidths and burst patterns. How does it differ?
>
> Maybe you could provide more details of the iperf tests you ran? It
> seems odd that CPU usage is unchanged.
>
> If the system is more reactive (due to lower coalesce settings and
> IRQs firing more often), you'd expect CPU usage to increase,
> wouldn't you?

[Added Andrew on Cc]

Shenwei,

If someone comments on a previous version of the path,
it is good practice to copy the person on subsequent versions.

