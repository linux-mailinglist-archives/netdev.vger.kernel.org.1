Return-Path: <netdev+bounces-201013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2647AE7DB2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03673ACEF9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0147B2DFA57;
	Wed, 25 Jun 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2JVBFYd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681682DFA2F
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844105; cv=none; b=jedPkiOjeipNkbYPx/XkEL8edh75CF1ceR7t0flgX1QhhI+48Xck/CN4ikpjlnJBRUReSWzKMR+LSpgw7n7LGQDq/sONTXNQc9QEugkpU3ant4OKHNxC6bXMjjjbEeucughrtcSbHSwYvcfBouVjvn4TdT8Hzlf3uQatr55GXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844105; c=relaxed/simple;
	bh=2rRu350h60JHsmwsHwJzodt622gtKWzq+OPhnEchrqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA02EPKoLNJnEtDaMcJxJX3BMVjp1XZJZRiNZzgwZ06j8uiDnI2DC6ywQ3s9LIczQCDRRxWOo5g8Vq2Pp4olRFvR9iqkCEMs9TpFlmQL8/nQpzvehx/Zr5BPBL237SBzgmPAUZoE2+EFtZna545KCiJcyxPohJvxLU3w9aHsow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2JVBFYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750844103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mAqAwTOZXkehu4n5rF4nF6gF35YsBdMKC3cn/fzrXw=;
	b=D2JVBFYdNb1J7+h0Uw25EW2R694ur5EdA36FOsoooJb6uS0rHK9f4hbPD3BXITJPzjTQXY
	kkld9T4bTQIJNWrpG0urThzMjIl7SNfGpbvD+uZ3bRcNTXmLk0eF3cj1i0+Hnq/lS9gS/L
	X9jKtRcSL87+nL0/+RtdtN0a/dqSVQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-gQZyi4zuOcWSUbO-LbUusQ-1; Wed, 25 Jun 2025 05:35:00 -0400
X-MC-Unique: gQZyi4zuOcWSUbO-LbUusQ-1
X-Mimecast-MFC-AGG-ID: gQZyi4zuOcWSUbO-LbUusQ_1750844100
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d290d542so8964935e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 02:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750844099; x=1751448899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mAqAwTOZXkehu4n5rF4nF6gF35YsBdMKC3cn/fzrXw=;
        b=DJlZoKyg1hH3vJ3ErBUrbyjZ9l1JnNzX49OgsrWlvsoJc9xpmLkS1Q4indWZu7ALaZ
         xZE980RyV60Bnq3aBsi/qv78grQWH9VdzqxN5NzNV3SnkGSwgTesNa04CQId3iJ3pUI4
         TBVssbpgWiI+CJaV7jUFaWu4jf3yTBOfWrxSQ6BRlkfVhgjrFpSKfW2fk9cPeOsc1ClN
         23/5z5dzGH21aH7+HvbeGXd7JdK4BKvMMC5LthJ/rde+XN2MhBmKKqp84N+ZT0MeoE6O
         h6AJ4JYMprHgpnaPHxrMjW8XEv5dnmJGhNNr0xtj/3oMFyQbB9Xq6iqdoVDAqPtBC0Vn
         8jjw==
X-Forwarded-Encrypted: i=1; AJvYcCWRPyRZPCBN1NWKO/n/4SASBNLUxQJw+Z2l5WsT2s2CM69V9HTsDdWrJykGlyKcFLmtDJY8n50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/B4C9ZSqMO6vg+bppTRwpUFp/wctq9Kv+Dkea4jAJHFDUEnfe
	8W1SauorjI5l9g0vZ+btN3AEEi0G0Bhk2YxPBhQAKoDx/T/kTD+isI5vweTfrabp40orRDLmLCE
	GjzHt3abCI7bi2Mody3RKu9VRpTyg04gqhCrmpj8rAtR031GQQEJzR/nxUw==
X-Gm-Gg: ASbGncuFcdJl4/DGVNv2QcKyup1M5Edp877E/+j2BVHKY0ys7wyZCqkUFrQHFluyqga
	DyrGX+ElPWKpclycnvpvh+eV9P58Cp6zvr96Tyz/Nz0AaVMeykEGmaoQ/AlgSFhm1y10vsVwL7W
	M9D0Cq5U6BL0WZPtD6WGJRL3TABZmYdHB3dfqDVpmJqLseIy/roW9UYsqmlC7TQbSEaOBVlUaJV
	zcRwdf7q0iRhDKvajWD3fAiYdblzg2679vKpo+l8t9SsgjT1uuvweaodx/qQUP8MDl2a3TCI8lw
	rK6nQqr71k//tJXdWKaL
X-Received: by 2002:a05:600c:c16d:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-45381aecd69mr19753285e9.22.1750844099569;
        Wed, 25 Jun 2025 02:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVkdjnYscaljj059nOuXtgs3DwQ8AuTeC7qCsDKRiosXM4d0YU/2WmfNVz/msXSSKT4XX+kg==
X-Received: by 2002:a05:600c:c16d:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-45381aecd69mr19752935e9.22.1750844099160;
        Wed, 25 Jun 2025 02:34:59 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c4acsm14047705e9.1.2025.06.25.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:34:58 -0700 (PDT)
Date: Wed, 25 Jun 2025 11:34:57 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, matttbe@kernel.org, martineau@kernel.org,
	geliang@kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net 07/10] netlink: specs: mptcp: replace underscores
 with dashes in names
Message-ID: <aFvCwcH2mJ2WxFYv@dcaratti.users.ipa.redhat.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624211002.3475021-8-kuba@kernel.org>

On Tue, Jun 24, 2025 at 02:09:59PM -0700, Jakub Kicinski wrote:
> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
> 
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: matttbe@kernel.org
> CC: martineau@kernel.org
> CC: geliang@kernel.org
> CC: donald.hunter@gmail.com
> CC: dcaratti@redhat.com
> CC: mptcp@lists.linux.dev

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


