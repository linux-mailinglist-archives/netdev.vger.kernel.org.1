Return-Path: <netdev+bounces-181495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999AA852F3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07F41BA1D35
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2327CCCC;
	Fri, 11 Apr 2025 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Ab6SQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8827CCC6;
	Fri, 11 Apr 2025 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348503; cv=none; b=AnKb7/4j5Cs6YDD5QHoRlfNBO2EhKIGG2qIEZpT9ssj35qF0GCaJJC9J8XoG9Log2vdJEXjMPKtEbo4GaIbd3FJahDmbqpnYRqcFnGiJTwZKhvAKQmgJYSHwzfQSF9mV4lKAZEUzcXnHIO7xVzRvZcf0KOu9tfOSRzs34zx1pYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348503; c=relaxed/simple;
	bh=FqzIv61qjaBq3HQwMm6m2HdY43aUYAekO851IFQD+hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVxC/YO0Uh5rck1MQEK6YfO38SRiN/D6am69ne93okjG9ka+bvxWfalp0bid4olDNjYFriGSz85km2sDrcANRFUGFFySrWYpMHNhfYPUtCJBbd9IHmwvdmHzPa8ujYqN7aAy+MFzfWom0cBLq5biiEGWu/8PvM4oJqV4xB6HegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Ab6SQ9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736a7e126c7so1441711b3a.3;
        Thu, 10 Apr 2025 22:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744348501; x=1744953301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FqzIv61qjaBq3HQwMm6m2HdY43aUYAekO851IFQD+hY=;
        b=P0Ab6SQ9b6Wvih8GMrfQ/N4575Zf8YT+Gg/fzVik/I5acjW1lACXSZLq7YiDbSP7Eh
         0uOOl5WE1t4H6XeRQrBKU456GwHfCvU8DN0O91QmwPFaGTLZGG3mnCmCKTufSNX8+W8P
         rLQ4fDpSAtgqrtPM8NzycT1MFL+UNDVqY2KJNVE1s6s+ZwtNVTgo1kl+lBT6GaxQ8hvW
         UmDm5VsbbDOebJVJRHX5tRq+eTzYS+wm1fhl+ErN/xyCrI7f4+I7Im9zPnkfg8VUTpaU
         Rl1MgRVINjIp3T4pggCPQ56hzYIQBSZFWvmH7eF42s5a15AM1Av2SovFV05fBPyOkXuG
         dMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744348501; x=1744953301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqzIv61qjaBq3HQwMm6m2HdY43aUYAekO851IFQD+hY=;
        b=NB5ni+N7o1wjE9MqYkrhyng/pkJAJjjLL1FuOLPOhqEfXqLTuI13nlLeG7XReKoqVh
         JAV9RFw9B3J+T2Lr9xuY8eL0onXv4Uq9b23e/YNe1rEQCf8q3f1GaFI5WMmsHVf3HHYU
         zMBVgXj8OgmCkB44JHa8R0A9Diepbxnpyy17sD9Lt3x7a7HPDZToZI47dKBxHmhPLy/L
         +Bk1ImfsuvPuUYdNc2m4fxoGlBcXQ7Ddpcbb9X4iA6hSS8RyC+vsr8/0K3Ph4/a0E8OE
         mUThQAJhq6fyeuochLvjePJyXG0x3yNyx6M7n/OyjTKAMV94mg2n1rH709q2MGBdjnpo
         OsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYfN6fdsPbAj56fEFzPef7arcEz94vD7faqxWGkvz6bFtmPG2M1VyiIuW38ghHt4xKoxwOomBdYRVnp0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhpk+hDkN7xY9X73UA5GYJEl/RkMpyjnVhlA4i1aH+Q09vvOK
	vXWKwoTSFbOVHwc8TzI4+QDI5MWjaZJmeEomjztwmX9+JQ1bz7MT/wmG/A==
X-Gm-Gg: ASbGncukOA+YZvsbW0VDVvvH03I1mC+amACnzw7aa/pxhvvg4JOxb+fe1M0VeBOi0I3
	ToviSq1ZkQ1F1ZKkjxvJ+n4UkqXCZamzGprubqgfJ/rnOZ8uEKizvUq8ktT2uVClLxt67CfluRD
	R/63Mu0mSBcF1or4dRYbAbg+sU5ti+wmN+ZukNifLhhkF1XJ+Hphc2Q/t7UvYYYnjzHFXsQTHZG
	HjUW3ZfOonj6jgr/puZ7i3IWmC5Y+1De5NotyhYsBOeOt5YQ8/paQtXZ+JjbR1VSY1NtordoE20
	EwnectP1B2OJYv8OaIRqxxj2bwQtLH0HfQ==
X-Google-Smtp-Source: AGHT+IHSRZgGM4nOz+W7TZodJ8i547Me4tXuvyxwsh9vyWPxSQCZRcvxoxwDJ+V0F8bLLps9/MvV7g==
X-Received: by 2002:a05:6a20:d70f:b0:1f5:8cc8:9cbe with SMTP id adf61e73a8af0-2017978b0d7mr2164327637.5.1744348501559;
        Thu, 10 Apr 2025 22:15:01 -0700 (PDT)
Received: from nsys ([103.158.43.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf3604sm3973222a12.25.2025.04.10.22.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 22:15:00 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:44:55 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: ngbe: fix memory leak in ngbe_probe()
 error path
Message-ID: <pok6kit3b7c7sv34mpvmzulycblqys3ntdrz7oyeofxhtfcht6@xa7iihddqrf5>
References: <20250409053804.47855-1-abdun.nihaal@gmail.com>
 <7ff3877b-1a76-45a1-ad03-922582679397@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ff3877b-1a76-45a1-ad03-922582679397@web.de>

Hello Markus,

On Wed, Apr 09, 2025 at 05:23:39PM +0200, Markus Elfring wrote:
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15-rc1#n145

Thanks for pointing that out. Actually I wasn't sure about which commit
to add as the Fixes tag, so I left it assuming that the maintainers
would know better.

I was confused between the following two commits both of which change
the kfree(wx->mac_table) line.
- 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
- 9607a3e62645 ("net: wangxun: Rename private structure in libwx")

Regards,
Nihaal

