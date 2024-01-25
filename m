Return-Path: <netdev+bounces-65720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092D83B717
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831F7B243A7
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739667C71;
	Thu, 25 Jan 2024 02:23:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302CD6AB9
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149416; cv=none; b=Kwubz4e2nP0Jl4+c9E8YUEXAJLtWTnhFsp6f42RG1an2GfWDDQpgGY81I/d3dCJckv4JwEqqcGOY01lkZRralv5710rWc15EZ3eadNa8Lhw5JkknhVoS70ptMI6Hb8rnMPXenjoVcrxEo1KfDXy6OOHowNgD0T6GeQV180wWFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149416; c=relaxed/simple;
	bh=muC2QoNmYe8mgtlBX3avcezW/0lWec2uIAI2S3/KjBs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EjOwV/n5zTTglmBs0TH+KJhoPpxrtD+B7AqfY4WQ5+m5ShoQ08QtfBP8uN8d3m/xRM9prOZxqO15GcO8heDyPqlnpVOnZjBKpuHMErX0NBFZzcLZrU0iedPw1DBFY70w6pYvPzCZfJU4KtUnaj0QSaXs+nNhYgegc3+6qNXNxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas49t1706149300t799t63583
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.185.81])
X-QQ-SSF:00400000000000F0FTF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2004138297236614635
To: "'Simon Horman'" <horms@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20240124024525.26652-1-jiawenwu@trustnetic.com> <20240124024525.26652-3-jiawenwu@trustnetic.com> <20240124103438.GX254773@kernel.org>
In-Reply-To: <20240124103438.GX254773@kernel.org>
Subject: RE: [PATCH net-next v3 2/2] net: txgbe: use irq_domain for interrupt controller
Date: Thu, 25 Jan 2024 10:21:40 +0800
Message-ID: <02e301da4f35$3ae8d790$b0ba86b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHT0IcsVC1jEd0mWkvM15E6KW/F6gH1k6lZAbGk9e+w2Y76kA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Wednesday, January 24, 2024 6:35 PM, Simon Horman wrote:
> On Wed, Jan 24, 2024 at 10:45:25AM +0800, Jiawen Wu wrote:
>=20
> ...
>=20
> > +static int txgbe_misc_irq_domain_map(struct irq_domain *d,
> > +				     unsigned int irq,
> > +				     irq_hw_number_t hwirq)
> > +{
> > +	struct txgbe *txgbe =3D d->host_data;
> > +
> > +	irq_set_chip_data(irq, txgbe);
> > +	irq_set_chip(irq, &txgbe->misc.chip);
> > +	irq_set_nested_thread(irq, TRUE);
>=20
> Hi Jiawen Wu,
>=20
> 'TRUE' seems undefined, causing a build failure.
> Should this be 'true' instead?

Oops. I built it with 'true' but sent the patch with 'TRUE'. =E2=98=B9

>=20
> > +	irq_set_noprobe(irq);
> > +
> > +	return 0;
> > +}
>=20
> --
> pw-bot: changes-requested
>=20


