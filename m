Return-Path: <netdev+bounces-234121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA33EC1CD18
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638C03B606A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB43357718;
	Wed, 29 Oct 2025 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wqiwa9m+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7A357723
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763564; cv=none; b=d86tJAI+wSJ2Qbd99+tSaA5+GP9lOU/WCPFTJD/RmNM/BXAv4u/O+t3YrdtZo++RI6LKr9neseXc+GecJxOyNaWt+ybt9P631zdfidgNG6TvsZXGyKoPuRZMJ5QumazuZVjG3r/ZAeliQuyTXZQGXUC4HQF0FZCtEjCKrVS0HY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763564; c=relaxed/simple;
	bh=cTexpRJo0wU7J7B9bcFApau9R7flokpRKQP27Gm4gxk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W0ApCqataG6gsIUql3Axuu3lmv6TczcmFR7KpFoZYWVxz7dzNysdVxDFgoqAX5i4jxK38gGD41sMKwFnJOyUrfQsCOwmzeeFve1akgSxiki3t9eyofjiZHaHbnAC4+N8U+VGPyDNaIANqzidxXJQAFPWazBvPTin8NdBZe3hnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wqiwa9m+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso209417b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761763557; x=1762368357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4br0oUegtFdNKvSxlN911J04LN7QkhMRzGEtWbYCkhA=;
        b=Wqiwa9m+gcDQmIodw09OuT7pfq5gHSxozEGzgig7AEV5M4T7AaaTY6uF9B07zpHHGv
         08uJIZoGSSIImGT0BHdAmP3CspW6Svxx64AAUltVqE0XgEL/T01czW+4jFcMsx0oQQM2
         2aCPqXWf+dH8LmnnjIJNRI2IRcgXISPlwvoww+CzuZyr9rFCB/YXroZMsVJ6kiCid7BQ
         9ABgDQuR6//vBdSHK298EtFWLUx4T7Y0h8lyVu9rj2ktrHUPy3lXXE5kmlzdqvj+qbQe
         LjRG2xgBSm3/b+OYAqN3cmovs8Kj4/+7HKIegGtzzFkqeTvNuKgftCDYelyF7yKp7xSj
         ZRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763557; x=1762368357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4br0oUegtFdNKvSxlN911J04LN7QkhMRzGEtWbYCkhA=;
        b=kTuRzCgiqWCj5qAgeFRg5MVhILqDBSKewHOJ1aPwL1bYolvX1kIMHO7kVibUNLc3vG
         Yvho7XtwtXTibZx6qXSxnjfZJYlVE790xd0gYVWvu+ELMDODr0IKyLgbLhk52KngKTBy
         PjYsI7t/cLuBQvveBcUVO4pvRyGd4nuCP0mmAP83mFA3cltU07Kkp2LlbhAAnpayvudQ
         TAOK3dfJpqdIWza2XS4gMwFCxmMTgDYx69dBnzDOS5w/cG6lFhws2v6dW8Yz+AxyGay8
         jW+qWC2FktSeo/C7m9gtntTbgC96y6Kru2IDkHyks87CUSuLCk2cu0ygJzG/35BW8NJG
         dwjw==
X-Gm-Message-State: AOJu0Yyn8xKQwqflBfP4tE66PvsOUpaEeF3spQdhpQZEfVw54p8uwYmL
	sBS7npvfqQhohyw47k0eplI48BVPVZ5g+yndDKhnPFyujwlpQk5nbkN0xkUHa+H7b+qnRgGkzyD
	pr6pSnjA6WGWDnMc2gUZVQc+gMjzdNiGxSM/l4Lnv3XGOoOPNx2SwXPFXNnOBIUxvT0GKxPfckY
	cSPy/WbIpml4638DHRfMLxrbix1rWfLdJos8oTIu+3avvLKaY=
X-Google-Smtp-Source: AGHT+IEKWkq+mWPUsmNz5aZRkdrzCUIT6gkE0tZ/BUHXHGJAYLSNM15SaKeC/GujJjvjemBDBMi1NiMu6drziQ==
X-Received: from pfblj6.prod.google.com ([2002:a05:6a00:71c6:b0:77f:1fc4:644b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e25:b0:781:2740:11b2 with SMTP id d2e1a72fcca58-7a626b0f088mr444356b3a.25.1761763556632;
 Wed, 29 Oct 2025 11:45:56 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:45:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251029184555.3852952-1-joshwash@google.com>
Subject: [PATCH net 0/2] gve: Fix NULL dereferencing with PTP clock
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Tim Hostetler <thostet@google.com>, Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

This patch series fixes NULL dereferences that are possible with gve's
PTP clock due to not stubbing certain ptp_clock_info callbacks.

Tim Hostetler (2):
  gve: Implement gettimex64 with -EOPNOTSUPP
  gve: Implement settime64 with -EOPNOTSUPP

 drivers/net/ethernet/google/gve/gve_ptp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.51.2.997.g839fc31de9-goog


