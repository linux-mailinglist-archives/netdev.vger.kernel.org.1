Return-Path: <netdev+bounces-180255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A583A80D4B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA22B3A7981
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1981B6CE5;
	Tue,  8 Apr 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD1dMvCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA017A312
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120940; cv=none; b=YqAajVWyk5HwgrdI41xTlWe1/6FSbvFTrFXhmqe+CuaayL0Nzji8dYzOrRYQ14cOMRzU5r+096nyTlxGZOqeosH1vI1UMXOHXI5F8KARSrTdt0hugFMIRelFr3Eo7cgi5sClgmhkw/yqaPb0laySJ6WOuJWBinw3J26EKAHCdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120940; c=relaxed/simple;
	bh=sWLrPPAWiPEyr3Mb7Cd/hV81ilfZrq14nzvn+NwujS4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GYN/ptFWZ/6PeZPFJ8N8tfE3/S2hz1xvoF4dD3q02Cunk743zBg5WFUooDCYLJoWXaaP6EnSdpDXBxBrz4on3Oys1t0diVYo2IiJmaVfmfvyutcihY0DUXv2XF5OkYN9CQJRStxKiBLevAoiQcV44bguoyDx6fDMvQ4F8wnwH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD1dMvCz; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso57446676d6.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744120937; x=1744725737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXqbg+H8Lqi5h9sF60AIhV3WeCcPMPBXJSqNAObKHas=;
        b=cD1dMvCzLj+fKY0YRPsxcGNcy4SRGfb8FjqgQLiAgVMse3JlmPPGaYSgfTtaZ2Gbuc
         j54BhGMONnM7nUkfBKEz27TfVx6CqY5BxedFfmiHP+PTgzQnZ6VRaNQ8kGvYI2fxFS9C
         /Y5kFMluyZdtiFBLrHTq7SeaDaynZI6neyfgG9ackFep4sQGHKzih8NWAVhe4+KvPxot
         5Zw+VjnNPHoV6xLE1IlqUs3guKgRPEvCNBAH+8JLKY2ZD0i6KdcmF2DAS0AVQxjSTnLq
         82MwOLrl48x+3aTY+yBUbQjytJLzn7LoEfuLVUpHEqKFUbLhqbI5u2AGqImuYcnO6zim
         fB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120937; x=1744725737;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SXqbg+H8Lqi5h9sF60AIhV3WeCcPMPBXJSqNAObKHas=;
        b=MYjPW25+5XEJUZ9uTqNiHXDR/AAzenKSvEP5EBrAsNsovC+v1V2MpK5Yh9eyM7NUGa
         1naXRW8I/XBhq47y1170dVBJXy4LO4CFDIlYAhT1rsnnUJk/9Xco6lcd8bInvTqDIQ4+
         t1QMEXOO63rvfvOL6C5vJBBzJTfxjg6QI7FfF6JXLilNECaGOhbereJ1sj12OuQfxnUG
         5Uq68DQTFUy60EN8TDTb+GwSiJw1s97gbcd7uTFAlaZQsHiTHVjcAhzTJoEsMwyTpjBg
         jmiPTqJhA4oXEb0rmFlllnB7r7OPDa/sJigbHutOKEMc0tbbrGJgqkWd2IMzyiRzGxDD
         FCwA==
X-Forwarded-Encrypted: i=1; AJvYcCWDrVrtp5TchvUAOKWeAXl6wmoAV1rMF7ai7EXQGNPtVaGwxyEgGwHPUG2JHgPfK73MMwqzBsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUpRu8tPQmckTy/nAl/pgiJsDtwIcfV/V+uJvTgztpPf50/yZn
	l6Ouleg4B0IDGPEk1roDTsh1XFV5BUDaQEVEq+xp02NREDXfH9D8
X-Gm-Gg: ASbGncs2ZhfGqjmILwzVguVkDy3hvYdKsE39KVvJJOLjrKIltyLlPgEW0iijpvmITLx
	jjSkkgz+0r51qnaDr6pOHcvPH2XzPGSLF+sn6sH7cBuPk3cdQv73Tz2zL44CTkeNj2+ZPr3Yp5v
	PkJtl1cs6HNA0j5tNLi5yCtc1/cAigtJBn66XtSseSvgzvBAEg+hzRztnyKMt/Djp9FFGuujpKM
	bQpaJsxSToMqIVrVUA4Q3mim4KF23fj+EpLOAsnt0A31BnKAtufvweNisqTlGimZG7TwBBXO7Cm
	4lMglDfwrK2+afDhDpBLhQ0mbhj9ADi4s10Q4XkPulmhmTsQj02FD656dLQo21dmOt6Zl0PIJEf
	L7LzDihUBl0qqxCh/fPdpalYyYmqBz4i4
X-Google-Smtp-Source: AGHT+IHXIADAIoJpvPq/XvUeuC122+WhRirT1TrKD5MH+H9BdIAH+/C9NFHnMjCYcWL7Wpgv9pHDuw==
X-Received: by 2002:a05:6214:29c2:b0:6ec:f51f:30e9 with SMTP id 6a1803df08f44-6f058403bf5mr245948796d6.4.1744120937381;
        Tue, 08 Apr 2025 07:02:17 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc0d23sm74698596d6.18.2025.04.08.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:02:16 -0700 (PDT)
Date: Tue, 08 Apr 2025 10:02:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Ido Schimmel <idosch@nvidia.com>
Message-ID: <67f52c6843f94_34067294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250408084316.243559-1-idosch@nvidia.com>
References: <20250408084316.243559-1-idosch@nvidia.com>
Subject: Re: [PATCH net] ipv6: Align behavior across nexthops during path
 selection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> A nexthop is only chosen when the calculated multipath hash falls in the
> nexthop's hash region (i.e., the hash is smaller than the nexthop's hash
> threshold) and when the nexthop is assigned a non-negative score by
> rt6_score_route().
> 
> Commit 4d0ab3a6885e ("ipv6: Start path selection from the first
> nexthop") introduced an unintentional difference between the first
> nexthop and the rest when the score is negative.
> 
> When the first nexthop matches, but has a negative score, the code will
> currently evaluate subsequent nexthops until one is found with a
> non-negative score. On the other hand, when a different nexthop matches,
> but has a negative score, the code will fallback to the nexthop with
> which the selection started ('match').
> 
> Align the behavior across all nexthops and fallback to 'match' when the
> first nexthop matches, but has a negative score.
> 
> Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> Fixes: 4d0ab3a6885e ("ipv6: Start path selection from the first nexthop")
> Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Closes: https://lore.kernel.org/netdev/67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

