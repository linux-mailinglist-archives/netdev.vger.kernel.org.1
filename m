Return-Path: <netdev+bounces-208326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA11B0AF9B
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 13:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B16BAA0C84
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3C22256F;
	Sat, 19 Jul 2025 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnMviboH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC41E7C10;
	Sat, 19 Jul 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752924900; cv=none; b=Hgzn6hdB6jJhGrRDFcl1rOCW67ZnhnPL2WHzJu6nD1d9V1QYwPYb2/t+ikY0QvSlfklZ6EFPyFueCB2OJrL4FT5qHTEEaTBZnAnl6DEw4zNftPK5fnX4fqopJ8+kLptm/khljCTrWh0tvDTTebJlp0MFz0w7HSkYK7q76J0e4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752924900; c=relaxed/simple;
	bh=pI/Wu4VJD4vdRub6/Z5Gz2RtKzMxqQmEx7I+Ec3VubU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VypRfKdtcFA4+2XXyJ1b5zrgW1k3lE7Pgnyi/nWzchpxxaODFSv9j35sK6vqSQDXpzbuP4w/N/vNqi0iBZdg+CpT9QSVRko3+zpeVvKtqgHuKGOek58g6bpmeb5w7DzGSkWoux5xZ7Vklnp0K2L8i3o9zJfdNV/AxPEpu/EcJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnMviboH; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2672138f8f.1;
        Sat, 19 Jul 2025 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752924897; x=1753529697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI/Wu4VJD4vdRub6/Z5Gz2RtKzMxqQmEx7I+Ec3VubU=;
        b=JnMviboHs4KILsKUgkt4Y16ZapGISts+KOKPL52ESSS8BAscV1M0/uRl4scS7S80Rt
         hJuAhs6HE7c1Go2Wdo+WS9r1Mc77LenC1cv53JeSqBVp9RyP4omWFCtorCg5uQBVWh+R
         yFW1BZuIJR9XW1i6Lru9v9hdRKISTWixdjlSysxEIc552mZLYwWpAbfnTFlgqvGTW2iD
         vtCK3BNiIf1UrWelEPEFV9Rb0NSc/OIsxkPJlrhNdWqKXkrrnu3PScW31zoDsM/fJeCR
         S0p617X2ianijhzVlP9Ps/JYSghChXzgrhIYGxGdpRy5h6oUJYP0WfnVRyQggIdzRROT
         3qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752924897; x=1753529697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI/Wu4VJD4vdRub6/Z5Gz2RtKzMxqQmEx7I+Ec3VubU=;
        b=k9IFuopbtGtRxa1vfH/4dhdcPDUIG62NJLPHPFCyZHfQEINjoN0nTSE9Kj5yQvQCJU
         ntXyaDt69FS7oaBb8SSqL0KMQHLnKsVf1ChmDTrRSj5Jg5S+1m87E0b+IuDwahD8N/Qi
         nkQU13keRN/lkub9Gvw6lBzDr5V45/dVe+tEZIlpmX2Hq6wwypscvUC+liKnmsk5ce4b
         3lOH62hjIett3v8LakSEtbHHeELUkHWFf8Id4NJ2FvoKHudiuB92r4vWWTGxyxcqhnnz
         2sdI1AKN35eRZoRkzfszVEVg3A/VXvnE0xRnDOzknrsD06A25Ul0kAXKzsfypymuHaMz
         py2w==
X-Forwarded-Encrypted: i=1; AJvYcCVsOqAS0dq+1fjDOxdtcdAUH8UbtGYpMRKADb6cZkdwjOVG8BCWoyho/3u7wcYcZrr2gXltV6iMLNypS40=@vger.kernel.org, AJvYcCX74jPxORrbJd1RTU0mhhazvqb87WFeUMfRlf2bOreXjicfFbrgliXL2Nk4oRe1UVc3u7thTQ1M@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWkNxm/c+dEePnJyFY3CSWSWw4i5vgBF0OZIJ7xX8nNftFMIr
	PlKMSKx2DirrbSZn/Eu7io9pz2HKvanXxTTg2y79OYVFWGiRWsV1BTDr
