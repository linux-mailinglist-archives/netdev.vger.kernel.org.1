Return-Path: <netdev+bounces-98697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948C8D21CA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2291C22C73
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05855172BCE;
	Tue, 28 May 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dgPbYLq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5817106A
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914418; cv=none; b=KGd6UesgVpWCHVrNYd5jnxtuw9+3DV7S7+CnAIvyleJpvFqAgURNKABM0N1kBMYGOylsv5hqxpvAm6bQnAjZpir3iMTDK+mJ0YN8X5tr8FdRyYuToouCWwhxDaBUUq1RWiwp2/pmnTj4jiGG7lEeT1NNK+pTMO7BJ8SCXJmdSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914418; c=relaxed/simple;
	bh=GhRez4Fx0Z0cdleXvJ6KlvooAZU3mXVtsJ2Oxo6UkJ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN8kgHM0BXtYzN4rLj8SM0adqN9uNATMi4AHwYynCmVvPfSqVUNV+c1lHINKUdwVaXNJCEwQMSNDYjP+r33NTc5f2g1jndOTckXRb1w7W5LVXEiSQAYtmlkuRzr6/M5kpSNy/1ymvqqjTH7GJs1szLN2KasrlGHaY3TOJALAZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dgPbYLq1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4202ca70270so12072685e9.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716914415; x=1717519215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+bE3y23Y2jc/sZ470W5Ehr4+nLRjpDlijTRzceXpdw=;
        b=dgPbYLq1OryBxByTEdk0sqznQOsBsd0eIDmd68uTGSYJXEv0thY5vM4mQql4nUEZJR
         vO4mGy9VWUszHRwwZFOSePvh/PEv6U5DqixX79HIVxVH5s0EFn87VxDoj+tjEThI0aGl
         UQsQ7YPLzF/PsNTBIi5YzCtZSFu/aAzJ/7leBoiKG1sfT2wa5w73qX/4xD/WTP1f6xFv
         TKT0C9OgiBSTWs8nS3njwxRtYtFM+722Ehi/Cb4sE/Bu9yTLTQyW0qz3ZWCFdmXxbdPa
         UYE2DrRVoBjIva1VMCPb0GJvcWYqhX1ecM83R7nqeWXX4br3e4qbWZkED5QhUk8CJVQn
         yyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914415; x=1717519215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+bE3y23Y2jc/sZ470W5Ehr4+nLRjpDlijTRzceXpdw=;
        b=KMKkDgq0WAQNuHTWTL3NLPTU44kiAqmBtFG8IWnab1b0Xpc0PQdBgMFbluyPrpXjSY
         4udQOI8sBBi0bwka5UnsgN8jTi+LtQo4i0xci+PV6OaWWtrl1zlUmNEOd1r5x8mZD/7r
         WzeJQNhyoDmfH6iEX1sfxNqLf/1A9oCiTVMmWL8/SnBlKaJZuR9yNrcdiJpgMZ9JczER
         XPSivPtJJvuY+wWETHahrvIGepH3G2LeqzKGMvFxPT1XzeLpu9DsRNKjaMmaBuKooXp8
         QpRRDgTFbdMPbEJwXxRXnsiyBHMZSGqzK1i4749ku3Yx4tPfnD2Lbccf6H9wPPajqFC/
         v1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU09kv38cZYPVxEo1ADrvjCw9f0LR+ipOztT9oWiIBSLSbDPbK6ExNDNgoAxeoa+H+VBwM8JCgtaGanF3VB7tksHmpMXFve
X-Gm-Message-State: AOJu0Yx7rtJryM1S1GD9SKMMc14wMVIKKlVj5TXf/JNRjqr6LgNuOVWt
	0gavXdWbJx74RWti8zsZJHh8BfjZMfODBkwWQln1514f7lwi28mNiT5aby+7FB0=
X-Google-Smtp-Source: AGHT+IGzWjnSFkB1ANBs2PNdU87HLzoQjdhoU8WSS6pgUppme/s6M+LhP97xyCLiBusTlbckGHkTMA==
X-Received: by 2002:a05:600c:4f96:b0:421:10ce:8aff with SMTP id 5b1f17b1804b1-42110ce8bf2mr86779085e9.19.1716914415293;
        Tue, 28 May 2024 09:40:15 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089667fbsm148191035e9.9.2024.05.28.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:40:14 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 18:40:12 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlYI7BjSgxOy7dbg@localhost.localdomain>
References: <ZlXAFvEdT96k5iAQ@localhost.localdomain>
 <0000000000007cc41d0619857dd4@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007cc41d0619857dd4@google.com>

On Tue, May 28, 2024 at 08:43:06AM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> mm/hugetlb.c:5772:51: error: expected ';' at end of declaration
> mm/hugetlb.c:5782:4: error: expected expression

Heh, silly me, I should have compile-tested, but was confident.
Anyway, now pushed a fixed version.
 

-- 
Oscar Salvador
SUSE Labs

