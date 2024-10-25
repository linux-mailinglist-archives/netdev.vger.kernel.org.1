Return-Path: <netdev+bounces-139128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE509B0590
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C56284784
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43BB1EF958;
	Fri, 25 Oct 2024 14:20:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749E1487C8;
	Fri, 25 Oct 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866042; cv=none; b=Gxj2QgrekERopdSrLTsKTTtoMRDCB/HHbBf/q2Dr+nuSwKEj1XKX46MK8qqgD8VY+1aC8A3aCS+KYrg+7OCMm2DBMmVtxBzW0hYUDDuWIKOkOphDFoIaxPivyhCkEYWOVqfAbqcEYmcl+pos0cr5RgZerquYczrnaHpVecDx6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866042; c=relaxed/simple;
	bh=hQWDTvm89tWKO5eXqVO9t55fZxRuRvxPhzOjV7MmF9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jANHexVhZiPDVYkHx/CCAp1IDgKXNPMU7htR90BBACPYPWvt/QdzD/d3GI9XcPjzOz+SXZ4oVr37zez0PJNWTVkKSqaZvXYfBSKj5/FyrdWiAyn/FoEUnKojiNphU+gT+Mytmn2JK7Z+G0ZcucSlQ6ufZQxg4QCigurXfWNj75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so2403307a12.1;
        Fri, 25 Oct 2024 07:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866038; x=1730470838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zvn1KRM3j0B0fP/qbHc6ItNU4Hwxo1I+cSw77XnpIyk=;
        b=iantGBGBwfOesCZlnWdrMwcX9XqOoYb7kOzfgQq0MXEhVl/3H0f+OqmteafORoqVFp
         UPH6rVulfIYPXHtG8DTPw+ex1cHJP5eJ9wAlRnqYvPD2mrtD+63A0AxTvpZek3tROgC5
         WRqHZE4QZUg8Pu3ITIAruIH0SgOH5ZU44FgqtzUKdGY2vRhFkosfmZJqPrRuMm/j6y+o
         Fxfirp7rEnRSs8pxyXA8VshLNN+dB9pgSDRjvmJ7HOUQ6eYTIc4fnU6eG0WXHhGEuAT9
         2U7WrVtpuXGeomKaRTEU6Ra9RW+AZblR9g1nKvZvDb8ED6p2W1p0a0veSUVvwGKyKEjr
         Tc5A==
X-Forwarded-Encrypted: i=1; AJvYcCVwrsD8jHDW+2/jcsbjMlHYm00XfC2EyOZlKjYxJprGJ5z7Y/F0xLBKTY7jgtqWZE9CwzgOmj+I@vger.kernel.org, AJvYcCWqss6AAcqUTyI19Nz8jHdFxj6yVkkhvDiBwIxuB4AG8AGz3dZ1ONHJYrI4+XaldfHm0DY8i/O/2XmzDuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59BCLJgZjzqLTPcZ9eew90fdmT6YovqqyKf43mSvBYjahnFJ9
	W4UURXSKVHfx5u10VCm/oe/JvHgtI5TQ9YdywJvHbQLLTo5AKTsTrfPUeg==
X-Google-Smtp-Source: AGHT+IGKrGaC7E3/HjS9KHr+9npvN9Ap8ToiC3grd4wlZ/5uUeR3+NM7KKDbLEPurzE7HDDqCC96bQ==
X-Received: by 2002:a17:906:f5a4:b0:a99:fe71:bd76 with SMTP id a640c23a62f3a-a9ad275e4demr524127966b.34.1729866037721;
        Fri, 25 Oct 2024 07:20:37 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30d6f902sm75694666b.162.2024.10.25.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:20:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	jiri@resnulli.us,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	aehkn@xenhub.one
Subject: [PATCH net-next 0/3] net: netpoll: Improve SKB pool management
Date: Fri, 25 Oct 2024 07:20:17 -0700
Message-ID: <20241025142025.3558051-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netpoll subsystem pre-allocates 32 SKBs in a pool for emergency use
during out-of-memory conditions. However, the current implementation has
several inefficiencies:

 * The SKB pool, once allocated, is never freed:
	 * Resources remain allocated even after netpoll users are removed
	 * Failed initialization can leave pool populated forever
 * The global pool design makes resource tracking difficult

This series addresses these issues through three patches:


Patch 1 ("net: netpoll: Defer skb_pool population until setup success"):
 - Defer SKB pool population until setup validation passes

Patch 2 ("net: netpoll: Individualize the skb pool"):
 - Replace global pool with per-user pools in netpoll struct

Patch 3 ("net: netpoll: flush skb pool during cleanup"):
- Properly free pool resources during netconsole cleanup

These changes improve resource management and make the code more
maintainable.  As a side benefit, the improved structure would allow
netpoll to be modularized if desired in the future.

What is coming next?

Once this patch is integrated, I am planning to have the SKBs being
refilled outside of hot (send) path, in a work thread.

Breno Leitao (3):
  net: netpoll: Defer skb_pool population until setup success
  net: netpoll: Individualize the skb pool
  net: netpoll: flush skb pool during cleanup

 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 52 +++++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.43.5


