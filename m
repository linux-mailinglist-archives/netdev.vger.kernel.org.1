Return-Path: <netdev+bounces-182925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1305A8A5C6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27A23BFF7D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6A2144DB;
	Tue, 15 Apr 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+q+APth"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A67187332;
	Tue, 15 Apr 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738597; cv=none; b=GpdZVniuI2OoPk+le7CMSjBH3z5Sa3zTUsCHa+pVTHBM1vfVWVz/GJrB9pS4MKdVu54rThIC9BWkq0hNe9IiwAi7xzGRybyNCgCpA1w4pt3LG+yXeM8wDyOOtQU73w4CYCoI8KYQrSOyUVREDYTuT0et3IYjBZEuNJFXytP9TDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738597; c=relaxed/simple;
	bh=vQM80CjrqyDAdAIX49jvUzOyW6y/t5uTzc2gxi9cQNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw8kQYp2IRp1DiEJzbWDICiS6QLTFMhfrKx9Mhqxc8z8mJi5wOwEwO5LmFYSTiWC6ClJ9T9ZF/P1pXZ/Jprq/GyK2yZZ8mrE6CmfyhZEUJqbke5GXOHudUSkfXKyQgeW9kNYB+OLhq6c5MgmWBlmifNYrHBCTUav+XLr0mGkAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+q+APth; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2295d78b433so61870585ad.2;
        Tue, 15 Apr 2025 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744738595; x=1745343395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw1ymY8+YUQh+JkgWWL+KhMbc5ItGim9yESffQXO5Xo=;
        b=W+q+APthsAOvtePHHsx7b3dVFyITgeBCKVUCH0QDXme8mTOqj4+yB0X+txQP8HfK7f
         THbCrq3TpX34TM3vrcuk7V0eZqTK57c6AaFG4hN6Q/DuwuX/haSiy22D0fTV1aSv45vp
         SopDZnBCpQdMseRcv0qphK3sehkHNBvs1XJLPIjy6ibX+d9c5DxbW8l2hN+9A+nNVo/2
         D2bdleXKCPjSvFZJ+H7q5zu8PrEWvAFYdJIU9s3hVDFTGSr7AmU8RKCeloOD9fY/iHic
         22+02ryv4/WJwM03bDn7PoRqsD3LFn3WU9KBCMRlVa9GgT/2n6K2itqfi5VuYlnpqwmR
         Zbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738595; x=1745343395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw1ymY8+YUQh+JkgWWL+KhMbc5ItGim9yESffQXO5Xo=;
        b=hYw/RCFWllUnuHJbofl3dwcOQ5JySdPE2c9RtY8Zvpffqkc0rHP7eU5PGCgjO8iNqP
         qAUkqOb0pLnOca9LWro1vLmNU2LTYBdM0TzY+vTf4sTWsh5Ab0pupVmdeGMJM7DvXrmt
         YSRVHKwjCsEBYX5yMi4/6nbjbK44kM836Wp+1v9YjnA/ooK3wIFELXVvMl+Rs65rFvDQ
         EDLvP3jeM+AYISRufZrmM3Gf+M5FQGK3O/vCy3HhSdAmIO9NFJDm9MJqeO5dC3yJUInM
         +cGGqaXhaPIFJ7bsezp8O9yxTPMWxjWrZZrBfeIonFGW3Xl6Ife7dAuoiXQMxiRn6gD8
         Cc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrr5Qb+d9u/hx9th02zI/jcwRnC85WPxIusMt+wvlunCWiQ+Qc8uRGIX+YZWsDdEe7k9TrupVv@vger.kernel.org, AJvYcCXmhisbTbtf7CZpOkvK23X+ZQXxdhIiHK7IYEDkmkh5wBno+CRKSZhLzGLi7s4vSmenTcu/WGSnp3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFTJOaiDpv8A7RLvwp6Bx6eYoOy52zmY2BBr9bfBgdnw8GTAg
	Ud0RqySn9BXLawHKFDZ7IaPUEYBNrsj4tZefvqzmvIuLg4gfduI=
X-Gm-Gg: ASbGnctj78kegQESVvn3TAzpATXbM9d9RMnf50WxTAso3K0I6qLb8k6P85xwIqlcx9+
	b84YrwcKYmGuw3ZZDdUelNf4xd5uEm8OAEK62nyBhkTldx/iJvw8qMvcdI3c2G7XZVI2KzQFPjp
	x9xImq+SzfmEaQLn74KTLH/Xczuj2TXwB7u3e+CB+wVsO0TuW4Ro5r2SmNhUPzZNPsAyF3nrhLA
	NIlXtUcX2ZGgYmR5A7cTTU3bSXXFfY/b/C283dxY81GPLoXs+JM6U41Hrtur82X211buYh+rDO6
	QdDbaDvwruVE/0bH22KZm4eT24R27Nnevgo/qvH5
X-Google-Smtp-Source: AGHT+IG/K1QhTjF638xgaVlGhZOHwpjSJjWV+kbfa3Z5KpaRK7xi11Jn+aAoTOhZQcQbm8Wlv1d4mw==
X-Received: by 2002:a17:902:d550:b0:227:eb61:34b8 with SMTP id d9443c01a7336-22c31a00b63mr212945ad.25.1744738595680;
        Tue, 15 Apr 2025 10:36:35 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-306df08f646sm13484299a91.22.2025.04.15.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:36:35 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:36:34 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: networking: clarify intended audience of
 netdevices.rst
Message-ID: <Z_6ZIgn-oSUAYosA@mini-arch>
References: <20250415172653.811147-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415172653.811147-1-kuba@kernel.org>

On 04/15, Jakub Kicinski wrote:
> The netdevices doc is dangerously broad. At least make it clear
> that it's intended for developers, not for users.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

