Return-Path: <netdev+bounces-267082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAo0MOXIsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:08:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E2227317A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35FCB3004CBE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EA635B63D;
	Thu, 12 Mar 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV+aEVV1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kpO61QpC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CD35970F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324484; cv=none; b=frmi6rT5nCX31C9Blqwns9pjvp2P8IGX6qjr+O5aJdk34e8AlQ/Xd/ozjn+0I3KdA1l+UCYrdHSqOMD98iLUlgwECRglVZy1GQL0gfPUebwHexZr5G9/FR9X7ltPfKlGSgbrcJql+4Kdrgp/DrLmytON7XD/i8h+KJ0XdPu9EWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324484; c=relaxed/simple;
	bh=tijxHpkB1XZlqGPvL+/rIuQOBbP8vGNP9OSJjet1gtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vCtBXlyrs+y6HY49MyH3k8Z8nBoePR7cFcwDHc3nbW5V0wiN/Jffg2Y90RnloyUZSTLmOZdsrfHfUWu77+yHHzm2Wm5FQEoK6K992bBlddc+fSzMYqtQM2DdgESF2RgdYiJxjkv90zRR/wLfg7VXtUHCrcyGC8rB+mqXvKCawXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UV+aEVV1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kpO61QpC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773324481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Khzpn5Mx56KvyAQlDdussK+xDM01SpYAZGq0vABXvB8=;
	b=UV+aEVV1ijLsmIFn2retVye4Qfdb3q2vyyDp3ce/bXVh+bttmodqUrTtquWi6ZVvrkbe7L
	jKeE8LUrdZWmK0li5kFKnJ4aVqC5P1diLlwzRG20D/7Ge2g99x0evwFf84qRnocC8cuTGf
	/GjXgb5LwduVdCaVD8qJAKRlFKw1SjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ljRxlVyvNsuxZkHHLtvk6A-1; Thu, 12 Mar 2026 10:07:55 -0400
X-MC-Unique: ljRxlVyvNsuxZkHHLtvk6A-1
X-Mimecast-MFC-AGG-ID: ljRxlVyvNsuxZkHHLtvk6A_1773324473
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853f33b7dbso7873365e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773324473; x=1773929273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Khzpn5Mx56KvyAQlDdussK+xDM01SpYAZGq0vABXvB8=;
        b=kpO61QpCYMTMtIbLDVpyhDbv7qRo1OJLcgCnAE+C1SG4kziPaq43QCZVnPnBSAor8B
         PjqDJ4FbaEvrzC57yuYUA35xJbb+m7qhwQKFqjBO+rlGjNLcMw0+01Q8WK4SjZV4U4rY
         Srh7QLlK3IN3e9561/Aezk/UZ39Uf5rTwcPQrAgweOxRtmtluutFXv2529U7c0hEjkWs
         6IKCwWV2vq6zX2HC4S2562jo/bSDM3U7BWaZ/o56lQdrPmgyh7AlqJhs9fbMX7jRvYtT
         b2f9WCUQYQQX6zX/yrFZ3VXvnKKxFCHGlbzPleHHCYnEXN0bRHsevZ22eubdfUd/DI1w
         4iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773324473; x=1773929273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Khzpn5Mx56KvyAQlDdussK+xDM01SpYAZGq0vABXvB8=;
        b=lJfxXIhX56UYM0LWLbPnNRtW4/KuBennSwronk60SbvocqHr+GfLQIplv6QesZHvXL
         7zPRnQERg2CAvl2nEeuN7LUjcjGvRf+GuMOmCBcItkqzXsyayVMLLtlPjQbW6CMtwcWy
         5gY6EMhE8KAUegG/NZE+iAXFNcGvwtOrUyigLVLzT4hNRhyrphsGvisOREvBM2qkvtxN
         zM4cCQWV3SKFheo8T33JYZDdy5lO3MUAW77EitcUbyujamv7AdhGUetO6QWPt6dHq1CA
         xNZUIe3fabz3LayS1jFmEC9fNVoTg7ojQWcmybHMre90zYWczQ9wyLv8PYDeT23Ca38N
         /obg==
