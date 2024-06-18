Return-Path: <netdev+bounces-104356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564490C3AD
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7921F22114
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0741C4500C;
	Tue, 18 Jun 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xO9RYder"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AD4F20C
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692580; cv=none; b=S5k6Epk7ofZMc1TI0tjcj2jzeTSAtDMnnvW7qTRGYuWsh4xDKdEe36jQZ66JuGItfzB83mtGXnitRNzX75EvUjxQ5dDugdFpwCfPPyuVu/w9QwWBVMdzdrMIbQZ56FuSt0OVGJJzpslQZXFXDVZyCkrt6EkD8jbbCwkMfdtjsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692580; c=relaxed/simple;
	bh=HorAiVwUoW7LYUotRnRfIwiEdecpcOHae16O5TWEZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkUqmzFH1+g23jpNMW8Ex6YXABKCowA3/zkpAujCQQG0aELEhs+TuvARZBjiOwTSpE1n1eumrI6eE6uUKctuTkECClANRb7yMcLc2O7rjNrsMTigeEdLhlgF0EAzvA/hohhOjA64LHqV06k3lSe9ztYzJZVs6z3yNFYTYE7vtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xO9RYder; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-35f14af40c2so4267795f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 23:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718692577; x=1719297377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HorAiVwUoW7LYUotRnRfIwiEdecpcOHae16O5TWEZe4=;
        b=xO9RYdergkDTP2NQrfkEUvUvwElayZ2fyKebfI01Bwh4KMEJBiVsqIj18nvxCo/6mv
         qrKHAHmbtGPQQqYA4AP9zNtxBsIt4bS7wOv1/XOWlyZOCNjZyrLTmipoWYPNJmdnBRIG
         J8io5OqcWtbnVLduO245Z8n8VCF/tRJ8kT0sJCT2ZOMWXjXKRYlBYmr+ZUMNC83N6H6N
         l+qA1etcGBoV3R1dOJFyWsdyNVwkb7eb0Cps5kzvHyI8ouluPwaZxSXfegWwwW/ZX3aD
         ZPIvE1GyPiENZyB4sEZndjMBJ3h9bAxIGEEDXOKT6cNcMNv45ft+DyVv2KphAo/uZv5r
         /Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718692577; x=1719297377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HorAiVwUoW7LYUotRnRfIwiEdecpcOHae16O5TWEZe4=;
        b=VniSld81YPbmqva0XmSO3O0U++KMMq1ayhwa+IkgRL9eHfEIrx4XjyQDYbdBSynuA7
         q8UEAuMVJpBk6ETNXMTz5wYLQSMrCzCNS2l4KBz7JqpIvUNEB2J82mbj5NgwfpIN2Ozz
         HxtAKtWgwcFEPhOBf9C82StU5ObFNDhlKvwrqTkeHjec31yAQAHkEYg1OeUq2hhztsLq
         EhevnkCI5PXurzBqVur2gdNB2qn6vAPpzM4MEuXrZhzjDD1/GfMSq4LE8k9N//P0snPC
         HaTo4S9waZUBbORkLIQ65pCa8xuqpek3gfywBQPG5yJPtwf23nX99LA/cu2mLY8uiz88
         bcJA==
X-Gm-Message-State: AOJu0YxAPZYCF+SiwJGB9AbdoGPeHcDMt8m36dQ5CpKlOXp4DRv5oe/D
	vmA7/FwAgDNESLYLYlLXAPouq959+pNBUoFp0Sb6m08D5qDVmxC09L84mls1QFE=
X-Google-Smtp-Source: AGHT+IEzfrg41QpLB+nnOz5LYqdfBfsS5WGazPuYs2k2TxMyqW2goQ/nqEHawvbloR3QDeOSWSQGsQ==
X-Received: by 2002:adf:f5c4:0:b0:360:9b82:daff with SMTP id ffacd0b85a97d-3609b82db62mr2219110f8f.49.1718692577143;
        Mon, 17 Jun 2024 23:36:17 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36095093653sm4820331f8f.11.2024.06.17.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 23:36:16 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:36:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] virtio tests need veth?
Message-ID: <ZnEq3YxtVuwHdFqn@nanopsycho.orion>
References: <20240617072614.75fe79e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617072614.75fe79e7@kernel.org>

Mon, Jun 17, 2024 at 04:26:14PM CEST, kuba@kernel.org wrote:
>Hi Jiri!
>
>I finally hooked up the virtio tests to NIPA.
>Looks like they are missing CONFIG options?
>
>https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout

Checking that out. Apparently sole config is really missing.
Also, looks like for some reason veth is used instead of virtio_net.
Where do you run this command? Do you have 2 virtio_net interfaces
looped back together on the system?


