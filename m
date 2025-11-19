Return-Path: <netdev+bounces-239752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F30C6C23D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E17B35E513
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D543D1F8722;
	Wed, 19 Nov 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpfWMvyI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4A1E0083
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512371; cv=none; b=g0pegD3erHQ/UUx+KHVXP5ZmhnDKn4tjbqLYV2xkrwEiJQA+fVLbmZbA3E2ZLajL6oJVAFmD1Yp5l7q9wI8YAR9tJwIns6RJAdy0h7RNWZKCet5GSOSfB4wBhbOspEDoMGGjneoJgOjmiJ4/DXopF6+jg7RwoqG+pChPFI44KXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512371; c=relaxed/simple;
	bh=b7tmMO0p4bVCq8zDAbJYSe7ln4nf+W8e2uwDHWvulWg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qtT652Do1R0RyYuFzShxhnTp6DdcXIHQPm6a7dEuruvNMIeBr7qhKcqei4c5jvsRFaJcwe3YYhj6LDJzOFGTq58JROPx3kbL70trTcD7H2WGfdrj7EWCs0ky2Ze+jsusbEmadmKbMdCBR33kBWlid248qq7SPCvjdpyBKtK+vKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpfWMvyI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-787f28f89faso58897807b3.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763512369; x=1764117169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvE4I8Lym/x/DUvLFKeaWCiMOxUxjUBGPJiECvM7CqE=;
        b=DpfWMvyIt/2WnCdWcvdmhY1RSFwqUmmVAYeOiYqxVEUKMgt67Y6ogCq/I+mmZ49sD3
         Ht9HRmTC+UuC64mrYxVxsBRvfLEEj+4UyRmYH6/ypo5IW6fRIlDLRlhtQ3BNBQYKN0kb
         wmnFa4mUFxvvTaXFxVM0zoK5R3Ef5b6LGhUBr6sPLEVd9/sUTRscjaQwhBM/gEhuVu6R
         iQZPHliFErfsO+QK2GRlI5zETH0pzH3k5vshl8nMHz17i8QSRhABDYdo+ueg9ngTxVzV
         lbTQHurMvgeu1ZZb6RA44RW7Qa2J6zy9QH4miEegsZB/4GJEO1G/0/aZnwB6SYSeMHXE
         cMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763512369; x=1764117169;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvE4I8Lym/x/DUvLFKeaWCiMOxUxjUBGPJiECvM7CqE=;
        b=kd7z048GGrC3o7SScbFCfSX30d5TtyaSIl5wzm//3xXEg8oGsbpI18ZMpQ4r1uQLPz
         9GZSjeGWcDwThXuHDLlfN90WD1lF19Fy2PRq7t1L9+vyCnwpwZZ8Uz5TYhx2WlZFFFRw
         fe+p66eraycxbK3SihXRIWqxq6qMitfald55gndDoE3mKgPwxhCJY/Nt++Ngfucz1WnV
         VS7yzQ6xkNlJA6z9346+10Q6didakHkamyn127GiMs1k0W382PhrZkkqVFDOyIvmD0pE
         2XJdd53h36N4+BIwnjDBwhENd6x9OP3l2Sl4IA5M9BY2YuTmKLh8hibs+fv/e2WwhVTH
         7ihA==
X-Forwarded-Encrypted: i=1; AJvYcCUWK1LgD9gLezVNF8XsLOdZ9Pu7QmMyuTMud/8PJZnNgrH0u0CezFs1CYKCd76nH/1zRthQFbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85htIe9bajLXFvFWfyEATo6/gxeWqn528Jt3AhNuEAaNdlwyY
	VZTK/Uz4Pc+gPDhV4nnOvZB6qTqZBf9iYa3pPjjfzu+Oyyl6eRkjThc1
X-Gm-Gg: ASbGncvXGMDMcPhPzTt8esGAoGh2DbNxagoPht/RotFteZL9ZQyZw5AhBtQYQlwt1FD
	nkCY1HcS8d84zhdQc8uihqxrvLPMop2QZNNMFVgiNgvVn/k+og3lZdd2lvWZDrhpzDVEKFUq8xh
	ELu2zkBl3Q5XRt2dhUTOkbeNC6nzpS+gHxsVsDZ7R7i4nMy1koS9Y/HnXhGWUk5DELMg3HPEQWI
	SJ6ZVy2T221rBcZQ/QKvhzp6AKTbBSySqQ8nXZ4hGSfTdHyiwfxZjxgLHIxmOt4t1VaKdnbch0b
	3GVmyvGiUXJ5zmdrsHuJHCqDmYaxcrCsVPndMgPWLB6mYfz2csl/B0+xU/tkHJN6VNJ4Ht73GlI
	09P5Y6nSsmx+d+Xp2EbbBhC53F4fOWVA/yIq+V+DjX9z+NRtQOarBbz4idMVW5GrZPxlhJy/e63
	f1ldG2j9q7PvSFYQLx5XJYDL/qwdLpFBpHPPvV9KqyxcffLd/qkExWe9v4VvpSeO2vS+UGoi4zB
	GpStE4UbNxyWwRm
X-Google-Smtp-Source: AGHT+IG7n+Q5NYSyI8NejaS4PVSekWHKgNJZTPy+ufa5QM22GmPdM5ZOcK9MEN93Ytw6XdKFx3XjNg==
X-Received: by 2002:a05:690c:6389:b0:77f:9dae:34f0 with SMTP id 00721157ae682-78929f397d5mr147190317b3.46.1763512369202;
        Tue, 18 Nov 2025 16:32:49 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-788221781e9sm58115627b3.52.2025.11.18.16.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 16:32:48 -0800 (PST)
Date: Tue, 18 Nov 2025 19:32:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 petrm@nvidia.com, 
 matttbe@kernel.org
Message-ID: <willemdebruijn.kernel.13c277ea2256@gmail.com>
In-Reply-To: <20251118162528.4a3f3169@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
 <willemdebruijn.kernel.27c628e67e858@gmail.com>
 <20251118162528.4a3f3169@kernel.org>
Subject: Re: [PATCH net-next v2 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
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
> On Tue, 18 Nov 2025 17:31:50 -0500 Willem de Bruijn wrote:
> > For the series:
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Thanks! FWIW did some more digging just now, with the indirection table
> read from the device and disabling symmetric hash for the test (mlx5
> defaults to having it enabled) - the Toeplitz test passes on all 
> the NICs I have access to (with the caveat that I'm not able to test
> IPv4). I'll look closer at the GRO tomorrow.

Excellent. Symmetric keys makes sense. Though I would have expected
the RSS rules would be the canonical format. Another issue on IPv6 can
be whether the flowlabel is included (which it shouldn't by default).

