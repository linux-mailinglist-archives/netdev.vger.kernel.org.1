Return-Path: <netdev+bounces-261900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNV8DXm6oWlhwAQAu9opvQ
	(envelope-from <netdev+bounces-261900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:38:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDE41B9F40
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E5531C1A87
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0793242CA;
	Fri, 27 Feb 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naHGGDHp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2232825D
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206282; cv=none; b=GGU4gGp9bTOehza+18NsRZrpVE4UfTnYWM3WsgAcEeN1lrViTcn7sbhUi3X4ys+m6ckxPscuGhakCeRJWm6lpqBKerKBAe0PlqdrRto4TXCrVmdqWS2tH0RCw744ka5QYl5RhaaNHLEcN9hVIjaZDhdfkEso+mJ5Cw3e3L1i6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206282; c=relaxed/simple;
	bh=TNIuemAFwWjgXBX8kMH62ik4iFwTOdB85BxIp9iTq4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6LokujOES4Q8MSfIOGoTUcMn/Xo/XIR+YjLhGB9FGD8mQQn5G6BmZG1AnLjzCPaehWOc5C5jWI9gEoGgDo7KutpDQrynGEjzRQpXmdPT5wjchU5PJ8Ml81lRTwW+83+IyCfoMvJKaK59+xk6Y+ilKgIQs6OhRKvG7sgZ3EIDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naHGGDHp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-437696cc5a5so133340f8f.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206279; x=1772811079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2kGl/nxca3gMElmPgWClDsdWOdb0++gHklmfXh1TOU=;
        b=naHGGDHpOiI+5/JqLdM5XQ0BiJEWf2s9SqwT9KZTEhKU9CfMQnm8azB8L7jFqu9DKx
         IcEJtGVh4rT6EX8PBYmdgd/+89OHU8LQuI3vMGDShJSueSckzTCPboaGMvzjGhKcs2tk
         M0MPIBgbor8+ubWe9M4XC7vsBuv8cPuLfxGyTLgJHrJRU/oCeHqdz5U6DpaJj03jlYRG
         eKCG92ffwWpqBftt4ORQD8NZz65nH/L4g9Y6MmZnk8jHiJAFYPzGbWtzxHOhDQOGoMqM
         lEZDUGsW86yxK+2lwOf108GbruKktt050RGHNgwb96EMzrw4z2rRDt9gS+NlIn0QEWZc
         bfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206279; x=1772811079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2kGl/nxca3gMElmPgWClDsdWOdb0++gHklmfXh1TOU=;
        b=m38FHJfFZZRt1VO/HoNgLxtQx0xJDLdpqpEIaU+bOxp2J6K4FopDHl43zEKZgsdzhp
         a9BIPZ0L5Wb8X9hWIyLYS3txjlP25qtErm6f1I+6PV52LVuUVAdbsMjbpFz/WLuB3cng
         Gi7/z7jwiNWl6mLAUmL61ijgZWneo7soA5fJsP8qqNFEWfC6LpvcYfv7VXDGGaG9pz6C
         N0hjP11r5DNh+NTYMaGVsZTNiQBeJH9CNPHn2WLwpXx7RhjAx5r2ETIVozywbz8s+vRa
         Mcps3RvVfYLFsA6Fr6LY/3YAAPIiDmPLAdpWAP+Aq0u28L7zWm0oxypuZSYJjr4EbRE7
         Je0w==
X-Forwarded-Encrypted: i=1; AJvYcCWFky/FtHlrZneavgm07qkiH6UfcVar4ZdMKMRlqkfycddS2VY7jshuLIqE993gZQlZu0sw2sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysy7j7e5MtOM6OwUlmGAhIxEeqYoqW+P7lNEtMjIJkM2GPwcyU
	S5p8qKg+gFfJy8C/kj2GJFQlptjxZB2UBjvKHwKLv6ltgJXASy+GsHAT
X-Gm-Gg: ATEYQzwdin4qheMPU3FQE6GYFqLMLr0JT4hphTM5NYb+VESVhyabuFGiDnY6Mrsv8Ip
	qikkzsnI4kThUzvBb9F90Q+b6Jt047lq5PfvBEczsiR99Uq+mf9AL01/zUvqQmfqzjkxZE/mEbE
	wPxurcBLM2upyV8YAfjOs0tTFy6Gn08ZIxfar70PI+jydC9K2u9DWuT7+yFBE/DQCIS+WQhIAGN
	RtvmoIaTYWq9o0345ua25n0DgM5g2KyEY7SDQiBd3XqK6YRvs16dEl6D4YsphAM83vxhCCUkapm
	dyj6+xW0EfWC3TxidRTQVIPYZzEgbecJQ4utadtlKzffivUz2FfJ3tFqMHpDetE1m0VnE20vhdt
	v+W+AxawJNXErmQHpGtak74GxyBnM2FF7kErLWaYFAdD5q9f7Em5LeoU18dTvGOtbrlKHagtQj1
	FGQ594T1/orfbYrA==
X-Received: by 2002:a05:600c:5249:b0:477:a478:3f94 with SMTP id 5b1f17b1804b1-483c9c29b66mr31520385e9.5.1772206278424;
        Fri, 27 Feb 2026 07:31:18 -0800 (PST)
Received: from skbuf ([2a02:2f04:d608:3a00:ac95:d4c:390e:fb0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm230573145e9.7.2026.02.27.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:31:17 -0800 (PST)
Date: Fri, 27 Feb 2026 17:31:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RESEND2 net-next 8/8] net: stmmac: qcom-ethqos: remove
 phy_set_mode_ext() after phy_power_on()
Message-ID: <20260227153115.rk7ntq2p4fbjcqdv@skbuf>
References: <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
 <E1vvkUX-0000000AuPo-3mEw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vvkUX-0000000AuPo-3mEw@rmk-PC.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261900-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,nxp.com:email,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 8EDE41B9F40
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:09:57PM +0000, Russell King (Oracle) wrote:
> The call to phy_set_mode_ext() after phy_power_on() was a work-around
> for the qcom-sgmii-eth SerDes driver that only re-enabled its clocks on
> phy_power_on() but did not configure the PHY. Now that the SerDes driver
> fully configures the SerDes at phy_power_on(), there is no need to call
> phy_set_mode_ext() immediately afterwards.
> 
> This also means we no longer need to record the previous operating mode
> of the driver - this is up to the SerDes driver. In any case, the only
> thing that we care about is the SerDes provides the necessary clocks to
> the stmmac core to allow it to reset at this point. The actual mode is
> irrelevant at this point as the correct mode will be configured in
> ethqos_mac_finish_serdes() just before the network device is brought
> online.
> 
> Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

