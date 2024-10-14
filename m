Return-Path: <netdev+bounces-135102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0799C41B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46C9B28814
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD9D155742;
	Mon, 14 Oct 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E70hk0Zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD6156649;
	Mon, 14 Oct 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895951; cv=none; b=otGZvbgsEf16INUg6GE2asMk9DFwb0MPjc7Ha9jA3JCf7ulfiMsJGy9pxlIr/fqH1breCfFrLNKaOPk7tJ/WOhDmK4+2PQilTSYHW0CSr9GWojmzLSn/EGOrrEdu82uWJwdZxWTRLW2mgP+zC24I4gKLyGhcss2zOR0t2PuJ+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895951; c=relaxed/simple;
	bh=LvBVOsVsySllUZqeEJfWUG07PKJiq8gAXIXFiMbcpQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HiKzkR1rGcPEuJgsfr3rsZpxO3lFRoikSeclw9eEBMY/PwJGTxgrWlyvchVRKSut+6yEl5T7D9+UJfNrSzg1eM62BsKGqwplc36FmIIRd3yM8vvdP4U8x/rLsr4Q3Fh+8gvpf9LTb7g+8dwJqS/PLpuuwgtROcO5rsg0+coJ264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E70hk0Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652EFC4CEC7;
	Mon, 14 Oct 2024 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728895950;
	bh=LvBVOsVsySllUZqeEJfWUG07PKJiq8gAXIXFiMbcpQQ=;
	h=From:Subject:Date:To:Cc:From;
	b=E70hk0Zh7QcT3BNPhmXoD3gRqa0Y34f6m1ca+wb6idqqB/JxDi2sLy8fOaJCMerw9
	 OzaUt/U6S30CX5PV+Wy1lYwgGIrO0aj/IKUQjdfa6x7/Yv3mTKmWDivjpERkIGeND1
	 SKn+J0JwYyecQg+0ge5Z+S+L80oAGS7PkAuFviGb2z7tUZjfWLktJxGrxjtgMb+xo7
	 MhYEi+D8EfayTG0KG4meCB1sl/xTlM3M2jTCXJT9B2lI85pblRg5ViCx8l6P7P9Stz
	 Tfb+nIHLCbIRde3Zg6WE8GzeoDA1gHB/rki2rL8Gg+b4umhAsu0tTQN7A5JsYiKuAm
	 j/AixHC5a3yBw==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/2] net: String format safety updates
Date: Mon, 14 Oct 2024 09:52:24 +0100
Message-Id: <20241014-string-thing-v2-0-b9b29625060a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjbDGcC/22NzQrCMBCEX6Xs2UiS/lg9+R7SQ4xrsihJ2YRQK
 X13Y89eBj6G+WaFhEyY4NKswFgoUQwV9KEB601wKOhRGbTUnZJKiZSZghPZ/9KeTTda3d/b0wh
 1MjM+adl1NwiYRcAlw1QbTylH/uw/Re39f2VRQgpjbS+Hfhhl215fyAHfx8gOpm3bvieLDeCzA
 AAA
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Bill Wendling <morbo@google.com>, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, Justin Stitt <justinstitt@google.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Hi,

This series addresses string format safety issues that are
flagged by tooling in files touched by recent patches.

I do not believe that any of these issues are bugs.
Rather, I am providing these updates as I think there is a value
in addressing such warnings so real problems stand out.

---
Changes in v2:
- Dropped accel/qaic patch; it is not for net-next
- See per-patch changelogs
- Link to v1: https://lore.kernel.org/r/20241011-string-thing-v1-0-acc506568033@kernel.org

---
Simon Horman (2):
      net: dsa: microchip: copy string using strscpy
      net: txgbe: Pass string literal as format argument of alloc_workqueue()

 drivers/net/dsa/microchip/ksz_ptp.c            | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

base-commit: 6aac56631831e1386b6edd3c583c8afb2abfd267


