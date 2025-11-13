Return-Path: <netdev+bounces-238247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37AC56472
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 198D44EA493
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44532330B18;
	Thu, 13 Nov 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6+m9Kgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B932E757
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022301; cv=none; b=Eo/JSYy/cFRrB5GTZRxykSSRQRiFsrYBBPcuLnzuDiEW+XlJjb9xwmGIvxYyBrvX+IaM0RDlRXku6inKCYQyHjBV4Z014EkLAWg7Hmfd7U3oz9TKDUvgJrH6FC98nYsoXtRlDlzSsHhxvpbq37vUcwb+C5IWX9wepmruuiSQ1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022301; c=relaxed/simple;
	bh=pXLpg1P+NszGM8RZ98JaLiDfJk2ejEBhbCKCWa8Wy4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jvTd+TJsQuerC49Xxu/HlzKicGPbwCjqU25scuXFaugzj9O56bvBhJtA7xhRlgL6lv8B2ULj710znopcQK6YiNpvtwVx8F1CAOKU6hcvKFdBUBLueVM68vKxzvzE6oOXKsyl5VQl5gal8AH912f+bdQLTFmucozsw4ANP1kFdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6+m9Kgg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2955623e6faso4653565ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 00:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022299; x=1763627099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E29I21iTFgmKy+IbzDTMyuzYhhbOKWzxr4diSFn7ScU=;
        b=Z6+m9Kgg4ATLxOnbYbxDYu3dpm05yxztNZa8oQ1pGTD3kk9DR5YRcxn4TcSSbC3Nuq
         2kI8VJTcTVuLj2N3P8x1sXf/zYvzJfCR1nCx2SIFBRTLNQBbu9NX/XaXUxR2xR/RG2eY
         WmfjJoEtBkzxY/G57J7RkhV4FaTfHYswK8/U8CFBvHeu0HWNjTTrvP95P4vZ4G5udc/6
         rTHN3A93A+CfRaX0UrD0MjqQ9intF/RYDGB2+khUaZ+9W95LU0kIzlTEi1VmnnstO+sF
         6k7WhvHAhs1JepKhG+Z4igiU9J8ZxfWXfpFH+hIBRMX3TO+t5d5ObsSOJZblvx6m+9nC
         8qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022299; x=1763627099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E29I21iTFgmKy+IbzDTMyuzYhhbOKWzxr4diSFn7ScU=;
        b=iYvyEYRHrPf8oslfj6CLlyQYDiWPbMdBqdpquUcuT8lcCu7dV4KNyc5l1ONbi5BRdr
         BbO94cfHamxkHRdf9Pw/H0xRaf9MOElbwIPnS864AUWtN9VWVpqg2bEnTGrwzalAs+y/
         HRXtQ7zDF32sQ3IdzWr7GphkDmMtLmlJ9YGNBQNeK2KfBHi93u7jSTn/dHOliF+qVEmD
         m6uejrMCsXsQ4xLiFXm17rUyQLkCBvDvHVFq2YmbJ9Gvxjm+piHbJshf7YTNaqUNkVT9
         9wnOkQJ5nDpHOBnizumpkxiAmQltVarHlkq31iE/tOvgyUsDxQ7MAXsP1YNoqopweMON
         6/oA==
X-Gm-Message-State: AOJu0YyIIng0+BSA/FrOkHfdppBjAjM9kHKQsYz8/DfNMUrmjfwLxVP+
	Aq+FA0EPcJA/W1jxdqEqunIDUbA39Jb2csLlPuyfB2xMk7L3WpeVmwXAVTYXnvibPYU=
X-Gm-Gg: ASbGncuzpzCbYEbhjH/Y64ArqAl01bfcENIcyDpf/wfmMh4qm8QJQWlD6V8j+oRr+oq
	npPJbMpnReSbAxjV2t2x8ndWS/1de2Rne4nBalblQW3SifXo05ntCNScdhNti1yd7IcTDo5awOO
	/148mOgI8Id0gT+LfKyJ2b9DvhKZPirD6Sh4/CMYoUOtOC7gv5RoAAlwEohH/XbMh3VfmXHEoCq
	+rMd58JnKzvUVUvU70hKvYoUrvSZCHqQg1C7wsGmBOXg38u3Bf4ylpJlTJJvUvhnSSuMc21b4j0
	11HumIAtOjj9yQaCXXYtFnZkXaeE2mLQWM9mdBbxXNhvvABsBoKfFW6ohtwedDTk2RQvC28omIY
	lRAd5UBx+UhR6A7XYQ365NnlIl1aFs8ky2v7tqF2ulXtFM9vOnr5onV8yMjh/0WAg42WV0lgrJb
	Q0fci9k3z3Rs50UhWzsKicugPY6pbnQvNgMs2K70Q=
X-Google-Smtp-Source: AGHT+IG6G8bRlTc+7WY76hJfvUTnoph43OEFDRSFR5ryUFHLWUxOfe6SWPhcIlsJWUCZ9XOhzdKiwg==
X-Received: by 2002:a17:903:110f:b0:298:34b:492c with SMTP id d9443c01a7336-2984ee1df94mr76201095ad.54.1763022298884;
        Thu, 13 Nov 2025 00:24:58 -0800 (PST)
Received: from localhost.localdomain ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1055sm16332635ad.59.2025.11.13.00.24.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 00:24:58 -0800 (PST)
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
Subject: [PATCH net v3 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Thu, 13 Nov 2025 19:24:37 +1100
Message-Id: <20251113082438.54154-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

As suggested by Maciej, submitting v3 which makes i40e_clean_rx_irq and
i40e_clean_rx_irq_zc use similar logic and a shared function
i40e_inc_ntp_ntc() to advance next_to_process and next_to_clean when
handling status descriptors. 

I've left the rest of the i40e_clean_rx_irq logic unchanged or this
patch would snowball. I think it'd be nice to change the function to
work with local variables and update the rx_ring only at the end like
_zc, but seems out of scope for this patch. 

Changes since v2:
 * use common utility function i40e_inc_ntp_ntc to advance indexes

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 33 ++++++++++++-------
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 17 ++++++----
 3 files changed, 34 insertions(+), 18 deletions(-)


base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.43.0


