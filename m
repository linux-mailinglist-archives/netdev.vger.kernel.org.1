Return-Path: <netdev+bounces-294099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGiLBNGhHmquDAAAu9opvQ
	(envelope-from <netdev+bounces-294099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:26:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B729562B797
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4F533005382
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A7385D97;
	Tue,  2 Jun 2026 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W4XA5YLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963B383338
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391875; cv=none; b=oGpSHO8Jt838YK5XyXcQ43KWcki5JrxN3ITwtn+9H4kr13f+couQT8M7sPFh3gi18PHhtXu3fqqzuGRaDrEP+J91IsRXE5jeq2olx48wT4Ee/mUCXNaWNlvs6xicEs+es/FcXuVdxHiM3XksdjcbNAV4lDz53FdPbOUdLEWKxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391875; c=relaxed/simple;
	bh=lkoq18BJdFHaWQIhUQGJgSq0KL5ZtbgMks2pAZGWVl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IO0xlAa4E5gLwwR2x/Hy9FM3XC2eac/mehEfi1lDTHKpNIlIDyqZexF/1zGs7muCRt/0AyQTwycnv+HUWf0i97IHIb6gvTdKCnUdGdoV2Zzlun+ATCfnfcvEx2j4/oNF1GUo/LukCxue4TJFUmhrTUvF3++r23X4340FrF2Xc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W4XA5YLm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68ae265815aso8738229a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1780391872; x=1780996672; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2t84N2IgJ4tv3CtpNoJS+773Ydo4nGG6xDktxtswRtU=;
        b=W4XA5YLmtnufSMmI4lRMqSzGyLbGGS2RUrfckCzR3358QplZvMghEVHRHbQ5UCNqc0
         hKPN5IFcAo1xUJ/4mFGc9/orB232bKu93R4wPMB8/oArJlMC40cU8rE8BE01ZCZMsq5D
         3iJcrVCxhnXsF5efvcSIJuykmHtQ4TlEhPkPHg6jVIl/rtvgp3nJDmYYN9FVkXe6T4ug
         ljiUofG6m/c799HLEAPWpCYaAWpckE7Ce7EWNeWdgYEgdqJt1Zv+i+tD0PmkEOSY5QV5
         w0IE/8Wq0XP92Oomi3aLVP0jlOqHowaUF7Yc4wPh3MPQBpfTIOJxu5+QZzJcMWeyCj+M
         duxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780391872; x=1780996672;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2t84N2IgJ4tv3CtpNoJS+773Ydo4nGG6xDktxtswRtU=;
        b=XfINCWuLOb2TosXTZ0wN4lQ+3NIBc2GzNYl6dkA58561YbGj5bJjZNwTz0gYtFZ0Rz
         4q6/2xdf3kFqZawnaQoVaXBNF//mMRw2MwT4xqpNCSbmbnG4jF36jdiEZNNVzVaS5Tab
         tsi/p7xrI4vnsr+Ul9HWY8ld3zLFDmh68myYpSEhRxhpH44cTC22d55vaMtycAVBGGjL
         kXL6HxQNZ8fGDW3lUuWvGEBlFt0z2q5tGuxFwjApPdQf2rpL2OPfI5fmBqLeskTLNR3k
         G2DGO0iMJ6X1/R/y8OFhUu3HFvg54j0lOS91tUEQDjRctqGaVcyxkT/plbBiqxrJ0LtE
         CgCA==
X-Forwarded-Encrypted: i=1; AFNElJ+yjn9N2N1Hf6KtDU36Vh84uG+upu9qc1uBqU7U102f3s5h1Om4jZ1Oox11NSiTTVYkb0uoy3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9koxLK0O3Rqz/n5s+0TmOSf8VE5lmbZqkV3Q69QSPH94VFlAP
	0ZKkjathLdlvgE75Vw0eAQHhschuPOq2l8cMZZ3jKgD/DKbjR/Rhsd6RGEYA38/xyjA=
X-Gm-Gg: Acq92OEmSQBvPiR53Pgtit1vkURIUboQ8st9xG9OF18eVyTkPRCpxRK3UY24dEAicky
	fYGJ3NCuvw6f0hA7EN46NrBeb3MKtZPI69Ci6kCSflaedy0/rRY2jZmvq6S3EoaO6c6o3pmq1rT
	LjlviG3STrJSjyNsYrHwCxzsb2o/+1p1dTo7NgAL+0a+0LoKHULuQzfSYW9z8y4CWu1U5KSvVV1
	tBpLed5vHVd0VWfjZf/3DPiCRPC5ae0KJWKe21/ADILFf0iZ2rMjLAlF0S3xkImGf8aeEnPnxZq
	OL+CHCCYbeZci9SsrKry4SBD1/16GYTw/gZJXwyGXnLkMSXZ6YeDz9+GYIa4mQCSAZwOe9UEVAW
	5Ux+JnbMi9l2thA8DRv139DqXDdq9XVELJAqeQ/dh3qfqCtZanXCh2m88EPvkoDQB2NLv9mdr3n
	V8FryGZ+iD+FM/s6+/phKennxONloy3rPinVXr
X-Received: by 2002:a50:c946:0:b0:68c:7f5e:5261 with SMTP id 4fb4d7f45d1cf-68c8a3732d0mr6294414a12.5.1780391871878;
        Tue, 02 Jun 2026 02:17:51 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb7916e9sm3152537a12.6.2026.06.02.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:17:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  michael.chan@broadcom.com,  joshwash@google.com,  tariqt@nvidia.com,
  haiyangz@microsoft.com,  linux@armlinux.org.uk,
  maxime.chevallier@bootlin.com,  willemb@google.com,
  ernis@linux.microsoft.com,  sdf.kernel@gmail.com,
  kory.maincent@bootlin.com,  danieller@nvidia.com,  idosch@nvidia.com
Subject: Re: [PATCH net-next 02/14] net: ethtool: make sure
 __ethtool_get_link_ksettings() is ops-locked
In-Reply-To: <20260528231637.251822-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 28 May 2026 16:16:25 -0700")
References: <20260528231637.251822-1-kuba@kernel.org>
	<20260528231637.251822-3-kuba@kernel.org>
Date: Tue, 02 Jun 2026 11:17:50 +0200
Message-ID: <878q8x5mip.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B729562B797
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294099-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Action: no action

On Thu, May 28, 2026 at 04:16 PM -07, Jakub Kicinski wrote:
> __ethtool_get_link_ksettings() is exported and called from sysfs
> and many drivers. Looks like commit 2bcf4772e45a ("net: ethtool:
> try to protect all callback with netdev instance lock")
> missed adding the lock around it. Not treating this as a fix because
> I don't think any driver cares at this point, but if we want to
> remove the rtnl_lock protection this will become critical.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/ethtool.h |  2 ++
>  net/ethtool/ioctl.c     | 20 +++++++++++++++++---
>  net/ethtool/linkinfo.c  |  4 ++--
>  net/ethtool/linkmodes.c |  4 ++--
>  4 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 1cb0740ba331..0caaeb91b094 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -325,6 +325,8 @@ struct ethtool_link_ksettings {
>  extern int
>  __ethtool_get_link_ksettings(struct net_device *dev,
>  			     struct ethtool_link_ksettings *link_ksettings);
> +int ethtool_get_link_ksettings_locked(struct net_device *dev,
> +				      struct ethtool_link_ksettings *link_ksettings);
>  
>  struct ethtool_keee {
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index bd97f9b9bf18..1d74ee67e77a 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -436,10 +436,10 @@ struct ethtool_link_usettings {
>  };
>  
>  /* Internal kernel helper to query a device ethtool_link_settings. */
> -int __ethtool_get_link_ksettings(struct net_device *dev,
> -				 struct ethtool_link_ksettings *link_ksettings)
> +int ethtool_get_link_ksettings_locked(struct net_device *dev,
> +				      struct ethtool_link_ksettings *link_ksettings)
>  {
> -	ASSERT_RTNL();
> +	netdev_ops_assert_locked(dev);

Not sure why we're using the "compat" assertion here, which falls back
to check if RTNL is held, instead of the newly introduced
netdev_assert_locked_if_ops().

The contract here is that all callers are expected to hold the
netdev lock (if needed), IIUC.

[...]

