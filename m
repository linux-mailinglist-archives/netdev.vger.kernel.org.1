Return-Path: <netdev+bounces-105260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC88910456
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F7E283DC0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EED1AC42E;
	Thu, 20 Jun 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltPSV0vP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577D1A3BD3;
	Thu, 20 Jun 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887376; cv=none; b=dWok0qtHDTJTlh0wNyTSeYDuNN3B943rxlilw55KpKhTlKkRd4Agfh+hbTiDT7JghK4r1/tHjhk6VRnqXkx9O/fyhbRVlB0qiyKQBVfDOd+RUBkflk0EJooh5VMZY9ItNXjyB2lxfMM6RF6/MUUuO36k6KDNtuyTGRt6hNElkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887376; c=relaxed/simple;
	bh=t0N0y1oyMCqLW+dEihhN/P9vSMFe/yHw3LDE08eebjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI7wXZZNcMs0o2DNieZmvJCxBA6yeNBV512pa8EDYFYQBOdBEwH3pYDFSAlMOMh9xYrPfchmIHBVl+TY2pEvFI1rLBX8NswZZ0fGExdc3UHoyDQu/e+T/bB3xb2nuBWbDZ87rxFWhMLYKZZvlqz52l0Am1YpHSNp3wJHtSf8SPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltPSV0vP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so735108a12.1;
        Thu, 20 Jun 2024 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718887373; x=1719492173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxevQl3D3HQJVJYA8M08gtV0nH43iXT7TwT6tdCH50I=;
        b=ltPSV0vPVhhf60XGwZ+DLgjDCYAcA+ZE8Vjxnjer3L3QrSZX/DbiKBuaK3P/iegevZ
         BilfvBz7fsfFnEIP/rdGPtRP03Z6p7FUoNthCAP0KGHt+zRGoITyIkZR8f4r1nbu7+ZM
         vXrag1ycQ4AgH4Bvx+u+u4+FPK6j37g5NwiZEmdwrfRbnIiuTgxLxIf5mhKQO9dwxQeg
         7BL1/AUtvmX0sdVROYEelaFMViDO0lJdjhVSnxQT1X7zlmLJNOqW+MAQlC/b0yFSGP8m
         U9vZ6xSuFW0qvPQJme/ara0KR5QMRyknSleBQdDjbb3h8FM+PxfdYAa/zFEEso3zzPx5
         6RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718887373; x=1719492173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxevQl3D3HQJVJYA8M08gtV0nH43iXT7TwT6tdCH50I=;
        b=IJEp5XbvQgVrtuJi7LaLT/Usd24eFRRJ2/PEQ1BBRuT/8GEWtQBs7gRhekI7htzxBc
         gXxdBsNdy42OYs/I9J1AQn1aTWib1uqMM/wTsjoVZKj37CVGpgmkiyCtG2BXrQNLOhXT
         0DzgsP/9xJhM/1FJfPg6Ye5jMEgIA0WyeQlpBVsHEChuHdtjTDz45nyYFbK/EeYHL/kc
         4Os6jVCfQU1HtnOLz3QFpxpbYLQrjK9SwFHCX0T3uu7Ueq/zhXQ3cdEsGhA8EjwyxedG
         O8q4E9wpHHZJBZ8dlZMtN7DcVMoPFeEqSDvhi4rynk0yiyEmvI9bXwEyaaMvIhKoIh1Q
         6rQw==
X-Forwarded-Encrypted: i=1; AJvYcCVRE2RGTHjGFmnFERNQoRqSd8O848gEOOoQ7zIC2RfYh4oiwbOD5SOrtWLMvJN4s8aL9yXyDveIIWU907v8M2G9WGLpVTikzffp2Je0
X-Gm-Message-State: AOJu0YxLs/3xHQyJGmh8Fxh+G4ezx4rlQd+KfQ9TUi+y76nF1g8sowDw
	CCnfzRSPGC/xyj03qw/VUye0g0o5EZ+juimdksqzUXxHa/mEeN1I
X-Google-Smtp-Source: AGHT+IFPwUYApRAep3mSwNWa7q4K5yr8wWihprCuHwrSAm2DVmZPRJnA7uHt/dZjOu4JMg/4WnHJnQ==
X-Received: by 2002:a50:d543:0:b0:57c:6b68:3bb1 with SMTP id 4fb4d7f45d1cf-57d07ec6774mr3102092a12.42.1718887372881;
        Thu, 20 Jun 2024 05:42:52 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdfd0sm9667958a12.5.2024.06.20.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:42:52 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:42:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/12] net: dsa: vsc73xx: Add bridge support
Message-ID: <20240620124249.emsveiu4ydsdvxpx@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-12-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-12-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:17PM +0200, Pawel Dembicki wrote:
> This patch adds bridge support for vsc73xx driver.
> 
> Vsc73xx require minimal operations and generic
> dsa_tag_8021q_bridge_* api is sufficient.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v2, v1:
>   - Use generic functions instead unnecessary intermediary shims
> ---

Maybe you could add a small comment to the commit message that the
forwarding matrix is taken care of by vsc73xx_port_stp_state_set() ->
vsc73xx_refresh_fwd_map(), which is called immediately after
.port_bridge_join() and .port_bridge_leave().

