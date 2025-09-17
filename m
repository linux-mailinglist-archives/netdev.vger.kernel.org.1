Return-Path: <netdev+bounces-224039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44382B7FA18
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A06622450
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201632E739;
	Wed, 17 Sep 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fmGapKok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45932BBF5
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117250; cv=none; b=s2shCEvjsP8V+BgFaw1bShpAaJDQ/c8Can8CRm5gafAvPh7kB2P0sHIXIpctKkYswgLvrXq68UQj+83F8RewrmXSAkCCvCis/E/Z92bSuwiDuzo4zHlswlmdkpCfOo03CnyCGDkUxivVVfnSgTYQspaJoBr3uOe5FWoyb1H/Cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117250; c=relaxed/simple;
	bh=nV1QrshvRehJ/eXBSMMeuT6hGEcacS/VSfv5Aahy3qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZbJDYP7FFPi4phbi1v2penrCu6T+LWJmaFdnU1Vf9/vO33vEduCYaKQvalq5x3FHlWsf5jTvcjyGkdTd/Bk+QJfyPIWSXogAYxpkrACY8BzP3xnQieZ81RCkzp9S7le33I4lxioOiXCEe8w3oZawHWb4upt1frHnz0XSxbrxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fmGapKok; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8112c7d196eso701449485a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758117246; x=1758722046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=to4BXgFyFuRjiSPORVXGshM37diVDi0cjrsHXYAgKmw=;
        b=fmGapKokLz9Fcmrm+nnUjiBmvailZKN+eXBViNgThFZcWW19Vmx7mlOTKESzUXi37B
         bs07Bfpv0vPwxX87e0/CVX7SE+rfHLbUu5LhZfHHxpBsWZxqJzUD7T1FQKiYBcELbr/3
         tycxPy/BbxgZyi/OBh0MXs0wciy4FKRW0kBEXz6oAralAR8S31KhPOUKqNhM2flGyjZM
         mXgAR0E2WSV7g6k3isAoALB1kzYFjlEA3OCIW6LBLdyOdKzDLffiipLxAO6PbpeHufyJ
         vNbUOvar8vSc+A/xmQAycFDBypO9mTF1YRVvfp7sTLCP9qeXVh5hmitRiypaZHStkKYg
         zQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117246; x=1758722046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to4BXgFyFuRjiSPORVXGshM37diVDi0cjrsHXYAgKmw=;
        b=W4jXvcnaubvW4KLWhGh2rYbCI6OhnFipyd6Q+Rq34Njr5V1VFFHQPW3EAacfdTsOn3
         2siooSomL+LXne3qeCiuz9mRVYbwPyeKLen+8IHW4mlWJ1U8TgiobAHQsM3lKVJdZMRN
         hH0CtL0+RRKiX2ujhg7yz37dDrnjTjfq58F/ogeKgKp9IDTvvAYw4Nsiaoo4tuFpG/So
         46oWR3k2sVglZZSd4zBA2u5CPjE0z5y3JLcf1KE8dFWbUhV/Mkdvip31bBJb4ncWMYum
         bUH4FkJTTZk8HjGonJimhR+kaA9D5ytexQsfunmUqiyBbcdBqyaCke39HQw0nBwJzHE0
         iPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM7oB7Iez2nY1InBhg+cRDHCORxbbvd2xgC8e2lj/w/Kv2UrFalngYxTAyfWNwHSSGEH/a7Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+4i3sPvJZFH4rrbSXPT8Oh/WEQ+quUgeVoIgybiw3wXEO/WL
	lf19kIasRbaeIZVYtMaJtjgYQXABP5I9MneDOhFXfQMnHmGQLbEwhOtTxGwvlne84g==
X-Gm-Gg: ASbGncudnogv6R8H6Yc1RnwvG5o+YXU03kahw7VLjwwC68Wj8u3k6AqBahj8EemR/r4
	5ZwCk7sSeS66PbV2+ktLxuDKxVCYBdxseBuIzu2ypJhE3omdJ3plNukvIxYrV1WMyViPZQDTfH4
	UEclCWds+e216tSqUf2dMEBu+mpKGZM6MKuiMZxTWuzu9wCIZRXnxjN302S6MECn4xclZRYnjtr
	nzG5qet20mbWRHNQ+cJn8JhOzdeL/KGs8rHIWtlaieJR6sThdSEO+6EofNCSuv7LQPlET0GVJiU
	tYvx3J2/mLSJVQX8DUjzPj1PKIB1cqXjClXrQi7KjkFM/beudchX1ZLGgtP8SFZRITp4eLGFqpy
	F40Epx9Vk+sPme5J8qIMSe1/8ax4WeQfa8/E+Sj7/HqhIGOXNyOOJN6HK
X-Google-Smtp-Source: AGHT+IGRBja0r5jLJ3qHXTLicrQ5EPV+1Dbg2srLDJPVrFlUWF3hlqL5YtcEGgwOtuhZt3aFjNDHDA==
X-Received: by 2002:a05:620a:4009:b0:817:6fe8:dabd with SMTP id af79cd13be357-8310b59ae28mr257079385a.28.1758117245776;
        Wed, 17 Sep 2025 06:54:05 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-82b15c2202dsm372471385a.55.2025.09.17.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:54:05 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:54:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917095457.2103318-1-o.rempel@pengutronix.de>

On Wed, Sep 17, 2025 at 11:54:57AM +0200, Oleksij Rempel wrote:
> Forbid USB runtime PM (autosuspend) for AX88772* in bind.
> 
> usbnet enables runtime PM by default in probe, so disabling it via the
> usb_driver flag is ineffective. For AX88772B, autosuspend shows no
> measurable power saving in my tests (no link partner, admin up/down).
> The ~0.453 W -> ~0.248 W reduction on 6.1 comes from phylib powering
> the PHY off on admin-down, not from USB autosuspend.
> 
> With autosuspend active, resume paths may require calling phylink/phylib
> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> resume can deadlock (RTNL may already be held), and MDIO can attempt a
> runtime-wake while the USB PM lock is held. Given the lack of benefit
> and poor test coverage (autosuspend is usually disabled by default in
> distros), forbid runtime PM here to avoid these hazards.
> 
> This affects only AX88772* devices (per-interface in bind). System
> sleep/resume is unchanged.

> @@ -919,6 +935,16 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  	if (ret)
>  		goto initphy_err;
>  
> +	/* Disable USB runtime PM (autosuspend) for this interface.
> +	 * Rationale:
> +	 * - No measurable power saving from autosuspend for this device.
> +	 * - phylink/phylib calls require caller-held RTNL and do MDIO I/O,
> +	 *   which is unsafe from USB PM resume paths (possible RTNL already
> +	 *   held, USB PM lock held).
> +	 * System suspend/resume is unaffected.
> +	 */
> +	pm_runtime_forbid(&intf->dev);

Are you aware that the action of pm_runtime_forbid() can be reversed by 
the user (by writing "auto" to the .../power/control sysfs file)?

To prevent the user from re-enabling runtime PM, you should call 
pm_runtime_get_noresume() (and then of course pm_runtime_put() or 
equivalent while unbinding).

Alan Stern

