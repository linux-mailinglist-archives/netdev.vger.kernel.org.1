Return-Path: <netdev+bounces-100370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E58E4560
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB011C2437B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3013A244;
	Mon,  3 Jun 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxU3OQNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7202135A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450288; cv=none; b=aAekw6TIF5oPXfdF9MOgybwWyJB+o0+AB+XpQgBued6YMQoB58nv2OPDltU2bQULHRf8fjeEKqnIVqkyFy7ZVwZpuo02EdlYDHu/SPWuhAFRGFNfnKt+z7ScW7YjChyfksAX2czR7J7wsTZdoUnmVu4VAwCiHUWaQGIry3A8KsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450288; c=relaxed/simple;
	bh=CEoDLkJ3D+axahfhHGyYUUFTmljP7j76I1696c9r2GY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cZPWOCVrXP5AEllqW5MSKWzIEAyg6rqVAQDGRc1frgT7IUJak+B1bYg7GNAL/oiTCiBVtN+1JH50fG8UeS8TsLLAGIp990lhJvvZcCB4SZuKVlgAvMpTzokgDPm79WmJNWeerP3NACaB+oCkKeGBbBePJRDbGXbJMfA2MsYOObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxU3OQNd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a083e617aso87392867b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717450286; x=1718055086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4NiDb3Pv1Vby0AAry6zkVD/KEp1C/Vte5LscHdoMfKA=;
        b=sxU3OQNd0e/ydnWLpGvlHVJ8+/xB4x5rf+PRTbB0U3+nCN+fpieYYcWYtKwcOjaRwD
         KttlrcebmGcLBnOEHwDjaMxVgwABIo+u4M8iMCx32+aZy79I3cikAGlpYdEXbyRGi+V0
         y6oRf7yVmSj7I73FYces9CVAIt9CG7NoAhF684Eiq7AhSZb1Fo08NYZfGkOJG+VeSzaj
         rmOiKMXRzxyR7xWBnMw1TkMCsdqVFTMpt/Q8OtfXod+6oihlIPXr/WfINN5fGiFMdwwF
         ZnV/RQTZ/80qHR712tPbV/b5I53cxp3LczL/Tw2EQA+vATO8dEaBS05ertXhQxB15kQS
         Ui5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450286; x=1718055086;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NiDb3Pv1Vby0AAry6zkVD/KEp1C/Vte5LscHdoMfKA=;
        b=H+ZzUtdXI4RvMovxmfY3h3h35sCQpRbSf0WhvImoP4xgmVZQbyHUWNO7H4jszdkpz8
         rP/oTvzuWAFPBNFF6eNjR5sMl2wCwQQtwsl3iBo65Fbq/06A8+lb5J0ri/EXhS7EJnhL
         WJlNND5HsBnTz/HCPYDY8fltqBHhJLzycv72BxfbYBBxRfwDWtUp9dURjwPieAuCbrW8
         OBBVTR2l1VoQkBNEVtMl9Dg/Ddopb3pLmD3O5upYE2fvFV+qIpvr6e7qth85sn92Yo6k
         mZYbcWIAs3b14Xo1YCMtBCdliMVnkR9QEXcgUIu6tHf+XU205HadjE2fl8VIGZma8IRP
         w1bA==
X-Gm-Message-State: AOJu0YyRKgxHGS2t8O5otGSPYks/BTYs54dRmjH3ArmzF5DWe7Qx982/
	1oj/LJUK46Y3hS5FYjVhs4N24UoJhONxiC9YGNqDtDj3zPGNEuy2vhH3FxvgeKW3TQ==
X-Google-Smtp-Source: AGHT+IEX2goDp9tBwkqIcp8HJSbbmpIIAHUZwaQn7crLYFN3x3s/eNmREo5K2lZIW9D6wYnqo8QYJO0=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a05:690c:4b0a:b0:622:d1d3:124 with SMTP id
 00721157ae682-62c79864af3mr25514187b3.10.1717450286434; Mon, 03 Jun 2024
 14:31:26 -0700 (PDT)
Date: Mon,  3 Jun 2024 21:30:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240603213054.3883725-1-yyd@google.com>
Subject: [PATCH net-next v3 0/2] tcp: add sysctl_tcp_rto_min_us
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com, 
	kerneljasonxing@gmail.com, pabeni@redhat.com, tonylu@linux.alibaba.com, 
	horms@kernel.org, David.Laight@aculab.com, Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"

Adding a sysctl knob to allow user to specify a default
rto_min at socket init time.

After this patch series, the rto_min will has multiple sources:
route option has the highest precedence, followed by the
TCP_BPF_RTO_MIN socket option, followed by this new
tcp_rto_min_us sysctl.

v3:
    fix typo, simplify min/max_t to min/max

v2:
    fit line width to 80 column.

v2: https://lore.kernel.org/netdev/20240530153436.2202800-1-yyd@google.com/
v1: https://lore.kernel.org/netdev/20240528171320.1332292-1-yyd@google.com/

Kevin Yang (2):
  tcp: derive delack_max with tcp_rto_min helper
  tcp: add sysctl_tcp_rto_min_us

 Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp.c                         |  4 +++-
 net/ipv4/tcp_ipv4.c                    |  1 +
 net/ipv4/tcp_output.c                  | 11 ++---------
 6 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


