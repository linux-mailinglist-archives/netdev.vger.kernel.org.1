Return-Path: <netdev+bounces-204098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB68AF8E46
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC3A1886591
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A992E3360;
	Fri,  4 Jul 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UA9K8fHW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E312874EF
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620653; cv=none; b=eO/iD6fftBLXSuSNg6+lUJC+iqssg8qGbiub9nJauFnPcSZQPZhzNhpy/RMZyBPMhmohc5oWWpmVxX3hB4nzEEkxV1ZUXHCXt4ejloCGNiqdp/wEUmyUedXV99CpYc6Ug8MrGAoDSCcPhRfuFVJUNNcASqmDdicY6hEOsGkXxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620653; c=relaxed/simple;
	bh=nen0FQiNOdfZO4Q56xpz10TT78TaPWD+VpCvGeEfP+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9j8W+uEaGFvlJhPWEbxn5AHuQvQkOR7R8ZRswKbWFt0PIzxSPNxzQEb+JDWlFKV5BMp8w73quBMoIeIm4wReSgMd8XnbSSMTXF0F8LWn3WzX+Gx67Hl6HKx0CA5BRfYmPF2u5/YruRm+AM6AnfKiw6CMwWIs50sAK6974Q8z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UA9K8fHW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453749aef9eso2341395e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751620648; x=1752225448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXvwDn7itTHGGZLWAaah4dYCYgTFq/tKhFwCa5qaWyo=;
        b=UA9K8fHW/T6xt5r4Jv+OjNYodBPJ4e0KrAw4V+XrQlCvpdZG/AEbyr8rvXdQBHwwZ7
         UP3aPuNXQSU6LX4IkLCAmkbdLkRW5Ei4PWLNelGMfCVnRpJA8wGH29HFyVzpEBKsCtBm
         RmKChBIVmNYTNjS2UbBOrp0FsFkvy8j1wzKJZ29YCgf3m1G69/wCSlYJxfLkfBkLnwpZ
         ZoyURvBStFdMAEUITtvqzBig1gXMjJgane3J3u1seV++41zx0HVSLdS3TjgR3m/zM28t
         7LBIvrj4E2YqlejXmf4BTzcRpTRd6B27ZEukG0HNYoz22RLkEvuNI2/P1eXfV8kAEEqx
         Ttsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751620648; x=1752225448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXvwDn7itTHGGZLWAaah4dYCYgTFq/tKhFwCa5qaWyo=;
        b=umVRLYDRllziBEUvMJd5stJ7v0SGzOvCEbOJmFealT03OJBJGuZYSVkF+FStfYbkU0
         yzPyb9R/0hKNmtk3OhDlzzieAyJ/ZYqJ1Unpjd30ZLXgoUfkhJ+vJPeYJADUc18sYMI/
         h+AnN3iMiOzs2JEiQ4w4xg/1PYqC9anPwZfsEtBw0CzaFKAh4H98TCroNPi3BvdeB9Ge
         qivW/vv2HBcSFDueFAK5nx5OVdcJWdsSV97g1jklmMTh5jTwZLgrzxHxD8IdhnGhAsRI
         raMxknCbI/xj8EZlY5NxWpRbK1T5lh3961mMWVaA26vKU/TMqnQBK1mFRzNpu/OouBM2
         azWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+QIbJ6rSoQivhV0pmKDQQGNE2niMdgQz2KHtfunprdR3YT6BcIGCeK8dzBgiPKO4ay9ZWRsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMIQTi5wCtOEgORWuSmqMq5a6p69cJEMJVen/w9GaYG55szbM
	4eG4/dRBuaBfRPnhSrqtkKAb96J6yMFF9N71v5a3QRQujFqToG1XRhdOsBORYaYH7+c=
X-Gm-Gg: ASbGncsmD4kcKm0JVqC/f7HnQfcpU6a8gAjGobmL8DhsP/zWDqY97F1ZWaF0L+zMwrh
	DxRghfNwvTTGsp2gqO2cVsT034Um6htv6Cmd7QRAu6ITd8FYzSZpyiT47a1qL9sTZBmBQddvFVl
	DggdsajBos7J3CDfJekm4smE3eeWp5zJ6ZZZivmiiWrQ18ec75KbgRdv1LD3NU3IKYABdGlYjUQ
	/pVcw8iVB7aKbP6NTrYstvJgksSuwoB5KGDL1iP8rSFKccnp492CF1g4RKQO1WwFuYqpa5hmNtr
	dt0k71GIAq/sWrK3vd0m1nSz/7pTasrHeE8W2/+tbJ5xd2HXLXRVVXMAWnmxh5GayC2Klw==
X-Google-Smtp-Source: AGHT+IFD4sOgB0QaLEA+zQ5wvucnFk0w/y8zzg8ON1aekW0QpH8D16ZTT07LE/HlxqbKBTMJuFlcrQ==
X-Received: by 2002:a5d:588e:0:b0:3a5:8cc2:a4a1 with SMTP id ffacd0b85a97d-3b4964e2afcmr1633764f8f.39.1751620648183;
        Fri, 04 Jul 2025 02:17:28 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030b9desm2014594f8f.19.2025.07.04.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 02:17:27 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:17:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, david.kaplan@amd.com, dhowells@redhat.com, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v1 1/2] devlink: allow driver to freely name
 interfaces
Message-ID: <my4wiyu5dqlalt45e5pz2dfhjm3ytbnshhhjqlcdetp357z7u6@zvnq7wfcunlv>
References: <20250703113022.1451223-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703113022.1451223-1-jedrzej.jagielski@intel.com>

Thu, Jul 03, 2025 at 01:30:21PM +0200, jedrzej.jagielski@intel.com wrote:
>Currently when adding devlink port it is prohibited to let
>a driver name an interface on its own. In some scenarios
>it would not be preferable to provide such limitation.
>
>Remove triggering the warning when ndo_get_phys_port_name() is
>implemented for driver which interface is about to get a devlink
>port on.

What's the reason for this? If you are missing some formatting, you
should add it to devlink.

Please don't to this.

>
>Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>---
> net/devlink/port.c | 17 -----------------
> 1 file changed, 17 deletions(-)
>
>diff --git a/net/devlink/port.c b/net/devlink/port.c
>index 939081a0e615..f885c8e73307 100644
>--- a/net/devlink/port.c
>+++ b/net/devlink/port.c
>@@ -1161,23 +1161,6 @@ static void devlink_port_type_netdev_checks(struct devlink_port *devlink_port,
> {
> 	const struct net_device_ops *ops = netdev->netdev_ops;
> 
>-	/* If driver registers devlink port, it should set devlink port
>-	 * attributes accordingly so the compat functions are called
>-	 * and the original ops are not used.
>-	 */
>-	if (ops->ndo_get_phys_port_name) {
>-		/* Some drivers use the same set of ndos for netdevs
>-		 * that have devlink_port registered and also for
>-		 * those who don't. Make sure that ndo_get_phys_port_name
>-		 * returns -EOPNOTSUPP here in case it is defined.
>-		 * Warn if not.
>-		 */
>-		char name[IFNAMSIZ];
>-		int err;
>-
>-		err = ops->ndo_get_phys_port_name(netdev, name, sizeof(name));
>-		WARN_ON(err != -EOPNOTSUPP);
>-	}
> 	if (ops->ndo_get_port_parent_id) {
> 		/* Some drivers use the same set of ndos for netdevs
> 		 * that have devlink_port registered and also for
>-- 
>2.31.1
>