X-Forwarded-Encrypted: i=1; AJvYcCWxPk8mlzVDzgiSX/CCJzAtbxNb7j3dUEYyoQb/TBeSRGMj904d2qDDyI5BXeu56qbANoSzaHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iIvS46DPjohMd+cZnoBw2cSILyGLemfb+EDKA9s1lyWrZGJt
	xUx6ViYKm5PyjuZSkI1Zsu3KFb/Y1shCVk/NafC3/gMzsgS9QwmCWt6MI8Hz2WhxahbxtvAaE2i
	K43v3RpY+1mlyiRYeeNUj8BD0lypMkdt4zWG9mCsUBz1eAyvCvBktbvuFIw==
X-Gm-Gg: ATEYQzwIuFSTkbF6voC/gTacUdtPQnzC35x1k6Pq+yfcyqxD93vKZGsgnNvDSk6TgQc
	SbLDPWTdBgUcawn0rV5sS+d886xAXeBB4v9TgLnu3cyB2hE8IGifRsMuXPGrLZosifh8M4ohgmC
	diE9Khn2PJGf43A4mz1ePXwaYnBHdVD1xrZ9/MYcjsCf2UCAKdvBTuzbxLjfSaQGDwz+vWdkPel
	O53EDDfKOseaZJ8eNTElcdW11qadZTrE92wxnyuisyv6AJldDB1lTULUc5ft8J/J5bLbvVqOQpm
	H8Cp4U4eds9JnQI3k9EHpqH55f3Ug7EtRdqiFue5DHkRB/xVwAPhgU6zUi3h3hT8V3VZB9rCuLL
	wu++mIYWP1CbKzYK8yLs97PoUPcp4pChivQwPBfCWt3WkMMlJh9DL+8A=
X-Received: by 2002:a05:600c:8b0a:b0:485:3ae8:2236 with SMTP id 5b1f17b1804b1-4854b123cd6mr107431325e9.32.1773324473127;
        Thu, 12 Mar 2026 07:07:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0a:b0:485:3ae8:2236 with SMTP id 5b1f17b1804b1-4854b123cd6mr107430595e9.32.1773324472680;
        Thu, 12 Mar 2026 07:07:52 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6756e4sm154581925e9.15.2026.03.12.07.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 07:07:52 -0700 (PDT)
Message-ID: <09528d3a-e08a-4942-aff7-b59610f6b13e@redhat.com>
Date: Thu, 12 Mar 2026 15:07:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend net-next 1/1] net: stmmac: actually error requests
 to change the auxiliary snapshot capture channel
To: david.laight.linux@gmail.com, Johannes Zink <j.zink@pengutronix.de>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Bartosz Golaszewski <brgl@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>
References: <20260310140155.3359-1-david.laight.linux@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310140155.3359-1-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267082-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de,foss.st.com,bootlin.com,lunn.ch,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6E2227317A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 3:01 PM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Commit 2ddd05d1d5ed ("net: stmmac: do not silently change auxiliary snapshot capture channel")
> added code that attempted to return -EBUSY to a PTP_CLK_REQ_EXTTS
> request whan a snapshot was already enabled.
> However it tested bits in 'acr_value' after they had been masked off
> so the check would never return an error.
> 
> Change the code so that the test actually works.
> Note that when the commit message says:
>     Previously in case of a PTP_CLK_REQ_EXTTS request, previously active
>     auxiliary snapshot capture channels were silently dropped and the new
>     channel was activated.
> this only refers to two commits earlier (a few minutes earlier).
> Prior to that only a single fixed snapshot channel could be enabled.
> 
> Note that the check will reject requests to re-enable the currently
> enabled channel.
> Plausibly the best fix is just to delete the check completely.

I agree with this last statement. Enforcing the check could potentially
break the user-space.

/P


