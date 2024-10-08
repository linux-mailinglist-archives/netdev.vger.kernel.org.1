Return-Path: <netdev+bounces-133047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9E9945BE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA46028180A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865717BB2B;
	Tue,  8 Oct 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3i7M07N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F52CA8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384409; cv=none; b=hPrbjM+Cid3+t6SK4A0rOoVtYVaSz/XCFRFLDRbruvbmKjC+9GM2GfJak6Ubaa8jxhz5V+/yw6tnZm039p7ab8BggqPtamGpDbQLrWy4nnvAk8DobX+L/dK43eMBQ0i3mGWdJL/jWMQpRBQ7BFcsZy4AUYxdW4oPSQZkd7ANmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384409; c=relaxed/simple;
	bh=46O6vUDy5VvCF8cgyZ9AnewsVsqv67DrACZoFRZ5Kb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u21t4AH/zpB8Swq7C5cRKuzIttX8HSjLofso3yO/8KLOWQ1+4hAqMmEexuE++TWvHYXUD/rbjuIOzkhLLJgFB7PdLjshbIm4kFY8/2519J6Mx3t6Uxrq6ISt2RHdZDqfRb6eybQSg6PZohNcZAJ8qSE8Bu++eKnFDpckXhEQMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3i7M07N; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20e22243dso29955957b3.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728384406; x=1728989206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N3m3YHNe0hk2B/RdoNrLzwPE2sjwm4w1eMeCeXse72w=;
        b=s3i7M07N4OjeXNUka9YEbCALNrpGdCVyBcowrToMj4rD0w1UZXOfyxdAuUW4XQjUZ8
         By5WeYcOhUZcofSUXC31r/Q+TzhGSXuFFGKorYFTnP4Tz0jMU7IQluf9DadOS0c6v93u
         BPKFvwNdpmwqxK1XQviWvXJL4I3A8L+xTE3kePx6DrE7nXsotbY6PFOHot8rDo5v4y/S
         lUDV5qy+dYbBj0PsCxwcYoXAFB46nIW4rkXFO1QvNylykmMYl6g+fXenPiN1SLFoK07g
         NeJIV2UJEO1MSqW9oFgV5byDj1T7vThGm3Rl5hUgEf5bImzSbRoFfCARlSI5HJSRcFgP
         3ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384406; x=1728989206;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3m3YHNe0hk2B/RdoNrLzwPE2sjwm4w1eMeCeXse72w=;
        b=II0zZvTsBxUAslsF3y8Jx7tXIBo01aRkvSwS64LmJdAW2Wwr2eA4/BdHop7H4tQ88g
         tO50ZL9yx96oOYlu9xonjLv3ulFOvSuSLjQck7KnVbspWHxPSLLSXMwiM+OjSXhE69ho
         SlGSmNlvAzDJ+HgIhnQ7S7Iz+re4BDQ06MxYf4U7TUx1kkC5tLpuadx/nWpl2mVjfv0j
         anlFwVZ7FHMO6qTj/SF2AQhfPUXNQKmMZTHMW9nfEXLar7Xc7nWn4+rXpfsl9Okh73Rq
         Y6KSPA+kRN9CMqEHGXzHlsM2r4BLNgzrv8UbZqOGnUK/3pYoInYnLDR3f+hQBwwCc+Ny
         sLCg==
X-Gm-Message-State: AOJu0YyKAoNjSfihe1Mg4spNK4x1UREbhpPnc2Z8e7m9uyeGar7Jt6c7
	uft9p01PZ8uy6+OpwQxSjVihTB8cGpe43WBUiC1hPJeCVfu1AF8Wm/94CwL+a2Si83zW3p6+4aZ
	vQcAAIL1Ll/lIRwpBIOL+tkgv1wjxFqQ4TiyHVFLbw5LwjeiveZO4Qb47Uwo/SzYvxbyCluvlU/
	vpdA/t42T3dF5be7GgjJTv9kCfwott2dSAJWI4Ng==
X-Google-Smtp-Source: AGHT+IEI35+d8kW3kWrr4b4NC9/yXBdjPJs2N2Z+nln6KZsef3bUdge0fOytTvYH75xWaoZkcdtCFcyclc9A
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:310])
 (user=maheshb job=sendgmr) by 2002:a0d:ee04:0:b0:6d4:d6de:3e35 with SMTP id
 00721157ae682-6e2c72b7a5amr470927b3.8.1728384405650; Tue, 08 Oct 2024
 03:46:45 -0700 (PDT)
Date: Tue,  8 Oct 2024 03:46:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008104641.3235861-1-maheshb@google.com>
Subject: [PATCH net/next 0/2] add gettimex64() support for mlx4
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

The current driver only supports the gettime64() PTP clock read
operation. This series introduces support for gettimex64(), which
provides pre- and post-timestamps using one of the supported clock
bases to help measure the clock-read width.

The first patch reorganizes the code to enable the existing
clock-read method to handle pre- and post-timestamps. The second
patch adds the gettimex64() functionality.

Mahesh Bandewar (2):
  mlx4: update mlx4_clock_read() to provide pre/post tstamps
  mlx4: add gettimex64() ptp method

 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 50 +++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx4/main.c     | 12 +++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
 include/linux/mlx4/device.h                   |  3 +-
 4 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


