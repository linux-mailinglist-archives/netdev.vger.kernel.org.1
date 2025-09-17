Return-Path: <netdev+bounces-224062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82BB8060C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578011C8299B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22903332A4F;
	Wed, 17 Sep 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW9RzKIP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD5335958
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121155; cv=none; b=DeBTuhhP99TruIdAeQkEa4je+8FnTd3DAEQms0JZ+KQ7ZXmrgT6+PFTpXsbY12MfhNE8dsuYpldHJk38Io18+wr5NcQS4X0rOtAcm0hrrNhMyXjZ9/tYOS3JQwYl9gKngMLl5LmN5D4J8/ltp+EysTU4aRnJR8wANRJjtzviUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121155; c=relaxed/simple;
	bh=yh7SesbTZYWzQbBGpY/ZkzlOkMaUAdeBXPpIgTxIOnM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=exHAFNkEsqDe0S5duRo21QXU0SAU/G0KFe9RA9itAEyA4LIYmVFDyVjfAxFhKgYUnAgMdnIEdheL8k0j6QQkTUDGaikzKTHfa9RV7JktmTMqX2fsioOdD+K1BaoZU5hT+youC+HHn/9Vb/s/q9aEmLV2gCtKbQpHbDrs4darpW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW9RzKIP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b7a8c428c3so28243401cf.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121152; x=1758725952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1u/3xHbMVMSe6ahB0zVOJXWh2eWu+2lWD9pKcxDw+c=;
        b=BW9RzKIPWmoAGnhmB9bG4rdVuaiODs6SQtoNhNQDsUdIQt4SxmGQ15L8gmP6JNwR1E
         F4MnmXDxksUyWxN5y6RwZ2tnzzc0Dfx/f7txNy81IN2tX4MWAFY8qTs9ojTOGww8UXCt
         r784Oce3YlbYDpn3E+4ZiAZ4U910EBdDuAdwNDUzgKfMe3ksLbOdqMPU8BIxiR4tZB5M
         65Zl3km+/ovvqYyzKn/CZKBwfdmnuLgUdcaqEelntvC+GV3we4bowbZX2Y4O/1LssLGk
         g1Wj2Reo1JIgL5VSnNFM5R84URD7h4nuNyr9EiZUC0hJFmNB6n8uxy6G1Bw1p4Pl/FUU
         y/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121152; x=1758725952;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y1u/3xHbMVMSe6ahB0zVOJXWh2eWu+2lWD9pKcxDw+c=;
        b=AlVdOA7lBTvuSW46AZGRN/odmW/gSTSnkuL5KNzQc516ilg4ay6qe9Tx+jqAjLzZzK
         ysXzHjTL0dIPzsarYCJH0u1CQazQkBT0r/+WUeLffu9CxYNaAEE95sGxLwUX036D/9RZ
         bYgE35brpdmyGKm638LJmKc4O/D4aFQBCanHU5nm1xNcgbj/nY0LNkzLZ4ne8dM/BtGF
         8ivUsGC+721o2jZPjO5iSAreyF7JSLdob3pNwG2MQFWVZWvGWlQ+soNDQLx8yWZsLP0k
         gAT1t24zd2lcmGqNWZIlA93EBrSpr2QEy3dzSrvtDeh8HPlnSlHIcp9QWPXr3te+QNUy
         k3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWY3lN69/U5Em1/UgjwP9yYM3xsznsprhLkkpHQZrZki4V1uQ0ZgsaW6Dep/un8nomqZnSuN7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Vtx2vT7arG/UI20kHeJFIeowaZxL3/cRvhCrVPsG/ooqdBgy
	PMSAFzFRxfbde76Jx1t6p1WdwBqzTIzIvwW9rASgKoD00BytosFdBGWO
X-Gm-Gg: ASbGncuBg/6gthGg6xu6Lk2ZgJFbx3vd/aqKTz8Zn6xsNPtbXab+VYajAuHWGCzhy+9
	G+OafRMA84DLNAnEIQA6G9w8NeCHmPeO4uiCwrk6KFso1TDgg4I43Cc+H8Odj+xaptVG6U3FsiJ
	RIeJC3WKjXnGiYOgHrK1y6Ls6Nh1bIRZmKTHPL2HVqIH7SBwuA95I5A6tv9PlGefTFXavgrWm6S
	qDF9POYrWz0k8OKpFoisoAPmEBceIWrZMoKD8eYWajs6rOaCtwpBfY1S1LAtx6BXvqpZDaLt9UF
	F+slDZV88i82u6wXbVyvx8Jvk+VTebYhqG3MDKNtxPAV0NBDJf2Btru6uVdQPdfv3UkzgL0B6tl
	UzxFM9c9t/PPwJPi5pV6noRJfEMOSJoY2oxmMVCgxhYGsytkAQ1HfeNQfH7pQDSI9LPs1m2Q35w
	xCm2l3yhNC8sKH
X-Google-Smtp-Source: AGHT+IE1ZnojiAZDH6saDNki1muTI7/erqnQ21hXzPFQ9pMFsjH1lVcr8EK3AZxGjp3lLeQyyE+IfA==
X-Received: by 2002:a05:622a:1e11:b0:4b2:8ac5:2588 with SMTP id d75a77b69052e-4ba6cd70e67mr29518941cf.79.1758121152200;
        Wed, 17 Sep 2025 07:59:12 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639cb4212sm98094481cf.19.2025.09.17.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:59:11 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:59:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.14eeb8af51257@gmail.com>
In-Reply-To: <20250916160951.541279-3-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-3-edumazet@google.com>
Subject: Re: [PATCH net-next 02/10] ipv6: make ipv6_pinfo.daddr_cache a
 boolean
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> ipv6_pinfo.daddr_cache is either NULL or &sk->sk_v6_daddr
> 
> We do not need 8 bytes, a boolean is enough.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

