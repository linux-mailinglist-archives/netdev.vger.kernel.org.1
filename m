Return-Path: <netdev+bounces-194571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B6ACAB7C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 11:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2DF189BB6D
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8E1DF728;
	Mon,  2 Jun 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh11yP2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F45A920;
	Mon,  2 Jun 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857055; cv=none; b=LMJ1U0qpwkrGDFqwcuiJGXbCDUjPxwH1Se6kJt1t7UWDRrEJBEB4ip6DZdVyFtTvAEajrp6v2QJ3BgXd2Y6geg7glGwhpB2xIm2xcCwn3Mx804QT19Dtp5txMa6NJpcsMGEY0VIXVLsP0guogkayrq8t/L0M4aJ3IMpmi4O4uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857055; c=relaxed/simple;
	bh=gX6orxA/UV2aY4E8x3UQLkcLWz2Od09M6861ebakXig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewPiqHr4nuEW7KwU4GJEafyP+g7nk+Z2q+Ie9hsZ3Z+OcJg8sMkA0W7yJbhF0pC9c6rU+HngxC2HTyaI7Cx+XhdPLU1RMYUepQ6OZFo/4sWIFAQ6Rl9QpYRFnpnH0WzoWIHZovIc819037mOZ85sgwv3/vSD4UPKYGjiQuIAgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh11yP2J; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad56886dd60so31415266b.2;
        Mon, 02 Jun 2025 02:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748857052; x=1749461852; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQxylw/p29sFR7A8ErN4cGXAefnIZYceNaxZSz3yM0U=;
        b=hh11yP2JslFx8qWzKLcEztwVSz/jmMJrN3jJazDOeqk6ayGktFlHXWGJkz0P1upFBI
         n0DjxVjkm2DJadxzVScTsRDZkp4a8eTiDj+I6QYtMgcFpJOjFhH7U0pzlhOlIbwOC9EA
         amZX/etDe9c54JFin7UC4wXYR4ggeZyl1n7RTXRqL9En1Ofqmos+EkHRLixtYtrc1j0b
         jtkpnaofca1PxIqqfW6/xiSES0bKFEkplGtjZOpWItrpOIR9Not2IbExbEwRPnMjD0ff
         pyvMo6Anppopqhms3v6gJldmkHSHtV86m4RQ9ySuBXOrO3p2FOf55R4Dzwe6ylTWCghZ
         Z4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748857052; x=1749461852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQxylw/p29sFR7A8ErN4cGXAefnIZYceNaxZSz3yM0U=;
        b=rjOaCaAmtYOR6WPrHYuw8XjN8RqFE+VWEtokUut3jQbK8DrVzKSLzvu/sNuJfkOS9Z
         ybomjrd3TlM6YNBD0ATv1VQfd2VJ4AY7Uvnwf68gEbxzupPVxdvjtGY1LPCeLnccitWC
         m3mXG27+CA8cxOqcciJqkGvxcpolz/TiP4LxQe5QeDlXyyr1L1NjcuH4anGI1NDU469i
         H5F6d4aLvrttMdR4/G1dwNMuDPXqAnp8KE07X4UnUPE+wyYk0+ztkYfikmrK/ILVZikF
         t8hjb7OwbLQ1M97F3mVZZP8cZQyVMCnRddCzU6VHcDZd5esuREu0C2VYJNanE713d5k7
         SA8A==
X-Forwarded-Encrypted: i=1; AJvYcCXkJ3Mz1T3TIalNxjuEkFI9Rb56+yAD7c4byDtxIkkbQ6WC08TpilerEQb4LHkClumvHOizx+s5@vger.kernel.org, AJvYcCXxepXhHubPKYzQ35XI2NoLefkZzN56KoEv9GmDkd3o0lZwjIwDRXfzjfXEd3XjEHQNAmJnqlmJ4+I+prI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwgOaqzr1+a6KvbKUe2EMV94JpJrJzKTUGqemy1PiOR4FfS3x
	Y6Yg+piI7pxuTq4VhkaGTfRHKNt8+X3QENLSNWDnV+HkootUBzx5kGoEsSYQ5A==
X-Gm-Gg: ASbGncs0ENUm7BBQXUmCyy8woGEmjE9YiM56xDsqh6QA6E4gUGUS9gGg9EWSG3VW78C
	lJf1VNx24+6x0OlEshnvJ6DZga7DWTHmtYDRCtGAmy/iUWjOvJOhL3qpbwuFAYklgxyXNm/dweZ
	lbId4v5uA1H3vWPzxF3m2lKxxm+J79N9z7FMfq3FILCI2ayjZ2tPdJPt+A0TuidVClDiPSPelEf
	DY4bIYsbJNKeDXLjYHjaJOefvLrWn7b/BmOm6FaEXArwOyAJaa8m4yJQ13claq8iyY+na/qzALQ
	GTj/eIXQzknEptKte9vm5YeHa6xlad/RVYd9GLI=
X-Google-Smtp-Source: AGHT+IGG0NkXu0xcD5YRrx3VhPk05FgiykGfWfJ7sprXcYrUMKcrHTugQt+PqRMDOtNYTBVte+DR7w==
X-Received: by 2002:a17:907:9810:b0:ad8:90db:8012 with SMTP id a640c23a62f3a-adb369989f2mr375721566b.0.1748857051933;
        Mon, 02 Jun 2025 02:37:31 -0700 (PDT)
Received: from skbuf ([86.127.125.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad696d1sm765610166b.161.2025.06.02.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:37:30 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:37:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Subject: Re: [RFC PATCH 02/10] net: dsa: b53: prevent FAST_AGE access on
 BCM5325
Message-ID: <20250602093728.qp7gczoykrown34k@skbuf>
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-3-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250531101308.155757-3-noltari@gmail.com>

Hello,

On Sat, May 31, 2025 at 12:13:00PM +0200, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
> writing them.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---

How about implementing a "slow age" procedure instead? Walk through the
FDB, and delete the dynamically learned entries for the port?

Address aging is important for STP state transitions.

