Return-Path: <netdev+bounces-147894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D89DED86
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 00:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F31B214A9
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 23:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599D7158DD1;
	Fri, 29 Nov 2024 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+AcN0f1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93C38FAD
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922419; cv=none; b=HhZxbHkymp9LvTaB+sfbosw7I3JC7jjP11ZBmYCdDQt3Y7Rv9Q84k6da35jzxdejLpA7kJXuIsyGZeENz4zpWpMnA8rKRZFE/06tKNkC/f+9zm+1KWbIsd9gEFlpz9RHOfXf0QszH5szo28yJQ2MBD1VyFUWmWvGu9r/Ra1CV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922419; c=relaxed/simple;
	bh=VZgFUVdk4gAO0zLwHMViCgM+oJvyehI2goFbWyHHj0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ltZCTQXBrd1MIJsLifhWHXQUYzRXrptVc1AOOPgpx/H9kEkScQj3+zsXeqfJsYUFQkDs+t+849oT5v55kBIYOSn+GlTaiXWHfoNxTwpoVZ0lTLl58kOtZdegJcFneN+wikJeZjl/jxexuGlY5A2iruAYRbCfIvtUI6MirBlDtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+AcN0f1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2155157c31fso4986925ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 15:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732922417; x=1733527217; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNrWRY+pT/5C5zHQJ4Jn0h3vLCDrtGYbQZesZ/KPulk=;
        b=m+AcN0f1o4IPTi0YAZCHX+A3tPhNk7Fr6IWYu60nEkywRC8vRsQggEcb+r1yqmXqnD
         cF3i63A3VPOYVp0o/nJsdnQRZ1eFui9o3f2i1JhI3HspiDu16qBXsFhGJaaccmHB0Evt
         Gsr7AdlwGQGw75PnqFkGpCCq6ZrdK52ObUa29UtYY8x4EPZlf6ciL7MAoUhotra1xtU/
         5exmkaJ51wg+2YKOvBqEH7LBN6s72BMLQ3VJ3tV8dkJ3OBMaByz9CZv87ZnqprnCHz8n
         ZpPXpZsR8j1q9VtZalsOGOMIjEBloxbO1HsguxA76zr9XcxVjXwjuf96bmbqigynUmR3
         3AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732922417; x=1733527217;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNrWRY+pT/5C5zHQJ4Jn0h3vLCDrtGYbQZesZ/KPulk=;
        b=BrIcsmpNib/dWQWS0cZbnUHUdN2V8ew5sLSYDhCiArGUxTYw+G3pm0OeupyQGzpbdZ
         1QDtfTPJJcipSy6psb7oAx7X98rWcJwcA7fciaWcy/WXVDeZPbJUK/fzJfB5C7l+gO/U
         MRidcIYBwapkbiLnknQtyqLLl9loLCqJupOh5eTJgAlQwfcpa99Vxy/QsZu87yVFvH/9
         2bYC2eq8F3JckZ0MVU0mdVC7gKf2bz0XMFVA4jCPreN7VZlhrCKNk8hGPnOIiuXmEiKH
         26Mc2JC81JdhtDn8pQHxjhEkQD9gfTLMIuGTaYT2Ap/DZPM1Axp3EXO4cs6CrFUv9vL3
         mgPQ==
X-Gm-Message-State: AOJu0YwgHe2Lom9YoIdQJ6COPk6SnWtr16c8M+wl3jhnsdtRjLAXK74R
	J5PJV0riaJNFLvT3jhA49XC8pnjrnhfZckJ5+afcesP2CuOBIYLQlhUePw==
X-Gm-Gg: ASbGncsd5lHJ+KDWr0Tm4EWaED6UigLi8l9zm9viQ610v8pnpO5BZjaEbr+MSe2OpuF
	TURfuUHU/dpD+QHdhiwkBIRAfg80UVam2Cik1LSvVjPd8HF2mDm551ry7GzJAMy06Nyji5TsEwx
	Wvootf3jHzj4dI9T0ylxEXfLiq/M68mvXtj5V/cO3Exbwj0FmAVt9Q1idbcHzIYtJ3uPXb8jgif
	ktw6yp1RbhxBXdefO4w5zN4t9DHwI0qhQbbm6Fcw3GcvQrlGdmGVaZ6vafCF6VGSULR0U3H+Jx2
	6htyRw85
X-Google-Smtp-Source: AGHT+IGt0aG3UK46ImH0HtX4o2DZSnoEhh8PuXBLt2xFXDqblvogDagPvUf7rZCDZ5VEnCKU/3FQhw==
X-Received: by 2002:a17:902:ecc5:b0:20c:c482:1d72 with SMTP id d9443c01a7336-2151d6565d9mr128570395ad.20.1732922416683;
        Fri, 29 Nov 2024 15:20:16 -0800 (PST)
Received: from xiberoa (c-76-103-20-67.hsd1.ca.comcast.net. [76.103.20.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219672dcsm35984105ad.134.2024.11.29.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 15:20:16 -0800 (PST)
Date: Fri, 29 Nov 2024 15:20:14 -0800
From: Frederik Deweerdt <deweerdt.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com
Subject: [PATCH net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z0pMLtmaGPPSR3Ea@xiberoa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When `skb_splice_from_iter` was introduced, it inadvertently added
checksumming for AF_UNIX sockets. This resulted in significant
slowdowns, as when using sendfile over unix sockets.

Using the test code [1] in my test setup (2G, single core x86_64 qemu),
the client receives a 1000M file in:
- without the patch: 1577ms (+/- 36.1ms)
- with the patch: 725ms (+/- 28.3ms)

This commit skips addresses the issue by skipping checksumming when
splice occurs a AF_UNIX socket.

[1] https://gist.github.com/deweerdt/a3ee2477d1d87524cf08618d3c179f06

Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..49e4f9ab625f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7233,7 +7233,7 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 				goto out;
 			}
 
-			if (skb->ip_summed == CHECKSUM_NONE)
+			if (skb->ip_summed == CHECKSUM_NONE && skb->sk->sk_family != AF_UNIX)
 				skb_splice_csum_page(skb, page, off, part);
 
 			off = 0;
-- 
2.44.1


