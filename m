Return-Path: <netdev+bounces-293092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHQ1KZx3GWqwwwgAu9opvQ
	(envelope-from <netdev+bounces-293092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A53601951
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89FA430394D1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34C3BD638;
	Fri, 29 May 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FjOTF4RG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAF3BED37
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053914; cv=none; b=dH/VTsplMdoIvMWImNwgT1dySDyK+X4zwo6G82ieyWbTfYmT4Fo+HeEWwr4ITREKsmbiRwBEXSqQAemP4yqegx81qp14Zw3nwlpnreFfq2PSJizPhXr9ZQA1p2KpdxuNeGA7Xj4E4MBzc1VZsxCYfD2E7v/6j5uW4u3XligTzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053914; c=relaxed/simple;
	bh=+eeiEBiwDZXVf/Yma7+wmUZ8/hJ44CuOx99QZtohDuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEg8/TvQtW4VKEoRxD9DUroXMFXCUIQDSaUbQ7wSqBGDjRrjPYKedX9HCgF1bhoAWkrSGVvbwrc4cfPsgwLcgeSMu4xe6+KTb1NWBIHFXSFuFBQdMEO+10CtGLGNTx8W4uuHQWJOKGP2flL/BS/v6wzMq0KbYldLO/pF154ASAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FjOTF4RG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so13503628a12.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1780053911; x=1780658711; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmDRBBHbIK5C8fg4LKh05CW96seLA97Tj4DFPrfVyQE=;
        b=FjOTF4RGUruGp3myvrkKyUq5cbbTqx+MlYfvgVOwzUfOO+Eh4uImYbXFmUIgK/OJG8
         IGKy+7pqCvhLDt29Hw1kNlE/bWzF6/zE0hdGvZVXzbRr72YFzpS5MieC+dElsad8Nc6F
         OnxpvvU8YrJl/XYkpVsVHuK+n+JmW5JOqQSxNaMChDvCJB6KecO8O1fmVUmohiI1Vq8r
         LjGAWkLqeVTY8X3yYv+vIIP4vjNLsw41cNbg8CVr6Bk30q95rBL9km2V7vUDEDd1wnih
         d14yB7no2oVhClIEO3j1GU0/y3Aye6zCR31PsDqxZevm4hlpRYOmXsFJgITyRcG3Zl/C
         QOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053911; x=1780658711;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmDRBBHbIK5C8fg4LKh05CW96seLA97Tj4DFPrfVyQE=;
        b=F6opBNvFfaKPrQdqCjdCkdBZW40HmjHO+qLDX4Q0IGxeGv07/1YwQmtOghLPmkG59q
         yZz/xDLwKjj6Rwa9t3PaVJGVfhQnJ0ODMEvaHsgc/dOyeShQMCXJq6mHAgbesFSzECC+
         IbLH80XOkE9p/5OtTRk/2tCeimCHEQevYanSKjvo44q8Z2pYOatFmE+46uOmtz/1V9VI
         BibPO8KcYQ9wfx60B8YHW7YFHH3f4V9xob0MZZaUON7evT/NoznjMimPQEqglDnVuEHa
         YHfgB6Bk19AsgfqGoVXHfkWmBgqMBDAO5M+uYoWFPb+9zk9ORjx5E+r3+Cv/vFing69k
         FkQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/y1XfhHQSZ5qOfTSajrbwObR9FT+56vLDN2EJMmjdWVqXNKoaaHtmQhB3S2GthQ2/EXRiF/4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnJKXR+Ty0hFIsZA6lazBYc5bpxkTwtJvza3221671a1T3iF1
	EF3z/IxtCbhMeva8oqtDjDIWOPV4G9A6TVg74BlJQ4PTYxoWJoACtTHOE6iTURx3mv4=
X-Gm-Gg: Acq92OFfZeIek1ppkXu6yKIjI2x3Sd7hIamd6goVZW4n++7hfeffrssi2JjuZ0yguPy
	LWeEnFFRuMloQmEv+v/cN0YdHR1Uofvcm7HPbRbi6qi4Nv7eGDWROBJOaidpuTIUKfnWl0idcub
	wF3gMLFw3GcdsEM9NMkOX2KdmqKESoTHcSFU8jRUIi8mW+se8w6Lez78uSV5iQNyDJ3Qnz4KpwF
	L5EqYhFad/0AlQfbuDY38ZGsK/pFp0Xbcy2oMc90M7tccuiNXq9TLxNwsP5m2RvmaAIirCUneiF
	MzyNBzwbs7upLL46EQARL3dp34AiOboQfTNSC0zJi02WGbD7tbBSszhahmVVa7TW9hHd3sEOVud
	a+rHlW5tsB2qLDCUV/sWjZoa+ykmYzzKA2k/d+c19GOpQ7WC7908UhGA2kywcD+SXhflIkhmYhZ
	Cy/OlqDjsDghYmD097sUoreqB9+hu8a2BMotYq
X-Received: by 2002:a17:907:2670:b0:bc3:7893:3bb1 with SMTP id a640c23a62f3a-be9cfd86f70mr93544066b.41.1780053911240;
        Fri, 29 May 2026 04:25:11 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d63c35easm57312866b.51.2026.05.29.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:25:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  michael.chan@broadcom.com,  joshwash@google.com,  tariqt@nvidia.com,
  haiyangz@microsoft.com,  linux@armlinux.org.uk,
  maxime.chevallier@bootlin.com,  willemb@google.com,
  ernis@linux.microsoft.com,  sdf.kernel@gmail.com,
  kory.maincent@bootlin.com,  danieller@nvidia.com,  idosch@nvidia.com
Subject: Re: [PATCH net-next 01/14] net: ethtool: cmis_cdb: hold instance
 lock for ops locked devices
In-Reply-To: <20260528231637.251822-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 28 May 2026 16:16:24 -0700")
References: <20260528231637.251822-1-kuba@kernel.org>
	<20260528231637.251822-2-kuba@kernel.org>
Date: Fri, 29 May 2026 13:25:09 +0200
Message-ID: <87h5nq5uga.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293092-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 41A53601951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 04:16 PM -07, Jakub Kicinski wrote:
> FW module flashing was written so that the flashing happens
> without holding rtnl_lock. This allows flashing multiple modules
> at once. Current drivers can handle that well, but we should
> let drivers depend on the netdev instance lock. Instance lock
> is per netdev, and so is the module so we won't break parallel
> updates.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/netdev_lock.h    | 6 ++++++
>  net/ethtool/cmis_cdb.c       | 3 +++
>  net/ethtool/cmis_fw_update.c | 8 ++------
>  net/ethtool/module.c         | 2 ++
>  4 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> index 3d3aef80beac..f4c77899fb86 100644
> --- a/include/net/netdev_lock.h
> +++ b/include/net/netdev_lock.h
> @@ -80,6 +80,12 @@ netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
>  		netdev_ops_assert_locked(dev);
>  }
>  
> +static inline void netdev_assert_locked_if_ops(const struct net_device *dev)
> +{
> +	if (netdev_need_ops_lock(dev))
> +		netdev_assert_locked(dev);
> +}
> +

Nit (because in the kernel naming is a competitive sport):

How about we name that netdev_assert_locked_ops() so it's clear that
this checks if netdev_{lock,unlock}_ops() has been called?

I'm guessing the intention behind the name was to make it
distinguishable from the legacy netdev_ops_assert_locked().

My suggestion would be to rename that one to
netdev_assert_locked_ops_compat() following the
netdev_{lock,unlock}_ops_compat() naming scheme. That should avoid
confusion and provide a clear signal which one we're phasing out.

Symmetry is beautiful :-)

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

