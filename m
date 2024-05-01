Return-Path: <netdev+bounces-92782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F458B8D79
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8719F281A8B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2F12FF70;
	Wed,  1 May 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii/rOyYx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8212FB39
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578514; cv=none; b=bLu8HQuVpKtVO4s5qcZLLD+mgbvAdYl1MP8o1EaBVcBFATOa9YMuhNrfi9i5eKGTwByta7D1ADQshDY8mx4O0PfyN+V/EFZzGhBao+hiSDNaweRPQgFJn91bxLPhPickbDfdG/g7yMW2AjK1W67iNFcj7huqscYrLbF5y6xGNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578514; c=relaxed/simple;
	bh=ep9gRD8mGOXCtjRdooKCCClREdkKGq/7TcmThE40S2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HInBbWQCMiMFOF+77pVO/jfHKxyDq1vKHcLUOm/QAyYST026an7CGmLytsp8xYW1tjhXTd7Qn/A1esrQ5HFKOPrXFcei/VHl4gD4SiGkW4JvAReJx/Cs4CpiVRjRjh9x2Ny/NcjSxL9TRJaRtuTZk9Zl9FGF4rHm3LfOtNR7q/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ii/rOyYx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714578512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vXPnuPC4TTKf1aPUT/9gMUEiWKzRf5rqJKHhBZKq84=;
	b=ii/rOyYx/PXPv/8uFsVS8N4KfOoBSyJQD+1xY6oywdabS/RBrh9ngROXqEjLzd41bovZfc
	7DvOGjJAY86ZqTo8QYygpgZnkdlLS4mzZLs/Ym/+KEXwa1sZCwQ2ydq49ttS5UZG2RSTi6
	9+k8lK4M4kUG/nk8jPMnTcFZQVPNOhA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Olba8qnfP6KTEHiuK_4A2w-1; Wed, 01 May 2024 11:48:30 -0400
X-MC-Unique: Olba8qnfP6KTEHiuK_4A2w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5563ef10d4so437327966b.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 08:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578509; x=1715183309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vXPnuPC4TTKf1aPUT/9gMUEiWKzRf5rqJKHhBZKq84=;
        b=iKRG440mQLoSEm2HZE/btLWy81GFFN1p+HkLZHmnFvE9xgFY+mHc0YCOPmj3UVQvO6
         RLL69arMyYnv6g7Ih514kN5NOl3+XFq/TWjIeq3j0BNBVzPDCfUbT0OvWwwWj4bYJf14
         Ce6xmMxK6TYTf4UlASyL9j+Ot1UYvrhOy0k5KdLfzW36QNnNKg8SzfM9T2b9SilsnZer
         /8AncZDWmRNpiJhpdpfEiPHBISo863EbH/QbtCaFzr0wgYXqhBRMW3QM+mkpHUMMyPj+
         3guOqbkstXRPQQTwwJWZuvtw7+VxwNFZOguZvGeUU7EALU9GAvt5G8WZBG+zi/r/xySe
         KjKA==
X-Forwarded-Encrypted: i=1; AJvYcCWtDB5vHpPnwXMShw36XOuhFpmos3xwvy9GpzqSWpSWvENEdKwiR5CxfTEnky2Ge5AKMMl8V5IIOuOFSVf7w70rPs3ZCwiF
X-Gm-Message-State: AOJu0YxZWERb5PGFtXDaX3p9hrnL66XBToMp+zUYeWNsaVm1bzAWxqn5
	dHQhO88H21sQSbkODHQ8m7kBxsA2g31Bfx0j5ISVNXVlJAZB02kP/PSc+pXJQdyVuYpgmDxZxM6
	VxypICE/MElRoNx2AlSfMTooTxXfspk/V1RdP9U63yxyVENej4FN2/A==
X-Received: by 2002:a17:906:5d2:b0:a58:e4dc:ad99 with SMTP id t18-20020a17090605d200b00a58e4dcad99mr1916532ejt.2.1714578509556;
        Wed, 01 May 2024 08:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkX5jNP9njQFhCTsNr5Jxg9lBydsGfLtvu6aP6rVyCQCFHRXL0OAvf21MC7R4anBI/wEV3Q==
X-Received: by 2002:a17:906:5d2:b0:a58:e4dc:ad99 with SMTP id t18-20020a17090605d200b00a58e4dcad99mr1916493ejt.2.1714578508989;
        Wed, 01 May 2024 08:48:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906090900b00a55b05c4598sm12447242ejd.133.2024.05.01.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:48:28 -0700 (PDT)
Date: Wed, 1 May 2024 11:48:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>, Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240501114754-mutt-send-email-mst@kernel.org>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
 <202405011004.Rkw6IrSl-lkp@intel.com>
 <1714538736.2472136-1-hengqi@linux.alibaba.com>
 <20240501074420.1b5e5e69@kernel.org>
 <1714576307.2126026-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714576307.2126026-2-hengqi@linux.alibaba.com>

On Wed, May 01, 2024 at 11:11:47PM +0800, Heng Qi wrote:
> On Wed, 1 May 2024 07:44:20 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Wed, 1 May 2024 12:45:36 +0800 Heng Qi wrote:
> > > >    net/ethtool/coalesce.c: At top level:  
> > >  [...]  
> > > >      446 | static int ethnl_update_profile(struct net_device *dev,
> > > >          |            ^~~~~~~~~~~~~~~~~~~~  
> > >  [...]  
> > > >      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> > > >          |            ^~~~~~~~~~~~~~~~~~~~
> > > >   
> > > 
> > > This is a known minor issue, to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
> > > mentioned in v10. Since the calls of ethnl_update_profile() and
> > > coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
> > > true, the robot's warning can be ignored the code is safe.
> > > 
> > > All NIPA test cases running on my local pass successfully on V11.
> > > 
> > > Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
> > > up to Kuba (and others). :)
> > 
> > You should remove the ifdef around the member in struct net_device.
> > It's too much code complication to save one pointer in the struct.
> 
> Makes sense.
> 
> Thanks.

if you really want to you can add a comment
 /* only used if IS_ENABLED(CONFIG_DIMLIB) */


