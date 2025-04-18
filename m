Return-Path: <netdev+bounces-184113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA00A9361D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3273ABC7C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ABE221F29;
	Fri, 18 Apr 2025 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee0Uxx9H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF4EEB3
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972874; cv=none; b=sRPS5sbNsFI9IDTjXgbW1tRglZdkl14cOlJcMjLAkVdg8EXbI96FxzgFplssPDa6vLO704q5yPyKt3vLIUVVmiFhb9uF1d9n6vq0/egJecKFfBtFh/+BRoBhS0u/T+gjIHBTDmxz+laOx8EraYjuvzHseKqhJ4tj9CDQTVgXsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972874; c=relaxed/simple;
	bh=ssRhHnqNJUPsZkPDncob+pNGXEDWfrZmrBsCviHnE5o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J9TTaWS3ocFDcIQ9hqenBuC3lbQxcTO0bskoHAphmYJOeCu/AGv4Ym+t4VZH0cL+pdCoMtpQCOLHiEopi6UdvfcvaTkC9bN3Bgc+cBpojUKtvpXcO0052M4+iCcCc4fApmm6b4ijEWP8o0ZbiRBAoBM8d8qRGYkjSdo9x17D/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee0Uxx9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A08C4CEE2;
	Fri, 18 Apr 2025 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744972873;
	bh=ssRhHnqNJUPsZkPDncob+pNGXEDWfrZmrBsCviHnE5o=;
	h=From:Subject:Date:To:Cc:From;
	b=ee0Uxx9HwLvvVQXJleivLARSu44rDfdvRy9NxkrdWen3Sx6lEWKl6KY3Ev1FcsJWf
	 nx0EPa0+NGQPJU+F452uJchNoCJsIKja83NAHvNa+F/2Ds+EPRObP7fVd5VWKu6g5M
	 WOEKcPjy9A1zM0rlej02XrA7GLZD+dqhKLSUTEUXlhgwT30NflDr3vjEWgTYYDoo+B
	 JeW8u9JbnAi/m+LqWsS2xYB52n6mQhaVsrAQqQko65fkuYRTKKZbf24CCX4hIR6Xil
	 hWChYGCsBuJ4h+Xr9tepCbg84g/HGpEJdPUL4HZCuzvbR4PMlofMo72kcM9agiDmSn
	 f7vh43sn98xNQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] Enable multiple IRQ lines support in
 airoha_eth driver
Date: Fri, 18 Apr 2025 12:40:48 +0200
Message-Id: <20250418-airoha-eth-multi-irq-v1-0-1ab0083ca3c1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAsAmgC/x3MTQ5AMBBA4avIrE3SCvFzFbEohk6CMkUk0rtrL
 L/Fey94EiYPTfKC0M2e3Rah0wQGa7aZkMdoyFRWqFxrNCzOGqTT4notJyPLgZUhVeqhzqdeQUx
 3oYmff9t2IXwV5IU5ZgAAAA==
X-Change-ID: 20250411-airoha-eth-multi-irq-8ae071c94fb0
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

EN7581 ethernet SoC supports 4 programmable IRQ lines each one composed
by 4 IRQ configuration registers to map Tx/Rx queues. Enable multiple
IRQ lines support.

---
Lorenzo Bianconi (2):
      net: airoha: Introduce airoha_irq_bank struct
      net: airoha: Enable multiple IRQ lines support in airoha_eth driver.

 drivers/net/ethernet/airoha/airoha_eth.c  | 157 ++++++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h  |  24 +++-
 drivers/net/ethernet/airoha/airoha_regs.h | 196 +++++++++++++++++++++++-------
 3 files changed, 283 insertions(+), 94 deletions(-)
---
base-commit: 8066e388be48f1ad62b0449dc1d31a25489fa12a
change-id: 20250411-airoha-eth-multi-irq-8ae071c94fb0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


