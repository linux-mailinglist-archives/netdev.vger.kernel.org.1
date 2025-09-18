Return-Path: <netdev+bounces-224451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA9B853F9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C57F1884140
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949F23D2A1;
	Thu, 18 Sep 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Itu0Pss4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE3A31
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205526; cv=none; b=goc79l8i9ar9L6iWnfTey1lxBE0F2GH+l+TuWlL8FBPPJ1GbhR0GvOadkKh00NnFt3PQsco+eh1xk87IASvAfPlg6nuRmcPh/ao4wNCzAZDvq/4qI94cRuo46AmCCApEPyUDG1FNiH6XEaYQ6CIudF4dIT/PHkAeepYHjtWk+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205526; c=relaxed/simple;
	bh=zd9oEvjbsFZEzkZKgyZXuavZDCPkhVV02+jKJxy8Q+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3KUcNdxgy/JuBlsJzK8S6yUQQUTxEF3SLkV/0vppohDQHiSWkG64v03BRsvHmpX6cjqQOrT8GLxohrJGB5plffKLIjhpcGuxOJWHCr+L7FioOBhmDpAvYvU5nQLWY/XI4iRN5duNxmiU3QNyxamT2KVP0TqAodX8S39esUyFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Itu0Pss4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45e03730f83so5276425e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758205522; x=1758810322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WE2DEt9EGhRBg3yNiaAboEyKKuePq1ZiZ4txhpHF3hw=;
        b=Itu0Pss4Gz+D9zvrBCqU+rcb7oo9aw4jqS0ZVoLbw9z1y84bZgpB2FG2dE8YkwUmHA
         6WBixguEjaCh0UFp3zEdNWHEySWpmr+vB7y3q4BiND4SoMfHryYvYEkjwL2hYvsKWukM
         HbDnjr/ROFFx6AFqp+Z3vmwLGZYwKgDgGaVsJBOwItIYrhaeExh37pKyogJqDuj7uFHQ
         sv+6GHnu3PkjZMZcVNwhS/a5vz6cmOXxOmgjpJv1xKrcP3mvDhvTjiN4XuVutiYtG+vw
         JCa0xMjx7A74l4CGwKXQjeM8ltMQQRVERhRR7bTe13shwzkfpyLd7nvloRJxck0EB0iA
         nM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205522; x=1758810322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WE2DEt9EGhRBg3yNiaAboEyKKuePq1ZiZ4txhpHF3hw=;
        b=raNw4kf1qUWoZSZOaAOJUC/ZBiT1Sradp8LLpUAaUiUvcCs6onft3yJ9CoCrVkK+c2
         eSwr6Iteia5sMxuFK1PvfNGuiHcljd8xMajXWmPe1aH/XmmXlmZgX8iziSF1PJbcDB3I
         dCFPmmNdvuhzchb8mgHnNJc+pEge4ox6/T1LHVuG1rIsV372YNoExSKgXJ/dINYSgOnd
         NF9RHx4rXqATgNZ/4I/99i4Tp4ynDghK3j9qFZyOFvx9eW8ulw/F/m8HhtSJmKUQHTV6
         xsX1oAKxzaeos/GJczXb75bWTM2AD1sDTKnnFLRfVXQPdQ7Jnq44tfK3WuHWaIKG/Llg
         2b0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzp1stVrbPn4SeugRGJY4gooK7xUHbBf2J1biaKUFLZZDH/SFaoWkQ0Pgpi73bBBunwdWxM+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiEtFGww9mjaeu+3f0cJUuvbA8OUkRkLpksXzSHA84cbl3zoY
	vvhwJMkXTSPucqzErMIBKegQTM4E14YhvQHg4T/fRnC1/HW+7uyztZh+a0AT4ZqaYlo=
X-Gm-Gg: ASbGnct10PBeca5VCWXVIvpLRPbAyXxcbQjAFGzjgxk1nNUhRpvW0lCsIxyE28txOOo
	zReTIR9TeXt1G5mThoL/e+Ma02iEQkA8RBxCmXc7hyrqD4CcaIDbDlJTJQR3Gja+gsfeN/I8INV
	WTPKt+cIHd2s/kBrnfSyG5g0Ghoem/sPuUSr/dxOY0gGyaRm9JniABr7wrU2g3AW5fA7d7vi6Ne
	T7Zf9yWDQnzedLKCFaTf2NztbwcWyLaihOEVlNrdSZ+duYG6WZjAoVuZlBqZrGHEvl5dYr6AT/p
	8ZoAPru6K5sF8ahKG2J+BvcF72Ce040TNkF37rklQTOJIEeeu0hY/9ktctMPiC1khatDCyZ9k+d
	7EJf/5FlUzN0IAp530pSvG0DEnhwimwyitiCWMQhDeCZHsR3b0rIoqGwY6+HGDTesl7bBJi8J+q
	I=
