Return-Path: <netdev+bounces-145335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB669CF184
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EB1287508
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90861D4610;
	Fri, 15 Nov 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="KfE+ZoVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344161E4A6;
	Fri, 15 Nov 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688362; cv=none; b=W95CLPStOt6WlkRPIPUagOObr6wxMrm76YsWI/yIBoo+dqRJY4FJy9jZhpH1qKgff9nvBf3pSK7Yij8ZUXTYEf8l2a7wbgdDs5OKm12+pVV1K82EFQ8jB8QHwqZLrnU9U4GuY6F/+9+viHHJF8LueD7RHAiLHgeBsxZS7/V9VYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688362; c=relaxed/simple;
	bh=ZHG5EGAzu3WVkmxq6N3DCYqty4k9LxnL4j4F+Dt19Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHCcA7cGnF7ipoR0JI3ZmuMf4Jbtub70WquJ4nl0nMYIVRwtiQ4zR492/3yKI51oEBH7rnDl1gauwclMBKMGPr3jT4Qi6l/fm25vIgxedu1VqScbB54ZsNC3y2wXjqIGcHWTCUFogT7ZwiF6zvjsoLbYJ6GZ2dQ+p19AzLwmkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=KfE+ZoVJ; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1731688325; x=1732293125; i=parker@finest.io;
	bh=X5FKveEGFoRtJToEkzkSd7Mwk8gc6fAM/LYYJdowFdM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KfE+ZoVJrzgHUkqYMokK6Euaw4ywuIeNeOLTNCJjmgdeU+k1252QIw9LNYTY8im+
	 zEW+pit0E+FH/9T3lEZI8wTjqAeQ0FMZiWKAgUzLLvjUqNvpaAwvXVjocOiJnqNYU
	 +YbUY5IRFprQA13XLV4g3ZgTmrFnzrfg5SAx8b5a3yZVhKt2aplieOCuCMEMdGgYJ
	 2uKzINzqxRAKkW7Ksr8pnarTMtJcwcLzxkXJCnDEvtOZqINhV1CMtCm2SXGCFlpXL
	 A7pHy6jjUSJPsWuso63m9tvOXhISs8JxMrA56SWg1UtvIrr53731UZuAYHzwKgTUk
	 8XPwj1ij8Ywebo+lTA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MDzNh-1sz0p93pR1-00GdLZ; Fri, 15 Nov
 2024 17:32:05 +0100
From: Parker Newman <parker@finest.io>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 0/1] net: stmmac: dwmac-tegra: Read iommu stream id from device tree
Date: Fri, 15 Nov 2024 11:31:07 -0500
Message-ID: <cover.1731685185.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VmMzWfMuiUIonudG8UECAGKTtEGicIuJhmmOO1QaBA8Qx1KyLJB
 wEy22iYL30pHd39L68ZkWkpgK3f91L6r7nr17yp6487cxmF8x797lm+/A2kSN+nUJeDFU0f
 TUu07BRkGBlZRFr92mVbbQt0b42wwSutsA6gHHnyYkhIdLRDQCmtwivXqtNG4TKsA8V7eWZ
 vWDhDZwGpz4iZXHdUFetQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xwSDuaQ0gg8=;anf8cpo65zssXb+qsXoVC7Gn4ZT
 z6T42O9ZoV7+aLb7gPqddT/uK1LNOz+3IKggCrdMLZF+Pt4qf5/q1JCJ4ZKgIGGLXNyGeRNLl
 W+LEy39cb0VVUw60tPQaTgh5V0iRepbK3kzf3aMqaUejTgwitiX0nrA68z0nwQKbK5HsE6Y+u
 JlGnDTvwt1HfQwT8Jyhh5GXnKMjzGHrkanu7U5T8Rp1cwowA74iNssF2aNVxPg+YjdB2ZqP9w
 o/DuFwU1BjDObwuU8Rn6uEJ2hfMGCQ5KrYMktudss14g8RHjDoeo+713WCYS6eKiwTg6gjn7H
 JNjcPNbrRflwID4vvZEH0gRFfNeIGUkfzDZvoKYDQe6bnOHql2mfQ9rYoP6WNV0sP+Fs2yMYW
 Lb0dAPxYfL2IVUU8NKolroSAaxr0ierboIEDlEUj+qPfzJQ7lq40NN1rcxSIeyibnJReKoB5O
 PeT26HKnk85EZ9PNZIm6LmqL3SUxQsTbfH1eeXoyudE/dN4bsShrBb9XKhymDHwbQheLRXIG5
 wFzA5PIZV54GPM6tlfU/jk1hdZUwEr2UNV9LVmVGVuBr9Vf6QOcg58hTb2V+b3YdKjSDiQ5un
 VmMofI4/cFjOPsULZ+yD7SBaOY9prvZYU9AZDOs1aGRNFHbE+QEO2n343fIRVBFrGhwFSJdZL
 Q7+MAna4HmeX3hxyW++tbx+bOTM1rNJF2Ro6glHgW0JcfiHOCiJcTexRoFQ87uvyBuET8f0em
 CGctAqmm3ayJMCPFYh0eM22gfEArvVZZq+PyQ/kOENNPdgKhFnyRCVPDKBYt1I+AkvdU6K3hz
 5pUyLd7tg16fvqr5MsjW87SGCVQI64a9XqmJbm222/SgKi6mJ0Qt6yKor02D3um8xO

From: Parker Newman <pnewman@connecttech.com>

Nvidia Tegra MGBE controllers require the iommu "Stream ID" (SID) to be
written to a register for proper operation.
The current driver is hard coded to mgbe0's SID, causing the other mgbe
controller instances to not work.

This patch enables the other mgbe controllers by reading the SID from the
iommus property in the device tree using the existing
tegra_dev_iommu_get_stream_id() function in linux/iommu.h.

Parker Newman (1):
  net: stmmac: dwmac-tegra: Read iommu stream id from device tree

 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)


base-commit: 37c5695cb37a20403947062be8cb7e00f6bed353
=2D-
2.47.0


