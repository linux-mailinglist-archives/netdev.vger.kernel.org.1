Return-Path: <netdev+bounces-165620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C452A32D24
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7054A1692EE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADEA2144AC;
	Wed, 12 Feb 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYa2WJN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB200253F07
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380322; cv=none; b=FK2uhWKvvT55ldK7lcPmMPvcllaVZYlzrRSg0zuGe3WRwHGq/lNPqbM7mladm6rb02XUtjsPdaYdd3jc+0QLvs8cHmzXHQGNjNRbzh1mEDd3kjfm0H7Vac2QfgdK2wiB5HlHEcK6zm9JibGKoxEnr6m2Eyoq7vzh5fBHEU4r7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380322; c=relaxed/simple;
	bh=XrtHcqcd72HuHAMtxE4pINEIw6fbepA9iNe1tzQbNbA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OM2q/CJQkqbKDWX+zZGQO//m5e2tDv98qDYcSH6VKdWQn2SE2d9CkhwVN0ztKav/ndaFegWO9i5dwQXZkwJAB5pU2R0cTH7o+UPADbpw5OiykvSPes4azaj1UInxY8hgICxvcfM/zT4Wj7lh4DoSRO3E/cHakELzSMRqjr31ROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYa2WJN5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e4505134c4so65414266d6.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380320; x=1739985120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LomJcjzw+VwmTTKcIz4GQ3Y18HFd8reLoLM3JvSsaI=;
        b=iYa2WJN5zpgON0Rg8TEb+fIajbzhwsmwCeCJ2X5gzXK2h6p/nQX0su7AK8JgFyQDC+
         4QMn33RHbQdiWhLOjLcLNuJXV13Sxu1Hk21RX+IWLu8nVAse+6gFozzyyppxW50oIUNo
         tep4jEKS4TC1HuFYpK4E080by8L+jGnGDz98TRkNV9eYwkYxAZDYfw3nqeDRTi7d6Z/D
         95yjPIs/TvZMMIb34ykQPvvWIftkidP39MMsIFKc6SjGld1YBkw3QmGDaNXs2QbK9BXP
         ADlUdY5OKDX6ZhHCg6R7Y46QCsb8zHp3KUchYthT2Imd0mkzMvldjcSZ84wNoajRQKvE
         B33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380320; x=1739985120;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0LomJcjzw+VwmTTKcIz4GQ3Y18HFd8reLoLM3JvSsaI=;
        b=uMbEuzLgjWzIN8r0bf5Xcd4GWQxl812KyP0Ihfk8SPBO+57H/THHFdxP/8C8E6jhpL
         0c79oYeU+eq3zNOuRJjlnl9x29uILeuUxiN6xgcPxHDSIuOjJq2R3i0kMlvObxsB+rbL
         GRqOU7zqmJemB6Wtkv5Sro5ioBA8zxZS4R0SL5IgdTUPJHygbOZCpu/yKNL75uvQWIIz
         P+HF8uqAm9QcDqn1gRK0fU3inv73D4D+eTKLgbPxHBcbYDGNshSVtTpdLiYTFrcnmNz/
         MoLZi2T9k/5ipB3JYDpvTNhAlZtiYqcuTBzOVlXMLwNLNYiMNONB712sQen1dAFmAklK
         zguA==
X-Gm-Message-State: AOJu0Yz1yONMDEMJnsIxlGThb5jnMmrsgo45bs/mK3CTgCcxAPGpE0ID
	RWZrYUEcdS/XQjjkGMrmTCJQ1SYQpquZqP4bMiGbhY0M4pW1//ny
X-Gm-Gg: ASbGncujp84+Z2If40omZ8v3y+y0RVf8CEv05NSEoXUi31qwa4SXSnNeLXPkV3oZxHy
	fjMLZis+i61F3mr1TyTKw9eMOFcuFUHIO44GbjMp5n/mkwA6vnecIWMVd+wK/cFLyZkl8dCRV0Y
	0OItnc5w/t/pduY4zhpI/s+kp3atEbskbifYoaNVYxmaZTYu4RAwGt0tDgo1BbS3N1/BJzlAEg4
	jJM7wfrRSOfBPLV3XfiF2FqOYqIaW4g3ixckTGbJLwx7kHoNnu96c4Cldsf/1Oe/GbqU2rfMKD4
	z2WH3nV+SMHk9sQ064EcxciYi1JiBbvob9BfjdEjnZRYqBd5aUb9NjfDdfcdaDY=
X-Google-Smtp-Source: AGHT+IFIqHSkTfBBBdAGwGtBsDv4gF5ow+2u4w1MRpG1IbSwgh/Sxeu3/aqco6KheAK2ybXSsHercw==
X-Received: by 2002:a05:6214:21e2:b0:6d8:aba8:837b with SMTP id 6a1803df08f44-6e65c1a3d93mr3146536d6.41.1739380319596;
        Wed, 12 Feb 2025 09:11:59 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44405b028sm73300306d6.78.2025.02.12.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:11:59 -0800 (PST)
Date: Wed, 12 Feb 2025 12:11:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67acd65eb7c0d_1c9bdf2947f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250212132418.1524422-5-edumazet@google.com>
References: <20250212132418.1524422-1-edumazet@google.com>
 <20250212132418.1524422-5-edumazet@google.com>
Subject: Re: [PATCH v2 net-next 4/4] udp: use EXPORT_IPV6_MOD[_GPL]()
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
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> to be exported unless CONFIG_IPV6=m
> 
> udp_table is no longer used from any modules, and does not
> need to be exported anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

