Return-Path: <netdev+bounces-131130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06CB98CDB5
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D838A2820D8
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695CF192B79;
	Wed,  2 Oct 2024 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LgvnGX/F"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECD1714DF;
	Wed,  2 Oct 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853914; cv=none; b=IJTZY0dFwWkwE0ELPjoCo9mIAFUTgseWYTae9poKKKtrki183kmD1F/E1tfSTWAPnhz7JJqV3loK2AqYdZxvd2GPAKtvqJs46kSlE1nxgMzrUTM7fJdfImIAE7S2vB/QOT2eQiz5gMZgBVduZeJewgYC6biFYxU3FzLcb8wa3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853914; c=relaxed/simple;
	bh=jr7aE9xm2bju/Qa4rHDz/VbL8GjBbvT/pzUFz+6Gw4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJFzrPtPcY11r+NfjkE0SSx+p4OTXNjpAO08/FPV+dOrB1badurXetXmh1o2mqrGeu8HpS/g/uq1o+IMUkp9scuO8y3VyxQzH98Qj7Vp1nvGI9yPEJMwbgOAlqSFHNT8ZOI5LCgiahRjugrkseOMpED7LZZlU3kF0qB/TlHL33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LgvnGX/F; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6047A20002;
	Wed,  2 Oct 2024 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727853910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XXlJdTQ5fZtHPyRlMjclVKK0w+ecbQ79TQPtjwAins=;
	b=LgvnGX/FIkPZ9scyoVF6TkBaVYqjHzG/RGN+OSasR6czr4O4DB5LoI8+aS91TivHJETl6g
	wF7+8NojymAEEKigr3nKTw7eNzLuxoTLhjGQ7IUy/XJQDJW1iW6snsJ1v4Bu0b+L+vqTdQ
	FPYeBJ/3rBeeSs3AwGF67crfTk9FUHm+crVwq2jkTib7BBbaEa3/1zIJqzPQlhtV6N7KrD
	trcmkiMiWHwaTVmAsyfjFtr/N6xlPJV7AClM1mUC9PTN1JMH7/pfOgTKfazFoiCdaw0g6Z
	p4tHn/9Xp4M4D036Ff+FyKZT7uzbwIQOhlBESL/ZEu3JH8Y4RlHGbpE4yVxRXg==
Date: Wed, 2 Oct 2024 09:25:09 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 3/6] net: gianfar: allocate queues with devm
Message-ID: <20241002092509.1b56b470@fedora.home>
In-Reply-To: <20241001212204.308758-4-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
	<20241001212204.308758-4-rosenp@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue,  1 Oct 2024 14:22:01 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> There seems to be a mistake here where free_tx_queue is called on
> failure. Just let devm deal with it.

Good catch, this looks good to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


