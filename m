Return-Path: <netdev+bounces-231683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FCBFC8B5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBAE94E2257
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E3C35BDB8;
	Wed, 22 Oct 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bGn7pvS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF035BDAD
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143309; cv=none; b=fCw2mBDHBKgHkpC6dkGyvd6OKAWn35vO/vxeCbQDf51VhlSEjLfPEs4beBPtSu9qBKxhA/KmBOTM9zTVu13EObLMJD38N2ow8htexwjPOLIhn2HsG5iXey8c5NcD4yKHjTuSJRWwMSimh7j676pPaQ+a/xHCA7CELVYOenrwA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143309; c=relaxed/simple;
	bh=7rFO60cs+ojMDtinvJI6S0GOckN6KLFDylmfbzmGFcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxWJ+baml9U9A+sk2ZpZh5kNc0CMU6vX5iprTwu5NPV9jAsLf0yzc08qJge+dQUMY/v8NWEPtD47YwHn4pKjrv1hEI6lGHCJL1hzDW7tVrZ9WYDvOkiTzlOG5zldLvcw3hxMgc6wyEnDdhWMfY/hg0DNAQfI4ypbxzsXrfhqLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bGn7pvS7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c6b9fcso11898071cf.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761143307; x=1761748107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bt2mz88kxQaKeFfwo7y6zN05vfKzXencELjsqpI75vo=;
        b=bGn7pvS7oDgH95eIgW/v8JnsBxkFJLUwEa3p8koVeFqqmWr7TWdKi3WZ65EDCse2zZ
         xJhncabx+zGpLd4PWXhlme7uLYd3VSMdlnw6BN7nOz21TUIKnFMm6xZfTzQjI3ZvUkYO
         7oBD3HXJVCeOS0wEJgsuGQ+j4iYSqgU7FyfvOu7ukbVL2pcTz6knrl8QXbRmMBxhM/4b
         gMmXzjs3jVKKfY8S5oU1CzGBSWAcNcUAZ+AQgryrDL4WyE66aJnv38laQf6UbEIy4YPl
         8sRN8ALVhuofbKObuSDJVtH53t/4uu/h4cc15yOwkdrrMf+q7ZEtxLcIf/mEYmg57+VD
         yk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143307; x=1761748107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt2mz88kxQaKeFfwo7y6zN05vfKzXencELjsqpI75vo=;
        b=dCVSWeQTIJJhlLgVrdnR+XtmDSpsKSVC3AO/pBHkTDeNHaXQmd3Or++6KPWT0KHs6z
         XkVUl9JDmATtzk40946W/oZflXuigB/nLPtHnzUTGNPiUFWhmB24FU7z30BRIRR6y3S2
         RAEI7PaZQFoL4KKtVavArWQUN2lHSTssHslCiC4X3xTWaFeLE1RLnLJyM3ghJX3ET+35
         qeJdLrhNewa3Gc/LdUapcIXbZRN1mbqG988zxQUHCBvRSn0YV44MYEU6LOc4bYSZpQjo
         +DKF2XRbnAkXFgEUZk87l3zn5xC0X0g7nJfC5qOC849N7Ma1Rx4z91G6ci3Fr9z2EY4h
         4qoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTy16erJ+WsJ/TR5DAtdeWQN0S2yYW0gU7N1Ub/DSCoBWH4VU/QQGHTAABcYg2ZdtI45+F6dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweYd7fCH5AVAkjZdROQv4f1Y4pg9Ifg7l1oB1m9Vf8OciyJb60
	h/v/LfBVhxzNSysN5xLCFJW2NOS4AvrDTTgyDuOQeuoWeyMVaYduWDq00wNzF2NE2w==
