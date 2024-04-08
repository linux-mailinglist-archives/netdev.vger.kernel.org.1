Return-Path: <netdev+bounces-85620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDBD89BA3A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680A42860CC
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5572D796;
	Mon,  8 Apr 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6HbVL3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93253364AE
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564930; cv=none; b=KJrLK2K8gGTwgkjV0sZbrE3Etz1F1LdimDYt5n93ayBDONfUtIEEN8byIJ6EXLQ5W7+LeE93n69RxyFhZIeWgaaoaRKZ5bKuMwI8z7zZUNYJGI6FNPD/sHbmfKmUuOWYaVQKQJhuQzE2XIA2tMFJTXxj3tV4el5x4csFjfWb8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564930; c=relaxed/simple;
	bh=niXxAfrjV9/SVNvnpQdZs7/XDvZMDfQsOo3MRg32GxQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RJ7FWID+m3RYmPOSp8fd21xgd14F8lLCjs4YG6lcoHyyJJUzqUvpXfPduhbUwpV+fiHf3fim/LHeSgdgqKDCRqz1XsP8z+bYjLa88kMJ5WPu0fET9evwv6BNRKwxeAX1I9Ov3tb3+be6ZbIenF5TDu5MgzTP7v1nGla1cRJnMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6HbVL3N; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so72613037b3.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 01:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712564927; x=1713169727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2o3IE3pCWWBmJby9aNxxVs7lO+f8yq5sB6mbYIwWD7Q=;
        b=G6HbVL3NcYJTpRq6wh75/eCcVDIRMvClOqHCIkXgrPGKTOzB80wW7iK4tTTU9Eappp
         D9JCLcwfRSSZ1ONdnuGnzdBykgBcDa4vgWQROXJW3gjxV5YZaaFMktkIMdONzOzEKdRZ
         xv2VsIkMhWt64pjWK2dcwmebvp5h8QIOgdo6a7U1ULOCxf0ME3ljWZSRcaOPLlNE0f4T
         5FGHJpDcMpsz8WgUMgNZtUk5wdCMDuv16tJDVw0QweTYqArhI6dR6xZbxCoyOF6mi5WQ
         22sz2cYXJcOLd0lqruoWMn8xI73HuHlq4FUBU28VIGLgV2yiKzb0VBDnGMQK5z26Z1Nj
         GXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564927; x=1713169727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2o3IE3pCWWBmJby9aNxxVs7lO+f8yq5sB6mbYIwWD7Q=;
        b=edb8T4j/2hAqTJcF3RG3wtp8QiF294DnR/EJiztOP8c3LX0OApFuqlzMR4FrotEbQE
         P2ZV3SlT4Yo1NOepH3UwwnUQmh8+ccM8z6ykyZLzmDgnYsWU15XRr2NadOTIncR5VMbW
         27qRNARFACWKIETVHsLt2F8gpqbv85eE+5Md1Uq4qXTkIuXZy90HdVmImQ8zOf57IoB6
         t9ivy3ocxD5KOlCsQZnivQuYbWg28EBatdgCnRWM7UEu+BkjdMn8yhdDEuB+m0PTuwVv
         BgL70L6CgpRXiq7pkpcYsD81RZDPVBmbbr1eDkKNUnlyEhS6/zA69IMEQzPo/1OUgW3A
         04MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA6N+40QkdfESDqp+L91r8MvKjHxfN2KFEBZByAUMdqIVMtvYicXwySibXTJPx9ZbSCXAOnbFhKUwQ1TtQCU2N4XRnTqmp
X-Gm-Message-State: AOJu0YymVzPR+10uKYoWj5k3IGttPNDU+7aXr0Y2BDI4cZ7PbdErdpm8
	0fQYHn5UNyUQhkp2IbVWNJLohZ4oQynYz6vVZmWTaRI0RHrob7/Hxj3Cg9f0GlgSYwiRmdvYq32
	8NFtLzhL5cA==
X-Google-Smtp-Source: AGHT+IGmS25JkChOPHKfDWS9LWrV0lsh+MwD14u5iyQT6uBqtqZ0eQ1kd4nu6EgdVp9m46pROqRVrSxjHzXIZQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:cbce:0:b0:615:44d5:f6f8 with SMTP id
 n197-20020a0dcbce000000b0061544d5f6f8mr2135132ywd.10.1712564927317; Mon, 08
 Apr 2024 01:28:47 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:28:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408082845.3957374-1-edumazet@google.com>
Subject: [PATCH net 0/3] net: start to replace copy_from_sockptr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We got several syzbot reports about unsafe copy_from_sockptr()
calls. After fixing some of them, it appears that we could
use a new helper to factorize all the checks in one place.

This series targets net tree, we can later start converting
many call sites in net-next.

Eric Dumazet (3):
  net: add copy_safe_from_sockptr() helper
  mISDN: fix MISDN_TIME_STAMP handling
  nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies

 drivers/isdn/mISDN/socket.c | 10 +++++-----
 include/linux/sockptr.h     | 25 +++++++++++++++++++++++++
 net/nfc/llcp_sock.c         | 12 ++++++------
 3 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


