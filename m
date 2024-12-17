Return-Path: <netdev+bounces-152607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165CA9F4CFB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD2F169405
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D631F427C;
	Tue, 17 Dec 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOFckzmj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7632250F8
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443970; cv=none; b=npfNQqfUbTSLzK4GOnuabnFtyy5HegKvnNvFFytP6DhgkfNmJI6w+7bSJvSJocx4CcuKISAteXoC5RaJ9CCBb7w8zFxlnfo+D27TLa1cFQgQb3Ed7odsJxURSJcfWSoJ93HKfKxGdX37rSJz6y/Dx3Ak78C5MR2mN9ot2vqXjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443970; c=relaxed/simple;
	bh=pcxgYby5WPpyBdlgN7E715zZ03HEYKEFeCg06Z1KpjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4fzKZb1WUmGC/FHCByS2hHJ6XnYksqXDLmoViD4lkTEDbu2jQa2oGlX8STb9dglQQiG4uH2shqDxdo0YxexuY0YhEsPwm4jimNOVaU0INVRAkbpnBczBewga5+zk3XTLK6/QDGCX6RU9JzN/wLDcA29LXVShRgR15HNxI62mGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOFckzmj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734443966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhAc/jC4dYpPGKRVWYaUOHuJTso9Ft2Xk/zIIE5uACQ=;
	b=cOFckzmjRECUjU9aD6ijFV2FGaYnYfDF8uR4xLAQpWq5Ksidu1kHzjwN2+wVjU2AgXqXBP
	e6HEOG35s7GBtNTIfWYge0HRJDKPA/wKk+bPl9XuCR32VYcuqqaQznvd0DZircbJGKkbnK
	6V3m2yCZenusIBKOfZRcE4ycBsc49y4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-UycPb7ZLNHOEGKJ2Odg-jg-1; Tue, 17 Dec 2024 08:59:23 -0500
X-MC-Unique: UycPb7ZLNHOEGKJ2Odg-jg-1
X-Mimecast-MFC-AGG-ID: UycPb7ZLNHOEGKJ2Odg-jg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso30038155e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 05:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734443962; x=1735048762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhAc/jC4dYpPGKRVWYaUOHuJTso9Ft2Xk/zIIE5uACQ=;
        b=ASTU+KCwjbJO51I6/TCnxTxIO388N7aE8pFJ0UCoOYJaA2Sdmm3bucx/O2siafkxvf
         B/4v2R6+W4Bqw9ZcYsP7wI6dtkRQFkVknME6mYRtqLOkwURDEBAfz9rG7j+GlTi77ZRG
         HlR82BhNERyIjFOSiRhE8ZUJsTumDUYoKxJa3lfIOBznqXcs0Z6lvGVpwA5xOAFzQ4Xp
         BuN/x6liT3+fOTMPUzptL27dIk4LPZTW/vNeUMAeygTWZ5I0pzKPW4c+fRsNgnPnNidO
         1iIV2SYAyQNRFEGQT228MtsqyZBnKFvtM7y2USXLrCdCA6lHMtctNhjlrntZhEjP6U1o
         xDvA==
X-Gm-Message-State: AOJu0YyEbZ+bDqJb5K1gFStRnWUzD7EHKkF+UyvuQ0+BxtAZhDDoFPHM
	Xm1iFcygz+ATMKiNPVGmpRsKPP2XkSLZ/F/v2BM+6jwUGcf//bVLB5EYa78HG2mEm79nfPPGmJ7
	wySj6JXf2F++p+RADIEwWJ8Gd9QPGDSYQ9sb/4m6qt8u13uhfbXjd5Q==
X-Gm-Gg: ASbGncvQ26FsTT2dG480LBmcioIaPawoG78cmwajbfJyGWOr51hj2ISLg9aaETsa9qC
	XTXV6eWIaCnDB5+7/VuCPgPwbcRJgBlNx2tZNyLhqoTv3qfr6AVQWSdR/kQtZtU618It9/EZ3tA
	bUJr7JAINJdmmQUXxNMArIm5yLTGk5ioHMtgZXpghSn4J+DqMNy2z4d7Br5DL/XJuVFXIyD1XoE
	4LvDX4wIzMgQHDFN/Zl4GHVNNsoUGTlBuS94kxw3jHjP6NGLxbVHxm3U9zzx/783UkUMFDpEuEX
	S12kzvz8t64mpKR3nMt18HMFjCWoS24rl2GS
X-Received: by 2002:a05:600c:4ed4:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-4362aa66874mr162680155e9.17.1734443962339;
        Tue, 17 Dec 2024 05:59:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5W4gsjGhjNWk8nWu+8lSYeQBM/Jwv9mAVLdL+L5km/+gmZuZG+fWr/Ow9dJs1LDLZZaqhGg==
X-Received: by 2002:a05:600c:4ed4:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-4362aa66874mr162679945e9.17.1734443962049;
        Tue, 17 Dec 2024 05:59:22 -0800 (PST)
Received: from debian (2a01cb058d23d600bcb97cb9ff1f3496.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:bcb9:7cb9:ff1f:3496])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362571776asm171647835e9.40.2024.12.17.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:59:21 -0800 (PST)
Date: Tue, 17 Dec 2024 14:59:19 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 3/9] ipv6: fib_rules: Add flow label support
Message-ID: <Z2GDt+5piTRsumVd@debian>
References: <20241216171201.274644-1-idosch@nvidia.com>
 <20241216171201.274644-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216171201.274644-4-idosch@nvidia.com>

On Mon, Dec 16, 2024 at 07:11:55PM +0200, Ido Schimmel wrote:
> @@ -332,6 +334,9 @@ INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
>  	if (r->dscp && r->dscp != ip6_dscp(fl6->flowlabel))
>  		return 0;
>  
> +	if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
> +		return 0;
> +

Personally, I'd find the following form easier to read:
+	if ((flowi6_get_flowlabel(fl6) & r->flowlabel_mask) != r->flowlabel)
+		return 0;

Does GCC produce better code with the xor form?


