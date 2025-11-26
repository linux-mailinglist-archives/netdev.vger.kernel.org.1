Return-Path: <netdev+bounces-241949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EDCC8AF5F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C11EB345724
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC5334C17;
	Wed, 26 Nov 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIHMarr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484A29B204
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174421; cv=none; b=socPk8inaSnlRtsrM61pTH7mlA4fTq5SwNR/jino1j1KXxFPHQpn5aM9umaq+G4nd+LV/0KZ4HeVgyrLJ0P75EyQT2KkINTqtfs/SsQaFJCcQNvIqrj3prJcAMERB+cKxx5dBAW2YLo9yPsTdCRJohMctjMWyPW0UhAv2lKKU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174421; c=relaxed/simple;
	bh=L+PYLEg2c7RuySHWZyUigZ3QXYcF5wMa5NkODsxLMlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a66R28APgBmqIC++hluRaNst7nhDrDTZ4VS9gVFe7Mrvt9DDYtJ9KZT6C56itsHKcAfnfNC3/9EXO1qY5WIjcXu0phXd62uZhge7wcns9UYYig5Dv2AshtO5qMxEMqBFkDiEi47hIW4/ZyikgVhaRDGi/2X9zrVfP3UCk2uc8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIHMarr3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798f4059fso8350795e9.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764174418; x=1764779218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpAyOKJ6Yz2Bai7wo0vq2pKge/BoDT3YbbpyLjfi24o=;
        b=VIHMarr3xxC2MyDMxx6Lc1L+237Tgd6kvaOO4OOGiQ8/9FRx7LWU7M1aJxUoHvDB3z
         gISMV4BFpB8OJBbnnxoUO6dotKIUz+e6MTje3Q7tY0ow/P7xze4lS+RgKhQMWI2Jalr5
         /TJ9ZyhDacjLOslRcHwhcq3NxFEy8khl9lX8HxVNRdeKn+ZOuiHJXve+06dB2mK5dfYX
         +CJoFGQ92koEZR3PaeHRvMX1bjiw7TCGntwwnTwyK0DfrJoITLXhBYFmQmFFOy0X3KPP
         z21z/jDEtAzJ7PiP/u469g8VtBiJ7KEvF7R3ahxs6NiR1+Q86aQV3CEmIQ7QVcXOF9Wa
         nmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174418; x=1764779218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpAyOKJ6Yz2Bai7wo0vq2pKge/BoDT3YbbpyLjfi24o=;
        b=ItzBHR1h6UZLUEgxJUZpHPIFKsulT6lx08gviA/ZswtbdWwdpFnkVzSFzd5ItBT5kj
         dmqgwiyQYDAUof3K7iktdd2f1Hu3xDi7Eu9A741/NyPerCyMAa9lOYMVf3D+vIVE7TsZ
         BBf+qc4mffFLdy+lS+htD4KtvslQSWBUXzVslMZpbHsYijbQ+qNG6ZMbOmZNjMeJkSaH
         OylempvkttnufDTCex3Ro8fT/UI6xWKoNBqaZW2nX4nzevhNXDfh2YcSSlaweN/Nz3EU
         g7DWy2Vxo6WKJI48gDZ+ksIH7+DE6qiiOA1B71XcsQIO2oGG/AnOKVNckbAvv/QOqySv
         dCaA==
X-Gm-Message-State: AOJu0Yxgo96b5si5EFdDPjXl4pMekhnfO/HcMVICrftoCoV3JuB1ywcG
	ygd8dmR9Oxix9FKrO6mr59LM5u5vkjJwRCTc2PvF9eL4OQLmhyEY/BEN
X-Gm-Gg: ASbGncs8tJFICN9lVIUOzuAB8arY8oWDwy7u7brJ3ecTZrhM16DpMW1M3zMOBFPdLVl
	TcI/yufOP0KXWz1JksKyknq+XnZnxBALzROwUhFJN/AhCOn747Qo2QMDcFAwLQqrPs+1hL3l08b
	WJ/RSH34+ZcDnxiXiIMCyeIbwChtEbeW0KOXzqbxWUuGZbAkcBdz+1bPoTSI2MxdKurcvY5KM1L
	Olx7iUbL0WlE+NwQCVlNg6/WvsKHP+ocaLfj5LsLhvD0X/rAga2Ca5DjIq/mZcs8zp7wWwAzX7V
	A0g3+lcnMEORCA6wymIgC2o57PjD6wKINXjWWB1YR9hFBZvJizz2ezG98CrJ1Vv9mu7pGzqhZC+
	S+de3pggW3is7bU5piV+SiJNQaxKqNDPT5hnT7PFh63em8svElwjTF6he2aEgKsBldUeEO1YHpc
	nNiTo=
X-Google-Smtp-Source: AGHT+IGkdeqnD9yqbzrAoeydZNYIWHAMmCvdoKJOZqbNkiAFeEcyG+FQDxy2mbwwlCwcRB6Wqs6rYQ==
X-Received: by 2002:a5d:5885:0:b0:42b:3d45:22dd with SMTP id ffacd0b85a97d-42cc1d2443cmr12237765f8f.8.1764174417590;
        Wed, 26 Nov 2025 08:26:57 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:a04c:7112:155f:2ee5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fddsm42129300f8f.14.2025.11.26.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:26:56 -0800 (PST)
Date: Wed, 26 Nov 2025 18:26:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] net: dsa: yt921x: Add HSR offloading
 support
Message-ID: <20251126162654.ajcwikzh4vijspxf@skbuf>
References: <20251126093240.2853294-1-mmyangfl@gmail.com>
 <20251126093240.2853294-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126093240.2853294-4-mmyangfl@gmail.com>

On Wed, Nov 26, 2025 at 05:32:36PM +0800, David Yang wrote:
> Add offloading for packet duplication supported by the YT921x switches.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---

I like the idea behind this patch from a purely technical perspective,
but there's an important question. Do you, or people you know or have
interacted with, use HSR/PRP on the YT921x switches, in order to find
this change useful?

If NETIF_F_HW_HSR_DUP is the only offload that the switch supports, then
one can hardly say that the switch was designed to be an HSR accelerator.
I'm working on some patches to make this feature generically available
to most DSA switch drivers, rather than being arbitrarily implemented
here and there. The usefulness of having this single offload generally
available is where I am lacking some data points.

