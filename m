Return-Path: <netdev+bounces-239519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36671C69251
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 488164F4F69
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F2346E77;
	Tue, 18 Nov 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmUOcx1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635E307AD9
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465534; cv=none; b=qNnAQguUGpCGI4gynEO5XmpGspbOFKgnxDzom/azTcjaHBjlDxCm6rTABkVk4QtrHo0EcDAxbUWulJNUt88jrGxnTFGpz67syCKNdUZJB/YCTkNrKZcTNAX0K4s3TYKlIEr2Xx/x4yRYwkTAIPZ9DgPNR9H7WFaH/knNts+8/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465534; c=relaxed/simple;
	bh=ZSYPQPCcxbyR8zWwisBrVYv9dYR/LlXu7hMPPvqRZKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWXLnvw/OkYcJY8VzjcV/RSnBZcyyCFB9UcHH4NqvjcXHADi8lSOG20gguMbuULBaf+PwxtwSUKBIaPvHT9MSr3JSRi9N1U4+hNkSETHYuLDthXVrHGYPszFx0Se0lkBGHaTHL8ksfNCxElKLuIrZD41DsTZcKUgCMHPdGKdHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmUOcx1z; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34372216275so5838260a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763465532; x=1764070332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj03nqtcPgmxcon+GCPvYB3CYWne1EFGms665/lYYBY=;
        b=RmUOcx1zwMaypuoh8LLXaReBq1XiGuL8EVpQzTm7kmr/WAJabMVdZhTpBcUUMTVFTu
         4x17YtRUIANplQ5hAUs7DEAAfE+EhnKDU+tr3GhPU0UB9vzBXX0EO8Hd7HGhqznoocWD
         HsYE1L+UcWs6qUasEwjTvAZyZJXlXctFtDc8LtZrBKXalJkqdMsic9QMC6iq0jAa5QhK
         61OUPA6s6C3FrBkCcq2nRsrXgKWxfe4cyVGfF0P390vNrN6x68ecAG1vNYfi6VnXsqEL
         T36KYO/l7kGvEWDuCuWAjwJIjJXCtZn3LRWCRGTRm1CVjbUm5LKvMFHVbsysAWmyDSK0
         2PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763465532; x=1764070332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj03nqtcPgmxcon+GCPvYB3CYWne1EFGms665/lYYBY=;
        b=seiPgXfTZoAV6pkqKX5bGwE5TD5OJ7dJAGdOjAd6uP5kQ8pj5cNLBfFqN58nFM8sSo
         x7hJW5sPz/RNkrA1/cnAKfavbWR3lopIHsi0GtIsD8m0ciMa6tWcO3tdGR+LY9nfbYMV
         GtPRb+jQDj8Be4gv2AVgSFwX0HPAT0CvuAElBvRjrkXzUiHPIO1Omz+UgWs3n51q2WvA
         gZYjH0KF/viSiqsHuJQc0V2sO7+lc1AXP0U3y6Nesozd1Pcy3xB0OlJxAg1XPJrpIsLq
         uXvbOrLBJv9SO/L83Qj/kM+k20Ba+VwA2F2f1ncdWu0COVItNTiKBKDSho7BUXUFLQMA
         DZfQ==
X-Gm-Message-State: AOJu0YzyjvsbjbdGXlEdodVtdOKi6mEdrnYyZSL/0a8H0Rt1pXDFot3r
	dQwtppjtK3u90VZVUobLNV3N4FlKAoRbY7PPeMR1D0vMONIQRXVzZ+3rlNz8eCcQd+Y=
X-Gm-Gg: ASbGnctA9itNOyISfgL1vHEQvTa8oZc0hcPfMs3I8arfrwRQ/wyfLm555oY2NkdrUCR
	pvfoj4p2/Mpw+dZ1Mfx96znTVM5lq9BDk8zvmzuqI1whNHJ8jiiHeFgeqkxvYY14qrn3wslCeXl
	O2sNcP8Ro09DWCXFNWOx7Jp9cA475tmerrMdlobg+I+8lFKtaif0VtEcn+GI7vIuhY76NJ4lxUx
	kfsh0r5L5F0G6dvEbD/qIqJCX9kD+NGyKEnKeL26bJrMwiqn3I2gic+4urZPAqjU//TvXdAywLH
	Zi2YfZPweu7rviWl/YGQAo+Muefb8OnLdMvbp8VXnGyq99gxctGnMCdsDUoUN4XM+HErQdqSxOH
	/D+1KmiXJaCBxV3/F9mR5OYII+8QyU2ItBrDb1yesT/2kbUvJ/emrClr1AnZrD1Vvn06PABzY4+
	TAry/AtQqVZvMQfTgngo5A9x7d0zdy378EXOXgmNnmB79m5sNF9g==
X-Google-Smtp-Source: AGHT+IG5VaG6Q0GIZPMrPaqT5GuUqUFcmdC9/5IBvB6VhxiJ4DPZkDYWpqxjta4C8WIbFOkh7vfiXg==
X-Received: by 2002:a17:90b:3c90:b0:340:dd2c:a3d9 with SMTP id 98e67ed59e1d1-343f9ec8d58mr19036285a91.12.1763465531943;
        Tue, 18 Nov 2025 03:32:11 -0800 (PST)
Received: from localhost.localdomain ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456516d4a9sm12583736a91.11.2025.11.18.03.32.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Nov 2025 03:32:11 -0800 (PST)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v4 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Tue, 18 Nov 2025 22:31:16 +1100
Message-Id: <20251118113117.11567-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alright, hopefully last time I spam you with this.

The status descriptor handling code is now shared in
i40e_clean_programming_status. 

Changes since v3:

* move the shared code in i40e_clean_programming_status

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 59 +++++++++++--------
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  5 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 14 ++---
 3 files changed, 42 insertions(+), 36 deletions(-)


base-commit: 896f1a2493b59beb2b5ccdf990503dbb16cb2256
-- 
2.43.0


