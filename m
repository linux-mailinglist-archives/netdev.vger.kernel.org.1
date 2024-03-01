Return-Path: <netdev+bounces-76718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F85186E9B8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C57AB24934
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92839AEA;
	Fri,  1 Mar 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/xiZdMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590439AE7
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321867; cv=none; b=QrFfqJHUcYZCHmx2InVC7QH+/81pFPePCjcSnlZtq9xirxVVcqmm+C+E0lqD/4qg9/zFuB1rN8pNIueyywULQIMKa2Scta+4jYd9JXNTT/Ou+2ZkboWSmiqowuN6/isV44WIMCmU2v/RJkKAm/FCyHjFewLyNlpV2zT4zU1w9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321867; c=relaxed/simple;
	bh=FgzTYM5X/lMsnEameLBSsAoL4g/6xeQipT232ZakpgU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dx89pBcn6MHPiiib/AjcbnYhhDPaykzzVzOG9JiUw64IkuSUfYrnTDXL7ShmhYfuIhAwcKK8cNvaVy4JpMHLHOaXPDfy9rPBabBk93TR/62F1sKWLFHrDViftOZ9itSswh96DC6NlFwR6f6GsLRVX4ZgGRRI7AAOyIB/LthH1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/xiZdMw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso4250785276.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709321865; x=1709926665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYisM5aXESdqiADUpbRsF9xZVanB6ehl3xMjMe9uTek=;
        b=s/xiZdMwPCiu5HlJtmZOm2mNgcwFhC1VzlVwqptvkDwNC1JgMZ/B0xfgs9rcH5LguK
         VvRtVBsaidKqlqBZuo7zDyTaPe/2PFUuo8mgXK3O8Jw2qpyjWzMiPx92IxbRMvsYREwB
         ziWvpxPxSSG1UNf5muTPIQdGGqxc6qX006kzj7CFxdaLwMWEaFqLMD+QTYuEoOdhNfSO
         sV0lG9GWQ9FQIFpBFWnOuFkFtUICIHL1dsAJNaypHk0DLSREFvczhm3kQugDGZw5RsKa
         XF8SBhZvhYkk/JWqj0XI3l8Uf0b/DEnMFBYNICaCaJvhFOi3UAQi7vcXYa25A74Vug69
         UIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321865; x=1709926665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYisM5aXESdqiADUpbRsF9xZVanB6ehl3xMjMe9uTek=;
        b=C3wuurq7C3EjUI1OdhPer+ZzXQqgjj7aAvey0CLJslWapRLCTfwtbBK1R8OZeeeTz1
         XA2+3qXKrlc/STKsdDlF9/yFlPTSr9hAZiN9QUj2r9luSHoN0a2gGFEFDVgo6r5KD0f6
         5hPOFE0UjfKuJwYFFcMkLbORDAQv41ASsTrkRpVeXHxGnd9wBxux7ruALisLUk+oNdZp
         8rjao4f2+8JPS6JnbQgF99GG2EwvV+Ce0ks7HQLueaUEZ6oFDTV0L78pGn0X+KtSE0UG
         jNJwZesfa55GGIN/eAvGkX0TY9LsLDS5WNjrCUADnq25jyF0SHEmIVHnD2h5NjdftyQv
         m3gA==
X-Forwarded-Encrypted: i=1; AJvYcCWPscVIqi+aBaasedsc2mBjrpKJUzENqVdVP/a4bcFe1IreAM3McARVCDRFrJxVqCQCBJ0mYFA0yBX81k8Nta129Y7+9VqQ
X-Gm-Message-State: AOJu0YwPuUZU/9TPd2TNuF4IGhnnIxIv1Mvs7X6G8/yN0bOB+6uSO4gT
	Q82aDBRi5zmXxA+H72AkyHUMAzZeOSb2iC+FN8EuuXSySnThNTFWggEv7cLX9IRJFAqTA90jAdf
	0HDFiJktAZg==
X-Google-Smtp-Source: AGHT+IFBhuBsKjfxUNWX3jIO5CYnUeTbTWFnnok+FlWUsW84LDxQj51BhuGsNmrC2o+L1vGOH06Ck7+fgJlL7Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:81d2:0:b0:dc2:5456:d9ac with SMTP id
 n18-20020a2581d2000000b00dc25456d9acmr99716ybm.5.1709321864898; Fri, 01 Mar
 2024 11:37:44 -0800 (PST)
Date: Fri,  1 Mar 2024 19:37:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301193740.3436871-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net: gro: cleanups and fast path refinement
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Current GRO stack has a 'fast path' for a subset of drivers,
users of napi_frags_skb().

With TCP zerocopy/direct uses, header split at receive is becoming
more important, and GRO fast path is disabled.

This series makes GRO (a bit) more efficient for almost all use cases.

Eric Dumazet (4):
  net: gro: rename skb_gro_header_hard()
  net: gro: change skb_gro_network_header()
  net: gro: enable fast path for more cases
  tcp: gro: micro optimizations in tcp[4]_gro_complete()

 drivers/net/geneve.c   |  2 +-
 include/net/gro.h      | 34 ++++++++++++++++------------------
 net/core/gro.c         | 25 +++++++++++++++++--------
 net/ipv4/fou_core.c    |  2 +-
 net/ipv4/gre_offload.c |  2 +-
 net/ipv4/tcp_offload.c | 19 ++++++++++---------
 6 files changed, 46 insertions(+), 38 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


