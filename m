Return-Path: <netdev+bounces-129345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8497EF5E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9F51C20B78
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950519E974;
	Mon, 23 Sep 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWWpgdA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CED19D063;
	Mon, 23 Sep 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109574; cv=none; b=Tg3fYtGTJWP+9x7fXYErTYeVEwhMJfCPYJl8Xv+NdWEiBl5aLf6+ULP6qESwUQa2x6bsRwRcYBVOZmMJmYhRCH2TvYEjxhodjFnmV/otKaeHdwvhKqR1ncLXgBhD0wex8KkF2pwr+ImKXVuNrQQY9SvO+wymWC5mGtLNiy8N0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109574; c=relaxed/simple;
	bh=BtWWh5uKfJUmSyiqbRGzOA9W9l+8x+M2nfsETg8eh+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dln/3Onb7E0hfdZgdNj4sqrN7pqDCBtaKAURqlCiAAq/6gutn44D5vt68Ti154WeWkZncYuciEbFDjto0AnZmDERy/7N7xg34x4hVkTlj3bl76SPV/sqsx/6Ib7f25b9AtCv2jRAyzu+v1dB6WgYAcyStIbEYBKzBifM7y5PW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWWpgdA0; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-500fcf0b32fso1029464e0c.1;
        Mon, 23 Sep 2024 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727109570; x=1727714370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/FTITcrdxHCLcbS1+Ae4moEr/IuUBgyh4KWOkQoZo4g=;
        b=aWWpgdA0Q75WSkp5qTGQCl7DpM9HLVsgqWFke5n2uVoxg1Z0Fqz9UaNoPnwPeX4a04
         kRl/BP5OCDOa38gYp2EJsVc2PYZPqjSmsUl/5VhlHIlAtp+VEr2I2tWfKmTZ4ScKFQyx
         Elkew+BP6bgwArSCp4M0EZxoijJDHpJcPaF938LhuxeqsL+2t4iAZRwz5Yanqn3/xz/n
         bDMXp0lBeIfB3q5YDVF59gu6XJtfS0FVqB0CQkEH1sU6Bs8DNPpJrEuE9kqIrjHly3YD
         GBBtDcWEagbojORGELdUBxSLxUhZtkUvJqJNYyLvFss4QfORg0Fe2+D/naaGD042/7yI
         JgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109570; x=1727714370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FTITcrdxHCLcbS1+Ae4moEr/IuUBgyh4KWOkQoZo4g=;
        b=qhnxdnsDzeaiIHjNS+JuVQLEts+gIAzO3k6y8cCaH8Qwp8bwLdiKJ70ih5ie2QeshT
         tPXqgsHHZx/ptMJznRpSNYg4ea1AkOSmohKBgkAoQT1hCG7LaONSrpneHSTcAICDRS2B
         jkYfS35A5oiZuZ1DMR4sj7i4C09oauNqYj1z+oRD4ysi7x57nxBTkpKjWIvPDIytZ2IJ
         EnPCSSKoR960agfTUIv7KBSQL7S4a/OnBN2PnvZe42rRIBsSEMGfuQIKnHj6aqY7v/jc
         z1tAhtKy//VJuhMpF3rcsTA2IJ5a3r1UTYXKYQD+UH1O1NvTArkOkdggSglsnirY/RCm
         uKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIFtgwsAnzosceCxPrp83KscNaPc8MZqXPv+B8DlQ4LF2Fcge/JAGyEh8wMN/XGIcuzkiDo6pa+W7zunE=@vger.kernel.org, AJvYcCWKzRpqn2LOAqnmXOL4rakeYz0CClYgCX3r229au7BDa5wWhuN7O1N8TDt1D0zxJOKCjh77Gqs3@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8EtEjg7RQtx6u2CrGpDOclAoAnJdtW3ev47b9f51iKhCUpNe
	9J5/LSkxTz+5WE7ixJ6uWbR7xDDqw3XJUEfZBAUuQYz0vjy+3vNi9sJL/FFkWpidt/yxjxc3s/C
	3yxPcTr2BSOM1qBI7wfABcdxc4YOKoFb8
