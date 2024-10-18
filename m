Return-Path: <netdev+bounces-136797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 932379A3219
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF38B21049
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B6339FF3;
	Fri, 18 Oct 2024 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdYimDv2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE032D7BF;
	Fri, 18 Oct 2024 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215219; cv=none; b=STwQ1hV1sncQ9up22XgN1CJ7Lb18qgpwIWwEDpNBxhqEoVnCYV80GC8pA1LIkbfmoliaB61OIJvdJh6YPM2M92vIjkP5ke+eA21a/j2WH9m02V2oAl1qe61dsJinvqjaT7ckNCxoip5geXrF5tOJjRhipa22XSvvN8aM09sLbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215219; c=relaxed/simple;
	bh=rInZeqsc+QKcQvmhgxE/TrcN5V0/e6lEkt9pIC856T8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rf8qFO2xeG2RnVH27pc487YRQe6aK3LrYAhkbiGgd8GwnxN19RC3IiCxFWCTDSxQKjBhZ6SbsHZnte/u1bXdIPqNmWpGQrpoxhHYVOTjaRuxxdDIYQekWoG+Uxh/8sDJeB4QLYkQwUKumJLjEp0Ylrudl7q7BqxKczzAJak8YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdYimDv2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c714cd9c8so16603555ad.0;
        Thu, 17 Oct 2024 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729215217; x=1729820017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVBdQDKACdOFfREB0q18lZeDtV7666msm3xj7bJP8BA=;
        b=MdYimDv2EjvHbWnw/QdoiimAmvQCazFEmDfM9J+A2PspenBwvMrUnF69WcqdwHDQNi
         xsQE36OEUnNw0ViBa9UVgLgBbcwHfr5itVqBNQ+CFYWsoK7zD6c/TIDFt67G21wH+QyF
         EcloRuUAF7NUmZU0CCa9aLxa98qek1mVxxQMRsdo2HjfoU6yw6YhD7vjlOA9hZ0qTNxE
         5VzX+m/cxLD0QT+SR47zl59uW6EGOp9cvte1RQZjCfh32r7mIZnk5XEXbHRilGxH1CMJ
         oQlMENxyZJb86hvd0EEtH6o10CQ9Mq92+sRdlSOv4tjSRUQrVN57mFkyOjqo4mpxuWMI
         MOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729215217; x=1729820017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVBdQDKACdOFfREB0q18lZeDtV7666msm3xj7bJP8BA=;
        b=lJKOTq9E5PBjU/wtHevTjzGaZUj1qn/Gh11HC+ElE1BD23q/kfeF0ZaUF9w6zAw03Q
         x4eus0dgj+fDmOJKF1GZZN1OQ7vKbuxK4CQkMpywe7qkCYrfV5jv7nCUJ1VFtKetS9Bd
         PtDCjdEYonUs6r8KpKOsnosXmpMvlHbeVK3A0CMepvXFNPDGQ6ltufxGlxo+4P9z97tC
         zTyOpEpXECQ2OJZO//vH8UeA44V3CfV6yS5XCXR1PC+SuAXNmQzLTAzcKmE8YPLZfVtU
         TwyAd1iYwLimqserIcPSj6STvmhRBUWxCoZDlExDYNXX7XfmmUItS6skYsFzXbBkEuc7
         iqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTP4fQRBDDb0yZ9vNydukqr/hBEzLwTPQZxetZeq1FBqD5jgYUg4GipyRty1BN5aEa0lr23hFy@vger.kernel.org, AJvYcCVmciF58E1LBHUrRZb7+mCj/tk1LZ9Uq0pQhYw3xwmaBx/uJpsaxtcgqNuBRi5ztqHWc0wGAsfciI6OWyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbvI8YBlCEkSFoNLiybMqfv6EYjUlKixA9YsYpLU2Q3IpX9Qn
	uQstv3cZZbvWdCL7P7dFp3t1XWebmxcntRZgrvkp6UgRMyzvYxmD
X-Google-Smtp-Source: AGHT+IFC6olARW/9uK6g5ucZbqkJMfH64yjeQl8CUkL2mnBdWfULzMNx7BQa28+IWGBvzpdDoonfVQ==
X-Received: by 2002:a17:902:d2c1:b0:20b:6d82:acb with SMTP id d9443c01a7336-20e5a8cd3eamr14787525ad.23.1729215217024;
        Thu, 17 Oct 2024 18:33:37 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a9136e7sm2583595ad.284.2024.10.17.18.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:33:36 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:33:27 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com
Subject: Re: [PATCH net-next v1 0/5] net: stmmac: Refactor FPE as a separate
 module
Message-ID: <20241018093327.00006966@gmail.com>
In-Reply-To: <20241017170652.jtg2abm532sp4uah@skbuf>
References: <cover.1728980110.git.0x1207@gmail.com>
	<20241017170652.jtg2abm532sp4uah@skbuf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On Thu, 17 Oct 2024 20:06:52 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:

> Sergey Syomin is the one who originally requested the splitting of FPE
> into a separate module.
> https://lore.kernel.org/netdev/max7qd6eafatuse22ymmbfhumrctvf2lenwzhn6sxsm5ugebh6@udblqrtlblbf/
> 
> I guess you could CC him on next patch revisions, maybe he can take a
> look and see if it is what he had in mind. I don't care so much about
> internal stmmac organization stuff.

Actually, I sent a patchset to move common code for FPE into a separate
FPE module before he suggested to do that, and you gave me valueable
comments in that patchset ;)
https://lore.kernel.org/netdev/20240806125524.00005f51@gmail.com/

It will be nice to CC him and listen from him.

