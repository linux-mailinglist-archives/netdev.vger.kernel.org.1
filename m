Return-Path: <netdev+bounces-307445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JAs7JS8mVmpQ0AAAu9opvQ
	(envelope-from <netdev+bounces-307445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:06:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B8B75442B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:06:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=xloPNrV3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307445-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307445-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1481B3047AC4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08738D6BD;
	Tue, 14 Jul 2026 12:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14359371868
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:02:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030554; cv=none; b=QDYW9HQJxZfRgrReUxAvTVIWKSyWB9HbtYR6gcZ16tTijZKJLLiGri87e5swhh82BJ8bFCRCNqpfZU3ffoFLerSO6lxs116cp+Ph73AZia8Kwwg+ELWEyAenvCYRqNYVr1sB2qzLcBdRh5UavGD0eSGM0b1zfxCkYV5vMkXGJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030554; c=relaxed/simple;
	bh=MxGbzJ1EXIdULAavSutQBPVkV2UhDVudqdZG1CWBmp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCNGZkyEDtyLHoxVVxE0tbTxcaye4Qx1M3h7Oc7MFksh4+QgMjfcnq0w8D41Bwi463D669kqmXD3C+TVazQMCcd/MAOcCClVy+xChg+8q/dPt4pUPJ12rNOESwkCTpHdbFDANUbPh93iblOg0AyTyJqnXOaMKNf+18n+mBw00Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xloPNrV3; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-471eeac43bfso4151101f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784030549; x=1784635349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MxGbzJ1EXIdULAavSutQBPVkV2UhDVudqdZG1CWBmp8=;
        b=xloPNrV3q0dsouuiGc5bUzJJ6bnxilhSIXwGOplClvayzzm6Ah2r3bsykgU0U2Os+e
         wOWh+yiGW8fcuU5rky5Evy6iXTIQKcCkSFXY8KZImeB1J8C08m2oKYln9lIIznjY1Zct
         DJX0fzJ6KIV/CB93zTxcQbxy5cryxF3hXYiE/Li2nG8xF4M4cWevWZ1KIRG6WJpccxlI
         wfj9ddFB7N8Z4YP/NXHbxO3jvLO2x3sFRT5C/kD7Gl/jWquGXSRwOWmBIekE8R82irLb
         mvwtasVMxsK6/qlM5kwsHk9QiM+vbfmJsl5eDdtTO9E2m77O18rBN/wyfvOu+wigyu/q
         3tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030549; x=1784635349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MxGbzJ1EXIdULAavSutQBPVkV2UhDVudqdZG1CWBmp8=;
        b=duWq0xZb/OsGsBnJHOkPh+COYO/XQnd9oBscqFxA1Q+ZgQDafo4E9nuYhR3+owrmUC
         Cl1I+T+KZcRli1+KmhbvUc0SG6BWbc/mqDz85qDC8aqCee6BdZG3hDBXvOXZBXIDVvwh
         vFUjknckuMVtnDhlwgmEAoddZHJB5wiGSoUPxoHzQAWf8r+TuBjLJoRcJpcCEnukNIhp
         D30vOSkhQ7nxtBqQTm+D6JLwRpIVoOdNvshSUTnCsTBcP7oEgtvD0A6XfVy2ZF/gy0im
         rh/7mzurxu9eAS2TrnyL2mz9cc7pAMZ7Lbj2Rri4wylbkEiM25ToABofFKHbHdG2Niln
         vtDg==
X-Forwarded-Encrypted: i=1; AHgh+RqN1e0enqlD6/P9UOgRSRtxIBc6QyNA4OYfE9XJXVwfT8U9TSuOgOlLlyNYNsY3ASX8zoP783M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGCRStwDNGnPNJRsOR90WX/3j8X2G7CK30TDFYnZWrUKEBv4N
	vVyyzTI0XDG0F0hGFs+nqom+i47mJJoSMVq3NcY2e4Pw+vkvILSQKJjUCiF2FZ8DffI=
X-Gm-Gg: AfdE7cmOO3bvYIV3KqzpWdVQwUm/RKrBP5G+RK/hMuZfnFhTBaPQJNi37Uw93VYl1Y8
	M1V54qvEMpQhpGcAXo3C42bJ+cl9sh4z8bBnY834nOtvR5YDKYybworhpw5Migb/NjnoWGvAh9/
	asy0kDbKYAiFnCoOnjKteBBZSqtvAJ3FTvv9vpJIhj1XnLaGOWdafo4iISpimzk7Edoy14cRqnY
	EEBaV+A0VWFHQ2vCYdIHDsdrNDgjIYwMuYRtJxbRUw3Lq8RlZKQv2pddu/HYRdm4q2wSGPjbz0Y
	SG2z5t3uEBxC9IDGLwGCfNqk7IvAlBokFYj/Yts7wqqsZAY0dnZKhLqutt3zul3YniCTRlgKolg
	+XMUas17M2XCa+SAf1oOsce2R32RXIY0j75/4T/RuXTtpuIFJdYY7oJVvzh3tTycNrK+E2SNYsr
	O54xxr4YGm5bw+G/4/UaD4Zg==
X-Received: by 2002:a05:600c:6b17:b0:492:4a56:690b with SMTP id 5b1f17b1804b1-493f8834e5emr94066915e9.35.1784030548728;
        Tue, 14 Jul 2026 05:02:28 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm7854172f8f.13.2026.07.14.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:02:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:02:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V6 4/4] devlink: Apply eswitch mode boot defaults
Message-ID: <alYkm08MpcIXnFl9@FV6GYCPJ69>
References: <20260714061731.531849-1-mbloch@nvidia.com>
 <20260714061731.531849-5-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714061731.531849-5-mbloch@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-307445-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,FV6GYCPJ69:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B8B75442B

Tue, Jul 14, 2026 at 08:17:30AM +0200, mbloch@nvidia.com wrote:
>Apply parsed devlink_eswitch_mode= defaults after devlink registration
>and after successful reload.
>
>Mark the default mode as pending when a devlink instance is allocated.
>Before devl_unlock() releases the instance lock, apply a pending default
>when the instance is registered.
>
>Clear the pending state before calling into the driver so the boot
>default remains a one-shot operation even if the mode change fails.
>
>For successful reloads that performed DRIVER_REINIT, devlink_reload()
>already holds the devlink instance lock and the driver has completed
>reload_up(). Clear the pending state and apply the default directly from
>the reload path.
>
>Treat an explicit user eswitch mode request as consuming the pending
>default mode.
>

Looks fine to me now. One nit below:


[..]

>+void devlink_default_esw_mode_instance_init(struct devlink *devlink)


Forgotten "instance" here. With this fixed, feel free to add my
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

[..]

