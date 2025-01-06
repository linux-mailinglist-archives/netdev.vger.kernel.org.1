Return-Path: <netdev+bounces-155516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ABBA02C6E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E731166B73
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621214A095;
	Mon,  6 Jan 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFCNmwLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38A1DD539
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178790; cv=none; b=ZjvJ/y9auQnO9eOjUHEnOz7A6CrpysrKHTnftVmFLv9AiyQ1TF4iM4ylJQK6XY3lMWpQLgHfSzRBhKr3yVo60tabYXVDBvqh2zUFsPwOWZfM5dJHlj5vBFkd/fkpRq4oArHyJQyj6G58U3sxkKS6XAC58w6oNg+5vuHA4nfDxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178790; c=relaxed/simple;
	bh=/3fyBQSnVje3HOnfZA3DSL5Tba+owFt7wwZfunv1ofY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG8w2YhGbGxTxPmJm5iMDms/ZvbxCbrdnSIFAw9dSGUeVlHuMvkmNd7YKaDb5QnUCQUmdSIyQHYDFnootvnpjkkbJzTIllrGVsprKyJVTOSUauizblBcObHKftVSgCVyba0z94PufrRbYLbHN72EvWDE1Jj/8Fi0+9+/l2pKU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFCNmwLA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso254283755ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 07:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736178788; x=1736783588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vofeaMhTZZtsHte+aS5aYsEVDRnnvlK1gzLLKLChik=;
        b=BFCNmwLAbEcMuCWAQhLzL0mdrSbzwgFW9qdu5LRhDryA9geOHGEdBZHllq3gqOjmGd
         id1QCXKESXfy9bUyj4prkyKL7QhtEOPzlFVHlOx58yRdi6+Hn368v32h65bON8nfrFhm
         XSJc+BDaogsGwqV/zAGLZz6B5ePx91saI1MSPYtDXyiQc4zVmEt6z/mM889ZZWPwx/GY
         I6RHwsaWvrlI1CON4ReehBNZE3hiTeY75idUIHGHeLDo/HKbc3FnOwZHOlZpQ3jHZUiF
         613ewCPqOJTSa9xDJ0amKB6Rf+db99XCZnGDr+Cd+31SCqtId2AzMlXvzuB7VlsWKn5r
         l3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736178788; x=1736783588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vofeaMhTZZtsHte+aS5aYsEVDRnnvlK1gzLLKLChik=;
        b=bEgnmI48xlpyIxEusad7nSrKVykLBlqTCz8yoU2GzY+P1SKfPGCtxG6pGeiz5cD9Ll
         iYiXa0S+cggFXLmyGbJOoiF8OZZ9dsdPkmrRlCQNLSD/2VnqR2fe8NjPhHRW0IxVmGh1
         4iNSR11A6JmcmAhpZRi16y0k6X2bC+4wY8wZXH7QoHurJui+v2bwY9QVitHympgYWJZc
         AoQetZh1AAU24HbcY9CU8e/KPr/EmhSl780tB1n+7iGzUVHx2PQX+37Ywe8ldSUwR9Ql
         z3NW4Rdu7D9TAtbHHTOH+WYIwDIMJFQtk8PkqMYwr4i8SRhSy4kEaYdAM2vKzfnh3Yys
         gGhw==
X-Forwarded-Encrypted: i=1; AJvYcCWKzPmG9xozZ1T2Ipw7DnFyB1mKypBxp3jkA0WP10HuOnP7ALMjbp1z6GRCNxSh2DxHElYjekE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hT+f3ecjmH22ayd9ANroihLh/4ATmPmYQ1zhvpAPh/9gv/Rz
	PCcaMH/FlpmZ7WGThkCzU8DrpTOAhgQXhYsvoM87Ju9Xa/NRqpI=
X-Gm-Gg: ASbGncsGRt1RUHAdySdjOc+d5Wl6ePG1FxeqhyqOjInmLJMpGQw6veIQU7ogTteIdQT
	fYNnD+PgcN/6e/pbyhQ42YJj4qUxgPdPahq4bt2SOYPfVqHLPFH/QZ09zZqq8OfC7LL7ERVSbId
	TZM2ZQGCL9b8lDdXnWfpRZemuXH1pA+Q/JiSNMDILNjGjHCUXYcan5ypfk5eKJkbnLtj+7Q4NVN
	nGmouEqkncBEY7GMhoWzO+b62Hfopn9VzjGa/wxqkm50Iinl94yyoYR
X-Google-Smtp-Source: AGHT+IFvVU4jVg9aoX+KkHFnvu3G1wsNb1ajjhqw2gu1ow40mY5Unkz/abv3SsncTlxRpIx5UUWF5Q==
X-Received: by 2002:a05:6a20:d81b:b0:1e0:c30a:6f22 with SMTP id adf61e73a8af0-1e5e080cba4mr101209433637.40.1736178787649;
        Mon, 06 Jan 2025 07:53:07 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c2e9sm32669256b3a.180.2025.01.06.07.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 07:53:07 -0800 (PST)
Date: Mon, 6 Jan 2025 07:53:06 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/3] tools: ynl: decode link types present in
 tests
Message-ID: <Z3v8Yn80sAL_qjIg@mini-arch>
References: <20250105012523.1722231-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250105012523.1722231-1-kuba@kernel.org>

On 01/04, Jakub Kicinski wrote:
> Using a kernel built for the net selftest target to run drivers/net
> tests currently fails, because the net kernel automatically spawns
> a handful of tunnel devices which YNL can't decode.
> 
> Fill in those missing link types in rt_link. We need to extend subset
> support a bit for it to work.
> 
> Jakub Kicinski (3):
>   tools: ynl: correctly handle overrides of fields in subset
>   tools: ynl: print some information about attribute we can't parse
>   netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs
> 
>  Documentation/netlink/specs/rt_link.yaml | 87 ++++++++++++++++++++++++
>  tools/net/ynl/lib/nlspec.py              |  5 +-
>  tools/net/ynl/lib/ynl.py                 | 72 +++++++++++---------
>  3 files changed, 129 insertions(+), 35 deletions(-)

I've seen similar issues with (builtin) ip6tnl in my VMs, thanks for
fixing!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

