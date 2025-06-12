Return-Path: <netdev+bounces-196858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D6AD6B6E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99313189BDA2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C097213E78;
	Thu, 12 Jun 2025 08:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD21E9B19
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718401; cv=none; b=Rwe16VcuRkluPrKSE05USDuGSBfJ8zWAN4wDMZ0Nir/DPK4LzO3glA1khdicrjMsvjJ0OyhKOdUzsqjkMXmfFfuJtXFhjbToy7tJtReGrUA4rOLTJIWtWqFznpYLsnRFtJstv6ELg5BZjI+n5JF7iuaKgii032bgg2gLayzdVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718401; c=relaxed/simple;
	bh=WxKr+Z/QJuSBRjFCvUCizSaES/2hJrrojfpmhNwGEFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwmpdk99GP5/U3mFWKK30uy3YtGQAj7qeJdG6f8Anbps5A+ObT+eGR0wojdYl0+Ip5bFoqm8MqvtgUhxY0BTJVSHgdHFwxbaKT8qig4ZkMIsMXXTCHDFwqmBqQd9qD50CBycfED5Cp/YuI3MNf9nKFu1aS1RZYDRBabxShbXkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60727e46168so1351382a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 01:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749718397; x=1750323197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9BRQ15OKOHKXtMKvoZZsftmymCF7lN8ZrgpGO4hGEM=;
        b=hz3h4bpUPKYP30ys+ezNjHAhHP8KnS2xvBSjxDJSK/b0tG7VsAKN5fojsaFQ7e3iPU
         hLQJYpGGXp9TKh9atbW4RFZdgHxdwCt2QYopKCKrkOCSfXEwhiHbbeYsyL6nCUnyyWhc
         QGg0xqW2Wc9/r6VAqg9Oou9h5FAzz5jS3eFBsvNLLnHjlH6ZuzeBlvEIzYt50qO1gyWO
         misPD6OHetJxVrKbJx+jNXIjKdarIfGhwee0zTrNAaUxneEYLHrR8MqW/1c3X4pjFIBY
         VifzjcH9r6/NXk+WacNBWs3DWMa17ZYnHdgSSOuYoMcdJrllON2QwtGJLVXoGL72njj0
         Xnbg==
X-Forwarded-Encrypted: i=1; AJvYcCUlhy9/zSEi7cy2ECoK+3xc5tLV47QNMNPb10V4E2l/ujKxRIHK3vRbSj7ksWnO6qyJAufYSqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkn6VRjAVPhhcmOXrReymNS1/2UHkepGnGaPmj46ilGA9I0dpj
	MSfs0foKPk6hoPTd9HcoZz1rl/JA4aFZ0FV+UBPOknfOD3dwc1xIDc7eh5XYcQ==
X-Gm-Gg: ASbGnctlnaH7L5sl5tvkrKB2A/5OacsKkHOsLZc7wW2sWL8DDunxY4ukILwKiiwM1va
	mnBLqA3R9dwLcbAAmmRXIsWgZAwObkTmZAK07lQkBoYecusFYQamTbooMbIBu8NS5gmEst11AP1
	LItMyu5I+fQFD7kGqJaboMc/vmHPKMLk8T45zvQT3WScyHZ5+3E1Emt20O49oYc9UVlpvzZgiCT
	Xvv/YYtuKIZQRbqVofJnraB8X6hu6DTSYmthMRPLzoPBxlPP3r518lr4rRd3KqqcL6reXrqHWlc
	sisnwrB9nFDnxM1QapeOdjTf9PMx60bF7s2lhDsBx7lLjF1o6Wq+
X-Google-Smtp-Source: AGHT+IF1E1bVNewhH+RFD0+fb5CPNLGeBooDCsz4uVeR7JxnCDwI55vapl2yzGpOaFQkOrb11zNo8g==
X-Received: by 2002:a17:906:99c4:b0:ade:76d0:fd9c with SMTP id a640c23a62f3a-adea2e348b6mr268993166b.3.1749718396574;
        Thu, 12 Jun 2025 01:53:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadb21656sm97767366b.108.2025.06.12.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:53:16 -0700 (PDT)
Date: Thu, 12 Jun 2025 01:53:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk
Subject: Re: [PATCH net] net: drv: netdevsim: don't napi_complete() from
 netpoll
Message-ID: <aEqVefLEgSz9AzHG@gmail.com>
References: <20250611174643.2769263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611174643.2769263-1-kuba@kernel.org>

Hello Jakub,

On Wed, Jun 11, 2025 at 10:46:43AM -0700, Jakub Kicinski wrote:
> netdevsim supports netpoll. Make sure we don't call napi_complete()
> from it, since it may not be scheduled. Breno reports hitting a
> warning in napi_complete_done():
> 
> WARNING: CPU: 14 PID: 104 at net/core/dev.c:6592 napi_complete_done+0x2cc/0x560
>   __napi_poll+0x2d8/0x3a0
>   handle_softirqs+0x1fe/0x710
> 
> This is presumably after netpoll stole the SCHED bit prematurely.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Tested-by: Breno Leitao <leitao@debian.org>

Thanks for the quick fix,
--breno

