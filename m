Return-Path: <netdev+bounces-151172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8F9ED389
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75CF282279
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D41202F8B;
	Wed, 11 Dec 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaJZ3MO+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB279202F92
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938137; cv=none; b=Nsnc+eIsMFaZ+AakrGfwA7MPMzWDCfXyMxECbRvs5lYlmk9Cy0HhuDXZ687oIDLcx0QVIUnpe0Adj91To7o+dHleokcjiArT3kN7/tJ6MTiAEo9uy7WeqJVJyqIJ10max8BiQNdDudZQ2quUxZAMP06TZ7Nty585WNs3Wp8fwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938137; c=relaxed/simple;
	bh=xuganhRKp85DtsDZPvtf1Y092XLOvqZdWrysMPftP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3Ya06E5D/hgzEzZXEMRKAyvz24rXR14EPbllWksBCj36x4htXS/71dq23qQBz87zE1ubgkeOsBrpUR3jSuqVJ2aMI7nZMIqMzrWug/3l1FVnOqaIbxY/8oCWiywqZFm2OMII2Q3jho9nqXmDUlA3rOHNhmFtFkca6f1E7PmIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaJZ3MO+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb95317so52442855ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733938135; x=1734542935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2xOcIu4cjw6MZPbpoPGAaQI1VrZ/TeGuPsTNEfVaoI=;
        b=HaJZ3MO+oHUekt/jknxLTjZXtXbenRvKCyRiTj9Bmkqqvgo1mhPNOhu1DxIZ2sIYwW
         K8kQ6LMhZ+vQy7G+9TZKMpnNTVqGXrJSIig4i2unMMu3fn7O2u7KMLHzUCGh7e1XdWOX
         reNFag/dTar7CKvEIT+CksdQQZdLCToZA4vdPLGVGIqN3Vl0xlmjusGkK+qY1+TweZuj
         jzN5ywefp3LHq8h4v0TJF6k87qiqQWONa5f/HaxtAJNnRyQ0g8a/d4E/SFc7SfjV9pnL
         iBGI+MJK4akhyoqyNenR2An8Gcpmyt6WkPArCmofGgCBagHB/10xsqkgU4lohhoBKGQ6
         gLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733938135; x=1734542935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2xOcIu4cjw6MZPbpoPGAaQI1VrZ/TeGuPsTNEfVaoI=;
        b=g2fqDwrWTMXY3/bCgx/LQb8EIdTVjoKU8r554tWBW8pmcG9T9sze5uYdQ6/NY0NMQC
         SMurycucKcNO1tpABqXYYcP/EPOBpPFcXndT2pOjtOJa00HFaXkipq+iVtx/Q7H5Qn+P
         fXY1Qk5/CxnsGewwCAtjHdMJLC7doUagifVv/IUTYDVqplKSykCMKgND+n51J1z0wIj/
         UlvQCJPs5wKoPT2DgbL+mAPCmIQkWCizoUiyj2Vdb+kFZPDEmKzDxFXu3begyIz/8Xgi
         w8fx/ADRyeKNPA7LD0MAbulNyouWLeZaSzkl4JI/ST09L+tFcM35bCe0uToSfeT3R/dG
         wUqA==
X-Forwarded-Encrypted: i=1; AJvYcCUSX419Nkl/j6T6Ll5NgHJN78fIXlTL1ek+V3ZVByrfOYbwhDQ4bedU5Vj3pWyL8ep8NceL7Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qQsIjmcqcaBWpOrs+TviLt3e66CHzW38v4P3HV/+jxhRnp2/
	ELX/wDkT8gsHTy+PWlfWrflMYYuKi3Lyk961kmD3QxEhMY10c7nN
X-Gm-Gg: ASbGncvsFzHRwetDWBuDzcP/H2rfDczlwufG2N8Qvdu8dFQyAStsrIr0FiIOasp7hY+
	/Dr6nkIdK7wZfstJByaZNcmXRWyf+Imy7Z1pd3E5PsdvVOLIxgWDYWLBQ44CRnA8OhcKPY/ivMa
	4aqegqyIcyspo3P43beUkyxhkVbFDZB57arX3vjOyyyIhgysCNTBEHz1QZdOCrKukprdkAhoopz
	sVQ0PiXNhOz6EgipygnGuJ4oBNPrXrYL+EzV0uF3yRJZZO8KYdJL90Lu8c=
