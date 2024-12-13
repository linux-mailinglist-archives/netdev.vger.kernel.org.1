Return-Path: <netdev+bounces-151846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634B9F1459
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D502188D706
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2071E572A;
	Fri, 13 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nC9VfrgA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EA1E571B
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112234; cv=none; b=STQATIxcR/2EqgFPbCArsvbxffLFlX2HAlv6lzCEYwIYmA16npg3im5Xs3TKobDZvNpsJzZFDhcZxy8g5YUKVBcjIEcya1Wemt+RfaQG4c9nK4oDrxjnT/azJ4WxPJgEr4cvFYKhq9zYhZTOjcXhj0ji58gzh4L1hP1Q58p+JKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112234; c=relaxed/simple;
	bh=Y3Lw72vZuT13nlVwqizEU4xTOq9iG+Ko8FT1M6jDu4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AV2/bGPf+NrbZ87VY6A6w6mlzpGwp/hwzpXnBbbCAaGb07XaECQuy1A1YPToY4i59bME0GE/IbvkimY+lssDuzFNrJShpCMDeXCP6xuiu7KF4HxDObGX7fShmQsJuoyvc6x3kWhcplyAW2w9pEc50b7UVVa0KCqu4nXpO24zu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nC9VfrgA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ecc42d43so1786612b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734112231; x=1734717031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TowrwHHo+Z/Rbfx8dYSOWZVrv2+F8jb+aOKcTufy/9s=;
        b=nC9VfrgAQG5fNQwOWI0kYm08Xf85UI8noMzCM1xDhnuiWEWUNB0kgdRtRzK6YOWS/9
         wrWuDW+ouj2j1Nb6+hGSh8vHlq9L+9qQDhOW5vjo9l4HS5aOPEuIUzXeAiKoOWsgTydp
         pNx5EK9mKlHqu2NKseCpH4N1wVgXgHpZJINEwtWonotZbPyK+WvwoQMyx2w+V71dHbOb
         ourFCPwEaJM4/HLw4NYk4n0809g4jBSuTxDLoh6xCVLtXqJ4EXrofi+9uKpuIUVeYdVh
         g1/tEaTudrbzvJ+yZVd0S1pzuMF0FgKvAT8+MzsmCVvZXRnvqiwZgIFkKFaMvh+YT0tA
         QZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112231; x=1734717031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TowrwHHo+Z/Rbfx8dYSOWZVrv2+F8jb+aOKcTufy/9s=;
        b=wxi+ASH9Lx3OiE6nRKZhS8Vr5oNXqmKQt5fwt1k+zkSjOZ6MtZpte1Yi9BNd5CTjJi
         HFsxiKpXaK6gC9Y0e6T1SaewgLIHOxHFLnY4oN4TNE6QEug5WRTOX+MwzFSUIodZPwK8
         kimr9rRM4q+8D45rge/g1dI2/L/QGlM+WKwT3XWduIOarBRGm9wKcV8hPC2DtMe8hjFp
         P5H+gu5LPBtu7ADLsOTX6LDy1qYaworfpoh7kdkboiQ70LkrIOJ9ZqjsQnVefOnzNvkl
         YF0gskjZHIsFi2YpkcB18h4N7E5jwMveoVOhS4SqCOrRDK6zTtR2JlB+Gd88xIAKzWBe
         1zpg==
X-Forwarded-Encrypted: i=1; AJvYcCV1g2NVt+KrrR643qfzbDU5XkHi2jkmOISXYLjHkSB/k9WYEWnYgUx5pkDIlGxTCnru9yPevEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGmvpViq2xE7EjB/7lVsaSes+Fx1+dUVCXY1wndjsVtY8fmZ7
	+3E1JbiAI7X2aJTESFcjXPNXYNWiWTLfhrMxVuoKUVZm35TcrHE/wiaQlIGhqgU=
X-Gm-Gg: ASbGncuoKvOnzQOl41tNrLe+zEddsyX3Amcqcb0f17hEwlGHGZUliBzZKYafMtMkZE7
	bBHWzO4tL2oNkh2zLasRCu7NAh9NaCgWvZDbr2gxcSLCJ/xvRbKB9K9LVD9pPR+we/xrKYjSyx6
	hsHKuU/XheqTOpyVIVmbCj39bv7vcUlyQFgp3gjdFXY0EZOwNN4+M7+MmfGa6z2MYBlS+p5m0jg
	7WT1kQ5aw73LxoBZ714r7P+YJD71jUm/xcQkSFs3JUle0L1abay7D4VNMktGcnSfVq7vYqe1oJ9
	DyjirxMoufRupQL/1Qj+5mlPN70CHj3nYg==
X-Google-Smtp-Source: AGHT+IHkiY7danHaI2/4tVyIk19f+i6/bLjvhn/gEfEFpMSrj8uqnFboP56GlYXHaxZWng9GURQDkQ==
X-Received: by 2002:a05:6a00:419a:b0:725:b1df:2daa with SMTP id d2e1a72fcca58-7290c248bebmr5836996b3a.20.1734112230993;
        Fri, 13 Dec 2024 09:50:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac52bfsm58567b3a.26.2024.12.13.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:50:30 -0800 (PST)
Date: Fri, 13 Dec 2024 09:50:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Set device flags for properly indicating
 bonding
Message-ID: <20241213095028.502bbeae@hermes.local>
In-Reply-To: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
References: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 11:42:50 -0800
longli@linuxonhyperv.com wrote:

> hv_netvsc uses a subset of bonding features in that the master always
> has only one active slave. But it never properly setup those flags.
> 
> Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> in a master/slave setup. RDMA uses those APIs extensively when looking
> for master/slave devices.
> 
> Make hv_netvsc properly setup those flags.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Linux networking has evolved a patch work of flags to network devices
but never really standardized on a way to express linked relationships
between network devices. There are several drivers do this in slighlty
different and overlapping ways: bonding, team, failover, hyperv, bridge
and others.

The current convention is to mark the primary device as IFF_MASTER
and each secondary device with IFF_SLAVE.  But not clear what the
right combination is if stacked more than one level.  Also, not clear
if userspace and other addressing should use or not use nested devices.

It would be ideal to deprecate and use different terms than
the non-inclusive terms master/slave
but probably that would have to have been done years ago (like 2.5).

For now, it makes sense for all the nested devices to use IFF_MASTER
and IFF_SLAVE consistently. It is not a good idea to set the priv_flag
for IFF_BONDING (or any of the other bits) which should be reserved
for one driver. 

If hyperv driver needs to it could add its own flag in netdev_priv_flags,
but it looks like that is running out of bits. May need to grow to 64 bits
or do some more work to add a new field for device type. I.e. there
are combinations of flags that are impossible and having one bit per
type leads to a problem. Fixing that is non trivial but not impossible
level of effort.

My thoughts, but I don't use or work on Hyper-v anymore.


