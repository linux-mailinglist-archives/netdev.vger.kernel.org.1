Return-Path: <netdev+bounces-74454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553958615BF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6D7B25EBD
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3CE85C53;
	Fri, 23 Feb 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFLizK48"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3985274
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701957; cv=none; b=FzicdiHyNNPLSnf6BA4tMGoSxMD1qATNaJZ2PFSsqcP2HSahPnvIjSg7DCc/5C/qTv/4YPNKfb+zhGH3/bDQqsbf1VqTWnfSbIkox/RM5d2lQKAjpyTbLpKq2cqOlNnV1xb5nQfRuBxMZeyiP6NZqnKw4XCUPLi0byjptibat/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701957; c=relaxed/simple;
	bh=u6pSkQ4sOt5fGCYmFUhQZB64aLd3np11pRKimJsVRkU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FXumZvuzVJakQPUBBVG7SI2R1hFgXpi+SC8EQlbUwznfOfyU5KxfHoVM3GrIlhKVkKh3z9lrLxFID7MPPHAx4txCapnkm+VzaSOKDK+O2WZbGco9c0dALLpfdDUA0GSM//CozsLAVTLweiQXR/kRnLbMrWLWU6tlKguS6bwDE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFLizK48; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d27184197cso5810981fa.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701954; x=1709306754; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6pSkQ4sOt5fGCYmFUhQZB64aLd3np11pRKimJsVRkU=;
        b=gFLizK48wHGeCZgMk2M1YdsfAWZSkaHrQ4eqRjo2/Ayn4IJef256B3hHVETC9hggGm
         ok8OM+6YBDIbG4Ncgs8wLV6tvpj6gEhDS6TJrQYXNY8oZ5VU4bEqezOyoJPIT+U6EXXD
         Ax+2gi/LCjvDPVfiWuNQaM7BAYLAW455WIjNkv0ixHeSntEcyaX72ZoinWcJc17R/HqE
         wmPFQfAf8St/Dfarye0gIk+8Tj6G9p96racI+X85k/0K/sMfMLHl/slOG/cW95PgCgj7
         WeMtU1cJQlFu5cMtt5UAfOGo//pj/2FQ/WHYn6TvWVFxfZr4OOVmxDoxOhAwMS5rKpcm
         JjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701954; x=1709306754;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6pSkQ4sOt5fGCYmFUhQZB64aLd3np11pRKimJsVRkU=;
        b=NnE8wskoHf7DEFrEJkQ2rZsFYBgYEA9o15+t3tv+oGV4eC3GMIimK60qhawfrSBWgI
         mE9Lm8Ec/C1/Nx3exxXs0QRMbvujQ55J4TnsEoMJe3OIar8oifF0JcrPBF8vj4xEKalt
         z/belpMnPpGI1PRbTV2vd7/lbVA1MgFzGUG5ILHQOiIuP3kpXcftmezxt2YTpBnkhJC2
         crPsvyImZ1HOdPaUO2w/1+ecrsAblFCcY6tVHG5Z72bfoRABozOi412BFrdULMNO0ZmX
         BrgJzDoQdImZRSIcRkxE50iYtuMtOvWb5QtPS1pJzCXiHiDQi7VVKBpV5Oh4nje+HxEP
         PVGg==
X-Forwarded-Encrypted: i=1; AJvYcCUAzy1WnJPNKLrYgtJ+D443A70GplS3AFF3SMBQWALJPZ80XXIAyQEwyiqAjSmb2HLofqFPEj2aGH33Drf950xiwrbuCXoq
X-Gm-Message-State: AOJu0Yx3vMGjC6yemjT0gjiKljPTyDz+2hg7K18PHmC0xLSEIDbSu2uI
	7LK4nIsl7NX+yiWHWG0DtY4FjIX2tZeSEcHBi4bTcdVYgWgo+8Ab
X-Google-Smtp-Source: AGHT+IFpWwxqP5cvEVpd6FhIkcTc13XuzS42RtxGs480oFJVngw9eV8JGl5SIjyaYQCeOpDrqjhe5Q==
X-Received: by 2002:a2e:84d0:0:b0:2d0:b758:93a5 with SMTP id q16-20020a2e84d0000000b002d0b75893a5mr135429ljh.18.1708701953928;
        Fri, 23 Feb 2024 07:25:53 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b00410add3af79sm2674915wml.23.2024.02.23.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:53 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 11/14] nexthop: allow
 nexthop_mpath_fill_node() to be called without RTNL
In-Reply-To: <20240222105021.1943116-12-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:18 +0000")
Date: Fri, 23 Feb 2024 15:21:07 +0000
Message-ID: <m28r3bqk9o.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-12-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> nexthop_mpath_fill_node() will be potentially called
> from contexts holding rcu_lock instead of RTNL.
>
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/all/ZdZDWVdjMaQkXBgW@shredder/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

