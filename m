Return-Path: <netdev+bounces-16595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC5274DF33
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C481C20B9F
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2948154B0;
	Mon, 10 Jul 2023 20:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6C14A9B
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:28:14 +0000 (UTC)
Received: from mx2.n90.eu (mx.n90.eu [65.21.251.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F513E
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:28:12 -0700 (PDT)
Received: by mx2.n90.eu (Postfix, from userid 182)
	id 2EC081000E4CE; Mon, 10 Jul 2023 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n90.eu; s=default;
	t=1689020879; bh=zWNoJjF1BDBexScrwPnN++PNX+oiTRWa7GVE3/ElKuI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to;
	b=gnP5XdOMNYzrTiXetHtrqClkwP6geBEOrX+ZpC2NxktjwKsiGM1TyRCpPqbhpX2VF
	 bLYfXk9V64QTLOkqrTjK6IptjmXvBWVlOicAa9hMq2HC91ZwA497nCrzUBLoCHet8w
	 seRb2P//qGQ0tlpCJHGWZTGfKIzyFmZBq6+8pLaYG4+pL3dYJ1VKcDWp77KhU0WLqU
	 JFjIEBP2AuyOM6eaWhrE3OGTApeXRH8uxRB5hjdUAZcelEml3Ql2aIuLSgyJQAKkpF
	 K1r7LxfwgGSCyxAtZqQleDICMmpSEXr6/OjhREwI9TDBFSLphlDaiSZflH8PQnOc7/
	 w2fFkpeIDR6Aw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
Received: from spica (unknown [172.20.188.202])
	by mx2.n90.eu (Postfix) with ESMTP id 920B01000E4CB;
	Mon, 10 Jul 2023 20:27:58 +0000 (UTC)
References: <875y6rrdik.fsf@n90.eu>
 <9c25971b-78e9-956f-95a5-38e688240ef6@nvidia.com>
User-agent: mu4e 1.10.4; emacs 30.0.50
From: Aleksander Trofimowicz <alex@n90.eu>
To: Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: Re: [bug] failed to enable eswitch SRIOV in mlx5_device_enable_sriov()
Date: Mon, 10 Jul 2023 20:10:12 +0000
In-reply-to: <9c25971b-78e9-956f-95a5-38e688240ef6@nvidia.com>
X-Mailer: boring 1.0
Message-ID: <87ilarpl4p.fsf@n90.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mark,

Mark Bloch <mbloch@nvidia.com> writes:

> On 10/07/2023 18:25, Aleksander Trofimowicz wrote:
>>
>> I've noticed a regression in the mlx5_core driver: defining VFs via
>> /sys/bus/pci/devices/.../sriov_numvfs is no longer possible.
>>
>> Upon a write call the following error is returned:
>>
>>
>> Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_cmd_out_err:803:(pid 1097): QUERY_HCA_CAP(0x100) op_mod(0x40) failed, status bad parameter(0x3), syndrome (0x5add95), err(-22)
>> Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_device_enable_sriov:82:(pid 1097): failed to enable eswitch SRIOV (-22)
>> Jul 10 11:07:44 server kernel: mlx5_core 0000:c1:00.0: mlx5_sriov_enable:168:(pid 1097): mlx5_device_enable_sriov failed : -22
>>
>
> This should fix the issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c?id=6496357aa5f710eec96f91345b9da1b37c3231f6
>
Indeed, it should. Thanks for pointing the fix out.

--
Kind regards,
Aleksander Trofimowicz