X-Google-Smtp-Source: AGHT+IFmCNB3daXudD3JhROfEryJYgNALfmn3p4YG5B1CgSMFYR0o87BZZoQpyR22/RYpoDdhSBVIg==
X-Received: by 2002:a17:902:c946:b0:215:3849:9275 with SMTP id d9443c01a7336-21778562d49mr53474275ad.49.1733938134688;
        Wed, 11 Dec 2024 09:28:54 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:1f04:574d:f94:333f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2178112caf3sm12200725ad.54.2024.12.11.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 09:28:54 -0800 (PST)
Date: Wed, 11 Dec 2024 09:28:53 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, dave seddon <dave.seddon.ca@gmail.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: tcp_diag for all network namespaces?
Message-ID: <Z1nL1VIBozBii1wz@pop-os.localdomain>
References: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
 <Z1fO0rT9MZs5D61z@pop-os.localdomain>
 <1373213.1733863522@famine>
 <CABAhCORpd+1A6uThBQ_YYx16iLkPZDXs5vwTkYDNAxcN3epWDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABAhCORpd+1A6uThBQ_YYx16iLkPZDXs5vwTkYDNAxcN3epWDw@mail.gmail.com>

On Wed, Dec 11, 2024 at 02:35:16PM +0800, Xiao Liang wrote:
> On Wed, Dec 11, 2024 at 1:43 PM Jay Vosburgh <jv@jvosburgh.net> wrote:
> >
> > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > >On Mon, Dec 09, 2024 at 11:24:18AM -0800, dave seddon wrote:
> > >> G'day,
> > >>
> > >> Short
> > >> Is there a way to extract tcp_diag socket data for all sockets from
> > >> all network name spaces please?
> > >>
> > >> Background
> > >> I've been using tcp_diag to dump out TCP socket performance every
> > >> minute and then stream the data via Kafka and then into a Clickhouse
> > >> database.  This is awesome for socket performance monitoring.
> > >>
> > >> Kubernetes
> > >> I'd like to adapt this solution to <somehow> allow monitoring of
> > >> kubernetes clusters, so that it would be possible to monitor the
> > >> socket performance of all pods.  Ideally, a single process could open
> > >> a netlink socket into each network namespace, but currently that isn't
> > >> possible.
> > >>
> > >> Would it be crazy to add a new feature to the kernel to allow dumping
> > >> all sockets from all name spaces?
> > >
> > >You are already able to do so in user-space, something like:
> > >
> > >for ns in $(ip netns list | cut -d' ' -f1); do
> > >    ip netns exec $ns ss -tapn
> > >done
> > >
> > >(If you use API, you can find equivalent API's)
> >
> >         FWIW, if any namespaces weren't created through /sbin/ip, then
> > something like the following works as well:
> >
> > #!/bin/bash
> >
> > nspidlist=`lsns -t net -o pid -n`
> >
> > for p in ${nspidlist}; do
> >         lsns -p ${p} -t net
> >         nsenter -n -t ${p} ss -tapn
> > done
> 
> I think neither iproute2 nor lsns can actually list all net namespaces.
> iproute2 uses mounts under /run/netns by default, and lsns iterates
> through processes. But there are more ways to hold a reference to
> netns: open fds, sockets, and files hidden in mnt namespaces...

Do you really need that accuracy? Dumping just provides a snapshot, it
is by definition not accurate.

> 
> Consider if we move an interface to a netns, and some process
> creates a socket in that ns and switches back to init ns. Then when
> we delete it with "ip netns delete", the interface and ns are lost from
> userspace. It's hard to troubleshoot.

You also use tracing tools like bpftrace for troubleshooting like your
case, dumping is not the only way.

> 
> I haven't found a way to enumerate net namespaces reliably. Maybe
> we can have an API to list namespaces in net_namespace_list, and
> allow processes to open an ns file by inum?
> 

If you have a solid and real use case, maybe.

Thanks.

