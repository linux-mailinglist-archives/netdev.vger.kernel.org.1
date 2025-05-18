Return-Path: <netdev+bounces-191333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88634ABAED8
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2359D1786D2
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B9211A3C;
	Sun, 18 May 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="omE4HvV5"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-19.consmr.mail.sg3.yahoo.com (sonic312-19.consmr.mail.sg3.yahoo.com [106.10.244.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48497211A07
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747558673; cv=none; b=G6XdhQudtrCHJuAJIL3qMCWS2LfzVKYeKdjbP/VfwLjUpHQ46h2RXTDoB0hsFFQ0JKqrCLYP/9Ye3Cq4m8TBGuXQceLwAaCwVGNAgH5OZ55OoBpWisU7BsneNZ9A/iGNdnsvx5mSkqFQzAS64Ob2qnmTMM+FHWMXYEuN9WVy1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747558673; c=relaxed/simple;
	bh=JyAcTrnuNeoYk9SGWs3dgGTw2HLd72dQ8f3iZhEeCDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=BXAJb/Rz7OKWSXCEWWFTuHFphH+TWQndWjjcn/S6YhR0b8Yh9DUV7y1YdQXWQVG9URIyZIjNkVone5j64I7dy3mbI+HmN97bYhXoTZz2ZGTDmNzet6ecgVGxP8lf94qLksZLen5pYHG2UtwpSzaugt4fZx4pt4LSjKfl8aVvQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=omE4HvV5; arc=none smtp.client-ip=106.10.244.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747558663; bh=r7X/ezeQgJvSucMsMS7K72/l4tRgF3nk99LElvKN51o=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=omE4HvV5HQtxh+zmIDa84JDWa3Y00TTBX3XBU/AVIaPKwgYknwG/31u1lFk+/nsFFF8TtJyxZxL8Dz7lnF4vjwtBVNJD9upHRqKqJIf+3qzhCFSKtZ/E8yS27TYeYVamlFymRGZ1KQM2WrEdrdEPsoqdIVYs//OQ+5S7OsI5mCYTUjSFRwSc84vAppWojWraDVRPlBbcfgPjSeAp4JqGqG1oTAxJ7fA2iRh2X6Dj24wWc7OoPfLOleM2aQvm6cqZV3kXh38VH13+0i7g1HMRwgzkYCst/Ia6yCECrqeVfUKXgZvRVp6IJSAGMguC9CXtA8GCjBrmpsM38fMIHktS+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747558663; bh=c63SravZ3fCqtFnx8nzQZbwxDu90LWAL4W1WDWWLGql=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FmcenPWRpcdgs2ge89mlpcNbJ1grISeVfL1OwX7e+w4Wy3m5w04D4E9+SbKO4Zj8rxjR4LJWV/v9PWh+j0ZwwzVuEeCDT6xZFc3SgPPaWzjnshY87+V3jVDhDQcRi3Efc5mGd+0Srqh1Ql7qWrMsgnFK0i/YBu6udJJk1aSMGzhYpWJ9XjH2OeJhgXmzA56J9OoCr3gCCm2XSCvUjKzdB917G1dMSkhv7Rjkm3TYdbqdwpAQTLBbASxoEyKoQhDNuORYM5B+mN+UgW58108DIKV1cVlyMIiUU5/z3TsolREVGrZXrp4DyL1+4J3/w2/p+7Y5kTMMX/PR39Yr47HnCA==
X-YMail-OSG: 8ALbrukVM1mRy7wHrC3bF9_jLf119l99cnkDgxCX9b0BKIF6dYii7UGLzfLsdI4
 yLXV4gQokUS2rLzWHYNG2FUwcKlu_7DpJSqVB5NHp28hJc.3qYYB8atrSdD3WCY5NHTJDp7nD0cj
 hWSVo_zsa9WIoMyha_DohZ8imyIsImzrTmYRwoi_GVXqtqJR5y._hjAK9Wds5VK4aDQhktCmGkNy
 8f0kDrWa_I.HHwSllFsUigpTpcn2FG4Xx.ezGsFidesdvHojX2RF5PY16xcRTBIHAxc5Awf.3zPC
 YP3NijxmAMtfNwMRt1lZ52vWlaO_tMN3bnkRXIS2RAUJVCz9JIEy.ffD4Ay581W1Bi4L5xgPa4L0
 HwmBQoTj1_wGfI7tGkGep1RQEHbjTefhYgrs0ldylEHYJPGevg6EW.ClZhqpmBKSb6FkT1A.6eC0
 rsQ.xO3y3fMRkCG5XCKUJ.MsSwHWjzoPEyi6HBFjzUQ9XOXAipmIi3mwJwAQCwh571jMv6TS6.Pe
 Twm0VBGJGGGCtT.av9NWQW1hVY3kxlyNvuRF.5Lhdqki8U0cyd2gsuacuwlYZddu1CTld3QBvSCc
 iN4JyK19jPQLhnsnlzAmBGsKy6Ez_5PGH6XRSCZisvIPgRdMnGVNlps2jC0DL_JJLXQQVGYu0hgx
 MIqzZ3zX3eORQLvupIHAMALo.7lmP7Ov62LIyL0zD7Uto0Q9ZdNra7aZl5Tdk6JXWImiYjdoz1So
 biQ74qw7DEhfHhezLig3Byq6dUbCJXqqUiNlXYWEvb9lrwRjWTEi8QRS.JqOh9mvw63vkAqM2CiD
 2p_OuvbEgIruKR_nPFwVGm9Tunz08sGj2OHHzEyQzeV7RlIK5ZlNBWZ048gzLa8AnY202pL7wQbl
 DmbViJ3uyyEHXY8tEbCD_Aa4wzkWqkJGRqJRat8a684gmET5lHxqElfgRxcoA_RFCB9UsaWOY76c
 0X3Xry17IPaTsL6C1jDiBTuI1MVwxJTEB.ebnagvjaq0YoYE18t9cdszVljVG0vYAFfcOlA06RGW
 m7UIEVD9RWFDSEOO2TZ3dq0M.mMnm1UHzsXP4nAIesHfHdY1LB6NfkCimBcOq9znF2Vamkm6DXwy
 uXFinPyU8tGFHgWiGLlxp.pvHIQiL9BmbvDy6ZO._cr8Kvzk4vgK_tHevfOpDu_u61bePqjO5P8z
 p_50.ObZ1sMswbwlXheQim8u_Yp1iRAmx9kCfb0PTUCGZzysbyrev6w03vqatW91yjoyvQkFjPSV
 fWbK.zADn1sLFUh_vuB0YZdFvws9LwIG5AXeBsNlwAn1bK9SZEeHZxY2DOczUl9FpMAKF05Uen5i
 _qTLk20z.cWJigSu8Ay.hpK86vM2ZuENs_zmrRbL0ajtKREUZxxZgtzDoguYj.CcVIi6Fo42X_kB
 YZAGCV6QgfOy.uZTHTI.Hqheg_nSKoGFCbmSlFhVwgAzWRfZehysW0oZmBt9Q.v1Mnxq45C1h4Gg
 UZS.OjFNWttyXiZjWIapsSGtKQ53auxZIAS7ZBihPIG_eFX7L2G7OjOBQM9pW.UidSYwj5YSuE0.
 Y7bxSEM5hrRqVxWJ63sgGk0Wl80rLCG_XL2SBA6zv.fw2uR4SxClgXUGi0lUiKjBvOg8zOPvmFx5
 sVY4LAtbMCf3JxZkDQwYi19bmaU30P3zrJY7.usSrYlobp3seSL7M9umd_1JHF5EWCpAcZ.IHQhv
 qlFr8F0oS4083eZSspbwxiQTRlVvPnjfWV6J1khvFlrzXdBfuhFVUN1ecEDnTdjxcbQYCrvI0_ef
 oxP1PFt2E38T936V4eVVvtKuwqLcgfpJ0v2TLoQIXv_gAg9wziSAkU_Gdxu35KwsimJHvsS1p8xD
 2ncA_p6h2XmeOTiuRVzXN2Xj6Iv0SQfRIWEhC3Dn55EJiWqfBjz0xWXO71X4unyidspe_58znZid
 KFBPW5E35L8CP7bQdSC393A0HHQVfAvYfvqzjZGBYpf_7dvQvBG06nOl1dEPlR_F3qEYXH3eK3s_
 ClcrnYuZKtB.bGXxNUrFT3X9vwKpk0vheivfNcSsVdzWJTv4Yx0Osvszkur.I0ksDNMUjWj4wpu0
 y3ln47y.AVLjxUK1SAaezTt7KZc3keeClQZjatjNOypf6UhA93IMlWZdUgXzqG4RCXBlbH9rmI0r
 mcu3FzDTI8vQY.6qPLbKTDh5Eb6w__G195Yh._DzWN4qX5oar57X0hZ5zi4tUWeIX7fjtvQvZDFE
 NGJdQs.CSn4Nk
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: cf43fd4c-633e-413a-82e2-38b249208732
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Sun, 18 May 2025 08:57:43 +0000
Received: by hermes--production-gq1-74d64bb7d7-k2g2q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c07c4a4ea2b90ef9265870a2a8be7fd4;
          Sun, 18 May 2025 08:57:40 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: krzk@kernel.org,
	bongsu.jeon@samsung.com,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] fix: Correct Samsung 'Electronics' spelling in copyright headers
Date: Sun, 18 May 2025 01:57:26 -0700
Message-ID: <20250518085734.88890-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250518085734.88890-1-sumanth.gavini.ref@yahoo.com>

This series fixes the misspelling of "Electronics" as "Electrnoics"
across multiple subsystems (MFD, NFC, EXTCON). Each patch targets
a different subsystem for easier review.

The changes are mechanical and do not affect functionality.

Sumanth Gavini (6):
  nfc: s3fwrn5: Correct Samsung "Electronics" spelling in copyright
    headers
  nfc: virtual_ncidev: Correct Samsung "Electronics" spelling in
    copyright headers
  extcon: extcon-max77693: Correct Samsung "Electronics" spelling in
    copyright headers
  mfd: maxim: Correct Samsung "Electronics" spelling in copyright
    headers
  mfd: maxim: Correct Samsung "Electronics" spelling in headers
  regulator: max8952: Correct Samsung "Electronics" spelling in
    copyright headers

 drivers/extcon/extcon-max77693.c     | 2 +-
 drivers/nfc/s3fwrn5/core.c           | 2 +-
 drivers/nfc/s3fwrn5/firmware.c       | 2 +-
 drivers/nfc/s3fwrn5/firmware.h       | 2 +-
 drivers/nfc/s3fwrn5/i2c.c            | 2 +-
 drivers/nfc/s3fwrn5/nci.c            | 2 +-
 drivers/nfc/s3fwrn5/nci.h            | 2 +-
 drivers/nfc/s3fwrn5/phy_common.c     | 4 ++--
 drivers/nfc/s3fwrn5/phy_common.h     | 4 ++--
 drivers/nfc/s3fwrn5/s3fwrn5.h        | 2 +-
 drivers/nfc/virtual_ncidev.c         | 2 +-
 include/linux/mfd/max14577-private.h | 2 +-
 include/linux/mfd/max14577.h         | 2 +-
 include/linux/mfd/max77686-private.h | 2 +-
 include/linux/mfd/max77686.h         | 2 +-
 include/linux/mfd/max77693-private.h | 2 +-
 include/linux/mfd/max77693.h         | 2 +-
 include/linux/mfd/max8997-private.h  | 2 +-
 include/linux/mfd/max8997.h          | 2 +-
 include/linux/mfd/max8998-private.h  | 2 +-
 include/linux/mfd/max8998.h          | 2 +-
 include/linux/regulator/max8952.h    | 2 +-
 22 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.43.0


