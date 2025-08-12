Return-Path: <netdev+bounces-212673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3EEB219C1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7873C1A229AB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83432D46BB;
	Tue, 12 Aug 2025 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="v+2PZ4mJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE12D1F4E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958425; cv=none; b=bMO0pJ4xc4lIy1q6VcELF3D2Y1OnRfil+tSKfy9y4oP9O+4JHCPkOmYGcSHM4tDZwAzGwXbsnLkIVY3jUGMLbRV9QLCIN1KfeCnUj/tlLAccZkFkvidOubhcJt6eyb4w4fc92I72Zp2fHstjl042s1SXg0KwHNImZzKkccUUwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958425; c=relaxed/simple;
	bh=wXwIIWGI5EWr/pFTzADoEy5DSx22T06+GvNVvNtR72E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFTfjd02I/KQCQdYrd2IR6BbWGd88Kfv1E7bzfmyTIY9J5EVampxBX/nyYTrD9U02s0mLjmGn9tPzJR4yIhT25JftzswvugmICcZ+AWArFbLB1yYH9rj3lWu42CzgYjqSO4hB6BXxYshdzVkkClkrfMQJ7BJMn4vIP0Illk0vbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=v+2PZ4mJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bd050184bso6414346b3a.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754958424; x=1755563224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThB9jylg64Mzoc4QaOAj07mG0td8J1a41HLR+vkGEJs=;
        b=v+2PZ4mJsN+bBtwYMmmKNPt29nUcUtQyByG36MzfT2xIeSCD4aRaLXGnb/P9hOadQT
         jFuaSK85tdjwIjA92NVGh+yfDLdxVl9/1krHb4LR+poCdOX6Iem9dwbCJfZBEuTlwKaU
         gE62IINAOj/PWxtskVIFHEMo+IFtUeIoMkCuPIWPs/i+ltTudwS/RNll6m1llSqXJKt/
         ySh74RxGRLu20+bt4P3Thv5/CwRTnF4eCyO1qZzzWkXRBvEQl7poBAror8pVtOBsFv3I
         I3uq2oMhAEoazNtNXGPP29cpxCQ/FJSOfyfYoVWGWrDmkC+FOVSnlu2zOF+cUFQt0Gjr
         jyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958424; x=1755563224;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThB9jylg64Mzoc4QaOAj07mG0td8J1a41HLR+vkGEJs=;
        b=IJEZMLROg+7k0vTFKlDsnXECQm4QzEuAJAZuA56dmRuU0OsIB+KnERG7Xo+4UZllwN
         tIkLx7AYWW3vDLvRgGoWWG1XguMHmav6h7d957756w9uCjj3RJCM8xXpqyMOZ6SFj56g
         SmVmlz5vZfG7WBb33OpZf9za6UDQLm2eYHR7ZIWbX8BmzdDKKumTzO3OUNj+1gIZRCZc
         0UiJ7NqjTvnPtyTVX7QUTdgNolV1O6VFPW1j3OBVfyvZjo94uYrMcosUfJu8SnOvUu92
         V8mBT4Ay9N/jHYrQDTZWPCmEG3J/y5His+iJEdCcBao9Fj5MOQ/krgDsz7WKis8elvKn
         hhTg==
X-Forwarded-Encrypted: i=1; AJvYcCW0KEF1Xvzo/ue5nrN73CxGkI4VO9W3ja58H2XUlqpEVWkrr7biLiWQrY6k2O7+RuHFAMHJz+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitHjuZaQZw+tkpeYPWFLF2M9+x6HCoWyZn5qwP4c1pmU/7Zkc
	GgZZ7kG7/cdhCzksQoxLB7Bc9cBngoBtxZETiG37lXf/LQ3bbY2768Rmk26qJK77nK9aBpCzQ5q
	Ogyw84Wo=
X-Gm-Gg: ASbGncvgl3crUQRGJd24TDTCbAbfzVhphEsCVUYWyBnRE/uzLB27KpZ2L4ZRJNNagw2
	2bBrpeBJE44Q8D+Cy1y+rmEBu+VergX1QV+lNwHGGbvvJReOcO9UeUDArgi6bzGkxRUGu/Nr6CS
	qilsHmgdct473CUV1zvDWGaTm3BC7AS3eoDVI2WJWbkvn9HvWEPg0PnrrH/13kzxuAf4t/JuNAs
	QIz2QmMtDRMvKSP4deWF5SHpWoY0rVJa73an4HhT5Snbgn01303eIy1JAzXGxmJobqfLWsKQlLL
	sF19gV/I1TDa5tDmI3ZQqYCYTGGL8O2vMnWuFz0LzFqnnSXOsIQPK03lq+vXdrkK1JoJRmTNj84
	9VbkeQxLJIqzIcsMc/AEPYlMA18Q9ZD0JIf2c6+JRzcDlA8vfhxsxVoOyoL5kGj7H7oc=
X-Google-Smtp-Source: AGHT+IEvpzM/FRK5CONOhWyaJmc1Kx9Kz9YibdXNrSoECj5xVh2wC/FEkbxUd4r+zCgwreVLCg1ITA==
X-Received: by 2002:a05:6a20:a109:b0:232:b849:b906 with SMTP id adf61e73a8af0-2409a88e547mr2282201637.11.1754958423703;
        Mon, 11 Aug 2025 17:27:03 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0d14sm23868185a12.41.2025.08.11.17.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:27:03 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:27:00 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v4 1/4] net: ethtool: support including Flow
 Label in the flow hash for RSS
Message-ID: <aJqKVHT3v-4Pc1hC@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com,
	andrew@lunn.ch
References: <20250811234212.580748-1-kuba@kernel.org>
 <20250811234212.580748-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811234212.580748-2-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:42:09PM -0700, Jakub Kicinski wrote:
> Some modern NICs support including the IPv6 Flow Label in
> the flow hash for RSS queue selection. This is outside
> the old "Microsoft spec", but was included in the OCP NIC spec:
> 
>   [ ] RSS include ow label in the hash (configurable)
                   ^^^ flow?
 
[...]

> Due to the nature of host processing (relatively long queues,
> other kernel subsystems masking IRQs for 100s of msecs)
> the risk of reordering within the host is higher than in
> the network. But for applications which need it - it is far
> preferable to potentially persistent overload of subset of
                          ^^^^^^^^^^^^ maybe a typo of some kind or I'm just
                          reading it wrong, but can't seem to follow this
                          sentence?

> queues.

[...]
 
> ---
> CC: andrew@lunn.ch
> CC: ecree.xilinx@gmail.com
> ---
>  Documentation/netlink/specs/ethtool.yaml |  3 +++
>  include/uapi/linux/ethtool.h             |  1 +
>  net/ethtool/ioctl.c                      | 25 ++++++++++++++++++++++
>  net/ethtool/rss.c                        | 27 ++++++++++++------------
>  4 files changed, 43 insertions(+), 13 deletions(-)

Commit message nits aside, this is really interesting work.

Reviewed-by: Joe Damato <joe@dama.to>