X-Google-Smtp-Source: AGHT+IGLDgxfcD9R60EZMn+yc5KYVxRrO0BbIFeSAQdoqt6pcwUYiTojoIKVW54d2TJVYbzhCprckw==
X-Received: by 2002:a05:600c:4e8c:b0:45b:47e1:ef71 with SMTP id 5b1f17b1804b1-462072d7939mr56704105e9.36.1758205521934;
        Thu, 18 Sep 2025 07:25:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32085823sm63270675e9.0.2025.09.18.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:25:21 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/3] net: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Thu, 18 Sep 2025 16:24:24 +0200
Message-ID: <20250918142427.309519-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND.

        WQ_UNBOUND will be removed in a next release cycle.

Thanks!


---
Changes in v2:
- wireless removed from this series
- work rebased on latest net-next changes


Marco Crivellari (3):
  net: replace use of system_unbound_wq with system_dfl_wq
  net: replace use of system_wq with system_percpu_wq
  net: WQ_PERCPU added to alloc_workqueue users

 drivers/net/can/spi/hi311x.c                         |  3 ++-
 drivers/net/can/spi/mcp251x.c                        |  3 ++-
 drivers/net/ethernet/cavium/liquidio/lio_core.c      |  2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c      |  8 +++++---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c   |  3 ++-
 .../net/ethernet/cavium/liquidio/request_manager.c   |  2 +-
 .../net/ethernet/cavium/liquidio/response_manager.c  |  3 ++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c     |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  |  3 ++-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c        |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c          |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c      |  2 +-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c   |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c  |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c  |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c |  3 ++-
 .../net/ethernet/marvell/prestera/prestera_main.c    |  2 +-
 drivers/net/ethernet/marvell/prestera/prestera_pci.c |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c           |  4 ++--
 drivers/net/ethernet/netronome/nfp/nfp_main.c        |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c           |  3 ++-
 drivers/net/ethernet/sfc/efx_channels.c              |  2 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c        |  2 +-
 drivers/net/ethernet/wiznet/w5100.c                  |  2 +-
 drivers/net/fjes/fjes_main.c                         |  5 +++--
 drivers/net/macvlan.c                                |  2 +-
 drivers/net/netdevsim/dev.c                          |  6 +++---
 drivers/net/phy/sfp.c                                | 12 ++++++------
 drivers/net/wireguard/device.c                       |  6 ++++--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c           |  3 ++-
 drivers/net/wwan/wwan_hwsim.c                        |  2 +-
 net/bridge/br_cfm.c                                  |  6 +++---
 net/bridge/br_mrp.c                                  |  8 ++++----
 net/ceph/messenger.c                                 |  3 ++-
 net/ceph/mon_client.c                                |  2 +-
 net/core/link_watch.c                                |  4 ++--
 net/core/skmsg.c                                     |  2 +-
 net/core/sock_diag.c                                 |  2 +-
 net/devlink/core.c                                   |  2 +-
 net/ipv4/inet_fragment.c                             |  2 +-
 net/netfilter/nf_conntrack_ecache.c                  |  2 +-
 net/openvswitch/dp_notify.c                          |  2 +-
 net/rds/ib_rdma.c                                    |  3 ++-
 net/rfkill/input.c                                   |  2 +-
 net/rxrpc/rxperf.c                                   |  2 +-
 net/smc/af_smc.c                                     |  6 +++---
 net/smc/smc_core.c                                   |  4 ++--
 net/tls/tls_device.c                                 |  2 +-
 net/unix/garbage.c                                   |  2 +-
 net/vmw_vsock/af_vsock.c                             |  2 +-
 net/vmw_vsock/virtio_transport.c                     |  2 +-
 net/vmw_vsock/vsock_loopback.c                       |  2 +-
 52 files changed, 88 insertions(+), 73 deletions(-)

-- 
2.51.0


