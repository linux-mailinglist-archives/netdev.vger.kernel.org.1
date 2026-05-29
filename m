Return-Path: <netdev+bounces-293069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNg4KGhhGWrDvwgAu9opvQ
	(envelope-from <netdev+bounces-293069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F860032A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90E4530170BE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195723BF679;
	Fri, 29 May 2026 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Uw8+YmgH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C8238150
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048230; cv=none; b=m0DXBHzGVFRvSiQxdCL+N3LkQ/pPxDY7KTQsiDKKTGS4jL68uyfp72jC9ff4v50CNdudR9SjqtIc7OVLCL4BFDMJI9BUAllvaVujldj1h6Aj76iGcbY2aNGf3YZm0dlL+fd0UBV8f/QdNA8dAV/UThhEkg2jdCjIykjxxwOMUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048230; c=relaxed/simple;
	bh=noZUE1IsUXwbMFZP5oM/PyOkLNyKjBND2J+rs0wlh3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBnw26DMA5Cn2REd1G24brbHWadN4CRkcJol4FIgGitEcK1XFlRrI/2ViwnQZekFuKBtXpdZlMzgXbFTBZLDRfxg9UTFqAvzFYdKWrRUyTUF1R5Rlkps5+bzu8uLMngntElAKzA3Wbg1huGi/pbr/CuDNmsv9FEzZIiJ/KDKgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Uw8+YmgH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef42dfb26so92918f8f.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780048225; x=1780653025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noZUE1IsUXwbMFZP5oM/PyOkLNyKjBND2J+rs0wlh3o=;
        b=Uw8+YmgH0VYSod7/gUgbBpnNZhzmW3Y+wSosHBWnPyjXK2zzJ3kCrYrkk/GrZnCX5g
         GhzYHAn54BL4awyJFYIzc2jc2SaoCAw2utl+SLIi3kscJtPtkZLvmoMRrDeGU/BDAlzJ
         smmWUHezOcC+s0HkVe0DzS754kYY7qKKaZ6UdAnmTiuJFLvAZ3ha6Lt+4btm5eIU6zcq
         FvS4qZAP9oFQuLFWYReUKNRhomuQ52eQxnp11jA9S8YNjGvzwRKkelwZKhvvd6dZpvA4
         U+Z/IHEk8Muwa0t6nayR2Vh4M53L/MK3fybY6f4H/ZI7OQgrkwDF8KFiMlQJS8V77s+c
         A2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048225; x=1780653025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noZUE1IsUXwbMFZP5oM/PyOkLNyKjBND2J+rs0wlh3o=;
        b=ja3NIHqkEFkWIiCcHXHm5X1iFTrIOFql2HBYe700YJPyAlxO4qbP+mFtkFZYQBaQIK
         QjzTqafMLl8gX0dFjXDfa3ziCSfRtK9CRxeejxo7bq3dGNByi+v1z7qYgnN8ewQB+e5A
         zXRVm8kuRt5NnUwCLK5QK3qHkFkNtY3qM+sqUa9aO1kpM6oTxZjk/jPDCx4H23Covauy
         oxH5fCzzNWDM8Xr/1jg5/NpKWOMPNen57fRADJ8OMCTpi5F9ru10P+VOsLkEYO1uGrm6
         yancIjCsbS5UnC1ZWzD4Ie90jTyKEAJJI79lvmAlEcBjPBJ4UMFJH6eIDFz2n1LtEn/g
         OSAw==
X-Forwarded-Encrypted: i=1; AFNElJ9FT9JxcORrM+snag54MCkXXp00G/DTkZDCIK6x8mvJRSNPE/4qBLcEg3vCYEDFuPzfzcSsjeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIIoX3OXD83/PNgGhsIZSJaYvPRT5ZuYiIc82k5lTE5HwQp4j
	DCtql4bhgUrVX1aIJT1W6HaNczaQmYxOAeJ936XYpaXW2wUtl7QkSKQ70LAMjkkMN+E=
X-Gm-Gg: Acq92OGdvqa6x73mfVw4nr0dIUmlUH1Zr/mENHaQwcr7g9HiDdMiZ8ZrBHBEo+W4h1m
	DGxrOjuYuY05R6HlHhNAfKiiEq1GiN+IcyBcM7/OtZu5GTIf6nqE5s4Y4u7GFVBPyR1SiKMFchw
	GtRXm5dfIoU/bTnIGTdt8wxwGnUJPLYofrku/EphOpBTJH6LVwcYhFXoSM8S8XOk8RqDCLLVtU0
	jeg6eQU/vF9epi1O+SYLtpXjWeXsaAHCoJhvKIodG4vTzbKqtHiwsoWk0eFVVTPG8Qs2rYQ6BDF
	NtnN7sD1EPIxqgaXBY1JBJVd8BgBo1z4qKwQSg2xXK06o/P7oXRorQsmAOpa4m6/nAztpKlDo54
	BtPCgfAabJCJ8vF4BpEOYFz2tiiz2119skQZfbBGnLZi07SQNUV2tITOPBERje9XAcM1kkX3cKO
	Jhh3PthVHWb2E+E//UJM9o5rcX85NYJwQax3CZo03new==
X-Received: by 2002:a05:6000:21c6:b0:45e:7418:a3f2 with SMTP id ffacd0b85a97d-45ef14481a4mr2488243f8f.26.1780048225062;
        Fri, 29 May 2026 02:50:25 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb7asm2425833f8f.20.2026.05.29.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:50:24 -0700 (PDT)
Date: Fri, 29 May 2026 11:50:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Jiri Pirko <jiri@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] devlink: Release nested relation on devlink free
Message-ID: <ahlhVnY0CGHV67Eq@FV6GYCPJ69>
References: <20260528191411.3270532-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528191411.3270532-1-mbloch@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293069-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 2F8F860032A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, May 28, 2026 at 09:14:10PM +0200, mbloch@nvidia.com wrote:
>devlink relation state is normally released from devl_unregister(), which
>calls devlink_rel_put(). This misses devlink instances that get a nested
>relation before registration and then fail probe before devl_register() is
>reached.
>
>That flow can happen for SFs. The child devlink gets linked to its
>parent before registration, then a later probe error calls devlink_free()
>directly. Since the instance was never registered, devl_unregister() is not
>called and devlink->rel is leaked.
>
>Release any pending relation from devlink_free() as well. The registered
>path is unchanged because devl_unregister() already clears devlink->rel
>before devlink_free() runs.
>
>Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
>Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