X-Gm-Gg: ASbGncvV5beMvcMot312dj08Z45IiDPw8irf7kkpi9sI+r6A8YKL6GClsOEKp6am7qB
	BXyFVa7hctFzK/uUlHfJFmzo+tePEpdTIsV99vPD1bQWHv9H01hX0MJ4s3nAYTtL/9zyNF3z4dV
	JCeBYpkjszDNPo3PFCMCekfwhXM6DCBgoFS+jUNBaFyl4UfT9pAJfT9AsRToVt1vwOwWit+Upit
	ZW/pWxgXGXKXcep1R4+Az6flJHs9DrWZ6jG/sPYpZN/JEJjczMXD+0TdDx/MIKsw8Zk5ait4M/a
	77By/TUQDYr9BGMcW0jznn1VzOZRhf0Ghbx5YRUSZKLNGFhl4/4YZB/PcUX0W/jAQVNOgELzT+R
	5d5ZoeinGzgYICj8jeuvS5ijP6tu0nw+U13CR6G0fdJ+spyU7ejlY1xjEdPG0f/rHQzaY0YxP
X-Google-Smtp-Source: AGHT+IE6g19+dUycquzad6W/cE38ba4tQ7W22bnkBUjwXHT8HNV6H9kA6IReaLnHzsPSz4zYawmCGg==
X-Received: by 2002:a05:6000:1ac7:b0:3b6:d94:d62b with SMTP id ffacd0b85a97d-3b60e4d28e9mr12485560f8f.15.1752924896790;
        Sat, 19 Jul 2025 04:34:56 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-98-199-117.alshamil.net.ae. [86.98.199.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b740c51sm45073575e9.19.2025.07.19.04.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:34:56 -0700 (PDT)
From: Abid Ali <dev.nuvorolabs@gmail.com>
To: Abid Ali <dev.nuvorolabs@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix premature resume by a PHY driver
Date: Sat, 19 Jul 2025 11:34:50 +0000
Message-ID: <20250719113452.7701-1-dev.nuvorolabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aHtNxLODmEHRVfdn@shell.armlinux.org.uk>
References: <aHtNxLODmEHRVfdn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Jul 19, 2025 at 08:48:20 AM +0100, Russell King (Oracle) wrote:
> > I do point this path out and there is also a second call
> > (2) .ndo_open -> phylink_start -> phy_start -> __phy_resume
> > This would mean 2 calls to the PHY resume every time an interface is
> > taken UP is expected behaviour?.
>
> The whole point is this:
>
> > > During this path, the PHY may or may not be suspended, depending on
> > > the state of the hardware when control was passed to the kernel,
> > > which includes kexec().
>
> Thus, the resume function *must* cope with an already resumed PHY,
> and thus adding extra complexity to try to ignore calling the resume
> function if it wasn't previously suspended is likely to cause
> regressions - phydrv->suspended will be clear for the initial call
> to ->resume(). Thus, if the PHY was suspended at boot time, it won't
> be resumed when one attempts to bring up the interface initially.

yea, I get your point.

> Hardware or software reset?
>
> How much a software reset disrupts the PHY is PHY dependent. E.g. there
> are PHYs that need to be software reset for configuration and
> advertisement changes, but all the software configuration is preserved
> over such a reset.

The PHY we have loses power when the kernel PM goes to suspend and we
need have a hardware reset upon its bootup in resume.
As an unintentional consequence this ended with 2 additional
resets (reset-delay-us in dts + 2 PHY resume) at boot->interface-UP.
In the end the "phydev->state" in the driver`s resume callback was used to
prevent it and checking further, it was evident that there were 2
intentional calls for phy_resume from .ndo_open which didnt look obvious.

This particular scenario was not the point of the commit but rather
having some protection for phy_resume but I guess its not possible.
To keep it simple, these would be my present understanding.

1. Should the PHY driver be able handle consecutive resume callbacks?
a. yes. It would have to be taken care in the driver.

2. Why does phy_resume exec twice in .ndo_open with PHYLINK API?
a. can happen but still dont have clarity on why .ndo_open does this.

