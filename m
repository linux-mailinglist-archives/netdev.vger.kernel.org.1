Return-Path: <netdev+bounces-242425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD9C90533
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68AD6350CE1
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 23:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B34832572D;
	Thu, 27 Nov 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQO2ZFUL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F18303A0B
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284834; cv=none; b=PaOmnqTDp+hDPB32dWGEbLd+h24hcg+ojKHbIOhblkGcfqowQZXeNVWR8w7N0wpmWifefTZM815m8UnfrlVvspAgA5NGKANSdAfeuDBnqyJhXCmxZ3vm6gjDQUr3tAL/FI/Tx5R9oqu6tvSpyGQ5ms8NC5+o+6pzXl9JaqqLY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284834; c=relaxed/simple;
	bh=8x486c86cae2O35/f5tnP2l33NWNcPikATHHtWHs6s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce9KLWLBkwhxIWauYCDPoFw8XmKu/tZVLccf9Yh4W6jlxze3A9VlJbkq8j930dyD46CkpqJfgSYcET2AaZtw/YGWyXY08iIDS8cjUSP4m1TGO+CoOJdqGB+9qV2HyrIpqcl5p/pESfqiX1/pk25jM4F0IDBKS7kATLBBpi17Gmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQO2ZFUL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1441700b3a.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764284831; x=1764889631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKnH/O6aeuLabuK/xaqPRLLII/aVcAqLAoEUH3ot3QU=;
        b=GQO2ZFULbZSVFf9DcUa10z22lmjdC0mh82Ld/Sg95XKv0ZyNEQXwodW/NWHwRivhdd
         EeXysRHIOO8ju/EOQ0SgBKTNurvSfNZ/SPY8+M3sB+Mz56dgAl30RA2xOzT3vnRk+vXn
         dyMlSNL9w717ltvm8p30sMPBLdIj/+PRL3koaJseWBCG56dJf1t7DE0FUhbgn3fl+9Kf
         FIwXveKuw8roziKt7KikshS8bSUTP5ugDQEezHmfOzykUHoak+iwuJNhBknghaJ+TOj5
         uQFn/QKLQs80VcGnB9TaR9+tRnlvDqQRGw7jSD5aBB8IQUUHl2ZrOyjtoDBHFSWQsjlL
         R5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764284831; x=1764889631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKnH/O6aeuLabuK/xaqPRLLII/aVcAqLAoEUH3ot3QU=;
        b=qhp8vsNHXeN0YBFPa7FCPodHJYsDxyYIOpReR9rQiY1k8nKq6zUEaAAEpelihwgiZP
         GlxrC0WpGQNpcIGpqvVClESIifl5MMho2EsV2kjwUvjX1I7cWP5bJ21rs9IqHek0WOM9
         5G1UVTl7U2uu1q9rZndwRB6+OUGSSTA6Wx2ySL/h7ifx+EIl0y+5YXrrzrC5zAMrUWsV
         Fx6lgN2atCLRcoxThqAxxTbX1KZ57cgTANTtHWmclZnqkUd7nTXIeQ3HKYaC6+Lqy/N2
         bmD/4Om7joGfiA+Gttsp9HEXYTfzfv0gWgee8xkZJ017AXAPXrnjTm0G319NwPpkKuE0
         jvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkQcAW1ZORe06NBJcitDnegucU/fjZutmbxGIBXYvxCQrSY+uCg/KMk1fqy5/ya/ZJm2x3QV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2yGlS9h+e/hWp0dCyTfPuXA5JDc8WNL4fsyYK4ZJRKiV2AZCG
	yim+NIxBeJU1zhM//G6v2oJhsEB9pLTbf8hEsBQz0C38ppVI5NvZTdcS
X-Gm-Gg: ASbGncsKXpLnTjS/uxTEizopjXM3iq+8vFanZdUAyRL796a8BIKVBD13e3nkgv+hz3C
	kBQLu0hElG5owFrQ3uVhmhaut4yKv+XNtQze0jzsq5L11nO/M6bDMS6lCziVSQflZfF/DhaF8Qi
	UKQvzZuiC8Byn9r3RixwHrqAQwhKmdBw6GRtX8msqGJ+6aeFKjdSOc6SKdE03koVAZ93RG6/FHq
	LLUSIGm12E0+bW4oQfYPC/c6IR/w8Bg3jk2GpJoVlp5VxR8hBfDuoeRGjd8eGGlAAdg1HROGSCt
	ZP72NVgQI1i0mHCFcCFp/0nfRUj72BMg8tatYravS4Pnlj9PuvPfeGMX54c5MN2MA8sa0Oty5VE
	4aHa+bbyctPZiuE0lOojRsEYIlT+g6svpLGebs3wdew+ekPNn/ckEFbUSx+jkCTFRazGgDRSnMX
	nBFMUqZAsBbRoz5B6DFMtu
X-Google-Smtp-Source: AGHT+IG6MZgRCqL3UfX6DVxG1TmGMoJ5MDpYjWvx0pC2uBQPQIC2ocWSFSAf02GnYqHCF1kMNktFsA==
X-Received: by 2002:a05:7022:6729:b0:11b:9386:8263 with SMTP id a92af1059eb24-11c9d872430mr18306094c88.48.1764284831144;
        Thu, 27 Nov 2025 15:07:11 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm11559761c88.6.2025.11.27.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 15:07:10 -0800 (PST)
Date: Thu, 27 Nov 2025 23:07:02 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] netconsole: support automatic target
 recovery
Message-ID: <v44skio47zulg6jok5wq7w2ylw4abk7dxtjarlgnuz7hukvbts@7clzpd7cqc5u>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
 <20251126173646.696537af@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126173646.696537af@kernel.org>

Hi Jakub!

On Wed, Nov 26, 2025 at 05:36:46PM -0800, Jakub Kicinski wrote:
> Netpoll does not seem to handle DOWN events, so I'm guessing your
> primary use case is that the device had a HW fault and netdev was
> recreated after device reset?

Correct, this is the intended use case for this series. Handling cases where
the device was unregistered and then brought back up.

> Should we not be listening for the REGISTER event then? On boot
> we force UP the device if we find it, theoretically there may
> be a case where user space is not configured to UP the device,
> and then we'd never resume the target?

This is indeed a limitation on the current implementation. Based on
your feedback, I'm working on a new version of this series handling REGISTER
instead of UP and ensuring we force UP the device.
This will make it consistent with the boot behavior you described.

Based on my tests, I can't force the device UP while handling the REGISTER event.
I believe this is due to dev_open attempting to lock the device which is already held.
For this reason, I'm resorting to defering this to a workqueue, similar to my approach 
on v1 [1] (but correctly handling target_list lock).

Let me know if this approach makes sense or if I'm missing something.

Thanks for the review!

[1] https://lore.kernel.org/all/20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com
-- 
Andre Carvalho

