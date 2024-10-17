Return-Path: <netdev+bounces-136737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C09A2C9B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581DE2816E8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D520219C95;
	Thu, 17 Oct 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj/0uObG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1EA219C89;
	Thu, 17 Oct 2024 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191110; cv=none; b=WfHgoNFbFaytN5x52EJ/Ldwxf70RqS0QC9LGAlH2XxrY4ogCSI4tXNS7OsDeQHfgov4Y70CzGHs07XRUjXTTuv3NU8SJN9t6weJIenkSIjDE4GduvVOWyn8vsAfxRSFGxYBYoHdNpLnG+X5CGF/m5NMCvDhSI2Zb5/gL73pgTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191110; c=relaxed/simple;
	bh=MytL9dZuLmcigO7X20aTVU/bR0ZbWa6DjLVO56fxOjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/IsXuaLx8832FL9epsnEueOz69VvtJvwGP4NU9YyhtvJC4XyhB65G4EuBUwiX+mnqAjqt8mOUrpvEBt2ktxzhsMpkyt4/r2T90XIv3tec+b8fkgA1o0G3jq2IQZwDcC/0VL0XRIxJcm3GVOK5eb+xUbogPd6bA47SJQtCQIE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dj/0uObG; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso5600835ab.3;
        Thu, 17 Oct 2024 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729191108; x=1729795908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hepi8wQtRl7njWAnSjPP92GtTeGsPlBM34ad5OO8k7k=;
        b=Dj/0uObGM3ZKfU/tBqLT3DAuQLoXEDzjETzKUBy/9NXNC4HmQiuc4qP/ypzXX5tywm
         c/q8Scqj6ez9gAzncnysm2u+56SYyvcsjXdzkfM5Xp6LZZMsuGZ8/s1y/mi4dKstOa2b
         1OWeNU3cktzgkjcd5De6kjegLmh8ZcsEXSc3ddM2oe89qVi36Z4a9ecFonS91L/2Dne3
         RAwQTz+rKQ7Xiiz1ELFAhF2qvo5aGo4VypNKhMTHOCQiSMJjJqWUHdkTHtgZSuxLKBS+
         tEUWTmiOcxetUG3RbO1BSVa7LBvdtdabqnbg37+GuX0txS5S7isaTYU/EgZzCIbtRzHx
         u3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191108; x=1729795908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hepi8wQtRl7njWAnSjPP92GtTeGsPlBM34ad5OO8k7k=;
        b=hh2MneiJXPRllsQ8SwwdqrSyXUtrdwQU7Mz+jzUCawlsJ4v5mC5lMNx5/lZXt5dSvg
         IMRIsEZ+DlPnUIrYR2mBDrT+S2yzLUrN7rxRRmhkZrLwCwUEviS2WZJPLhiD6JcDP6jN
         3hpCObB4AwDgH/smJcvUHjgOEAsnbfBBw30iPjRzlGPnL3597BbNIu3z/RbAes++1P8U
         koFcwiY3QpNomvKcB2Gi24+AIVm0YX/wbbSqFil7KKtSbo1MTvzXLWnqg+J4hd7a/rV2
         lShivITmS4KgkSIXfeLR/niYWwLiXJIO9xEbJnINLft90OnfbNSB3GaGb/GwglWVGgoC
         gQKA==
X-Forwarded-Encrypted: i=1; AJvYcCUJq8g34CEMhBnvZSN3bUAg+r8ch2SfCxSd+chANteF1obCzAjnAd1YzRBJ3H989QhVi6GCMTsX5+J7kS4=@vger.kernel.org, AJvYcCUdBmdvn1txPFiFCQZDF2alXoFogaVi4YyPZR7VK+rSUIA+Gt5yrlsZXyKBNpQcuSJhiBVNNdKR@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkOiPmk6CdRfD4QDm/qq/bG/IyIWqfROTih8dnp+WL052ei7o
	0GnRZVkNK7yl7qgmhYsH5wX3LrhVhar2ZxAWXWuG0XoubA6ntelx
X-Google-Smtp-Source: AGHT+IGsEWxwCngvHMMpKuZbpcfUdCmpBi35XioejXQh1Q1m1gMgIgjlonjAbhIM6BhmsPMpv5elNg==
X-Received: by 2002:a05:6e02:1fef:b0:3a3:b4ec:b400 with SMTP id e9e14a558f8ab-3a3dc4f0a80mr91223895ab.17.1729191107650;
        Thu, 17 Oct 2024 11:51:47 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c72427esm5217854a12.94.2024.10.17.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:51:47 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
Date: Thu, 17 Oct 2024 18:51:15 +0000
Message-ID: <20241017185116.32491-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves error handling in the Marvell OcteonTX2
NIC driver. Specifically, it adds error pointer checks after
otx2_mbox_get_rsp() to ensure the driver handles error cases more
gracefully.

Changes in v4:
- Patch series thrading fixed.
- Error handling changed in otx2_flows.c.
- Used correct To: and CC:

Changes in v3:
- Created a patch-set as per the feedback
- Corrected patch subject
- Added error handling in the new files

Dipendra Khadka (6):
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c     |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c   |  4 ++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c |  9 +++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c  | 10 ++++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c    | 10 ++++++++++
 6 files changed, 43 insertions(+)

--
2.43.0


