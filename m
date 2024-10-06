Return-Path: <netdev+bounces-132529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758399207D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B141F2164D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4D189F50;
	Sun,  6 Oct 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsMtp4pc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E717DFE4
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728240877; cv=none; b=dfWgLZZBklP2cYkVV5iILW9ko9yF7PTI7+1QqRuOMIQtTtOwCdZ6+hwxmacZA6WVnNVzfXXT7qvj76Wn3JAlJ5Ymd5WM8jVqMpk6IFZLpLcl7uooEVg/F3wkxQHnmoENb2wJwgKbW74do5+I7xbPYWA3LRUlVqbLGrKBxsFyzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728240877; c=relaxed/simple;
	bh=eqLBEMAQSf+btZDJrl8RaAfXHa4b4S2cpfJaSx0Q28U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9nehE9RTvcMd0qE4SkLHxKJ5W7jVuulf83PkMHQcC+i/dRzrkk8L0XPPAZCBiCcsrl2FnMdqOJs2torEBiocrW078ff650iK2CeYa1wWznYkcuEboqrx/OvDKbsA6mSicjRCsez4Juua7VBFOdpfIyPZ7ZkluNjTfihcppLtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsMtp4pc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so36695045e9.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728240874; x=1728845674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqLBEMAQSf+btZDJrl8RaAfXHa4b4S2cpfJaSx0Q28U=;
        b=gsMtp4pcdMjLL4Y88BD9N0HokvxK+Fu4pwRphnrCfnHO0GHqwo0kSvdVGG1DJndi7a
         snikzzMahY2YSpA8S5RUVlcm6IerfAOAWJXM8jMckPW3i85IIJm1ik2f/yaduFO0augX
         dKROfIQzrigBJhpTrbO/fdaKN2T4yHOAaOxWW7pAXS6x5UR+ZPNf5VCq4Np0nzXt+NP7
         SsN1dGCtk6GMeDJ3tyhmLCL7MckmV3V0VQxSQIImqr9AWnetvAQzgWwMlobI/WMzlGie
         lvdTVZD+9m5MIiMp/sZICmjIUJvOQ1zcc9D9LkZiHP8FPWoUWsZtnQxrSvcNIRRKDMzu
         5FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728240874; x=1728845674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqLBEMAQSf+btZDJrl8RaAfXHa4b4S2cpfJaSx0Q28U=;
        b=KX/QgXsWf5NzGJMKOCFvX+AfK1W/5BlbKoo3PL/XThT76MGqjGJwrhDZJh+NhJ816L
         jhFQ9ewIWLo4rgdEbHDs9ppV5R6FmC6yoYCBvUrvxjZDm0xetyoPX1n2kH3QCthWz8k3
         1OftqS4mjgXslPq0ZwJ8+oExt2Tj+p6uqq5UkUIADaSB5Bne9W4yxR6kJUJqeHaBzSbM
         0W/WXcGsxJ/Y3hrUdjl6CXVMCF91UJvoBjU2k0iv9OvC2HlU7Ggr/htEoVKQaPMNF0kZ
         jNi5lZWyer9X/WSDcEZNnTI0gHrBqWVeAb6uizhpxdxsh1toLux3e5zabRDGLEvhwrFF
         X2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQyJKanDLieZWvWzW03XV74cbdcZ1951HOdvATsYL7GVx62bZQ4dvvmOWhF/wFHl63cH97YIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKCTamaNUPvUSkKWK7pSLFqNF7bR08QjLhc7XPXYl0F5eLFkk
	juJwm1iH8LC0nm11o7H6c3en7TfbDShwlGi5l4JHKsWNbVG15u8Wc0JP+k80XE9LaS1fvN86c+2
	lQuNiL1j5m+lUqtto7dHEdq79FXXD2dSFqHqr
X-Google-Smtp-Source: AGHT+IEBiO/p3rx2bqlm2dNlsaStD3PfVO0kyL833nSsNH/LU86Lec0Czjjz9Pufcg5yfRoHyp+1MEUcGei7MBMxt+0=
X-Received: by 2002:a5d:5604:0:b0:37c:c5c2:c692 with SMTP id
 ffacd0b85a97d-37d0e4f8a06mr4736312f8f.0.1728240873781; Sun, 06 Oct 2024
 11:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005222609.94980-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241005222609.94980-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Oct 2024 20:54:20 +0200
Message-ID: <CANn89iKQhxEPRVKmxDZp4SR8x+SaOZyWQv1dvW37PtietpBPKg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net-timestamp: namespacify the sysctl_tstamp_allow_data
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, kuniyu@amazon.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 12:26=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Let it be tuned in per netns by admins.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

