Return-Path: <netdev+bounces-69647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F179B84C0B5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 00:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D4DB22E20
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 23:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B71C2AE;
	Tue,  6 Feb 2024 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnDGuOfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104B1C68F
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261312; cv=none; b=W6LQ5FJoso4BLaLRoByEg7JFOYIA1HJPzU1gl/lHBGEt/I8KJ5E4XBKyCKz7bzTfmpMA24sNNBgWDZpBc4sDl+VwsKPvuSAr8sY02UsIbv5lnkZ+3zAScLI5UjCcItaObQ5PN8F1UvD99HOr6ByOcD89sd1bMpuR+AxfobeE+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261312; c=relaxed/simple;
	bh=BFCcI8p+nRPXOIBHUWOKBWwydHLiUv/S6nst0MPuWO8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H2FxHK6bfefO72DrFdlyug7yFZD/NNaxb+Vn+0SU0kQBgeV6+uZ1qNXiaQBQHoFhnTQxvfOspqAQ5alHh5CB5WRJfsxc4IaHNfp94eEAO0s+LfcRytI13EyJ3lvAgsv7/8yNvJ/C8ZsD+4UiFz56ZgQ+1htRkuBzkIEPNTUt+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnDGuOfP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60406302a5eso573777b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 15:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707261310; x=1707866110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b3gHWSOwl9C9mczk45Fsi9H1g2BHLWicvr6xe7XELg=;
        b=QnDGuOfPwk5YiMlnIsynGEmDR3YkpajgQZI8d+AcbfdxZE19R7tv5BeyO9C/VrAeHM
         Tyf5gfxikKMXXIBxBaAS0e+CCVcLR4apH9xCPn+VtJLf4Tt0aTBwuaG20g16XyLRAYXP
         U8Gq84RVQfUPk9tUfzArGr1rRKZ2UywxJNuai9T4Deh2FPG9nPTvE8zIeh+OUz0gHAKg
         Fq6ihV+ojIbCl9UoHm6+kUm343hNlucza1pzWSDjWcc2eiDWfkwHRVs5r9cSqBn0n7MI
         lvQnT/8H46DRenP+GCiI3tHnLb5U/M9H9CcoO71Bt2ggZYAhMmNah0R9kw4hX6BzAv3e
         xwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261310; x=1707866110;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7b3gHWSOwl9C9mczk45Fsi9H1g2BHLWicvr6xe7XELg=;
        b=GH8DBXw39hT4FU800WpSJLRapgbmGsJllGCOcvSCRLf+jasaBpvEo60SplO4J5pPBX
         dGdFxsj/s+MwCWL0R+fM65I5s2RU6eYyHxGGtWowz+kjO4aexExAqTgUXzI/f4WoJlXX
         /l3qm5cD09zFKMJcHkqRpJx0OUkot1Uy299WtXHuKG6p1Hfdgs7O9gLr9NZPL0bWW/T8
         oLS7PIcDAmsyFE4tPsn4/yHz4UZLWJhBTTQcxfuT+DJflXgdvfmpk7bBiTENgi+Jy+X6
         jIylplpx8shX2hZwfMA4/gOD5L/FCpHQ6bBf9boqTJ0JpmXou3xpn9QAUbo91Mtc1Rpb
         TwUw==
X-Gm-Message-State: AOJu0Yz87uUy/QLHtCrCEWHpjD8MN6+iPzI6s2DmRfU8JMQNXBswPwwc
	e9ssM9vabODjFVztQ348KqNPsoq8VAf35zPBxy6T/Yn7Bwy1HT8V
X-Google-Smtp-Source: AGHT+IFlkGvCuqMKbRKoq7lhDNt69ojh/YNqM7hvGAra8P9/finB/jKeddnvx29jc8sZSYW84upG3Q==
X-Received: by 2002:a81:c10b:0:b0:604:4bcf:662c with SMTP id f11-20020a81c10b000000b006044bcf662cmr3150369ywi.12.1707261309490;
        Tue, 06 Feb 2024 15:15:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUZPL5hKCZ2JL1uufC3eHjWHeP3EZx79CM0JAMse4bpDFUcY8mtH2LfDgo7+ui5oeteeVzDLIKq6lCNbiG/uM7Tu9Hf91KXKi56zQONe7iCpjqwIeRjGIUUPI5Bk/ua9v5xeVT9ioddn+eJrG17wS1GDScexHUVDsK7B47Ia1ELGKqgsTd1YTagCFkURqBhIXgTeFo1hsB1j8WeZ5P6b6OTnDbhalLMomRDzXQiYPfF7hQNtvkxA6tPPewjsw==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id w9-20020ae9e509000000b007856ed8ff83sm1357296qkf.45.2024.02.06.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:15:09 -0800 (PST)
Date: Tue, 06 Feb 2024 18:15:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 kernel-team@cloudflare.com, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <65c2bd7cd505f_11e19d294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240206-jakub-krn-635-v2-1-81c7967b0624@cloudflare.com>
References: <20240206-jakub-krn-635-v2-1-81c7967b0624@cloudflare.com>
Subject: Re: [PATCH net-next v2] selftests: udpgso: Pull up network setup into
 shell script
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> udpgso regression test configures routing and device MTU directly through
> uAPI (Netlink, ioctl) to do its job. While there is nothing wrong with it,
> it takes more effort than doing it from shell.
> 
> Looking forward, we would like to extend the udpgso regression tests to
> cover the EIO corner case [1], once it gets addressed. That will require a
> dummy device and device feature manipulation to set it up. Which means more
> Netlink code.
> 
> So, in preparation, pull out network configuration into the shell script
> part of the test, so it is easily extendable in the future.
> 
> Also, because it now easy to setup routing, add a second local IPv6
> address. Because the second address is not managed by the kernel, we can
> "replace" the corresponding local route with a reduced-MTU one. This
> unblocks the disabled "ipv6 connected" test case. Add a similar setup for
> IPv4 for symmetry.
> 
> [1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

