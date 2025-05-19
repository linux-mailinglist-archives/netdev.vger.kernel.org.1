Return-Path: <netdev+bounces-191668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C509ABCA64
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159CF3A2780
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CCC21A425;
	Mon, 19 May 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="h6dqn127"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-20.consmr.mail.sg3.yahoo.com (sonic308-20.consmr.mail.sg3.yahoo.com [106.10.241.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5720B1F4
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691709; cv=none; b=opPHeF37qfv5v59yaLQF4zc6Li4ArMVuwlKmc5Mn81NksZnbaKjCs3LZK/otwo15dFTtuELuc5M/vzFD07q7DJU8i1EgpvY2DakFAc0mBUVJwE+OZxI++fOI7WIG7k+1YTcirhm3bMJQykcbJQK/QlRYE9mmCIkpnd8GLOhlsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691709; c=relaxed/simple;
	bh=C1Zqj3JRfLSuUvMUG12lgk9tmwQBWWOhW/vbeCEZVB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=XLKzv7sB1018KIkVMb23qdzlNwkD2Q3UZo3AA9QdzMr+bP6XuBV15aJh5A3qcAX4iXgg3kog9Qef20ZE7zevIKslP4BejHC4Jcxscth6BqJ/UEsvljjCeanMlK/xVP1+n518vhlRvpvw7GwzdsMNDd1VZjf+1pahgk+y2zTwqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=h6dqn127; arc=none smtp.client-ip=106.10.241.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747691700; bh=sZc8TW8Qe7ENGKIbNTGywz8wtSH+oZRNTWQbtWOIpTc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=h6dqn1277mshiV+COm0TcIR6hGDhRb+KBsSAfZHY8JFc0ERkuD9rdeeRKaZslMLNeXeHNkNZTlWEe+rIzlCwMbva8gghY+ohuaq7PF+iElq6KKHlpF6IE5APNCpjYkymF4ApXE7qt2i/IHuvYBTtPggbycR77MQ4DbanBjeSRwrC6aAjwu2zemysYN/t5m0NFgst6nluzhgWzq3+3xJhr+jHsVo3ORGA5Vv1URdP5uE50gzIqGvGfPA2OP2TA3RVisiJ3mzXTcY4+/tyYTbHoe9YosIGKUgzcncPaQkbOtu/dvTj0O4cXHkR6UK1BrR6WeupqoI4KSzHFQUsSRFS0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747691700; bh=E2dXjCzj1a0AfAYnitnSwHhKrcl2MxH4mPTeIG8Dy0A=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=P5ZYkV9XlKdmfKDeWiVMBlmKPOInYXRKKIhQ5cOFh18uktC55LmBfczSu/IZ2GQiwQOg3xKkd4yi+mJYHB4BHjFfDeymC6ngxj30k9eiLJhAjTUY+rTpgHbaYmE8q5LQ6iLyY3gLLDt4qRmx18spY2V6SizNoI/URDtbuneLN//kYyeAz2c4MeeuLs+5fWT+Iu74+vvbLD7DZvd0DnR1D3G6k3WY/sSA/rtaIaaXUWIS7RBSv1/5m3IJaNfCAAaRJGYUOgyyZqvj5xkQ/fRXPCXPWK1Aa54udnmp3HYPPB9lIajMnax2rpMQTTOizPuORAXwspYw3+O5gkMElKtfXA==
X-YMail-OSG: N5QIzyAVM1n6A3Jv0sjFnYc6a5yRWDYT1I3keOBPGaGP8qX1hgi_JNUQ31cvtJV
 bGsNdDRYuOh04ehMJAj8TwSMfLQCOuD2K_Y.IFsx3XoTA2m2RS2RpnU_7GbfBvskYBmPRFlSrq.h
 GzGlj78EUUrPQV2sg_5CdORBNY89AsJU5E3WvgPXFTeNiLHNabMnhgdyB3JiIMTd3tX.FOalz8oO
 N1SFHqqGVq1tFn8yzQC1yfrTz9GBRynOWK_1c_y6elYCdLVCE9_i3nYEsAAYuZ6SQQ430PeDagFL
 WcbB0kxXdtUeLzjwXHRydT_auAhOupzUYzdTHMqZF0o06.YTABroJYTZiIowlUroMW8MYQM_nys6
 aYj2XtFkd4ISBjF_vkkFh8Wzv7C1sW9YKV.0UrX368FxpQmP_JvP2qGsUvuOK_JA2t3ZyvXvBUZx
 e6SHLJ3l1pii47FTUGY36By5BgDtgTlE0i0bmeZHNRJX6w8Tnt09vdFWjXmC0jFJDLwV183PKY0R
 4yQXN8d5tPgkJRjKBOogHMhNJV5fWqSdGm.ONaBSikRyGmGr4.FMi_SrWhDFBDd2NECimj.aQZtf
 xFCrkBBXCJGS9XbY2g23U1c3L2usMmMm2.v4JD0HTAJpfySD062emM4NU6OLjHL11jFaFu6lLAv1
 EdKVtPCtJ8cfjjFtaj4GpwQTC6qbNaPEq1avqKINo6w8fWb26efhf9ojw_EEkWrObzvQwsYdMmqF
 GIjfK8daim2WWcgr9wB5LXWTE7pHXTELlnGj2g_KLc2Sk9c.nQjROXWAabatTs3xRd6dsyUSVMfd
 tiEChbjA2N5ID64a_5xbvN44TYuIg8yzF5tfNfCqQnfoIAMnSnDcfQ9sXVtFhUxTJN5QmSJ0FPfY
 hf.EQ17wHcBZdaVdUSDl_z3FajwpYXOWua829pw_ad6fDdwm7_9QSy_7jRAJWWOhv3aH1u24WV1V
 yu1TMuNgfwEnRU4.UCevX8C5YK5NKurlOVBouo1_kNbubINSHQXrKU8t91HMn5erw0uX2P6m8bqR
 J4rwV.drXguowjFlglEfNxPE598tBK06wBcb2_q2Y4z7vaxtStv1.zFTR2FfWp.RKQLtgdisouDT
 cyLIm80qVHvjkw7TSbCniVrIlEdPZ0HSrGptJGQ7R0flZ0kjZ5Qrd1F6bk2rL1PNXbyX67Wb_RUe
 rjgImDf1xrH4sFUptv.G.2z2TBJCoeCqmWb6lKOVWempRh2TgqI0stZwkrHPhFQilRmykeAe0esF
 F0_0YX3z2PgpQPds6P6I0IZC56lgzcggVPlHbNncswUKtwAw8pbdS6_0u2Re_CvYcLnzorv4u1D9
 mPWuK3UN6cBy4ELyKag324ZbafO6gjLBa5jyZtNbLi8QJcU8uC8dMe7KIn82pj6wPCC3K4J0MePq
 BQrO5t29Z6lxuMa.UvbvtOMvlxpkGTv7qtInVZyP2QnxcSpYL325lGxK8KX5iQFhvXPzLz0SbHdX
 QvCPJCAU0y5yJHsooOhfRMfxT7VfFx8NNf73wpUe2KzkcmzGN2iQNvqFRhT_g6AVIVII5.3cbyQZ
 Ke4fIKNlm4JCPIKPm1sBvdEuK_RjBlJp672uNIGW5PMeFNgSNU2JAfqBX7tKCz2SD0Glpmgupke7
 Xst6c17eUmi3jS8VwXj6N0kWLoZ2fXJOqb6FilEcDLStQ5PAz967ZDkJ7K3Pg6dPBe8b1ALmpzeh
 lxLp9FQ5En6XsJe1ahSrtMcRrqqMqOXB.ueUCGLC5BjIyo5627ggI6ihY5uHNTstjPfGzNq9PdYk
 GqwgnHXEWYi7xNJ5wOehAezHzlscJRV7tb8ZB_RK0AjwrOF0g.yN0P_owqubjpgRaJdB54_Tya_U
 P5V4oyX.5vvsB.qtChnkaYj1EtvW8OmkOBEu9sCThcU8uJQADWmmhYOe4vlnh8CWFf6raceAmVAI
 Nh_FMHJortHyfZpyF1uAEHdvu1L.pAVwuc6PWirRf3l6FPXgzsNTAavKzN8k15N1gSIfSWyiAUBr
 tHJtDSKU_uifINQG0pWycuWEqV87YlEwjahoe8Piy_KiJjvBcO0MBRej.wP2uAEfHaHstQmxk7ba
 mmaeqzMPf3ZCS7X9pCTuji11eKmSilIG7n5ra0lfZ0EjaMBuBxVEQVb.2iHeEj.w.EGXjYeuxbrm
 HnRnHhabTtC5N4swFoWAAD_pHC6grtvAh_tlrxEZN3M2mKQEnk8czsrR5iJ7s62ITYrGtB1tLgs5
 dEco.6.1kPFv9s9.bhZvpm4IdB4KxgD58oiGaA4QQsu2Uzey_DllZVOCdUkt3TZvGjXLWGVBAX55
 Tk.PZ9k26BwOKlbMrKJ5e_Qm_7peL3f3YtfLIB19iJqOgHQ--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 4657896f-ebc8-4b38-83cb-2b6ea416c4c2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Mon, 19 May 2025 21:55:00 +0000
Received: by hermes--production-gq1-74d64bb7d7-rstz2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d5fa22a8ec8900100267a57050f58b0c;
          Mon, 19 May 2025 21:54:56 +0000 (UTC)
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
Subject: [PATCH v2 0/5] fix: Correct Samsung 'Electronics' spelling in copyright headers
Date: Mon, 19 May 2025 14:54:40 -0700
Message-ID: <20250519215452.138389-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250519215452.138389-1-sumanth.gavini.ref@yahoo.com>

This series fixes the misspelling of "Electronics" as "Electrnoics"
across multiple subsystems (MFD, NFC, EXTCON). Each patch targets
a different subsystem for easier review.

The changes are mechanical and do not affect functionality.

v2:
-- Addressed Krzysztof's comments:
   - Squashed NFC patches into a single commit
   - Combined "nfc: virtual_ncidev" and "nfc: s3fwrn5" corrections

Sumanth Gavini (5):
  nfc: Correct Samsung "Electronics" spelling in copyright headers
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


