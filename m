Return-Path: <netdev+bounces-205364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7EEAFE52C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CB23BA76A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0F288CAD;
	Wed,  9 Jul 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oOH+uUcf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A42288CA6
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055534; cv=none; b=uv5GD8tOYZnLrkIwgLhJV2YFepF1zIv1npNGPxCi9qcOpNY5/9mH4MdC1kUmKyZwcs27SjBz+UhELmeH34XzYMBBAX1pEMiNUVZ3zvJiA2Xr91VbuobUUi6y8CkrQd9n0dxRO9fXrc+Nk1ejd+r2bWJ71uVJwBSri+aDtOVWbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055534; c=relaxed/simple;
	bh=sFZ+QicVm3fqRKkbFrQtDvOSQDGAAazW2i7zJFINsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3OrUcgKBmAoOkP2GcCeszoeqlWFQ9EMFBXuHwQ2y5+QY4Xy+KocTgA8On0vp01GKpLRFN4TKAxMgV8vExOT0vHRoZ4pphav0o4viNKfEDo7LmHWyRasX6BFtTv2yh6Oxvpyu/AIt0GdnJ7n83eZpu5cBmripAbzHaxUHXtmOOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oOH+uUcf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453647147c6so50831225e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1752055531; x=1752660331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0x+leR6VZvjdpbbABt7eT4Ar2h6toyeGs2XG4qKz76A=;
        b=oOH+uUcfnhLxUX/1TiA+CXk8zszEO+RvDOZpSh1MK3SLwG4hej9TrIEfhRjP5ACAe/
         JVnOPk6e60AYZ9eNHFDuq8HkNU9jMJaqn7lsMLI7Zs6170KUpGZjUsCt4opf9k2M7y+m
         Qo16wHkDizWZZunTYSA63dNpHLFMyU9bqRSAVG/DBCH0VanzdsgantFrgUojKgA26tmD
         T+OhS73xOIkkmlmO5I43CYeX4zeWh0uuJSxxiH2Y02NyN3PR3bMbntyreKCzbVNeFzWU
         qFtJ2XEYt8JqAoMcRpA9NdF8OSOIVDYVZZouZ2l1cSWEnW9QEfAKApvbJG/eliA8+ZpD
         mhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055531; x=1752660331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x+leR6VZvjdpbbABt7eT4Ar2h6toyeGs2XG4qKz76A=;
        b=E98a+bWuHBXjxyKJ6TD3nqW+I8FJ/lOasJXktokkDJCPu0d551ar41t1As+nJsjJQ+
         UWsKUoy2yY2+qr7Qan7skmR8IBUEGVM3jZje/7bg9lOa21a4T4tF1pvUJQuisqcCpZDx
         RwbFXuf4ABQJOZiiWls890ixBZ/aoK2ZvaIKiT2LmD8hVQfnjRQKxlsHzWryHU6zzzS6
         4f1BaHH9Et6yMjahl+iXt5fCU9H1RUtEYwhVM7RoT087oc0KmS8rhHMMxwgdAVE/hEbS
         f9aEsu2pFApRD0bBoLvW9ZKyGhr5zjCWtz8IJmJce3Bb/7jN5Y8ZtJs+CASM7Lrm410q
         VBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZfnwjfmLhvCnVdb4u86KXp0mP2Wchmffr8G4ClXS2gEdVv2OLwtFS2bTJ5cPSXGm9TI5XsZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGY97ofKfo+fRb3beqowk7DLRU84v2dCbyBevLzuFMf+2bj5VN
	VHwfQPpczD2u1gLKY73u4lq4DF/Do83izZ1kiISgxzYWnYtHOsCQw1uPnmwglgy9Cyk=
