Return-Path: <netdev+bounces-237594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9245C4D949
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCD01898535
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D2734F466;
	Tue, 11 Nov 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka92SsLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B7248F78
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862771; cv=none; b=Bsp9Hjvi9MzEBSOCFfPh7kY5XubVREWnQrYiMHyPNDJX0PQUvuLxcHRZj34gM98yEGq7h2pt1XjVlm2oKmFJcCFuc398a3EV6pq8jZ5lAmCq7qVMtybEJvdgx+ixkwgVZPkE2Uc+Zag/023SjnkcuEikK1YZT9ENnRsCnKinXq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862771; c=relaxed/simple;
	bh=ZrriaY7f3hMQTaJUFpGqsdoFMi1c2aFwgNHHX8pPfuE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=i4g4DYJ/N1zbfNHSI5Q589zSeGIgAGV6d86LI7pztYP9Jwfi+fyXHG65YnmimX21Kj021wQB9aF/KD0DIQBodSetEQB7Sw5Xh4H2PhPa7Q9Ng/UPaF2A0iIAa0/GHRy0RjLW5LGfE+3KzheJOxqnbEODO0kOddVMgWS/Z2Rj7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka92SsLp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775638d819so23445005e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 04:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862768; x=1763467568; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrriaY7f3hMQTaJUFpGqsdoFMi1c2aFwgNHHX8pPfuE=;
        b=Ka92SsLpBSosnHgQDnSJ9rhObb8x0M4za+EDeNOgd5HLVUh0Ww82/ncMqihMX3Qa9V
         8H5IMDR9PtKuBYTyNGxiXFQNESHfr9Lcrw1RfT4L0mjXSwZe7auccE0qxlc0vqFyE8WV
         /n3siSrFMQIbGWRS6kLJ6aioMTWmWU/vq8qSdGhCLKvMBM/A4LCu15ufY5hILjEpZ2Gw
         A78ZOxRBj9DO8dxXp1GFsye0pAz7w14uBBa9ArwlENEEOgXOEyAJVAaHppLgwqhjJamI
         YDwzUXuEP3s5qz/yfVSnWBVFgv0OxJ3MVIB+6maDkkHmy8nQxkgJN4f9ahgudrSjK1MR
         nQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862768; x=1763467568;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZrriaY7f3hMQTaJUFpGqsdoFMi1c2aFwgNHHX8pPfuE=;
        b=P+qoPWvG1nY3g1xi/l1eFIOmV6eXCVrPcFE0Htbfo8w6siok5TpiWWC3Hk4gtbz3m7
         jlk8ztBPTapP+41WtYFA8W+UAafag7JoPRGluLw2HpHqarfdNfzMPgnxtQ1vnUVQXdQJ
         FrDGIyNoDHpeX/PJ8FS8WxO6YcsBx03I9oSGbFI8NGRP/aogalrHrd+6rIIONzTTbF5s
         Ixps3vRkhUorWtyjaFqf39TY56QMHvY7RzIMaBUZsTNHW07UjGGTtohHe+9OagOZq0z0
         +MXIkBK6l2Xy/ZNgaKxI05GtIiC7qvxbjhoIq1dIWu5kXDhc6edekuE9jaLd7gy+yrrI
         hdQA==
X-Gm-Message-State: AOJu0YzQoEWM7Wf/OkbROSskhRuHtGZZYKs6QyApoQHBaGtYGiarm7Pt
	EY2yIiGKrFeuPIEwG2sThZHwXr+DWjC+3OKCrhaqRQE9AevdULvOx5LI
X-Gm-Gg: ASbGncuBedD3vgnrzec/xJWm7aOVhR35iWnziTB5OaFe9K9Vcm5Gh+IY0diBOqYoC7e
	AajGNZRNdtrwEad4/AGUI/iOZES52g2QhIrYU2OLBnzjwoy7Jcc4i/1zEowBfDYznNBcom/mfX2
	pyFxUJtbM7NCYHtQN+Yo4RzFPfbQUs9F+cUPSfMBbzBhGuRMj70jevU8U4yxEcmyzgk06LylLnA
	bgZRWbg/55l20483lhprOnvxyyMR0UegSwAp4D6PJ8Hjp9XUGTvgKP4itdXrVtOlIjKkLZ0ZsJG
	BqUYP43pBPAUhX5ms5bBD7+1SsW85BdndFHZ+25fGp38/wAG1ud1fuC5tAQjMIvhL50N/nUl5Fz
	SCUHBq3bIcLx5D/yapbETcsJw5fvEet/1TCdrApJLvA7mAJ3nxA+UPlze1/ph0pdmYBQNZzY8j4
	mYtZW9aBiRIKcI35TIQBVLUTo=
X-Google-Smtp-Source: AGHT+IEyYDG77M1STNeblmSWekQOp0fQBGtq11ULzfmgoplqW724/CyBqBulA2DwNiDx2tiNvs4SSw==
X-Received: by 2002:a05:600c:1549:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47779260013mr69044815e9.10.1762862768197;
        Tue, 11 Nov 2025 04:06:08 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f46d:4de5:f20a:a3c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477773f7749sm174403575e9.7.2025.11.11.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:06:07 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jan Stancek
 <jstancek@redhat.com>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
  =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Ido Schimmel <idosch@nvidia.com>,  Guillaume Nault
 <gnault@redhat.com>,  Sabrina Dubroca <sd@queasysnail.net>,  Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCHv3 net-next 1/3] tools: ynl: Add MAC address parsing support
In-Reply-To: <20251110100000.3837-2-liuhangbin@gmail.com>
Date: Tue, 11 Nov 2025 10:07:13 +0000
Message-ID: <m2frakq3vy.fsf@gmail.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
	<20251110100000.3837-2-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> Add missing support for parsing MAC addresses when display_hint is 'mac'
> in the YNL library. This enables YNL CLI to accept MAC address strings
> for attributes like lladdr in rt-neigh operations.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

