Return-Path: <netdev+bounces-127520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20259975A7C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8B62871D3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1F185B7B;
	Wed, 11 Sep 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jbsky.fr header.i=@jbsky.fr header.b="tIqmMOVm"
X-Original-To: netdev@vger.kernel.org
Received: from pmg.home.arpa (i19-les02-ix2-176-181-14-251.dsl.dyn.abo.bbox.fr [176.181.14.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F37DA66;
	Wed, 11 Sep 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.181.14.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080327; cv=none; b=E3YigIFgdyjredhf7oCCuv6bOdHp7JtHgpN8oFI7iHv8neEnUqilQmruMhoORAkbSXPywtSiHDRvgD8KhVUuurEDblWQLW96fjoTDObxNlYlAsMTgdaba2nowdtYfYkjao8Lo4Fu+UzO19RYV4E+r8D6kLUNcAzuRLkwwl1SH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080327; c=relaxed/simple;
	bh=gW5j0ruWh8TrtaENG4c/a09DC6UAyDssRURGEh0kYgo=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B7GktIPiC8rz5JVEJe3DVYoXadPZC3Dsh45Jn0Ug9ssETX9uYA8Oz467vh6hYCUmWgLAqCr3DWvFM44rc0jAAy3qQVJ2I2Ynydnilf4sSIPW8xKfn8o58tinEk78LryODKE9IKdiikq2IxXuL76N61MqYrQJ2+o7NzMv41Inmvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jbsky.fr; spf=pass smtp.mailfrom=jbsky.fr; dkim=pass (2048-bit key) header.d=jbsky.fr header.i=@jbsky.fr header.b=tIqmMOVm; arc=none smtp.client-ip=176.181.14.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jbsky.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jbsky.fr
Received: from pmg.home.arpa (localhost [127.0.0.1])
	by pmg.home.arpa (Proxmox) with ESMTP id 8AEDC223CD;
	Wed, 11 Sep 2024 20:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jbsky.fr; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=pmg1; bh=gW5j0ruWh8TrtaENG4c/a09DC6UAy
	DssRURGEh0kYgo=; b=tIqmMOVmXKn8bY/6hEOL9C47CSHY/Mh8dpAXP21pdcDi2
	BrFZKHfAux+XZaXHLU2nY24rA4x9hV48lUaSH1sC1zEFiCFEfyae8rnWVFtZ0mXa
	OUT+21Dp/eXbOv4RfMuveWUujX4bh+OnJRSL7zBXWrXYcfFVmVVOZqPLFIuIED0i
	FH07l//gnHSjsXp7wb6HukfQA/Pk8R1HN2P9yTObzGA8xWPDMFeWZoYCXVaVV0tb
	kembyrYYT/bfiP1z6AYRH5Hi1WoeuCxBzo4f5zIp/7G5mXYJN5w46ooSQYgcrLC5
	PHJ/ZoGonXhLs5vMKRrZC46N1BLaIFl9xIMKn/7Sw==
Subject: Re: [PATCH v2] mvneta: fix "napi poll" infinite loop
To: thomas.petazzoni@bootlin.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240911112846.285033-1-webmaster@jbsky.fr>
From: Julien Blais <webmaster@jbsky.fr>
Message-ID: <dfdc195c-eaca-fdd2-5540-d4029bddd465@jbsky.fr>
Date: Wed, 11 Sep 2024 20:45:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240911112846.285033-1-webmaster@jbsky.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Hello,

Maxime, you've enlightened me, yes, what I've committed is useless as
it's dealt with further on.

Anyway, I can't reproduce it, I was on the wrong track.

Yes, for my next commit I'll test the mail so as not to have this
“disclamer” anymore.

Thanks for your feedback!

All the best,

Julien Blais



--
This e-mail and any attached files are confidential and may be legally privileged. If you are not the addressee, any disclosure, reproduction, copying, distribution, or other dissemination or use of this communication is strictly prohibited. If you have received this transmission in error please notify the sender immediately and then delete this mail.
E-mail transmission cannot be guaranteed to be secure or error free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. The sender therefore does not accept liability for any errors or omissions in the contents of this message which arise as a result of e-mail transmission or changes to transmitted date not specifically approved by the sender.
If this e-mail or attached files contain information which do not relate to our professional activity we do not accept liability for such information.


