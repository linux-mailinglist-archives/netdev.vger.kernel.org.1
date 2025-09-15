Return-Path: <netdev+bounces-223248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462C9B587E9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C5176D11
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381872D8385;
	Mon, 15 Sep 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpYe5mjw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604D1F7575
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977141; cv=none; b=TgAHrgHpwkqB/v98ap4W7GcUp/HrMu2Rk2/eBiecT+EVZVyYP0AFnxkpwkl9FoNiC+bna1SlhhSqsVzSs5FIIvmrJyL6bzzlGj/jt9VLBbSokglzepjmMWLPOYFkfrMiqRy0Wiuw7G/EqkA05HLIF4ZC7JjWYujDhe0Eb5h2Mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977141; c=relaxed/simple;
	bh=ftt+iv2dDCGkvUxXnG9rJL/cOZSanH7X71959fWWkQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtWtGU9h2PdFIobK5XrF9oh6wx6tdJHNy7evO+reHnx4lBCAFzBLgS7vxtswTJefW0MpxqT9DegfCsGxaGwdWIovI2xogajRCE6dHCGWPxYQaA5jFH7kTaZ1G5bBNn9WxGdR6cKAVPvnN1ob7mGxx2YYG9bCSweq/lmVp5v3WNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpYe5mjw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-329b760080fso4774811a91.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757977139; x=1758581939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSDmoqlxw4z4aQswpyZFiamImQuOx8Z+ekpGup4taR8=;
        b=dpYe5mjwcJAU1DNlLv0KT6Qjnqm2ZpsPbJ6R5YFjs0Xuoec3wYpepiBhaH83UvUE9S
         oY+pm4/C+BOu8p5KNlusveCs2ExCEhi2B+PbmVrbuKUqetHo/G1uNuqFwoC8EiuFC2Uh
         HsWF17wdokSOJq5e7DVp2hzlfmaHt4DmxKkOnOQzdAGqIB4eoaJZAe9F3g3TKyBnwEMS
         Vo+CUW3fmZdSP434N2wyeLdQ5SNuo/nTRnlvyeM2/8de+3OkX5ihNCueTwVjZq2/tp9y
         FgFW+OszckMsEJJX+w74jA7/bPBgLSwLgHkjR+NyINHEZU/ITAdLMOXMbqltoZl3Q0uC
         yuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977139; x=1758581939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSDmoqlxw4z4aQswpyZFiamImQuOx8Z+ekpGup4taR8=;
        b=sCgAduvr1ulmd2oDxlkbhjzVz38IoCEhLeIgWys/MzTh15SbezvVaMSXwnMH+/oZmV
         C5/kbrpIeOu2OcsLOUPFT2Gcp/yH9DoFvOwblGW6myIvOpGG8L3MZNR+/g06APAysQTn
         kQo+ueloOEKnlmGK63CrNvHkUg5yjjPXG4//7MNJs+JC9/nI2od8U80hgGNNN9FrEJen
         QHxBbqZ7WR5Zrl/TTa9hacU+ZIgv0yPjzBEITUjG30cEH9PLfSnQEGVOMUZ25fRP0Q9G
         DDso0tSvp3CmzPcTN9PlgElS5kolvzeYITL1FH5Q+vP2dnlKd63gidJnEAZHINLjAI6R
         Ne6g==
X-Gm-Message-State: AOJu0YxCi+WOQGaDOC4PjAMBbtS2SrycN2ezF1GbpbAHxYXC5PC23f9Z
	00gNeWF7BUpHZcO0SFnrmJNRm5BC39v+k5rJmzORF9X0ku12wXu7PxnTLvL6yw==
X-Gm-Gg: ASbGncsbHAhss7DF6MDeeFc/tmh2eQbaUCf99KU+gIYrFByCym+P7mpnd6xwNcxyzQO
	dh1KyR/r+1qJ9eW48TKWco9Np85nRJTj2SDxciGsf+y48VUZq8Pokf+F9CPAbUFwLvfB6GhZt4Y
	lr+jw2YrpIWnJilhbJP2bJVQrl30VGYBDEQPEhK3QD1Yb1DpL2tqQnCNfzOj0CUCaIq7sKCseaV
	wJA0DZK79S6k2XHI/khw03XKPNgzT9rFbixmUEu3RNigoXy7BVTbMtOI5xLa3cnprdlZfN4yEtC
	bBVxZvX/fIO/ETp9q6KCy2QboerbY5OjfGvcch+epk0Et6OiZYlRhbBiUYW33jfa5gBvj3ClyB4
	7S3+hnpXe7glcdYSjCQi1x9Re97oo9U2ITJ0=
X-Google-Smtp-Source: AGHT+IG529bX/o6roCNozyvKSx21IvYoKWmgO6AuFYvXgK0iassffvFb3C6VU1p0t4Q2YB1Gp07yyQ==
X-Received: by 2002:a17:90b:534e:b0:32b:df0e:928f with SMTP id 98e67ed59e1d1-32de4fb9a28mr15872384a91.37.1757977138850;
        Mon, 15 Sep 2025 15:58:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b618sm12790980a12.32.2025.09.15.15.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:58:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	martin.lau@kernel.org,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	cpaasch@openai.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH net v2 0/2] Fix generating skb from non-linear xdp_buff for mlx5
Date: Mon, 15 Sep 2025 15:58:55 -0700
Message-ID: <20250915225857.3024997-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 -> v2
  - Simplify truesize calculation (Tariq)
  - Narrow the scope of local variables (Tariq)
  - Make truesize adjustment conditional (Tariq)

v1
  - Separate the set from [0] (Dragos)
  - Split legacy RQ and striding RQ fixes (Dragos)
  - Drop conditional truesize and end frag ptr update (Dragos)
  - Fix truesize calculation in striding RQ (Dragos)
  - Fix the always zero headlen passed to __pskb_pull_tail() that
    causes kernel panic (Nimrod)

  Link: https://lore.kernel.org/bpf/20250910034103.650342-1-ameryhung@gmail.com/

---

Hi all,

This patchset, separated from [0], contains fixes to mlx5 when handling
non-linear xdp_buff. The driver currently generates skb based on
information obtained before the XDP program runs, such as the number of
fragments and the size of the linear data. However, the XDP program can
actually change them through bpf_adjust_{head,tail}(). Fix the bugs
bygenerating skb according to xdp_buff after the XDP program runs.

[0] https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/

---

Amery Hung (2):
  net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy
    RQ
  net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
    striding RQ

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 47 +++++++++++++++----
 1 file changed, 38 insertions(+), 9 deletions(-)

-- 
2.47.3