X-Gm-Gg: ASbGncvQlfS93wlW0TKk+QD5+Mvsy65ZrdEa/USbKfdgQx8OgMRWOuxA7USLOLtXjPI
	egiiuQVqlPv/weblNYT/z36FvXkYSgduJd5KZ2U+ptk1uUgljlafnYe8VruzVUzLmQrCxuMALXO
	fIfvp2T8kwC8+qwVVXOlV2fT/t0SedHuJ49fEL/eB890agDTp/0EDcgLAxyw8QSsZIcjmrIdN0q
	5vr8dAX8ko+oxaEgZgs9REN75wfp7Z4f0sdzHOCqsOVCFbqEgGQbgF6oswoGO8wGzYLXLZDxtkC
	k4oszspSLuIH+1Zzp1PDyOvvqKEWIh33X3bIAWnBXDo3M7O+D1elyffRfckYkHGd8HHhC3UaUG1
	ggLuBQj7V+ArUf8802KtZcjoa3CxA+SHSEJMiJgQUanjWFG0yPvD6wVsAGBFPLkOQ8yi5d8rN3N
	8PLl1M5oWLBUoynFld3wI8peEXDk8omQ==
X-Google-Smtp-Source: AGHT+IEQFUBDmtWZDWA4/99CoLc+AR13PHUMRk56pDNsg4FZV887ScrpKn5yezdEL9l3JNDRfXtxMg==
X-Received: by 2002:ac8:7f51:0:b0:4e8:b9ab:8ad4 with SMTP id d75a77b69052e-4e8b9aba18emr149827841cf.81.1761143306656;
        Wed, 22 Oct 2025 07:28:26 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab10da83sm93572291cf.39.2025.10.22.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:28:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:28:23 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, yicongsrfy@163.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <7fd2d38a-08c8-4043-8dfe-eb2171b4e4e8@rowland.harvard.edu>
References: <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
 <20251018175618.148d4e59.michal.pecio@gmail.com>
 <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
 <20251020182327.0dd8958a.michal.pecio@gmail.com>
 <3c2a20ef-5388-49bd-ab09-27921ef1a729@rowland.harvard.edu>
 <3cb55160-8cca-471a-a707-188c7b411e34@suse.com>
 <fe42645d-0447-4bf4-98c5-ea288f8f6f5a@rowland.harvard.edu>
 <b3eb1a6f-696b-4ece-b906-4ecd14252321@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3eb1a6f-696b-4ece-b906-4ecd14252321@suse.com>

On Wed, Oct 22, 2025 at 09:58:57AM +0200, Oliver Neukum wrote:
> On 21.10.25 18:33, Alan Stern wrote:
> > On Tue, Oct 21, 2025 at 11:13:29AM +0200, Oliver Neukum wrote:
> > > On 20.10.25 18:59, Alan Stern wrote:
> > > 
> > > > Another possibility is simply to give up on handling all of this
> > > > automatically in the kernel.  The usb_modeswitch program certainly
> > > > should be capable of determining when a USB network device ought to
> > > > switch to a different configuration; that's very similar to the things
> > > > it does already.  Maybe userspace is the best place to implement this
> > > > stuff.
> > > 
> > > That would make usb_modeswitch or yet a new udev component mandatory.
> > > That is the exact opposite of what we would like to achieve.
> > 
> > In the same way that usb_modeswitch or a udev script is already
> > mandatory for a bunch of other devices?
> 
> Arguably broken devices.

Perhaps so.  That doesn't affect my main point, however.  Besides, none 
of the possible approaches we have been discussing are truly 
_mandatory_, because the user can always force a configuration change 
simply by writing to a sysfs file.

> > I agree, it would be great if the kernel could handle all these things
> > for people.  But sometimes it's just a lot easier to do stuff in
> > userspace.
> 
> Well the kernel does handle them. It just handles them wrong.

:-)

> You are not proposing to leave devices in the unconfigured state,
> are you?

No, I wasn't.  But that might not be a bad idea in some cases.  If 
userspace can do a better job than the kernel at picking a device's 
initial configuration, we should stay out of its way.

The trick is to know for which devices -- there may be no general way of 
determining this.  Particularly if it depends on what out-of-tree 
drivers the user has installed.

> > > That is probably not wise in the long run. If the device whose driver
> > > we kick off is a CD-ROM, nobody cares. If it is a network interface,
> > > we'll have to deal with ugly cases like user space already having
> > > sent a DHCP query when we kick the old driver off the interface.
> > 
> > Doesn't the same concern apply every time a network interface goes down?
> 
> It does and that is why spontaneously shutting down network interfaces
> in the kernel is a bad idea.

If the action is carried out by usb_modeswitch, for example, the program 
can be responsible for shutting down the network interface cleanly 
before it does the config change.

Alan Stern

