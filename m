Return-Path: <netdev+bounces-212694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE56B219DD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D61F1A23B72
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE552D5C8A;
	Tue, 12 Aug 2025 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="J+pfjIfg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C1E2D541E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959069; cv=none; b=SjRWLS5NoFQjBOF6LtLjjaqjhw4cvcY3cgA95FNywYnJc/aN4RN6AytQj686MRZGBXmhMh1OYbnS540iUOHtrGIMRWPnS7F/ZljzKxox8Wy+SqJV3bEG3ZJNRZMDlbvPJR25sqNX6myjJ0vo+kySY5Ce73jta4EbwcD62yGI1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959069; c=relaxed/simple;
	bh=Zoh+456yPTlOVfyqB1JAdgyRQS67Q1wYUO8Fk/hdDqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF/U53B4ugNp3TerZ2Vyn0PJDq1QSW/JIk/M3NeFCtM8BSZmlYmoZ/igN2V4H8WI4aSR2Jgiholq5BxCaa3XfrgMYADdwEdwLXU1vjt2cgPKeOfRhy4U4cyy6lGEqc9qRVbjr2t+1D6ZOW2iZml3a/nVRCWXSocHSF+crfVm6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=J+pfjIfg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2405c0c431cso46115605ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754959067; x=1755563867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi4jnmsHTvqQw1eRRjxdKyQuNx3J0h7y8Nu2xezZ5UU=;
        b=J+pfjIfgtpdwfb0lvaCZrwLH48EcNyBepVoFlhcrHh6fE0I3Q6OweX0O0M8L02VmLs
         oQVJKdL7E3DWP3OD7chpVxpslPmStJL82OLlLk4fUIHTFch2ljuirHwm4OSI59Y/mgSC
         pCqjL7hRtOTVhXdPe0F9aQqVSIRpg0ChUHS91tKpagQOrF6/RsIzNEOWyK2GkELFxnMZ
         thvtLZhpVuPOE5NNjr6hJkVPqLbYExoMrUp1zHitVbsqq0J63U0hDOaNEFpPu/Qpqi0W
         LISLDFnwvPNIdfmftLP5ByvKq5C9cydB9SoL7mCBZYEUWcJ0nGoF3zwi7pdNOM2Czkah
         LJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754959067; x=1755563867;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hi4jnmsHTvqQw1eRRjxdKyQuNx3J0h7y8Nu2xezZ5UU=;
        b=JmClvdAxlzIhyRceFgx8/n5ZXArZ5rnGXmIAVvsfs4HPmUJfnDlYyshhv00d4e0Zly
         U8JzugcnGDgfiJdbSj4yBIbbuzX83RMpsNFu80111tctuJS2iysj0WNa69BS5+VOalBh
         tASfUdXZl1ecsvDBjZpVWvfxC/oZOLHe6/iYUuzHIiKo88tshLTRk31KtZvN/Uzoe5B4
         lGY8tkolJGVLPWCuAzibsPJXeO6vFtAS2+HmaKCvVQ/9ayw/i7hq2q9z0Dgl5PrfODZx
         E8TEzJatb48vdXJPabSriohRc1m1Y5JyF8Ao+FRWp3aDRdgbfr937jE91cWLx1jJIl43
         wW1g==
X-Forwarded-Encrypted: i=1; AJvYcCXd9fjaIva5IkBmxAxslklkarHzAhu5rVJmz1eirN8ZEwLoOUmpMW4aVcSF2dvVHoWP+Iv844U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aVjNyKgbWSwqDRXLSvs1zsIZPb1fvhSmg32i0wIW4WVN4xj/
	YuY6RZFfdxf8TLf0FJ2wxJZR9ov9YK9jz1oW8LFv1/ikYzE2z1lh+CeSnKrcNBuzIRk=
X-Gm-Gg: ASbGncszsfsb1t9BPJGkiSfKfAsPl/G9xNcBIERlDq/tGK7boAK8CW2UYcInmI0AFr6
	O4U8fpKbChZYifTZKRpUDqTGFabl1H15kvXvJsRFhVMbINO7HoE5kI7BU5wNKa8GcIB8cGnoAkS
	yU48zfbil3zXtgAdXo0kbMwgUCWP3jFuAyCcigHe0GM4aKhJddKQmjuomywCceYKd24rfpHc2nt
	dgZ5E+udwMHNqC5pBeGl5sHeljFoZpzhh4NHkSY5nPW7bxO32LS2YaOqRd+x8Od+2hzdDUj0WqY
	prMPrWQP6jmyA4b3RrgeoVJGWkJOkA9xysqptr8mTYIGfwXdmPKFSMttvrJBjVCAfOY+a4nLQzf
	Ka8QKGx2I7yw3R1VCCCxLDHoEr5h9ptYBTvAPD6Ts1QEdP2EFFm/8WS2ltE3Mnlc1k3s=
X-Google-Smtp-Source: AGHT+IFRSXuDFlvPS5PxumIrCP6El65cWROzIzFAT7VIuasP8g6CXDhJN02xRtdA+6LGDv7Xg8I6dg==
X-Received: by 2002:a17:902:ef4e:b0:242:9bcb:7b95 with SMTP id d9443c01a7336-242fc389ea5mr19350275ad.57.1754959067544;
        Mon, 11 Aug 2025 17:37:47 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b4adsm284741865ad.132.2025.08.11.17.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:37:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:37:44 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com, Willem de Bruijn <willemb@google.com>,
	shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] selftests: drv-net: add test for RSS on
 flow label
Message-ID: <aJqM2ELIzMDDgSDb@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com,
	Willem de Bruijn <willemb@google.com>, shuah@kernel.org,
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
References: <20250811234212.580748-1-kuba@kernel.org>
 <20250811234212.580748-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811234212.580748-5-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:42:12PM -0700, Jakub Kicinski wrote:
> Add a simple test for checking that RSS on flow label works,
> and that its rejected for IPv4 flows.
> 
>  # ./tools/testing/selftests/drivers/net/hw/rss_flow_label.py
>  TAP version 13
>  1..2
>  ok 1 rss_flow_label.test_rss_flow_label
>  ok 2 rss_flow_label.test_rss_flow_label_6only
>  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - check for RPS / RFS
> v1: https://lore.kernel.org/20250722014915.3365370-5-kuba@kernel.org
> 
> CC: shuah@kernel.org
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../drivers/net/hw/rss_flow_label.py          | 167 ++++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py

Reviewed-by: Joe Damato <joe@dama.to>

