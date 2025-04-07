Return-Path: <netdev+bounces-179866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F237DA7EC9B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBD54244A0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756D21ADB2;
	Mon,  7 Apr 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4UScyaM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904252192FB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052004; cv=none; b=c39CNp3ay89qZrBcfsE2RPqqkQHrs729OezcjPqYTd/+FI8tr2zo7CxHANj2JuLxwpMdTXztWKuH5/CQNwvygOJdwUjHqC5mterUWJPDBF5az3uVInxQm6FsUyKF9NiOX1rEUXBfSwhJcvm9FULg2Ultegkp2zkSLK0kYMM75oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052004; c=relaxed/simple;
	bh=sptLx6NyvKObNQQ2RrrWTmA7tHEaXcI8AdxDeN52DRc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dpL0GP1XCq3mESkQ33utHsdfyqQyL3U+2/EsPyDDFqT5WszmFsCVKS4uE+piIoVsVIecBZ2/BkKT4Qyye+uS8zT6hTytkp84EdifGmGl9qRKoxNxixuDZkfWgOJPj6ouCLgcUbgWSXY6E7PcPrcmBH7AoThoyA/AH65OsHkOqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4UScyaM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c592764e54so605428485a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052001; x=1744656801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57T1uU4HJF+2wYX2aK+3oYSk+w+77sDErmU+beNpQEg=;
        b=j4UScyaMShmyHyv4dfK9LEHCnc2SE8oMSQ43S5bq/7Yhxcx36Ssb3mE+x+ibeMrX+R
         HpQBDzK2Am2YHoYjW8/Uw4ii/Oy8mIgfCzVi33zEPqT/5TCiJVnotOEAR8wC7Fps69i5
         LB2e7uksNOFhJRYGFrnE+oMSB16IO2FQnS3pmpjpoodvCoihlYBim9my6w28tEqQoeYb
         Ehtv58tKVYiR935XxwZUeNhp/VFXXk6oCSdCM3AGe88brqwAZl1QDXe2vpYlC0fmBqzj
         jws4AfzYcMQUT9dTCBzKQvNkgTeVoAZAbgKPAJ+dRBDruvJ5u0xUKl8g2CyQxrOho0Pk
         9OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052001; x=1744656801;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57T1uU4HJF+2wYX2aK+3oYSk+w+77sDErmU+beNpQEg=;
        b=Ll4XQk0Z/jyI5dhp6udjI0/EshozBU2LOQ7YE8e3pIpA1zdIY0/yyqAw9g9qhMDWm0
         f5zq7aBlJKl1vdIrhRyZTHIO/jXhnuON/xap0KpxKRt0Y1gjI+bjt6gzR3fG52vBXqXi
         kTo2zQ8XTTKToG/6wPvQK6vwfNUOqzl52k9gtyNBeBgwY08dZ5WXPUPlsRG9mnLKGIqv
         Irqb/yyAWswVk59Haer31/b/RLcVfTVhjaHtUpnx9rjomYFtup/QH0P+brgLftfaDGLl
         SHz2KbxrwY4/zRDDzBQJ2mLC0LAKJgL6LQbJDO8m+R77p37hkJt+cyMznwNLDXPkW+Ed
         T0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXPM+X0mG8AYC62ui4csAiki+94n8l4ZmxGNs6Yc48+buOAcQ8QKyJbKw1ThjRZfJc3XyLIrzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZOtpQ+hYmoU6SoUQCfBDUM42Fi9zLU4Bmw3N6VpkLQ9YlD6c
	nsqnUnaCEIMK6+SM77yULimrI4RwJUWga/FaUfho9MtGRR5aL+y6SkKqvA==
X-Gm-Gg: ASbGncsZGWhiaVtt5KKyYb85t7dmmk3gmPED4tTy5ouzTOjBXkixrVsjwDuGn4AoaUt
	6eB1kC4B3MEiHeWbCYwPbY5/X4U/A2jrvs6qUq0DH+XB9WhErXbPswRU/vFGeebworyeHPNdRiL
	MxvBZLE8s2zfp2NzDlHI6A+AQlzSheSKpvATs0Zlu0YZkhwdUGhMzl1iOTDnjEw6AIVz9ES89nt
	okDxE2zAB0kenJscxdcxoqAi13zFINAF8wL7S1PxoxeWJl27HIRj734+wh5yccxSk/kSAMEDHpN
	4jzB/WclrTWatpT4nVF5PEU6p1I/9YHcCrRlDcw/QvuRNNnQJBeuLKIwRaV7s6r0HpwMBp8SLkS
	xPmb0+1qPUbmT7zDATuyfMQ==
X-Google-Smtp-Source: AGHT+IFBpT7FvyvuwX+5Fv9eZrLxZVblQiK7ESCROonaOsgUpptc62IthOmbfURdmBAuZRZ16w6BHQ==
X-Received: by 2002:a05:620a:192a:b0:7c5:4c49:76a6 with SMTP id af79cd13be357-7c7759eaad8mr1761554985a.8.1744052001227;
        Mon, 07 Apr 2025 11:53:21 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea58da4sm632777585a.82.2025.04.07.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:53:20 -0700 (PDT)
Date: Mon, 07 Apr 2025 14:53:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67f41f203509e_3a74d5294de@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250407163602.170356-2-edumazet@google.com>
References: <20250407163602.170356-1-edumazet@google.com>
 <20250407163602.170356-2-edumazet@google.com>
Subject: Re: [PATCH net-next 1/4] net: rps: change skb_flow_limit() hash
 function
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
> As explained in commit f3483c8e1da6 ("net: rfs: hash function change"),
> masking low order bits of skb_get_hash(skb) has low entropy.
> 
> A NIC with 32 RX queues uses the 5 low order bits of rss key
> to select a queue. This means all packets landing to a given
> queue share the same 5 low order bits.
> 
> Switch to hash_32() to reduce hash collisions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

