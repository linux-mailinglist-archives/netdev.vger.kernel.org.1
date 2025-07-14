Return-Path: <netdev+bounces-206564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA01B037AC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A9116C7CB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC2722F767;
	Mon, 14 Jul 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtTN7I7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E041474CC
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477391; cv=none; b=iah1SFeRjtpAKQOceLASSq2hVJRjMjhJtx04K53HGtzMC1k3oabgQsxgIIvIrc4sijIzVE/QjiLNP8uU60VF+jDjkAps+hOLFEOzjBmz55oPnK5vaXvPBRzJNm/6vt4n+nJif/9zw3odCo4tQODYIlKQ7+LgaqJPy5bVfAiaX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477391; c=relaxed/simple;
	bh=YUEqPsFazIDWRltcHSOPed/gK+BHVxbYh2k+vSUpN6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ExTqB8F44mqxKpxaM+egVbWSb9s1juyuntBZTV3+qqA4zYsxnymD3DQNSbjkWBrdZpUdVM5WuqB/liJZ6xPSoFQMF+W75UIIVHGnz/Hl086JxOs1Ei8IsIXI04clBiKisHzeBwdCJKoFj9F8tHFt9ZDlXICEEPGluuQLADFXc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtTN7I7h; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso705836266b.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752477387; x=1753082187; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YUEqPsFazIDWRltcHSOPed/gK+BHVxbYh2k+vSUpN6w=;
        b=PtTN7I7h9WGTt9LM9vshXanvlmmHdEDA1PZQnqIDykM/QhuGUQ+WAPlQI8/b3lxu+U
         RM3ONRo/RIhGArPXn0rPaerrvGESpSHS4Uk606VEek4QNuruD+NJwRQ9yBCkBoY6XK7k
         +CcEdeIPIoWg0gvfKKcQM5Gyxhk6n8oRH4ZXGLbxKOXS6fvD42Ne8OPAvbQ1u83RnP09
         QEFz86/w/EOBmnK51uw7g8LCq2eWrsPCBXpahLzcB8MWsATpCl2JgULBS2w0cTdlkomk
         WNzbMydYVqTahz+if01Ivkarl20hAzsElxOMGhhcIi70TMuGBJjiHQ7V8ExrGlXy0OD5
         x1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477387; x=1753082187;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUEqPsFazIDWRltcHSOPed/gK+BHVxbYh2k+vSUpN6w=;
        b=s4cCmhqJdx3k14XnJajzAwkwHkhDu4tFW7eRkpHcxkvtpncmHDihv4pp8cNRfN2LEL
         NJYYOPM5p+a2ANhuEeiQg6On/H1xMmuONh28r4zF2wnAfIHa2Q+/qrb3LQ0mIoV/MmM2
         M/tGyL3RRM38XYptCD7WdlcbXUvEuW3glGdtkULxk+MRpYZ9lFmbZBEMojwWh8BIOI6m
         9U8rvF+kzfu9MBsQKbe5PmvRTs422Le6yJ5qWEqJGq49oJdOppFTj1O7QaJ8blxS007Q
         3MHQuT0N9FTl9aEZcAflDguP3Z9blVFJcgRnMUxs/0+61GB/ecgrH/mF5t06fScRROwE
         dOXw==
X-Gm-Message-State: AOJu0Yw/EXQmJqY0K0z92M/9b5eFGP1oJgYHRxNk5tdmWAW/TpiyK3JX
	rj3nmXRRmYl2c6O2Ov1dWbXnZ2LjGLi2y86SLq+C242lrt3Xze8EVxFNoJxrfgyanW3KX+nHGMy
	kV0PTqIQUQITmg6M2aSGi0mtKU3/MYhPqdNqv
X-Gm-Gg: ASbGnctMxMXG/g9DsvFe19yFggWUECln+8q0DMzJGAii3zd+gPaduYEmdUbaVLlLAcu
	UoNPwIFrhdvp90WjXI5eG01TdJqNH7JVkUo7ws2oGmHBmcbxi+n11JEVtsKNtiJOVtwspuCrlgE
	VQNZs5U5nrvAYdcKf68QHe64JcbDFe1DPMcUT7qz9LoAHEl82p+xU9RzOR5SrL15zCHVAlhEXWG
	8hliCY=
X-Google-Smtp-Source: AGHT+IGwxN3H7k5eSwPhe/dC/WKXZ7IMAhRyp4eHqAuoWHnHV1Ye4COS1YUTYkhOzJZz7zWYudFntV7M0hBivFO4a4M=
X-Received: by 2002:a17:907:d7cb:b0:ae3:ed38:8f63 with SMTP id
 a640c23a62f3a-ae6fbfa602dmr1166891566b.14.1752477387022; Mon, 14 Jul 2025
 00:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naveen Mamindlapalli <naveen130617.lkml@gmail.com>
Date: Mon, 14 Jul 2025 12:46:15 +0530
X-Gm-Features: Ac12FXwTv4Hz7-qw79QjVnXoJ9mwh-c0Dw7fOhfjNuQ-6p8HLrhSQLU6P00bYdo
Message-ID: <CABJS2x60cwpoDXTex0M+CyOepWbdvX8-RcwFmBu-vxvNywW0tw@mail.gmail.com>
Subject: Clarification: ethtool -S stats persistence across ifconfig down/up
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am trying to better understand the expected behavior of Netdev
statistics reported via `ethtool -S`.

Specifically, I would like to clarify:
Are drivers expected to retain `ethtool -S` statistics across
interface down/up cycles (i.e., ifconfig ethX down followed by
ifconfig ethX up)?

From my reading of the kernel documentation:
- The file Documentation/networking/statistics.rst states that
standard netdev statistics (such as those shown via ip -s link) are
expected to persist across interface resets.
- However, Documentation/networking/ethtool-netlink.rst (as of Linux
v6.15) does not mention any such requirement for `ethtool -S`
statistics.

So my understanding is that `ethtool -S` statistics may reset across
down/up, depending on how the hardware and driver implement the stats.

If this is the intended and accepted behavior, would it make sense to:
- Document this explicitly in ethtool-netlink.rst or statistics.rst?

This clarification would be helpful for the developers and users.

Thanks,
Naveen

