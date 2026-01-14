Return-Path: <netdev+bounces-249927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93055D20E1E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42FAB3055736
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249833372D;
	Wed, 14 Jan 2026 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nszmqe99"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2F2D9EDB
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416433; cv=none; b=NwCa5nHGj+EisY9BNcuVVpIRzW5lw5GdK9QvJZxzb2pLfWpN52Vo1/RWIwrdwuKJaLpmmEB1oN83R2lbKVFsRk1XAWd4troDsq2T7j+b2BXMERp18D+nyoY19CrQXHEOFtVslWlr/ajlLmYHmmeMG/8B9Zbe2GoLM+hZSEbI+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416433; c=relaxed/simple;
	bh=jYYx3ICzmguprfORr6CeHewRj/Eyt+HvF6Iy2rZ0UoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFBRzPvD0GbfaScgqBv9vfxW+xzqqm1CWJ3PNZAmq6RqDAhTZE38u6gzHTearwBU/Ia6AhppGoJ8kJsRyiS/h/UkuOzIMOLN20qqqbtzcuUj3qBeuyFksSf6zqfxBqIszNATGHpRzUbLvouGD5NG2I3ubV5/q1V7RDpQ2WbgSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nszmqe99; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b6f22bc77so13375a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768416430; x=1769021230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9ken08GWaBvhZybEJhtrMx7vEhMPkB4XYNJbjZoLig=;
        b=Nszmqe992s5WDkU6CEkfnC2NoO0TjxKUv+BuqCk4VeBinBqML3rJz3/dgIQBr+I0Qx
         fRU+kk4s5sgBaEN2nx+ZIMFtunuiePP97cuPiS71bFCfiI9Q5bN6+HdbqXnrx5/wAtwD
         5hnTUm59zLN+dFSgETkTQDZ0zOmW8yhCjbbk77q4avXNbI1KC9ALigwKLTQk0f8jxwM6
         SIXEsZ52gOLuuqxXXikJm5K86S3Lc0OcIELa1vmnuLw5vfZZRWmEjoaWCwR1x1JOZMCG
         HXOckxkmPfkW/3Qzo3PyOXpEYswwW6EuW8SqAHgDXnfzlolnX1ikyUBPgXIX0QeDx2iW
         TEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768416430; x=1769021230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ken08GWaBvhZybEJhtrMx7vEhMPkB4XYNJbjZoLig=;
        b=jqSqZsGKc8orkulMx3beFmpBJxSGWn04yFTXPMhyd4eW4MzEqfUDme6yWl494y+7aq
         zoudtvQulFqN0aYHxFmuLPfLBl3GQEwJqbKWGfEMTz+BGR61bfz0cvdAC8hjIHNhZsbp
         dIzYnr8VIufw7Om3VREQIAl5SKMFfVQhASP6sBE1q6OmklPVxbiuTQNLj4oP7/mRReH1
         6fizDXT38mHvjYFNgkE4+ouynwcKz9cmvBKjM7nT84lqApEgFMtRdddQpJH+xLiYsRfT
         RjaLwudc8B+79P2+mTu5pdBBgRr2qk3LHplMRVqux3roUTXGWKsg1YhN5SSr9mGloJ/i
         WyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXl0svzfVHboDWqmlAS3YaXxhPbKz7zNg8HmV66foRdKXS5cLXMCEEt3r2cT7+8cbBJAb7WqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwck6OW/BR6wIi1bP4p97P80GajVtCWe1fVQzOkbf2jQH2FTA
	pg31UQBtu8LM3cY55OToMK4+XxTrurWbk9IZ6hxxpyL4kewNcghS7fbl
X-Gm-Gg: AY/fxX5/grVfwAtaln76Fe5Dx//+7dU/bpE051eZvctFksPxolgAiw6J36TLao3U98j
	irUcM0sSJjUTPt6rfPb7ZRx0w4SeSGprS2WqeUCvpJ5mMumiiKGLTeO6RtA9l71XGK9q1XrJgP2
	95p+ReyKlgYOqLjeI8ft1l/+75Gay+2ZDRdoFF8myoQeK1HUuUqz83wVYZiV/048UvNjVHtU4PO
	JpCZmbGb19mIyaTbq1ONpfcqGBnvUsO25iP69jujxHHvZhnOLVW6KUYw+olo9ufbPhK3KVdyLZo
	SoExx5vkofJmgk8ug3warNDIhmiHZ6A1PZtog66FelqO7BRVPwiehg1sd07cuCFhpdpynN+r5mT
	yTV6MghWLKPGeJovhbFoKM7xtoEjI3f7kkTksffMh7/slHP+Uviej7M7CE/l9CjhUqdBfzx+0w1
	F3Keo=
X-Received: by 2002:a05:6402:1ed6:b0:64d:46f:320 with SMTP id 4fb4d7f45d1cf-653ec47b906mr1748710a12.7.1768416429553;
        Wed, 14 Jan 2026 10:47:09 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:9b39:8144:8a26:667e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882043sm327189a12.11.2026.01.14.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:47:08 -0800 (PST)
Date: Wed, 14 Jan 2026 20:47:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 03/14] phy: qcom-sgmii-eth: add .set_mode() and
 .validate() methods
Message-ID: <20260114184705.djvad5phrnfen6wx@skbuf>
References: <aWfWDsCoBc3YRKKo@shell.armlinux.org.uk>
 <aWfWDsCoBc3YRKKo@shell.armlinux.org.uk>
 <E1vg4vs-00000003SFt-1Fje@rmk-PC.armlinux.org.uk>
 <E1vg4vs-00000003SFt-1Fje@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vg4vs-00000003SFt-1Fje@rmk-PC.armlinux.org.uk>
 <E1vg4vs-00000003SFt-1Fje@rmk-PC.armlinux.org.uk>

On Wed, Jan 14, 2026 at 05:45:24PM +0000, Russell King (Oracle) wrote:
> qcom-sgmii-eth is an Ethernet SerDes supporting only Ethernet mode
> using SGMII, 1000BASE-X and 2500BASE-X.
> 
> Add an implementation of the .set_mode() method, which can be used
> instead of or as well as the .set_speed() method. The Ethernet
> interface modes mentioned above all have a fixed data rate, so
> setting the mode is sufficient to fully specify the operating
> parameters.
> 
> Add an implementation of the .validate() method, which will be
> necessary to allow discovery of the SerDes capabilities for platform
> independent SerDes support in the stmmac netowrk driver.

s/netowrk/network/

> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

