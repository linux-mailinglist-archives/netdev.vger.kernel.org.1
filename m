Return-Path: <netdev+bounces-166676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF8A36EE6
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE43B13B1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374E1C6FE4;
	Sat, 15 Feb 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftztP7CZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD14400
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739631050; cv=none; b=AjGKy0BUUm54TcnkflDjH0kHE05XXAKbIrz8uUE5hCF/DH8+kOHxVKXYsJVgrf9HnYpj5kN4Bpa2rNJNcIVhI4l34C7wCgb9ZX8ldRGcq/3bKoLhhZYvfEDyQNfNWyasVT+jDqFKpUkoL0BtInnFjHDSOOvya/PoimjQ1/bAHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739631050; c=relaxed/simple;
	bh=SWRrrQkaTxYEv0q5FmwJ8obiaDrM9IhdXeG/cNP74m0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JYbTeI2IWX5mvaStM4IeNURLzlUQ2XymAphp3lXSFhEIj8qmTDIsz0NTovJ5fX6N/skRedttf9Sb5hKK+JQecqVYeiiXnM+l16HJXNjG5F9o+m0fb3dlZB8WUsiGWvnCw8b68BW29zTPyl/2bRwOcCvDr8WGPg1gqg2tIvF8m4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftztP7CZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e4565be0e0so33909236d6.3
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739631047; x=1740235847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQZWvFQUfpkKGQgAUvD4LRdp7wwl9gyYyXQmJ+Bb4/M=;
        b=ftztP7CZ0Yi2kYJLsLocv30LKb6EKY7bS8jTAw5s8tKacTYH9I6geT1TsqMvAWIVsg
         usTF58711VeUzVfT64Gcq1xi7c/0rUW68wS31K8qs4GNqFRNkjAbDtx4Iy52Kj0GC6PN
         S5amGlirwlXLwmmyyF39Rk4xwr6ySMLZFGa6XriDLwAcTdAVVQCqgk+nixKsdt36Kne7
         wi3dSI3ZhTET2Yy+lEG8fOMgK/wk/nSID5yyOxmKUO/3KRHVpH6lIfCGYhnkMgdDq5me
         Qu1VthC4fFu1ZAmnUXcAIUQbzAhvzwTiPePW1YP3TgUlPYeiQXYhqcnn1cRdGcWoCLPS
         Q+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739631047; x=1740235847;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pQZWvFQUfpkKGQgAUvD4LRdp7wwl9gyYyXQmJ+Bb4/M=;
        b=t7PqbgNfYGyRDZbmBM2vZOgnGXN//RIqWZlhgu98yIERba8O5GyYoJi+zLabx0SWfQ
         cZKw+ovtSPG9tUO24FzOtYi6n+gCE8YxPbM3/L00cNnq8e87e0SKdPhdGtVgcD7cCPh8
         x4mFLdE121nPQoR7BvhdjEZADlytE1YlD4fS0pFqEbrlYEbg9VP4UTLQwoV9RWx35QdV
         0G+lbgiA4t5zUu7VjwBi8uvgXUZxt6sIRtSlr6JaDCZVC9RzwpdNhoUDF4otKGb4byLt
         CM9UECK9JaElT4sq6R+QN3gUC5EeSyFh1yVMyOdVmRxwFP4C+PETjYtcwEosWtyBatlb
         C1Kg==
X-Gm-Message-State: AOJu0YzZFbicVTCZPPFHlrFSyEEzWRdJ83WVpIehFXeNrp7saKc2WFDd
	HAls4QFrQUrC/XyIyLk0OzBw7SYo3x2CfruCoZIUxSfpqMuF6bDz
X-Gm-Gg: ASbGnctDV6xlOYqkBsSpk3rT+BI8Xf07GXBKr6qq573LsLvVrHkf0jLkueqNfa3CVXK
	JP2J4sadWT7xV5UXeLqVNyeNE6O82VlIT3+r8OE0T+zdotZ9A04CEiRlesZdN+YA4HBWfxxAUIo
	0y2yy82YDz9aXJbHB7BSubSCsCe2vGoebjiXPkboxRlkNXRpaEG94qLCWtQ4WwkccKIsXoqw8Hf
	zW0uyTU2ymdqRy2nCaStKbMXEflfP1l1LKF3fs3QqX0cmtuZSF1Akk3aImMtOuMi8A8BSLlsHeO
	3qp5lLSYhZZl42GI8kpBs9fbAetf/x3/ktQJNWVqgGW5c6GkjcMG88WCsZsHARc=
X-Google-Smtp-Source: AGHT+IFMZ1vYEuse7kR1G8hpzND7ioOcIr1FAYyB32zToYwvtqEJ4Ueu0UHDUYrpLlmV8zsXnBJL/g==
X-Received: by 2002:a05:6214:cad:b0:6e6:6b55:aa79 with SMTP id 6a1803df08f44-6e66ccc46b6mr53845556d6.19.1739631047334;
        Sat, 15 Feb 2025 06:50:47 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65db006e4sm32440766d6.103.2025.02.15.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:50:46 -0800 (PST)
Date: Sat, 15 Feb 2025 09:50:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 stfomichev@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b0a9c6ae5bf_36e3442944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214234631.2308900-4-kuba@kernel.org>
References: <20250214234631.2308900-1-kuba@kernel.org>
 <20250214234631.2308900-4-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 3/3] selftests: drv-net: add a simple TSO test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a simple test for TSO. Send a few MB of data and check device
> stats to verify that the device was performing segmentation.
> Do the same thing over a few tunnel types.
> 
> Injecting GSO packets directly would give us more ability to test
> corner cases, but perhaps starting simple is good enough?
> 
>   # ./ksft-net-drv/drivers/net/hw/tso.py
>   # Detected qstat for LSO wire-packets
>   KTAP version 1
>   1..14
>   ok 1 tso.ipv4 # SKIP Test requires IPv4 connectivity
>   ok 2 tso.vxlan4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 3 tso.vxlan6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 4 tso.vxlan_csum4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 5 tso.vxlan_csum6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 6 tso.gre4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 7 tso.gre6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 8 tso.ipv6
>   ok 9 tso.vxlan4_ipv6
>   ok 10 tso.vxlan6_ipv6
>   ok 11 tso.vxlan_csum4_ipv6
>   ok 12 tso.vxlan_csum6_ipv6
>   ok 13 tso.gre4_ipv6
>   ok 14 tso.gre6_ipv6
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:7 error:0
> 
> Note that the test currently depends on the driver reporting
> the LSO count via qstat, which appears to be relatively rare
> (virtio, cisco/enic, sfc/efc; but virtio needs host support).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

