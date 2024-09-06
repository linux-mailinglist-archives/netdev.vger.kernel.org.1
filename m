Return-Path: <netdev+bounces-125901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AFA96F2CC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB91C23AE2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C91CB307;
	Fri,  6 Sep 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOAYrpDw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382531CB14B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621670; cv=none; b=o7e1xMxXBooFd6Ju8+sO4iqJ/jRPkZyta4Iz9lA8Oe6s24TFZ9ZBRHGvIf5UGkUoipz+jsPY1Rbhw+va+wSY0fdxyATCnjKPv/1/FZvLGYSKIUZXiHjzzUY8lAwY+VvgTO7LF4XgdX401A3gmcN35rVoD+34aLKUkc/HDGG6ObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621670; c=relaxed/simple;
	bh=XM5romIm4KxJKc2Cm0Xo4inyO+ieNM4r8IJYwcGNYzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+JH1QQDQ/QMtysbNLCc0BHJBC1c1jxUBtYGqofbrpoUiFmXcdifRxdUlQrkQkCLBvQQmVzV+8I/NkVnmgwkp7JJmCJ2wDlj52PPaOHkhPF2QJ4I206912QNS8mFqTJ+Q0Rr61eZFhPRW6z/yuvty1DmjumUpMn95VcrCR2SQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOAYrpDw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XM5romIm4KxJKc2Cm0Xo4inyO+ieNM4r8IJYwcGNYzU=;
	b=QOAYrpDw/1ztnmRUt49INo6StpeTztsyIkLUHwlo5kIbyxPv32PIft87ljj7QkkIwbaU2T
	59teEJckJSjQiOUg4oxaN6J6ZWnCEPdkbrUikGWTiFZh5ZeJpUeiNKSUCcndJZbugW/sfR
	YwylZ9mf/rcomCmk8kOxR4wGBjwImxw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-49Qmm_uOMtyiEmMn2JSiCA-1; Fri, 06 Sep 2024 07:21:07 -0400
X-MC-Unique: 49Qmm_uOMtyiEmMn2JSiCA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c827c4d3aso15264925e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 04:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621666; x=1726226466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM5romIm4KxJKc2Cm0Xo4inyO+ieNM4r8IJYwcGNYzU=;
        b=VfK/kJmNLh/XzcvBWIdtvlmHbn6S+8saTJnXU5iIpNgCwYyPlDqGcwXWDRsVWMQDnU
         ppfx8AZSImf4GzjWraAEAPjXKtk83HTf/bL/DAciqkWbYkzCtreCwDPSYIajKFS9A6iX
         WwMTwuw4TzVR6WCCItDubbzXR1ZzR0fFmCeUxE7QG9+yyS/kp+JTqdRcGCOwfCXQQDUp
         5OaT6T682XBAawRddDdmtH3pyaD23M8MJEw6T2UQ+3pGFA3n1aOeZ/i6HttIdB0zORqu
         ZqTJx7nqf/i5tuhLLjKdTivRVflH+CN3apD8ldPeljNHNyRny8xJjLQhe69w06JH4TEU
         s8AA==
X-Gm-Message-State: AOJu0YyiQ2agYBN24lyPSdDy54UDIdZ2OipGRlS3O7YELWjbgIsZYTyT
	kNX21KvaDOQYWqbMDmF0yOKgKsWdYDgJPm7JXdD2QyWlHET3ArIjW+BsjXJ1BA2M1JKlWbOPb8k
	E/PKW+u0Hduaip09k15N0t4hiRj7cVN8+/Wx7ZHuAt1Ex2ug6YBLOfg==
X-Received: by 2002:a05:600c:5103:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-42c9f9d65cbmr16318195e9.28.1725621665632;
        Fri, 06 Sep 2024 04:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE93E9q/W6NuTuOA8k3tsvdqWAFnV+g/TGFfrApNmc8vSoM76gleN9ntAIhvsJ+eJLqfOgoMQ==
X-Received: by 2002:a05:600c:5103:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-42c9f9d65cbmr16317795e9.28.1725621664988;
        Fri, 06 Sep 2024 04:21:04 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0606e9dsm17561175e9.45.2024.09.06.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:21:04 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:21:02 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] bpf: lwtunnel: Unmask upper DSCP bits in
 bpf_lwt_xmit_reroute()
Message-ID: <ZtrlnguvBN+BJpFc@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-4-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:31PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


