Return-Path: <netdev+bounces-99227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B58D427D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33B1B24F74
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6222D27E;
	Thu, 30 May 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F24FSipB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0876AA1;
	Thu, 30 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030239; cv=none; b=Tlsd7GVOLzJXryfX4Tzw/G5Dtpk5flsJkqr7/SKSgtuMmuSlNdBkXuY7KQWtPl3t5S7OPctXjRzrH/Y3X+cRgwqF8qwDPftWmpxPUz6Uj5AgvDhu8ySvdVXsWTHXSU1qQ+GDP7WtVy6L3H4AWo/F7eSeDE3BJpDoNYZ0AbnAQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030239; c=relaxed/simple;
	bh=w0M2NwYr/14Mvs7l87d7yBk8eY17sbC7zcA+FobWwQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv2QXBNs+ta3OR5SuYpRy7RLX3tu/8zqoPlQNvORabGWmpBl4I+WzBpOp3zt6J0njLVWhD6K47Vj8n11pkQ7chwhMooVyy5Jr/uXWQ2CpmAIbjP8BD0plZGiJg3ASQ91PIFJmi3mUHnnDr7AwPkdZliNNcBQHJoEcKtQpO3tlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F24FSipB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso199691b3a.1;
        Wed, 29 May 2024 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717030238; x=1717635038; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8+O8xhY+pxJWdqeW2KaJVJjVRnx1SFKpe5mCJ/JMA4=;
        b=F24FSipBFdAKBQ1pwHupzNe/aaBgnlfzwW6J3wyDyAJRHhMPvB9ccvyBeDDiI+JUP3
         +I5niiuefXkKIhumab3qU8vqatW7gimYNj5/mMjXtwFVGvr5b1Nr1Cs40n3QqSBzIo5T
         XBxNaFwNe4cb9egClaXYd9jouKS39L1E+Mo+BmjXbfNYsxoR3xU1NcOUGFbe71QkZAW0
         YdihjVyuFjHR45spuL61ZDY7oYl7sCzAIyZpNZg4NDvmhciUlaH2nLg9RPXdiRXXCPEo
         P7ogpyxD+O30/Vpv1pvcXr3AS+VLlBpTK7lc80zedOR4CpiMLhez2pfxXbS9SNdI0qiY
         YEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030238; x=1717635038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8+O8xhY+pxJWdqeW2KaJVJjVRnx1SFKpe5mCJ/JMA4=;
        b=ZPIHzqKJSWyohIuDgX0pcV7EFl5GEQZbBN9x8BId0hCNeN3s8elzGZdG64ZC89D17q
         utTPghO3YNN9fWolJEMgx7EP6wPDMdHr6SfuFWZ7MgVbY/Nd/PiKmmaBGTcQ4Dy5nafc
         uaxRcCsmPACcKLAOYf+f45EXPl62S9pvDC8afhtglL/dwCdsQSzF+VYtvDRWbLW9QIQk
         aBQ+wjk6i1k8GJvFqiknZesin2CK7U1SqiVYusQmqhlNSPAdTmV13ASn/CdzL2g8oWku
         78zGzfofNFK+GYA6zHHKpSuPr11t/bhmqqYLKIpkudrGBPF85buOh2Cez5h40H3+dykh
         NWYA==
X-Forwarded-Encrypted: i=1; AJvYcCW4OmjLT1qC0UUwwArf28CofcyO3w8igHoi3DHlj6j2pNnHPWlZNC0oT4fbzlt+fZZ56vxR9yiMl9zSXdlpndHsn0Q2XXxu+h8MktreQWaSdMQoTB3ySnqNUqwrd0UDjwGX5G10V1bCYNRZe6Z58fkUZww1n2BPVDSrG3dzZ/nXvsY/2wyX6LMsG8Ts
X-Gm-Message-State: AOJu0YzJvm4f0EYpiCiP/Ca3NHT01tZZzCxY24XShbV/d6wDmBxvPvJn
	did9Z8c7yIe0hVeOQITkge17Y0X9c5bOC9YVTOGxqFcYyiOzUl3IND5pq06u
X-Google-Smtp-Source: AGHT+IEYDfQxP1oHkh5ta+MZE51Ikrl8Y36qaiEgsMUgYNELNTiBc5MpFMcJovRpYRv1UkeiFSflbw==
X-Received: by 2002:a62:f201:0:b0:701:c944:ae75 with SMTP id d2e1a72fcca58-70231a867d5mr652385b3a.4.1717030237502;
        Wed, 29 May 2024 17:50:37 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc3552ffsm8593308b3a.80.2024.05.29.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:50:37 -0700 (PDT)
Date: Wed, 29 May 2024 18:50:34 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev, netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v2] landlock: Add abstract unix socket connect
 restrictions
