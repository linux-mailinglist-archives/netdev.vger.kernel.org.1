Return-Path: <netdev+bounces-115694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642C94791F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319122816B3
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72308152196;
	Mon,  5 Aug 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qv9kc6qr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65515380B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852730; cv=none; b=d+bMEPSVVsThJdowM9z2MrZJIpMgCa1hxqrbeYx8dGDra/i2dNFiRxRPdSnya8Ykxv/5VUauEO/gtERFFzM/k/YtwGXyRNi6klmqzc5Uo4J1C05eJR1jv8iwbm9Miulezh900meVS3ExNEaZpp+8IWN82wf8g78wnker8QhJzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852730; c=relaxed/simple;
	bh=aBUI0cv6RKxMVVB/tkuI6YX2BH2X9rEgl2ihEJmJwVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUCQkqbhqcMKTkaIOVMrhBRiYdlO4/29n9xOoVbn32AmjPOhZKzYRBMbWm6+9xEckdis8pkcBUsUr4++8ldcsaKcDAc4e5s4dlJUQEuQaVJJnx3A2/sZhUNQD8zWkk5AXnX6PmQUew1uXfXsNckE8rxcfiDkoH2ppwFvYGrX9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qv9kc6qr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04c29588so16551110e87.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722852727; x=1723457527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBUI0cv6RKxMVVB/tkuI6YX2BH2X9rEgl2ihEJmJwVE=;
        b=qv9kc6qr7XCOfYvQPiNBzXUIengFj9TI4d0m0yoRBYyML1cka3P+plRhBU0D4fal3f
         LpT/QMv8W0yRCAz0Oo//qF2aCOM4LH9ovlcfMxxrgYNZZHOeV/yIlLexpHXenq4Vrstn
         4miNQZnGqt/eeDyt2miraqi1QqGNcS68ODnOcTVQYqWnY+C5f1PkmGj1bJka0+pBcbiC
         iThKB95jPeGGKa8Y9KuYs/msP/LtBlAXIUpYsCSpYdFFPTU2aBG2Js5SaYF75JoPfytE
         pqG31rrgOKeGbj8lIKZv/iPzJyzzCsrG0GZaZCz5XSbArGV8cTejHsFDTp/4+EvF811A
         qvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852727; x=1723457527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBUI0cv6RKxMVVB/tkuI6YX2BH2X9rEgl2ihEJmJwVE=;
        b=ZMOcAmH6a47kSeLBR0qqUJ5xz51x/RHuFvprhLzmdgOD9kpz24/eWxmgTdila6LFvs
         QAWMpAL2XC6bycCcMI83B/4CghEwZzOQvKWYGxXDW0lWAmWFcjrgbukujA1AQdRS18ks
         YoZEF1Au2hqzYwFs++AfaklLwfyFzE6SFPs6RImLN6KXZqWZFR49Azrd124FMfykUsAc
         ir/7HBN0U6TxbH4PcnFaiFOUlS/whTfuYB1bhrT+3FFqUKgDB4lCUytxQaV7zqMzWHWu
         WAmSWZZtex9jUv0UVctMGQWOe4uu0EfE2UWw7F10m9ownzlgRdrQmQKkv2p4WI3vDYYH
         EE4g==
X-Forwarded-Encrypted: i=1; AJvYcCWnn2+/rf693XUSPqIWFyFhNKbgSuX6BTzDabc4JurMKupWVXjEgPVNyE1IxAGObtxMDAf+O6idhk/PmqJq1kRzSMCWrn2r
X-Gm-Message-State: AOJu0YxrOD4PK4m9mP+6qxHdpT1HUmoI/FC+406p8nKGao0UP0TALlVP
	MYDZoKkfrkLCB6zTYkwlr8iLsXB2ZQJ3mpqpP34RfHN4Fqibgu1R5SMu7wyMP611Y54AqPoZuhd
	gAgOkD6sHh+UEnD7CnoWuEW2bs4MYsghuRcZkKw==
X-Google-Smtp-Source: AGHT+IGy87u/qg4BJ3TC4T8YzxT5D6K9LAVyY2+21hQh275kOvCpifr3EAKkDMIr6mSuV8VqppJGDqylPVAwqGtgTSQ=
X-Received: by 2002:a05:6512:33ce:b0:52e:9d2c:1c56 with SMTP id
 2adb3069b0e04-530bb3b73bemr7403273e87.35.1722852726656; Mon, 05 Aug 2024
 03:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Aug 2024 12:11:55 +0200
Message-ID: <CAMRc=Mf2zOyQv=gw6+c=a6U-fJKOaXK9QQ=kukmXKTjXOx8TNg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/14] net: stmmac: convert stmmac "pcs" to phylink
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 12:45=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> This is version 3 of the series switching stmmac to use phylink PCS
> isntead of going behind phylink's back.
>

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> #
sa8775p-ride-r3

(The board is a more recent revision of the one Andrew tested this series o=
n)

