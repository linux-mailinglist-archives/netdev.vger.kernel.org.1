Return-Path: <netdev+bounces-60066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B1B81D353
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 10:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28531C213ED
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261FF8C1A;
	Sat, 23 Dec 2023 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhOVlwzx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5ED8F56
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35fd0154368so11109195ab.0
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 01:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703323666; x=1703928466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DwBJOXeJ43/I+1ASIMeFUeOvNamLGIhj8L7jhc20go=;
        b=GhOVlwzxl00mxy/CShpl6u9DHQSmD+9vqGPiAYAEpSEsAnKpcG3K54ofsBqgXJ0Ljr
         jhcphwxh3klNnagHqy9kNvZczL2SYhhE4Gq4nFgBgQsHN08Eq6XVe4+maVEaJwVc9bvO
         +JcCAJCt8qKs4z369w+jbn/SUyMXA5i5rD1mab1LKTKdGYMHJoRiFNbScdbZyt6VWVap
         XUxQrXSuP+yyN6+V5r1gegSSNAUjroFXU3iRQUJLd7iz1hkrjQMWnnKEbXBWr0714M2w
         cZJa5vfelzv8reGiN5i+3brvNpiz9yhS7UXBehhYSFCBhQRxhLAiq9i+9BYyhObDA+sx
         6d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703323666; x=1703928466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DwBJOXeJ43/I+1ASIMeFUeOvNamLGIhj8L7jhc20go=;
        b=Y2BadMavOfi5FqRMCx9KkpcpZBahJWZnLRjQ/3cqLjCO1lVTucduvgMENjDadL6V1g
         okX77LVx7CCJKGEv+RVCwq5qGTv4QUwUbKCOOh7MMPQ2Mkc7btx8CVkMY8DwbIzNCsEh
         QepB1EyKyeSL8mwUMCwG2a8R8a2c0Pi5dXeCDLLp3BWjrMFgKzlFQW6OtouAPLCtsXkE
         GjhoYjQdiWXjW4Yc0L1FKgvEJND3o+GSxL0UhJJybrMmJ9FWEU3zdzREaee+sj2W4wMX
         B4JHjeHkyhwSsIWu4Z/2wMvkQrqos0uPkzFXwRwIBt9+Tse8IPk3WWicWIiz90vSQ9/U
         YNPA==
X-Gm-Message-State: AOJu0Yx/81/Ssd6sDRu+lLYSgjoU1oq6/X/XaHM1NsceMK6ee2ws+qK+
	xfR/jNSHZGAPFr8IdF3R2tk=
X-Google-Smtp-Source: AGHT+IGp1HJJu/Z5lHWEgYPwkyf/lth0B4raknzPAc6BFI03t/xy2rxa2aCjJxLA4ygLTxU0SeHs0Q==
X-Received: by 2002:a05:6e02:1c86:b0:35f:c6ff:6a30 with SMTP id w6-20020a056e021c8600b0035fc6ff6a30mr3169907ill.6.1703323665875;
        Sat, 23 Dec 2023 01:27:45 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001d33e6521b9sm4747020plb.14.2023.12.23.01.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 01:27:44 -0800 (PST)
Date: Sat, 23 Dec 2023 17:27:40 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC PATCH net-next 00/10] selftests: Add TEST_INCLUDES
 directive and adjust tests to use it
Message-ID: <ZYaoDK6XZcR9C6r8@Laptop-X1>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>

On Fri, Dec 22, 2023 at 08:58:26AM -0500, Benjamin Poirier wrote:
> From: Benjamin Poirier <benjamin.poirier@gmail.com>
> 
> After commit 25ae948b4478 ("selftests/net: add lib.sh"), some net
> selftests encounter errors when they are being exported and run. This is
> because the new net/lib.sh is not exported along with the tests.
> 
> After some related fixes to net selftests, this series introduces a new
> selftests Makefile variable to list extra files to export from other
> directories and makes use of it to resolve the errors described above.
> 
> Link: https://lore.kernel.org/netdev/ZXu7dGj7F9Ng8iIX@Laptop-X1/

Tested with

make TARGETS="drivers/net/team drivers/net/bonding drivers/net/dsa" \
        -j8 -C tools/testing/selftests gen_tar

and all looks good to me. Thanks for your works!

Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

