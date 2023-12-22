Return-Path: <netdev+bounces-59906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF381CA0B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 13:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD39D1F21E9B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751918056;
	Fri, 22 Dec 2023 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKehDq8P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913AA1DFD2
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so19304195e9.3
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703248227; x=1703853027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VShQOkDyOQUhX9HywN+ltueUtPe5q/n3T/gBT1xnywc=;
        b=eKehDq8PD0ZlYbmtQHi6BhlDIqNCmKJoP2bldS1VvB4COVDgK3Gvzb9JiUuHvjYOeb
         7vUWO4EsfnfAaWcyGGi6HvuAZMLarU/0hqiepGc0b5tTnLtxMYoO0flUFUQz0YyEZ93b
         QIGjlKBcxgntwdLKPYMKfq4yVONRz0MkW3S0Lf7izzJdR0XUgHVv8Gz5RVNdj362gPpo
         otm4REJLdYfpZ7xvD9+/iZ3PLOS8/OnXDN4iQQibdnDP+muXAEi9yr0xcHSPaKWrKd1d
         3rvzmbzCkP6/1HTyfOhXddmgdZF8K3Ji+EkFVpc1AKDT+iYgQv9p6Ui7EhKjN2p9Nzt/
         C8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703248227; x=1703853027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VShQOkDyOQUhX9HywN+ltueUtPe5q/n3T/gBT1xnywc=;
        b=ODDona/RKISMilzqpfS7pNupgc/idH5lwb5UgTHdlkva6pfweFsZw2PSwOOa/WAMzn
         dU04C8GHqvWj5EpZ3r3AM+91sw2PVAv+nhqaoC0MJmN+FNRnApQm6PswhSOHQUYGgtRM
         DzA3Ugojnu0KdMW8tPT91Kt2lYQFjONlxNo4ehji42bSMX3tuF3p7p+cthR64BqkdNEx
         hwZnrAyta7CYHKFBidstriSWncQmBnA2k7D0b5iNE2H5iGHJPV3gigR3GwARKAMssSOj
         gtSFkAlgxW97F64m+lr0TvOrH22wjX2XGOWAKvoZ1AsiRMmlFYTMBcnyR0md69IDOPOY
         d8Nw==
X-Gm-Message-State: AOJu0YxpKyv5K7LECCJAjlNuRPbgITRWnNF7ypPL+RB9x5TmdgguAxgV
	k0rnSwS9LRPxWwABJJnFzk6t9X+GUnzyzw==
X-Google-Smtp-Source: AGHT+IE1qW2PmxwR5LLvX3JkKUeu9J9/6IFecg5/0CNK/lN7Qlx51PGBrMaoetarR8ExXxA+mGJZZg==
X-Received: by 2002:a05:600c:2493:b0:40c:a11:19e2 with SMTP id 19-20020a05600c249300b0040c0a1119e2mr515749wms.114.1703248226392;
        Fri, 22 Dec 2023 04:30:26 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b0040d3f4b1c8esm5292849wmq.36.2023.12.22.04.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 04:30:26 -0800 (PST)
Date: Fri, 22 Dec 2023 14:30:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Household Cang <canghousehold@aol.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE
Message-ID: <20231222123023.voxoxfcckxsz2vce@skbuf>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com>

Hi Lucas,

On Thu, Dec 21, 2023 at 02:40:34AM -0500, Household Cang wrote:
> > On Dec 18, 2023, at 11:23 AM, Romain Gantois <romain.gantois@bootlin.com> wrote:
> > 
> > This is a bugfix for an issue that was recently brought up in two
> > reports:
> > 
> > https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
> > https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> > 
> Add me in to be the 3rd report...
> RK3568 GMAC0 (eth1) to MT7531BE (CPU port)
> Current workaround for me is ethtool -K eth1 rx off tx off

Is "rx off" actually required, or just "tx off"?

> https://lore.kernel.org/netdev/m3clft2k7umjtny546ot3ayebattksibty3yyttpffvdixl65p@7dpqsr5nisbk/T/#t
> 
> Question on the patch to be built: how would I know if my setup could
> take advantage of the HW checksum offload? RK3658’s eth0 on stmmac is
> doing fine, and eth0 is not on a DSA switch. Does this mean eth1
> should be able to do hw checksum offload once the stmmac driver is
> fixed?

The MT7531BE switch requires transmitted packets to have an additional
header which indicates what switch port is targeted. So the packet
structure is not the same as what eth0 transmits.

Your GMAC datasheet should explain what packets it is able to offload
L4 checksumming for, quite plainly. Probably MAC + IP + TCP yes, but
MAC + MTK DSA + IP + TCP no.

The bug is that the network stack thinks that the GMAC is able to
offload TX checksums for these MTK DSA tagged packets, so it does not
calculate the checksum in software, leaving the task up to the hardware.
My guess is that the hardware doesn't recognize the packets as something
that is offloadable, so it doesn't calculate the checksum either, and
that's the story of how you end up with packets with bad checksums.

The patch to be built should analyze the packet before passing it to a
hardware offload engine which will do nothing. The driver still declares
the NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM features because it is able to
offload checksumming for _some_ packets, but it falls back to the
software checksum helper for the rest. This includes your MTK DSA tagged
packets. They can be checksummed in software even with the DSA tag added,
because that uses the more generic mechanism with skb->csum_start and
skb->csum_offset, which DSA is compatible with, just fine. The GMAC
driver, most likely because of the lack of hardware support, does not
look at skb->csum_start and skb->csum_offset (aka it does not declare
the NETIF_F_HW_CSUM feature), so it cannot offload checksumming for your
switch traffic unless that was specifically baked into the RTL.

More details in the "Switch tagging protocols" section of
Documentation/networking/dsa/dsa.rst.

