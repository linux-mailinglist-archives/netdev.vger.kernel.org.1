Return-Path: <netdev+bounces-238264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E434CC56B2E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49243A2548
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49129B22F;
	Thu, 13 Nov 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f4SNebBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B380191F98
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027270; cv=none; b=fysreSHMGVVXE0As2dwStpEwCwp9nNU3L21OUacVEWXo08TcO95LHF23tvomB5a05DwsqJJDSpkpTfxBuXZis3QhLbw+dM9GDNXWWGDravQFX2p2qhlNzVFsqPnPMz8Oj68CKqhwEVyC62qDFGuWmpCfe8VoRDr9Wknxf8XFKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027270; c=relaxed/simple;
	bh=DbxUkh3Vw5wasaX5jeRtdwoAiV4AgSJ5dOhSSPJPkJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+KWds5NYXb32Tkk4SlNOtorePfcavQVZ+FU1cmUXr9lTKcrCdiLAecYqy/TjE/4JAdXj0kGEB3sEukHnLOzrhVY+81V492VCtPneQjmC9bwbjbTWgIONA1XSyVtNCLjOhh9KgQ9MGmEae8u05WZa8wf7h3StoCqPWUqvAK6AK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f4SNebBo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F3E6FC0F57D;
	Thu, 13 Nov 2025 09:47:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA4D36068C;
	Thu, 13 Nov 2025 09:47:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CE14102F21A5;
	Thu, 13 Nov 2025 10:47:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763027265; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DbxUkh3Vw5wasaX5jeRtdwoAiV4AgSJ5dOhSSPJPkJM=;
	b=f4SNebBoOgauOpP46KjpfsniZkGj5SnOGUDXZhsVerZUsMy98Fdh3JLs0yxG9nq/iQHdFZ
	7okR71KPJY6c8Fua1SNWbowBRoQ+CL7vEr52wX581VLBPvCRSoN4V1Gv+qfWYZGxDHlCe7
	UlYupaocX4qMXWxZyaYDuEj3TJb/w6TCfqSSAj0AVNxkDg7wzI4sOw9wRN6VgkcE+Li8kh
	wXGJpJWG25Uyg7Wtf5GE+n24Q3PyJcTXJQ3Bu4wn9T1mHLAsQkPisrhdIsMdiju8aYI9Xo
	gRUiiD7eypvhnaWUdSroPWwmxvhccwN5UgdTCfD6YmMXFnxYbnUAs0fTIOc0bg==
Date: Thu, 13 Nov 2025 10:47:43 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v4] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251113104743.751fcb32@kmaincent-XPS-13-7390>
In-Reply-To: <20251112172600.2162003-1-vadim.fedorenko@linux.dev>
References: <20251112172600.2162003-1-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 12 Nov 2025 17:26:00 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The kernel supports configuring HW time stamping modes via netlink
> messages, but previous implementation added support for HW time stamping
> source configuration. Add support to configure TX/RX time stamping.
> We keep TX type and RX filter configuration as a bit value, but if we
> will need multibit value to be set in the future, there is an option to
> use "rx-filters" keyword which will be mutually exclusive with current
> "rx-filter" keyword. The same applies to "tx-type".

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

