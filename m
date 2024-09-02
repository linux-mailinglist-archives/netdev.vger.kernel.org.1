Return-Path: <netdev+bounces-124200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A99687CE
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F941F21196
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655B183CA1;
	Mon,  2 Sep 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpYbUyq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9461E868;
	Mon,  2 Sep 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281220; cv=none; b=f/8QNp6YHtznO9ncX7HvBjnrvVNOnjfqPUL30wFZ4ry2tirYpejjdZgRgEhaaKKxVwcc6C9CUX/xbJj7Ol1/bHygsc8Exd3Ki9tNuaAa5/LwdhbB0zYfUGInUFyncLkIpHS+iDZaroasvYLBTHjmfHrBO9Mn7rGdIsAB1tWjacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281220; c=relaxed/simple;
	bh=cqf4+ewWLaQPZ1rDZxdUXvpmttNTRtDo3EURRXc8/3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pWc+H6sn5Fax32XcJa8J8wqfWtBkO1Iy2oLUiK+ygy2q+9qGXQuG/q9/r5pvmw/PogRv7yw2LNoizG71DldPWLkAfrZ1iTY/FGkKt9cJrlNWOSJNDSs9bijToAlvAXu0sbAnCnpc87O1fpherlrRrcq1kR0GhVDptkgTxPklrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpYbUyq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E0CC4CEC2;
	Mon,  2 Sep 2024 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725281220;
	bh=cqf4+ewWLaQPZ1rDZxdUXvpmttNTRtDo3EURRXc8/3s=;
	h=From:Date:Subject:To:Cc:From;
	b=CpYbUyq0rXCVJN5YCFNR7zOcujHHo6kXaNNF+cPz1JiLxw/UDLTpmOaZ0NYUC+S9t
	 Bp4hMoZqqScpp8QpinyfxcBS4lA87YVUTykLgTTsgblU4e5GQs3UUD+xbQN3TB1klJ
	 6QBNyjNzmxiVRZ+Cpz+qAOJ0yJRZnN9cQjpcTJYb7OfmvZ0xLyqNI0puHJBqgUFxSj
	 CThPiBpzGC57q5lde6kIMHAzk/9FGX6HCAby+gKkatWmrq4nXPIm0QYpFghA8vnXc7
	 tSO1yceExbdFRIMV4sV4z9jgGwiHEDB0S64wFt3acXwwIj7kz9gIJ+mcpz0Jn6HPK8
	 qB6KubZnJo5mg==
From: Simon Horman <horms@kernel.org>
Date: Mon, 02 Sep 2024 13:46:44 +0100
Subject: [PATCH iwl-next] ice: Consistently use ethtool_puts() to copy
 strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-igc-ss-puts-v1-1-c66a73b532c7@kernel.org>
X-B4-Tracking: v=1; b=H4sIALOz1WYC/x3MTQqAIBBA4avErBswiciuEi1KpxoIE6c/kO6et
 PwW7yUQikwCXZEg0sXCu8+oygLsOvqFkF02aKVrZZRGXiyKYDgPQUeNsZNq7UgOchEizfz8tx7
 43tDTc8Dwvh+eNc9bZwAAAA==
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 llvm@lists.linux.dev
X-Mailer: b4 0.14.0

ethtool_puts() is the preferred method for copying ethtool strings.
And ethtool_puts() is already used to copy ethtool strings in
igc_ethtool_get_strings(). With this patch igc_ethtool_get_strings()
uses it for all such cases.

In general, the compiler can't use fortification to verify that the
destination buffer isn't over-run when the destination is the first
element of an array, and more than one element of the array is to be
written by memcpy().

For the ETH_SS_PRIV_FLAGS the problem doesn't manifest as there is only
one element in the igc_priv_flags_strings array.

In the ETH_SS_TEST case, there is more than one element of
igc_gstrings_test, and from the compiler's perspective, that element is
overrun. In practice it does not overrun the overall size of the array,
but it is nice to use tooling to help us where possible. In this case
the problem is flagged as follows.

Flagged by clang-18 as:

In file included from drivers/net/ethernet/intel/igc/igc_ethtool.c:5:
In file included from ./include/linux/if_vlan.h:10:
In file included from ./include/linux/netdevice.h:24:
In file included from ./include/linux/timer.h:6:
In file included from ./include/linux/ktime.h:25:
In file included from ./include/linux/jiffies.h:10:
In file included from ./include/linux/time.h:60:
In file included from ./include/linux/time32.h:13:
In file included from ./include/linux/timex.h:67:
In file included from ./arch/x86/include/asm/timex.h:5:
In file included from ./arch/x86/include/asm/processor.h:19:
In file included from ./arch/x86/include/asm/cpuid.h:62:
In file included from ./arch/x86/include/asm/paravirt.h:21:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:13:
In file included from ./include/linux/string.h:374:
.../fortify-string.h:580:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]

And Smatch as:

.../igc_ethtool.c:771 igc_ethtool_get_strings() error: __builtin_memcpy() '*igc_gstrings_test' too small (32 vs 160)

Curiously, not flagged by gcc-14.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 457b5d7f1610..ccace77c6c2d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -768,8 +768,8 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *igc_gstrings_test,
-		       IGC_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGC_TEST_LEN; i++)
+			ethtool_puts(&p, igc_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
@@ -791,8 +791,8 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 		/* BUG_ON(p - data != IGC_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, igc_priv_flags_strings,
-		       IGC_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGC_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&p, igc_priv_flags_strings[i]);
 		break;
 	}
 }


