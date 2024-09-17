Return-Path: <netdev+bounces-128667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A897ACA5
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 10:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE631F21146
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE815667E;
	Tue, 17 Sep 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bUf9utEG"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B04149C7A;
	Tue, 17 Sep 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560743; cv=none; b=UFoR2wQCiumlxGVvNIX4iIWFylaSoY4fNrTEUu9evzWdt328U21IM49LvFq+3OjF77Dg3fuB0VxGIXA27P2RvABAjphCGA3tSiSFybwVR4G9RDaT4DuVC3MdvTDTpyUE0X0diTrhmT4BwrRcxV3kgEe1359PSYhnGdjWRLdTSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560743; c=relaxed/simple;
	bh=AVSpDINng/M8RPMo0wOBbSAxd97prxusW+zcNsFt9PA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1Ub/nYW8qO9HmZCiiPaUt80gi8UsAjOzX/BAREfQ4wU/bgAklTmv7ZIJhTKRdy/OkPDRf6I03CO3wzka3XNjj8cbGJBmTVPLVjfgs0ZDD848MNy8tG65sOQ5hZNeL6hIFd8KpFp/S3I7D+LLjFP8APW3W+NEztWD8P+h8OecmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bUf9utEG; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4BA7240005;
	Tue, 17 Sep 2024 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726560738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVHa0U3M4RHRMsj+Dvk7seOfiTZYMT1VvMrVavb55+4=;
	b=bUf9utEGd1l/RY4lvm5vf99OIrPy/njmBMMF0Itdq5tZ6QIi3wl5CFl9KVevbQW4u7qyL9
	+cJaaAKzmjUtjlCEeSDm3ulqCBsun8Prx+2CgHaahHcB1MRFTZszsAz3xHMtpH2sPk0JlF
	CqYjo3OrwyQC7/tXhtk3jxcMHfTBqDjj/1YJdRTUYTbfFfaIUrBOeMF7wL0Y0ZwCoV3z+r
	6FhzXxh5tW2DZqm99loOebg2y/ZlhNZ3llbSR2H3yb0P/6vnp+Kqqk8GdJsDBb4NDmWx4n
	t0iBmlXTHWZownMltKy+Z2x9pGNFfMTp7hcOZeUHeJGnGwf2GujnsX2gYrODqw==
Date: Tue, 17 Sep 2024 10:12:16 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Kyle Swenson <kyle.swenson@est.tech>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool-next 0/3] Add support for new features in C33
 PSE
Message-ID: <20240917101216.408c2f45@kmaincent-XPS-13-7390>
In-Reply-To: <ohcflwsvztqatsaudheougap3sxkdah5lagtyzr6d55u2nzcwq@iaaoyutqdbj7>
References: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
	<ohcflwsvztqatsaudheougap3sxkdah5lagtyzr6d55u2nzcwq@iaaoyutqdbj7>
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

On Mon, 16 Sep 2024 22:11:28 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Thu, Sep 12, 2024 at 11:20:01AM +0200, Kory Maincent wrote:
>  [...] =20
>=20
> The series looks good, except for minor detail: the new parameter
> c33-pse-avail-pw-limit is documented in the manual page but is not shown
> in the "ethtool --help" output.

Oh indeed forgot the help usage text. Thanks for the review!
=20
> As far as I can see, the kernel counterpart is present in 6.11 so that
> this series could technically go into ethtool 6.11 but as it was
> submitted so shortly before the release, I would rather leave it for the
> next cycle. As you submitted it against next branch, I assume you are OK
> with that but I better ask.
>
> For now I applied patch 2/3 which is a simple fix independent of the
> rest. Is it OK to apply the rest (with added help text) after the 6.11
> release?

It's ok for me to apply the rest after the 6.11 release.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

