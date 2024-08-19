Return-Path: <netdev+bounces-119669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4299568AE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6373283E82
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC51161319;
	Mon, 19 Aug 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWEIStYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B23156F5F;
	Mon, 19 Aug 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064079; cv=none; b=ADUApiwv6pqKpaRURbT6kNCFUmZRmYgrwcu+MgW5i8LDKyRnFYqj6BOSPUt7vegZtxReB39OlI4WUX9yr1AEphPGf6c+yEBuXFB+fRFsrM5os5CpDrwO7XHnIKlSJfBhLZVXeAn10T9twCojH5BVDg5KzHoNbLILbOA3JA5ijTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064079; c=relaxed/simple;
	bh=v5z6AULAsqrvamkmm47fcgWfrj/5hDRAYigHZr9uF3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXzLKywZa+6SOmMTD30uurZJgbcGmX+Jb4BjgdSD+d7aYnsdF62/YF5o6WQNcNeXdjMCnerxsa3rS60TtMBf4dU0CH7WU7emmgtmjmOy7EDT6hLq+65qhSt6t88A4TEAV7ZxxG8bEcSx4b7Nk/SWZxMB3LR68laHMy0+HTFB1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWEIStYJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bec7d380caso3291996a12.3;
        Mon, 19 Aug 2024 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724064076; x=1724668876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVKFniiYUmClbJ672Ev2Mb0P7iZLXweyclnrIo2HQ9U=;
        b=YWEIStYJje1tquPl9uVngOLa1hfALYxGHi+j3iD62l8jhu+OOyOOUans6ap7+Am2Z3
         uO1utKWXlB128GSFZ5YuXc21z7iW98Y5ZL2y/KZjyQYOevse2ZCxupgQjYlY84dx58uW
         7zxGixxiY6zSfC2ybO3cEMcuUCjb7UxnXYQOBLwioolunEcO+qTU8tYXEQ/gayf3D5oP
         XeIGdEOAbP6h00fa17fRrL0Vs+V/3yhEwb1paMEsIeksn6ckFEJN/x5sXUbd3kv+SnSD
         rR4a9mft+qriT4Xb4s7/JDFk9tQKYDmuPzS7WFq89W3OyNUSe2o8pEYoIdgZniHus1/C
         SgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724064076; x=1724668876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVKFniiYUmClbJ672Ev2Mb0P7iZLXweyclnrIo2HQ9U=;
        b=TKrGB+zbTDb3vW0WxCr0DE0sMUvc2P2MWG6z4urH6shk4K/mFGkelCAkAQpnMqYuwf
         BOw1AU6VY6uxoGg7cKlec4bmFiwbBTf5vKJ4etOpLH8Nlof2MepZESD1D/0XMOxM8CsV
         kf+K5EEASsaqSvPIF9oXoMcfnyLwu4fWdxkJzl6AdFOhmcjnUp9vPh0b4RD8KFtix97S
         +ljjiW0AFhev7rezlDssIuXrux14XSxU5vM9yNTsuF9tkE5N1nH26ZM9cvc57byNXSYt
         QSaPkkTAClx2we5uAPGOrGGDZxTkPtMsBMxjfw7L8zWwh2qQEq+U6VBZLBiKgxZnm4/c
         KkFA==
X-Forwarded-Encrypted: i=1; AJvYcCX0OTEe/GnLgPXlsSjzUNRT/c6g0UICw8NJ6UEekubPd62bCNKVAjKSWaZRFZLPVx6KN2Tb1gxhvM8zjt5KhguGg2U+iDdRYow2309SuweQW4Q9VwO+bu19oOjKzxBO+sT46ZEu
X-Gm-Message-State: AOJu0YzuJAU8kwkJ/DhALwM4Bx0CWUZTUDsAK7wrH+E5fQ/ugGGiiDel
	BJXObv/cB1WysEXANSc6aRisdBcs0V/6R86F/UblYnPOag/2R+O4
X-Google-Smtp-Source: AGHT+IHs5GXee+OasG9e7/BpW3mRMBtLWO4BYF/yYqXrjn+ojBJZWBcii8jWJRvXvthItd2shWSoHw==
X-Received: by 2002:a05:6402:5114:b0:5be:e1bc:2320 with SMTP id 4fb4d7f45d1cf-5bee1bc262emr4837315a12.4.1724064075382;
        Mon, 19 Aug 2024 03:41:15 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdffa57sm5444545a12.55.2024.08.19.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:41:14 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:41:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: vtpieter@gmail.com
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <20240819104112.gi2egnjbf3b67scu@skbuf>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>

Hi Pieter,

On Mon, Aug 19, 2024 at 12:12:35PM +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Add support for changing the KSZ8 switches tag protocol. In fact
> these devices can only enable or disable the tail tag, so there's
> really only three supported protocols:
> - DSA_TAG_PROTO_KSZ8795 for KSZ87xx
> - DSA_TAG_PROTO_KSZ9893 for KSZ88x3
> - DSA_TAG_PROTO_NONE
> 
> When disabled, this can be used as a workaround for the 'Common
> pitfalls using DSA setups' [1] to use the conduit network interface as
> a regular one, admittedly forgoing most DSA functionality and using
> the device as an unmanaged switch whilst allowing control
> operations (ethtool, PHY management, WoL).

Concretely, what is it that you wish to accomplish? I see you chose to
ignore my previous NACK due to the lack of a strong justification for
disabling the tagging protocol.
https://lore.kernel.org/netdev/20240801134401.h24ikzuoiakwg4i4@skbuf/

> Implementing the new software-defined DSA tagging protocol tag_8021q
> [2] for these devices seems overkill for this use case at the time
> being.

I think there's a misunderstanding about tag_8021q. It does not disable
the tagging protocol. But rather, it helps you implement a tagging
protocol when the hardware does not want to cooperate. So I don't see
how it would have helped you in your goal (whatever that is), and why
mention it.

tag_8021q exists because it is my goal for DSA_TAG_PROTO_NONE to
eventually disappear. The trend is for drivers to be converted from
DSA_TAG_PROTO_NONE to something else (like DSA_TAG_PROTO_VSC73XX_8021Q),
not the other way around. It's a strong usability concern to not be able
to ping through the port net devices.

At the very least we need consensus among the current DSA maintainers
that accepting 'none' as an alternative tagging protocol is acceptable.

