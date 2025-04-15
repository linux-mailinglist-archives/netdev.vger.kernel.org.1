Return-Path: <netdev+bounces-182933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC63A8A5FF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118BC7A2903
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D821E086;
	Tue, 15 Apr 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TCKslb0N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6941F3FDC
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739337; cv=none; b=HX7cFusdf/++GhnsBxhY0DXWngXi/skroahgeBv+x6JA5DDv/wXZjxlk8GQsNrNX50vOJ2KU4sy7dZiZxBMfH04knesjtz3MmoBFIiFa3Mh9igyRflTJiR5T8Cju5NIsjmzEu+vgQ0JS2wJgkmRok521FI5EJuGmzN0e3aEE7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739337; c=relaxed/simple;
	bh=RPNlOzcpIdhcySFqfpyBF2e7zVynxGRjqd4ydDdgP3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLgSEBf6gWA1Df/VOua5Hm6IJbAkPVxORHUU0FZ2lGUo6eBXdnW+aQisf8IVpZ4AZZ+vJvumx8ckb+XyWJ+VbsUwe9k2/j5lkkCybPs2zQx+ybrNiL5xGQKTAIW2fe4O3QSppC4gS7vHKGa5DwcaRC6jt52UJwfbfhcMLQmzKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TCKslb0N; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-603f3d42ae8so2726792eaf.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744739335; x=1745344135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANX4NdbqEAvGlGafpizA8wzqllXhtJE2T061H/45JqU=;
        b=TCKslb0NqQPnHeHAgQT6XcR5cPD7YWzr4m1zt/SUNP9SSvpHzKfdXacEMSrcAEazhY
         oL5Icx9jgQuM0DerH8SiT66r67xxbO6rN4DpDVxuPrJhxwBt6Gxnfqe+2Zy+AqnOvXlT
         M1lkw0UwjRfP23KJ99Hqwpscp79XohtnbbBIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739335; x=1745344135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANX4NdbqEAvGlGafpizA8wzqllXhtJE2T061H/45JqU=;
        b=w65nCTQ+0T/kk9vcd1zZYFUIHS8XvN2Kp+ym10Gw11X04LYzWNBV3JxTJ1rPBHTaTK
         wtF7WXrZUA8w/ch/JfC0R5QJSQTBGYl92CToFmhhTmcZ9kopY36B5PI3CCCtLS2y487i
         oE1zXcVMxtK6CcpKobht+gb0s53S3C5ub+lskECEZ+WX78hMJNCBAP8eV0ENswUytgCv
         m6/gmCrKBNxJRWcFCZMmZoMb1wbTGVkG2al/5QHRs3BGnhImejjSoX7I7Zck25DHqRmc
         Pk+Q9u1Qs6vZO35mKoDPIH/ZjvvRF36zwvLCFhyKUkTRb8bn1JxsakISe0DteRfnIAyP
         fjbA==
X-Gm-Message-State: AOJu0YzwLQ1C/WwAKKyB0x+GWJ1g/WbzGboff60mA/zUlIifn0tHfgyl
	tMaghjVagAmR4nUMemfb5djn9QOZuZyJIhXaDE08y9IBBkw2jSrmfOdVabjgOQ==
X-Gm-Gg: ASbGncue7KLrd+ISDiyMi+58mGAVf+hpFWRi4bbTRTtTfTN+3T10hPiU726jNUdVhqO
	Lecit/pXVm1m4cceNmJ00W98VzSUzZwNmcczE82OC6+06XdvttNrih2fG4L+jxIASKnfScNDjTi
	6S+dnVyi8457Jeac75gGKlvDYcR1Js2EW8JkXH/LO10OrseJBX32JW2NtmNneQUBo1cmYxoAQGm
	tSWJKZIAQDMny3/xJMp2Rn3qUSFu3u3ox6E8tAtcpG1tgVR3Ue7BMuBkqfaF9BzRwh4B1F2dHU9
	tjjPUABXfhRLjaWp1VOKa+eyqnmJ/Kb3BAui4lqPQdJAfTmTtj/L8dcBi3DzlwcXOUaR+KVlTdu
	HGU5jS7VVLnv4OlE1
X-Google-Smtp-Source: AGHT+IHwGbWOEQW1thInLCBHnI8G5txs8ZejF50mgXdGZv/oRuC8tWbL3MR0ruHuUDRuyvzK0SEdLQ==
X-Received: by 2002:a4a:ee81:0:b0:603:f526:ce1 with SMTP id 006d021491bc7-6046f5b41f2mr9723774eaf.8.1744739334824;
        Tue, 15 Apr 2025 10:48:54 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f50ee87sm2457073eaf.7.2025.04.15.10.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:48:53 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 0/4] bnxt_en: Update for net-next
Date: Tue, 15 Apr 2025 10:48:14 -0700
Message-ID: <20250415174818.1088646-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch changes the FW message timeout threshold for a warning
message.  The second patch adjusts the ethtool -w coredump length to
suppress a warning.  The last 2 patches are small cleanup patches for
the bnxt_ulp RoCE auxbus code.

Kalesh AP (2):
  bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
  bnxt_en: Remove unused macros in bnxt_ulp.h

Michael Chan (1):
  bnxt_en: Change FW message timeout warning

Shruti Parab (1):
  bnxt_en: Report the ethtool coredump length after copying the coredump

 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 11 +++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  5 -----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |  4 ----
 4 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.30.1


