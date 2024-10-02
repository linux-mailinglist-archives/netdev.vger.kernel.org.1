Return-Path: <netdev+bounces-131137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09F98CDFE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B41B220D7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4431940BE;
	Wed,  2 Oct 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CfGeK1vN"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0A1FA4;
	Wed,  2 Oct 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855232; cv=none; b=hTZivaXS8nTnaXKkpuvAIPlxtIM8bA6AOZ6fJhqDLwO+Yl+9jaGtiBRLNXdRV3F6Bea/YuVLFFOkm2Mw8nk0M/Is9SI4MOJ1eo/ay7zJQbfws/x4nGSB6YyO63mDT/mLchxF2xj8j5HihoZZQfst/DyfBBOPnP1AYu9igG138Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855232; c=relaxed/simple;
	bh=p6llJNcco+QQzDlSdkCPl9WCczGavtuZ54iqKmXa2pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdKPS3hPLWObTJuiYqYpye9vO0RHongGGMH3HjcjLpG+p6OQK/65riGbeh7W5GKMGOYmjnC2iGEMwWZN8tQOneWDozgq2ZpZEaMdaGjfCTgp4UzmAOdJ3+XETgRbl1mkRnb/BsmpRdw1EXhfQfboZ15TIoHREvAB7zymQqxoLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CfGeK1vN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C50D1BF20A;
	Wed,  2 Oct 2024 07:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727855228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgA6bA/HaDE/HBHnC7DziQxXs6HPMwsrlTWdthcXPi0=;
	b=CfGeK1vN5V6kKUY4ZvrW/+Gws/rXr2vvQ2H8jidvCu/wEHPhn6PYgwNt00uUcdB+eiI5Pj
	W9Itytmutg5AGybhRkZJGUurjgUZYnb4hKHxC0sViLWlsjhVR0LfxF0wB60imWl6VdQ6cS
	+a5HiZkT8jZtBUtFYgUgydqHGQ7lsHEab7GyOWCpKDhGfcZM4YGVEJqfFBeg3WmMYVuZQH
	kkHZbBluP6ZajJbP+Q1+9+S1IcHzUNgT0iZkSQm3Ou17CXER1/KLJKOFRMCMRQE+98VFs/
	BibntUU5l3sT5itOkFBcMqahyOYmSnSSgWVK7Rj1nTComSn3XP69nkn2tBsjcw==
Date: Wed, 2 Oct 2024 09:47:06 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 6/6] net: gianfar: use devm for of_iomap
Message-ID: <20241002094706.4a0831e6@fedora.home>
In-Reply-To: <20241001212204.308758-7-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
	<20241001212204.308758-7-rosenp@gmail.com>
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

Hi,

On Tue,  1 Oct 2024 14:22:04 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Avoids having to manually unmap.
> 
> Removes all gotos in probe.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

That's a short and not very helpful commit log...

Besides that,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

