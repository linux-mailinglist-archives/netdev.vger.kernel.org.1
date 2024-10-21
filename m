Return-Path: <netdev+bounces-137558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B779A6EC4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1749A280E84
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272019DF8C;
	Mon, 21 Oct 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ6vnl4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F3199932
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525974; cv=none; b=gWs/ORwavhCZRnTzlGL05HgSFXELyAwqmQQGsGEF0XiY13Cr0DPhGmpEbNZUjq8Y1Ol8LqPiLcQ2EN5zyVbbYgwE7T5bXr1agQjnqSjhqDPeKEmlx0rOw8lLPInOJwJwizJkdElyTa69L/QQ+lm6PMpfBx6ZKg2ZYxT/thBHv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525974; c=relaxed/simple;
	bh=wC1MjvPMCL0TCf3wxSWNw5bvPQBjGaIxWtPGF18QpRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utxF2EZvSgj9EJVq7iWhb27BUezPbgAU/6Vs1+NRWBF9QuE3CQpdzjSSchomKsQlcGDog1VGklUGE2VoC9lQy63DIduA0I4CCNlG48h9ngCNXlotuKbswYuuuf6FjZxSRt51eGgDjZQXGBdGuuQ7Ljr7iiXsdB8UY3INfmXDh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ6vnl4S; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so3601640b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525972; x=1730130772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRYGncUKh4y4sS8zOvTUVARZtN4AJoQ/JP39E1eqSKc=;
        b=VZ6vnl4SaQmG1ZvuIJRXJjaMOctfdJGirbTkPmY6c5WROYfWjFpruP5xHXn+2sR/sf
         LirnbR+ps200s8VzPII7tX+nUvdU17PTLXcoMWfiYJMN8UvGEY4L7eNsANFUz4GimNTL
         FY327++cInRZJor4ItBj3SPZvM4HpoQTOSljw7IH8J88rUjVWXx8OJBPs1jGHOl/opwi
         JSb+B5DFZ2eVm77TjQzz824tlJNsuBLetHUsR4wvWB1UquUnylLitP0KfqYZnskyyqlO
         JOuKJrooMlmS3wlBAYnf7jQsdWWAfVsglyzt/LEcq+VKOwqOjsJeu5ljHLQqJSxXdBym
         ivrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525972; x=1730130772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRYGncUKh4y4sS8zOvTUVARZtN4AJoQ/JP39E1eqSKc=;
        b=WDXJ4Fx+s3KcgtPopcjyTssZ0mvkCVchfkUBHl6G73h1Gc8x28HZmBZlW+kV4RVQhL
         cuPEpQOpdv/aD9fvXY7KNXirSVfuLLrBbZkZP7m2ZgTjHmuQITtRYV//GpGz5dV0PV2k
         e89H0hoYpFTeMOXtpnCcAfnLIF/o5t8Nmqw7tQpnEV7k56XDbl3N/8d9rWuO69JJDJ8i
         tNIPCjrD+6L1S2xU8K+w+M+qLduI5nVeQD7gdKV1P2d5FHaDtx+C0bLNIeKTVOOzG9aw
         vRNbQ13nQ8HvVFp9L3Zlb0pbI2u/plxDpB2pOyBJ9VEOI6Ku5tl6BqgSv7+BnlhQ3QUy
         t00A==
X-Gm-Message-State: AOJu0YxN/+XgTAAQrQahbi4dlKdmvXTOROmd2l3yCj/5iZS9lUV3R5RU
	6YkoApw6GCai9JP/SpScSz6juNsYULxi8ht9irXN815QBwqogzix
X-Google-Smtp-Source: AGHT+IGeLgNepbM8p7Qg0eNrcJgfiDhGPMQSBrrvj3+SmRKZNzHrLreozuYXJajLxP53qv4DGzDwjA==
X-Received: by 2002:a05:6a00:3909:b0:71e:634e:fe0d with SMTP id d2e1a72fcca58-71ea31aea56mr15008015b3a.12.1729525971494;
        Mon, 21 Oct 2024 08:52:51 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea0ddsm3154697b3a.143.2024.10.21.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:52:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/2] tcp: add tcp_warn_once() common helper
Date: Mon, 21 Oct 2024 23:52:43 +0800
Message-Id: <20241021155245.83122-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Paolo Abeni suggested we can introduce a new helper to cover more cases
in the future for better debug.

Jason Xing (2):
  tcp: add a common helper to debug the underlying issue
  tcp: add more warn of socket in tcp_send_loss_probe()

 include/net/tcp.h     | 27 ++++++++++++++++-----------
 net/ipv4/tcp_output.c |  4 +---
 2 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.37.3


