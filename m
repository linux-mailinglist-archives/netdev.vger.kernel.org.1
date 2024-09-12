Return-Path: <netdev+bounces-127908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F20B976FEC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143CA2818B0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FC1BE868;
	Thu, 12 Sep 2024 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Aq/LBPqP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA81B654F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164227; cv=none; b=j0F5nVTo+J9i6JK/W8IA5tD6QjgOWkKpWHxUUPa49Ag2yiDW89gbpgYW15svPAjFD5ikAl9MYo+gdQTG2QoCgDlzGc4j+dV6I1f7JssT0BM7KNWjOTkERJUw0/TCq/Rc3NjYt1AlxQjLPhMGwctog+BmVOZ5fpgBef2tzvgxv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164227; c=relaxed/simple;
	bh=K9bHNXidNq1NONjRV3KqfvBuioQWkPY4XuRvNYCCu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx4imdq3X+Ldq+pbe4tGQYaKwPWckoWx4kvtpvuDXyNmKMwhKOdtDkUesdUdePfZn4LWAISic6lxF1lViji82wVr9PfGYARSHMXxI9AlRS+N7kNVRVDMwdgNnWTjmA8Fg6cRSfAqfS8LuKO55llD742UITUMel7OqZAs8kVKBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Aq/LBPqP; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so2054101fa.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726164223; x=1726769023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv9p3quoHSsHUIbL7kx+Hg9JdnYpsM4+W5Q4SWHht7k=;
        b=Aq/LBPqPqwSwTtXmXH4ycohnbySVMjyOC0V3KrneLHH0XDN7l5u3u2UFnnA3xMHl6H
         EXMV+Y3JrPccogepbohYDDYc2oAiuhCw2LqdpFvXek2HErffqNENBEpvPhhic1FabG9K
         mcav3JMtyzdNhk5rg52cHBKzpTwK89qRxn1+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164223; x=1726769023;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mv9p3quoHSsHUIbL7kx+Hg9JdnYpsM4+W5Q4SWHht7k=;
        b=JLpl0rojaZkZM/9E58QsxNAdb15QAjzbts74YteW+zrRQABt1FatlaQKhB/Xhgc3ww
         GaMZR78VS3V7ifVQ88ChbIig92l6ARHR7rPTk00PSddKkCYq8MKbrwDHUz2ptfu8BXIV
         VGCSaEpR0p3ge0XBwgKTS14JNUOTnAe23wGoQeowrsmr6t4fuskdjbQ/NNh4b8mNylax
         nQkqbLZhohMnOkuJoBJQNWpoDku+OxfPJmr1BiOQ+3FR/CYHc1Mx+rubiQKsq22M0fan
         ukoBaAP2joEkl1M0omOywDbjquIuPL2ZNuuzSHlTOqwFyRUEekdfOb27Nqb8TX+7QoDp
         OsYg==
X-Forwarded-Encrypted: i=1; AJvYcCWinzL/vTgkwH9gSbRlTcG0E0i8smnSFIntz0cLnMDGL4pxbQ04sKuwnAj+DU8ovhTJu81YoQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNg8qzwVtG1QsURkfcblQvyBSd4yZEQeLGBmnXQH3ob2JribB
	aF0HI3jWDWX658lqO7XmRLSfYz4daTFs3y0XOPjf2FOfjJZGOpu5bb52c8Erqic=
X-Google-Smtp-Source: AGHT+IGutxN0EFHWMjO/BNwOFXuVUe1ZaE+f32VgpdmDZHWKMPFXtSdvr1s4Lp4H00pwKJtMkdD0bQ==
X-Received: by 2002:a2e:1312:0:b0:2f5:1ec5:f4fb with SMTP id 38308e7fff4ca-2f79190619amr922161fa.13.1726164222726;
        Thu, 12 Sep 2024 11:03:42 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76efbsm6823344a12.67.2024.09.12.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 11:03:42 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:03:40 +0200
From: Joe Damato <jdamato@fastly.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] fbnic: Set napi irq value after calling
 netif_napi_add
Message-ID: <ZuMs_BXeLYX0_RiZ@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Brett Creeley <brett.creeley@amd.com>, alexanderduyck@fb.com,
	kuba@kernel.org, kernel-team@meta.com, davem@davemloft.net,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240912174922.10550-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912174922.10550-1-brett.creeley@amd.com>

On Thu, Sep 12, 2024 at 10:49:22AM -0700, Brett Creeley wrote:
> The driver calls netif_napi_set_irq() and then calls netif_napi_add(),
> which calls netif_napi_add_weight(). At the end of
> netif_napi_add_weight() is a call to netif_napi_set_irq(napi, -1), which
> clears the previously set napi->irq value. Fix this by calling
> netif_napi_set_irq() after calling netif_napi_add().
> 
> This was found when reviewing another patch and I have no way to test
> this, but the fix seemed relatively straight forward.
> 
> Cc: stable@vger.kernel.org
> Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

I agree with your analysis, but I'm not sure if this needs to be
backported to other kernels because:
  - It is not a device that is easily available (currently),
  - The bug is relatively minor

I'm not a maintainer so I'll let those folks decide if this should
be a net-next thing to reduce load on the stable folks.

In any case:

Reviewed-by: Joe Damato <jdamato@fastly.com>

