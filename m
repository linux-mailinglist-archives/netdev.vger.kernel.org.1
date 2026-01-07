Return-Path: <netdev+bounces-247533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A764BCFB8B5
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B578E3034E41
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8823D294;
	Wed,  7 Jan 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjzx3J1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC472417F0
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747921; cv=none; b=QAQN1PTx71H8tLQjf6Z1b+HV4gfLpJnaXPnTgoJ1xpiadz0KaY2BEWgwQ9hpGSsDEwrBuhgHO0LaifYhWI6a9jGnhGSsuz4D3L3I2TjWh+Bao8DlBrQCzzUvekNCK8NEJ+M1WsgVHsS89hoY86/BIBLc3eaOYKZkcmlZlA1yu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747921; c=relaxed/simple;
	bh=8+A7JJ35NzoQ5l9hGwxPyHD1LIdTAMGfemokebbJmOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H3sxBOVKqogON4UWNAzMa8ArI0fD7CSmWOANKCqrYz8sYOGYvvAhEfj4RoHr/lkh2BOKGIFjKWPrt53avtX9D/kOj3SONeLyKmO6GAaqrgR6l1wbS+wAO2EZFsiTeWHdTPcXKehqoQKlEhM8EuggoUbv0QqPLXB2I5rhR0YwQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjzx3J1b; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ae32686ed0so3085209eec.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 17:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767747919; x=1768352719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgCM4PdeMwtaGAjDdJiUYbxQZ0vj4v9BcNHM8Ys9aos=;
        b=wjzx3J1b3Qq2QEuS9s5I/d6402EtjNIbQgCyWcuOxnkQF9w+yW5nR2jYejP0l7Usfn
         QnmgWDFL3xhZnTl+m3BW7YWQMBZNRpYw0pWjUV8PVmfRKYDRZW/lz9MANvoWY8M68l/z
         jHzjf4u3LqjyXxOHmbJCZFVnHcii4WSDL7Azp5XHUsV0i0u2M8Pf/V+rqlynliMPMhC/
         rMXoGjvvbChKK8Kyb9/rhclhoidFdVGB+ohJZwUXdo07Vx8BgJlHrO974eWIJw01zfp/
         0D1ayuqKEzoiNofScMF4Yv0V5UIqZAPwWXSYphidi+VZLAscLJjaPknEw7PzXpaXujbd
         mocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747919; x=1768352719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgCM4PdeMwtaGAjDdJiUYbxQZ0vj4v9BcNHM8Ys9aos=;
        b=ks5x1y5g3BZxGJD3FxHM0I1Ym4DiBR/BmG78AUB25iTuEEdZzPvJbUlLschjkkRKbs
         MD7dctX0Y/GQcOFtu61xQqYrIGmZjY7MY+7m5Hefj7j1H/Ryjvsmvhv4kpDsmH3jXgey
         zju7j7IIpGx7nxvq0WoyUEvMPlV7T1JBwoVLaQt8juwz6QERcrxj9Iy/tiexStSIOE1o
         V1C2YI6K+dmXgR0LlEqVzUUQJlEgT3qH84Zbg7+O4dYNjGPsaGlKosRuGUdS6pMVisM5
         hkYQTtHLbUG/CXcbW49JrMKWPyQudbgZE5djduw5Sr+9LFfnE0pXFhsz+LHtpEKMsSSW
         3utg==
X-Gm-Message-State: AOJu0YyPGNcH+H0x3lkwSQ5pn9p+L6v5zRwH5UpBP3DRSIEmUE7CH78Q
	YtaX1CBxgeJ3i3TwpvGeBLOJQTg1NTTulYhfQTFt6I00FMfxcOvsfbEKcsE/gIuTlfAuMTfxzMc
	H1eIWpQ==
X-Google-Smtp-Source: AGHT+IFj+b4aF+K3rOjN8KEbm91uYV5xlFvkogdLWnfIxNCoV4dVQ9b0ZLkt2gOYISLMhV6VHkw1LvhmW/8=
X-Received: from dybcp4.prod.google.com ([2002:a05:7300:a144:b0:2a2:4eb1:3771])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e42b:b0:2ae:4fd7:ba56
 with SMTP id 5a478bee46e88-2b17d2951e1mr608048eec.23.1767747918938; Tue, 06
 Jan 2026 17:05:18 -0800 (PST)
Date: Wed,  7 Jan 2026 01:05:01 +0000
In-Reply-To: <20260107010503.2242163-1-boolli@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107010503.2242163-1-boolli@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107010503.2242163-3-boolli@google.com>
Subject: [PATCH 3/5] idpf: skip getting RX flow rules if vport is NULL during
 HW reset
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"

When an idpf HW reset is triggered, it clears the vport but does
not clear the netdev held by vport:

    // In idpf_vport_dealloc() called by idpf_init_hard_reset(),
    // idpf_init_hard_reset() sets IDPF_HR_RESET_IN_PROG, so
    // idpf_decfg_netdev() doesn't get called.
    if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
        idpf_decfg_netdev(vport);
    // idpf_decfg_netdev() would clear netdev but it isn't called:
    unregister_netdev(vport->netdev);
    free_netdev(vport->netdev);
    vport->netdev = NULL;
    // Later in idpf_init_hard_reset(), the vport is cleared:
    kfree(adapter->vports);
    adapter->vports = NULL;

During an idpf HW reset, when userspace gets RX flow classification
rules of the netdev, the vport associated with the netdev is NULL,
and so a kernel panic would happen:

[ 1466.308592] BUG: kernel NULL pointer dereference, address: 0000000000000032
...
[ 1466.356222] RIP: 0010:idpf_get_rxnfc+0x3b/0x70

This can be reproduced reliably by injecting a TX timeout to cause
an idpf HW reset, and injecting a virtchnl error to cause the HW
reset to fail and retry, while running "ethtool -n" in userspace.

With this patch applied, we see the following error but no kernel
panics anymore:

[  312.476576] idpf 0000:05:00.0 eth1: failed to get rules due to no vport in netdev
Cannot get RX rings: Bad address
rxclass: Cannot get RX class rule count: Bad address
RX classification rule retrieval failed

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 6a4b630b786c2..c71af85408a29 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -45,6 +44,11 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	if (!vport) {
+		netdev_err(netdev, "failed to get rules due to no vport in netdev\n");
+		err = -EFAULT;
+		goto unlock;
+	}
 	vport_config = np->adapter->vport_config[np->vport_idx];
 	user_config = &vport_config->user_config;
 
@@ -85,6 +90,7 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		break;
 	}
 
+unlock:
 	idpf_vport_ctrl_unlock(netdev);
 
 	return err;
-- 
2.52.0.351.gbe84eed79e-goog


