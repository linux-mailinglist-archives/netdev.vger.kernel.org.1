Return-Path: <netdev+bounces-214867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC80CB2B912
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C195821E6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F224887E;
	Tue, 19 Aug 2025 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cXhhhMiF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD71863E;
	Tue, 19 Aug 2025 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583537; cv=none; b=c609J+k8zX4Fny/5bXC/Wu3SUXLXH+lsp9U6MuXuGffuRpl4nVYrVMWasIMr7GgoHdQuNwtL9aY24o+CUwkWRILsNPsnVDYUNp0TBgiYdqFavvYFv5Mw3OR5sv6qH847ZUw4zJmDD3hUSw+Lg3CPT0UAcN4St3wnLL3TgtLt5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583537; c=relaxed/simple;
	bh=N3LS7WI2X5NWesZ4A5L63sw8/+kTcuheRn9ATmG66jM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTytOkmTSJcaS3tcmwebAF5qEon5l+rQPTeRCTCv9smfACHKY0CpJg+riO0ME3/KkB9OqHLyLSCuPSDoFq3eIszb3G7uq+xeE9u6mlHoZt1P5xk9DxDAFkb0fBZDw1zHF1OyhzWXSHT4EWaZyDHRIPjzO7WeYCtaI1PpA9UWyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cXhhhMiF; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INWaPb004812;
	Mon, 18 Aug 2025 23:05:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TB0qNR0SEwJRdxY8s9wEQYgP9
	m0pbeXDRFVyU84GPyM=; b=cXhhhMiFKQhwLTHhBhY9XXs6hHV7aEDm/cDK0l0Qw
	pLnMritCxNJRxaTjAdUSJxSRHJeTY4+OC5Lm7rheAuQSPxIAMDUe8bFcKXl92WRJ
	8GJmbNpPnnFeMp+rtnCGbuPWB8QoMXUmv5Kg6xDK/Q4fyXN/WcLsNwD1Q9Sg6Rw+
	iRs0z5WTEtjjWUTw7/EbbmAL0KcLIedYgvm0nnKbT61sH1s3la9ukEY0/S5G2/If
	PaYHOSm5C0IVs9DLUnYSo06SroG0RWyjWQcW6f1wXeaLkh8UIwV2qPABNwS4w4Bh
	hXIkLoaFu1HvQmHyagXdkEzQ+eVvCbqmcsNpN3k1oyWTQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48mdx0gm08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 23:05:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 18 Aug 2025 23:05:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 18 Aug 2025 23:05:22 -0700
Received: from opensource (unknown [10.29.8.22])
	by maili.marvell.com (Postfix) with SMTP id 4FB253F704F;
	Mon, 18 Aug 2025 23:05:13 -0700 (PDT)
Date: Tue, 19 Aug 2025 06:05:12 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Michal Schmidt <mschmidt@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel
	<przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesse Brandeburg
	<jesse.brandeburg@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] i40e: fix IRQ freeing in i40e_vsi_request_irq_msix
 error path
Message-ID: <aKNU1YnfNbXYhUyj@opensource>
References: <20250818153903.189079-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818153903.189079-1-mschmidt@redhat.com>
X-Proofpoint-GUID: l9xTP6HBH2e_0mEtNWTxDdxGK_zSUXWR
X-Proofpoint-ORIG-GUID: l9xTP6HBH2e_0mEtNWTxDdxGK_zSUXWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDA1NiBTYWx0ZWRfX3oVAofVUB1Wx jqiAW+/Me2Bdho8ExZdWk6o4s+QKkHdowTu7AlRtIsqDi4h/63XkGp+N1kK/faVlwTh/TZC3jHd duv2mEviLAOz2uh//3SolXuC1rgKhAJn+fak6c8HRbtI/y7k2TTPzimMv1DkcWKe409m/4VH4Bu
 XFqZ1MLNinyQJ5wqT0cW5PeHNe2R9agU9jphxzEL9f0iYDDvRe09aG3F5MYg7fZlnqqZ9oPJlPa T5iJNTGXUFdjTSXXpc02jGSdhsLvFI++F1geDi4/1Nh+ADLmknwU/JDTU07db5wkxiAkjIURfCW gc7+52NZ1gpDZmD+PkfyZfJJDjKZjPY/QhFdzyzs0urPPMmAs06NvtDFyHqIVi0tsUaU7/Z95ao
 cXz2bNrDB/CeLqG/O9+G+JgooinIK5L4eepe2uutBt8e1uU+09L7EWtMrfd8+QhT79F4wIsb
X-Authority-Analysis: v=2.4 cv=D4hHKuRj c=1 sm=1 tr=0 ts=68a4141e cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=I6fm6gUqSGKCge1PFHkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01

Hi Michal,

On 2025-08-18 at 15:39:03, Michal Schmidt (mschmidt@redhat.com) wrote:
> If request_irq() in i40e_vsi_request_irq_msix() fails in an iteration
> later than the first, the error path wants to free the IRQs requested
> so far. However, it uses the wrong dev_id argument for free_irq(), so
> it does not free the IRQs correctly and instead triggers the warning:
> 
>  Trying to free already-free IRQ 173
>  WARNING: CPU: 25 PID: 1091 at kernel/irq/manage.c:1829 __free_irq+0x192/0x2c0
>  Modules linked in: i40e(+) [...]
>  CPU: 25 UID: 0 PID: 1091 Comm: NetworkManager Not tainted 6.17.0-rc1+ #1 PREEMPT(lazy)
>  Hardware name: [...]
>  RIP: 0010:__free_irq+0x192/0x2c0
>  [...]
>  Call Trace:
>   <TASK>
>   free_irq+0x32/0x70
>   i40e_vsi_request_irq_msix.cold+0x63/0x8b [i40e]
>   i40e_vsi_request_irq+0x79/0x80 [i40e]
>   i40e_vsi_open+0x21f/0x2f0 [i40e]
>   i40e_open+0x63/0x130 [i40e]
>   __dev_open+0xfc/0x210
>   __dev_change_flags+0x1fc/0x240
>   netif_change_flags+0x27/0x70
>   do_setlink.isra.0+0x341/0xc70
>   rtnl_newlink+0x468/0x860
>   rtnetlink_rcv_msg+0x375/0x450
>   netlink_rcv_skb+0x5c/0x110
>   netlink_unicast+0x288/0x3c0
>   netlink_sendmsg+0x20d/0x430
>   ____sys_sendmsg+0x3a2/0x3d0
>   ___sys_sendmsg+0x99/0xe0
>   __sys_sendmsg+0x8a/0xf0
>   do_syscall_64+0x82/0x2c0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [...]
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
> 
> Use the same dev_id for free_irq() as for request_irq().
> 
> I tested this with inserting code to fail intentionally.
> 
Nice. Looks like changing this in i40e_vsi_request_irq_msix was missed
during 493fb30011b3. Just a question isn't this not throwing any
compilation warning all these days?
Anyway LGTM.

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> Fixes: 493fb30011b3 ("i40e: Move q_vectors from pointer to array to array of pointers")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index b83f823e4917..dd21d93d39dd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4156,7 +4156,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
>  		irq_num = pf->msix_entries[base + vector].vector;
>  		irq_set_affinity_notifier(irq_num, NULL);
>  		irq_update_affinity_hint(irq_num, NULL);
> -		free_irq(irq_num, &vsi->q_vectors[vector]);
> +		free_irq(irq_num, vsi->q_vectors[vector]);
>  	}
>  	return err;
>  }
> -- 
> 2.50.1
> 

