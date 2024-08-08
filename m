Return-Path: <netdev+bounces-116762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45FC94B9F4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65051C21C0A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1631A189F37;
	Thu,  8 Aug 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqUTuFs2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9273466;
	Thu,  8 Aug 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110469; cv=none; b=jBfNVu8kbJodVsJ/gs+xXqCQeaCkwT1eAq3RzgDKv5FclexbAhb28ad9kAprDZxqx0Y3j4xq9Y1JWxOoYwHI7hdo8fIn1IWnxdyrsC7nB8U9TYTg8bG1vSS2sc4HXJsXBHrjbVKf1WJIQukCHKXAjE27DcPGLqv+8wXHN425WXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110469; c=relaxed/simple;
	bh=rdluQewSItcySNG+3i6jFfQAfvrAJmDGh/YK1tqn5II=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nT3ibKQFHo4G1Io2CrOvzj/7+sAQGeINZm4T16wUq459Fg/51x9SzsBlcJBfvRfT8pwLmUhpyIFVia4ebL43QrY4p3a6yAQbWLRan2hJciHy1W78FMKi0+WSZinMWhAumRF6bQk2HwJ1u31UIMr0PrQUJvJSlNmwz/MDNV3SEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqUTuFs2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so870973a12.0;
        Thu, 08 Aug 2024 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723110466; x=1723715266; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBhZULL5Ag1OLTPY3pjydRIc/GdHAMjxJL78XL+XyeM=;
        b=EqUTuFs2c7Zt1aBgK0G2vVux05U99vCCEH1rCFOqv+ho489V6/oRu1nlw4IbFD9mSL
         2lHLx8BClmOt8Mo/hY3dU9sBJvlNSc00Fh1dQI5mYQp8Nq7KkrCAd+WdUmlD5bp9BJcY
         FYU+tQ5b+fR7yN9sC54Dw7iuKqRBUFLkjaRvXKB84CBWYbURf+7TiXlSREupki4+jP6h
         5zShsEtTJkNxDBVdpn5ignNzGgOzc4vSAGgR3sniW9iaJKkN3wF/IS/V9OS7YoEy0hqC
         2U6f6QIXlCO+kZi86/CfPFlZRF2wEr6go7h4BUcwnKClvP+XGQhtQ1D2ZItSvDw+P7cO
         AwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110466; x=1723715266;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBhZULL5Ag1OLTPY3pjydRIc/GdHAMjxJL78XL+XyeM=;
        b=t4bybvWtetsjs1BLczHbvVUoPyfAlk5jj8zT9xVdJIgbLuXTyhRzL4iPahcMSHWvIs
         PSK/xFJgk5dpIyxTLJPLtqFgodw5BAAJGRN44qK8HxyepEfq6HLBJVKFRMStMfu20bgK
         Y+8GQ8Vn+PRj0YJLZhUCu0MTwMPMymeOhO5Tu5IXfyQXiHWSU0h24YMnv6UXHht9tbBt
         u0wG714sCETtIqfqfi4zUgmXiAz2tNneqgVsdvRykEJstGqB8CJMex+1KfgCs47G0C/o
         YGM3QQoR1XXoLb1NYA3uNDkQg80wY8M000jzoaqaVEFh0EpBtDs445WAzEUzesJHnYoN
         Eerw==
X-Forwarded-Encrypted: i=1; AJvYcCVd03D/aep4xOcr854OkAPdgkBvk5ndLTetcyIw0FFcjTd7oM4EsvmRdZkZ8ju+YizMorXX35/gA8rMNYSjbz8KJHiNiiu0URWKitqK
X-Gm-Message-State: AOJu0YwiTjbzLGCta32VTJABtOhx634cnC/A9Z2O5WWCXbHHX1BiS2Vu
	+e5GNSlLt2PQ+gwfoY+fLEfiUINZzlQrPp+xz9lWXZ29ItNZ+Gb/
X-Google-Smtp-Source: AGHT+IF8mj0BOvbSv7xA07WMvHeNSHL86rnn8RO7wcQeC1PjxBQjti++uqmboYwBEztJgg7mYOXOUw==
X-Received: by 2002:a05:6402:d0b:b0:5a4:1bde:eb18 with SMTP id 4fb4d7f45d1cf-5bbb234d027mr906411a12.36.1723110465524;
        Thu, 08 Aug 2024 02:47:45 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c41916sm459647a12.41.2024.08.08.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:47:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH PARTIAL RESEND 0/2] net: mvpp2: rework child node/port
 removal handling
Date: Thu, 08 Aug 2024 11:47:31 +0200
Message-Id: <20240808-mvpp2_child_nodes-v1-0-19f854dd669d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOUtGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNz3dyyggKj+OSMzJyU+Lz8lNRi3SRLozSL1MRUgzQLcyWgvoKi1LT
 MCrCZ0UoBjkEhno4+CkGuwa5+LkqxtbUAI3wVNXMAAAA=
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723110464; l=834;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rdluQewSItcySNG+3i6jFfQAfvrAJmDGh/YK1tqn5II=;
 b=TtTQc7Urhwe0LLTyGEDjNgliNuEMWZdguN8z1F83lU+N8whEULr0S4SMDmrUoVZtiz1QFQqEn
 yVWE36KsYViBmi/XyBCHjz8mVE98uGrTSayeC5P00f5bu6Ah2A3gRpV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These two patches used to be part of another series [1] that did not
apply to the networking tree without conflicts. This is therefore just a
partial resend with no code modifications, just rebased onto net/main.

Link: https://lore.kernel.org/all/20240806181026.5fe7f777@kernel.org/ [1]
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      net: mvpp2: use port_count to remove ports
      net: mvpp2: use device_for_each_child_node() to access device child nodes

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 31 +++++++------------------
 1 file changed, 9 insertions(+), 22 deletions(-)
---
base-commit: b928e7d19dfd8a336e13ec0d21e1d60dc285efd5
change-id: 20240807-mvpp2_child_nodes-b92f8eae0f87

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


