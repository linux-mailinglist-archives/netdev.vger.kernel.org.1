Return-Path: <netdev+bounces-87002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F64A8A13D0
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D023B289C8F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14D14AD0E;
	Thu, 11 Apr 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXCYpM3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6014A4E7
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836922; cv=none; b=SUOI6yovVuGd3Ubmm49i439OHePuwALbzmslpCqe7DNU6ScHxKZiJj/IGS/nB/4JnQhF2lhygbLWxgWAggB6ilb2Yoft6YVeTQYJet9xVAdWU+2vU7agG73VuaebTAs4p76aZbHFMFsJaUGjjstFGlAn8qC0sT7FBOUtdCvt3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836922; c=relaxed/simple;
	bh=WOGDS/jHodlCFSNuuovtPF2PmxHBMd2nyQscMq9vPEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZISjC8bnGDF1uSPo5z0/3leLWYIf3NCvy2Tm5DqP9MTowykFYXm38mWeOITncMsCpm+fWT8kPBtd0QiS5hV7EoIzcfaLSfhVafFfBof3Kh/KTxUyG5lvkN9GbKYPqsaSfZwXHGz5iCH3s/SNCeW87ygY6JGLfCuVzW2H0+o/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXCYpM3b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417d08135b6so5640335e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836919; x=1713441719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbL/THhnMZrowsbTGbZXiwbJYabCZWyizerlYGB5Zqc=;
        b=UXCYpM3bv6egQtCoLY9wIEX5gni9h55rPlHF+QVzNnQmFm7T1vfIQHNcQS/CbUxWpo
         hF5NaqnVgDhSDJEd2XvFRCdQoGxdq9zK+6ZS8qZGRWv5R/LjXED5lyT2lJvoTyiIkmzj
         YOqloIuw6sRPpG7p7BT5HlcLA/Egz7TXxQgHJv8N8gIGN8kNn1D/kXL+sX+ToTIfYh+M
         33PeBUUy5/XB1sxY5b0ZqxeJ/k+z7DF+sLS4rgxPxLR3LG84OpLkZ9+mEAOvElHdnP2V
         5IIR9oF3RJb4vt+4KF9hmG7fNtGkYhQWuRk3rgeaOkD6ISelPLJJEqDGdg4NdUKateuC
         uFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836919; x=1713441719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbL/THhnMZrowsbTGbZXiwbJYabCZWyizerlYGB5Zqc=;
        b=TWRGjyBCGCH7Ia9PENJsI1KE8o2ZiRjuaK4t3BMjTKS6P/VlvAJkIZE6pCRKXQeCIL
         iQAeG1REUE3PBRBWMz/+iNUs+5gAryBT+gEF7CyjttDd+1tXwCwfNO9LYjR2Om2eb9b3
         1Ma6kOSEalDsZlRjznumKApm6+Pvs+XO39WD+sAhelFH6mZvi1GrUv440TTxlZxxUg0w
         w807cdKoQrup/ljfdmKPZ2Fc/qeIvzrU14prABDRmNodndbE+y2S+O7pPqZOLl3eEd7W
         7j9MX8R1vQ6ZbD63T++odYWCkxTPlfsXmWlMtAhroQZNystrKPp2KpQ5VtK/0R9O6AL7
         p9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWxOdvxzUZhZUQeewP5E/i3erRq0e6qE6OcJSm8MzbtXKDQHsPF0uHOgyPle6J41PsVMFMnC/+PwzwHVQKJ8Es+p7DG6MEW
X-Gm-Message-State: AOJu0YyEgf5r1FTivGPFOTReOeBTC3W5LrDNW8Ws7hKzj6RL8uZDVdZJ
	Rt0awMFNjrb8PMbqhawRqutDBb1/1X9cd2QpH2/1Yr/6zZSNZVCX1pvnUfGU
X-Google-Smtp-Source: AGHT+IEqZDUbqsHmx+0d/mdK60hFJ2s2R4GPh77+dLgE4PYnsNfNN+gLmBjZr+n6bMrXxB5BhX8Kog==
X-Received: by 2002:a05:600c:4511:b0:415:8651:9b8e with SMTP id t17-20020a05600c451100b0041586519b8emr4330475wmo.39.1712836918799;
        Thu, 11 Apr 2024 05:01:58 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b00417d8c16bdasm1694202wms.39.2024.04.11.05.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 05:01:58 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:01:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <20240411120155.uan4ej7eqhxm4psp@skbuf>
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
 <E1rudqF-006K9H-Cc@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rudqF-006K9H-Cc@rmk-PC.armlinux.org.uk>

On Wed, Apr 10, 2024 at 08:42:43PM +0100, Russell King (Oracle) wrote:
> Rather than having a shim for each and every phylink MAC operation,
> allow DSA switch drivers to provide their own ops structure. When a
> DSA driver provides the phylink MAC operations, the shimmed ops must
> not be provided, so fail an attempt to register a switch with both
> the phylink_mac_ops in struct dsa_switch and the phylink_mac_*
> operations populated in dsa_switch_ops populated.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

