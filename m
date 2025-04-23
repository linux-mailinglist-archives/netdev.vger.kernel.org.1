Return-Path: <netdev+bounces-184946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6EBA97C38
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0945D17F356
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630925F992;
	Wed, 23 Apr 2025 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJpfaugA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479D256C84
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372592; cv=none; b=dJiBQUhxVxlyNaUKTDmVnLx7yRWCvnQ/4fOZeANuulkYp7CNvOTJTBjsjzEknBAddclJxw7p3WX/qQndv+WbVWHAOEKqrSRmP+lVzv8ZecQROB/P82M71RlefADQo6xnXfgWJrHfSeu0BeT4JYWWhuzM2M/JzR0Ng13wmfUT6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372592; c=relaxed/simple;
	bh=RnMAfj5gjNafYU7AP+ooqso0i5vh2wJQEYo8eJYCy9w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=atH7a+qx1f2eUBOLPCiADNbqbsP3V43BmBDTB9YRxDtkbUu3LEh1can0xGGqKRAsvBhrSys+I7p0ZYnv6uGBhmHp7watBJ2X1d6ZSpYd2vEsoeHEr7WRHEbZ4Ry1MqH8kkVdOekGxciWLfoDPP9DNl0SLHft7qVjZqfZY0y7gu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJpfaugA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af548cb1f83so5642645a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745372589; x=1745977389; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ksdzmp2QqAdsXB4A9m/fErScbuOtpfwOq24glnlcapI=;
        b=SJpfaugAvSq4y5wmN0tWbkYqSyDj32pY/xZ/o/Pr7RbgafxmIzw873hzPap07LfUZF
         4vIoknUaRtlLub5FBtScCI8XFub6lTiaK7ANmGaIueLzoijE9MDZGjG+gPyIxbWVsEHg
         8jWVDuRXflEVHLcx8IiyzNVAohpIKHZTunlH3qKJfBCeMFbI2JcZ1Fn8jKoZAfGi0guL
         +U3sogbjDb7alRoc7CwVqWh7dlRiQty3F9RLi2XFVtgbGlwZ9rzoYkCjhSPwRY/umYqG
         +TtEArqtb/MSfMGuMYrjfReTduPWAKe0BUk+9+fV1WTQwhpxgtvBGASpF0rATm3UbsDZ
         hciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745372589; x=1745977389;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksdzmp2QqAdsXB4A9m/fErScbuOtpfwOq24glnlcapI=;
        b=JuxFV8PZP2xUY43E45e0NNc+dSSdFZpP+oiEwE99Jm0I53Suy8dT0F0iNhw+ekUGus
         BvX5Z4dA4N2x/33R4Kgvd03ykblSr8X25aNKA6uD02je4Jh3O2TetjAvp2ge8xJTwWDV
         au0ySlGRvyaBGM20K8IkdQ1wil8ycybo9tuWuESrtQfYbhSMG108O5GUK5WGMgcmojAC
         AbEfeA5wINsRFwP4NQUDJxvD4YJfa/jGbPpmXybYIrHs22deioSqu5VSRn6ydE8kMWqe
         Lkcj/PhanPlw68fm5lgRu/ESqm0Kgx5D2O39ocqNWdWpjCzDWNOV3JgaH3mFGw1/eeYV
         T33Q==
X-Gm-Message-State: AOJu0YyQaJlxrwhafGOTGS/4v96P5s0MfAYwPBSc9VtrAPDcoT+ghrIi
	cApUYm0opKfR1W+c9mWR3lghxjxXPKQAsP0RV6k1CRYfhwnqzYBXqemBxs0NtA30Xxbm86ceV7A
	RqPyhCwR+wxHi4lK/qu1XT+cPpR7uGVXH
X-Gm-Gg: ASbGnctcwwgXJVlV/BtKE+rh+G86kFX42sqiS9rswjMqD9HxeGf7Kt6ZgxoNhUNqUGE
	Yjd9dTP4iqpkNQNLxC877YU9hJWiFngBLt+jChE0gOt2gMjg7+C6JKLUFStpN0abmsOhc+tF/wG
	r4rJx3/lBDkSCZ/BhZwXTuhH3SSc6dy4Ey+9xprdo59LGaeJuGnzrW3SzA
X-Google-Smtp-Source: AGHT+IFurak+rpM4uDd0RXTdNEwyAuTZlDflmLhafDG6OkyjEGS+C5x0p8AMNIJA4f8Rs5J6HuSqg6DH0kNNHxFd2E0=
X-Received: by 2002:a17:90b:4d0e:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-3087bb698dbmr27828691a91.17.1745372589343; Tue, 22 Apr 2025
 18:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SIMON BABY <simonkbaby@gmail.com>
Date: Tue, 22 Apr 2025 18:42:58 -0700
X-Gm-Features: ATxdqUGlaQ4ApIiOr2aFHB9jkG-nDZvNqBmdkphHJA6EduZkadum0I2jFScPqUg
Message-ID: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
Subject: query on EAPOL multicast packet with linux bridge interface
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have a difficulty with making EAPOL packet forwarding with the Linux
bridge interface.

 I have configured the group_fwd_mask parameter with the below value.

 echo 8 > /sys/class/net/br0/bridge/group_fwd_mask

I still could not see the EAPOL packets being forwarded  from the
linux bridge interface . However I can see the EAPOL packets are
forwarded if I use it as a regular interface.

Do we have any more settings?


Regards
Simon

