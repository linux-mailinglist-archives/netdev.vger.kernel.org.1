Return-Path: <netdev+bounces-179191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3AA7B195
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C247170DF2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773E774059;
	Thu,  3 Apr 2025 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG7tAHrt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFA2E62D4;
	Thu,  3 Apr 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716686; cv=none; b=Xkwm4hpkCUHF9vcz+SUnQ/DJQ/oCTrGvcVyYjQWCj1n+sX0M2J33Rjgd8Z/r2x7sr57NCcqcmXXflB/Isn7/ok2Yrrn18AuDMHYdqG1gLvU+KYm5dY9ym/jysAq3fbEg8KBR9mIm/Y1w3qoJ9yUpsWs5tsbRTS0oEuNe6vc6jW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716686; c=relaxed/simple;
	bh=+CyspF25xHfjYoZGk8QYqgWacPXeHzzbsulAih8loaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRJgkGqIQ9JhlgtykjQkSCFkZb8wZgncxEBSRqltXn55dilSKhNw2+pqX2/0c3zlYiwk7sYJy/ufCZO1WsdBzpe6zRcY4V9d6EVKnC9ZGxBN+FbTImq+YapZS5GShRuJq9WJiis9Uz48l+pJvPlYNjGrz/U63HFo0o+3lQvYGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG7tAHrt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912622c9c0so112402f8f.3;
        Thu, 03 Apr 2025 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743716682; x=1744321482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZLFFossSrv/l+DrIWpc+oReNbAT8/u7SKpQNw/QK98=;
        b=GG7tAHrttGKGN3dstcWIlE8f2ZeXb9gd+vvJeur9pPwgNlwD/fPZO4Q8YUB9+olRb1
         ruQNsggYGNhYOXIsfKSg3xMb8EFT7bhNebRnVH3BmFoxpx/nMRH7j9i+RV+ZsjuvAEDb
         xJpu47J/FDDyBxydS3sxMmq4LAXbOUkeBHqLAtvgx5+a+y5GGxMMxmVD+K5L8LMFgZm4
         pMeJjI31E3ddCuDEC7y3fl1l0o/SVPceqcc8/RMfiIalU7XvSmL9sCr3POZnzf/4u1ss
         FzHSmiCB0M2sbf0olVBclpS6jZhv29yZYWdzcTKNK5BJ82b0OqfN+sqML9md9kRH5Pqw
         b4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716682; x=1744321482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZLFFossSrv/l+DrIWpc+oReNbAT8/u7SKpQNw/QK98=;
        b=EkcQNo4ePMb6B9sVMbDD8TPsrLY26parZ6Qj0G3kVdXNlCDCIBCSTTl3gPGwRZDsQ1
         TnhhuqDXKq0YXwGVPeZSeaLMwpwMG4yGYriMw3hhU/Ye5llPyK7d6tlW+EnQ+PBpRxwj
         3hCargzP1uam/lA/6/pIKdN2hnTrzsKymrp2X5tKNPmp7z8GDY9M9FDsTmPV1YiVzi+2
         UZbO5n+iMFGTIhS4mG58IBse36yn0RWWSllSrtWwFX7P5JVHxquHtDWWJCJFTj0YNumk
         kaFZ+7G1USVAWRXcY3qnUh+sbJthXOmwDapVPArBZrL7rgVBE/i3TwXNE+rI0DNsWimD
         O5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVPITcKOD/j3KnqLZz5j+rk8jUp6VeQE0p09h2q96B3ZuHNTNTu8p3I+vDEKyo1ocXwJ0ETUZ3FHIwqz6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqqZoy71AK681P5tNPEJVHmmJ3osTV+QFi20rPrPnu69N6l8NW
	exVOwUzMHV8mt17xASGRm9UHJWVq7mHT+M3xlgutau5Cay4VHQPN
X-Gm-Gg: ASbGnctPtcQ9/X9KYeVh2UNOWajneCZLBZhADaAJS2zc/DE8+XM4nCLW01hL0xoHKBG
	n/Kqrjlyg8vU+m5yPei1PdrU5GDxBGZNQqhtZ7qLJZL9J7g7QzRftpMI6tZ3JgzaGgRBQjIHOAc
	/LeyjEFqUgeB9uCVs6OVQmhWLfmHO3WOokTNn/VIiNNSJz6stmG9vXaDYcjUUv6H51O7Q6tha4Y
	ekz5as0totnh5o/n/pY3l8gHIAAFYZB5AWTYJ5FwOKjEHSfepk4U3nTC0LdRLZm8cB/F8nFIi5R
	AsOFyN2Js7FYtPq3soSFnhqDz84+gDMV
X-Google-Smtp-Source: AGHT+IHCoP1sFHmxYqWia4K8+qVVM6seiDlHapxM0uV3sLIUbL70FLxnJ4moaJo2s4aSpJ0GoseXFA==
X-Received: by 2002:a05:6000:2283:b0:391:3110:dfc5 with SMTP id ffacd0b85a97d-39cb357f3bfmr218465f8f.3.1743716681606;
        Thu, 03 Apr 2025 14:44:41 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795782sm31928735e9.26.2025.04.03.14.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:44:40 -0700 (PDT)
Date: Fri, 4 Apr 2025 00:44:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, Julian.FRIEDRICH@frequentis.com,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	upstream+netdev@sigma-star.at
Subject: Re: [PATCH v4] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable
 timer on destroy
Message-ID: <20250403214437.fayvje56af3rbfrl@skbuf>
References: <20250401135705.92760-1-david.oberhollenzer@sigma-star.at>
 <20250401135705.92760-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401135705.92760-1-david.oberhollenzer@sigma-star.at>
 <20250401135705.92760-1-david.oberhollenzer@sigma-star.at>

Hi David,

On Tue, Apr 01, 2025 at 03:56:37PM +0200, David Oberhollenzer wrote:
> The mv88e6xxx has an internal PPU that polls PHY state. If we want to
> access the internal PHYs, we need to disable the PPU first. Because
> that is a slow operation, a 10ms timer is used to re-enable it,
> canceled with every access, so bulk operations effectively only
> disable it once and re-enable it some 10ms after the last access.
> 
> If a PHY is accessed and then the mv88e6xxx module is removed before
> the 10ms are up, the PPU re-enable ends up accessing a dangling pointer.
> 
> This especially affects probing during bootup. The MDIO bus and PHY
> registration may succeed, but registration with the DSA framework
> may fail later on (e.g. because the CPU port depends on another,
> very slow device that isn't done probing yet, returning -EPROBE_DEFER).
> In this case, probe() fails, but the MDIO subsystem may already have
> accessed the MIDO bus or PHYs, arming the timer.
> 
> This is fixed as follows:
>  - If probe fails after mv88e6xxx_phy_init(), make sure we also call
>    mv88e6xxx_phy_destroy() before returning
>  - In mv88e6xxx_remove(), make sure we do the teardown in the correct
>    order, calling mv88e6xxx_phy_destroy() after unregistering the
>    switch device.
>  - In mv88e6xxx_phy_destroy(), destroy both the timer and the work item
>    that the timer might schedule, synchronously waiting in case one of
>    the callbacks already fired and destroying the timer first, before
>    waiting for the work item.
>  - Access to the PPU is guarded by a mutex, the worker acquires it
>    with a mutex_trylock(), not proceeding with the expensive shutdown
>    if that fails. We grab the mutex in mv88e6xxx_phy_destroy() to make
>    sure the slow PPU shutdown is already done or won't even enter, when
>    we wait for the work item.
> 
> Fixes: 2e5f032095ff ("dsa: add support for the Marvell 88E6131 switch chip")
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

