Return-Path: <netdev+bounces-129798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6E9863FC
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC03B274BD
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1187A1D5ABD;
	Wed, 25 Sep 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fclNx2/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914F1D5AB6;
	Wed, 25 Sep 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278683; cv=none; b=DXvbDD9+7musFMiAjap37/Q7szFj8PhYenbkg7auI/TsdiGAHhMTlwMtZsF/5KdMnGl9Cdbpb7Rch9ARwHxaroIrBllZbyKRoF6N8bmsSOCSXUAa3CWujuOy8VIpCBOv2Pmgml1DX3kUvCHUx/u/WUlptl1cDqGqPALLyVlu7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278683; c=relaxed/simple;
	bh=qQaegB/CY+RMNIpGwZktikND96IzDNK9c4iLGeje7O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc1BDmQIMcrlZjhxGvlDJMlCq9U42uMeUIQjkpYffFYKOgk00D1lPvJo3DhMo4iWCMpud/Kimtnx380/kVCCmc8si7Js8jOBAkqvy2Mq+uEn2iyOKILIzCsNAgnyfhjGAjkwKdAgSVjCXIP+rxdoaHExDPWurISQpfHLQFNBpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fclNx2/4; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-503f943f115so1349445e0c.0;
        Wed, 25 Sep 2024 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278680; x=1727883480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQaegB/CY+RMNIpGwZktikND96IzDNK9c4iLGeje7O4=;
        b=fclNx2/42WHL1L+xRoLUiCgEjs6X8WeqIm/E1IGEZm6HWuRWFBK+orIVfeuimhXrnA
         zwBMI8KdiUxIGoI54FJqqdPRRi6csbslNRg3f0n3El8lCSNSVPMwc4sOETm9/lirZADF
         0fBBNatzoDU2oM4qhqDiPRznFdFPaOio7dtxTp/pRr09r7lEB823ofq+MLovwzMRWLqZ
         LeywZYLvJbyRXvREhW6X/pYRZnW5sBR4MccsK5lWZ1owxIToZywPFj5QffcBUJobrDnB
         k+uTdYcUnCTA82jgAIoJ040Z72kdB28SsODTvrItDq483YrbWSEn8TsYNv4YWPKia+3Q
         BCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278680; x=1727883480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQaegB/CY+RMNIpGwZktikND96IzDNK9c4iLGeje7O4=;
        b=AY4xEA6X+cn940AWI+tkN8C/sHN4a/pYr1pYGUR48arnrpXZTkjxt9NGfNQGWMIFop
         DC6GQUB+5tx64L9Caa8SR+9Pf7KyoUmy5QIYSjD+8/twXpB0zw8v2HzKqVXXZ7Aa+rHz
         k+908tR1joCuvA9CNJywK0uwdFrJ6N8VplfWa8F+yGor3kmLM3fxEmVD0/9PCrtwSrCV
         dQqNbom3oJ55mNCEAFCCNCg5EL0KpJ0Q/91kPpUvdGhzsXeVD2X/i7uX5ysYpcDMVDt3
         +g9JzZOa4IokHcmTEwGPCe1KjVlvrL0HV5MqZU2yiYciq4dvhR25kXqUqy4vOfR5kOni
         jjGg==
X-Forwarded-Encrypted: i=1; AJvYcCUmGSMlqhldJrrN6A+NWNKk1Ph2rw9xaJ++Hu+yoJtidB8EJp4pdWpx+XnME1zoElSXE7ztOLjJoAXsKd4=@vger.kernel.org, AJvYcCVzZZZtVVyV9dvhPCf0ByARqA33budto42p3sR/kUgMFFO+a1g87grbUUUhDHCDS5wtXou5icq8@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2b0V8KVuYU5T3PZYbz5mL6dkTBmeo+abEflMmFGpqI8rg5Li
	PSPosw2S1HEuqnToG78nb9k/ETdgwjONKl5bYYPOclW4hn+D0Zq+9kiosZC4BwHA0hfoi1mZ5vF
	T9h7E29CGzrXdknw2nFOluAQkHJyz7DygK1Y=
X-Google-Smtp-Source: AGHT+IEOq44YSVQBZM4ocAEcRPcpmoijL3KJAuuCU/GUmvBejs9ZRARJ4whETyoZnNxIotep54t/sCX3HYbtJXo5hbc=
X-Received: by 2002:a05:6122:17a8:b0:500:eeee:c8a2 with SMTP id
 71dfb90a1353d-505c1ddb6f5mr2896462e0c.7.1727278680096; Wed, 25 Sep 2024
 08:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924185634.2358-1-kdipendra88@gmail.com> <20240925111857.GU4029621@kernel.org>
In-Reply-To: <20240925111857.GU4029621@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Wed, 25 Sep 2024 21:22:48 +0545
Message-ID: <CAEKBCKN=J6esdjOF5yh1KtmOVTgmXpKjTfbXAzyRcULKzbMi9w@mail.gmail.com>
Subject: Re: [PATCH v3 net] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
To: Simon Horman <horms@kernel.org>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Wed, 25 Sept 2024 at 17:04, Simon Horman <horms@kernel.org> wrote:
>
> On Tue, Sep 24, 2024 at 06:56:33PM +0000, Dipendra Khadka wrote:
> > Add error pointer checks in bcm_sysport_map_queues() and
> > bcm_sysport_unmap_queues() after calling dsa_port_from_netdev().
> >
> > Fixes: d156576362c0 ("net: systemport: Establish lower/upper queue mapping")
> > Fixes: da106a140f9c ("net: systemport: Unmap queues upon DSA unregister event")
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>
> I'm sorry to be picky, but I think the fixes tag should be (only):
>
> Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier to detect DSA presence")
>



I have sent the v4 patch. I was checking git log -S 'function name
like bcm_sysport_map_queues'. But when I checked with the
"dsa_port_from_netdev", I got the same result as yours.Thank you once
again.

> Otherwise, this looks good to me.
>
> ...

Best regards,
Dipendra Khadka

