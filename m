Return-Path: <netdev+bounces-179750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D804DA7E704
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50417444A4B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A847A20DD5E;
	Mon,  7 Apr 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bp3IZy/F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58920967B
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043768; cv=none; b=X/O5ZU6lP3c1Ms1+Lx1zKlhXqwVM5W2yHNqvbjPemhzZyX8DkWH+SRBW/xPXpbfKPgc7Jel6LFyTHceGveD2/U0RobsFGOJdYu417GHIzmu9hCpoD1SBjlbbaC/mGDnAi7OH9OKTwwSiBmVZcjM0HG7DjjNPKLuzMsmdGZRGz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043768; c=relaxed/simple;
	bh=Owk+KfJYj+AVhFREAD0PhsmasWXGNZcNL8kcyoyzGD4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WQv5qx2+J+B7JPZMB8LWWLHFVUtTAIl6S9zkfEhKmWH/TP5TUtBsYwD7ZfOQ6zymPWA8cI2WOkUD3FLMmAGsccIxyo0TfhhUZbAQy9lez7XeBbt1sXCIzHigSgc641Cv+Cnrs1HQvF1XKP4iwtfgwdLZV00GKYtqFZM1p7b149Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bp3IZy/F; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-47689968650so46083251cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744043766; x=1744648566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2NIuTPnOvRhqd0lZN6WDhBnrhkj5ZdAa2i8ZUsSLgUk=;
        b=Bp3IZy/F0YhZFsWVdNbRo/rqy0/DQ9LJwyyEKmtZqjlOSC/ViNoAe2zKlgYoa7Ao7/
         atgk8GSER+Ag1brGD/eLp5sVmuUGsIk75tW/UGDoHvHgcImDVU34jBiyh1QjHD1xRcs4
         QQ5JV90oWJL2GLEbq0a2pxWvNYLyakppiMGICUPozWDyLL5n1OW2Iwwm4ijt8kCBpb/X
         zoKWkYsPs6vrOhDnQg6onErkYq07fb3fh6nB+g88OJumex4zQC+lBoNjII8YQ/4eL64r
         HNCJZ9Dfl4Gxu1tjLc51OthrIkWuG7mZNygu4lN9kTmfX4TIP8uPnV8H9JGaq74tPAb8
         dljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043766; x=1744648566;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NIuTPnOvRhqd0lZN6WDhBnrhkj5ZdAa2i8ZUsSLgUk=;
        b=BCU11FYRn4AJ2rhxaqwkqUfKdzVS5BwQNc6Q0wVj3bQy1HcSbP2BTTrgsRuSf1UiOj
         CVEigiIJZozTktiB0MA4VFqZihkwdsaUSF3LwymHQvRMvCCWmQMjKiP+pAQjoe8dbzPN
         ddfBaAITPsOWJCMesyM5ZTPgMm8RubRfJ9UFIAsAKYqmTMEOKXfR6MXdMcB2HRMHSm6p
         1FQbAL+h/Q8PCwSKFmsvQXUS8mKJVVR6GB0q5KdvLMKoJf7DE6Fuel/6llPoM5JOWH5N
         LJXGodyN1tuYHMylT54itCq+IPcjO6uxbTatfGPQZFuP4cHDZNL7kqvfCTGb6gSmoZCa
         lcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMjihExLsm66GsZ+7Y26lonr7XkGnlMFnFbi6KcpRPHkUVDFi7zwQDTJm5Tyd/iDvHGVEvYlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFRI2XFYZWtCaMtjVZA2e/Gsqli7/iTGsmy+Lqkn3egEbUt/l
	u9JIMkcPoce4AKdptXnSAAHoRWdWEBe4CetSG6DhA0foPjaPS8WjnpR8vVXRHKCb+XqGVAL5+fU
	h3L6/4FaAyg==
X-Google-Smtp-Source: AGHT+IHVXopJezmAt1Ahj7ejA29rQG+2M8lXKPIGtFtbKQ2kuO0je+1Pa+4A7LqLGSRfnxDu13uHmUQvhqqGmA==
X-Received: from qtbfj14.prod.google.com ([2002:a05:622a:550e:b0:476:8e67:358b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a93:b0:476:7d74:dd10 with SMTP id d75a77b69052e-47925958048mr217706761cf.19.1744043765939;
 Mon, 07 Apr 2025 09:36:05 -0700 (PDT)
Date: Mon,  7 Apr 2025 16:35:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407163602.170356-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] rps: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Minor changes in rps:

skb_flow_limit() is probably unused these days,
and data-races are quite theoretical.

Eric Dumazet (4):
  net: rps: change skb_flow_limit() hash function
  net: rps: annotate data-races around (struct sd_flow_limit)->count
  net: add data-race annotations in softnet_seq_show()
  net: rps: remove kfree_rcu_mightsleep() use

 include/net/rps.h          |  5 +++--
 net/core/dev.c             | 11 +++++++----
 net/core/dev.h             |  5 +++--
 net/core/net-procfs.c      |  9 +++++----
 net/core/sysctl_net_core.c |  6 +++---
 5 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog


