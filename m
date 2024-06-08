Return-Path: <netdev+bounces-102049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301889013EE
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 00:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54601F217DE
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7FA3B182;
	Sat,  8 Jun 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muWYXXKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9204FC19;
	Sat,  8 Jun 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717887511; cv=none; b=AcDJCvmin6zXODPDGmlpyNo21zKmDMD4nbwqsja7MOBQkO2VxKenrzZ7VXSTBz+BqvQExuGAgz8RfYjTZUVWeOC6uHzpoL0Bw6lZCqzpYIBNg+SaQdUJWW322oAOuxnvPPtCyLccrGHCI8hnNxDySjmWoyxS2g4gmWAcrMBL300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717887511; c=relaxed/simple;
	bh=XdcWb0sHax8NUfiRR8sBcfY/ZUDS/yJ5K90Wtm2ykyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrWOffoDdHT7S+a18DQocDfWYKwC4fGKEOfThXAGbaFiCuQ03AF8vBZW0bk+D2s91ZRJpGjcQrio6/9Q0BL2sF6n8NRyK2aA7cnT1sX9HXZ479T/yPibyj4+wOSRWBMlzGsDJ6miSTBd5PUPTwiAvorqyA+pZldu2cqClKf8tIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muWYXXKN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c614c572aso1494065a12.1;
        Sat, 08 Jun 2024 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717887508; x=1718492308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnNwc2LGbMmroe/knes/Yk2//+knIMtvNN3CoAHTpmU=;
        b=muWYXXKN56dydvYALu9n833MZGWLzTg0tXeeJwuJnE9tArG6FQKlVsN7n+OCZO4Nbh
         ZDjnuDSfKOMjytmSxYr5jAdcHXvPbbKSYCT66f8JlEVwlxorJHnldH3sw8Dz4Fb0KNBk
         JZ733ds4UyLirq17jVDts6tClR0IwKIXzjJ+2kSew8d6IdToYbpbkPKxfjUo0dkPlhqZ
         MtyyVab+dBMVQRZA8dchYgcbjnqowPFQpHUSYWT5gqh1u5KQt++5F1Npj9D0Wk2M4RYe
         CIfni8sdzk2ODOYhIyUqaYdMocXJJGgGS53iS4Uno4mrx2h9Z6PIKiH5ykFLQc02NAjV
         rjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717887508; x=1718492308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnNwc2LGbMmroe/knes/Yk2//+knIMtvNN3CoAHTpmU=;
        b=p07pot20LqVw20oR8lOuKRFB7P2BirpVkrB6mlgaJ3HZ40IB2wNLF2e74p8rY+YVAN
         fMzL875LEFSOs/BTsgQNUJKz6Zglaohd4AOASTnJFyzE5PTV1oRp8mW4ay+tIAz+DPk2
         Errh8K3G3K4bwU+s3WjB6OFq9m5s1BvqQChpOfwfOlZGpwyBIP4hCpb2t7/3fg+769Kk
         C67Q+ZGll4r5S8UszwQLZ3+EzcdFuTtD42KkeuWqoRFygqg6skFlPWixfwmmOwQ5RzN8
         /Ix2cDvNC/r6ZeEwTIx5Ws18FUuK79haxEDrLH/mMuHxb/ZaLQdF8sl4YBfWxWm8u/eT
         E9rg==
X-Forwarded-Encrypted: i=1; AJvYcCWr4KNxbGcg5uYSCSHEBLMfZF+fJwRq5yPr3qLH80u3EVpBWe7yq/4CtqY3lqHum19vAUrT4SzK7pFEQ4Lr8vuLKke6ZRUgN6lzp4LsOryzxquUoQb02r2bNv30W1SjVa52Wu32
X-Gm-Message-State: AOJu0YxGr1zOlbOoAb/NtG4+QbXST5USm7oDXLdwtlSAxyNEaTISMEdJ
	uBYe3Ie7SAhphBncGzGtRQqwfu23qbkOVa/wwuTUQ4peGpoatDvL
X-Google-Smtp-Source: AGHT+IHzT4dW0AQbWU8Ll27rAW1mMXU6/phWBWaFUZTgEyUAKve+QqneDBv9Atir+V20O1ejYoBo6A==
X-Received: by 2002:a17:906:495a:b0:a6f:cce:4457 with SMTP id a640c23a62f3a-a6f0cce4ce2mr110771466b.71.1717887507926;
        Sat, 08 Jun 2024 15:58:27 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f16427842sm21529266b.100.2024.06.08.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 15:58:27 -0700 (PDT)
Date: Sun, 9 Jun 2024 01:58:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	wojciech.drewek@intel.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net v5 PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
Message-ID: <20240608225824.nae2ptctjzf5reee@skbuf>
References: <20240608143524.2065736-1-xiaolei.wang@windriver.com>
 <20240608143524.2065736-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608143524.2065736-1-xiaolei.wang@windriver.com>
 <20240608143524.2065736-1-xiaolei.wang@windriver.com>

On Sat, Jun 08, 2024 at 10:35:24PM +0800, Xiaolei Wang wrote:
> The current cbs parameter depends on speed after uplinking,
> which is not needed and will report a configuration error
> if the port is not initially connected. The UAPI exposed by
> tc-cbs requires userspace to recalculate the send slope anyway,
> because the formula depends on port_transmit_rate (see man tc-cbs),
> which is not an invariant from tc's perspective. Therefore, we
> use offload->sendslope and offload->idleslope to derive the
> original port_transmit_rate from the CBS formula.
> 
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

