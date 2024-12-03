Return-Path: <netdev+bounces-148334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04389E127E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 05:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB4C282FEF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB2714F104;
	Tue,  3 Dec 2024 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6nGWN8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF831F95A;
	Tue,  3 Dec 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200956; cv=none; b=J/FNHvT4jFgreHCbnWnajXestNH/BiAX1r4J1NyG+1baAWChAumuJW2fDSGV46eJFwM4nZ3RAMzbJYeYwPHt7zlEL0b26leea2NqmcGENTrNRB8+7cPTwMq0nettEeEVHz9VUCNrt1JtKcNImPdooTiNu5Qb4Nn+IS7x7eJUOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200956; c=relaxed/simple;
	bh=ViVAqjjZvLV58URuz15D/sZ4aJArxNvxN7MtA8SFwNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9oRWGuzw8W6MUrl0ugyJsU7SX33FOr3m2guiQDmdN46UfgeMXeLGyIuc0fP+7XNKnC94nqUzjKHoJ5QxDikfsivLGRHIKv2ftWZ8EJYTqlxG06ydLiuqGnQzGdpAXOX9KhT2Yk1/EVC0zdOSLLJT+ZSdYp3GyR+KCWNFakQNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6nGWN8C; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51536c8a7bfso57048e0c.1;
        Mon, 02 Dec 2024 20:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733200953; x=1733805753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ViVAqjjZvLV58URuz15D/sZ4aJArxNvxN7MtA8SFwNo=;
        b=T6nGWN8CAFhWYTQZnThNe5nTN4n/4yzHQ5BW9GsRHrxQ28+Hjp7Ct6hg+/9JEsB97M
         Y37e/Yj2oJbMl/aLXN+b5y43wAFy0gwr6XNLYBIxulmNig+Pyz1uV4dYNVQR73XGbpf8
         7pFM9Ffj+I6Dfvt07EtieCK92BvphXOk1rYmzG7OftCtp87QpTo6Kz3qIWg7L5J6Dovx
         EKBeDstyes6vAqysdpO1OEZkpmylRjN/kUU4ZUUH0OZHv4TL+jCLYAG5mDb+jCtZujZD
         Rhp1uW2ESgfJiRf6wSh10WmFiY/Sd9IkiOamvVKfElhyogdQdxz2/IOyLam2tGmSSrov
         jJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733200953; x=1733805753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViVAqjjZvLV58URuz15D/sZ4aJArxNvxN7MtA8SFwNo=;
        b=qTbED4E7kQTfm4iw2ewxenXYTLevesetZhBACgC5H2q8O/569JGuaGPuXtrPO2EBrr
         zY8/moA+CLnj9WJz541XvQqertiM76MIYqfQ9uKlq3pfnL0HfF8T57/3nyPf0JIsz0Ul
         L3XjBkstVNbTCqyThWnGdyaLfDcMTWWPflQko8pacN00B26IJ1ZyaS0lRrVEt7gEGNFB
         Vk2Qtt8xeTZu3wlOp8aT3XyjH9TJx1eo43sjdw/97vOHwEztx0Kql3hSrUEGEhl9++Kg
         qyMeZ32tz9Evs7VJOPCDqvnj9htjySdE78EFdqoKr36iTb7xOyQzh/6q2o1paL8pBV4m
         R57Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2lG5994uqd8nCtkNVlEHY38ceUru3o37DibFCRhAYgn2pYAKygY6G3NraT8vxeLC8+xHkF0TX5yuVai4=@vger.kernel.org, AJvYcCXHDtQYEquvV8/7WlVL/vVumRxNMCrWRQtltL2cXRNJ9lyOw4bdG8FM+5p9HVLje7D2zfnxPQ8O@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzrsdD7TBmbQ75kV7LKnw0TylOyTE6TvNFgGPe858EO8ymIve
	qy3HixhDUSEiFd8nP6qccFk8RbdksMrtp4PuXYbSJc0Q3xr7Km5ErQx+IPEmYe3+fEeDWz48bcB
	evkWJIWh6D1KxW0JqMEmlU+xJ4+0=
X-Gm-Gg: ASbGncsK8iJnPy2h4Fla7siFL7vrKNKz18wSsgkqGCtNZZaFlb4/i0jD/jn4wN3dPto
	JG7F/RFipMZQ0uFOO/2F97KuGFzKq0CLSpA==
X-Google-Smtp-Source: AGHT+IHy5MlyFI8+A3Hmc1+MN3o57bD5DE0ACBL7TEQs72+4w5qltLSrPxiJCGtgb8hsoJmY14HNf1fuOt/O4bmHJvI=
X-Received: by 2002:a05:6102:2ad2:b0:4af:9805:104e with SMTP id
 ada2fe7eead31-4af9999c611mr313903137.8.1733200953557; Mon, 02 Dec 2024
 20:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202195029.2045633-1-kmlinuxm@gmail.com> <690e556f-a486-41e3-99ef-c29cb0a26d83@lunn.ch>
 <CAHwZ4N3dn+jWG0Hbz2ptPRyA3i1SwCq1F7ipgMdwBaahntqkjA@mail.gmail.com> <aa36e5a4-e7d2-4755-b2a1-58dc5a60af1c@lunn.ch>
In-Reply-To: <aa36e5a4-e7d2-4755-b2a1-58dc5a60af1c@lunn.ch>
From: =?UTF-8?B?5LiH6Ie06L+c?= <kmlinuxm@gmail.com>
Date: Tue, 3 Dec 2024 12:42:23 +0800
Message-ID: <CAHwZ4N0y9b7XKmkbUWDox0-wga5VW706417X6goNv0LsHwPW2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: phy: realtek: add combo mode support for RTL8211FS
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Content-Type: text/plain; charset="UTF-8"

On 2024/12/3 11:53, Andrew Lunn wrote:
> No, it needs a lot more work than just that. Spend some time to really
> understand how the marvell driver handles either copper or fibre, and
> assume the Rockchip SDK is poor quality code.
>
I'm currently busy for a new IC project so I might not have much time
working on this patch, would you like to accept the another patch about
broadcasting PHY address?
> It might also be that the marvell scheme does not work. It will depend
> on how the PHY actually works.
In fact I don't familiar with how thisworks and which function will
handle link-state change callback, yeh, Rockchip SDK is indeed filled
with low-quality code but it

Sincerely,
Zhiyuan Wan

