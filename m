Return-Path: <netdev+bounces-301782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UQONE3NRPGpPmggAu9opvQ
	(envelope-from <netdev+bounces-301782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:51:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99386C19B5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:51:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=EnPuo9t4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301782-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFED53018764
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22761DF751;
	Wed, 24 Jun 2026 21:51:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A419D89E;
	Wed, 24 Jun 2026 21:51:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337902; cv=none; b=AKvnT/619O3Lhw8dvd0d49rAYowKQaI0U8iKej2GAN0ZtFkC+7xHWsE8yCIdHI5CI0vqjPHCTd+dAKrEKh93XV5ouEfOFh5Tg6Kw6NzzdcxqQCvt2wCixxgh7Dzlu/i81w7rOvx9cNy8ASNvE3/Db/5VwLUXVOcu4oO+w7cCC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337902; c=relaxed/simple;
	bh=AFEW21SWiqiIFTvSKJN21okIlXcZyTwSPfAYCnqtbJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIKyH1EsupqGxzMh5kXcDoA0Phcvv9w7a4lOqc/5slSgOamAKrZH2I7fbWzucyd6MP4nvAoKzueq0FFrb1oFWnjMk6tIFgA3ptFWKvXo2907X4nUTJJKAorChuEx3lyjHRq0+vwRpbkTJQlZdblQXisxZCwhPkesjttuvjPro0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EnPuo9t4; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hg2jGaNyqb5D+bewA3yspL2Q0+FIRriJ4/WPaOu7cmo=; b=EnPuo9t45YOpg2houW1O3P+5cj
	Oa5/y5gqDdlsI29/QvicDu+sq1a1kAjWd/pO86SbD48WnDA/8HIVGsl9EXXHfLWFdp9CwJwFG4Qr8
	+6oYo6XOt+LFGM3obSLddZ0sTmhSUXz8DSVMWD9Xb+M4wthF6nCYCRonSZIv7crMb57A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcVVJ-0099FA-T3; Wed, 24 Jun 2026 23:51:29 +0200
Date: Wed, 24 Jun 2026 23:51:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zinc Lim <limzhineng2@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	alexander.duyck@gmail.com, kernel-team@meta.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zinclim@meta.com
Subject: Re: [PATCH net] eth: fbnic: fix race between concurrent hwmon sensor
 reads
Message-ID: <0673af7d-51a6-484c-be38-3f46849ebb30@lunn.ch>
References: <20260624200514.1332788-1-zinclim@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624200514.1332788-1-zinclim@meta.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-301782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:limzhineng2@gmail.com,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:alexander.duyck@gmail.com,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zinclim@meta.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,meta.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A99386C19B5

On Wed, Jun 24, 2026 at 01:05:14PM -0700, Zinc Lim wrote:
> From: Zinc Lim <limzhineng2@gmail.com>
> 
> Reading an hwmon sensor

Since this is a hwmon related patch, it is a good idea to Cc: the
hwmon Maintainer.

I don't know hwmon too well, i've never had to look at locking, but...

static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
{
	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
	int ret;
	long t;

	guard(mutex)(&hwdev->lock);

	ret = hwdev->chip->ops->read(tdata->dev, hwmon_temp, hwmon_temp_input,
				     tdata->index, &t);

Could you explain why this lock in the hwmon core is not sufficient?
It could be i'm reading it wrong, but it looks like the lock is shared
by all hwmon instanced registered by a
hwmon_device_register_with_info() call.

	Andrew

