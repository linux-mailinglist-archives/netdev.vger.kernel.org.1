Return-Path: <netdev+bounces-294851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6+XO/lfIGpc2AAAu9opvQ
	(envelope-from <netdev+bounces-294851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:10:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BD63A0F5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:10:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V3msmcDA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294851-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294851-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE79E3038D16
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24964534A7;
	Wed,  3 Jun 2026 17:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259744E027
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:07:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506444; cv=none; b=O+lTsCBfOwuUXl9CDEZG9YWf5/nByx1Ps3nyx2leFRcWv10sEoMef3W1lv4Cwa/Lk0Ytcy5LILHeE+mZ/wp10oPQAgM1pSBV97vzo5dvIZMvFAo21UKak3nHDX9//NJjQK560MBtoRmc9US+u9DG/1KTuiUFjwNNRCS6II8WqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506444; c=relaxed/simple;
	bh=LMWL5z0PUBz/1/4zVtrAB3Slt0tJCvRIQSlyKhfG1Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx4BYF9OPn2vYacm5QUjT/j5+DdA2SEyI3o9la6iChDfxkSXJPEtTestnS1qh9YTD9fybHSI5xqw0sbqvCHzWs+U+4pi9JRen0xJTG6dU7y6gxs+ZvI8H35Vzo/8ZGEcV6aWKVr8EuVR++uy4vixYzy4yJ/417hcvrnT4lwv9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3msmcDA; arc=none smtp.client-ip=209.85.210.195
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8423efd76c8so2556385b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506443; x=1781111243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnoNQ6TPVeQqZZfaJltcjq9kwZ8+POJQlduiwlUGeUU=;
        b=V3msmcDAXuY0jk2quY7iEEo4lnBO5cReHTbG6ZvjHEU96mRCZKSWBtTUircFZb3Wsd
         Di/UCpeHUcIUrAgH299i0KGUS38x4xCdGSW8wMYVe8zl5DYN50WaPnQbbAbAHieTIpI3
         v3PSBvGYm3ltm9d/8/EAsrIPr8rr3Rkq8m5Spm0c6Ut4MnwVAXyUawolvpDBwTXarU4W
         jiN02eAUFvFF54jUbUk619C5+GCGpbrQemhvCbHmSqEMLkjyObP6dbwtSn0QjS13QGJN
         P1TQRYWyVTWdGIJFL7OUJrYCpnvjDzF178uJsA5U8S+kbOgN/LcvMO9qq63urXtPUX7J
         F+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506443; x=1781111243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnoNQ6TPVeQqZZfaJltcjq9kwZ8+POJQlduiwlUGeUU=;
        b=Jo6AR9A5AsdficxMa1S8Bwk+qnSRZmCCjhm9kyFPQLqHl+cA3C6mtkyYrWQ7bW3c2g
         6oJd+r2YLSaDEahuJOu1j4eV7dNUs1MIilf+5VJ3QSLJJWgzOf+YfEVj3bSX21A7TX2h
         r1Xu4vLxNAD7Z/KsrH12ZFsVLIfNVSLk9j8qkc8b8CNhM/zuXTMyHlGGrg4iwY29cCqD
         N2YLVuyJ5Ai6FMxooPtYPtptzDnI0JjhzVcIELg4vBnp/FCvgrT1lFHBNQR1g+mC1Eb3
         Oir1/LTBxIdE7ZMwinOR/U1qaeZPY56HnXQk02l8oGMe0gqdx7IsRIrJo4/ouYx4zM6t
         jd5w==
X-Forwarded-Encrypted: i=1; AFNElJ9IB3xjyZCNv+MMppm/hfJThsGZ1wBycUNwZfHvynHFsX4rCLhj990kSmn4bm8A2+PjnCj9x4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlNP59MbtR3KJWGvTeC1p7tPehy07FquwuHYJwTQ6WZOml8WR
	iTz2GfS+R3iFFC/vXYilOkw/HyCmuZOVKbqU7T1ByScUzKKTV9bwnYS5
X-Gm-Gg: Acq92OETVoOzBA541z276okwcasVTI3xd4TG35EdbNqPMz/qnKn4LSiwm0A9BSh25I+
	Q1AvU4NR4vcaylVngGNQccaZvrhxuUS0ANntx+OTjlbFIa0fiwGX2lteufq3tp00RnXzBX5WdFB
	IWhJN+XWTW20UKt3QROUdd6Fu+UJx3CrKx+VKep4TsVRI6/N8OaQ4bIz4t2eNlKy2fyT0jSiAoQ
	j0n6KOuDrh8jxX1tOpqJdDeOH3X8s90V3djOs7JHra1AXIgSlA+IbMFr8Tf5wlOtJ3k9c5YYrV7
	EixXiiyl6QAsGGkIZeAf8WHSnV70fCbTLXSx/hswmVG7aV3C47FWy0KumFUwM2kvgAFPyY375mg
	Ox9FLBtZ+2/3FZyCaF9vtjSEfh8q4Cj9LgwZaASP+GfVGeVtVdNo5fMz/8mHF2W9/GQ95XizgvV
	gxzVLqKiZL6t6KiG8XFO7DtRUHYdJInJl4hs/Q
X-Received: by 2002:a05:6a00:3317:b0:842:5564:2e2a with SMTP id d2e1a72fcca58-84284d5a532mr4552805b3a.6.1780506443037;
        Wed, 03 Jun 2026 10:07:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282378986sm3777135b3a.22.2026.06.03.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:07:22 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:06:54 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jakub@cloudflare.com, 
	maxime.chevallier@bootlin.com, nb@tipi-net.de, lee@kernel.org, linux-leds@vger.kernel.org, 
	pavel@kernel.org, jv@jvosburgh.net, michael.chan@broadcom.com, jhs@mojatatu.com, 
	vinicius.gomes@intel.com, idosch@nvidia.com, razor@blackwall.org, hare@suse.de, 
	jhasan@marvell.com, danieller@nvidia.com
Subject: Re: [PATCH net-next v2 11/11] net: ethtool: make sure
 __ethtool_get_link_ksettings() is ops-locked
Message-ID: <aiBfJ8rbhl_VPiGt@devvm7509.cco0.facebook.com>
References: <20260603012840.2254293-1-kuba@kernel.org>
 <20260603012840.2254293-12-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603012840.2254293-12-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294851-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jakub@cloudflare.com,m:maxime.chevallier@bootlin.com,m:nb@tipi-net.de,m:lee@kernel.org,m:linux-leds@vger.kernel.org,m:pavel@kernel.org,m:jv@jvosburgh.net,m:michael.chan@broadcom.com,m:jhs@mojatatu.com,m:vinicius.gomes@intel.com,m:idosch@nvidia.com,m:razor@blackwall.org,m:hare@suse.de,m:jhasan@marvell.com,m:danieller@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B9BD63A0F5

On 06/02, Jakub Kicinski wrote:
> All drivers which may call *_get_link_ksettings() on ops-locked
> devices from paths already holding the ops lock are ready now.
> Make __ethtool_get_link_ksettings() take the ops lock, and assert
> that it's held in netif_get_link_ksettings().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

