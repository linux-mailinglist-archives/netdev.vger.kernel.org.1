Return-Path: <netdev+bounces-138917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDB9AF69A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B3F2832A0
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD62AE84;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cja+f0J2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769CC8DF;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819263; cv=none; b=tiuHRi3I1D99wypNGTbcQ4xshm3IXMtb+oMtO1j/9H8AnyBpIR73b+L/gdXcWCI+O2x+LT6ztq1vCLSFmFMpQMhaVmQwdMRCl4DBu6qg/4DC8A39HSDDukhK/pko9YF5bTDaEd6xM8kt7C4NKsGzd65gKAzmJ0f5FVmm+DyZ3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819263; c=relaxed/simple;
	bh=1otnsKA6AXNJNQvjX5o3McHr/yUE64d7zrdHdVp9Ttk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FlAD1txehWoDmPQ0YDq9j6XT8NAO0pAxXOk5Hrk2vPupo+6fSA4q9yCLns30rLd6DR7MwEhKKFp9YvAqHnl8QyW4hWC//UD+e3bXqSpIGvZGzDjUabv/Urpod2u/7d/PKlbi34VhRu8t6A9Qz3/oH9uc19xBBr0mz0HhOyi+47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cja+f0J2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61871C4CEC7;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729819263;
	bh=1otnsKA6AXNJNQvjX5o3McHr/yUE64d7zrdHdVp9Ttk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Cja+f0J2AobTEXJerHNGgQ2j301oISqVcvmxo98EdTohH9Fw6w3cZheDm7W/SBcLd
	 jJAbR7Q8tED+NLncSYNMycZMBDEnaHnK0JylLaJa7Tqu+f6Plv2/Il+RuNZTG44/SW
	 1m3v/4yxVry5YStfwZt5qfxBEDq5x6FyRYrXyGDRzYPql/fFb+Fud+JhJXZIlwT2TW
	 RjRr/16GpvsalgYoJXXmqlqP9t+k9ZVUtTAKKe8I8MrtbMPI/L15Q96Y6ekG0BwFmd
	 0JqCPCRvbTNRZ+lfyGH7D45Wys4Vu+TemVVeSoEZMH1rMHwF1l6HeoQcypGxDwDimI
	 UNxqKJ9572hrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E01CD1039C;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
From: Nelson Escobar via B4 Relay <devnull+neescoba.cisco.com@kernel.org>
Subject: [PATCH net-next v2 0/5] enic: Use all the resources configured on
 VIC
Date: Thu, 24 Oct 2024 18:19:42 -0700
Message-Id: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC7yGmcC/y2NwQrCMBBEf0X2bEq6xhY9+R9SShq3dsEmko2hU
 vrvhuJpGB7zZgWhyCRwPawQKbNw8KXg8QBusv5Jih+lA2o0tcaTijSHTH1m10eS8ImO+hfPnES
 RtY0ZL9ScxwGK4B1p5GWX38FTUp6WBF0hE0sK8bu/5nrn/wPUpm51W2FrNCosExIXBntzXLJyY
 YZu27YfBfx0wbgAAAA=
X-Change-ID: 20241023-remove_vic_resource_limits-eaa64f9e65fb
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729819262; l=1555;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=1otnsKA6AXNJNQvjX5o3McHr/yUE64d7zrdHdVp9Ttk=;
 b=rxT7brw5elvfAKfY0od+z1O8R1B5DOpECJDXa8DVkzNHCyto+LC4iXbSrZ7Q/Z+Cv6dkmCldO
 0rW82RCUmlsD9xDTJ1D4xcs6nx0mqkuFsUj2t0HdCzsdtp0MGBi0VeO
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Endpoint-Received: by B4 Relay for neescoba@cisco.com/20241023 with
 auth_id=255
X-Original-From: Nelson Escobar <neescoba@cisco.com>
Reply-To: neescoba@cisco.com

Allow users to configure and use more than 8 rx queues and 8 tx queues
on the Cisco VIC.

This series changes the maximum number of tx and rx queues supported
from 8 to the hardware limit of 256, and allocates memory based on the
number of resources configured on the VIC.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
Changes in v2:
- Followed Kalesh's suggestions: removed redundant NULL assigments,
  returning -ENOMEM directly
- Reviewed-by tag for Simon Horman <horms@kernel.org>
- Marked Satish Kharat and John Daley as co-developers to better reflect
  their role in this patch set
- Link to v1: https://lore.kernel.org/r/20241022041707.27402-2-neescoba@cisco.com

---
Nelson Escobar (5):
      enic: Create enic_wq/rq structures to bundle per wq/rq data
      enic: Make MSI-X I/O interrupts come after the other required ones
      enic: Save resource counts we read from HW
      enic: Allocate arrays in enic struct based on VIC config
      enic: Adjust used MSI-X wq/rq/cq/interrupt resources in a more robust way

 drivers/net/ethernet/cisco/enic/enic.h         |  62 ++--
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |   8 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    | 397 +++++++++++++++----------
 drivers/net/ethernet/cisco/enic/enic_res.c     |  33 +-
 4 files changed, 294 insertions(+), 206 deletions(-)
---
base-commit: 6f07cd8301706b661776074ddc97c991d107cc91
change-id: 20241023-remove_vic_resource_limits-eaa64f9e65fb

Best regards,
-- 
Nelson Escobar <neescoba@cisco.com>



