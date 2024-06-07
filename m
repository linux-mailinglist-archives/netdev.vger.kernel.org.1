Return-Path: <netdev+bounces-101791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B7900178
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90561F2321F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553FE1862AC;
	Fri,  7 Jun 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFZVGfkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487014F9C9;
	Fri,  7 Jun 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758205; cv=none; b=cQBPZr2uF+h4XeQZKyO460ewIMVfWtb7gSXpOWOkJNMMzJSTyyeD0n14808LYV1OOGNIH9mps8U4vnn13VdHKf2p0JNKouKpS0JSk2cvST2GS2wkbBiHs8jjvkQFZNcn1DJP27SG0lFlkeBGHNXcT/cc8r3ALRlcXC7xxO8KMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758205; c=relaxed/simple;
	bh=8nw5+9QSvd75ODQl6YA/tY9wEOPBMobwqxnZqMlfGis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQlcrMrE0fcMfQixnTlLx0h2apN/tkFyiwwyc6aUA10qmCAfHEPV+HiayIjXFJ2OjzFGYDqIuezvsV9Auhy+Nxu5LxK986NHS7kT5bsIkRCZTpbba4I6ZTkMnK3j6Bp3jeZtH0qgSIzPQ6rJfcFvth2kBLvE2jt+9BC+7bOQckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFZVGfkL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68b54577aaso255928566b.3;
        Fri, 07 Jun 2024 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717758202; x=1718363002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+86wNrn4HfmmxGyr0WWPH87gKM8bg6dMGDirFSvqGQ=;
        b=eFZVGfkLjsVO+SanAeCf9+MN1dv+1Yhrc/dVzQ0Ygd0U8hQghO5LBxobnLeFzmbDyp
         RKdNKDB4G2qp2Ghu4B/zSCD2PR7NCpgMDvCd6+UetBy/GzXaOvzxk/zwbjWIJaOjXx2K
         2/TPuAF6nI9PBL5FSWue5NtRph8AuBPWWp3YLW1DS2UUJtpZlX8XsZ6Se7qEYQjxMV3U
         ocRiPhA2c//Y3MBLaK9EvPxYb58VWN0XjFG4qV8AazDoZNpZsBbXqZvVZYcpY85IwfV3
         6pseFWgvamFlXWBE/yUmxDKJdfVp9An4uY23n7LaxvkTmxvYtHf6Ra0oKh7BjzTMrg78
         fG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758202; x=1718363002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+86wNrn4HfmmxGyr0WWPH87gKM8bg6dMGDirFSvqGQ=;
        b=LPJeNbITW8REZfXLQHZkWJrqnpqz01noILxBn3n12RQyuJu4oK24imVf6ILtK4SqLD
         TEU1e8wEbBDE+cUWDzRM0a3p6SIb5mEjC9Gv0dpvREbjK/MITecSc1B/i2s32/Qmk0rB
         kGqu5qRyX0WUHxn6Ukv7hHesUQ6Jgjw36B/5m96h13vbRGzMtyX7TYRkP/xIAMUhJ1S6
         jo+xZxqIl5bMwgiKTj7uHW/fT7qA7LYSBixT0CIM77BtZickw9WevdrVvpjkxxJN+q1i
         QzKqd96oDDuJXX7zN+Ps3xLA6Fs7Ia57IUAkkgmuObKPIDRZiqJZBjrwqlXGli0nQmRS
         qKHg==
X-Forwarded-Encrypted: i=1; AJvYcCUz0jfwKx13aV6wAZVHqevH1zp0k8WPC/S/XCLqUCZFBWvN1KUxLngEi2NBtBea7JpbHI+gvVMsZqDY+kbrF6fQ2juc6KLNYB0cIvih57D1Ek2HqLlAAhvmDqf3PjSZZrH95ck8+nD9nMf8GIuqy0zkczu7edOKK9NKnn4JwyQc1A==
X-Gm-Message-State: AOJu0Yziq0PSos0jKRUvus14VjFcrBz/z6bS8GPjG936n3+eNun99AZ9
	OkBVhscX5uYUjwn4XnYCfrn3iKfXA5YreGAyotbNeDlV3h9onEUY
X-Google-Smtp-Source: AGHT+IH3/WlA2+Ku0SBN45ZdbPjdWwdhtqhWDCqJW88WoCxPrg6Ehh5A+2AcrjeIKVwaX7V1QKW8Hw==
X-Received: by 2002:a17:906:7f16:b0:a68:8a2b:6e5b with SMTP id a640c23a62f3a-a6cdb000b03mr157480266b.58.1717758201768;
        Fri, 07 Jun 2024 04:03:21 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805cbca9sm229440066b.65.2024.06.07.04.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:03:21 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:03:18 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/13] net: dsa: lantiq_gswip: Only allow
 phy-mode = "internal" on the CPU port
Message-ID: <20240607110318.jujco3liryl7om3v@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-3-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-3-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:23AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Add the CPU port to gswip_xrx200_phylink_get_caps() and
> gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal bus,
> so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

This is for the case where those CPU port device tree properties are
present, right? In the device trees in current circulation they are not,
and DSA skips phylink registration.

