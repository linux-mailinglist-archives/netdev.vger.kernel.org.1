Return-Path: <netdev+bounces-95317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFE98C1DD5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41582282C8F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937E15B116;
	Fri, 10 May 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fYKmEbmi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E91527A5
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715320441; cv=none; b=VbKCVr43lzUCEYRBO4e7mriVvgCKyi6MaVcXqd2yHiSZqD9cRrAMoKEfA39FmvuB8iiQQNGCKoGVd/dvj6rbXX6gnQk82fPyoP1P2AMzaxIAapFp16c4EPDd2CLOoer9WeJIBbI6I0/OVXrx//CIvlDamT6XDbSodO2WvRM9bOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715320441; c=relaxed/simple;
	bh=4PEitjlgb+KO6v9/1VnUNw8pVTM6GDPJ4mUKQsGr/KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stZSX9p4Pfby6hN89bDGiXN4foO3F6ehsOxCz8U+GrFl3ukbdMBsjS1nhmlHeMX/M/a8Nd3qfGBHIgSCyZjErY4I8imYKP4z5fhaKcirAAWRdcugXtkew45nmLz6XCDs0WBIxCvMXgBdi4El31v9lnJ/AxjH6RLmoWRFkOe5qMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fYKmEbmi; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E098411FE
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715320436;
	bh=pb53mmGBdA39Om/S6gifWUIT/OZjQtmNrFO1eNmJ+LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=fYKmEbmiIl/QYEl2LM6D8CTePtubMer22wic+ML1cb3nKdSWAAPSsqTcegQxzs2Cb
	 23Or3R2bYzOvyfIIq4Kyq8jNyJMW2RQ4yy9GVSTE8p1rHCxhwUS/cSbwcQ/qT2+LmM
	 6Rsn78P17JPKF95jbyYJdTI0NhUQyQJ9tY1dY/+K5k4xbL6IjfBUCQNjR6nXuleSw9
	 z+f5ZIT/P73b7n2H9mOtfd1thgNM5C7uFqEzhxdT/JkdI1LEGF872CYytRMk2FEUGT
	 NR8uBfplYwGarW2xCPREWbp5/E8jgehgbEkI7fDocz1GVywFYIz/I7gUmP3lvoxsbr
	 kjyx21GoyOYQw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5725fffb621so657336a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 22:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715320435; x=1715925235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb53mmGBdA39Om/S6gifWUIT/OZjQtmNrFO1eNmJ+LA=;
        b=Mc/5QFcO2iH2aEnHTA78wDXmEW03rrNvGKJ0pQFE1QO7jxxAcPm4Nz0GIaTCvTweFp
         5VMadV/D+144gnjDjc6umoVmE2cmy98xN9LlQtU1UNwLZPyH27wVDD4grl5wZWL2vI+W
         K0NF+GU8mYEJgmBRizxKcrQz7H5hXgMaqZPRDRQ/bo26uGwBXnVr7oMgbqmkvFj0AYo2
         vJx9igIvs2ClVLPw/TaSXkTHdckDQJJnsm9axmUJ0b8rz13WlBVJN+EY0VSybnab8B92
         DQ6kg3QYlp4yS7n34M6cmHcly0VE3xKuRn0J52lzaOZrgbXpKtMNquFG/tx4r1H5mmir
         v0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc+D1AsxN9yKcD5P5VZ7da7Ur0OYW85tEde+n5GBAj+OsvcanJvoO6SN0lrE/DjjNELa2zdjbiPQlDmMu9qCCED3QX4KdM
X-Gm-Message-State: AOJu0Yyruf1jz4YuxVX+M4y3g7Yzd5Y6/uGsiEzBGDttknRlqkU60VyP
	gjkNn3FoYclqF0HPtnKkLZfYeIYwNUZlJg1Z4esw8gHqHx8hFhxuZJ8xBv4JdvhoPRxvJZ8Y2mi
	ah0Q6NbR6pB4YgJfcmamy8DKxX0H6XgxvlWuaiFU543WFAYO7Q2lnQUFuzx+VqU6Nnq8GYQ==
X-Received: by 2002:a50:bb05:0:b0:572:5f28:1f25 with SMTP id 4fb4d7f45d1cf-5734d5c1692mr1161712a12.7.1715320435050;
        Thu, 09 May 2024 22:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUERLBxoc5gVqjALyHDp2f85+2hPeKHWBMU3eKKrua9AkiVLI6CvgwDj1X1kdppOmcHMa0VA==
X-Received: by 2002:a50:bb05:0:b0:572:5f28:1f25 with SMTP id 4fb4d7f45d1cf-5734d5c1692mr1161698a12.7.1715320434315;
        Thu, 09 May 2024 22:53:54 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c3229b5sm1436042a12.79.2024.05.09.22.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 22:53:53 -0700 (PDT)
Date: Fri, 10 May 2024 07:53:52 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <Zj22cFnMynv_EF8x@gpd>
References: <Zj0ErxVBE3DYT2Ea@gpd>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <1567252.1715290417@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567252.1715290417@warthog.procyon.org.uk>

On Thu, May 09, 2024 at 10:33:37PM +0100, David Howells wrote:
> Andrea Righi <andrea.righi@canonical.com> wrote:
> 
> > On Thu, Dec 21, 2023 at 01:23:35PM +0000, David Howells wrote:
> > > Use netfslib's read and write iteration helpers, allowing netfslib to take
> > > over the management of the page cache for 9p files and to manage local disk
> > > caching.  In particular, this eliminates write_begin, write_end, writepage
> > > and all mentions of struct page and struct folio from 9p.
> > > 
> > > Note that netfslib now offers the possibility of write-through caching if
> > > that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> > > v9inode->netfs.flags in v9fs_set_netfs_context().
> > > 
> > > Note also this is untested as I can't get ganesha.nfsd to correctly parse
> > > the config to turn on 9p support.
> > 
> > It looks like this patch has introduced a regression with autopkgtest,
> > see: https://bugs.launchpad.net/bugs/2056461
> > 
> > I haven't looked at the details yet, I just did some bisecting and
> > apparently reverting this one seems to fix the problem.
> > 
> > Let me know if you want me to test something in particular or if you
> > already have a potential fix. Otherwise I'll take a look.
> 
> Do you have a reproducer?
> 
> I'll be at LSF next week, so if I can't fix it tomorrow, I won't be able to
> poke at it until after that.
> 
> David

The only reproducer that I have at the moment is the autopkgtest command
mentioned in the bug, that is a bit convoluted, I'll try to see if I can
better isolate the problem and find a simpler reproducer, but I'll also
be travelling next week to a Canonical event.

At the moment I'll temporarily revert the commit (that seems to prevent
the issue from happening) and I'll keep you posted if I find something.

Thanks,
-Andrea

