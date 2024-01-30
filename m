Return-Path: <netdev+bounces-67331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B66842D19
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DA1C228FA
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CD7B3FD;
	Tue, 30 Jan 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kkp3+RrD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9A7B3F4
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643654; cv=none; b=uZhvO0Yo24di3FA0uRxYaCnsQbOgL4KgXAT4kdFQOP0NZ3ZoYQHq8UzIvPRSS779YfzFdzZMnhW9ikFT0QQQnM/O45MtYuBOoLxHx5ADIBt6gXURcGOinvXJCj7Z4PESJvB4JrbFSA3jXVM/8DZYIargpOC00PAYQOOXaE3zTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643654; c=relaxed/simple;
	bh=iuTRs8pD5zQvTzuzah4xY/tENHEshzjnd6mwrqX22ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlZl4wiJXnP6GPmbJh4pbFH48imJgns+925g1XZ3XhkyWVMgrMiGbXnlXZXHqHM4nVSGVyfPZB2t2sRNvZCA6ceoI7FJM8GOlQ+xTlyS21tQxbnCxM+Lv3C4UfZqqUTLXtdXy8yoiAq4dngPDN4l4Pfg05EhBFqF5n/Eh7uU2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kkp3+RrD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706643652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpJuEz0EuPaTrjfYgpnpRcO5lXRj3M+OefQiLWQnELc=;
	b=Kkp3+RrDwx/+fD8evHSQNf8WJckkhtBu2CmcxGjN49J5lw9uay+Cl+c3wTOAEvd/fy124z
	0ZKCOdkd0c9LQyu0yo3MfagkC8kAfqYUx9pdhZdLcAvCjXyQ3UGsGu7d4CGDTCFy/ashNb
	F//MXNh4VeZo9JLgrhsVO/OdaeHkvks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-NHFAO0oTNIy-AXloBLlA0Q-1; Tue, 30 Jan 2024 14:40:48 -0500
X-MC-Unique: NHFAO0oTNIy-AXloBLlA0Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33aeb5a9275so1279151f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 11:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643647; x=1707248447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpJuEz0EuPaTrjfYgpnpRcO5lXRj3M+OefQiLWQnELc=;
        b=RfjEoDTTcnJbBES/6ne9NmeCflNYt37fM2I2eXgtqcOxWuPLnm7RMHscUvcT7Acgtu
         Fwlehy1gkATnqTSRzOl4w/Our03kF4ZWXx96A4WgGND0k4bAmM3Sw5/HYtupqXknjaxV
         pGT3xLndQTjf7bGnQyKF1DNRLDJMSRvUj6DilM/wxgT1iFn49JWXD2+8aHR2gRxMQoZ/
         /dSbiQzWgnKGEhimcysakqsiTHGHkAWCUKckfo+Dbq2kssZ5cQOkjy7IJh6nSvoTQxxH
         9KuMOPrVgYrq4bV44fAcRfIqDbIryJAR4J3uBF6WlTn66O3CB8XsWgRf2Gpe8nbSvuhN
         YdGA==
X-Gm-Message-State: AOJu0YxBxTHLAb8tXlb1s6QjeAeQs/374QXXlGjo1bCfnO9+zFObZ57h
	WXfoOTZjjNKi2XG/hK7tCQwgzZB/rpjM4DFdqJOu0pP/3X+m9TmPeTB2BiYpDvg24He7PE6hrra
	BrudnssJoQ51nXUgHe+nEMexI3BZJ2CArEj1SmuMXO6qMVikNrn6DXqBVeagupg==
X-Received: by 2002:adf:ec8a:0:b0:33a:ea28:2bd4 with SMTP id z10-20020adfec8a000000b0033aea282bd4mr6260247wrn.4.1706643647515;
        Tue, 30 Jan 2024 11:40:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF3t0vfnDSip2D0CHJlu2h4X4lIQQd+XkEWV/wTjfSUDh9ZS8uuhJAP+QPbw4Zo3obl8jyBg==
X-Received: by 2002:adf:ec8a:0:b0:33a:ea28:2bd4 with SMTP id z10-20020adfec8a000000b0033aea282bd4mr6260230wrn.4.1706643647255;
        Tue, 30 Jan 2024 11:40:47 -0800 (PST)
Received: from debian (2a01cb058d23d60036688fbd67b19d62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:3668:8fbd:67b1:9d62])
        by smtp.gmail.com with ESMTPSA id bh2-20020a05600005c200b0033afd34781asm1797370wrb.75.2024.01.30.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:40:46 -0800 (PST)
Date: Tue, 30 Jan 2024 20:40:45 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Florian Westphal <fw@strlen.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/3] selftests: net: don't access /dev/stdout in
 pmtu.sh
Message-ID: <ZblQvSCgTSs6FfQU@debian>
References: <cover.1706635101.git.pabeni@redhat.com>
 <23d7592c5d77d75cff9b34f15c227f92e911c2ae.1706635101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d7592c5d77d75cff9b34f15c227f92e911c2ae.1706635101.git.pabeni@redhat.com>

On Tue, Jan 30, 2024 at 06:47:18PM +0100, Paolo Abeni wrote:
> When running the pmtu.sh via the kselftest infra, accessing
> /dev/stdout gives unexpected results:
>   # dd: failed to open '/dev/stdout': Device or resource busy
>   # TEST: IPv4, bridged vxlan4: PMTU exceptions                         [FAIL]
> 
> Let dd use directly the standard output to fix the above:
>   # TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


