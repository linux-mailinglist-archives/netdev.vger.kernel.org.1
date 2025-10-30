Return-Path: <netdev+bounces-234248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A81C1E1CC
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DD5334D791
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F0E2900A8;
	Thu, 30 Oct 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6FJIXFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61926FDAC
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790648; cv=none; b=U86VwGQwMxjNvM1wKWQ9v3R/jomXPxz8OiCKMNGg6JC0/qjlekVP6giqEfYIwgay08BwKmDAbcl5rXQBmfaqiHeB/o+PD6zG1fUUl/lWGKAcskty8or1J2UfS9yxMGn9xnMMFgQa/PxY54Q6k2NO/Vdj6GHZwEgV4m1jnx4BHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790648; c=relaxed/simple;
	bh=/6c2y9ANIF87FTRVL8fxIK1dv+k5hC5UX09DmPr/LGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk9DuyYwM+Av42MUZmrdDbYrrUrEdWS0khFvgkV+yjMu5nwq2qvkZoU3Z5U3J+D5Q5i3okNTnJvwkd/KQcShNp9TPLaNy2/czLcjm55XqNKtVlXlEmOo3tGbIsurxzlnzAQLaNJwzxYEdoqfDRboA9uqguPhpfOjbDzYqiMp4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6FJIXFw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a26b9a936aso438585b3a.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761790646; x=1762395446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0iJfSZcYi4d+4cBtPvkDIcUkSGuJygcNQUXASJtpao=;
        b=S6FJIXFwclFDvNaBh4b5+X3vuZJOLQRiS0e73mhMzWcH1/D3Sk067XNHK8qJocSeeI
         EfOXWG9PODFZ22aQOrBEoKFjpP3PUqZMfREyA3YHuDWCeTY8UR2Ln+rK8U5hOludMd6S
         OnDGJg4MqTpOXl4rOU3brmCEHgkA0FhPlbSSJSv9QNhMoFuG4VZAs1szcq9d7wYGFt4h
         mcXnXROxqeIRYfVf9nmwjLZfAhVlqb6YBdm1txsMBjpgcfaXzilQtEsjVufQyhrJ37AV
         VsuzKWNRN81XdPhC4ug5UsgIP8+Pu2RWSruY49i/XkQECgNmI3lLRNhdgKDtOQfO7GDU
         Z+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761790646; x=1762395446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0iJfSZcYi4d+4cBtPvkDIcUkSGuJygcNQUXASJtpao=;
        b=aZ7lwzAZRFLYNc85vO5tzm0TNlFU5NquD+VojsmlSKFTKWkGOEmfJWDyqiQvLUi1RU
         nD92CrPBcCt8vkapyrEPqnaH/BrfReyRzlAYeSyEJqF97qSqX5ySVZ39cFTgyfB/KEAn
         buQ6qLatkIBpqpDyh626EqVipBwMU/0tbnuFthBCNeKGmxDB+bDRxeiINjhZedWOItxs
         NFsiOEKzKTST9fLmHIlClUL+P8rZ9OeV/R6qYCQwkVr1fzjivfpAd4GdcmATZ5N9RcVL
         a2EwfXf1cpGMDEoGbY31S8pL2JqvP0oBMfg9XUBM1W5iJJnkMlzaCmU2KHjUmnMs521S
         +NcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvHATiRtWbSIm44V8H4Jvn7b+rPwXv8uXb+Y27HbmuzMOFXx3M9RfUVeTCTRAQSSu+n0pNbio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDylfLZf+du5E+kmRcLA9Z15nA0J4Ombm98zYx1FIp8kuKmI/Z
	v2sE2qgfy2Kigoebupys7TgqHkqiYQ0v4w6T3uacOfiWD91NuWf6Xoz2
X-Gm-Gg: ASbGncu63/psqJ70kcHeO3ED+1AtUL6+AFfe0MuxROj9iLOjkIoqSUeT5oc73vVAfSI
	XV8q4GBuDxS0+Xhqsk0oTy6aW3CM9Lw1pyf35rC+Zw//3/eDaybF1nKwLKPj8CDOhdQ3U4MPD+R
	7BI8bZcex7Tia1H+a5/cvejfgqeIBnvDWP0Y/ANGpuKfel0L4CPwMWACheaDjKJhE1rozWVMU8a
	SzYxy5HbxOCeTTqN69HbAiy7OZk4bsEvxn+5R8VAs1XjSMIehSb2s2mKb/jw7HXwE6GaopI52Iu
	FN0QxWVe65EqMRH8fP9I3oqq6ujKLgwrYOA3RgJU8Ilk8bcGSU8gHqDcI4weT3oQnzUFvYgqv93
	dodgKc6xkDNNKiDsigH6PEKO9sMIHbv4J+xWuG1aKXcbI3okD9XDmX0Har5UNJzCo6qW/hragnb
	/VFhEK28DbLw==
X-Google-Smtp-Source: AGHT+IGZqbW0+/S17J6RDbXZnRIU8hSK1Dmm2Um3L8P8CRvPomF8j94cwh/RTW/K/MdMyX0p0nhaJA==
X-Received: by 2002:a05:6a20:734a:b0:334:97a7:8357 with SMTP id adf61e73a8af0-34787d7d88amr2092916637.60.1761790646348;
        Wed, 29 Oct 2025 19:17:26 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712791576dsm14913433a12.12.2025.10.29.19.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 19:17:26 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:17:17 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction
Message-ID: <td7eseq6rmc3s2ecvcjyyyn5feawjmugzb4ihjyviquro7dv44@3dosfqam6h7h>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-2-inochiama@gmail.com>
 <20251028-parka-proud-265e5b342b8e@spud>
 <rclupbdjyk67fee2lgf74k6tkf7mnjcxzwcjvyk2bohgpetqt5@toxvy3m5orm2>
 <20251029-fading-expulsion-f0911c28d23d@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-fading-expulsion-f0911c28d23d@spud>

On Wed, Oct 29, 2025 at 05:54:49PM +0000, Conor Dooley wrote:
> On Wed, Oct 29, 2025 at 08:56:09AM +0800, Inochi Amaoto wrote:
> > On Tue, Oct 28, 2025 at 07:22:37PM +0000, Conor Dooley wrote:
> > > On Tue, Oct 28, 2025 at 08:38:56AM +0800, Inochi Amaoto wrote:
> > > > As the ethernet controller of SG2044 and SG2042 only supports
> > > > RGMII phy. Add phy-mode property to restrict the value.
> > > > 
> > > > Also, since SG2042 has internal rx delay in its mac, make
> > > > only "rgmii-txid" and "rgmii-id" valid for phy-mode.
> > > 
> > > Should this have a fixes tag?
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > 
> > Although I add a fixes tag to the driver, I am not sure whether the
> > binding requires it. But if it is required, I think it should be
> 
> Kinda depends for bindings, amending a binding for completeness probably
> doesn't need one but amending it to actually permit a functional
> configuration does. This is somewhere in-between I suppose. If a driver
> change is coming along with it which is likely to be backported, that'd
> be a vote in favour of a fixes tag here too, so that the binding and
> driver match in stable.
> 

Thank you. It is helpful for me. And in this case, it is suitable
to add this fixes tag.

Regards,
Inochi

