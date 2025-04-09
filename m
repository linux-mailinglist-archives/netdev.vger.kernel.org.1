Return-Path: <netdev+bounces-180752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D65A82550
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD938C08DD
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9422641EB;
	Wed,  9 Apr 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHh0uC+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC7263C68
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203078; cv=none; b=QsyeUco+aSNnEtv0CEGEtFDOcFRoP9FFLEu4f+8E0ejnb1lxPW+QvBP5ESefG7RPOqlIJMK3i1PbMN7N9Z8PFHmr7sGlckhe9wYDQTeBfC06bkVHLI1na5GyxUlHAzjyHOOQ2/755CLkV+e4/JyjpCZtzl/kRB/BEutk5QJyE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203078; c=relaxed/simple;
	bh=2e9bYM7rCGL5ghOFqS+0juImjHzFiMVHvRUdkVXPa3o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ra3MM23gvXdXBorD9H6tWwLXmggLFGUNvV3c5pSAHVY9AZ9bY2HCV+5ALKL1maNAMenmzziRHHBs8HUL2ZsxlgN8OLdL5v6oiSX0S1zAHMn0hM4Z9vrQcpOYnPspHTo3dnurWCIqca1n5xAVBJzzlwX4u2hyiyrY5Tpr8UyRMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHh0uC+b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so66108915e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203075; x=1744807875; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2e9bYM7rCGL5ghOFqS+0juImjHzFiMVHvRUdkVXPa3o=;
        b=iHh0uC+bcC30VXVPhOl4bPglHNuDdK9UJLLtTfQtJc6VllntoBsm74CrxPe99vYJ3j
         2/sYAweSD/JKZnG0Hjc+vnD/AbI8Q+xuRCnu+x2D43T8bHhUxNyjTIZOQ8CiCmAU7S6K
         XK+Pt/oxlWQgENGvG5Ym2MMoDLBg2yg3Pf7kPrOY/bz8yrTAfaaKBwEByEB0LUrjDK2d
         Ew/gLvDcOlNigrO9xafE9ixRERj1PkVjMsJLZRD91F6I4FB3ZkbzxleoTHBn6niiO8hn
         cXYGdq9oan+CcHRHdTZ6tYdUhdofK6N4g8ogMyYgiUh5lYg2qEAhXdAxzuk2uJJm5x7P
         yOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203075; x=1744807875;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e9bYM7rCGL5ghOFqS+0juImjHzFiMVHvRUdkVXPa3o=;
        b=PVmgkGjn6TC3fmN7Ih4RAJp74VepYdDaTpTXe56I+uvH9MonF7uyntWdQ5K2gbXUBq
         TCrDO+wclEVycgXJUygZTogU6izl6K+x5oid0/0l8+/SeidfX/vnYsGCpVndyWrpTBV5
         uAY7uX5cqY7ajR/YQROQ+jmhcSouNZKXgzF88kWkd5DlUieelEyBrerKam9TEXt9tGAh
         kBq+OXLJuGduGC2KcGnyFMZL5AT3nT0MZv2C58TApfRcc3t2g1787j3tgYkWAYLMxKzj
         gFfvptQ4sP3k5FjiefYKx44keLi5gXFCCDa+mPmfpolYGmUD0DS6WNXsyLJ7Iu418+IL
         H1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRAhVaLBbK4mm+P+raDMD1JtsBfSlLfus6meRQ3qdBTNPrQZGgjNCBKtwWG7nT7bhMN04wtjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ngEIK3CSHbUTtJXFC8p+i605NS9UB7JSNREq5w6+QXBEAxEW
	1UtASJFY3kuy6YYJvSk7k3xoO56LYHeUkRwICubAbjKvAuFZTFkj
X-Gm-Gg: ASbGncsxqFxHZi6T8c0sCaepD746XFlSul8vEc9Mc6lJR1srZsXeakokAV1bACsbhAE
	IphFjQv6/McfUbMuCul+1CRKqWOzGTI33+D1D6mkm9vGmeE0rAa+5NagXN4t45oS9c9lBg33A3n
	1rWpf/Qq90zZnb3IPHoP8hMDWK5ym/+FTzmtmtFHqKDbPwFuk7zAtYU0TZer9v5BMiS3vnUXg08
	8xNXBHnw+YCZOGhAK5Sg6c1wiIOYZTcjKASOEvLqS6hER7+XagVMwGVKZbVRjj4c9psc7Uin4mA
	/OSqU1UdJoopSOKO/8VoQDK8a3dVRKKEP0XkqqA0DDzkkcsVu6L2MA==
X-Google-Smtp-Source: AGHT+IEkeskq67DVAFwg4fLtHQQ3W4xEEniY+h8qlI+quBIWTJUxOFX6umthmYLXPY+M3Nd3E0CGaw==
X-Received: by 2002:a05:600c:4f53:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-43f29d90286mr6287415e9.0.1744203075012;
        Wed, 09 Apr 2025 05:51:15 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5d31sm15231045e9.35.2025.04.09.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:14 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 07/13] tools: ynl: support creating non-genl
 sockets
In-Reply-To: <20250409000400.492371-8-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:54 -0700")
Date: Wed, 09 Apr 2025 13:25:15 +0100
Message-ID: <m2frih34k4.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Classic netlink has static family IDs specified in YAML,
> there is no family name -> ID lookup. Support providing
> the ID info to the library via the generated struct and
> make library use it. Since NETLINK_ROUTE is ID 0 we need
> an extra boolean to indicate classic_id is to be used.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

