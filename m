Return-Path: <netdev+bounces-246713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B44EFCF0990
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 05:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130333008EB0
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214C1A0BF1;
	Sun,  4 Jan 2026 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avAeS6me"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFB3A1E7F
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767500432; cv=none; b=Z2Wpli2PzmcAfm3zHfVrAKrxsLSj3YL1SskzdmMJPWGysf2wzZRgiuFbS5zPt3iSINayFt1ooOC5Z+sgzMaLV6frDVMSQW8/VVZ48LcjAgqx6NsdRSVC57M+hh/Ggv+FoVYIJa1I9Uo2nevKrIR19Z/sMovaImIbXTBtvOY3GmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767500432; c=relaxed/simple;
	bh=RX3gMEZcTH67Bxo/eIbLIv9e7iwN2au5qeMMCkY0R1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se7b3He5Jc+sMQjtaiTfPbHakEbXndF5+yWDj32Xp0qUtIc3uYhEPAbjx3R/EsFqWGgZHd6bY3AR1bYFDnpCQNHpTz1Q2ea/H99FAD9K2dDYVq0vQ9zt8eRFSNJhAOT5t1cVTGOGS4NcGjRgjPCpLjXKsZ6uGr0kqnkKcPaQOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avAeS6me; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a09757004cso166444705ad.3
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 20:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767500431; x=1768105231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6nBwJC+SVX6T7+F+sOA/Sheo0DbsbYJTKhwwwCAPJY=;
        b=avAeS6metDABWEv8ODxDqFIal8tMbND8ghJTAYxVtA8Oha0FSVJ7TCHZwtP1jV4KCZ
         MrjLMG8hqTaEgtkbINUIlyMl+RyIfB416w8tomfYOFkwSv4Jk1Ems87lOSBprwNgW/wf
         2e2oeJPcpNHS8dQxyfiv0XeHJgNC6pQlEqPu8h1vdx9YMsLzShHEMMfUDMHryu6ukP5S
         hkWBcKtTjaHvqnlRqqGc4hhXoy4dojspsTcagjWIziOxAPCa0GPhh/gs8xiQ67HEPQT8
         bBQjtz4HaxJgbs3A2AEaYgJvATzl8sVSRdx8C8Aw+ExFl4Jn+hOaWPzhHkMW+VHcvIKd
         C7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767500431; x=1768105231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6nBwJC+SVX6T7+F+sOA/Sheo0DbsbYJTKhwwwCAPJY=;
        b=wD3YJ9O0lzf3wzbHLWsOCFW2RCQBkbB3Tt8jzFVQmzL6udmPTvDiivLzOlmsTE/IEB
         ybJ6tgy2FldyON59fyYXdR+a6T18X1oa0aqtekZtKFVd7l+5akxXVzS3SQ2mr85D2jSc
         GXZwMrhetaXNS30agHxuNbT4nqX9AMBgt8102nCM8G9HqCoN5HarY32OnKXZwlkZKNhj
         aWMJCopN7lJN7RuMh5VgZYDm8bRHP9zXH9QUdwqoRLvwCBFzzt04ZRW+Rwe0ZqYfv6G2
         24EFvNmhk20jyR6l7PN5+IrmsbWfr9XNaW8Tj+jhsvHmJI7DJZujOk8wudjIIjWrzs0C
         iAlA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgy54xfn2ixSUi3ct4wPnwIPpi9vwaETs4OcoDBZCo3/qDUDUzpQjTc+88F4YO3vkaNboz5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpF0b9JvB4wEVLjfj2cIWE1LSbBonv9KapBlPDJSewLZj71Yr
	et8Lo/VeTr+DjdFSMK8Vb3jIq3nKDHQNT99XNI8+Spdbz+tXJPtnsqOj7xmeoQ==
X-Gm-Gg: AY/fxX5s21QkksolqVH5FO12TUgnfU/ZMh/PZSXdTTc6zk9WMIjPkSpMxjU0NJNmieJ
	FjqODh9hhHGP7j0abMchkthr5sAEPCj0N4w5XsKvDL9TPYCtEe4AT3lQgsetMIF1tA5PD1J1ymw
	6MjV8votaGE6rNQFYqIqFDfrx1bb6nLlw6BqYZKolgNuoWk8iviLS4rRjBTKu9tMbEKWsfbf5Lu
	0zKCwAzInh3bZCw9o3dsuBv7emEoXVTjeC2Nukje6Ld8r+R9aLY+Eqy+jDXWOsxk+oGomakZipE
	0m5YnJMYAXqcWaqh+7cx39KVYvefIKueLOAAf0u10akNyf+9Dgd1tPcJ5wL5VjeZtBjT+ZowCQD
	7a6OQ1FUdUAzrO/2O9Se2G9K2nZvQWV/v1+9CnUpvjEOsOpD1Xy17cIjiEyTEk7g9eriRC8y2B5
	bv0St+7f8fywSv+gVfSQ==
X-Google-Smtp-Source: AGHT+IHUpwHvnK3OnnLoHHoXQ9d7hpmZAe1QXYSNjbNO046UtCVgz8pNSLFRxuLq8aY2z5YjJ8K3bg==
X-Received: by 2002:a17:902:e74c:b0:298:5fde:5a93 with SMTP id d9443c01a7336-2a2f2a354c9mr467793295ad.32.1767500430604;
        Sat, 03 Jan 2026 20:20:30 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:cb59:f2a4:2079:8f4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82a9asm418957185ad.30.2026.01.03.20.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 20:20:29 -0800 (PST)
Date: Sat, 3 Jan 2026 20:20:29 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
	jiri@resnulli.us
Subject: Re: [PATCH net v2] net/sched: sch_qfq: Fix NULL deref when
 deactivating inactive aggregate in qfq_reset
Message-ID: <aVnqjRmjOQ4ZtTsB@pop-os.localdomain>
References: <20260102013148.1611988-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102013148.1611988-1-xmei5@asu.edu>

On Thu, Jan 01, 2026 at 06:31:47PM -0700, Xiang Mei wrote:
> `qfq_class->leaf_qdisc->q.qlen > 0` does not imply that the class
> itself is active.
> 
> Two qfq_class objects may point to the same leaf_qdisc. This happens
> when:
> 
> 1. one QFQ qdisc is attached to the dev as the root qdisc, and
> 
> 2. another QFQ qdisc is temporarily referenced (e.g., via qdisc_get()
> / qdisc_put()) and is pending to be destroyed, as in function
> tc_new_tfilter.
> 
> When packets are enqueued through the root QFQ qdisc, the shared
> leaf_qdisc->q.qlen increases. At the same time, the second QFQ
> qdisc triggers qdisc_put and qdisc_destroy: the qdisc enters
> qfq_reset() with its own q->q.qlen == 0, but its class's leaf
> qdisc->q.qlen > 0. Therefore, the qfq_reset would wrongly deactivate
> an inactive aggregate and trigger a null-deref in qfq_deactivate_agg:
> 
...
> Fixes: 0545a3037773 ("pkt_sched: QFQ - quick fair queue scheduler")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Cong Wang <cwang@multikernel.io>

Thanks for the fix.

