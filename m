Return-Path: <netdev+bounces-208309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E23AB0AE2B
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 08:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FF91AA5625
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331F42264B6;
	Sat, 19 Jul 2025 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkJoBrGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709611C84AE;
	Sat, 19 Jul 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752906358; cv=none; b=j8YDt4VN2tAEuaOgvAcxNrn0RKY3vJQv0f9CBZPOh1dJrXQp94dhVFvr4F/KOL1GSOaflyUD2OqE+A/65itAtFhxqdTmYWFB2MsueiZfglPDwjeGtifGtJ3VlsqS39JmbhAU8cKEevD5fRd+sykXPFlmdqgjhzg3EpqGVtZayyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752906358; c=relaxed/simple;
	bh=XwJ21gHeqdOULgvCF8ZTkqBgOmIEfdl5i9YoW2R9H6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+tdByusQbPb0SaYmWP2+L4xZ7nE2NDuP7lCXoaYmVG/tG8+9xKuanF8p+gvq79PcAMydePRVh6vhQGBPm/MmPYLY71v2ac0auLSxFzUhVgJIyZ/XvIlhOnNS82a8qA6K0IolXPcljLowQTZsyOwA9sHNaEP9T5pPUkGt8/Y0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkJoBrGk; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so15547635e9.2;
        Fri, 18 Jul 2025 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752906355; x=1753511155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQte6lI5PiSDZsROxixX7uIAesOBBN2vdifhMT0mgMU=;
        b=WkJoBrGk+/8EQdqSKuMbKBeKK/cxMkjc3CiIQUMQJn9LfJO6okW2sZYsUoUPhmZcCp
         M1wktG9Ithj6h3EjzRg8VialtCMJWrrqNaOEctMuDbOWhOhgGGkQJmeO04H4TPlhbRwH
         4wAG6sdTPGb/lpMJFYTHiy5DjnevI0mm1XYiZLrSb8nk7VWndASAG9lArX4yrc01AflV
         fMFPwPnESIvwhBOIVZbjPzdu5dkCJMDz2tTMTbir9CsN2x7zPNmUlx7KPW2kAJIvOZl8
         AQ3TngJghba4/tH5+IAew7Ilw8zqsthszzKj2SiJP7XliFS4Tk/aBYPbxyc9e/Xp/FU7
         NC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752906355; x=1753511155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQte6lI5PiSDZsROxixX7uIAesOBBN2vdifhMT0mgMU=;
        b=VT2YmmX+8FACOHE+TNLvPb6bPbOYTnx/ZTT+JkiDYjuDtvHfBaCh2DMjfc6ZX0EB0C
         GgqQ4BizzrljnXL739UJTx17phjjQ6qPY8LVeQKgtosWnT7zVV6OvESJon+yoOpjVZie
         2F2oUnozLgTNg5HDoY+73F5l0zG6YGteTD5Y8mYuIPTH6P9ZcwXKxj+Sg9auvjWvQobw
         w7Nhik+/VmKUabVv1EwtlXNwV9s64BN835XN+YTQaXawHfZaKBni9IMZSs43RwAyJAiF
         R3SyphTizgC+PqC57JhZ5DppLqKuKitO6zGzzge/ZyyySZNVF3rp7se3lsjKLt4tHH1d
         pPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFCE+VyBximNqVVMzAyBXUCpiE4DDnYbIWOGf9FtSZG7CkiZARCkwS8wxwDE8s4yiRZQzdAchY0QrACZg=@vger.kernel.org, AJvYcCW44V3772yLoOO8Ydj+8jnIu8wWSIopLgHkhpp3/q+errxH+zvmX24AgE5pmadt1SEq560OYY+r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+VIpCJbJfC9EfxyE6l+iIPKeNzm366mgQffcl8d8WF+UZGx/
	d7Anr6BEFy+7u8sbUhCKkre5/0hGIC+VrsE5bP4VlJatwGQbBC56Z34W
X-Gm-Gg: ASbGnctykcdR1kg4b3Z02lRdJxT5MgGz7kK3OJPRD+P0H4dkQyNXUzZjKhZ3A3mrF85
	YPB4AdObStwMxOQwWuG5kr4M2/K3tBQxaNHBahRIqVy4OQJhBdh0kJZkfwTLVO/ZUGnVXwgXnbt
	830BdubzjI1q9VMvRy4zaPL6zFIy06GteCDj7Wo1kFhotlmKhNkQbU4ooq5cNX+8OoYdYssbzD2
	1o2pygug645QMxClZj5MJbCy+EROOsmwvHQgX3wj851z5+BwY7bhJGlRNbKQaLF9ARd17ZZAjpz
	P5h/H73KlO+C4oul19wODffZM4TPueqEsq+LJXfwBGf4cHNRdpMnJKR6Rvjxxcq4RtLJe26sL0B
	N20y0SyhlDjplzlN3zwliiXT9SCcBUEKBoK8V1oNB8a95shGUP5PFssEjrfvKbQF0YwQjN6uFNz
	vWLc42cbA=
X-Google-Smtp-Source: AGHT+IHCYmjEIfhlQwmc8yrS7GWnHntpJS0njrNamtTKFpzD6ap2kSWGk/ZfVqw9GGz7tTQlhFVEwA==
X-Received: by 2002:a05:600c:4eca:b0:456:db0:4f3d with SMTP id 5b1f17b1804b1-4563533d6fcmr75253535e9.24.1752906354647;
        Fri, 18 Jul 2025 23:25:54 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-98-199-117.alshamil.net.ae. [86.98.199.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf4bsm3811274f8f.31.2025.07.18.23.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 23:25:54 -0700 (PDT)
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
Date: Sat, 19 Jul 2025 06:25:47 +0000
Message-ID: <20250719062550.652-1-dev.nuvorolabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aHpyDpI9PW8wPf6I@shell.armlinux.org.uk>
References: <aHpyDpI9PW8wPf6I@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 18, 2025 at 05:10:54 PM +0100, Russell King (Oracle) wrote:
> Sorry but no. The PHY will be "resumed" from boot, even if it wasn't
> "suspended". So the idea that resume should only be called if it was
> previously suspended is incorrect.

> E.g. .ndo_open -> ... -> phy_attach_direct() -> phy_resume() ->
> 	phydrv->resume()

I do point this path out and there is also a second call
(2) .ndo_open -> phylink_start -> phy_start -> __phy_resume
This would mean 2 calls to the PHY resume every time an interface is
taken UP is expected behaviour?.

> During this path, the PHY may or may not be suspended, depending on
> the state of the hardware when control was passed to the kernel,
> which includes kexec().


> PHY drivers must cope with an already functional PHY when their
> resume() method is called.

This is not what I expected, but if it is by design I do not see a
need to fight it. Just to make it clear, if we need to reset a PHY
after it returns from suspend(or any code thats dependant), the driver`s
callback should provide this guarantee?.
if yes, this was just a misconception of relating it to resume callbacks
provided by the PM subsystem where such behaviour is not exepcted

Obvious logic error in the patch but this patch is not required as it stands.
-	if (!phydrv || !phydrv->resume && phydev->suspended)
+	if (!phydrv || !phydrv->resume || !phydev->suspended)

