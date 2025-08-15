Return-Path: <netdev+bounces-214027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F39AB27E18
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 105CE4E25C2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F52253AE;
	Fri, 15 Aug 2025 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjuuhm0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841517332C;
	Fri, 15 Aug 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253054; cv=none; b=A2ehOWC6hRj7tnq1n8vi90a1z6Q+5LQ1ScLjb/PPVJEKeVTcTmX1/Ua7mvaBpoWi2+qDTQrVJ1reAQrSKlA3RkXs2b4gwr/MmoeuZ4aUlI3yX3Macs+lb3dLcMs3qv84qMNyFU3b4EzaVLDiE4RJGlPdTRpRUtjamT4NlywqqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253054; c=relaxed/simple;
	bh=S0/8BdOSERg5uWRWITzQDVfY6sYuws7ILxyquavqsqY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S4FTGAgfRQo37CqbOAVD5NFOVHzYitkM7/0+vl7DzRB1YuybmxW6WD1qsGKv9fd4ZHWgCXi2pAVYeRL5ohAIV4E51O0uVR1bp485NRnJoNc/7N/XsGGzH8LhZ42t2GUbSf7Zd1flbajR66+1fkqqPdZvnFAYFulzpeBMFB7pyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjuuhm0v; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53b171ca696so773478e0c.0;
        Fri, 15 Aug 2025 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755253052; x=1755857852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CUXXCmt6pULCqRNiIVnXu6Ku5PVFCvCyuITqaGMBy4=;
        b=mjuuhm0v+l5zYEIY9Kvf7nA3RsI0OIUDOVX8I6h1GsMffMamH+H5iNIfrwRqXKEIzB
         P34Ods+/biQzxDCuRiJzf7/GqnJ2QKzY+uCamzOUDSVL0FT0ewiH1qDpdf6HMvcx58fb
         Fx7/jyHn6pdLQm35r9N79g/tXan+TPAcDRAuIGu7hggqgtbn+kQ8sR9kYOeBuY4HQE2X
         /qkdYlB7BqpN+4fhxAreg38igNYTvHdML3FvpRAX0BVi6tLRTYJUODl1ob+oF3x1rvsA
         1A9bYi323ME4fiWtwtg/8H62vy85wzZuZV9KKPRPRrUJBBMBWjquAgEX7QZpRCmX7oKA
         O3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755253052; x=1755857852;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0CUXXCmt6pULCqRNiIVnXu6Ku5PVFCvCyuITqaGMBy4=;
        b=EnLbdaH0D3Qcg1HOkDPpHNYflOOxms3OzWkMYOaUSuzQGVmynfr8fCHUMpulWB7755
         E3hdtCHc9wP29HAU74dBjXKtDwp3h/7N0xAActfG2orc4M7Ube3ISm1b5gFBLeKQjyU2
         YOIIDwsKoFmX4AtAauwMBrxfrYiDeqFntC4DOQyX0ejkpcrvduE3BeBq/QpwP2WSYwc2
         7YLasdOUfTAUG1UnpPFSDgcaa3HaSXuOm+VXC7KS7oBnPqgzFTz26Tc/01ruSaqMh9f9
         tVoQJdOdPWQpM0eM/VznN5GRSDq18E2yEVbQWiFOsoR6ax1QIq36a8illgvYnDjlXOCl
         aJOg==
X-Forwarded-Encrypted: i=1; AJvYcCVHSLMrLyBLZIHfYcMuORnCN95V4UeKhSUBzAxOI9rmT9PsZJ2SCok2uezBc4chB8K4NjbaqWvkFPLkWyI=@vger.kernel.org, AJvYcCVeAbjoHoSKz7k1N9wXWmfx/v2thTnfpberKYCVtN+nfaZRut8CfdOkw+l5G0KjlTRbUppv6KHk@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJoneVfJHkGuvlQ0IWmKj6oJu8mF+5ykU7sTpK1c31cKy9Th+
	0c/+wMxAsaxlxwgyUDRJJjb2CsZudt545i3xn+jK2BJg98tCe/qU2tJe
X-Gm-Gg: ASbGncsE2BisGjcsyovW2Q1h4harWhWjCTu+97XzHKEgNuWCgar3wn+UHA+s9+J2g71
	YZgdG5vcvfdFricKp7K3WWdbAzyHa6oShWDlyoEdB6m9JGg/JBWixyI05Ox0lfR1JdYPeAqZNof
	QXyGcixjAIg15WKmXuJOAMRe9bcRjcUJyM7VgOAKe6oi2yhS8Z0+bugX+FKONLIa2cBHUTN/iXm
	ge/Z4KyHzMxjkkphP/mmrRS/JJkBcgLUIP1tBn8d5cPUmoI9Z5QXbenCbFvrv/lYPYDr/Nv3QaH
	xSng591zhFtPowZLA0OP7xTII4YPphQ3eg7AUFU+JeZrDqBHFzy+8wD7LXwaCBHpWdQaPkscdWD
	Icq/hUgFi4XUpDKp1fzCbpaqoiwXy2S1jQ6AqypeZAbJV8/IlrTAYnCQRagFsOzKqEWNCNg==
X-Google-Smtp-Source: AGHT+IG2gbli32klA78F/iI5imumJb5ahyh3dTccWNTgh97CCTa++9QvatbKuYqFDCy+k1Ttc3iHIw==
X-Received: by 2002:a05:6122:31a0:b0:530:6bcb:c97f with SMTP id 71dfb90a1353d-53b2b892f93mr290049e0c.8.1755253052025;
        Fri, 15 Aug 2025 03:17:32 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2bed94b1sm152335e0c.17.2025.08.15.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:17:31 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:17:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 shenjian15@huawei.com, 
 salil.mehta@huawei.com, 
 shaojijie@huawei.com, 
 andrew+netdev@lunn.ch, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.2d92c3db94507@gmail.com>
In-Reply-To: <20250814114030.7683-2-richardbgobert@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
> This frees up space for another ip_fixedid bit that will be added
> in the next commit.
> 
> udp_sock_create always creates either a AP_INET or a AF_INET6 socket,
> so using sk->sk_family is reliable.

In general, IPv6 socket can accept IPv4 packets. See also
cfg->ipv6_v6only in udp_sock_create6.

Not sure about fou, but are we sure that such AF_INET6 sockets
cannot receive flows with !is_ipv6.
 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

