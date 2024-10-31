Return-Path: <netdev+bounces-140643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F09B7614
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708CAB211A2
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679DA150981;
	Thu, 31 Oct 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jP1K4KOJ"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6D13B592;
	Thu, 31 Oct 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362213; cv=none; b=duRxPZhJDDcDwRhY/06kPf3C3Lpf92vCFcMsFtN3lwg8ocnH7z0MGrChetF1shoVJO6Sl6vcPMIcsPUQY1rmMD134AI47zuTcX/wnd0BTcW/zkpceRk4w3QPMoACypyJ9sXaPiNz+q3GRt5anCyG6vu3/IkQjCNwYvHgUSUMSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362213; c=relaxed/simple;
	bh=u0zFcieJJl0UQTPUsFEEH8w12flh7zNg0ag0l4Sfq6k=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=pTDLZTMqaQNDSy2H8Z/2RcVguEm7cfytH1sLx13sP2Dwod9VBUIxU2PMkTPOMRwD5VioR+etcA5KLy6B1odyzKStqV3Wb8sl0SlnPIXsWq8gAT4MYuw7cBrKk/it4qoMc7wiexYZP2BV7CURu4bhQITRFEf5BFtp+GxXKaRkB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jP1K4KOJ; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1730361902;
	bh=qUbaFb4MFBE/T7Ht8F3AzaMcELszwC4DmF2bIEdangs=;
	h=Date:From:To:Cc:Subject;
	b=jP1K4KOJeekM3nPqKdua/QGr6nPwylx1Ikl/EqIzlnYgI2WqkMi/U3Ebz0suLWgYX
	 AsFAJbVCz9cmNfTSoyeYNEVGB21AivQ514/3mZq8DchgiU/c+x9/Ro/JHwv6NL25ZN
	 JCR33V5xuB6hCE7ij+Fqbd95prZGNJ7FO06E0vCY=
Received: from localhost ([223.70.160.239])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id EB12561D; Thu, 31 Oct 2024 15:58:49 +0800
X-QQ-mid: xmsmtpt1730361529t99aoe8ge
Message-ID: <tencent_99262A4B390D43E22441268D3D8CC0AF2E05@qq.com>
X-QQ-XMAILINFO: M9VsxC5s0NEwFtHcyBd85QE1DUV1fQrmY0tQ+gIl85UsPr34Dk9SMUBfjr/mXc
	 4e3+ebYpzUZRrebZXm2YYpYhGY0s8mTKXH1mEhQjD7s37houAa1xKf3+N4UhG1CKhuAg/hqlQBhm
	 bwCWmoOAQAV445XKIEvgMETXEOZ4VsBFegw6japE9w0JOX3zwGfVZJtTczCCafyEJD9mQDxOgQED
	 PHAwvkzmo+qJ8fEY7gJIbTJl6eFViIlAeeRI1H4SC/cDUD2gL8P4P/bs3K4gg+yZiILJXxuuGsQ7
	 q25cUNHlPFMhSSNlcoBdrAefUUtWjs3OyedhpTkq+weHFaA0bXwSNBT7DkUEaqWgues6PSWkt8AP
	 uLL84MHX8HlVD7ppucUai0Xdcd1wZo9pd3yG0O4Ab/c549AMc0R16yXa3NqtXWNVyKu+08BUYVuJ
	 YUy4QHDVcAX8aJmGpwDFT5mzZhEPnoIDvodlUBstrqYOjtbN5uOTYSFTKNN2P/z8fy703ts6BKi8
	 oYPdGQeTf6qVvxvL60+XCycfxa95fYZ0kYFqRoPAM5ARHAoEv4Vjo07lSxXDCBUSkcf9SOreZrsn
	 9AySzJJhk+DCeNVNsPETuw70lWdJKbTSu9JeLa+BhkFRiE4Qd6RmuR8PLO+Mw3Zzz2ROQQugSpqy
	 0ETDS2hrL9lWN+08fueqdW4xySgS+7u8r6SArmD9RTwonWfbx0RBhBteIiNx7jK3xYu3Gx5j6NTD
	 v1+MhjYLC8jJRmB/3GDonCmvCsadGPrTVOYOs29X99SeUJ8EC07NaYxQj4oYo/p/JgHTVLSoRIa9
	 DA1pxTLDmfv5d5YMfhF/MTyFNYR2Zjp/uoOoxJm6GPRafRQcWQxgplY2GETXpDdUVkIBTANt+Hhk
	 qhh6ct4rQzNf7e5Cd/4SyPRkM6eTXiLrZN/qc0c6UCV5ivMic4KXe8+UgQeKn+X2nDPcwxpvAXHT
	 N7O63/Eh5DNNU3okhBQ9oOTHhRQ+YLve/7+0Q+qGx3fg4t01UBUoXUuOoHxo5T/LSENolhGmEECw
	 iR8fsMRG3yTPa89C5UT01Ky48jYPzb7c2kdDwvpLbizvfZ+V95bKkQuYH8Sg0=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Date: Thu, 31 Oct 2024 15:58:49 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Inquiry Regarding PXE Installation Issue with Network Driver
 Configuration
X-OQ-MSGID: <ZyM4uTK5OUiOLEJz@yangang-TM1701>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear Maintainers:

I am writing to seek your expertise regarding an issue I have encountered 
recently while using PXE (Preboot Execution Environment) for system 
installation.

Specifically, the problem arises when the PXE network card driver is 
compiled as a kernel module (.ko file). During the installation process, 
the kernel gets stuck in the 'ip_auto_config' stage, waiting for the network
interface to become ready, displaying the message "Waiting up to xx more 
seconds for network." However, it appears that the system does not proceed 
to the ramdisk stage to load the .ko driver, ultimately leading to a failed
 installation.

Based on my analysis, it seems that for a successful PXE installation,
 the corresponding network card driver must be compiled directly into the 
kernel rather than as a loadable module. I would like to confirm if my
 understanding is correct. If so, would it be necessary to adjust the 
relevant code? Because it is not suitable to compile too much ehernet drivers into vmlinux.

Best regards,

Gang Yan


