Return-Path: <netdev+bounces-219235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DCDB409D2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7669A5E2B2E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8E32779E;
	Tue,  2 Sep 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUJbi1kx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF55304BD5;
	Tue,  2 Sep 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828483; cv=none; b=Xz/667u9x2iGQ4Kjl1IpjhSjN4MM8QgO2/vZBF/XbF7wNJCC208DZrXzK35OPFP0KCde3PL1TsmhMSx2R+bxyTft8s9leN6YYZ9h9neHIqvckAQQB21MNGnppraKk1UcQsZCUVZUFTaarTSTHkLy9oMh03Vo6mj14zlszlfAC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828483; c=relaxed/simple;
	bh=Sj49yptOGdMuncakRHPEyJmJFvq+NN2TNWU/jd+Hr8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEnXEd4UoebhLzxQw1o7ztC/4b/WJBniSkss2L7ydy/eiMnnzZxh/YCICSmIT3GTMExTRktmtxY9nH8btPoPwYePIjN189bVvyBR3BjQdV8LmkE2UUO09UTPp7s4ecTeMW7dfBCwn5RciB290E4+P/QhZXJIyRW/Bgl4IcqICmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUJbi1kx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3280264a6e8so2738581a91.3;
        Tue, 02 Sep 2025 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756828482; x=1757433282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+pJ1XLq6zr+V6cH6Abz6GdNYzdPPKUd1ipby2dd0mU=;
        b=KUJbi1kxbAKyXKJ9hGzrRwuQa1XlVzNVRc04zYGOQ5dUMKmQD/RpZWOxzXGf1FQQyv
         CsJcLgZxKFH3KCDt3rmYK2hCjAk9osFZhVVYajSb4KrkAp+lqXd/5BmyXo4VDA3+J4/X
         msserwcOI56vbJPQkfw/89Ks8qeKsf8Uj7V2PUAKRBLKB54jd2ET1Np1rAdcKnadfuyi
         qdczCNL1KedOc75ReiYGbSf0G9nudfw5ZDyDG1z8oUn8htN8eOoFEPtwpbUelDb4bp3Y
         zLA8njCwiHUyvTLtpHFhYou4A8A5+ORF8GsaeJE0MqSwqDs51HrFGHz0Mapu9/IJAm+r
         EMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828482; x=1757433282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+pJ1XLq6zr+V6cH6Abz6GdNYzdPPKUd1ipby2dd0mU=;
        b=mZZwq57Asz2/4EAJ6MrSGD/xNYNSPrPQnfpcYlwZpeGyP+OZcdU4nEYQQR0svrA6xE
         k5kFY6T/sSBSz5WPnX11PfzczBdMQvh1wAhICl7WtENbbL9FweZ8/T23N3soxAZnPqdD
         2ooPqwbBdbgvS/NX6WXQtSk9inqWvsnwn7JUvaceKYSAc0uqGJwxS4ZJky+3g9vcfYlO
         xxJrzV0MbmkIKq1FcAxpgbygVfQ9I1F15UcGQZhFXMgh9NSngXCpHTcQK6zGUZG9rU5l
         5d7F5UnRCPQurME8AyHW6+cPDvtYB04mU/sQNQ50UG85/v1ps/axXcbnZ1CQ8No8T41Y
         jP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW5EHivqAYpKIqCY6WP3Zc9IEwdSM61es9yNqPgRbhy5Fbdys8Qd/idZiVThdOwrhpOOY8RIOY@vger.kernel.org, AJvYcCXIuF4ZMnsD7avEDhONNMJH4WAUFAfwOgZKv3TgqkbtChpsNUHyGOBPD3AoyoWWQ8vAOqkytr8sJvwSrYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxnNiLzSkbWMXidWmzbEvFWj5v1yug6Xl1dKB5lviPllxEDMfG
	W3BpD+R4qYgpvXgKY93+BQe7IiJd/wDKPzRbhWnodmaEhNfQBLUeqas=
X-Gm-Gg: ASbGncsebcs42Yr30DjYW/Vr8n1DVmQIxmAkgfAibobRWHKqHiwHHGp15/EuT6czLUf
	9ZurRYX490OOpHarkPDtOauol1rU9VckDZETgHsk53vA8DwKhArgXYYhsaBTmgIRenQapifo8fc
	mqDTo35ON9fDRjbByVOeNEOnKBN3jUYr4eGM1h79jejLHvLwOBNbt2JDVKTjiusoT+yAwrXiPGj
	MnKiAtIbZvqR9kV/LqOGDmq6zSu5Ot3ZkmSKGHD1v8a5BTuSLJWCBCEBCfkawEvbNZMFxWtjy3w
	PUocJYGMkwWHQRxDXNXfAlnCXmMzpxvyBvA11ylcCQeGZwPR8vs9NF5/qA1DC2cFdVeZQpNIo3I
	ouPQuMzNFIU4YqSy3xfUM8EqOR3swIhrDMJZPdy0DUwhcTaSBsIInVbPdE28iiVsWtvmpuYPHco
	dw9e/2jvuBFSkoZit+x5eRVuKrjxjSFBR2k62rnIAeVME2k7oYWHwoXJjgxNT+yKhHbhFPCWB0Q
	gsS
X-Google-Smtp-Source: AGHT+IHW+/+KN3k9Jrc87aSzWT9SddjBik9QhcHTmdkOkNlToMtgRJ/BCQVvZriOXxsU1s6BDpOXoQ==
X-Received: by 2002:a17:90b:3d07:b0:327:6da5:d94c with SMTP id 98e67ed59e1d1-32815437c67mr16859308a91.9.1756828481616;
        Tue, 02 Sep 2025 08:54:41 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-329e4f084f8sm2185632a91.10.2025.09.02.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:54:41 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:54:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v1] net: devmem: NULL check
 netdev_nl_get_dma_dev return value
Message-ID: <aLcTQEN-sAHxASMI@mini-arch>
References: <20250829220003.3310242-1-almasrymina@google.com>
 <20250829175222.32d500ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829175222.32d500ca@kernel.org>

On 08/29, Jakub Kicinski wrote:
> On Fri, 29 Aug 2025 21:59:38 +0000 Mina Almasry wrote:
> > netdev_nl_get_dma_dev can return NULL. This happens in the unlikely
> > scenario that netdev->dev.parent is NULL, or all the calls to the
> > ndo_queue_get_dma_dev return NULL from the driver.
> 
> I probably have Friday brain but I don't see what you mean..
> In net-next net_devmem_bind_dmabuf() gets a dma_dev and returns
> -EOPNOTSUPP PTR if its NULL.

+1, the description and the fix are confusing.

Unless I'm missing something, the intent seems to be to avoid hitting
a WARN_ON in dma_buf_attach (really dma_buf_dynamic_attach) when the dma_dev
is NULL. Mina, can we do this in the callers of netdev_queue_get_dma_dev?

