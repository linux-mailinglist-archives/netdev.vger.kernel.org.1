Return-Path: <netdev+bounces-75479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002686A176
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C305BB2D7E0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3314E2D0;
	Tue, 27 Feb 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iK4SasSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CF51C4C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068048; cv=none; b=bxlfooWkFIsqWqNQ7FrVQCvSZLgmsAWTuPtQvXRr8gKHcZ7QFunytWveu0CoKh9xb5Lvyn7IxEtjduxSGnRLusWIIe5IVlOAJ5Iip8cvdWLP0WnBzICHgSYauESNkG/v8bEDQVhQ6U7cxpPj+pzwo3gwMdKFHXe0l6ljFyMSZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068048; c=relaxed/simple;
	bh=8x0AInFvNP8D8pseZGq+/swQQQKewxZNnJ30DFT4RAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LQAHN1Ef8iUEo4CmaWH3vibUzdZRyy9HAcnIJpYsBPq8B7+BfqZXMeuAZoToJHctQCDT2LWb+eG6ssIF1PtXvyrG8QuADQF8r2xjL0Qr58BbC1Be48cfKGY3QKIhav+dFVXxp7vT6Nf6BlaU2RqPmpXLo0902sik2jSyGZ7MTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iK4SasSx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c670f70a37so3992648a12.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709068047; x=1709672847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUy1NBabgD/YvIHCZG860o2vJieXU6o1NrCb1/bO6vo=;
        b=iK4SasSxa0ayd6xwn+OumKiKykqayYPToA8GQjICuVHcAd3qybB4ZjEJtTiwB+2EiW
         D7eG3xcErCCeRpTVONASXairdYUbLEtYuZhPbwxLknEaw6TVq+pkw+ms6yQJMI/y05ws
         aOFn9dL1JVz0LWPQKpCq7peFM2+dpVO8WdJByPHHI0eRzLtevJXULI6GapiR6OkHI7dL
         bx7GgRuqxFAK5ocmH//I0Bpt0W7arGhsCgaz+nDSBf7foPTtjRq3s9ATk4UsR7sfdAfn
         G1fDuBQBQjxv9BwRufjrRvcCkVASEbOU8p0ReoBSyYg3rIQfeuNgkj12xzOy56aOwzhX
         oXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068047; x=1709672847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUy1NBabgD/YvIHCZG860o2vJieXU6o1NrCb1/bO6vo=;
        b=VnO7gRRRGcobRj/a1jgz3x2g+sFm2khuA6guMFm+yY1DUlTHZdf9MisPyHrT+5LUlM
         IP6tXdGjGz4pmvEnqyXBbSYgyuO7By5mVCeATYb36qlnE6s/L+VJXyMB3lQaXJp1w/zT
         z42xLKZolAnVwuZGh5W9LNmMgVacV+ClkUo63JvMxir7V25Eo1pbPxkBBbQP0kR0LJAZ
         5/ubG8m+TcppqNiPQBRUUVNA5ZV6Jfrw0wiTGvPNiozK7uQJHvktpEEG5GpihtGahZif
         mJUkY+0fSPN8aVrWpUM0oG9Ifcsqg5gGZ8W+wBNwX37Orus5uTJZpIjJwjryLfKNuGRK
         r4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZgnNW8DJd2CKW7vykbYtgDqEAquEJyZP8xxxrhMbpRHZKzPUZgetIImJekMBWlNg8qD0I1GQMUooScIYkK5x3JFApOmDc
X-Gm-Message-State: AOJu0Yx1+w/hm4a/b4fHbbk3U4r76S6/UsXhAZ98y25dcDrQRi0HIbRt
	Xb8evZAyfCzpK9pQwTcMYo95yIgeZ7eXemJ1sids1gMhPwWuFX1vy66rOhIm6kEv3w==
X-Google-Smtp-Source: AGHT+IEacAH+Q4FyAoK72Cci3UzTI0vQ+NRQpgPAVO++DG4AN3ZPhIoL/p+dkS+nRDhkktjc5pyGtP8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a02:185:b0:5dc:1a4f:6319 with SMTP id
 bj5-20020a056a02018500b005dc1a4f6319mr50404pgb.0.1709068046686; Tue, 27 Feb
 2024 13:07:26 -0800 (PST)
Date: Tue, 27 Feb 2024 13:07:25 -0800
In-Reply-To: <20240227210105.3815474-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227210105.3815474-1-edumazet@google.com>
Message-ID: <Zd5PDb7WQ2o8kx8C@google.com>
Subject: Re: [PATCH net-next] net: call skb_defer_free_flush() from __napi_busy_loop()
From: Stanislav Fomichev <sdf@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="utf-8"

On 02/27, Eric Dumazet wrote:
> skb_defer_free_flush() is currently called from net_rx_action()
> and napi_threaded_poll().
> 
> We should also call it from __napi_busy_loop() otherwise
> there is the risk the percpu queue can grow until an IPI
> is forced from skb_attempt_defer_free() adding a latency spike.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Samiullah Khawaja <skhawaja@google.com>
> Cc: Stanislav Fomichev <sdf@google.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you!

