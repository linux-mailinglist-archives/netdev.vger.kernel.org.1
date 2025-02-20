Return-Path: <netdev+bounces-168025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD87A3D267
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AD63A95EC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF3C1E98FF;
	Thu, 20 Feb 2025 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3A0eCah5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A1249F9
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036935; cv=none; b=SYMTaxkOZ0K2vyhFCMj9Vf2caLHADn8jbApqKMXP72LnnAL1gvAS9BpWXGTMLAfZuv3xxsGwbN5QJ0XGNwHdTqTX6g/pCPEfBmVFa1ZlQZhV+OhNQbqH6MyQXgwI1WXh2OPmudAiov3NXBYelNjCtc7Wwl8cdNF7pjCFuPU907s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036935; c=relaxed/simple;
	bh=U7Yx5k/NAwOCXyebhYzvC03Dr3cLxDXqHnZXe7yefh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dlHP/R9yn5SRAzEeUOfuDYlZn2tor+wPEEdR3Z3oJtVfQhwX2drmwOMNTVp6Y/042LWnO1fbEJ9RVKvfv+S/A2z0mKB6yl5zlu/+Tqx80ogjuaqB7KZcPo3SkeosSnNzFUYYMrI/fpMRSmKpKHAstmuuHf7g8/dU0si/83Z3NQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3A0eCah5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220fb031245so12472745ad.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740036933; x=1740641733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnjCruR7pZ+UkWMQSjJfKgGfDhIgBhyVkrB3//n//vs=;
        b=3A0eCah5wMeFnr2xgI/OOyzHOcdOrj+/HXV/yZX5dxDxRrHXs6XGZuzpuqoTWHZt1J
         C6vWF8uD6W9NHYnNJos7N/eWlbMkVo3IZCp9JO9iY8xIAO1v8hjV64HiADsOHi/lUSn+
         nYaTO+QJ6cDALsk7LENb2rnR0u+WaSimuINW4hwxa6ynaLZ4iwe1k8MjJQYDo0JJn5sM
         GTIIWrbfU5LhaFJgnDEa3m7SdPjaWZRrs0irjYyCPyJs7JB2foWN20nDv3Fu+rY98tGE
         PF3qn+hHfVy3hNwne/MXT3oa1UdooEirexheOY7PdRcPnfbFatTO50oVqqE7rPleO5LW
         J/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036933; x=1740641733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnjCruR7pZ+UkWMQSjJfKgGfDhIgBhyVkrB3//n//vs=;
        b=MZ09WRnQBSQmNkH6Ow8njyCsukMk72Q/mNVhU4K7NtKVwGUPMsx9IojQsbevqWmwya
         EQy9QArSJbNDXDrnqyxi9bej+kJw79PrDZtZUDd7v2pb11+0co2FQ9R02Jh4DMgP5W0b
         0cb6WSgABAZnkKQkpQhmw/7pLaL4M6SCaBs6HsDDiKIan6a1j4P/dIEUatYUqZHPDxwk
         b669PCDiiFXCji0CAVKPf3fQejIdEGu3svrRuq6UlPwvb2FkarnWQi9ehzV5NmCB3S+1
         JzBYtl/flr0J/eF4h5ahfkM9bOY33YLYj1jAthebFiQ0MnXS/d2+A0KboxSQNbPhvM1+
         OH1w==
X-Forwarded-Encrypted: i=1; AJvYcCWbg0PwOGcUQbPkQ5SrLhnEok7rvdW/jD/JVwoM2j8bK0EIMxKgkzwjBZzbQu5ISuYNHiEPZTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNHEvvYt8SdifImLMy5xK144YOiKHJCMxYBqQitRjzjSnWhxK
	wPMH2WMxR5204jgWhLrbYv3EtS/43aPN/ImsQgpFC1VhuEz72c7/8B9q1MuMdTahcQlteplMza6
	mHz4lZuCAier3sbIuEImiVPGwP/WS9Q==
X-Google-Smtp-Source: AGHT+IHbK3KuFWHJvk1Iyx/aIwwOgDOycEgKtTFGAWWSEvRljQSodRI5tbjfOy5gcnnlFYgXHm/F60btlSNxZgr2KJGU
X-Received: from pfjx15.prod.google.com ([2002:aa7:9a4f:0:b0:730:85dc:cebb])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1014:b0:1ee:ced0:f094 with SMTP id adf61e73a8af0-1eee5d68e1fmr3022099637.33.1740036933608;
 Wed, 19 Feb 2025 23:35:33 -0800 (PST)
Date: Thu, 20 Feb 2025 07:35:14 +0000
In-Reply-To: <20250122120941.2634198-2-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122120941.2634198-2-chiachangwang@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220073515.3177296-1-chiachangwang@google.com>
Subject: [PATCH ipsec v2 0/1] Update offload configuration with SA
From: Chiachang Wang <chiachangwang@google.com>
To: chiachangwang@google.com
Cc: leonro@nvidia.com, netdev@vger.kernel.org, stanleyjhu@google.com, 
	steffen.klassert@secunet.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"

The current Security Association (SA) offload setting
cannot be modified without removing and re-adding the
SA with the new configuration. Although existing netlink
messages allow SA migration, the offload setting will
be removed after migration.

This patchset enhances SA migration to include updating
the offload setting. This is beneficial for devices that
support IPsec session management.


v1 -> v2:
- Revert "xfrm: Update offload configuration during SA update"
  change as the patch can be protentially handled in the
  hardware without the change.
- Address review feedback to correct the logic in the
  xfrm_state_migrate in the migration offload configuration
  change.
- Revise the commit message for "xfrm: Migrate offload configuration"

Chiachang Wang (1):
 xfrm: Migrate offload configuration

 include/net/xfrm.h     |  8 ++++++--
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  | 14 +++++++++++---
 net/xfrm/xfrm_user.c   | 15 +++++++++++++--
 4 files changed, 32 insertions(+), 9 deletions(-)

--
2.48.1.601.g30ceb7b040-goog


