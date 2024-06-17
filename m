Return-Path: <netdev+bounces-103975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B722B90AA65
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9791C22F37
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA331953AA;
	Mon, 17 Jun 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fQ2KhoLU"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9A1850B8;
	Mon, 17 Jun 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618047; cv=none; b=LjNFEWcyz6qjwflCOPmDZNp+kfV8J8UP9fO2BfWzRqjc5Z6HD6Witx4CxzlpR31l/hIeDNxkRXOyD0toGqSs/ssn7Ykh0p4K8THru4zAki75j+yKmsL2k5GgPN/NTM5tbOs8YgffSvTCxTPuHYncaRLqtLTTYAM58CnckaWhGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618047; c=relaxed/simple;
	bh=tYuiC6QbT5FXQiZqqCMzyEwoYaYFQ7oLGScrKvg1NF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ig+6RacG/tPDyRt+dayqFoRLPOtWI5G+MEOe2Ggioy47aV2teK2qoLuuQRAQJjvvjHLwveJcKsqgI5sfymM2vTyqZ9m8MB16583dI+uH2W1QZmYZ0NvehVi7hll/JQhz86chJ20Eik0CeqiOxPM+APJnGgkPl0kikWE85bgolf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fQ2KhoLU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 967F920002;
	Mon, 17 Jun 2024 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718618037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fXy/1M/ehynERfZM6LTgbM89cMeabw0uohiD5x86J4=;
	b=fQ2KhoLUUjSz/3jJ6gYT6m+7jv00onEwyGQJUgWeZz5smY3WtO5q1cP052WYoQ84DBtA8D
	gfZrTNomSd5bnSNRLX71AoXlGZNyqUkW6J2/5swMLLc2v+lJErwjDU/exa/mumZie0qtjD
	VULTbGQdd2Coq1kYFun51h6nNyfuFIiFx2ZfAN8pBDF1M89tjdjj7mAIRwe2Vgj58GP8C2
	HfYbpP3mpV2uubQ/q8C7xihHTKe78xZDLOiXXlo8Gi9LhHsx8gEv0xk7adIBK57RN5OseS
	Sb2TdpQcQMGnT/3j0fLn3PQpi0Z/FhbvMAp2BAqUINFAc1nGnc7pOdIpPazjBA==
Date: Mon, 17 Jun 2024 11:53:54 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next v3 6/7] netlink: specs: Expand the PSE netlink
 command with C33 pw-limit attributes
Message-ID: <20240617115354.7e4dc256@kmaincent-XPS-13-7390>
In-Reply-To: <m2bk409etb.fsf@gmail.com>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
	<20240614-feature_poe_power_cap-v3-6-a26784e78311@bootlin.com>
	<m2bk409etb.fsf@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Jun 2024 09:03:12 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> Kory Maincent <kory.maincent@bootlin.com> writes:
>=20
>  [...] =20
>=20
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

Hello Donald,

Thanks for your Reviewed-by. I won't add the tag to the next version of the
patch series because the change asked by Oleskij on patch 5 will change the
specs.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

