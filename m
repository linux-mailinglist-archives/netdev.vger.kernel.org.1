Return-Path: <netdev+bounces-146447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C39D3770
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AFA2826D2
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F919CC27;
	Wed, 20 Nov 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eeDCWYI9"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED018EFC1;
	Wed, 20 Nov 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096292; cv=none; b=maDdQhjgBZax+MN7C+vItEbHHgDJeRQrfkcTzW5sguonqfHMJaVENDFvgvrwAgV0mV6KOL5n6Xa3v8L+de3NLd9K9RKHzCUHiFsvrwCVcXAPUxDlvqHJTWSte0pMSxQiv1k2pjWjsUqLzRsywLPx+nHqM0DR7cwrhjfOunc9pzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096292; c=relaxed/simple;
	bh=hX1ZJF+sGGIC+8ruMcNzuj5ORxT9wSray9WemWCxTyw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+X/jP9b1fge2BungO7pkYNyPAuWnXTLs9XfEQegtScy4ouSRIaEoubf/1Br/SxYQ4sFABwAyC5QklRaNNqfw8uZNvJzbfUG/c6otxle3aMgX2UFpOsez/F870Y9XVFZHMSx0MUL25MuyC7KeBddXtCdrHMrQqqpgZ3EQiJI3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=eeDCWYI9; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1732095977;
	bh=hX1ZJF+sGGIC+8ruMcNzuj5ORxT9wSray9WemWCxTyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeDCWYI9Ys8QDbAwJ+8duDW9BJLaRGtrwOKNrOA4LF6lwv32DkazcmRaSyA7cGXSh
	 9GlIPqYi2qOyeYIQGY9RxChXdqW36pZeFkv0dEvUUdm+m7ulfCMYdwLx2mbiYEzUV7
	 Lk4O36lG4wXDuAzWH6cTrnxLVJnnQWsOdmmAUxgY=
Received: from localhost.localdomain ([111.48.58.13])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B8F32AAA; Wed, 20 Nov 2024 17:46:15 +0800
X-QQ-mid: xmsmtpt1732095975tomnem8ce
Message-ID: <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLZ5Zmw0+h4a+g4rLsmAD3gPh+J7MA74U5LwZfUeO0GXRNk8i1HB
	 r00ykJkRGzA1uZWYHYakHlq480PetZjVTFjSLAvrXWFyX6YhHs6BKa4bGEkzD0Ndfy+a8q8FHIdx
	 ejt5v6Gf/y9IxIbm2r0UU9bVYUbkDRArA5HzCIxu1XnHnmqNmB44HNLrT+B2GSDsrkA0lA7gMfGw
	 2R86FWhw8011kl7wjnZpLAvRZDzLztNQG8UNKkF7Du9D9zTzG5ac33nSOISWsbIYqywOvkO7fvBh
	 gAWucWFcoFYJ+xLI/w5lGtq/ZwBeDkanTBOC4VlvLjYmMW47Kwscovl4t6NupgGROGmQadLHXMR3
	 nsmAOYNxUSV1l33U/i/W94KWsWIN67zlArQrDfjGIl3aF+1gxnKbImIOdiMqj9UMT9gSmSC3nJGU
	 oZE9Va2iYbKZewHV3royWNOxBBInG87LT23o+unInMkdwf0AYj/xlyjX1Dy4/x4SozeRPqDJgyJX
	 imzznUkazK7aOvsqE4V4/y4yjnUD7yzVkYFaZ7LXh70X3dIWALj0qSgI851QHidGBb+URUh/5Cc7
	 +P5NgWlghbtSBC76selZf7LZDIVvHNOowMCMy35xw3Y9kIaIOQuE302d1h0RVSeDgHoV5wQbqlFv
	 g12wlwgwMtY7KxQNoJI0SDdLF4nJRpOe1pGHn43X0JJ7iQweXLcE7MK8/Y+AX05zgrajfpZTDwdd
	 1GlrXwS3+PgJZjG3StTXo3IZebBdob7STcf+Ok4bf+zmvByBwp/AuMl78lULAqzGcvnmkgncpcJU
	 naLorrY48Da2eVaN4j32814uTIkJfPUoCVdLcmwPbIaiDR8FWv6teHcnn1Sr5r3xEY98SKpJ04pF
	 KX6WC599V7CznzEA/LEaJI7Lf3ZSb+NdqAP8GCoA+rz07gDjO4R0l8g3KxP8dcAOm55VV5Jb6znZ
	 Ab8A+n2x4Qf+4A3dOt0Sm90gyfsje9jZz/M+Es3bzVq1EmegftWlMh9NA/5cbdOZA1MWw9Ei4=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Cong Yi <yicong.srfy@foxmail.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for improving code readability
Date: Wed, 20 Nov 2024 17:46:14 +0800
X-OQ-MSGID: <20241120094614.175215-1-yicong.srfy@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Russell King:

Thank you for your reply!
Yes, as you say, there is no problem with the definitions themselves
being named. When I just read from Linux-5.4 to 6.6, I thought
that PCS_STATE_ and PHYLINK_DISABLE- were associated in some way.
After reading the code carefully, I found that there was no correlation。
In order to avoid similar confusion, I sent this patch.


