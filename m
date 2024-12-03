Return-Path: <netdev+bounces-148497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6F9E1D72
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE512166118
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E51EE01A;
	Tue,  3 Dec 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frGnzalr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BC1EF080;
	Tue,  3 Dec 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232088; cv=none; b=Z9LAT5V9FScvkEp/OSqB6oeox5CqCBgmvPylLxKIJT10jqJnH1n+/pfh2BFND7TiS77wKUWv1dckFQZj1bqLcbaUCcF2Cc64c9aFdYiH0oJYbqVXjwo3ze7nMBMbw8FzABkHng6DItxraahS8V2TIJEQPR1kXSR3RqR+KK1R3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232088; c=relaxed/simple;
	bh=Ba3O9EjoepFTiQI4RzMrDidRaYIKsp89rK2EE4pz/uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhzuzPqWoNfSU7KYUONN6uyDJCtymYz/DdVZd8oH10p7m1qG9BfMkgZZjPoP9ShIqNEmSWJT6Y6JK0p2xnNif7wWfhpLxfqfQTwgGoTbpjBpwSdNi1PiZhWsI9NJDroxkP6k+WTiiuIK16LPk890/N6GkJ/cPNZ7TmFYc0nAi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frGnzalr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fbb47b65d8so553741a12.2;
        Tue, 03 Dec 2024 05:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733232085; x=1733836885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DiQRGn9sRQGD6IKOQcesLAyYTuqtB1dL/cnYSRZ7mw=;
        b=frGnzalrgx7WeR+NX/MyDSpzqLk+3mypZelJscV5RNh+oVzY7XlFVuFZP+2H3RCXuX
         A6U8/IpFJ6C+X6RUTn3uMOmbGY4n1n/pK67mm7vywKCwYxpmYiABG/Eydl6VMd8BeKF2
         P7J71Vinv1KBrkrWiiTkW7U4bAJHUFroxpOAHLBscI2e5kdBLmx6w2SeBDrk99Dot/Ru
         gwmH6nkBemZkok+s4lyeFyIkhNg10M2kPOUD8TkDvkjgtjkGlbySGIx26/lANu4ob2TP
         /lPF99bOUWeiIpFmzX6k8MzcIz8BeCFB8xuSXhOVCwE0Ustq8peKuQbmCiFU+Wzt26Ft
         PWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232085; x=1733836885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1DiQRGn9sRQGD6IKOQcesLAyYTuqtB1dL/cnYSRZ7mw=;
        b=crt45uH0nzKbC861yTjT7kqrEFnDKPvrRjjVMqB2YxepPCNZbuqH3pFZRwCLpzQJqz
         MUMaJ19SmPwgxC3JUtmfWEUlRMJEcp+bHbb/ae/ARsfDs3cts6bfRmbE4lKtTgcRqPoN
         m0vYEbTkGlNMLkDEsDczvjbiMHbuVCuO5lRIjA88b7PG2tgnOe3bc8/0D+sDxTzV7+6n
         OsBlMcCgbSggVNi70N/AG9xRcOppD9xV0AjsosxzcmYyg7Z3D20j9blx518AOXFNf1Al
         v7/6Cvi8m1cpxTcop9XuzcNqaVbEdRpGHhdeTITSwcNjFXrLR0//ZKsSy1IVTYjN89T7
         XJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVShcHHjo4CUnKOyhL88FF+W9XdLQbn6SkXI5mKmOP5aAxUlJbjuhc3RhGvQiwNYvLZqUxliIVZl4QCYRA=@vger.kernel.org, AJvYcCVoofnm27CIeJxl4Q5gpwCfvmcD6BK3Fw8A8GP7pJ3ny5Eoia++cz2qdU82AyYW4lzEnMqx72/T@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/qWGTOMOhd20Euvhpz8p/sho6RY/CgXTpjTfEHuujs+LGKpV
	4MXdW6Tf2kl1fU5UuFX2SdCX/xDqKWnOsP7hwTr3VE3hyg/6lfbO
X-Gm-Gg: ASbGncuus66PPfyH94BE3wkvVDPljVoFNpSElmQTYhV0ec7RgPp2pNu6mveNsDnaatL
	ZG9ZbNN1VkvNCQSc0YHmz5fjOl0FRx1AP6yfbWzcmUp5etrk2R90osSnXT7kqArhtjmO3Qz1GmK
	ChUyVFNgAGLaKLu0+xGGcHeXtPhn1Cahr7fU5U6d7k3sct10iMo1ZpCQaxnCWFWKbjigHXiJ7LM
	w9ejd7D2nqIMGbF9fcgzV/epG1K+5purDe/moUVVKeGqDC5
X-Google-Smtp-Source: AGHT+IHAPfHiujUVyPP0cOqZBADE3PjYm4MguovQ/VxhjE+GUA1ExnFWoE9eRjvm+n0H2KSnwut3QQ==
X-Received: by 2002:a05:6a20:4309:b0:1d8:f77c:c4f4 with SMTP id adf61e73a8af0-1e1654102c1mr1875816637.10.1733232084850;
        Tue, 03 Dec 2024 05:21:24 -0800 (PST)
Received: from [10.96.3.69] ([23.225.64.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c385eecsm9589795a12.68.2024.12.03.05.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:21:24 -0800 (PST)
Message-ID: <0ad27909-3d43-4c26-a69f-d0c8846f38a6@gmail.com>
Date: Tue, 3 Dec 2024 21:21:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: realtek: disable broadcast address
 feature of rtl8211f
To: Heiner Kallweit <hkallweit1@gmail.com>, andrew@lunn.ch
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy.liu@realtek.com
References: <20241203125430.2078090-1-kmlinuxm@gmail.com>
 <af9e2342-be01-41a8-9099-aeee6cbed258@gmail.com>
From: Zhiyuan Wan <kmlinuxm@gmail.com>
In-Reply-To: <af9e2342-be01-41a8-9099-aeee6cbed258@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/3 21:18, Heiner Kallweit wrote:
> On 03.12.2024 13:54, Zhiyuan Wan wrote:
> 
> Why PTR_ERR()? Did you even compile-test?
> 
I made a test on a real mt7621 based hardware,
I misunderstood what PTR_ERR() means.
> 
> And more formal hints:
> - If you send a new version of a patch, annotate it accordingly.
> - Allow 24h before sending a new version
> - Include a change log
> 
> https://docs.kernel.org/process/submitting-patches.html
> https://www.kernel.org/doc/html/v6.1/process/maintainer-netdev.html
> 
Ok, thank you.

