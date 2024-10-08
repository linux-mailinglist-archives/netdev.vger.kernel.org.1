Return-Path: <netdev+bounces-133126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA39950BD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65E9B26D77
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBB1DFE12;
	Tue,  8 Oct 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B57gxDuv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA51DFE0F;
	Tue,  8 Oct 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395646; cv=none; b=km/pmVO9o4tIUbi0qGt9cyXrKchp8gpsPSOTTF25FUQzNle7vSA39/ak4ievCtcYJczQHJIEPCGEE+w+qES2qTgwAhL2UagxbeKtp5KSlum5F5bc5bszviczDPM3gBGo0AW1VhF8y0UVmsYisBXrvMRKiSm6IBZ8pBEIHsi02YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395646; c=relaxed/simple;
	bh=aaY+wIaEEkC9xHfCZFhVigmMZCz9c2xpl5FhmVqMai8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JV47JrSAe1K+F7WjhkcinnIeNZLvMw1ZV1aNy417sEcgoPrCdcnxEw+zoxxcoDZgiyiL6Gf+dysOGkTffH/Il3hujwJKQWn6xbKI7ZIZ9bBtZfL+6ZUj3fkRxvMYqe1zYzIx+wEWnrky5Fwq73jmz6YLs3i4YKh6FO525NGqTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B57gxDuv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so1319233b3a.0;
        Tue, 08 Oct 2024 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728395644; x=1729000444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aaY+wIaEEkC9xHfCZFhVigmMZCz9c2xpl5FhmVqMai8=;
        b=B57gxDuv4aPPcgxqa6QLwHmqxklNplm7Sb/o1IoEnkf1wAYQOOCR13Wm+OefCnZ01A
         TIP7PI9t6+YLnk6Jg4rdUTM0fm5Iwz2+zdkG9wXcXFpkdqDRISVZnISwViYDyOcyyQKh
         xPYnqcZmQpHHfR9AfqYbVqwWFXMFoM2/nG+tdgoE8xTif2+PvKQV80jOvPmQzSk/BX01
         Ic/HiX9UGF982hRZg6bisQtfVz/1jgDa5MKsOWdADBIFbhadnfp11AavWzUmHf1dNCF8
         u4V1QdgAI4uOCqWVS8PoTFCkx/MN1Omh6utK3D336A4xbZgMGVRmyyod8jn6O0huQF/b
         lseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728395644; x=1729000444;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aaY+wIaEEkC9xHfCZFhVigmMZCz9c2xpl5FhmVqMai8=;
        b=rKuw8A6alH2mPvtrpzjyvCGaAxv11kgZRB7iOVixeshzzqF8SoDtvn10UUC3+0RaYH
         V5ttKHb2oRk7/uTrWZWxrHeQVqoZUYO84JU1WSzgH3p/S0xULfOFcBrBdnHUUlTSx0Y4
         dqcxoGHqUqKQq8/vd9vzuI/C1eS4OPlM2lpGvjorRhgL3C1+adj8LeGRmUBmfLLmUMvz
         oEuAW/9iLXlexNttjg3m7EYtRpHfOlYZeCL9b3sqjrwtvSe/on1oXeaeVnQYytxCt6U+
         4HqvKtlsLlyqZUDy0HZLIHmFJzvl6fhfBI9Xf4k51Ao5KHu1yQbYUPM/yRFC6uyempcF
         kMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGynItPwJNWV6hIISSPCck6fpmfkdb1VW28tLSOZxJIb485b6kZ1SiFqHjs54s7K3aAdtZkfP0W5LrPWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7GVhoLbXBwDWTH5j2wenQ3+foM+SZ0F41besIhY/ydT30CyW
	A9EdxHnnVC14KdlfGnnvCpHKg4pxEjN40QrCB4I9ZUvPK4inFx46hN4LQ+W941mB3hvmuDHRMxR
	C2ITcnFiQtdWCLdTWgefhgZVJFlk=
X-Google-Smtp-Source: AGHT+IEF48iWWfah22/+IwUfbLh6mcogYteMnbU9jKCbOCBu+OSShZtUZfNBxWfDdFikULL4IyG3L3ZF/7fwoj81Iz4=
X-Received: by 2002:a05:6a20:2d22:b0:1d2:bc91:d49 with SMTP id
 adf61e73a8af0-1d6dfabadffmr23416866637.31.1728395643274; Tue, 08 Oct 2024
 06:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haoyu Li <lihaoyu499@gmail.com>
Date: Tue, 8 Oct 2024 21:53:52 +0800
Message-ID: <CAPbMC76hAA3sonOM7LvXPAF0r19uSo8sWcqL42M+iR6JCBLGMg@mail.gmail.com>
Subject: [net/netlink] Question about the function `genl_init`
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, chenyuan0y@gmail.com, 
	Zijie Zhao <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Dear Linux developers of NETWORKING,

We are curious about the function `genl_init` at
https://elixir.bootlin.com/linux/v6.11.2/source/net/netlink/genetlink.c#L1912.

According to a history patch commit
(https://github.com/torvalds/linux/commit/5559cea2d5aa3018a5f00dd2aca3427ba09b386b),
it seems that pernet operations should be registered before
registering the generic netlink family. So we wonder if the order of
function calls in the `genl_init` should be adjusted.

Do you think a patch is needed for this?
Please kindly correct us if we missed any key information. Thanks!

Best,
Haoyu Li

