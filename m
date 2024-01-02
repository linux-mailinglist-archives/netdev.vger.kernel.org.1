Return-Path: <netdev+bounces-61011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4128222A1
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 21:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A28C284799
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79412B76;
	Tue,  2 Jan 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMiTdhr0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F632168A2
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so6569618e87.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704227673; x=1704832473; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijoKC73TdFIBBVqv9dw+ePrN9BbIEqwbvqYBbLsAH54=;
        b=LMiTdhr0UWKnSmqYwIC28ucWSwJWEvqYqx44iDEFM5PKDTZMLl0I3jANsKWKa1NDw4
         7BnaLG66Y6sZQmVBciG8tQ5j9Sz6phr2N1QadgI/Ot+vLFH62GYYYr/kK5TvCqcLyq+P
         Z6LDWQUe9QCgkVc5zJyOZDlQTuBHE51KokRAe/64tA6p5rkfG20GidFnjeknaPA6AhfQ
         hCUJQ2J7ICim5Su7asrTu48uPaz3GMxRiO5zjSi2tjnuS2QgSNe/cVc0OO/L9Rs3D9Fi
         Jhsu3tuDTWIfJCBB4UTmbMJiS/OzAOLhJKfwhH6LyxLsOWRqxy7R69ITAbzI4fvlCsD4
         OHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704227673; x=1704832473;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijoKC73TdFIBBVqv9dw+ePrN9BbIEqwbvqYBbLsAH54=;
        b=s0UeNuomca5Kxgwn0gSaEGKjffznZJ9l+cN31FToRpS1RJq1Bqcp8Dk+BPSup4cgJL
         Hqs0oByZonMFQ6K7mjDHtkop4k7PW/zRZ8XvF3eSO4N0UU5+QILUbDzPqv0ngGv2oO/S
         c2S+0H8JQDctrh/0HX3SN5h5TzQ/77mg4c0YIfWFlgwKR3pYCP8PcZd3CtaCKgLtSZyw
         ZOE7PuranDuXsePKp+QX1nZuHcrUmOOrG3/quEtO7RK6RR1/6Z/m52B5RbgoLUnfhy7w
         S81zuo9cPkpYJ9TZ4tkhm8U1FbkAFah8bxyPCXns18j4wjpxaxXHAel7Ht3y0gqR8jYM
         peoA==
X-Gm-Message-State: AOJu0YydT4k3iP92aUdmXsrKw/GF9yswBnQxlBGOFPc5EhIqJJTp7G0u
	edk2TR5n4TfmACTAzNlkk/Ygjp8SCh286w==
X-Google-Smtp-Source: AGHT+IHGkoUEplTignncvs4gU+lmE2oE8dGFIYDLVPk62i6X25zNjCJjepMfBlKvCxtPnofRRK9H3g==
X-Received: by 2002:ac2:5b5a:0:b0:50e:5afd:d585 with SMTP id i26-20020ac25b5a000000b0050e5afdd585mr3421860lfp.259.1704227673232;
        Tue, 02 Jan 2024 12:34:33 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25213000000b0050e7b52c735sm2668392lfl.145.2024.01.02.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 12:34:32 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v5 0/2] Fix a regression in the Gemini ethernet
 controller.
Date: Tue, 02 Jan 2024 21:34:24 +0100
Message-Id: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBzlGUC/4XNzU6FMBAF4Fe56dqadqYU68r3MC4oTGESLWZKU
 HPDu9uLG8xdsDzz852rKiRMRT1frkpo5cJzrqF5uKh+6vJImoeaFRhACwZ1pi890gdn1rRMJJk
 WLTQKldurxt63MFDo0xBURT6FEn/vBa+q3qq3Opy4LLP87KWr3Vd/vm3O/NVqowMaxMa5SIAv7
 5w7mR9nGXd7haPnTz2onnc9+OAsDqm78/DggT31sHpd8NFh62KipzvPHT049dzNQ0+tjSYhxH/
 etm2/Q7X/FMIBAAA=
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

These fixes were developed on top of the earlier fixes.

Finding the right solution is hard because the Gemini checksumming
engine is completely undocumented in the datasheets.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v5:
- Drop the patch re-implementing eth_header_parse_protocol()
- Link to v4: https://lore.kernel.org/r/20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org

Changes in v4:
- Properly drop all MTU/TSO muckery in the TX function, the
  whole approach is bogus.
- Make the raw etherype retrieveal return __be16, it is the
  callers job to deal with endianness (as per the pattern
  from if_vlan.h)
- Use __vlan_get_protocol() instead of vlan_get_protocol()
- Only actively bypass the TSS if the frame is over a certain
  size.
- Drop comment that no longer applies.
- Link to v3: https://lore.kernel.org/r/20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org

Changes in v3:
- Fix a whitespace bug in the first patch.
- Add generic accessors to obtain the raw ethertype of an
  ethernet frame. VLAN already have the right accessors.
- Link to v2: https://lore.kernel.org/r/20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org

Changes in v2:
- Drop the TSO and length checks altogether, this was never
  working properly.
- Plan to make a proper TSO implementation in the next kernel
  cycle.
- Link to v1: https://lore.kernel.org/r/20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org

---
Linus Walleij (2):
      net: ethernet: cortina: Drop software checksum and TSO
      net: ethernet: cortina: Bypass checksumming engine of alien ethertypes

 drivers/net/ethernet/cortina/gemini.c | 62 +++++++++++++++--------------------
 1 file changed, 26 insertions(+), 36 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231203-new-gemini-ethernet-regression-3c672de9cfd9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


