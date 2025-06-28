Return-Path: <netdev+bounces-202171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C0FAEC7D1
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 16:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8A717CB86
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB79246BA7;
	Sat, 28 Jun 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/RVZ5m4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A171D7989
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122151; cv=none; b=I63CCzt2pTRyroEBlVWKtLOIBWn7Z6+GaaQ/IwjXs8wfw/MP9j9FdJdkU7ppM0BLsuZFB/Bddf7l+96UqnfRyylQiXdByOY10Fx7t7rnnWfNh8akIY1TRRIGQWoJmkbPvzspx7qd6+791EEQBLGT5YbknUImm301v+S9jh2HEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122151; c=relaxed/simple;
	bh=KHR8NfmoUKT1dPoAeWmJ4knXJjoPVKThXfdyHalaffU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Nrc9uXrp1Vu0++cBBdO/Lwan7oQ9fhuUmU1EEURUkQs0KTfi8rsrMw44TFjIXSc+ndfwvOUrymYQzl0UtYjolKO//rvVMRovBDWg5NqEsTtP9Bic+OAzI28gtPdkfmQ4RW/h059OhhHNvr2jCMpScM9pxYm6GCWPfrM2CABvKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/RVZ5m4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e81826d5b72so2492489276.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751122149; x=1751726949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhiZJU7UsDFdtEGVAmFFHyWkmCwAj9iAob+NyDuvAtI=;
        b=i/RVZ5m4UiQuVpJx8KOdxc5qhreokcm2qT33C3veOFWmvdPRrVaHXRWl6L2PcvDTd8
         ZYLvG+bEnJ+Fkv5mgS7GrUqUYv1f5U8a4SBMFmGvhDrCxJdTRShjLwm1Tk0tBlTbIDQk
         MGUV8xNj5T/qijNjimM4xExG58hVfI1mRfZ8fDWT9LqY26yeNCAhBk0eI0srPahM/KJA
         PXBCyYLkOta3kHZWkD9qvEs1PStN+CnbPKrLEWyIZxdn7mSqIc6BiON181pA7cGhL53F
         +uCff/kyKmfLksGPwjzb1U1z6xnXZzy7FGWLOgczf/Vd0u7b2g7btpc3AEPJ5O2BUILO
         iRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751122149; x=1751726949;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HhiZJU7UsDFdtEGVAmFFHyWkmCwAj9iAob+NyDuvAtI=;
        b=VWjZE7nxBZM4cBFuxygzR5tQVjy3TI/uTnRW60LxqT88CXDHCrx5vxo31ycfXIP0xP
         Z20YBqW2zThKHUDR0BRSd0um03+9om9Fops4oxp6joOQpNMCJqWgcj9f8GMQ6dVGqzOY
         4X3JbJQFkVGTO5mxwGfUSanwQFF0gV8E1Ncb1DZFPwWUPb+i0jmxhxXV8mr4/TnxlJxy
         hUolEtxLR5+tGU+3ZR/CVbENsmsJi7bBr3y8s/zuEt1XzVORLqp3MT20bFjYN5KAOxlv
         d/PjxC4sWYK9N16F58muPkt2qfRUwETx3GxBdjQBYj0D2UMKBE2BF3NRflBnhj7ZS54T
         847Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3AgQc4yZAE7FT1q92Rf/sR1sdpbWVmM+TC0dKJYlHx7Yq+8II1WRdmh62IM/vWI9iNwO4d2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafE3lYGYU4xRR3p1aoGZ4UJT276zFiz1wVjn4WGx7hUaujwhy
	nH5W9+N3sbShR8MkmieP1OccONst3TQq9MQ05aqRBxRE7QH/Eta6MUdG
X-Gm-Gg: ASbGncsEKUXFGnnytS+PNq5+q19EYsqhb2M0JmGW49468Ro+ALykv1EufAhu//a3ikT
	lASveB4klRYg+vH6FP6TqmxsqQBA7Ztug4ZxwgkECJI04EZGVtltthzGjjBuoUNj7W+WReH0mbP
	KfSoDQ3a4npEsFtmPEBtTLMeuHj7/99AzITUdOBU9SAQkRRonwIkzEbEhC7ZV/l1iEV4gvfUb9W
	odPT45LWn1le84JVTRgvsW7eNMiRknWbPwYR89Tk4KolYTBMil4qn5KPq3/SXp8aD7J//KXGZrM
	qrMAY/nw8HOTVys1hH1lb9Uo12DuEjB8NUxqTt4k0OkPqgNtQft0lQxwaFbPdpcrOu8YB7wtner
	atbN32nxbR+ttsRly1rDeWbtuUjJaeKfNaau5Ya8=
X-Google-Smtp-Source: AGHT+IHfIvQkfrRqf0jqhrdwuu2+fRhjjAnVa/P4cjuo2634vkere25Hi8xeLL35pV7GOZNstNKpMw==
X-Received: by 2002:a05:6902:2781:b0:e7d:c87a:6264 with SMTP id 3f1490d57ef6-e87a7ad1d29mr9051496276.6.1751122148845;
        Sat, 28 Jun 2025 07:49:08 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e87a6be3bf9sm1205639276.43.2025.06.28.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 07:49:08 -0700 (PDT)
Date: Sat, 28 Jun 2025 10:49:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <686000e4103db_a131d2941c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250627200551.348096-3-edumazet@google.com>
References: <20250627200551.348096-1-edumazet@google.com>
 <20250627200551.348096-3-edumazet@google.com>
Subject: Re: [PATCH net-next 2/4] net: move net_cookie into net_aligned_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Using per-cpu data for net->net_cookie generation is overkill,
> because even busy hosts do not create hundreds of netns per second.
> 
> Make sure to put net_cookie in a private cache line to avoid
> potential false sharing.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

