Return-Path: <netdev+bounces-95008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097BD8C13A1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A9128236C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39319C8E2;
	Thu,  9 May 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jfTDpJk9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D410A3C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274942; cv=none; b=X+u9XNS3ep/KyEf6ibaKCbZKaEuUBVpGnlLqqDOTs/B9DQfZatcxrh7M+6+SjplW+OdYYbmKTEbDCKs/VMNOakMBPH6RICWMs0sZ5uJoBjENuZSRYt30hvLKQmHUx670L6BsDc2T1KAGhZwbJz+xOo/OrW4+C1BAv3hsTX4ieVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274942; c=relaxed/simple;
	bh=I2b3mZDphqAOw1CzA9XXn8owOPYBXLxuDEHOZbykNDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkEStgweQ6Sm3WIMuaNETC7ISxrC4dtT5XXoxKyBOItBiBvMvMPELvSjw2+nnrNAB1oJFECQKLquuZFF69YhGC0AfHL6HJTpjM/WnB51d7I0IDA3OUyPUyjI3xjt/lu2Baq/oOX8TiMZq/LztiggK10ASN7Lq6Ax+AiB5kbsl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jfTDpJk9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 67FB5411F7
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715274931;
	bh=R13CNUyH1MbzjMY2CalRPAAS/uvh6wjQHgeABBOaJzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jfTDpJk9q6zsy8oZFwZ7HCMxbqbfLjcGbav/51M9Fm4+eTXRvos2ySsnq89ZXrNNS
	 1VcvnR7ZJHGaPw5gzygz5GDjkk5zkh4S6a+KiD+kc2SBSk5SAwd+l3mQXIF8iWDoJT
	 L2PrVEzpj9gjSd4ECS9md71qGtQzzKP+56ndq3PP6iEzNKo55xMwdwpa1EFespM9ni
	 UfBGS8uzTTJ00eCdW7Jc8j94605ezTLe6iCY10QGNheCFNZbpSHXRN1Oj5OK1Fzall
	 B+orPH+7QPrJEHyMQbg1cBVzykUyFmo5wl79+wpABZ6dwjVE9+y0U9WJrvLxI5FagB
	 aekqH4pn1IjYQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51fdbd06c8so76392766b.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715274931; x=1715879731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R13CNUyH1MbzjMY2CalRPAAS/uvh6wjQHgeABBOaJzE=;
        b=rhWFc+KVXX9OXBLEtwuDXOYlmtlI4W18odkT0PimINkh8zlwJq7FYcK0vE/BR4mild
         sA81ZxcLuLWMbZm/HGD8ljoj9oLa5OCcbn3CiGV+SR0KYWZOaTAM1GTDQpxwZS5dw2xp
         skcfqUGi/jIZD3DU/qELo9hvxny6haMiXJFPA46AWi9OFHy6vVjNhBRrCfkE+aMGWiDE
         n3HV0yj4VkWINn2cKq3Un3X9+FMSueCgqpwHnR5HDTfSS9ka2IPoicjYAPZrp7kv8dTX
         ei2vcl7UKXOSKR/ct4t/VfI6EURmTPrhZ17tYErE6/c3b9T1ipriry6GvvWOBcvFK8yl
         YgUw==
X-Forwarded-Encrypted: i=1; AJvYcCWoHg1bS1Sl8WbBQLbNWSDhH4Y3MQHqVigVZnvXhVANUjWcCLJ7G4uKTqjJVnu9JKhxDBR//BjIr66Fz/yILl8F+iojb5qx
X-Gm-Message-State: AOJu0Yy6TQUIRE6jkIeQnoylL69Q66XB6METFs3CYR3AI7DX5j7L3lPL
	6eCWldCLR0FlzQxDn7JMqDbBI1Duo4dvbh2LA0/1QgfydT8exta9SMNjxI5jfUmDFs6PYK2aye9
	y29Dn+7+C3+NbYbKpsJJnwJvoGJFOtNG6BAk5mHFyPAZ5Cs7XIgklloEPqkb8VC4jAdfu5w==
X-Received: by 2002:a17:906:3849:b0:a59:b02a:90dc with SMTP id a640c23a62f3a-a5a2d66ac03mr15003266b.54.1715274930670;
        Thu, 09 May 2024 10:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRId3ZK7jZnEUqxnKrbYMBDrOXsoSZ6C8TgHiChCG3zHZRXUk/mhnLLXZdmjv+NVtyVoseaw==
X-Received: by 2002:a17:906:3849:b0:a59:b02a:90dc with SMTP id a640c23a62f3a-a5a2d66ac03mr15001366b.54.1715274929765;
        Thu, 09 May 2024 10:15:29 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm93194566b.129.2024.05.09.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:15:29 -0700 (PDT)
Date: Thu, 9 May 2024 19:15:27 +0200
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
Message-ID: <Zj0ErxVBE3DYT2Ea@gpd>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221132400.1601991-41-dhowells@redhat.com>

On Thu, Dec 21, 2023 at 01:23:35PM +0000, David Howells wrote:
> Use netfslib's read and write iteration helpers, allowing netfslib to take
> over the management of the page cache for 9p files and to manage local disk
> caching.  In particular, this eliminates write_begin, write_end, writepage
> and all mentions of struct page and struct folio from 9p.
> 
> Note that netfslib now offers the possibility of write-through caching if
> that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> v9inode->netfs.flags in v9fs_set_netfs_context().
> 
> Note also this is untested as I can't get ganesha.nfsd to correctly parse
> the config to turn on 9p support.

It looks like this patch has introduced a regression with autopkgtest,
see: https://bugs.launchpad.net/bugs/2056461

I haven't looked at the details yet, I just did some bisecting and
apparently reverting this one seems to fix the problem.

Let me know if you want me to test something in particular or if you
already have a potential fix. Otherwise I'll take a look.

Thanks,
-Andrea

