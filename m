Return-Path: <netdev+bounces-125911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECF96F3DE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E131C21143
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292301CBEAC;
	Fri,  6 Sep 2024 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBsrkHWs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7901CBEA4
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623962; cv=none; b=PuTajfVpBUqDATGjW5b3jHyIubqW7UTZxpQWN7WQETxgvYPWgLnYwLut40A00SMgn2u2N5Y+VDFDmKthvN/8VF0VK7jG+T0AUwXumvw/36jcwSnjGB+n59Do+S5Qp4f0XPmDFxMjWrSbJJ8UNHv1jKsyaBYmwQoyUMYN5wqnIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623962; c=relaxed/simple;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHZOokiVwVq5pjKfhycfCzHcKGRA7GaLZZEjw5bUzgkHUG4OTvmBKwlLXfCEvAKueQrVKz7IqissiefCBYyuDv8zBB4Zu4m+jSTxqXN/03+28kVnkgYKrWCDTCPAYK8bKqJQ3NkUDXHnIX79kg9EYCXQlcje8vFSQQB+SddxTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBsrkHWs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	b=SBsrkHWsCOGQlxVhPyMHDXDGZ8kiTK+eG9zgYRAZXXz0bCx4IrEeFsvhKczPqYMgucRjZ2
	EhX8ElLzOdBVo81C/+uHUHtwe7I0gEiSZ2gxA1vLeopYlvKOtX2Wnpdv/hQWlNV1fl3bIu
	r2THp5EqKARhUDSNvqMFJURm1cr1E9k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-YAPb07LmOIuzvSgtRyV1Zg-1; Fri, 06 Sep 2024 07:59:18 -0400
X-MC-Unique: YAPb07LmOIuzvSgtRyV1Zg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42c827c4d3aso15598805e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 04:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623957; x=1726228757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
        b=S7YgGtlyEbsrzD2pWrCIA5IUM42F3f0yYrezhpjEu9aztaMTPJbiW7CSPa6TnJFM9g
         3fhnPCGsTvJU6Sm1hGk1P9tAfSBG5YDLgFzRdAeNmG91HX7dI6sp32+x8JkjSRH7YiTf
         3npLLFxBIdc3kXyj21UcIZbWVsf4avDX8otWTULXXx+sFxDoP9hWP0R5jhTRo/kpwBe2
         mvOsLgvx8yk9fNSmjI46rvt8f3K9Zrn76KMZcVCg6od0M5xwBZ4JIC4XIEoLwg9cNsyZ
         gWBzg5hzwSuydH1G1bhKFSAnNiUzX0ZXEllWPUGKNnqNi/ne+DUCBUEUTHE8SYkExsf4
         w8ZA==
X-Gm-Message-State: AOJu0YySG7Mr7r2gGq2KWTi8i/Ks6JgiSikHdsoEeF/TsG8k39Ss3s+z
	IrmKZu5xbzdbuAGBel2z52Dk00osEY2RmZsAFWJklPa4RqF6vn3mC0wd+EFm+Y0bC42TDEpfrj/
	aJK9WmzAESh0yDaSZ89hdgWoxJlN+gDcAGJN5XD8s0QCPNnSeyGl+Sw==
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589795e9.29.1725623957340;
        Fri, 06 Sep 2024 04:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYA3WJyXIhIIDEVufGNxXIOM6KJ1IZ7nsonG5drAh9teOtbcCOcgYplQPKS/qfufalrdR4OA==
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589465e9.29.1725623956763;
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d351bsm18481815e9.30.2024.09.06.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:59:14 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] netfilter: nf_dup4: Unmask upper DSCP
 bits in nf_dup_ipv4_route()
Message-ID: <ZtruknlefVpreVRQ@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-11-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:38PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


