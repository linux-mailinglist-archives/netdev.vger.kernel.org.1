Return-Path: <netdev+bounces-128616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB897A9F5
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538F9285EC5
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEDA31;
	Tue, 17 Sep 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ/IENfw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3D17F7;
	Tue, 17 Sep 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532729; cv=none; b=ndpb4d8wOLo/G2M/nAzPPq8wuHAOteKrj37870JVv3RUAd0aDQOvAobyBXhqCk+J7DTrdPWxWbMJkO5ICqoq7NbUDUMgS7B0hMEXPDf7bsPgQ1Gqb5F2d7eVVgeuRtgCLAAtEdIFpIrGmR0aNXYlgxFpnFhL13xYTRex2GWWwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532729; c=relaxed/simple;
	bh=HNhgtpAq1nKBRHz+MfstOjc82sUGrWpqyAVKHMA9zHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsx7Fd3SBAA4cznuSm33bRnPphU0d3+lZQKgcOF/Ua8IfI4+xKf3Oo1W2g0fuQ3MvdWrgHnWv4WoVcoPAC983+/eX8tTI3VPcB3tAX6g8DCGxBd8gyLPVH3N1lkPmHb4vyMZaUycKzMnJy0qWT0qHg5dKByTZmDcSWz7CiV92yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ/IENfw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so4688199a12.1;
        Mon, 16 Sep 2024 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726532726; x=1727137526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNhgtpAq1nKBRHz+MfstOjc82sUGrWpqyAVKHMA9zHI=;
        b=MQ/IENfwG26ubzUh6+yzcAS1IBwj/a1TtCOTfLQ9+uPrhYSkvFcedMIEmFlKJoIQq3
         5OOKkTfpscpld1WAbOqQc5+VEXAQMYVRkmFdOVvc1Ea+tN7Ep/rFc6CxImeQktJ/UjyU
         Av0XiKNUqRWsnMcneuaim4SyyjuIdrXnBnFSKTFEcXYihPu5sJoixJ80KC1dZz+TplQC
         3fOllCwpgF8FwQMzdUqQal+ikwTRBIeAp4ekRwciDf3JoNOPDvdEeJt1xkAwYn/Kslvi
         Foi6qMRFChYllh1RaVjOp1S9SystiKqT1Cw/8Fz+oq6W7itzOSj6dOt2j/vCa96Ow9h9
         xJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532726; x=1727137526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNhgtpAq1nKBRHz+MfstOjc82sUGrWpqyAVKHMA9zHI=;
        b=VqSb4yCRLCkZ/eAb6I6UjF4e7iKL18tOnTT2tDCHoHm1lApTVpVE6GUhlQgKUqqRY1
         ysQbd27sXjRgWcDnhiibsWLdJI4JgWk+8TRPemxMbedQPmPp7dEuVGfFb360rH4ftJE4
         /9bOMukg8ZkrcKtSghsf1Y9HcZ/6AeMgyQ3u9MzBm+R0TBk1UwlcPtJNtnvsedGQWOfh
         m4JRobEZbcIwwBt7iyG1ucsg94zJRbu1Cu7zVohrFCC9uca/TUo9HGvI4tPD6Z2uqEaj
         7HdH9xON7kjm3S4asrV5Qr0G5VVvXJoQGfdK7+8YRGK9yH8JzYHkGgTCWButSWwwG4xu
         rC0A==
X-Forwarded-Encrypted: i=1; AJvYcCXGAPtE8zpz8rwvLn4XwWKWdgkKN/QjTtQE91uR9k9fNA+7FYCIzKTPH/Ieoe2ZRct/nQm6kFhT@vger.kernel.org, AJvYcCXxBQuH37xy+uXhlBmE6sr0EIVdJwF68UBkz5vsE05f5KsdhZwP486U5ke8D5lT4KtAZMT6k9MdSYCHsfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYXAowALcANil5xry2LmKIlOxNDepyzlcRXBb0jOy1OEAx+q2
	a5TfIdeBCgr+DxZPSGxxK3TxORXDEHH/l5EuhISb5FZ1J8jb7fcckbYrNj8g8RYESw+GHJVESCa
	p2trwVbc4Mo7h5VbGpBD2/EQxF7aHTFLl
X-Google-Smtp-Source: AGHT+IF0i6BbMToFJWKAZpvgkjQyEbAtay0VE5Es187+ygaWsJEizelTGoClKli1kQwYLkZEGUzydxRW4GUprMflALI=
X-Received: by 2002:a05:6402:40c9:b0:5c3:c548:ab3a with SMTP id
 4fb4d7f45d1cf-5c413e089a8mr14515414a12.2.1726532725187; Mon, 16 Sep 2024
 17:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914190343.rq3fhgadxeuvc5qb@DEN-DL-M70577>
 <20240916051804.27213-1-aakash.menon@protempis.com> <20240916071735.54uhnzejos3ksnun@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240916071735.54uhnzejos3ksnun@DEN-DL-M31836.microchip.com>
From: Aakash Menon <aakash.r.menon@gmail.com>
Date: Mon, 16 Sep 2024 17:25:13 -0700
Message-ID: <CAM5a72rZ=a09q0NOQhbzgRonxbFTcvYKfQAeftGEX5kPx4cfsA@mail.gmail.com>
Subject: Re: [PATCH net] net: sparx5: Fix invalid timestamps
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: daniel.machon@microchip.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com, 
	Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com, 
	aakash.menon@protempis.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Bit 270-271 are occasionally unexpectedly set by the hardware. This issue
> > was observed with 10G SFPs causing huge time errors (> 30ms) in PTP. Only
> > 30 bits are needed for the nanosecond part of the timestamp, clear 2 most
> > significant bits before extracting timestamp from the internal frame
> > header.
> >
> > Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for
> > timestamping")
> > Signed-off-by: Aakash Menon <aakash.menon@protempis.com>
>
> There are some small issues/comments with this patch:
> 1. The Fixes tag should still be on one line even if it is longer than
> 75 columns, so the robots can find it.
> 2. Please use GENMASK(5, 0) instead of 0x3f.

Hi Horatiu,
Thanks for your feedback. I will make the suggested changes and send a
v2 patch in a new email thread.

- Aakash