Message-ID: <ZlfNWtyEnIAw99ne@tahera-OptiPlex-5000>
References: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
 <20240401.ieC2uqua5sha@digikod.net>
 <ZhcRnhVKFUgCleDi@tahera-OptiPlex-5000>
 <20240411.ahgeefeiNg4i@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411.ahgeefeiNg4i@digikod.net>

On Tue, Apr 30, 2024 at 05:24:45PM +0200, Mickaël Salaün wrote:
> On Wed, Apr 10, 2024 at 04:24:30PM -0600, Tahera Fahimi wrote:
> > On Tue, Apr 02, 2024 at 11:53:09AM +0200, Mickaël Salaün wrote:
> > > Thanks for this patch.  Please CC the netdev mailing list too, they may
> > > be interested by this feature. I also added a few folks that previously
> > > showed their interest for this feature.
> > > 
> > > On Thu, Mar 28, 2024 at 05:12:13PM -0600, TaheraFahimi wrote:
> > > > Abstract unix sockets are used for local interprocess communication without
> > > > relying on filesystem. Since landlock has no restriction for connecting to
> > > > a UNIX socket in the abstract namespace, a sandboxed process can connect to
> > > > a socket outside the sandboxed environment. Access to such sockets should
> > > > be scoped the same way ptrace access is limited.
> > > 
> > > This is good but it would be better to explain that Landlock doesn't
> > > currently control abstract unix sockets and that it would make sense for
> > > a sandbox.
> > > 
> > > 
> > > > 
> > > > For a landlocked process to be allowed to connect to a target process, it
> > > > must have a subset of the target process’s rules (the connecting socket
> > > > must be in a sub-domain of the listening socket). This patch adds a new
> > > > LSM hook for connect function in unix socket with the related access rights.
> > > 
> > > Because of compatibility reasons, and because Landlock should be
> > > flexible, we need to extend the user space interface.  As explained in
> > > the GitHub issue, we need to add a new "scoped" field to the
> > > landlock_ruleset_attr struct. This field will optionally contain a
> > > LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET flag to specify that this
> > > ruleset will deny any connection from within the sandbox to its parents
> > > (i.e. any parent sandbox or not-sandboxed processes).
> 
> > Thanks for the feedback. Here is what I understood, please correct me if
> > I am wrong. First, I should add another field to the
> > landlock_ruleset_attr (a field like handled_access_net, but for the unix
> > sockets) with a flag LANDLOCK_ACCESS_UNIX_CONNECT (it is a flag like
> > LANDLOCK_ACCESS_NET_CONNECT_TCP but fot the unix sockets connect).
> 
> That was the initial idea, but after thinking more about it and talking
> with some users, I now think we can get a more generic interface.
> 
> Because unix sockets, signals, and other IPCs are fully controlled by
> the kernel (contrary to inet sockets that get out of the system), we can
> add ingress and egress control according to the source and the
> destination.
> 
> To control the direction we could add an
> LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE and a
> LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND rights (these names are a bit
> long but at least explicit).  To control the source and destination, it
> makes sense to use Landlock domain (i.e. sandboxes):
> LANDLOCK_DOMAIN_HIERARCHY_PARENT, LANDLOCK_DOMAIN_HIERARCHY_SELF, and
> LANDLOCK_DOMAIN_HIERARCHY_CHILD.  This could be used by extending the
> landlock_ruleset_attr type and adding a new
> landlock_domain_hierarchy_attr type:
> 
> struct landlock_ruleset_attr ruleset_attr = {
>   .handled_access_dom = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
>                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> }
> 
> // Allows sending data to and receiving data from processes in the same
> // domain or a child domain, through abstract unix sockets.
> struct landlock_domain_hierarchy_attr dom_attr = {
>   .allowed_access = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
>                     LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
>   .relationship = LANDLOCK_DOMAIN_HIERARCHY_SELF | \
>                   LANDLOCK_DOMAIN_HIERARCHY_CHILD,
> };
> 
> It should also work with other kind of IPCs:
> * LANDLOCK_ACCESS_DOM_UNIX_PATHNAME_RECEIVE/SEND (signal)
> * LANDLOCK_ACCESS_DOM_SIGNAL_RECEIVE/SEND (signal)
> * LANDLOCK_ACCESS_DOM_XSI_RECEIVE/SEND (XSI message queue)
> * LANDLOCK_ACCESS_DOM_MQ_RECEIVE/SEND (POSIX message queue)
> * LANDLOCK_ACCESS_DOM_PTRACE_RECEIVE/SEND (ptrace, which would be
>   limited)
> 
> What do you think?
Indeed, in the case of abstract Unix sockets, both parties can send and
receive data when a connection is established. Therefore, we can define
a single LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT to represent the right to
share data, regardless of direction. However, we should still retain
LANDLOCK_DOMAIN_HIERARCHY for SELF, PARENT, and CHILD, as the source and
destination are important. 
As you said, I believe we should have receive and send rights for
another kind of IPCs (which will be used for landlock#8 issue)


