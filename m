Return-Path: <netdev+bounces-249936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441BD21087
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE863018F7F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D8346FA7;
	Wed, 14 Jan 2026 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1SaFUWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F43346AE5
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418933; cv=none; b=M0OWoLQDU/YhUt+uYEK+IPD3K76Lj3VNV7R4mekjBiTEmLF8eIETre5tW4QH7jtBZV/dPsV8tV7AmgYab58UGxhpLuLgrMZJzxjWWdJaL2XvSyALfZasB1GYH3QttXoAxr2x/OXOEIl1O2bE8F8hoXloLeH6EwRof400CiJkcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418933; c=relaxed/simple;
	bh=QKRezXrA3bG4ArDBbT58+S8c1CtyAn6iBKaQozySKZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0TYKCpd3bHvqnwl8YBkHmrw7c/XW46UVHQDQ9I8AgppqIRk144tCjNi5afC8bLFKkknD6vZ6FfyDaGyMXIVSGeeDj5Qy6UUzwec/4WONe7EO1uLQZQ7O19JLVWYJiXLR4pwUkUXd1z31k7wDRaNXISyHzGSAJxuk5apmhBjCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1SaFUWm; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56373f07265so137592e0c.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768418931; x=1769023731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=F1SaFUWm961JKpMnu0ydteNHS4t3gcUzC4JP64uX+Pxwm6r+qtELwLoB7gSni/Vb87
         ST5RwkRCCH/SRgx5WxbexFtcrj26A8BiglaB5QC30Rl/Uv41uKG7AVFGlPgBTmFFmKJw
         coXkIQuaGC0k2EPoL0hhFOLMboVh7HCwv30Vi4N3Rg449J4JzWWraOAZZYHXRMnpcR1z
         pMqlkGgiEDtsaNCPANBcnVAE5GJq9rpbSUYYL9hBi1OcDD/9mpRNCtlaPN1VqTo2zk6u
         Fztciom0/pJecn0NCLJpn+i5hSrSetqKJwq6Oc7PZsCl4e6/JZ9lYCfHMoMutSuVEZlZ
         86mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768418931; x=1769023731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=QAnQ+Wyhq+z/IJjl9C6iZtJLcfqdA3q+QvD6w4Lx8zGIZb9+ibQUHANO4EoTuJk4vB
         QuWy5GZY4ToMlZWozbanMXCC2Q2HWkCauZjqf+G//ClsUCYmm4IAlDmPHEG1P00VK1Ng
         Y+xqZkRGZHcUd0bfMx0iUtuKRWp96in0Ie92mUlGK1UpXB5SH0imcvCYoEgu4R80jgE9
         sC7lFcEh790gkNPJ3qUjll0Zf/1SS1aw+6XmLLOF/zJrKvb4Mgt55A+B/w+JdgZMidbR
         PBLbdzXetAEajcAFkXrXlIYeOPTJ0WRBAEmh1u1VztJlaUJ5wwAppvg2Kz/NmS9ZQVRX
         0Z5g==
X-Forwarded-Encrypted: i=1; AJvYcCVlY9wBIzkmAXE5Z33qAYQw/lJlWl1nd0xu94Nk3+VI7XzGs1rmgboUILT/sJvO7BzH2a3cQPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/RHIcSZQ9OAQlGehu9X/8rTY68SLg8TxqN47utwQVstMhvNj
	J9IwXDJRm5ZXtbbeyOYhuF9odJLVGqEjeAlF3EVdMIHtx08AbmbUZa06SKF/RA==
X-Gm-Gg: AY/fxX7nz6wF6Tkwyq9B1Sy9nremlxVnWqxP4cLn3txs8usxNWaDr/NCW8Bxietpbuj
	OutYLv6tuzwSk6VB219GvnU4SDRQXIgnOPr6MHf3OdI7iPSC/rpkKGnAWVuin02eORrT1BrY0aH
	QEtMggeWwB9I7OEvWeW/hsvcnIhBg6lOHKb0yI3vsgzD8kmqRSPN9dThCzDdwtIRHEMV3YWDjqW
	YLRRrPl0ETsLPxx70qUAoRHONNrDCxUfce7jyY54EsFmJ+dUMzg56I+LjJnw3ef9nlDEn9ke7uF
	Su3R2QJkgotHfCDpt3FXcKkkn+t3EqNUCvNbE8TUBpFEnJwpGn0pNgsW2O5AiczlO/IVDdeeqPr
	BSDOOSCiISD41CmVLB0vJkiSwKORswP69/pHcyZesfmOEph8V8hTtwyfK9BNmtv9Y64l2Jc4Fb5
	/oszmvu6+XmoGqSVJTh9arPzrZvOWx8TguKQ==
X-Received: by 2002:a05:690e:1c06:b0:646:eb06:f2e2 with SMTP id 956f58d0204a3-64903b513d2mr1973243d50.73.1768411311135;
        Wed, 14 Jan 2026 09:21:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6e12ffsm92418037b3.53.2026.01.14.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:21:50 -0800 (PST)
Date: Wed, 14 Jan 2026 09:21:49 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Long Li <longli@microsoft.com>, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWfQrS1oNcXwcXu3@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <202601140749.5TXm5gpl-lkp@intel.com>
 <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>

On Wed, Jan 14, 2026 at 04:54:15PM +0100, Stefano Garzarella wrote:
> On Wed, 14 Jan 2026 at 00:13, kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Bobby,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-set-skb-owner-of-virtio_transport_reset_no_sock-reply/20260113-125559
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20260112-vsock-vmtest-v14-1-a5c332db3e2b%40meta.com
> > patch subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
> > config: x86_64-buildonly-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601140749.5TXm5gpl-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> WARNING: modpost: net/vmw_vsock/vsock: section mismatch in reference: vsock_exit+0x25 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)
> 
> Bobby can you check this report?
> 
> Could be related to `__net_initdata` annotation of `vsock_sysctl_ops` ?
> Why we need that?
> 
> Thanks,
> Stefano
> 

Yep, no problem.

Best,
Bobby

