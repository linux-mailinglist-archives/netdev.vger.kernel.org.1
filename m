Return-Path: <netdev+bounces-103579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C734908B2F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257E91F22728
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A9195808;
	Fri, 14 Jun 2024 12:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B61184108;
	Fri, 14 Jun 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366460; cv=none; b=sb5SKsZHw3MqCBqKQhK0tHsYJ64r47H7e9KxMFoVd0CFKsMv+GhnElIs+YmvyW8jpHkGPNJfm5xm3El9rGJikHgQqaWCSmDKWDFHr+LHIj1HykRInwAhYGNUQqABnQOjPhpf5+DCkcCzXbEHfibQ0MB52TozUIaxJEkpwktk+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366460; c=relaxed/simple;
	bh=MgEc7xmF7iEZYhCWJxN5DpXt7Nk1yu973TKHIqqKb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bev8hN+ZiO0AuW+BfGN75CQtR6Glk0AFIV+pqUjGZofkbemx01DwqjpgaEMBR3DohnEhkJT7qYC4x1nFRu4yeisFXVGEq1RaCC80kEDc7uqFyXpm+9lzJgqYRX+qd+m8i6H4Aln7e/q9o3emOPZHP60CtpFn/Sqh/W6M3OIArBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so2266220a12.1;
        Fri, 14 Jun 2024 05:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366457; x=1718971257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx3+tEx/bRO112S5D6MlGbG6rpWnWaRFWOVaBF2ErTo=;
        b=tWWc7Ol9wb5VHKWwhkimqHDLmcL0XO4HN5WnWBVD1qMjGnL5np5pfQNLUDXX74WTJy
         YRUfySHCXt2txUzsK73NuE5EnGhNERMjDtPYvY93QwlOv7Jqz6/7SMfwfALZoE5ZNG9Z
         LusVMlbVu0qbv6GvgtykXwmI0mgVyVeuxh0DeU0QcecJa3SrWhhWI5BT64EWFTjyunFN
         RaT4UEdkdZckhlFR+oaEAUMqQ7cWfMjhzNQbk1MA4i37TEtZPl/zpRANf0w6lDuYHAik
         iEvLykAUfh74oT/W4CFp6YWpylNZDqIk7Cb/V5s6LazRx8fHUx1R4yShXoMFQ4OuFlci
         Fhtg==
X-Forwarded-Encrypted: i=1; AJvYcCUmM6nsfdt1ypXBHKKnOBMvMDTCcuKyKeF30m7CWwq6SzDU+Pul4Tsa7iDJiyS5WZCkexSCGFzs2vFkVCyH1en+LMVLFU1PXXz9Stx+FQr9Y9TczJkklBjNljH5oKNUteLq5IFR0mW0P8TetCy2oWJ+OQ3Ux+OI6jBVE0dLGzDnhOD4Gs3w
X-Gm-Message-State: AOJu0YxS+NUyKiae3lhQPoCDAirBg1EsHy74UkqRvMSG+ThFbCqN+gm2
	mmjchU++X/rNC3SkzFNhpsmVJeXOaDdNCZ5Cz5eU7NIpj5WjtZbv
X-Google-Smtp-Source: AGHT+IHBHm31PZ29e6nEa/Y7XqntiW6RZwljeYbps4cAyXiamfw1DNoVUOfdzjPeP2QRHz/hnFp9FA==
X-Received: by 2002:a50:d5c2:0:b0:573:555e:6d89 with SMTP id 4fb4d7f45d1cf-57cbd652436mr1663002a12.1.1718366456759;
        Fri, 14 Jun 2024 05:00:56 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce067sm2206196a12.9.2024.06.14.05.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:00:56 -0700 (PDT)
Date: Fri, 14 Jun 2024 05:00:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device
 _properly_
Message-ID: <Zmww9tS2eWt3mnj3@gmail.com>
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
 <20240507111035.5fa9b1eb@kernel.org>
 <3b08e1d0-62be-4fae-9dbb-9161992ee067@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b08e1d0-62be-4fae-9dbb-9161992ee067@intel.com>

On Wed, May 08, 2024 at 11:13:21AM +0200, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 7 May 2024 11:10:35 -0700
> 
> > On Tue,  7 May 2024 14:39:37 +0200 Alexander Lobakin wrote:
> >> There are several instances of the structure embedded into other
> >> structures, but also there's ongoing effort to remove them and we
> >> could in the meantime declare &net_device properly.
> > 
> > Is there a reason you're reposting this before that effort is completed?
> 
> To speed up the conversion probably :D
> 
> > The warnings this adds come from sparse and you think they should be
> > ignored?
> 
> For now...
> 
> > 
> > TBH since Breno is doing the heavy lifting of changing the embedders 
> > it'd seem more fair to me if he got to send this at the end. Or at
> > least, you know, got a mention or a CC.
> 
> I was lazy enough to add tags, sorry. The idea of him sending this at
> the end sounds reasonable.

I think we are almost at the time to get rid of the last user of
embedded netdev.

	https://lore.kernel.org/all/20240614115317.657700-1-leitao@debian.org/

Once that patch lands, I will submit this patch on top of that final
fix.

Let me know if you have any concern.

--breno

