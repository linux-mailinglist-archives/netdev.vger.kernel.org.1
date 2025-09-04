Return-Path: <netdev+bounces-219981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72974B43FF5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422A5A04A57
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B7308F07;
	Thu,  4 Sep 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UmgIrN24"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E81EB9F2
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998397; cv=none; b=UZXZrq3PiqHNK8Tn5Dn5Sx/0TPt1Y8pcLpiGrDOpALdq1/ldyo8oa9YpPZ3wiqPLZmgfF1kChnXvrjPZuH3RlYzmuQpfHIO2QAuNP1e0Qi/fswsXKmo8/f4YUdYP434nuvzweMvi1kOqtxF3xi5VTq1eIcQQJB2fzL7XSiOtrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998397; c=relaxed/simple;
	bh=GjIMhldMZjLi/k1VMDA0uSdrpQ2tcOhNKetfFoIFYTw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=CPzpazckDqoRiP7Q03qwkESXYvKcPQeLSWpeuMVXJ08TTXJyiyAsyWTEYeQxbWzli2jhH2lk5M+Y1Q12qp6NuBxWSRtHQDtDt11OtZ6n65yUKB2HjidluG95Go9qLrHrSeBdsc4DjKmGVFV67bZ8q4/0LcjAx0nK2jwCGWnbIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UmgIrN24; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80e33b9e2d3so101230885a.2
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998393; x=1757603193; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7YNCGfuLeRJGDFZxThdtxp2uXd/nIXSU1+d/iqpvn4=;
        b=UmgIrN24bZcnKDgQ+hfbmlbI0EQX7VCiJ0iyk6Ht7loHlFNEh3cSEFxt1ZvIsQOUZp
         61rke9doJgKSUWbMEJMYeLPaOsdJvRBpdys1a53xdDMMcIMcdFBwg1V6w37X6zNxMQQD
         m3YGJ/jWzQA8fwaoOVfGDUQTEqtDZgznENXvO6I/KyW+bV2esFgYkKcDcCzIheBzXICQ
         c4XlQhhGBy9+fQ4CCPd+8k83FzrlLRomG6JUoNdYqyn5fAM337Pn68z8FTLAtGOxDD3R
         UJ1xhBPlWvEMAXVyicR16D59bY5BRqTotBv3p6JCgsy8D3MZpuXnOazdo7RH+rDO2+tr
         G/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998393; x=1757603193;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+7YNCGfuLeRJGDFZxThdtxp2uXd/nIXSU1+d/iqpvn4=;
        b=DUoYNOUWRbj+aulw5xcmHJeqtUNcUki6KNCg5kv9NOWneKdCnzygvC0v3CXPuodXHT
         9xxdiLvPqAtn++OVNfWFgKI0CfPTJ5nESxvSBJCFQwPGQ5FiyuvsKX4Y9dirJ/7JpS5V
         H5YQJFOx5JiRP24GuBArFreWsyRjS72J7AMBVTE09u8jTpIj8hxQNTMKrldjV1XJh90K
         WYbux5TQK+/GN0zePUnMbjDqGOfyyLjw68emAK0QmYAbJQYagaRkIkkJBgcu0SNL3x/5
         gGdnaGY7jB5v+QIsnKkCV3ODCW9K/9BX5aU2IYnGC3sNtUo0q/nyPz/5WmH8gnYbw/Gl
         b26Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjvM1m0/Tsg34BUzPlhcBRjYWlVBMpax18NM02L7/CTWVgMSdU13nE3vV1aKjhAPN9pAWQvnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2GMC+FtDCd4K2O1ZnQa7vnUCryH8b3cvOeIDqDhplKiHO8yd
	4MfW0fD9Fp9+rjz0B3N2WUO7FVAGzijEfyh46KDaYmJZZSxJJynv25yGp4Cmlj9v7A==
X-Gm-Gg: ASbGncvn5MzpsQmO+vt7rNWKawuGJoTN8FLEV5Ay38F7UpvnbwVMRJAa2CaroHX/FDL
	ggx6dcOrDfInjbyiz6M+kSnZghexQnzlICfM6zprZI0RVZWjtmFiQ8m4FKXkteEwaolbqyWi+H0
	JXQZeqh8JpDrDBg4ssiaV6ATv6L99fbNkUVEDeYVowZx0gxAXABxzEG3/IQkv6ENw1cwE54hjLA
	mkxtC47F00MGXYhy9/V/E2nukKGwXN+IoiVneFu3MFdZy0UVBMoajzfhNMTBW0yz4+0OGeLeRwz
	FJtm+cPZx9Jz7y2oCJqP1Bdhkj6ItPIjmFpBAoRvjUJwGkBFiEDupnpP5NGS9pbiRz1PXQxlRTg
	BqV1P93JbT3LoW3r1uiZtCyT65FriiOyAlssP9RInXV7qR3yFM8+PvtgJ2wuqjQ2kLAxgxRtar6
	MCT0Q=
X-Google-Smtp-Source: AGHT+IHEZYUVpRQ02k7NJUaQish8Bi6v9XojrzC/OeiOZRuFggywJiau6M41XffV1wTKoVjcjfFHig==
X-Received: by 2002:a05:620a:1a81:b0:7e8:14c:d1a9 with SMTP id af79cd13be357-7ff27b20216mr2265110885a.28.1756998393152;
        Thu, 04 Sep 2025 08:06:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aac237b51sm289724485a.61.2025.09.04.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:06:32 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:06:31 -0400
Message-ID: <cde565adc43452e83958fbe0ab54080d@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250903_1645/pstg-lib:20250903_1606/pstg-pwork:20250903_1645
From: Paul Moore <paul@paul-moore.com>
To: Eric Dumazet <edumazet@google.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Subject: Re: [PATCH] audit: init ab->skb_list earlier in audit_buffer_alloc()
References: <20250904072537.2278210-1-edumazet@google.com>
In-Reply-To: <20250904072537.2278210-1-edumazet@google.com>

On Sep  4, 2025 Eric Dumazet <edumazet@google.com> wrote:
> 
> syzbot found a bug in audit_buffer_alloc() if nlmsg_new() returns NULL.
> 
> We need to initialize ab->skb_list before calling audit_buffer_free()
> which will use both the skb_list spinlock and list pointers.
> 
> Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")
> Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/68b93e3c.a00a0220.eb3d.0000.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: audit@vger.kernel.org
> ---
>  kernel/audit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks Eric, merged into audit/dev.

--
paul-moore.com

