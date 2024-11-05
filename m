Return-Path: <netdev+bounces-142050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999979BD3A0
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAE81F217AD
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930F1E32DA;
	Tue,  5 Nov 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1uUrvyjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2DEAD2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828648; cv=none; b=ekUomWxo5LOpPIyf/3HneWT2qubiiWXa2zWO6Q4Ky1McMmnUzuVO5PavYdWSH921716Zq3lxkgfGOnqKXiIa936QNxG6rmq6PZslpDsiyw21pHwcfWy7LcbaX+lbv3qqwfiuvmMGYNdGbj5YNX2wT0baRpbUav4IOBCrpjSv7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828648; c=relaxed/simple;
	bh=ksOTXSYoaR9xlSxSCAkG0D/FqVL6U/2z8XdO90I5CLY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tesAMOBQLAqj0FdVX6YBItzJlrknF2enAWbNS7cyimiuQz175GeY/MHa/iNioizzTN0B/K1rqfRsn4s5F8Bh9JfyOqbLe/cGzTqNSphFmU/h0HN81JEONuzjRxKR8gvDh7XUtyjgxUz5QyvonFclfskv8sbdHOWZnG2IpJNukWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1uUrvyjJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29142c79d6so9297737276.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828645; x=1731433445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4pjQVLZDflRtCsfAy85d1P2cqYuherDvdptxN/0yZk=;
        b=1uUrvyjJkuSXV6tVz7vjfCC2Di774wM0l8xLsBl5UVReWhJw0hSz75WUW1mbGCuuwN
         eCr67fWuSsg8dAqyYiRcNMZb9zFca2FQ+2EYvmwrbJSq7qCYTOFazlBMmWug8Og0o+zc
         J9WbKr9NDBAdJvvQdr5Ue04cTdla7P6XnmSRW2twQEbn64Aax+Gxb+NtF1PiGWRXHhKN
         Y5JOIROxHbDvtEyIn0HBmYb4PC92ebDTHxNPf4GIVwfYq0KbPlPMN1SpclstM7ufmW9K
         XyL+aLvt6+BszM1k7C462tI765/FcPVJYk2PNZ2oDuqTcWmXvZPCPABpn04zjjHvT27H
         Tf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828645; x=1731433445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4pjQVLZDflRtCsfAy85d1P2cqYuherDvdptxN/0yZk=;
        b=DKcyYPyxygVAIVsR0AvfIQYpNF4ric4Mm50DMKg8qyc6iuehECfZ2bYBgskP22Or+I
         QEI2vF2zmLYDQcT5CNQWR6VuNsP9ha2BIgCDULpy1o9tNwdom7xpqFsCqLNeQS8PWXY6
         k2yQfPy90iZYqQwPo5i+E9wMyxadmXO3NSYrMeH4t7QhG58xJlPo07vTkNw2AWjotUdj
         vmt6eKbgPE0s49M/uc7GRI08jrgIm2qXROEqdoSN/7m1LKZEN73VMIQS1JaG0C7Cnf/G
         o6LAkStdViIGpY+NIjQfA4r9YON1MOVFg8k/A/bpcFw8IY4BzLw88+pBWZas8ByWyatc
         sKXg==
X-Gm-Message-State: AOJu0YySqspNBAI0PKctKCJMJRVL8woUR4pUHS6xpYtZSwzOH7CX7YdE
	BsEjswdO3YceHFSPaA9Z6gSFAesZlCtB65s+4dO68GUwsLwMdbruec6qEFa9p+N/u0ObbtRolbN
	d8PY6gv9TzQ==
X-Google-Smtp-Source: AGHT+IHHIm997GXfDe5xQdp4/Ku+gjomULDzEB54KlxntWbLwDhyk6PFCMGujWTlPUF5kGhvC+ZykWYDfdTC7g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1d1:b0:e2e:3031:3f0c with SMTP
 id 3f1490d57ef6-e30e5b0ee45mr14049276.7.1730828644991; Tue, 05 Nov 2024
 09:44:04 -0800 (PST)
Date: Tue,  5 Nov 2024 17:43:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-1-edumazet@google.com>
Subject: [PATCH net-next 0/7] net: add debug checks to skb_reset_xxx_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add debug checks (only enabled for CONFIG_DEBUG_NET=y builds),
to catch bugs earlier.

Eric Dumazet (7):
  net: skb_reset_mac_len() must check if mac_header was set
  net: add debug check in skb_reset_inner_transport_header()
  net: add debug check in skb_reset_inner_network_header()
  net: add debug check in skb_reset_inner_mac_header()
  net: add debug check in skb_reset_transport_header()
  net: add debug check in skb_reset_network_header()
  net: add debug check in skb_reset_mac_header()

 include/linux/skbuff.h | 47 +++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


