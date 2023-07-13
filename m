Return-Path: <netdev+bounces-17420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC1751855
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266251C2127E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477D566E;
	Thu, 13 Jul 2023 05:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897153B9
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:50:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAAC1BD5;
	Wed, 12 Jul 2023 22:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GFMF1ikSol53pF8uOEYCDZ1uK/JIIE1rXx1j7+aTy1Y=; b=x5xLgY8KePVopF6k6iKAFKM/QG
	P+4A2RB3luT+Ws8svb8REwmQaHeRbkoCjA9Af2WrJZb8mRuM/yjfryuJsmtFM69Y3IssVptJJTksC
	RG7x556xM0UQIkcBxlIIN4Zef6sOPTp7Q7twuECA1YqrVG/8ndJnKCf6zs2HF9dS78IC1uh+Xx4Oj
	t4AIjyGIugFrOD3fIoJWGFZZsKCWJuYJyxdguKPnI5u/yIuAme0Fo3ySGMVufMUWtgEHpKsatIIxP
	+L1qSalel55POdhvo+0+AVTAhscTS70DCmxARuO5QPwJaRhSPxGTKTjsvNOuWm2FuZ7Luup69oQ2A
	lQDDfFrg==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJpDS-0022Nf-05;
	Thu, 13 Jul 2023 05:50:14 +0000
Message-ID: <27105f25-f3f9-0856-86e5-86236ce83dee@infradead.org>
Date: Wed, 12 Jul 2023 22:50:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net v1] bna:Fix error checking for debugfs_create_dir()
Content-Language: en-US
To: Wang Ming <machel@vivo.com>, Rasesh Mody <rmody@marvell.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krishna Gudipati <kgudipat@brocade.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20230713053823.14898-1-machel@vivo.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230713053823.14898-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi--

On 7/12/23 22:38, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in bnad_debugfs_init() was forgotten.
> 
> Fix the remaining error check.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> 
> Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")

Comment from fs/debugfs/inode.c:

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

so no, drivers should not usually care about debugfs function call results.
Is there some special case here?

> ---
>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> index 04ad0f2b9677..678a3668a041 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> @@ -512,7 +512,7 @@ bnad_debugfs_init(struct bnad *bnad)
>  	if (!bnad->port_debugfs_root) {
>  		bnad->port_debugfs_root =
>  			debugfs_create_dir(name, bna_debugfs_root);
> -		if (!bnad->port_debugfs_root) {
> +		if (IS_ERR(bnad->port_debugfs_root)) {
>  			netdev_warn(bnad->netdev,
>  				    "debugfs root dir creation failed\n");
>  			return;

-- 
~Randy

