Return-Path: <netdev+bounces-75362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A08699C7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612D5293D2C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4719E149DE6;
	Tue, 27 Feb 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PP5VLfuW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849A148FE7
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046139; cv=none; b=N8SXV9vtnPwA1GvQwzSKZWm4HvoqTLasKUn4/lZvehpgtACxNuw760bu7qn9UW2GYbJOg5S7KQ/xvboyD4H0Zd5WtztRJzWbGszKPyoTiQth09Uho0AxsXe6XjS47IYncKFPMxNVwpT/HKlFH5zhIg/gN4ktkaTcSsQQZHgsIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046139; c=relaxed/simple;
	bh=GLILOSxCZ2DqLzkJWkLjcT5JTuB232j0AbzPRjBs/ZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CaU00+/Br0y9YynIVzY6KWRaKLhXA5H6pVlox4qki2tlnRQco7f28tcGguV7qSJ6j7QBIjhwmAXfQYGFh3ueFvh/5+WC0o0NyV1cUMrlQv7Z9slMur5cCq1jXPFzDulwWmtd+OQs5OIN7inUJUiPo1+jIU+YucAyIHJzLJW7fdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PP5VLfuW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso7833728276.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046137; x=1709650937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D05c69v2En4zL++gk9H2Vf+b0n0+Zb9pBNQgR/CyUI4=;
        b=PP5VLfuWSK22KVDUiX/Euk653q8rcPQTGUYaKgxX5duvsvLORSLalfqDA0xDft0Yl8
         eLlKK8uqO8X/pkRn171QEX06Ld4tjERmpmhopp0dzzVOvQevTZbyQM2V50kpHcgpDfo+
         rpg6YhHgYobmRUMpF8K06vZr4lwumZORoXA3TEMYSASkgPdfQNGn3f6dDA2dzBllho7R
         GfQDDZA5w3xQt9URFkPp2Hz1t4a1qXWt+9S31GeJLhClGoazCK9C4wseuhj2nvcW7UKm
         aNCufjAPN7xMzBqntyM66decZ0BjIbFY9vAhBuGhf3Yz1SADj3s1oh2mqiNSaSfOYZtF
         6XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046137; x=1709650937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D05c69v2En4zL++gk9H2Vf+b0n0+Zb9pBNQgR/CyUI4=;
        b=D1NOQ+8MiadXRtam+BMw+ewg+WUwmW0uLCCy1aEMpvvMmk0RugHVslNSy20L0fx6rz
         HqfnFPUTT/KqqnJR9Fbm7b/z/lj7DAqdLasQdrHmrM0Cas7+JZdIK1rVcYttjlGYg0Q0
         KUlD88emN39DWw/JIWe/dQ4JML6ytRAl4mPgDDgys7JOkd/ZYMmkFjDY0preAF1awhXE
         IJCetfceciHEzFn+IeC3blX6Gc4+GltkjOPIkfr4iyvYHou9Y6qS/3GywFWnt0ZHa8zY
         EY4Nf8Vhu3WV7zRBPy3OTEHSlk60Sh8f9SGSk/BCaYY2xCreh0zVRwemcGDeS/zM3FMa
         nU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiRe28c24j+SnGq8OYrHtDMus8yP/VwkuyjQS+QDA+LbyPoC1NxXJ5dMxbv49e+xTBw4Ztpo0x8y/vvh9KEE0g3eltjOAr
X-Gm-Message-State: AOJu0YxEu4mGKuppAwbdbVAKDXiOi9EdG6q7ukqK2XgOkGAYRs/l0R2c
	TgAF2u1ZIeNksCIBWxKrRT2XHZmgNEEIaZ2A1ax57uDnWbYhEsjxZ1z9AbJCYxRmcygvYwqepB2
	ywj32P1ZmQQ==
X-Google-Smtp-Source: AGHT+IEbbt9cyJF7DUx4mimI42jioPylfrsuJYdfiV7m39IU7tE0/Us+95FmH4/96KFuxQtb9YInLqbQ3BOPHA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:120c:b0:dc2:2ace:860 with SMTP
 id s12-20020a056902120c00b00dc22ace0860mr90102ybu.2.1709046137045; Tue, 27
 Feb 2024 07:02:17 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:54 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/15] ipv6: annotate data-races in rt6_probe()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() while reading idev->cnf.rtr_probe_interval
while its value could be changed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/route.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6a2b53de48182525a923e62ba3fbd13cba60a48a..1b897c57c55fe22eff71a22b51ad25269db622f5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -645,14 +645,15 @@ static void rt6_probe(struct fib6_nh *fib6_nh)
 		write_lock_bh(&neigh->lock);
 		if (!(neigh->nud_state & NUD_VALID) &&
 		    time_after(jiffies,
-			       neigh->updated + idev->cnf.rtr_probe_interval)) {
+			       neigh->updated +
+			       READ_ONCE(idev->cnf.rtr_probe_interval))) {
 			work = kmalloc(sizeof(*work), GFP_ATOMIC);
 			if (work)
 				__neigh_set_probe_once(neigh);
 		}
 		write_unlock_bh(&neigh->lock);
 	} else if (time_after(jiffies, last_probe +
-				       idev->cnf.rtr_probe_interval)) {
+				       READ_ONCE(idev->cnf.rtr_probe_interval))) {
 		work = kmalloc(sizeof(*work), GFP_ATOMIC);
 	}
 
-- 
2.44.0.rc1.240.g4c46232300-goog


