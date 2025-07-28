Return-Path: <netdev+bounces-210521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0828B13CCA
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F5D17FE4F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D0266565;
	Mon, 28 Jul 2025 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAjRuZ9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC85450F2;
	Mon, 28 Jul 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711798; cv=none; b=F0MXzcf7OO/YpX302LThu+XPMm7ogrnBJULOhkVgvzOaEC0XawQ1+0+/Z+KeoGmHwVf6DDXRsRYpQb8QeQ239QmaoFz5tjGbO5pJUcEG/KuB0spENHjkzLXyJgdz27sFP2C0O4kq4x/5rgsEn+70lbMHVVjp22h3es7SFnM2zvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711798; c=relaxed/simple;
	bh=NDjCc8R452PUdjbuVaahxAj5XeqbSdHCMwjSCoOTiiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBca8g0mDEm5ftibh0QL5u34MqW5SB69UGERphjCqGCEjKbwVXa5FV/yvLmTgOddKdIiKkAuLMwDVi4HGh7f993O3DtBxQTXzuqN60bhpDnvDXWclxwUAPVWwAAGFQcBT4PHaAVsSwgjZs8bz85yhpgwPsmzcWhUZjKc/4LD6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAjRuZ9/; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8bbb02b887so3816341276.3;
        Mon, 28 Jul 2025 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753711796; x=1754316596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ReXTO4NOQ1zUGOlq4RJ21yg9LAY5yfcMlvjneoaw50=;
        b=iAjRuZ9/4S7BA+/07Y3mD4G5382TMKrIVj1Qkskmw0OlcPH+1P/WnTZYO7UnmwZve6
         rCj6dvhtCQ3iqHyUAaZ8tdGjAocdJG5NfIMoQnmdmPcujmQNeyNDTTIWh2ohTS+ip7em
         P3tS9FnUHCRyhsyJRWe3hiyRIEuYPJPS5piAImdNNytKw4UW3Sv1D/aGOUwXs3PryRE4
         w/30v0KwupJdiXbisLaE7grEM2iPTEbW8a1E2P26g8rLhBPfzM/IrhhLCrDw8y9ya8ZA
         yal9C+Ke/+O5zdnQUQaMHgv6XIIE3pUfG2itUlJOi9K21PjqapG8nf81je2sJJJyAyVR
         BBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711796; x=1754316596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ReXTO4NOQ1zUGOlq4RJ21yg9LAY5yfcMlvjneoaw50=;
        b=Myy3+dL4bBv4BPfC1C/Z3srGM5/Qs+ScbDDwO8iUWGwS7muCa4dsK1L8CEOuIz2giw
         O2kbadnQ5CBzdbCF+VKJimmTCQcx+ZjSemxMsy8sR+6fKxXsGRMEC2AAMNsbLSJemgix
         It/HINMzUFxh1gTQl3+4fpwDM9XEfd+7byanEDdXn/uAZniHYnRHAfvRx0g+OTdaj3wX
         9pvTOoqZU6e8I1REQ+JZ7H2LA/PV4pxabqADLEwe5hKUNSuznplg3mkWYFPKMnS6QKus
         hlShKDM2Zt7FdKPBoVGQyjjr+sQ1zU92yvpqzzTSSv+Q3qL3/aWCAUBVa2qGWy7dO/0/
         I3gA==
X-Forwarded-Encrypted: i=1; AJvYcCUghurWuZzseJ57JSm4SBfio/tdZCvDpjQA0vOfogMu0qVcQCtRVVAeQbUGt464GCRJx6ho7NfV@vger.kernel.org, AJvYcCWqyxqUhzXwyQZCB6T4vWk7hZcx1BjsemG08Tl4EpKVNQczPuajMUnpLlsrhcvXa1oIDzW/b6EyZAcKfuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08xcEX7mUbmkCYmY37uZNv9SCMgnpE3DNOI/TsIhFXLbfxm/u
	y8haLLBMI05lBAGwEwI9bZpEfJAEMN3Aw3k/Q6oECoJb25nOuA0bS9wS
X-Gm-Gg: ASbGncuTlL6f0YpnTEQjGIsj9L85Jcl+jy4ScLi1JfTNKPK+lbQ396lnp2V5avAHB3A
	TI4dBAjJpVf0sp506SfHizHEcjY65107/DZdsL1Khg2jSILMyp0/EGcTbnnhQGmuweyDmvOhiMX
	/inBt2XFFZrlR6/6GNiZQlRJ+BtootUTLW3PpAGH0GrkJsw6Kui8XjCWzuKdsbMpfgVZPwo6Dk+
	0ZkC729kDs7xpVqh7Fp2Y5vNf7xwQypbGgKc5zDHvrgDwJYY7XDkGfSlmkpnMdBl5/HT1Tn0k7U
	+H6gCX0xGjov7T7dJyWxsUV7tmoJTp8w7a9SqHlZaRM5Q0Xi59jJSzOISBwGpohKGVbWQgi8j8o
	idCwLMhvBPzoFGUD+tQTnDdzQ/iMTGMbIeb4jKgR0Mg==
X-Google-Smtp-Source: AGHT+IEmbcnDjPEVNHVDOcgbY6/zgEo1s/qZUk6+0wtVgdFvPw21hS4A4TmSd1+Eue8XTrBzHOlhvQ==
X-Received: by 2002:a05:6902:3401:b0:e8b:79cd:ef1e with SMTP id 3f1490d57ef6-e8df138968fmr12541917276.47.1753711795565;
        Mon, 28 Jul 2025 07:09:55 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df87056ebsm1987427276.40.2025.07.28.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:09:54 -0700 (PDT)
Date: Mon, 28 Jul 2025 07:09:51 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yangbo.lu@nxp.com,
	vladimir.oltean@nxp.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <aIeEr0ScB32ysLPu@hoboy.vegasvil.org>
References: <20250728062649.469882-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728062649.469882-1-aha310510@gmail.com>

On Mon, Jul 28, 2025 at 03:26:49PM +0900, Jeongjun Park wrote:

> However, when unregistering vclocks in n_vclocks_store(), the locking
> ptp->n_vclocks_mux is a physical clock lock, but clk->rwsem of
> ptp_clock_unregister() called through device_for_each_child_reverse()
> is a virtual clock lock.
> 
> Therefore, clk->rwsem used in CPU0 and clk->rwsem used in CPU1 are
> different locks, but in lockdep, a false positive occurs because the
> possibility of deadlock is determined through lock-class.
> 
> To solve this, lock subclass annotation must be added to the posix_clock
> rwsem of the vclock.
> 
> Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