X-Gm-Gg: ASbGncsVrfragKycJfSDAWo31e8Rwkemjz5BTljwVRCzQq6gG5NXvQ6KlHiFhdg+3UV
	+twpKefA6+E9anF+hIhu14/CFlF+F+thmao1mq4SlXXbZ8a6lJsAX2a7C4ocpalnpnb97j5FU0K
	zLkcHQnT60ASv4hMf338Wy42cW/7+5KwD34P3gbiipFvMyRIGJwkgEAu3lbp70snlnpqYN1TTSW
	IF1rXarP/dfrceiVhXYFfBeX+C494ebHv3G8ykrNLtZ1wuFnS2vNo/xpL1N5QHDI1uZYdrtz/I4
	rtOlRcHIs44TP9daUXwgfbJpVdxBGUlbkKTQ41y/9EI0gwK/rSwPPvrHfn1GhnA=
X-Google-Smtp-Source: AGHT+IHpIFajgMol8nI7yV85sDxF3J5lIWIyrknMcsC4HlnClZXLtkHdvmnIZr6BNblri25TvejkxA==
X-Received: by 2002:a05:600c:3e14:b0:442:f98e:f37 with SMTP id 5b1f17b1804b1-454d53a0161mr13652105e9.21.1752055530479;
        Wed, 09 Jul 2025 03:05:30 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d4fc333dsm18171305e9.0.2025.07.09.03.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:05:30 -0700 (PDT)
Date: Wed, 9 Jul 2025 12:05:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>, Joe Damato <jdamato@fastly.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devlink: move DEVLINK_ATTR_MAX-sized array off stack
Message-ID: <dugteasq4zxwqww4hepsomjga4rxpyk76p5eudk7yrs74ub4vl@cusxvnvgmmtz>
References: <20250708160652.1810573-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160652.1810573-1-arnd@kernel.org>

Tue, Jul 08, 2025 at 06:06:43PM +0200, arnd@kernel.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>There are many possible devlink attributes, so having an array of them
>on the stack can cause a warning for excessive stack usage:
>
>net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_parse':
>net/devlink/rate.c:382:1: error: the frame size of 1648 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>
>Change this to dynamic allocation instead.
>
>Fixes: 566e8f108fc7 ("devlink: Extend devlink rate API with traffic classes bandwidth management")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
>I see that only two of the many array entries are actually used in this
>function: DEVLINK_ATTR_RATE_TC_INDEX and DEVLINK_ATTR_RATE_TC_BW. If there
>is an interface to extract just a single entry, using that would be
>a little easier than the kcalloc().
>---
> net/devlink/rate.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/net/devlink/rate.c b/net/devlink/rate.c
>index d39300a9b3d4..e4083649748f 100644
>--- a/net/devlink/rate.c
>+++ b/net/devlink/rate.c
>@@ -346,19 +346,23 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
> 				       unsigned long *bitmap,
> 				       struct netlink_ext_ack *extack)
> {
>-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
>+	struct nlattr **tb;
> 	u8 tc_index;
> 	int err;
> 
>+	tb = kcalloc(DEVLINK_ATTR_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
>+	if (!tb)
>+		return -ENOMEM;
> 	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
> 			       devlink_dl_rate_tc_bws_nl_policy, extack);
> 	if (err)
>-		return err;
>+		goto out;
> 
>+	err = -EINVAL;
> 	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
> 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
> 				     DEVLINK_ATTR_RATE_TC_INDEX);
>-		return -EINVAL;
>+		goto out;
> 	}
> 
> 	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
>@@ -366,19 +370,21 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
> 	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
> 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
> 				     DEVLINK_ATTR_RATE_TC_BW);
>-		return -EINVAL;
>+		goto out;
> 	}
> 
> 	if (test_and_set_bit(tc_index, bitmap)) {
> 		NL_SET_ERR_MSG_FMT(extack,
> 				   "Duplicate traffic class index specified (%u)",
> 				   tc_index);
>-		return -EINVAL;
>+		goto out;
> 	}
> 
> 	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
> 
>-	return 0;
>+out:
>+	kfree(tb);
>+	return err;

Isn't it about the time to start to leverage or cleanup infrastructure
for things like this? /me covers against all the eggs flying in
I mean, there are subsystems where it's perfectly fine to use it.
Can we start with frees like this one and avoid the silly gotos?

