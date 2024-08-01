Return-Path: <netdev+bounces-115055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B924944FDA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB90A1F26605
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC8013C9AF;
	Thu,  1 Aug 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTjEQH3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4231384BF;
	Thu,  1 Aug 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528151; cv=none; b=i8W/3M/1Oi58YZu2xXALd0I2xDTDWUs0q+t55F7AFqqZMBab48r2Vjzg4Xr/RgidC4nbNmAli5gGtVWDPhmszCH67BJT0xH/QToa4fYIrRkkkUQtiZ5yVEQCa4VztiuoNhKy4ntqs6EURQUFZCcHBnmhovFL4fvqsMrAYfkrGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528151; c=relaxed/simple;
	bh=JbM0mobM8XPHWJlV+GkhV0iKaT4Ass7pcwi0VX4eFCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1ghO1wuFQlQ25zxgWsIVI0jlAzoM7S3wSPGc8YFetq4EICoGgHIYDyRygwKUVZ/Jo3jXdIVSUwp7nnost4KwOH/LgU+0+zZfuyBtufoq42zGPtxzkpc8hFZjCvPyGydAlRN49e/7UfLKCSOcSY5bw1tN9Nitp2Df9qm6dWmD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTjEQH3o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428119da952so45712415e9.0;
        Thu, 01 Aug 2024 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528148; x=1723132948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbM0mobM8XPHWJlV+GkhV0iKaT4Ass7pcwi0VX4eFCk=;
        b=TTjEQH3oP5Ofohgx2AAiEcGfxH/TscCMGbQuTiHVNA6g+N6r3GHeeaLnHQolfNA/lf
         IRd7S5UuDRNnGrBXEE3ADyRlU4IhD2hyOSUHVH0ENNaYBlpWWYUmAXV7XzYNvUqoSHPz
         KKiCCX2KWjLrG3zD5jVPbSVzXfSdbIZeI7oHVfwRK+WpJBfAArH35XehgARGmAICGD9G
         qsS2Knjgo8ugeKsaEUETTXd6b+6DRkbfuMv1jDYDtNKgCmQfbRI+TcDz0AAho7YU6+BH
         rQYKZm9W+Fr0aevJ15ZWzWcY216vRRQ5Ggq/0HadTvj2LAwfFr6BkYxc56H4TBsTX1dT
         bXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528148; x=1723132948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbM0mobM8XPHWJlV+GkhV0iKaT4Ass7pcwi0VX4eFCk=;
        b=IjRZMBAMKlzTsIykUTxeGpIzHFTRgFjtDrp6+YictZOEwnXl/11up2DbwBACvyq5dt
         2CsM+/3K5Fi+aasjsM0bPLQP+n4QcC81g3Ah/QiP1W2gX7F3pToAQRp590I8wHbM0+xj
         Z6KfFLMaGKDv39Nc4+F2D3cZy83ynE0hXLGYpgmjTw/b6l6b6X17nsF502k7ebQFUn5N
         UWS+Ne5pFL0MW222deHBe26CQHLkDfO2+FvbkxmvyOaL/liuwtB/8bbSRS6dfJzvZUfH
         evyFjZg5KCtIk+bE7J7LoEQyZ4btkwIGvSOskrN9V3jbyxyabKl7O4uPYrkn+ZU4SXV3
         6FTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+aeoykduDv24N8PSFQPdShXKIa7PNXUpAjtsWvMdJ47DAOyYNPj+ietXD6+3K9Ngg3GPdwLdbpw6OXK/P+wWFqMx6BHjk4pjO5hMdBHI9SQ1bmgq/7JITVntLgFmJe2wILcGG
X-Gm-Message-State: AOJu0YxfQnevL5+TOoGyXcibCBpmrh9es2hHNruziizOG8rsU+sms4WH
	ruBXDb6f7NT0Xvg7cXqbpPCf5LtFbNo1qWazjt724a3hezUMCk4W
X-Google-Smtp-Source: AGHT+IEWV66ZYrus0W1ET1gIeNLur6+QGxyXdCNjV0dIiQyEy2PYiogbwno7MlX6tYQEIb9prjLr2w==
X-Received: by 2002:a05:600c:4e8e:b0:426:654e:16d0 with SMTP id 5b1f17b1804b1-428e6a60397mr3059625e9.0.1722528147540;
        Thu, 01 Aug 2024 09:02:27 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36800cdasm20140304f8f.64.2024.08.01.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:02:26 -0700 (PDT)
Date: Thu, 1 Aug 2024 19:02:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 0/5] net: stmmac: FPE via ethtool + tc
Message-ID: <20240801160224.4f54tanxs5dz5hwq@skbuf>
References: <cover.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722421644.git.0x1207@gmail.com>

Hi Furong,

On Wed, Jul 31, 2024 at 06:43:11PM +0800, Furong Xu wrote:
> Move the Frame Preemption(FPE) over to the new standard API which uses
> ethtool-mm/tc-mqprio/tc-taprio.

Thanks for working on this! I will review it soon.

On the DWMAC 5.10a that you've tested, were other patches also necessary?
What is the status of the kselftest? Does it pass? Can you post its
output as part of the cover letter?

