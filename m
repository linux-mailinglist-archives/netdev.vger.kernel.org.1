Return-Path: <netdev+bounces-71971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4ED855C3B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 09:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29041F22D8C
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4401400F;
	Thu, 15 Feb 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5BJPRIs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF013FEA
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985118; cv=none; b=HZj2pfAuuLTvufXpnAywqnyHYqXb8Gkb6P4MwYo63IYcJhTjEEgMaJt4sZpqC2/yfpaLlGvXvwfuvgaxBPr/Hfltr5XEtGuHLw+GQOUPuOoTa+VQzfOXCJPsLcPKUWiwgS3biMh1zSTOPem79L173MXSKMJt/Sh2kH6pGN2AnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985118; c=relaxed/simple;
	bh=JZ4MSA4nJaIwap8ouDMw5DfwuHN2Zukl7Ca7ndtp4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwQTf70BOf7oLipRYfxi3du/lx/VrfJv9mXWg1aFQ/ISfFASrWKvecUbQ0l65pdOaS67lcadoJT39heAKE5ogJqYPt/uI2k+wOlM8TMzOz8nUBv0Z8Vj1zmaRsyT9FygXS0t+YYRET6rNtj9sxi9PxyhmMMZQ7Cyj7+0jYUTru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5BJPRIs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707985117; x=1739521117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JZ4MSA4nJaIwap8ouDMw5DfwuHN2Zukl7Ca7ndtp4ms=;
  b=k5BJPRIsiouSJ/jIn7UGHgNF3tlfvtwVXm922drFE9JvU9nIhsCr0+u3
   7cyAJoNFTGnLcK1a5LgBfa8G6MvXg3nTrQzkay0YOGkTlY+m+qhHZqa1+
   Db28i7DMrcQVF5aYKWKhJC6YNuEDOAZVWL7dGcdD9QygTWW9Tuh346qHE
   ozqStXFutMh6L9ti2L+nXYSkAV11CV18VBUma0hhGWf3E9rmTK3B8uwal
   EMBwPAXl3SzKaSWyRB87Zer+At1cvQc5QmzHm3/lzv5ndWrVRWqnHJF/p
   U1LRvPoudmdIZ6fGmRxthKrUMT9aeH9U2ijtMerQ5kRsOIxWfYVhKmRS1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1970897"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1970897"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 00:18:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="26625405"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 00:18:33 -0800
Date: Thu, 15 Feb 2024 09:18:25 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: Re: [PATCH net v2 2/2] net/sched: act_mirred: don't override retval
 if we already lost the skb
Message-ID: <Zc3I0YmE4vYrkvYz@mev-dev>
References: <20240214033848.981211-1-kuba@kernel.org>
 <20240214033848.981211-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240214033848.981211-2-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:38:48PM -0800, Jakub Kicinski wrote:
> If we're redirecting the skb, and haven't called tcf_mirred_forward(),
> yet, we need to tell the core to drop the skb by setting the retcode
> to SHOT. If we have called tcf_mirred_forward(), however, the skb
> is out of our hands and returning SHOT will lead to UaF.
>=20
Thanks for fixing it. I had this UaF after ingress to ingress
redirection (was wondering if it is reasonable filter configuration).

[ 1459.177197] refcount_t: underflow; use-after-free.
[ 1459.177219] WARNING: CPU: 32 PID: 2427 at lib/refcount.c:28 refcount_war=
n_saturate+0xba/0x110
[ 1459.177227] Modules linked in: act_mirred cls_flower sch_ingress veth ir=
dma ice(E) nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet n=
f_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conn=
track nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink ipmi_ssif in=
tel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequenc=
y_common i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp co=
retemp kvm_intel mlx5_ib i40e kvm vfat fat ib_uverbs dell_wmi irqbypass led=
trig_audio rapl sparse_keymap acpi_ipmi iTCO_wdt rfkill intel_cstate intel_=
pmc_bxt video ipmi_si dell_smbios mei_me iTCO_vendor_support ib_core intel_=
uncore dcdbas joydev dell_wmi_descriptor wmi_bmof dax_hmem isst_if_mmio pcs=
pkr isst_if_mbox_pci ipmi_devintf mei i2c_i801 isst_if_common intel_pch_the=
rmal i2c_smbus ipmi_msghandler acpi_power_meter intel_vsec fuse zram mlx5_c=
ore crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_gene=
ric ghash_clmulni_intel mlxfw sha512_ssse3 bnxt_en tls
[ 1459.177300]  mgag200 sha256_ssse3 megaraid_sas tg3
[ 1459.177302] dev_queue_xmit: bootnet
[ 1459.177304]  sha1_ssse3 psample gnss pci_hyperv_intf
[ 1459.177309] sch_handle_egress on: bootnet
[ 1459.177312]  i2c_algo_bit wmi [last unloaded: ice]
[ 1459.177318] CPU: 32 PID: 2427 Comm: scapy Kdump: loaded Tainted: G      =
      E      6.8.0-rc2+ #3
