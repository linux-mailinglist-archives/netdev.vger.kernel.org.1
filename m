Return-Path: <netdev+bounces-212695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C05B219DF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5C1426EED
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A6274B4D;
	Tue, 12 Aug 2025 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="0ppCyRxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A201A7AE3
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959229; cv=none; b=JYETYEl/hiscXOQtiyOHvMLhgWlOxSI4UWke5jn8D28haePeTXy7BPeshd9vGVSBvMdYOJI6mDzExbB7kztCuL3O8TKhbvyfrWci1LhJPQCQNsWPQDmbSwyWbt/ZCwq+54nYcri1osGySoUJEVEbegke0wRyG4jsjrgsp9NEB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959229; c=relaxed/simple;
	bh=rms7A1txBFb1jn69fA68NEA0zs8RNmSqekXV9OgAjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHaTdINjJl4hV8o08FzbVIv0tl5HefSH94s8Yr8H/Au/U1/lAbM/Kk2smIcNMVVrDkv57t/B7p5l7fbQ4FW31yWIkFbGbooy4CoPLpyAblqJxrkW6PoEIrntgIXYFsWtaf58YNZT/hPoKbv2QBmAvFbtGM17bbp01dNoBa/YxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=0ppCyRxi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so4096626b3a.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754959227; x=1755564027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rms7A1txBFb1jn69fA68NEA0zs8RNmSqekXV9OgAjJA=;
        b=0ppCyRxiZwPFOJVeowelBA41ImGVAQgaTKFsOU266aAQilbPcs/0y73BTC1tgu0CIF
         XszemtgQNod/WxC3tz0Co3G/ISbD8tKDhNKdlAa28Lm9wbgEjrG7oRbptQN0VqCtvJ6/
         CYnC/B3cxrf98/vS2Ac2dHzSP1eBZOYFaS82Hq04Dh0B+ad90rC7LKKM/s/fE/TodWc0
         ETxNdMjWLWN1DuB1kKh0lgndd+Z9guR/ZIlJDvF00rWBrcGHorWW+nPE7FjJ0tL0P4hb
         iHdlDz/qrn6w2iRUUNWNOmYAMNGg8pkzdc9YLmunp4HZ2Br8oC6su5MMpTdQtlsR1icO
         etvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754959227; x=1755564027;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rms7A1txBFb1jn69fA68NEA0zs8RNmSqekXV9OgAjJA=;
        b=etBZFEJiyaTJN3qJSH+yicurJpU9J5zjwnoPvoQFiavcZIItGjL3DWa3VowftyzgD3
         kt8DPYm4J/lBBSoIXGoVAAEUWC/uWVlgkeIiA13P1rHrDgXjw+PR0YwXNzQ+rwU8hzUO
         RpTA91xB9kdy+c62HdedVGlu5B2lFI2jriPiZ3L8anaZiSUjOqiIQsc1WM5UwLhYVxC6
         R9qGXcB45sPy6CxiOFyk2cUn9S6TlgQOo5wLzclGJU6OEmnKBaGIhge4dLE4yLcSmRSH
         ynZH/NBbzRxOhurxOc2Y15KfauliDI2XZGQJD0hFtsUaw/r1sOqQivx8DQ7PQ3+BXRv1
         uhvg==
X-Forwarded-Encrypted: i=1; AJvYcCU3q+9M1h3aO9YvhrppjLixugo4LRAAxiWPkNPW/QBYHiUdC6MiHm1AKG5IVWwVqUXc74zL7Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnecgretNqfU2w9OxySVm+CCHZrA0t2ljjCdAOIDGJT4uByGr
	IUl+uTPFc/p5Z84LmVTv6cVm0q3Lgm1o+2PZRiybBlOQhtN4D3J6IuO9XiMxZOZUK18=
X-Gm-Gg: ASbGnctHyBXJ2Dq9Ww+9RLXZ8Vks/lgV0O1BaQLQfffOxXoSnWNz9EO5DbG2nBdrfoh
	IF1I8H+k3vZAbEuIoaDztgwpjBEINRu1cwRcetp7l6lPm7rx0XrJYEtgEUHWr8IuSYXqYfnxIJc
	p04xD/HMVLm0X2GUiIzGjIxxcbeV32fR02iOk3W5miBHJeL7UIgfR/GkxVDXVDJZ/+OhGue+rMX
	VNujXqlw6ByT7uFJpAy0liMAgJXloVLkzVa8NgyiI61TKDrUeaKmUUvHCsOxZH0qr48P7wX5uzv
	eZhqlIPjhgLDkoGEhrOqsv66vu2zTWA1gX5hCimVCtCXBPqdLZRG5t/XMfEm+Xb85e+GOBAhy0j
	3vDCKaXRPPc23ty6j0HcJZTYVA7mc0FCx/YPFIoUYN2tbE7rPajfhIAIXOu4o9/6UdyM=
X-Google-Smtp-Source: AGHT+IHUg8iFoT4TmU/bzvkMx35fYuFrUfbHSSQNyIuLRhC38FMVYtBRsGIq7qrTUuuvbzmxoEkF3Q==
X-Received: by 2002:a05:6a00:1388:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-76e0de2ddf8mr2497799b3a.3.1754959227113;
        Mon, 11 Aug 2025 17:40:27 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6fe4bsm27859472b3a.9.2025.08.11.17.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:40:26 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:40:24 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v4 0/4] net: ethtool: support including Flow
 Label in the flow hash for RSS
Message-ID: <aJqNeO36UpQ5KFI-@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com
References: <20250811234212.580748-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811234212.580748-1-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:42:08PM -0700, Jakub Kicinski wrote:
> Add support for using IPv6 Flow Label in Rx hash computation
> and therefore RSS queue selection.

I think this is really interesting work; thanks for doing this.

Do you think that the docs (Documentation/networking/scaling.rst) should be
updated to mention this setting and the side effects of using it?

If you agree, maybe that can be a future thing so as not to hold this change
back.

