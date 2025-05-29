Return-Path: <netdev+bounces-194262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA42AC8121
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9752E3ABDE7
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9722F759;
	Thu, 29 May 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JimVV/X9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD522DFB6;
	Thu, 29 May 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537113; cv=none; b=roQahIcVprvtDrqkR3rzpxOlnVfGwGJUX1gHFM8x7XIxUScs80ryjX3LG2oOaMguEm69GGOV+NLUdzmaHMFfoL3xLN3gwTXuSX/TUyvK3TGLHtHckLQEAWkDhsoMRbiO6kpD/aaNJeWhXF/y2srTpM8qzUs8tTa3rcgAoIyxdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537113; c=relaxed/simple;
	bh=W4Eakk//CZD/1pcCK5WWbH414b08UjW/mG8/ZTupKEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvccW8Lxatow/j/rOzF/tMPfQIkDyr2eNMJLxuEfysDQUG3j2agLDdcfL7TsoXRCX0U1in9IWxy3vhN6AuhVoIEiTbLQh3qM69WFcokCo0NDgUCTJQCVrZxw+2tYo/l6iTgEkYkAfMSrsvNLXMkYeQtCNCXEGnX8G7se68j8deQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JimVV/X9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2350fc2591dso5444195ad.1;
        Thu, 29 May 2025 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748537112; x=1749141912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/V3LVqvGBRbRHLON1izXI/6DJpy6GtIlnecMFwbPTk=;
        b=JimVV/X9ym468Xskz8QrcoWDnRybBlos+IXtzesMaKHsmTfbW+szZYZHohhqX2F/LX
         jIT/4KA5DNVV5k77202WWxwM/sJ5B1gL3vhbNzmGeyBEwNiNZ/BEeQtoHPzXUCzif1aG
         IAiwDQGY7WCnAJQZNfoTCVuaQEHIPVnQeVvRp3ZEP1Ta8JTG2CtA5QMC9pmwwWKNFJS+
         DO9D3ErlBTdU5CBlCsUuP0QQfQGsmRPAAo7yd4O4l42nhv2kkPcK3UeASH4+c0IW9Isw
         EY2FsyThvebSH4Pu4SgqiUYPTvR0uSMXQtACL3SjHOBYeoAsmolbq7TWxqOk/IGmPTb4
         3w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537112; x=1749141912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/V3LVqvGBRbRHLON1izXI/6DJpy6GtIlnecMFwbPTk=;
        b=tjegT7yGHlt8QffoLG3ukup1TLf8EJXqbf+z3shkRR7A5yEvPhF/Y+UmqHeAU95Wxg
         O9jdvWr8skGIqm34tTL0Neena2eRMl/8Du+vkCdrAtH67gy8VpsMjlwpdsI7dUlBh76d
         kMb+8CDCIb62bS8FrwCWHhe6orGqE0fJZQaJPrZWNQ3VLxrD6Ew8kCcRkdpI+8EJiLd/
         zX8MDx5GvQh1IFEUUUFBPGFTbKmYIoJgZ4uQ0DcR/akFOZPRfJ9XmKlzKrXyM6ZkRvvX
         RZHIxRQe2vNZ+4ZOGoVcjSuaQ2N4zMX9Bl5PsHrMxEBO6qW+/spnU+sHoFg4w7NvifFF
         hC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEn12szj03icR8HG1QbYYc9S5NDRHl9QltluTP8tTtDdTr7F/1lD/VS8F/Axzp2pnDXgJzwr5P+CMVsd0=@vger.kernel.org, AJvYcCVxybT9oHpnoLipMWoQIUDA9ntVoQxmub4kPI0ejO5eGkY7w+AnPAm0EIHh55uuzMfhizNWqSKK@vger.kernel.org
X-Gm-Message-State: AOJu0YyCU5/CEQmwWLR9cMl6Y86+cYk7Ou9diVtgjRe8dn3kOusu7P5n
	023hdEhvxymp9TT8LwQ0TmIy1dUM2Tm1zUl0++BXl1bqvaybzxJ0QfU=
X-Gm-Gg: ASbGncvkBTcRDv4RRzv8YUEKwPY/x4BX4Cjyasr7dednQ5WsUH3AWnOkf3f5i6d7pn+
	4fmhLYuqIfe9+g3rmVLkuWEXiMm6g95ItVBsU0HYUMZYbsk+v5i8ANwcd7DKSdAafnwT9+i1UJs
	hktLipDXONAAk2Lkrx8yticelgDbHR04WnRxyHzJ8GHlyCzk7XNMbj9ooiXZ0fUjGAhjpEfZelA
	dFiPbEtJt9u+WvoHOmCrJ2XAut3ODzPJzkb0FJrtd84zoUbw8GCwm0B4pxaa5GxFfHAi2yPJUWb
	eW/K2D7uFOJepiLwENFvQKo812Q6uFRRdpi8FAG5YorrQxuYu1ATeOjK61kkygaBrxYgNfeVJMT
	6daTdTE+SSCnS
X-Google-Smtp-Source: AGHT+IGbkQp4pusdpFpco5RbHOf137pHkz17fyX2qzwynbpVmOd+gWiawsLiNAuc3mjDCa6uNuWckA==
X-Received: by 2002:a17:902:d504:b0:21f:6ce8:29df with SMTP id d9443c01a7336-234f6780d43mr56830135ad.3.1748537111521;
        Thu, 29 May 2025 09:45:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506d22d0dsm14304355ad.257.2025.05.29.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:45:11 -0700 (PDT)
Date: Thu, 29 May 2025 09:45:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_newlink
Message-ID: <aDiPFiLrhUI0M2MI@mini-arch>
References: <683837bf.a00a0220.52848.0003.GAE@google.com>
 <aDiEby8WRjJ9Gyfx@mini-arch>
 <20250529091003.3423378b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529091003.3423378b@kernel.org>

On 05/29, Jakub Kicinski wrote:
> On Thu, 29 May 2025 08:59:43 -0700 Stanislav Fomichev wrote:
> > So this is internal WQ entry lock that is being reordered with rtnl
> > lock. But looking at process_one_work, I don't see actual locks, mostly
> > lock_map_acquire/lock_map_release calls to enforce some internal WQ
> > invariants. Not sure what to do with it, will try to read more.
> 
> Basically a flush_work() happens while holding rtnl_lock,
> but the work itself takes that lock. It's a driver bug.

e400c7444d84 ("e1000: Hold RTNL when e1000_down can be called") ?
I think similar things (but wrt netdev instance lock) are happening
with iavf: iavf_remove calls cancel_work_sync while holding the
instance lock and the work callbacks grab the instance lock as well :-/