[ 1459.177321] Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.12.1 =
09/13/2023
[ 1459.177322] RIP: 0010:refcount_warn_saturate+0xba/0x110
[ 1459.177326] Code: 01 01 e8 19 1f 92 ff 0f 0b c3 cc cc cc cc 80 3d fd 12 =
cf 01 00 75 85 48 c7 c7 70 de 93 89 c6 05 ed 12 cf 01 01 e8 f6 1e 92 ff <0f=
> 0b c3 cc cc cc cc 80 3d d8 12 cf 01 00 0f 85 5e ff ff ff 48 c7
[ 1459.177328] RSP: 0018:ff5e8ab706db4df0 EFLAGS: 00010282
[ 1459.177331] RAX: 0000000000000026 RBX: ff4f7131460b1000 RCX: 00000000000=
00000
[ 1459.177332] RDX: 0000000000000103 RSI: ffffffff89924668 RDI: 00000000fff=
fffff
[ 1459.177334] RBP: ff4f7138e904c000 R08: 0000000000000000 R09: ff5e8ab706d=
b4c90
[ 1459.177335] R10: 0000000000000003 R11: ff4f7140bfd49b28 R12: 00000000000=
00000
[ 1459.177336] R13: ff4f7138e904c120 R14: 0000000000000002 R15: 00000000000=
00000
[ 1459.177337] FS:  00007f69ec975b80(0000) GS:ff4f7138a0200000(0000) knlGS:=
0000000000000000
[ 1459.177339] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1459.177340] CR2: 00007f6861c9d030 CR3: 0000000157fd0004 CR4: 00000000007=
71ef0
[ 1459.177342] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1459.177343] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1459.177344] PKRU: 55555554
[ 1459.177345] Call Trace:
[ 1459.177347]  <IRQ>
[ 1459.177348]  ? refcount_warn_saturate+0xba/0x110
[ 1459.177351]  ? __warn+0x7d/0x130
[ 1459.177358]  ? refcount_warn_saturate+0xba/0x110
[ 1459.177360]  ? report_bug+0x18d/0x1c0
[ 1459.177366]  ? prb_read_valid+0x17/0x20
[ 1459.177373]  ? handle_bug+0x41/0x70
[ 1459.177378]  ? exc_invalid_op+0x13/0x60
[ 1459.177382]  ? asm_exc_invalid_op+0x16/0x20
[ 1459.177388]  ? refcount_warn_saturate+0xba/0x110
[ 1459.177390]  skb_release_head_state+0x7d/0x90
[ 1459.177398]  kfree_skb_reason+0x35/0x110
[ 1459.177400]  __netif_receive_skb_core.constprop.0+0x971/0x1000
[ 1459.177406]  ? __blk_mq_free_request+0x70/0x100
[ 1459.177410]  ? blk_queue_exit+0xe/0x40
[ 1459.177416]  ? scsi_end_request+0xfb/0x1b0
[ 1459.177422]  __netif_receive_skb_one_core+0x2c/0x80
[ 1459.177424]  process_backlog+0x81/0x120
[ 1459.177427]  __napi_poll+0x28/0x1c0
[ 1459.177430]  net_rx_action+0x283/0x360
[ 1459.177432]  ? sched_clock+0xc/0x30
[ 1459.177438]  __do_softirq+0xf2/0x316
[ 1459.177443]  ? irqtime_account_irq+0xa4/0xd0
[ 1459.177448]  do_softirq.part.0+0x72/0x90
[ 1459.177452]  </IRQ>

After applying the patch it is fine.

> Move the retval override to the error path which actually need it.
>=20
> Fixes: e5cf1baf92cb ("act_mirred: use TC_ACT_REINSERT when possible")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> ---
>  net/sched/act_mirred.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

