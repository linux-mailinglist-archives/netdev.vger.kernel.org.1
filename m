Return-Path: <netdev+bounces-16491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452C74DA07
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438431C20A7E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932412B72;
	Mon, 10 Jul 2023 15:38:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76182F2F
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:38:11 +0000 (UTC)
X-Greylist: delayed 512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 08:38:09 PDT
Received: from mx2.n90.eu (mx.n90.eu [65.21.251.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EF10D
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:38:08 -0700 (PDT)
Received: by mx2.n90.eu (Postfix, from userid 182)
	id CAC0E1000E4CB; Mon, 10 Jul 2023 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n90.eu; s=default;
	t=1689002972; bh=hcVyq2INVB4uswiTgUHMlDtwd0dhKXRQ+RHUCBFIl7s=;
	h=From:To:Subject:Date;
	b=n/WbAij2m/EQIGF2YV2bFMB8k5o+GYd1Sd/neCoLFsDphNSH07MDUuQDMin15F9Iy
	 LXmHk1r5Gx4Z35exk7G50HFRE6M9SmQdRujXHyJHNTNMA9aDU3EiT+1qdLGoTY5Il7
	 zJkSqanUlBUiBek8xSFcH7eYuZcsR2g+SrKVymRyx74Z+i9L3KozuOxnjgZpV/wy/m
	 A27HIi+5IoANjdcfS02RRKwMWJFtlqp4W3vWh6b6/2/eJ/uJKWHPrw9VBb1nzuiYuY
	 ZusrL/t4fzcgwwH8F9PYFnnOe4S16oNTSf6jaGIfXwzpFxcfwhD6hIq1rjKV3vj84x
	 dvGcAHVpy7iiA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
Received: from kuk (unknown [172.20.188.200])
	by mx2.n90.eu (Postfix) with ESMTP id CF0FD1000E4CA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:29:31 +0000 (UTC)
User-agent: mu4e 1.10.4; emacs 30.0.50
From: Aleksander Trofimowicz <alex@n90.eu>
To: netdev@vger.kernel.org
Subject: [bug] failed to enable eswitch SRIOV in mlx5_device_enable_sriov()
Date: Mon, 10 Jul 2023 15:25:30 +0000
X-Mailer: boring 1.0
Message-ID: <875y6rrdik.fsf@n90.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I've noticed a regression in the mlx5_core driver: defining VFs via
/sys/bus/pci/devices/.../sriov_numvfs is no longer possible.

Upon a write call the following error is returned:


Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_cmd_out_err:803:(pid 1097): QUERY_HCA_CAP(0x100) op_mod(0x40) failed, status bad parameter(0x3), syndrome (0x5add95), err(-22)
Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_device_enable_sriov:82:(pid 1097): failed to enable eswitch SRIOV (-22)
Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_sriov_enable:168:(pid 1097): mlx5_device_enable_sriov failed : -22


which could be traced back to a second call to mlx5_vport_get_other_func_cap() in
mlx5_core_sriov_configure()->[...]->mlx5_esw_vport_enable()->[...]->mlx5_esw_vport_caps_get():


 7678.225594 |   21)   bash-1604    |               |      mlx5_esw_vport_enable [mlx5_core]() {
 7678.225594 |   21)   bash-1604    |               |        mlx5_eswitch_get_vport [mlx5_core]() {
 7678.225594 |   21)   bash-1604    |   0.300 us    |          __rcu_read_lock();
 7678.225595 |   21)   bash-1604    |   0.270 us    |          __rcu_read_unlock();
 7678.225595 |   21)   bash-1604    |   1.320 us    |        } /* mlx5_eswitch_get_vport [mlx5_core] */
 7678.225595 |   21)   bash-1604    |   0.260 us    |        mutex_lock();
 7678.225596 |   21)   bash-1604    |               |        esw_legacy_vport_acl_setup [mlx5_core]() {
 7678.225596 |   21)   bash-1604    |               |          esw_acl_ingress_lgcy_setup [mlx5_core]() {
 7678.225597 |   21)   bash-1604    |   0.290 us    |            esw_acl_ingress_allow_rule_destroy [mlx5_core]();
 7678.225597 |   21)   bash-1604    |   0.290 us    |            esw_acl_ingress_lgcy_cleanup [mlx5_core]();
 7678.225598 |   21)   bash-1604    |   1.720 us    |          } /* esw_acl_ingress_lgcy_setup [mlx5_core] */
 7678.225598 |   21)   bash-1604    |               |          esw_acl_egress_lgcy_setup [mlx5_core]() {
 7678.225599 |   21)   bash-1604    |               |            mlx5_fc_create [mlx5_core]() {
 7678.225599 |   21)   bash-1604    |               |              mlx5_fc_create_ex [mlx5_core]() {
 7678.225600 |   21)   bash-1604    |   0.760 us    |                kmalloc_trace();
 7678.225600 |   21)   bash-1604    | ! 500.430 us  |                mlx5_cmd_fc_alloc [mlx5_core]();
 7678.226101 |   21)   bash-1604    | ! 502.070 us  |              } /* mlx5_fc_create_ex [mlx5_core] */
 7678.226101 |   21)   bash-1604    | ! 502.650 us  |            } /* mlx5_fc_create [mlx5_core] */
 7678.226102 |   21)   bash-1604    |   0.410 us    |            esw_acl_egress_vlan_destroy [mlx5_core]();
 7678.226102 |   21)   bash-1604    |               |            esw_acl_egress_lgcy_cleanup [mlx5_core]() {
 7678.226103 |   21)   bash-1604    |               |              mlx5_fc_destroy [mlx5_core]() {
 7678.226103 |   21)   bash-1604    | ! 239.330 us  |                mlx5_fc_release [mlx5_core]();
 7678.226343 |   21)   bash-1604    | ! 240.080 us  |              } /* mlx5_fc_destroy [mlx5_core] */
 7678.226343 |   21)   bash-1604    | ! 240.680 us  |            } /* esw_acl_egress_lgcy_cleanup [mlx5_core] */
 7678.226343 |   21)   bash-1604    | ! 745.110 us  |          } /* esw_acl_egress_lgcy_setup [mlx5_core] */
 7678.226344 |   21)   bash-1604    | ! 747.640 us  |        } /* esw_legacy_vport_acl_setup [mlx5_core] */
 7678.226344 |   21)   bash-1604    |               |        kmalloc_trace() {
 7678.226344 |   21)   bash-1604    |               |          __kmem_cache_alloc_node() {
 7678.226344 |   21)   bash-1604    |   0.250 us    |            should_failslab();
 7678.226345 |   21)   bash-1604    |   1.080 us    |          } /* __kmem_cache_alloc_node */
 7678.226345 |   21)   bash-1604    |   1.570 us    |        } /* kmalloc_trace */
 7678.226346 |   21)   bash-1604    |               |        mlx5_vport_get_other_func_cap [mlx5_core]() {
 7678.226346 |   21)   bash-1604    |               |          mlx5_cmd_exec [mlx5_core]() {
 7678.226346 |   21)   bash-1604    |               |            mlx5_cmd_do [mlx5_core]() {
 7678.226346 |   21)   bash-1604    |               |              cmd_exec [mlx5_core]() {
 7678.226347 |   21)   bash-1604    |   0.750 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
 7678.226348 |   21)   bash-1604    |   0.250 us    |                _raw_spin_lock();
 7678.226348 |   21)   bash-1604    |   0.260 us    |                _raw_spin_unlock();
 7678.226349 |   21)   bash-1604    |   7.290 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
 7678.226356 |   21)   bash-1604    |   0.560 us    |                kmalloc_trace();
 7678.226357 |   21)   bash-1604    |   0.260 us    |                __init_swait_queue_head();
 7678.226358 |   21)   bash-1604    |   0.250 us    |                __init_swait_queue_head();
 7678.226358 |   21)   bash-1604    |   0.250 us    |                init_timer_key();
 7678.226359 |   21)   bash-1604    |   4.160 us    |                queue_work_on();
 7678.226363 |   21)   bash-1604    |   0.260 us    |                _mlx5_tout_ms [mlx5_core]();
 7678.226363 |   21)   bash-1604    |   0.250 us    |                __msecs_to_jiffies();
 7678.226364 |   21)   bash-1604    | + 36.880 us   |                wait_for_completion_timeout();
 7678.226401 |   21)   bash-1604    | # 1772.890 us |                wait_for_completion_timeout();
 7678.228175 |   21)   bash-1604    |   0.440 us    |                _raw_spin_lock_irq();
 7678.228175 |   21)   bash-1604    |   0.330 us    |                _raw_spin_unlock_irq();
 7678.228176 |   21)   bash-1604    |   1.290 us    |                cmd_ent_put [mlx5_core]();
 7678.228177 |   21)   bash-1604    |   3.020 us    |                mlx5_copy_from_msg [mlx5_core]();
 7678.228181 |   21)   bash-1604    |   0.530 us    |                dma_pool_free();
 7678.228182 |   21)   bash-1604    |   0.380 us    |                kfree();
 7678.228182 |   21)   bash-1604    |   0.720 us    |                dma_pool_free();
 7678.228183 |   21)   bash-1604    |   0.360 us    |                kfree();
 7678.228184 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228185 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228186 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228186 |   21)   bash-1604    |   0.360 us    |                kfree();
 7678.228187 |   21)   bash-1604    |   0.480 us    |                dma_pool_free();
 7678.228188 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228188 |   21)   bash-1604    |   1.030 us    |                dma_pool_free();
 7678.228190 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228190 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228191 |   21)   bash-1604    |   0.360 us    |                kfree();
 7678.228192 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228193 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228193 |   21)   bash-1604    |   0.360 us    |                kfree();
 7678.228194 |   21)   bash-1604    |   0.710 us    |                free_msg [mlx5_core]();
 7678.228195 |   21)   bash-1604    | # 1848.590 us |              } /* cmd_exec [mlx5_core] */
 7678.228195 |   21)   bash-1604    |               |              cmd_status_err [mlx5_core]() {
 7678.228196 |   21)   bash-1604    |   0.950 us    |                mlx5_command_str [mlx5_core]();
 7678.228197 |   21)   bash-1604    |   1.780 us    |              } /* cmd_status_err [mlx5_core] */
 7678.228197 |   21)   bash-1604    | # 1851.180 us |            } /* mlx5_cmd_do [mlx5_core] */
 7678.228198 |   21)   bash-1604    |   0.260 us    |            mlx5_cmd_check [mlx5_core]();
 7678.228198 |   21)   bash-1604    | # 1852.150 us |          } /* mlx5_cmd_exec [mlx5_core] */
 7678.228198 |   21)   bash-1604    | # 1852.620 us |        } /* mlx5_vport_get_other_func_cap [mlx5_core] */
 7678.228199 |   21)   bash-1604    |               |        mlx5_vport_get_other_func_cap [mlx5_core]() {
 7678.228199 |   21)   bash-1604    |               |          mlx5_cmd_exec [mlx5_core]() {
 7678.228199 |   21)   bash-1604    |               |            mlx5_cmd_do [mlx5_core]() {
 7678.228199 |   21)   bash-1604    |               |              cmd_exec [mlx5_core]() {
 7678.228200 |   21)   bash-1604    |   0.710 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
 7678.228201 |   21)   bash-1604    |   0.270 us    |                _raw_spin_lock();
 7678.228201 |   21)   bash-1604    |   0.260 us    |                _raw_spin_unlock();
 7678.228202 |   21)   bash-1604    |   7.160 us    |                mlx5_alloc_cmd_msg [mlx5_core]();
 7678.228209 |   21)   bash-1604    |   0.570 us    |                kmalloc_trace();
 7678.228210 |   21)   bash-1604    |   0.260 us    |                __init_swait_queue_head();
 7678.228210 |   21)   bash-1604    |   0.250 us    |                __init_swait_queue_head();
 7678.228211 |   21)   bash-1604    |   0.290 us    |                init_timer_key();
 7678.228212 |   21)   bash-1604    |   4.280 us    |                queue_work_on();
 7678.228216 |   21)   bash-1604    |   0.340 us    |                _mlx5_tout_ms [mlx5_core]();
 7678.228217 |   21)   bash-1604    |   0.260 us    |                __msecs_to_jiffies();
 7678.228217 |   21)   bash-1604    | + 37.490 us   |                wait_for_completion_timeout();
 7678.228255 |   21)   bash-1604    | ! 316.610 us  |                wait_for_completion_timeout();
 7678.228572 |   21)   bash-1604    |   0.280 us    |                _raw_spin_lock_irq();
 7678.228573 |   21)   bash-1604    |   0.250 us    |                _raw_spin_unlock_irq();
 7678.228573 |   21)   bash-1604    |   1.280 us    |                cmd_ent_put [mlx5_core]();
 7678.228575 |   21)   bash-1604    |   2.840 us    |                mlx5_copy_from_msg [mlx5_core]();
 7678.228578 |   21)   bash-1604    |   0.510 us    |                dma_pool_free();
 7678.228579 |   21)   bash-1604    |   0.380 us    |                kfree();
 7678.228580 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228580 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228581 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228581 |   21)   bash-1604    |   0.380 us    |                kfree();
 7678.228582 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228583 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228584 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228584 |   21)   bash-1604    |   0.410 us    |                kfree();
 7678.228585 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228586 |   21)   bash-1604    |   0.380 us    |                kfree();
 7678.228587 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228587 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228588 |   21)   bash-1604    |   0.490 us    |                dma_pool_free();
 7678.228589 |   21)   bash-1604    |   0.370 us    |                kfree();
 7678.228589 |   21)   bash-1604    |   0.380 us    |                kfree();
 7678.228590 |   21)   bash-1604    |   0.640 us    |                free_msg [mlx5_core]();
 7678.228591 |   21)   bash-1604    | ! 391.590 us  |              } /* cmd_exec [mlx5_core] */
 7678.228591 |   21)   bash-1604    |               |              cmd_status_err [mlx5_core]() {
 7678.228592 |   21)   bash-1604    |   0.270 us    |                mlx5_command_str [mlx5_core]();
 7678.228592 |   21)   bash-1604    |   0.450 us    |                _raw_spin_lock_irq();
 7678.228593 |   21)   bash-1604    |   0.310 us    |                _raw_spin_unlock_irq();
 7678.228593 |   21)   bash-1604    |   2.030 us    |              } /* cmd_status_err [mlx5_core] */
 7678.228593 |   21)   bash-1604    | ! 394.300 us  |            } /* mlx5_cmd_do [mlx5_core] */
 7678.228594 |   21)   bash-1604    |               |            mlx5_cmd_check [mlx5_core]() {
 7678.228594 |   21)   bash-1604    |               |              mlx5_cmd_out_err [mlx5_core]() {
 7678.228595 |   21)   bash-1604    |   0.260 us    |                _raw_spin_trylock();
 7678.228595 |   21)   bash-1604    |   0.280 us    |                _raw_spin_unlock_irqrestore();
 7678.228596 |   21)   bash-1604    |   0.260 us    |                mlx5_command_str [mlx5_core]();
 7678.228596 |   21)   bash-1604    | ! 158.330 us  |                _dev_err();
 7678.228755 |   21)   bash-1604    | ! 160.760 us  |              } /* mlx5_cmd_out_err [mlx5_core] */
 7678.228755 |   21)   bash-1604    | ! 161.340 us  |            } /* mlx5_cmd_check [mlx5_core] */
 7678.228755 |   21)   bash-1604    | ! 556.330 us  |          } /* mlx5_cmd_exec [mlx5_core] */
 7678.228755 |   21)   bash-1604    | ! 556.810 us  |        } /* mlx5_vport_get_other_func_cap [mlx5_core] */
 7678.228756 |   21)   bash-1604    |               |        kfree() {
 7678.228756 |   21)   bash-1604    |   0.350 us    |          __kmem_cache_free();
 7678.228757 |   21)   bash-1604    |   0.860 us    |        } /* kfree */
 7678.228757 |   21)   bash-1604    |               |        esw_legacy_vport_acl_cleanup [mlx5_core]() {
 7678.228757 |   21)   bash-1604    |   0.310 us    |          esw_acl_egress_lgcy_cleanup [mlx5_core]();
 7678.228758 |   21)   bash-1604    |   0.350 us    |          esw_acl_ingress_lgcy_cleanup [mlx5_core]();
 7678.228758 |   21)   bash-1604    |   1.370 us    |        } /* esw_legacy_vport_acl_cleanup [mlx5_core] */
 7678.228758 |   21)   bash-1604    |   0.250 us    |        mutex_unlock();
 7678.228759 |   21)   bash-1604    | # 3165.340 us |      } /* mlx5_esw_vport_enable [mlx5_core] */


This second call was introduced in [0].

Device in use: MCX416A-CCAT.

[0] https://lore.kernel.org/netdev/20221206185119.380138-9-shayd@nvidia.com/
--
Kind regards,
Aleksander Trofimowicz

