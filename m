Return-Path: <netdev+bounces-219333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B20B41042
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E73174F0F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D3278E63;
	Tue,  2 Sep 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dle3fUTO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A512773CB;
	Tue,  2 Sep 2025 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853060; cv=none; b=bKLnz6FP/HBjm5XXuU+3phz0LcDHrlP3QfOhy3Zgfw1vUIN7kZNsZ7lDRzLcyE5oPZtvjq6s4tloam0MtVk6n408tteYUDX1OFnxq8j2JSNGgFYkKIbCsLjYvas1CfeoMQ2j7bCGrdxkdYtu6HeC4HfaWMJjLySKx5tQw9ZsKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853060; c=relaxed/simple;
	bh=pDElXPlxysNWbmacgYCCIjzT8CBnCZxPfNk0jsnb1do=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YHHKyR+UADrun4Co+cc7FmbLruMTApeA5+kcrzG/KIRXWdvISlP1p9ncG3T3yFUdKbs8eVjt+1g3F+yyxqPXXLh7DTPkqU+F0jb1ODycwK+KbAX0UA/dK1OhCOwkcgo6+WQ0dlGAB70OGN8yDgsaTLy5av4x7mczkUvLhmcljzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dle3fUTO; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-544a6597c82so1597632e0c.1;
        Tue, 02 Sep 2025 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853058; x=1757457858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSjF4T1Hwo77xpCNosIzPOB627gBX9Y5QCHwTlQLO+c=;
        b=Dle3fUTOpfUZRLioRPsXjPKlaHgo/EQrCLAhFBYovEe5LiIrlWIp3PjPJH8BdCL/T1
         Xwy9qopvKHzjXHMwJxJE3JKuAkP9/2Mj9P7fUja8h/fgDMa7QD7r7cJ59KsqX0f6YtBE
         lvEQ2kgQwt92uITaNaTgyyvgZt2a6Hx83eHtg0wBjTV2dVo1mPxZxeyu6wGQlqfAw00A
         y8qprpx4l2k8mABHNJEn4X9EXMg3v6LR7QiB+JTUwreZ9e7Jz66UJZDxeapXAz7oSVmL
         2za1l6LTnJD7+WyPW5mWDBRmC3iLXKts0TbR8lJ8TpG7wfL49ntAdOxoSZX/ydZa7+t6
         nrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853058; x=1757457858;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SSjF4T1Hwo77xpCNosIzPOB627gBX9Y5QCHwTlQLO+c=;
        b=jqmATZ34ANqSMOW/OB8kTIgS4sGPMKTpg6i93xkNc3CEpjMqr3DNQHRZCvQV+vMjQU
         63dWifq1Py7ZlXTfHDiASaZAr+6S/nZ4xO1fTurDgDssaQZZgTPWOMRZ42UtXl1xfj31
         H5t8OcrsDLHuCQ3IJCO1YSLHknze4fh66qgX7IRo5QyyMlkd1XiNh5qvd7HzjcZ4TeRL
         73o+7QwZYi4HA+FGtpRB6i/mudfYTcvj2LaM0Id2JeyrgBOfI9UAYq+wda5JiwtvAAjV
         BbbjiIeSmLb0V6FH01UO+/QQO01LUoYTHUdcPiYhIezW5jaq4Yf44xVv0V5pBG6oBT35
         UMJw==
X-Forwarded-Encrypted: i=1; AJvYcCVA7c6E4Mt4AEvESXrOYj5jUvTY33PL6aWS/p2War1VI+UCJdjf8LRzWmJtbSgLg38qdjMfPFOEJALX2lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOH3jlA9QiLdzoODktUIrRWYSubTKkWRg7uJpk5Wvvj0xWDqYI
	Gywo7tqGWChAACJeBsJEOMhxQtf3un4/MAfYu3rKfvfD2ze/4zts8uPCbOCFMQ==
X-Gm-Gg: ASbGncu2oZTZYhUP302qk3wHhn2TL8I4W9wIbBwMN0uHOIyDhs3ZtjAa157MNca8oDa
	XMCg8BjGd5yG8tKkBwH8GvjuPUc+ZOgH77Ed+Ce3qBo+A6aMEbwOpS2K7NExYaY9ncLTlx2IMoG
	OsFXsRdbuojx5PDHmrGkAI1+/WNi5t6NWiACwcqv9MFzLiiLbiX+B/CksO4A4bSkJYu3qaZfV/E
	ykXulTNWwzomnwJRHBeCWFjJS6EkzHRwigkZmnaPOHHCG7BlaPq3NB4ZMQFSi+cisXFCInBFgXP
	In3f3COUbBAF84ZdRV6WRp/s1l7Sw7t43M4ciTQjlE7rEQ3v5klTPKgHGBY0z5g6PL4YpOv4Aw8
	gkYZ8PvT3gJXWpeuorbi0pdpg9d52Cn/pFlpinWrnpmPAQlLFaGEimu9kyVvTrGSppONB5mmp5t
	7h4KMOq7NGFvnecLeJEFaCxgY=
X-Google-Smtp-Source: AGHT+IFBUwYB2UafAJcoVgYvi5smXXO0j3kJPgVySw53HU05l3de4kuy/loqjzhuufm5UUWS2SQATQ==
X-Received: by 2002:a05:6122:1d8f:b0:531:19f4:ec19 with SMTP id 71dfb90a1353d-544a02a9c02mr4052236e0c.9.1756853058146;
        Tue, 02 Sep 2025 15:44:18 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54491464b0csm6067110e0c.18.2025.09.02.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:44:17 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:44:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.cc9704ca4054@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-2-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-2-51a03d6411be@debian.org>
Subject: Re: [PATCH 2/7] netpoll: move prepare skb functions to netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Move the UDP packet preparation logic from netpoll core to netconsole
> driver, consolidating network console-specific functionality.
> 
> Changes include:
> - Move netpoll_prepare_skb() from net/core/netpoll.c to netconsole.c
> - Move all UDP/IP header construction helpers (push_udp, push_ipv4,
>   push_ipv6, push_eth, netpoll_udp_checksum) to netconsole.c
> - Add necessary network header includes to netconsole.c
> - Export find_skb() from netpoll core to allow netconsole access
>   * This is temporary, given that skb pool management is a netconsole
>     thing. This will be removed in the upcoming change in this patchset.
> 
> With this in mind, netconsole become another usual netpoll user, by
> calling it with SKBs instead of msgs and len.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

