Return-Path: <netdev+bounces-231819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2694BFDCDA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA2718C596E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B223933DECE;
	Wed, 22 Oct 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkczl1UU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711B331A55
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157385; cv=none; b=sRgbPbp6aLsSDlZm5XUB7oxjPq4tLilG+dSQoELjLVOeDSDerz9/187IejR9HeyIlNcRrwsGYj1QQdTY76mTFHZghTWqO9zkIET9p6UYfFAbGlnBa7JvIOz+T/N/vENCGxB9iSxkuXdFZpHDIcyieCFGwLtoeHfN8DvCZgKdbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157385; c=relaxed/simple;
	bh=+K6gU4pDbN962OTbzW72F8Pr0/D3a7NXwC5GrI/TXjw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y/jxQvVkgdced53N3u3fAnU0p4osuxdFHgNFhmqHdJA3I/nxQTCPxeGxSBHLgp3gIRPdnDjjJhdX2q26Bl3llrgsOt0TBHAx87HAfduvEHS8O+6IFpWldkaLngk//p+uKaCMucuL7R8+f6iPhWsXV9WSTVXGa6/fpmg4IP2EeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkczl1UU; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso1240540b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761157383; x=1761762183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QnvERTjVk/9VYPJjwrSuIH93DeOljHL/NDPQQyXq2Vw=;
        b=hkczl1UUyddiFx7n+FZWrZQqnZhimPBkblec/hV3IDwnS3TFXBT++Gagdu3kIVCjdN
         tCm9u9NYimkqJYqtF3plr7V1Qu5oDzOusatSYwNvajkJblGCEDmR5zt4tTkvPemAwsKn
         lcJ1OSXCZlFX2JG5zIwWIsF2enCcHVzLFSttfxNqQ/9KnMoekAx1+d+7PY9zWOgltNIQ
         nRw9/hR0ITxEIfDuBEMu9bNAA9I7rvxVuCyuHJzjpB4SgFfnU+7L1NVq1gGpOyzWaiPr
         QQBVA3NmFlRVAJvr253An/Szqz2u38kX0fOXz50OllwSI2HIrQ9ISlPMf+yakJ5Z6Vk8
         yfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157383; x=1761762183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnvERTjVk/9VYPJjwrSuIH93DeOljHL/NDPQQyXq2Vw=;
        b=Bn4/NCCSSh/NL1SzR6k/29mfliaEkCcHwmZYDDUyPgzPPJymE90cUCYVM6v+Oy2iNH
         Bbuxj5IPW5eGAqxeYSHUxadvRAmGBbICGB7d4VS+nTshfEWZOflnN3wr+3MOMRRgEeqw
         5GG3UFHfWYqfDLDw/sdYPXAHDTqBCVzgAtjZqUgmXCO4ZjkIh1sag7fFpuhQxrcDh6AS
         huokk9WORfKrugTHrFucW6G1W3erjKQ856lXZg4t6yaW4R6QlInPviYlyxIB67MrbSV1
         RRbP7tSFNYxYwIYrwDI2jU9WsC3MIFcIE95mOddyX0tfsbcK3FBixPc3LBHPgnB4khaB
         JnQA==
X-Gm-Message-State: AOJu0Yyg0Py06rE5cNxXNoGHu+u/sAXJpbtDVgAWZVlfNPP18Em3z0Ce
	2vOLcIs4JtR+qbm12w0xDxDT9aZwtXxtn0s/HGF+/IBzvCk+sY1PYXxqHGnL1iyash4G7sXwfBW
	YesCvViimdlizZ8Gs52EWoWgX46NyNRRf74UU6ijO9SX7YMm86tQ9ayAiTNkYH+MNB1DmO6LurV
	p8BNVffPzf3QU9HcKOk5Uk8GxBiY+yAbXH+4wwyddAYYbMgnQ=
X-Google-Smtp-Source: AGHT+IElUWWYopXNTwmr/idOyOr/ov9LIeHGwd/y43eNeyAOHt49H7xt00mt6Xqrw1/VPrWa9Emeo6hD3nePDA==
X-Received: from pfbhe9.prod.google.com ([2002:a05:6a00:6609:b0:777:8649:793e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:94ce:b0:771:fa65:ae6e with SMTP id d2e1a72fcca58-7a220a99177mr31030524b3a.17.1761157383397;
 Wed, 22 Oct 2025 11:23:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:22:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022182301.1005777-1-joshwash@google.com>
Subject: [PATCH net-next 0/3] gve: Improve RX buffer length management
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

This patch series improves the management of the RX buffer length for
the DQO queue format in the gve driver. The goal is to make RX buffer
length config more explicit, easy to change, and performant by default.

We accomplish that in three patches:

1.  Currently, the buffer length is implicitly coupled with the header
    split setting, which is an unintuitive and restrictive design. The
    first patch decouples the RX buffer length from the header split
    configuration.

2.  The second patch exposes the `rx_buf_len` parameter to userspace via
    ethtool, allowing user to directly view or modify the RX buffer
    length.

3.  The final patch improves the out-of-the-box RX single stream
    throughput by >10%  by changing the driver's default behavior to
    select the maximum supported RX buffer length advertised by the
    device during initialization.

Ankit Garg (3):
  gve: Decouple header split from RX buffer length
  gve: Allow ethtool to configure rx_buf_len
  gve: Default to max_rx_buffer_size for DQO if device supported

 drivers/net/ethernet/google/gve/gve.h         | 12 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  4 ++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 ++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 55 +++++++++++++++----
 4 files changed, 69 insertions(+), 15 deletions(-)

--
2.51.1.814.gb8fa24458f-goog