X-Google-Smtp-Source: AGHT+IElx0s9IV3YPyUgWmF6Ksl4pU39a6ROGQqn5NUxh7Z3Ne28ZUwbLafd4PaCUqIBb3wvxHDY0/TbyqHvxs9hG1Y=
X-Received: by 2002:a05:6122:3197:b0:4fe:bce9:8f4f with SMTP id
 71dfb90a1353d-503e41a8025mr6812497e0c.9.1727109569634; Mon, 23 Sep 2024
 09:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923053900.1310-1-kdipendra88@gmail.com> <20240923161942.GK3426578@kernel.org>
In-Reply-To: <20240923161942.GK3426578@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 22:24:18 +0545
Message-ID: <CAEKBCKPkJ7DSku0w1injh55yd2HJdK0S3KPqWM_dUPQBAQD3pw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, florian.fainelli@broadcom.com, davem@davemloft.net, 
	edumazet@google.com, bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Mon, 23 Sept 2024 at 22:04, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Sep 23, 2024 at 05:38:58AM +0000, Dipendra Khadka wrote:
> > Add error pointer checks in bcm_sysport_map_queues() and
> > bcm_sysport_unmap_queues() before deferencing 'dp'.
>
> nit: dereferencing
>
>      Flagged by checkpatch.pl --codespell
>
> >
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>
> This patch does not compile.
> Please take care to make sure your paches compile.
>
> And, moroever, please slow down a bit.  Please take some time to learn the
> process by getting one patch accepted. Rather going through that process
> with several patches simultaneously.
>
> > ---
> > v2:
> >   - Change the subject of the patch to net
>
> I'm sorry to say that the subject is still not correct.
>
> Looking over the git history for this file, I would go for
> a prefix of 'net: systemport: '. I would also pass on mentioning
> the filename in the subject. Maybe:
>
>         Subject: [PATCH v3 net] net: systemport: correct error pointer handling
>
> Also, I think that it would be better, although more verbose,
> to update these functions so that the assignment of dp occurs
> just before it is checked.
>
> In the case of bcm_sysport_map_queues(), that would look something like this
> (completely untested!):
>
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index c9faa8540859..7411f69a8806 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2331,11 +2331,15 @@ static const struct net_device_ops bcm_sysport_netdev_ops = {
>  static int bcm_sysport_map_queues(struct net_device *dev,
>                                   struct net_device *slave_dev)
>  {
> -       struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
>         struct bcm_sysport_priv *priv = netdev_priv(dev);
>         struct bcm_sysport_tx_ring *ring;
>         unsigned int num_tx_queues;
>         unsigned int q, qp, port;
> +       struct dsa_port *dp;
> +
> +       dp = dsa_port_from_netdev(slave_dev);
> +       if (IS_ERR(dp))
> +               return PTR_ERR(dp);
>
>
>         /* We can't be setting up queue inspection for non directly attached
>          * switches
>
>
> This patch is now targeted at 'net'. Which means that you believe
> it is a bug fix. I'd say that is reasonable, though it does seem to
> be somewhat theoretical. But in any case, a bug fix should
> have a Fixes tag, which describes the commit that added the bug.
>
> Alternatively, if it is not a bug fix, then it should be targeted at
> net-next (and not have a Fixes tag). Please note that net-next is currently
> closed for the v6.12 merge window. It shold re-open after v6.12-rc1 has
> been released, which I expect to occur about a week for now. You should
> wait for net-next to re-open before posting non-RFC patches for it.
>
> Lastly, when reposting patches, please note the 24h rule.
> https://docs.kernel.org/process/maintainer-netdev.html
>

Thank you so much for the response and the suggestions. I will follow
everything you have said and whatever I have to.
I was just hurrying to see my patch accepted.

> --
> pw-bot: changes-requested
>
>

Best Regards,
Dipendra Khadka

