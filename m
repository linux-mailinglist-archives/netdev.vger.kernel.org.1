Return-Path: <netdev+bounces-236493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB4EC3D3C2
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D053B32F2
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F7350A3C;
	Thu,  6 Nov 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOL2/uFp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C141E1E12
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457294; cv=none; b=V/PwL4mZEhvEhxFrgBeaf5djFSzqufjPl0NtI6vo2eVlbDyydYet2T5+bPqBm7EIBn6vfnQFclFy8VnfKbwkGTvyRHBYOUD6fg6J8RWwowxvBCtc/xRGk0klMDEUPKfRHDSu57ZiExiQMjFP+nLrZZBx1BZulEa8k5JBky5HMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457294; c=relaxed/simple;
	bh=TdRMNwspcVJ9kQA7zkIsefuyLgLFgUtCg/5v+XUh9PE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c+hMLoliaPcVnwlYDByb9PIsvceOCndfNQ5z6ys31tHXXPxIrrIFI7KmGn78SyAMu6+RyT9fSD+9l89sf7aIjoGJpET2wjcinlU0aAr9D2sG3MRo7qw9x1mQyz7xBuVf4UUpWJvyNOIYG9TY0TDMoQETDYR5F75horgAcScdu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOL2/uFp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297b355d33eso7656665ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457293; x=1763062093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lT5KwAqbRWF2gKeCcm90x9U0pAstguE9kqlPXu7sP/w=;
        b=lOL2/uFphmiMkQEgTneEDMcztKKKlzFgGdzhCmE44nCasqsAWiYGxPsw/xFlKjOedj
         a1uiP78efUAnJiYF8QWfSQH6RrSwSyfmsHZ70mCAmX1TNZ8eErV702kHPeLMipyV/FkI
         CbEJKHULIKyMtjxs3HDF3p2IRT7QEb1LmZAV5O1myMlVuV5mD5JTcZXdxIGQvfUjPJKZ
         yIjlCVXmxuMXu9pf9u1xy5g2a4uDCcJjxeUSD+0CTe3tfwxjNrCyXX0zn42SN9HiU5n4
         ygwiu5kjAJTFShccEniHYRBwasgj7bhkls7rA3UxVBbLx+rP7SYT+LtVFMHPBIIIAMt8
         05ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457293; x=1763062093;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lT5KwAqbRWF2gKeCcm90x9U0pAstguE9kqlPXu7sP/w=;
        b=A+U96sWRlzLKK6o7ugrvS0xdkdn0EmMrAK9iSE2VLLUt/jueUF0M7vhU/t5VhpOndZ
         YeQI4mHkjJolfjGMVk8m0YCZ9F4u9xHwJvlOeblldpxzqsF9iA0EhsIJdSnE+P+1fcCR
         5Tj1725qRyhBrFet2uAgvZH/fG/hqsG0MzJEO2luJGwg/c1Z815MQU0pA53wth6JYI0R
         cwYcJW25OPLzeTWzgKwZaxZU7Fk+Mu1hXWVONCPgv/G6aCE8Xiv1PrOp98KeDbpjc5JC
         i3tNgvF2uiXXYj8gELVi+mE0SqnmdLxyNVlmdVKNI/aYAjQ5HPyoTWjqT0nehpnW5LfH
         hRlQ==
X-Gm-Message-State: AOJu0Yymk9YGg2aXkHKbyHc5KYhON9sYJTKHju/9ZN3mOmtypmgDXKJu
	D5FA/pGN2Vqqe7ONmmjTucbtA8QR8b8BJSbrPi+pHNx8mk0eJBbrbw4KXdJRMtQ3YG6zQtgSeY0
	l9Z4FSk52Lu4md21fVIKghDCUhvEy8/w1mRNEqbQyngdp7fWwa3F926sBhYEYhEi6yZ9PK+p7Qe
	Ex9A7vkDqXPzR9mO/zgw9rtCgYcPYYp+7+i3a33dZotXF5CnI=
X-Google-Smtp-Source: AGHT+IGU5eYghBMAuYSLi+iZWooYj6gGPgwJCh9MNZGW+OQvjpn9F9Uz5fs0kPjXRt1fiJcT047jO+nQxDdkIw==
X-Received: from plok16.prod.google.com ([2002:a17:903:3bd0:b0:290:b156:3774])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f644:b0:267:f7bc:673c with SMTP id d9443c01a7336-297c048f427mr7510825ad.44.1762457292164;
 Thu, 06 Nov 2025 11:28:12 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-1-joshwash@google.com>
Subject: [PATCH net-next v3 0/4] gve: Improve RX buffer length management
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

This patch series improves the management of the RX buffer length for
the DQO queue format in the gve driver. The goal is to make RX buffer
length config more explicit, easy to change, and performant by default.

We accomplish that in four patches:

1.  Currently, the buffer length is implicitly coupled with the header
    split setting, which is an unintuitive and restrictive design. The
    first patch decouples the RX buffer length from the header split
    configuration.

2.  The second patch is a preparatory step for third. It converts the XDP
    config verification method to use extack for better error reporting.

3.  The third patch exposes the `rx_buf_len` parameter to userspace via
    ethtool, allowing user to directly view or modify the RX buffer length
    if supported by the device.

4.  The final patch improves the out-of-the-box RX single stream throughput
    by >10%  by changing the driver's default behavior to select the
    maximum supported RX buffer length advertised by the device during
    initialization.

Changes in v3:
* Removed newline from extack message (Jakub Kicinski)

Changes in v2:
* Plumbed extack during xdp verification in patch 2 (Jakub Kicinski)
* Refactored RX buffer length validation to clarify that it handles
  scenario when device doesn't advertise 4K support (Jakub Kicinski)

Ankit Garg (4):
  gve: Decouple header split from RX buffer length
  gve: Use extack to log xdp config verification errors
  gve: Allow ethtool to configure rx_buf_len
  gve: Default to max_rx_buffer_size for DQO if device supported

 drivers/net/ethernet/google/gve/gve.h         | 12 +++++--
 drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 +++++--
 drivers/net/ethernet/google/gve/gve_main.c    | 73 +++++++++++++++++++++++++++++-----------
 4 files changed, 78 insertions(+), 24 deletions(-)

-- 
2.51.2.997.g839fc31de9-goog


