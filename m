Return-Path: <netdev+bounces-180343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8FDA8105C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF38788558B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35BD22C321;
	Tue,  8 Apr 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XoRvZiXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDC22B8A2
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126394; cv=none; b=BEcYojI+qlJ37REGM9AP1BmjObruP4V2oLP6At21ekelJfDa00D62klzIxJeySM471L7x3eGF5TJYGiYN33fRwmgQJBg6dvRWQCE1H5ljfaZQaC51TisFB3RZWp0YTXiHnweHGzd1scS3mwoblV9Tct5BFUF6TPMrS5qY44BBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126394; c=relaxed/simple;
	bh=fZSe9cOE6+lN1PYsZGWt0c0EBhhVZMgfo7/QsrayYj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=pKzr/UaeaByQYvER/8+DEzfTZGA697hI9dObKBuBgZ4lqFZgNYNbVXbYTjB4pksotzqlmvGKzxSMfBzcgcOepBMwWKB99eW+hB6mckcyiCqt0Q1d2gmA0z5gZjxy7VBbzO1GTBfcqHzFb2ObcuPzmHmfeesg8G1u/HeRrDOHAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=XoRvZiXm; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d6d162e516so45135285ab.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 08:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126392; x=1744731192;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIp5HkuCecJrXO42LNENOtR2HpJcHzON18/VgrUWA2U=;
        b=dtnnc92qsfvdo7ljbDwpUBCxr4ipmSFZmxb/5ZpmRqsgzXRezIFU2ldX5fg56EnGRm
         HKK0rgnvwuRErpsdnUkwMXFy6Xw4JAAKh8LANtOc1iuqq8mxVVkemVLqX0CSpDcf7UkF
         yyl3zssYKR0coE1kVKpvKK1FQWsB6M4r6j5xTfkMCdQSemK69mMLJxR16xLJRWGHiXYU
         PKzV7WKVVRh37QmQ1b7phRQW8ZFnQMkyxmm4OcJlNEtrnwC3eZ16AVD+uBflgAGP7KGk
         OnGTZ/Ane3z8iHALWhu9+vEdb1h+mbFfn8ONeXUXVXX+ncv41fZN5bx9WXLl1mzsCggn
         +ICA==
X-Forwarded-Encrypted: i=1; AJvYcCUdQ2EbSbHZlSIjCGFt6KEa1a0eLW65i4GMNhBaJjN3zRSxiCiESIglzRH1VbS4XTTUVEdHYAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFxSlVMRIE/heOqTGL0AcBFUglo29W8FLOm6VWjKluHgFGaWR
	+mCRg2y4IRntQBSl/OEzFQ4+JJakODV+ZlMPoNgbL87xzJ6rtRV77z01/I4K7xsMVg4qJug9t1a
	S0zmxeOwlqqarZLrDrnkGVb+SXvzcyA==
X-Gm-Gg: ASbGncvBtdcCbIEeU68qS4B9BZelCgUKGvzGnScDGT4QF4WKnWgLUCc9jLFylNca3/1
	8uIvgD/81B0pqH8upWCRcX/SMiGJe/LVR9yrUAwduR38R1YRfzw7EaGthm+iHKUeGcZyKtWjJlD
	8STRE8wbwGyP2uK1+HCyp30Wmwah/WYHM3u2UMEfymcxRJDG+rJhl38VQxU5VwCJbPk/q6fPsYb
	OcmHXk4K+gru/EtSmFB0Q2dbdtX4Wpf1E+GBuqQm1PaRGSBu44Feu5uWTHQ7yM89+lEBntDA864
	YgibIOhln+OVpYGl/Mv0Xk0SCHg=
X-Google-Smtp-Source: AGHT+IG0bJHf8yVxArmgqdUB1VjG2+cLxcbev3xbFIUcyxf0dWKFoKc1j1VYHlHpJORlLSCMN8zrwdAyYHgg
X-Received: by 2002:a05:6e02:2484:b0:3d5:8923:faa5 with SMTP id e9e14a558f8ab-3d6ec536c51mr139672185ab.10.1744126392378;
        Tue, 08 Apr 2025 08:33:12 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d703c0b600sm1161445ab.53.2025.04.08.08.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:33:12 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1744126391;
	bh=ZIp5HkuCecJrXO42LNENOtR2HpJcHzON18/VgrUWA2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoRvZiXmLdRa7ky3oaLJGb1Tqv3cqnbOyHOEdxKTMssua1ZAFg5cxhRrQ8iRbaNOG
	 9/9zQqEjQcKIamZ4YTOx7abJNoRNPtv8sdb+oc46Hlu3PzFvtul41m8DUhDs4OULze
	 shlA2AgFZY1ZmsK07+atJJ5xX/pM8ATUOH41E58xaKu98tjjjRdq3PSbYb45vIEXLL
	 cjbf3rmmQO6NrOcc80HFEPL33TM8RDgMz4+DJm3Op4TL8IxNWO9/gCf8rRPwzTSeKi
	 skiPf5i2kJDf1WDPXZ0LNIt1XeILe/I6Q95BmdJPlWbNUXv4pw4QnIupz97xDoNsC+
	 Nv5jLsfOCR45Q==
Received: from mpazdan-home-zvfkk.localdomain (mpazdan-home-zvfkk.sjc.aristanetworks.com [10.244.168.54])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 81F2A100242;
	Tue,  8 Apr 2025 15:33:11 +0000 (UTC)
Received: by mpazdan-home-zvfkk.localdomain (Postfix, from userid 91835)
	id 79EE640B1B; Tue,  8 Apr 2025 15:33:11 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Marek Pazdan <mpazdan@arista.com>
To: andrew@lunn.ch
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	ecree.xilinx@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jianbol@nvidia.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mpazdan@arista.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	willemb@google.com
Subject: Re: [Intel-wired-lan] [PATCH 1/2] ethtool: transceiver reset and presence pin control
Date: Tue,  8 Apr 2025 15:32:30 +0000
Message-ID: <20250408153311.30539-1-mpazdan@arista.com>
In-Reply-To: <8b8dca4d-bdf3-49e4-b081-5f51e26269bb@lunn.ch>
References: <8b8dca4d-bdf3-49e4-b081-5f51e26269bb@lunn.ch>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 7 Apr 2025 22:39:17 +0200 Andrew Lunn wrote:
> How do you tell the kernel to stop managing the SFP? If you hit the
> module with a reset from user space, the kernel is going to get
> confused. And how are you talking to the module? Are you going to
> hijack the i2c device via i2-dev? Again, you need to stop the kernel
> from using the device.

This is something to implement in driver code. For ice driver this reset will
be executed through AQ command (Admin Queue) which is communication channel
between driver and firmware. What I probably need to do is to add additional PHY
state (like USER_MODULE_RESET) and check it when driver wants to execute AQ command.

> Before you go any further, i think you need to zoom out and tell us
> the big picture....

In my use case I need to have ability to reset transceiver module. There are 
several reasons for that. Most common is to reinit module if case of error state.
(this according to CMIS spec). Another use case is that in our switch's cli there
is a command for transceiver reinitialisation which involves transceiver reset.

