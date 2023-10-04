Return-Path: <netdev+bounces-38065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697617B8DCB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1950E281771
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782C224D0;
	Wed,  4 Oct 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="haqQaiCb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5131B27F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:02:50 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B2DAD;
	Wed,  4 Oct 2023 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MEDpCLtA6saV273n9QbcI2SdIbI0BMgImtkzhlafRjs=; b=haqQaiCbgNfx9MLqPT6W8jhO7K
	JEVhl8TGbPhoNHqFMYUrjcD63PDSQ7/zJO48daapSPsR3Q6xIXyPnvOh8YJHtokW/xl0mzstSwvKt
	YTjl/M4/Hk5mT8JntCjGewR+Ggny35NWm15L8cGiT0HiIy/c2e9zIvyqtx/Tj3K7G10Pzbprb8vjx
	xzpLmF0K8jfh+ETxNPuME7H9XiK4+kZmAgZUCQtCT3i3lZMdk4ruZp4DbL1e93j2/JrAIpk5mYKNP
	kIwGBryenk63kLXf0pUHpd4TtRiwkk8zusr6mMYtPf1qIfTxY8DXTfcSwbo7qcPU0oFmOrxVLsQOX
	lzv3l5pg==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qo84m-00Fp66-0x;
	Wed, 04 Oct 2023 20:02:32 +0000
Date: Wed, 4 Oct 2023 13:02:29 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH 2/3] netconsole: Attach cmdline target to dynamic target
Message-ID: <ZR3E1TLE+BFuctsx@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
References: <20231002155349.2032826-1-leitao@debian.org>
 <20231002155349.2032826-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002155349.2032826-3-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 08:53:48AM -0700, Breno Leitao wrote:
> Enable the attachment of a dynamic target to the target created during
> boot time. The boot-time targets are named as "cmdline\d", where "\d" is
> a number starting at 0.
> 
> If the user creates a dynamic target named "cmdline0", it will attach to
> the first target created at boot time (as defined in the
> `netconsole=...` command line argument). `cmdline1` will attach to the
> second target and so forth.
> 
> If there is no netconsole target created at boot time, then, the target
> name could be reused.
> 
> Relevant design discussion:
> https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/
> 
> Suggested-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index b68456054a0c..6235f56dc652 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -685,6 +685,23 @@ static const struct config_item_type netconsole_target_type = {
>  	.ct_owner		= THIS_MODULE,
>  };
>  
> +static struct netconsole_target *find_cmdline_target(const char *name)
> +{
> +	struct netconsole_target *nt, *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	list_for_each_entry(nt, &target_list, list) {
> +		if (!strcmp(nt->item.ci_name, name)) {
> +			ret = nt;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&target_list_lock, flags);
> +
> +	return ret;
> +}
> +
>  /*
>   * Group operations and type for netconsole_subsys.
>   */
> @@ -695,6 +712,13 @@ static struct config_item *make_netconsole_target(struct config_group *group,
>  	struct netconsole_target *nt;
>  	unsigned long flags;
>  
> +	/* Checking if there is a target created populated at boot time */

Perhaps a little clearer:

```
       /* Checking if a target by this name was created at boot time.  If so,
          attach a configfs entry to that target.  This enables dynamic
          control. */
```

> +	if (!strncmp(name, DEFAULT_TARGET_NAME, strlen(DEFAULT_TARGET_NAME))) {
> +		nt = find_cmdline_target(name);
> +		if (nt)
> +			return &nt->item;
> +	}
> +

Thanks,
Joel

-- 

Life's Little Instruction Book #356

	"Be there when people need you."

			http://www.jlbec.org/
			jlbec@evilplan.org

