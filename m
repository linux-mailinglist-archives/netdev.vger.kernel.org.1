Return-Path: <netdev+bounces-168891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0DAA4153D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35DF3ABBCD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017913D8B2;
	Mon, 24 Feb 2025 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcCagdbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD41CD1F
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377763; cv=none; b=O5fU6UtyyK51Mjy97hNzrJT8LtH7AaQtPgDf7mZ2nvJt/emjQ/czdPWfyIWo5J8t9NzJDnJqhoOiWsbfkDkz8lzJCKCICXHeaDHHoqxorli544J5f/9VCQFqPn/hXKzXMMFRqWY+URhCi/v7kCN/kawMJaMiu2N9RqL5dRQfSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377763; c=relaxed/simple;
	bh=wGoHBj4GYEHpcFIE06CJjcuRlxOr4kQbxMKzwlTJWIw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fOx8t0zRxnkisnrGGxzj6ZD/9Kvkspsi0D9mGSj25AmJefpxKGEHMkApEhiseYuE03RpwA0eww85mjsSSl5OZq9ik8QnPNXLlFaf+tJ/851xvxasDNkNzokS3NSwyGa3X/WNd9DjCVEmQSJU/drQOKiK2Q/jjdVsuWhKJxInqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DcCagdbk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc3e239675so13518776a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 22:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740377762; x=1740982562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nQmkguyql/zE6R1Ccc9u6H0PqjAkdIF6Z2ohK+P6jy0=;
        b=DcCagdbkD7Np49tDZgyYREBPM48HO/Wt8n9NNUXyxOwrurR2uDe7pAHWVj0AT/0MdY
         MYDP9qXVyoMlD9R7gt2fQ5gjPXjQz+BEg3OH3j/Q4/eiI/XPa7VGRJPR1mi24i0FfSZO
         iGUyLFkd8q9fPm0RtHIuvq5jTM0QKVc6hMerqKyLbt/1AC2KdIM42uILcwTxu/9wk0mw
         VDaMIwk74ow7spWfZZawyne5WAq3Aj6TFlC4HY+1uhWK7aj9I0usQF3wECUgE/LoaLxN
         9hgeeByG50K3cQijel1Es3GEa4yu5qZaRBp8vHFrP3gBAPSu8NhsEyUPM7941Gq5QDPb
         DnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740377762; x=1740982562;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQmkguyql/zE6R1Ccc9u6H0PqjAkdIF6Z2ohK+P6jy0=;
        b=pAGPFRHwEsROZH+4A/21otMdatbY0WMe5UOBXS2t6ROokAI4/dg8GQbZE14yWDmuoz
         4euCzrSybhgYOeClisuq7D8DfT2w2CV9NiZPPVX3RIQIYCCtW+CNNJNWo6SxG3lcZJl/
         Ta+PfJt989fS2WcNO9oeW7OaL3PTXpgI0EAsGDHu0DTEBjb1TR6hnPYEz1QaeHQSAaoi
         WSk2R+XJxAfzrq8us8xEKTsij8hVx5svx7o5lGH+8Y4d9nMxzlyz174DKZr3gojE0oq+
         cMuAfGYH4mUlh5BCpX378ctQE4JufxhCDc8sWIk8yLgpROmBKCyBfyRhzzMglJuRuzrS
         jtug==
X-Gm-Message-State: AOJu0Yweq8lq62rVXEMHSUkMQ+qhOfDKz/x96puy3xO7oUyrq0BQyWKX
	c9ehS34iAkDSaPNm76s6WiTkYJv7lTxwmOD/pmzN3RZQn6pVptVtpse6BooVCjL/mskyPArD+wt
	9AaB4QfmslF3vXe94iUb7En42M2tPft3McDVotdVi3E7eA2LpDd5UYcH/9ygfqGcoEFpyZPI6Nc
	O54pSvBSbgPVsHV34fsrmrPddW5Wj7pnFi3NWdKySSeQw0Zwb08or8b8CCmsM1suPc0llZwA==
X-Google-Smtp-Source: AGHT+IGzi6lrEyuZU/N1Cz14RXcdxewduO9+tTTb4A8KFiGiwB+QfGNxePoqWncJ8QTpj8GNaCyRuIq5oNcktVxmKnT7
X-Received: from pfbem12.prod.google.com ([2002:a05:6a00:374c:b0:732:222e:ac25])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:99a1:b0:1ee:cf5d:c05e with SMTP id adf61e73a8af0-1eef52ca01cmr19408076637.9.1740377761585;
 Sun, 23 Feb 2025 22:16:01 -0800 (PST)
Date: Mon, 24 Feb 2025 06:15:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224061554.1906002-1-chiachangwang@google.com>
Subject: [PATCH ipsec v3 0/1] Update offload configuration with SA
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: chiahcangwang@google.com, stanleyjhu@google.com, yumike@google.com, 
	Chiachang Wang <chiachangwang@google.com>
Content-Type: text/plain; charset="UTF-8"

The current Security Association (SA) offload setting
cannot be modified without removing and re-adding the
SA with the new configuration. Although existing netlink
messages allow SA migration, the offload setting will
be removed after migration.

This patchset enhances SA migration to include updating
the offload setting. This is beneficial for devices that
support IPsec session management.

Chiachang Wang (1):
  xfrm: Migrate offload configuration

 include/net/xfrm.h     |  8 ++++++--
 net/key/af_key.c       |  2 +-
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  | 14 +++++++++++---
 net/xfrm/xfrm_user.c   | 15 +++++++++++++--
 5 files changed, 33 insertions(+), 10 deletions(-)

---
v2 -> v3:
- Update af_key.c to address kbuild error
v1 -> v2:
- Revert "xfrm: Update offload configuration during SA update"
  change as the patch can be protentially handled in the
  hardware without the change.
- Address review feedback to correct the logic in the
  xfrm_state_migrate in the migration offload configuration
  change.
- Revise the commit message for "xfrm: Migrate offload configuration"

--
2.48.1.601.g30ceb7b040-goog


