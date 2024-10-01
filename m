Return-Path: <netdev+bounces-130981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2398C518
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBD31C23836
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E73D1CCB50;
	Tue,  1 Oct 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KU6+UDb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB201CC882
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806047; cv=none; b=r6Qc44wJafge7TdB2/m/3Lvy0G7jB9A8ktzGv0P95IKIw0cBLW/LO1MXinuZ7eGgy5Re/ipmRqxf2d17SoCYc67PpnjaXNt56zTBz0SN7xHCL7tJN5BcMBLZ4S9FZT+Rc76+mXtf8AV7C+sayd05lwjSDeqIAzQoabjC1BcLv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806047; c=relaxed/simple;
	bh=lKv1oPd1u6ZafX752GT6OJMf43JnT/5BtZuMMtd4hGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1mZFVW7wYq9ii4uRlnrrSiDVEFwm8lEkQjJqakGEL22LoVrrFkcQx7lu43ib3CGxLaBud44x1XYwBcWpxsrLvUlsz1gece8zL9KsAE1CNrww1O9wN5wZTQTz3UUdkWfkTBkdOW2j5LvNQ95MATe9ovcCowYgY8DcoqBbYg79lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KU6+UDb0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7198de684a7so4108675b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727806044; x=1728410844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlfIDLL8X+h1iXFwaqyKKzJo5oDK37QI3Hy/+CpBMIs=;
        b=KU6+UDb0TiUTtvTfVjNGiyYeXwPmSSOklNtUgnpjM5eCU+fT3BtGqVdSIyruahg7s0
         fS/Jtm0G9S/Z92LOwmap7GiSXE2O4ztwL2P+RsnQDZv7HI+jFXtlAbgAWYdToE9UUNlG
         AmUYWOBw2IRF73OiPDMHxGq2denCd7mayOkSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727806044; x=1728410844;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlfIDLL8X+h1iXFwaqyKKzJo5oDK37QI3Hy/+CpBMIs=;
        b=AeeAaCH7XJQzCNQvb18npShnAUtBQv+Bo5DGhL/HBwr+xBF9AuMRg+PpWuPXg3LxkZ
         1ZAjIL8JtxZtbd5gv+OAdG/ctoTWsP9+TNvrnKucB49s84IF6B3XtXnOYhco145mxVy1
         bGcjKHo3FG7fmuZkQRMW+pYyhDBvli6cwX8aGseaNb9WnzBc5DKx+XybacVCe+dbTrEn
         RDBDcjLcs0QIYnjaGgU7wHLyszmuSYi0PkPFVnpsD10Ahw2ZAltncf43KgHP1XlzoHPr
         +bNY0W6S11bdTxq04b7RKPhKMGiQAYzuIj7EvLexgLvqJJAoTStpD/fddt9X1j43KmUM
         kTeA==
X-Gm-Message-State: AOJu0Yx0GQpup2TAqNFNHuC2sBsuO4AcC3H2d2R5Eg2feeb9c3DYm2nj
	pAy0tFdfSDz6NTTnyZ6f7O8sLxFHvmxOcqP+FW/m1Pvbu93Aw8dMCKIXYrttSG0=
X-Google-Smtp-Source: AGHT+IGzb38o63/1Jf14hRPcELRzrT96vMV7+jxQmAG1DD4+K4rabFqw4JMpN8Rh//7ySnQXE6tHUw==
X-Received: by 2002:a05:6a20:d503:b0:1cf:2aaa:9199 with SMTP id adf61e73a8af0-1d5db22de58mr822622637.15.1727806044197;
        Tue, 01 Oct 2024 11:07:24 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536645sm8343990b3a.188.2024.10.01.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:07:23 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:07:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
Subject: Re: [net-next 2/2] ena: Link queues to NAPIs
Message-ID: <Zvw6WIbaRKzNMVF_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
References: <d631f97559534c058fbd5c95afcb807a@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d631f97559534c058fbd5c95afcb807a@amazon.com>

On Tue, Oct 01, 2024 at 04:40:32PM +0000, Arinzon, David wrote:
> > > > >
> > > > > Thank you for uploading this patch.
> > > >
> > > > Can you please let me know (explicitly) if you want me to send a
> > > > second revision (when net-next allows for it) to remove the 'struct
> > > > napi_struct' and add a comment as described above?
> > >
> > > Yes, I would appreciate that.
> > > I guess the `struct napi_struct` is OK, this way both functions will look the
> > same.
> > > Regarding the comment, yes please, something like /* This API is
> > supported for non-XDP queues only */ in both places.
> > > I also added a small request to preserve reverse christmas tree order on
> > patch 1/2 in the series.
> > 
> > Thanks for mentioning the nit about reverse christmas tree order; I missed
> > that.
> > 
> > I will:
> >   - Fix the ordering of the variables in 1/2
> >   - Add 2 comments in 2/2
> > 
> > I'll have to wait the ~48hr timeout before I can post the v2, but I'll be sure to
> > CC you on the next revision.
> 
> It's not at least a 24hr timeout?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n394

Ah, looks like you are right. For some reason I had 48hr in my head;
I think I usually wait a bit longer for larger / more complicated
stuff, but in this case 24hr seems OK.
 
> > 
> > > Thank you again for the patches in the driver.
> > 
> > No worries, thanks for the review.
> > 
> > BTW: Since neither of the changes you've asked me to make are functional
> > changes, would you mind testing the driver changes on your side just to
> > make sure? I tested them myself on an ec2 instance with an ENA driver, but I
> > am not an expert on ENA :)
> > 
> > - Joe
> 
> I picked up the patch and got to the same results that you did when running on an EC2 instance.
> Thank you for sharing the commands in the commit messages, it was really helpful.
> Correct me if I'm wrong, but there's no functional impact to these changes except the ability to
> view the mappings through netlink.

This doesn't change anything about how the driver processes packets
or handles data or anything. It's a "control plane" sort of change;
it allows the mapping of IRQs queues and NAPI IDs to be exposed via
netlink from core networking code (see also: net/core/netdev-genl.c
and net/core/netdev-genl-gen.c).

This can be useful if an app uses, for example,
SO_INCOMING_NAPI_ID (typically used for busy polling, but not
required to busy poll).

A user app might design some logic like (just making this up as an
example):

  New fd from accept() has NAPI_ID 123 which corresponds to ifindex
  3 and so thread number X should handle the connection, because it
  is pinned to a CPU that is most optimal for ifindex 3 (e.g. NUMA
  local or softIRQ local or whatever the user app wants).

Without this change, user apps can get the NAPI id of an FD but have
no way to know which ifindex or queue it is associated with.

It also allows user apps to more easily determine which IRQ maps to
which queue (without having to parse, say /proc/interrupts).

This can be used for monitoring/alerting/observability purposes by
user apps trying to track down the source of hardware IRQ
generation. Say you are using RSS to direct specific types of flows
to specific queues, knowing which queues are associated with which
IRQs (via their NAPI ID) can help narrow down where IRQ generation
is coming from.

Overall: there's a lot of use cases where exposing this mapping to
userland can be very helpful.

