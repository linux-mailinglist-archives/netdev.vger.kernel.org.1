Return-Path: <netdev+bounces-248288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20445D0686E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 00:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65E14300AC82
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 23:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E028D8E8;
	Thu,  8 Jan 2026 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCury5uW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4181D9663
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914357; cv=none; b=Ak7fFBsc+VYotrQlrCeLP+5I98yQ5/g9EJffR/lbC93pZrHfa3h/IlZRMhPKj4Xc35wtVTZR4QsHxqh5fEz0agUAkwgBxsCtVGGIXteOUcoBC7xBvZoYKT8xftzGxlSYp/siAgX3qulWx/AIEuF5ECcQlzSykypPbokXklgqPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914357; c=relaxed/simple;
	bh=hWYmWXFxnKku1jo28+4Sq4UXesm9R2PiIxdlKbhYrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCiHOUPYCC14NnS1HquyZ3qBHcZbISKSrkybc8QV74aTIiQq0xxcBqXee8PTl1zEyn/iSCcYMIEmpxGLlnaECOHxewWjuhr82LE/Zkt44tNFVzqiy86ihtLZA8s+b+VffV4SbqabQ1nU/IubNut90QVbY1cpZ89J6FBN/I6j0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCury5uW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432755545fcso2128501f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767914354; x=1768519154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWbIabO0t2kJEwN10dkXtzynFH1qHhFIB6cJcEXchTE=;
        b=dCury5uWabux0LywhoSmGTi007hIU4jy5E9NErlTKCDJ8QsRzDm8izqUTAVJpwV0KN
         hHGX+VHUxrs/Fb59NzT0HRqHxEAUwVitAA3qtwmT+V9Bmomt0b79a97s2nSWnuS80nl5
         J21Maid3Y0AzttNM04lRaidW6Y7bjwGcBELjjiuFSBzO1umv8gEJ3LnHq8nYRgm0FqJH
         2qV9qptHUkkbCEAb4Czg6VBEfZf1qAsoyqfNkyRHpM3o1sREBM8MsQXbGssbXm8rk6NL
         HUQpWDuH+T26Le4DjIQqMtjufhGcr9lf/6MQJbC/AuaaCgYHTZH1ImIXER46NH6Nf3O5
         WB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767914354; x=1768519154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWbIabO0t2kJEwN10dkXtzynFH1qHhFIB6cJcEXchTE=;
        b=jW2tycLMOtqNDqYHK7YjEt+LhPydfBQZbizk5ICuSFngHNq/4E1WqFwtcwVcThSBg6
         ua4uB69x0kjyp70msHoUy/Qls4HHPo59b2kHiHkERtBs/8llmrvYGnt0mf60Ay5tES8P
         Jj8PdZ46CiTzX4zOmMhVhm07ObvI2rEGE+zFww5A2Nal9N5bgR2cduSAiqp9zDbQ2ZMx
         I3MCGwKLBgHBSzds4o9yswn6xnt2stWu938Dh2GMw+VIOnpe8wBuSRQQsy4vI5qJXUCS
         JVGKskv0cYavhvw0q1vJaJ+LxUkfzBOtNyVzhRpiK22Y/L7L4pC/pu5pcK1zBkrc2Hf6
         b8hw==
X-Forwarded-Encrypted: i=1; AJvYcCWLTQ/dZkYefR2XjBF6w43TvczmSOagkA6oq/UIs2YyanBbE6iK4qYI08l2x1MsMVvwjtaBvVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoh5maGUhc+NlqyOoCquDsj7NJRgqcomwcwNRAFNK4UHCUYudk
	wpjkRV52+sfsDWwBTaQal4jB1q3BT/JTbGiXyVQQ/OUBQY213YNPLQNU
X-Gm-Gg: AY/fxX6YcWMPcjVqVtlYzDGq0CEvJThMNwIYkG2rEhPG6oBvirEtltEUf3CmkUm7pAi
	3Spp261TTQd9Jk11xpb+TilmgWEWwQoaTBVI3xtEGudhTpdfrCoUlPUQ2cKYJjJbG9UTq48PaN9
	I+T7A2FeW9St7/CTtu5XYqul0tmoGxqKI2Wp4zfCT+ft6mQvtO7afMCqeAO2sN2O2Kc59Tb/tr+
	NHvACe3usdOcFjbq96gIUSk/8VL/yW2QZlIpaKJKEL3xm7KjrEWrkTn13Io9iZLjbKMYfXCMbal
	91KQb+A7J6a6LBlM61cYH04Ld79vUr+h8TAnqqaltf7uwIkoUsOiauLRmXwq2ffadT1zDeUKcz3
	nFGylKx3aB88VvJOXU82jsiVmB7yfAoswx1g5qQo+09HmotgSUzhBXVrXg+7g+buP5YBD/VYWMM
	iICPCZGO9Zy8vq0AU=
X-Google-Smtp-Source: AGHT+IEzdhKALltABm5XBS2La8kTprLHVWdnQ5WNEGE6t0W+pFNLVRN/o9iPJ1XeQZrKs1u5edJ7PQ==
X-Received: by 2002:a05:6000:4305:b0:429:c14f:5f7d with SMTP id ffacd0b85a97d-432c374f13cmr9768336f8f.29.1767914353881;
        Thu, 08 Jan 2026 15:19:13 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm18693102f8f.4.2026.01.08.15.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 15:19:13 -0800 (PST)
Date: Thu, 8 Jan 2026 23:19:11 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] r8169: add support for RTL8127ATF (Fiber
 SFP)
Message-ID: <aWA7b-8ouKIm7HFU@google.com>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <d2bab188-96de-407d-84b3-34584494aa30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2bab188-96de-407d-84b3-34584494aa30@gmail.com>

On Thu, Jan 08, 2026 at 09:28:20PM +0100, Heiner Kallweit wrote:
> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
> DAC). The list of supported modes was provided by Realtek. According to the
> r8127 vendor driver also 1G modules are supported, but this needs some more
> complexity in the driver, and only 10G mode has been tested so far.
> Therefore mainline support will be limited to 10G for now.
> The SFP port signals are hidden in the chip IP and driven by firmware.
> Therefore mainline SFP support can't be used here.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Tested-by: Fabio Baltieri <fabio.baltieri@gmail.com>

Thanks!
Fabio

