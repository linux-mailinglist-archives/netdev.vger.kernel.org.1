Return-Path: <netdev+bounces-22524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB56767E71
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A9D282497
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A258B14272;
	Sat, 29 Jul 2023 11:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D48210B
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4833C433C8;
	Sat, 29 Jul 2023 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690628862;
	bh=XFPsoApbITff+ah69P91loWYngnR4L+QvZBYUA6T7PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hURT3ZJmTVlc3jtqKmW8N+ECl58CT4W3hl6NDn2ah/vakPW7Gym1dnPvu8zpeBy6T
	 8WzjbuFyHe1PEt8aFUls7kfEQCQrv+a+ITy/QrndtsWVoVW9t7PrVK1gfTHMhq9n8a
	 IYrhgjKWNwqNdH1F0yo2PazlAHcwp8BToy43YwhlBQPraHtfnVXOhTCQPbCa6mrfUF
	 e8UCC1538yky3vBVAUl2or+Ncl0oKIpM5oqY9TmEwE2Z8t5W1FWUgRbXW+tw0ITE/g
	 LEFKX2sr4CGTbLQ/ADYnE6RX0kwxgKihUDnt74j+y4lcD7Cl73NjWkTstg56gpe8Fv
	 RWtrduuWvE4Wg==
Date: Sat, 29 Jul 2023 13:07:38 +0200
From: Simon Horman <horms@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	David Miller <davem@davemloft.net>,
	Sudarsana Kalluru <skalluru@marvell.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 1/1] qed: Fix scheduling in a tasklet while getting
 stats
Message-ID: <ZMTy+lpSimgR66jh@kernel.org>
References: <ZMJcDvPrz1pEBPft@corigine.com>
 <20230727152609.1633966-1-khorenko@virtuozzo.com>
 <20230727152609.1633966-2-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727152609.1633966-2-khorenko@virtuozzo.com>

On Thu, Jul 27, 2023 at 06:26:09PM +0300, Konstantin Khorenko wrote:
> Here we've got to a situation when tasklet called usleep_range() in PTT
> acquire logic, thus welcome to the "scheduling while atomic" BUG().
> 
>   BUG: scheduling while atomic: swapper/24/0/0x00000100
> 
>    [<ffffffffb41c6199>] schedule+0x29/0x70
>    [<ffffffffb41c5512>] schedule_hrtimeout_range_clock+0xb2/0x150
>    [<ffffffffb41c55c3>] schedule_hrtimeout_range+0x13/0x20
>    [<ffffffffb41c3bcf>] usleep_range+0x4f/0x70
>    [<ffffffffc08d3e58>] qed_ptt_acquire+0x38/0x100 [qed]
>    [<ffffffffc08eac48>] _qed_get_vport_stats+0x458/0x580 [qed]
>    [<ffffffffc08ead8c>] qed_get_vport_stats+0x1c/0xd0 [qed]
>    [<ffffffffc08dffd3>] qed_get_protocol_stats+0x93/0x100 [qed]
>                         qed_mcp_send_protocol_stats
>             case MFW_DRV_MSG_GET_LAN_STATS:
>             case MFW_DRV_MSG_GET_FCOE_STATS:
>             case MFW_DRV_MSG_GET_ISCSI_STATS:
>             case MFW_DRV_MSG_GET_RDMA_STATS:
>    [<ffffffffc08e36d8>] qed_mcp_handle_events+0x2d8/0x890 [qed]
>                         qed_int_assertion
>                         qed_int_attentions
>    [<ffffffffc08d9490>] qed_int_sp_dpc+0xa50/0xdc0 [qed]
>    [<ffffffffb3aa7623>] tasklet_action+0x83/0x140
>    [<ffffffffb41d9125>] __do_softirq+0x125/0x2bb
>    [<ffffffffb41d560c>] call_softirq+0x1c/0x30
>    [<ffffffffb3a30645>] do_softirq+0x65/0xa0
>    [<ffffffffb3aa78d5>] irq_exit+0x105/0x110
>    [<ffffffffb41d8996>] do_IRQ+0x56/0xf0
> 
> Fix this by making caller to provide the context whether it could be in
> atomic context flow or not when getting stats from QED driver.
> QED driver based on the context provided decide to schedule out or not
> when acquiring the PTT BAR window.
> 
> We faced the BUG_ON() while getting vport stats, but according to the
> code same issue could happen for fcoe and iscsi statistics as well, so
> fixing them too.
> 
> Fixes: 6c75424612a7 ("qed: Add support for NCSI statistics.")
> Fixes: 1e128c81290a ("qed: Add support for hardware offloaded FCoE.")
> Fixes: 2f2b2614e893 ("qed: Provide iSCSI statistics to management")
> Cc: Sudarsana Kalluru <skalluru@marvell.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Manish Chopra <manishc@marvell.com>
> 

nit: no blank line here.

> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Reviewed-by: Simon Horman <horms@kernel.org>

