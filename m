Return-Path: <netdev+bounces-174300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2578A5E332
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309E33BAEDA
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74946256C96;
	Wed, 12 Mar 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PevyLSms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED42512E4
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802225; cv=none; b=Civ19dE5ATFrcrFbqjPs6Jx2SLsidwt8TrMoovZmJlZOndpk2JgtnKOIQ82liQ+FN/LYQllayvATBq0xL1PGfjwP2Tf/o8ospRnVLYO3W+dFVVF1sCwCQ/VddOnTOxU+LtpnGGdupoN+F8IHqDCP7HPi4C4IWwvNqMnEw9pxy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802225; c=relaxed/simple;
	bh=rU5vy4tDfFZ36pWjXR9FFooaWrjIIy7FCgMwNAKeGB4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uTu0dqSh0K0gQs+sA8qY+RclrvepAV1UuAZT7TIoRTlFL2D3wfjnq35dM/a84Ti0lo/UeM84XoxZCcOv++yKUASBnHkgXH5lZRO3W3Tr1DQHiqAIqKGKLgDiBZZnwzA+TpiQptXfiKzA+Yk6bx5U59m4LxFI5y0JdJNigEHUAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PevyLSms; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55500d08cso4992685a.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741802223; x=1742407023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I9oz1Z0Dwadk6Mx6Ac0uuAcvarRn0g+iVjfSxLC0To=;
        b=PevyLSmskSDAgwFba8Z1UNdYMPMY8ooU9mVVAFohaO9jsfG7Y0XQ1BFhA4ffGJeSzW
         k8bQE5efr9x6tMmgOzfLuLagX7pq2Dy+FG2LG9UHDce3TR2DgI/duysjMqOZw9PD7O1b
         IacnVpVcPqLDme4KAQ/37OhhA1xaAIzoiD+2CL/rxItA9YjKTTOQCSKCY+5zRg+VZN4v
         kja701TgzyFJMK16dFkHmTIeElWXsbnpdGiupCnRm1F5GDkVnjC+OaDiowYTJ0JcChXc
         /NuSSuPJwavZiHxCyHfnf7Jmxv18VLyXOB47t9cF6faCNERg4DZH0E7+yHGu+VhfMZZt
         pEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741802223; x=1742407023;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/I9oz1Z0Dwadk6Mx6Ac0uuAcvarRn0g+iVjfSxLC0To=;
        b=gKmokUZg/2a/gvSYWY0idXl6GeoAJoI4YYsfJk57WUooJTgL5F6SFQu8ykrbZrOGOB
         bAtdjwv7424JfZe+Q9SDhlcCN7saaVkH7aJegCmzihyjFt67CuR9Q4rCeWXgzF3RCMYL
         jthwRNHC5UQr9RxSr1QUBvFQ5o4cfo9nfDPfR3twMHivTAttP37bxy/0Dh0HGbzw/w2y
         xGz5QekOLZe4yVQVy+qL5OiJ/bclibuSV2GZqbmReS+hoB9pN2EOL9ulDDGFsY/3SFe5
         sn20uPjG5UiMWEO1BzaV9vhJDuqKz1lGRxBY7JjuRs6f0dd00sWgtJ6GMGDjFX8V/Ca0
         ecnA==
X-Forwarded-Encrypted: i=1; AJvYcCXa1zcZqqpZgr2Pe0KGFYyQpO+JI9KDVjf1uLVef0jlWvWkwukwvIW16VLCDkswaL34UbSonhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2mp3rqL/hPBe4fLGJipdoOpeCW3Wn7vsosjvon7+G77Zp+tQ
	LMPlc5gqZcszl3yH2YEMxtP7yVXBZyyyOi2c4VP7bszXdEcU9c5o
X-Gm-Gg: ASbGncsaKJ7teS3xBADXaYjWOpMfgtzI0lLc0gd8jF3wzxJd+3SWUBX/gUGETSsK1Fw
	gjUEJdrWy0DJdDn7MGcjq+qU9pZpWP/exIe3j2Zb77LHbB7Ke6vLgmRcOBd2sTlt1jMmOnyuVba
	EJj6PRY1ASyAxq/wL80FuxgA7w3O6TYK6iBZlQ46Eq60DDPpD/m8NwajY1/6I6W7149BSmAikc3
	3fUZsoHmb00KUjvBtR7JSy9gGOt22hDl2jmAXjczwbtb8vIFa0WUjEgkvDfNtVsGxC9To/9SPWj
	Ml/t/pPdTJgIPxszTdwNsRnRLR8RDH4c/XBMux3PpNQDeLkb4V3Z+pDWwvlo0jPUHDicAvNJ/4n
	U3UZunUgiiEYvSSyxltakBjMuw1B4aPM6
X-Google-Smtp-Source: AGHT+IF67ueDQGCYjMUAf3nuRZRj2NiHi6p7DEcaxTlJcJcIuzshaTmcM10Y1KwthkDGQsTVZWhR8g==
X-Received: by 2002:a05:620a:6008:b0:7c5:444e:3f56 with SMTP id af79cd13be357-7c55e843b8amr1382348085a.1.1741802222852;
        Wed, 12 Mar 2025 10:57:02 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c55212d8c8sm509892685a.42.2025.03.12.10.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 10:57:01 -0700 (PDT)
Date: Wed, 12 Mar 2025 13:57:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 kuniyu@amazon.com
Message-ID: <67d1caecdaf4d_38d99f294ce@willemb.c.googlers.com.notmuch>
In-Reply-To: <6fd1f9c7651151493ecab174e7b8386a1534170d.1741718157.git.pabeni@redhat.com>
References: <cover.1741718157.git.pabeni@redhat.com>
 <6fd1f9c7651151493ecab174e7b8386a1534170d.1741718157.git.pabeni@redhat.com>
Subject: Re: [PATCH v4 net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> It's quite common to have a single UDP tunnel type active in the
> whole system. In such a case we can replace the indirect call for
> the UDP tunnel GRO callback with a static call.
> 
> Add the related accounting in the control path and switch to static
> call when possible. To keep the code simple use a static array for
> the registered tunnel types, and size such array based on the kernel
> config.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

