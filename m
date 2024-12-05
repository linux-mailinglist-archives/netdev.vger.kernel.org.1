Return-Path: <netdev+bounces-149484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF29E5C20
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B148E18842C0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DE224AEB;
	Thu,  5 Dec 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUyaeouY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4F17E473;
	Thu,  5 Dec 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417449; cv=none; b=BKrIPay/asOLquPUVlURdcw+4ruoQzhuJTvPvpQGF+Ti9Sl5ruGDm07b4mHUIJZci2s0sxxQ3+geUm+ucBRD2Tx1XJjMZ/9nETr3iisQjSFJpIWvVuf0EicJCnLGApTcs1VU+MoEJu4CINPf7TS1gaQfBBjcDz8SBsI6qUIEn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417449; c=relaxed/simple;
	bh=oGfWW60F9GXeis13WJQH1YWP9uI8wK159nVr4TCspJk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AuCXVvpMwacI3KwN4LiUSzkOtOxSJITqysyI853sQGNdn7v/EVc3DRcWvN46P9TnU4S6TJ+DGtLkvmtJxzsXryBHqqBCyG5wi7DmsyvU2vesCCXbTmrfU8s56L4ihrVI5bxNOpPYYwbKHj0j0JXA8h4BjYsYCffJTFc8wikjVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUyaeouY; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afa525d6bdso326600137.3;
        Thu, 05 Dec 2024 08:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733417447; x=1734022247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ip7g8ZBAyv55LDWoEeh4pNG9nPsy9ulRpf+djAImBI=;
        b=VUyaeouYGVVEdUlTiFV2iVA7/n/1mK2AetRwEmYDd8bJRv87WcqCDL+qKUKmTIEwZq
         WRzWIhBYjxz3yTFR8GE0zzvQB4gawVDWq9Vemw15BcCmficUHJ3lkyYy65b33NvWecwz
         RPsSsFmQbu8411tQQbiUOuHxbUow+6Y0alQpHqAfeXOFUYnpH46NW9KmgNovTzI03FEi
         cwKjqyDLi3xpbC/D60/rwkpnQEVMF0grShwkRr742DR3qiPfl/mEz/ZIhLSTiCliqOEq
         skxvI8WNPYUEK6JOSP0Hw0yi2uWMlv0ud5WmoewUrDANhiSzZKNWe5da18TiwmaD7WXY
         m7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417447; x=1734022247;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ip7g8ZBAyv55LDWoEeh4pNG9nPsy9ulRpf+djAImBI=;
        b=PhxWnNdS7wOrN+EDJTvz548/p0MRNVECnOGZLakQ3Kj49U6oUwU+ayI9fFc8AMZlff
         /UP+7AjjSaYhkVWBC9t1Trm/DklgLEWZEChjMFmSryyNiIIWPss6mUewe4K4fvCN6ehI
         au602LloOJqxAOBLjoLPKnDERMa5kzCWpYyFnGvT0fscbl3qmaS6CNJQltNicEHRGcqY
         7vGlxJSfMtE4efcqnI22oLknDr+9WGQSKJ7ZP91QJpkZstk69rR7CdoqEJl7rhMmKPZU
         t+PRVbkoqrlACimNtrxUSePgYnXiDe1m7BcACU1IKF38t8n+33tT+7JjJzHLWOHGmHcH
         U23Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLmL2JkQEfWp2ik6GE9X8wDcukOKkEmsb4pHAEvwuKzhc5/W3XNad+w+bi1iR1uucFYo/nSg4n@vger.kernel.org, AJvYcCVR1bwzoHQJ9HNxgJIuV+XHwyRHbILXw7c8kbCew1rt3Rkg3lHmh89cWPMDtTK8KrOVFZkTOIYksQRT9SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpx97e+xLmsxWD2d50V5OGu/aJdlZJSh56s6vAH1rn8HIE7vFB
	TLzghATBE0NmoOBFPpIKwvHOUopsXwJRu9UYaSIKDsnNgRrvm6H1SHVGsg==
X-Gm-Gg: ASbGncsVqRxiJHM1qTWgolYuTuvmJtaqbFbhiVpZc0TUHgRlQyEUw/6l4S4cGamyqmK
	OasdpczDZQ6cNpBf1nzT+5wOS66tPd5oX8rlyaYlKj22USr+VMKONnOiM9sGT46ScrFgyBGgWUj
	yYMUprCRI467KzHBG01S8poWSJMqFMDM+A/nYmXglF7iK0udkMe3dQBJkGwTOlOVt0bLEq8dE6T
	viJUAk7Wc99hUlSnG2XMfAM6qZTRNIQFD3S5RMj3LRucq/2kwBPVBAWpA9T75DqeAyOQ7orKROe
	vKDZ4ZmStnGgdMzJX5PvxQ==
X-Google-Smtp-Source: AGHT+IHokD67x/rwM1UuTEmWeEKMCDNmnPwBDnY+8t30KDYA5tginYlfFZxDnAm4nG2hv2sAzxdyCQ==
X-Received: by 2002:a05:6102:5128:b0:4af:597b:f6 with SMTP id ada2fe7eead31-4afcaa10028mr6691137.4.1733417446716;
        Thu, 05 Dec 2024 08:50:46 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4afbc5e6e22sm244771137.15.2024.12.05.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:50:45 -0800 (PST)
Date: Thu, 05 Dec 2024 11:50:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stas Sergeev <stsp2@yandex.ru>, 
 netdev@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <6751d9e5254ac_119ae629486@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241205073614.294773-1-stsp2@yandex.ru>
References: <20241205073614.294773-1-stsp2@yandex.ru>
Subject: Re: [PATCH net-next] tun: fix group permission check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stas Sergeev wrote:
> Currently tun checks the group permission even if the user have matched.
> Besides going against the usual permission semantic, this has a
> very interesting implication: if the tun group is not among the
> supplementary groups of the tun user, then effectively no one can
> access the tun device. CAP_SYS_ADMIN still can, but its the same as
> not setting the tun ownership.
> 
> This patch relaxes the group checking so that either the user match
> or the group match is enough. This avoids the situation when no one
> can access the device even though the ownership is properly set.
> 
> Also I simplified the logic by removing the redundant inversions:
> tun_not_capable() --> !tun_capable()
> 
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> 
> CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: netdev@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

Reviewed-by: Willem de Bruijn <willemb@google.com>

A lot more readable this way too.

