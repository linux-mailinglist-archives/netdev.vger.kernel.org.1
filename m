Return-Path: <netdev+bounces-200501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F19BAE5B8D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC82F3AEB1B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B19226D03;
	Tue, 24 Jun 2025 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsnGW//N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674002253EE
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750740112; cv=none; b=k7buKFFz+GFc5QMQNxDUFIBzyVoiqhS61CNUPXKRdWAtPBTpFeyGfhdJ8QzupQBRD2nYHlksu1kCE5Su23RBsAYeg4TwdVk2OTWJXeBR+D85flOW04XmbqPy+MRingDGWkLoHQA6Og62C3HholtQN62/9Z25+Dl0kQgehUjAtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750740112; c=relaxed/simple;
	bh=Jok0JTAqa2a6Wsr3Yk3fD30Mc445sxysbjQvpzzEvpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l00dir3yxSERwcpyZkJDCa9VWgVy3EUXYJzXfP+n4dCURQfv1ViYbYIA6+94neJvHw9B8mB/5TL9Z7ueTfC7oShhO2P9fBEOWJBp+qgF+maOBT8nKNIkI25TNMX+AH4dD2Dv5J2yzkAidZ/QduphR1mcU3W+DkMkXu5Bqa5xupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsnGW//N; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86cf9f46b06so159174639f.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 21:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750740110; x=1751344910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzMJS2X1n/0wJyKWZIHzZuia2PzfbXvXRqUpceWdQdQ=;
        b=UsnGW//N2lf+B3rjSFNFs7Ah6IsYLVkeSc8wdJ2kR5AC4snFbZ2ASvAT5ptCZyA6ZI
         Lb2Ys6D0Urj1IXcJXeLY9ecq7r04JSr4m9bSNoZdIvDjarCjXVduugIExYlcffNJi9oi
         u8B7TQj/RENm4Rz0fEyekdjpxM09omfq9/8Ry4YYZ0hsxqGP4JCVPPb84dTQqv2jpY5G
         GOtrRfPkH9UcpD0E4feKzDhJ23Gj5P15IOtXC/shebJArvOs7FdbzCt7oy6JxXRTpsTi
         zEWKzYipPG591x1QDVjF0KwZA11l8FQEO3/tgcKbLVgksK5uhhKg6hLEURt8leUuL1av
         0M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750740110; x=1751344910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzMJS2X1n/0wJyKWZIHzZuia2PzfbXvXRqUpceWdQdQ=;
        b=VjxGxME4d2EEQbc3yW4dTOYvcsID5/vd5eGiTZ6J6qqjKSO1L5rQ2JMkh8U4y2+PUa
         cgmoNAMGpujBT+u2MI+cg5/wTtrE0dc7eJ++mmrKkoWIhFR3XUYeAgTSc/aLCAWaDQqV
         s78H8RSGQYpTEjb9Cxsl1mrhDsiXR1ZXu+PJ/z32UjdygKCiYihJJk7FhALo/VJDrdwR
         hICFWKSyXdjHlsuoykodynv4I3w0nOROwQJIxR/4gFH1FUvGcyLsMVZB/hDvCaFVz/vp
         yWaX0fYMw8ab8ft7feomidyhToPFgn1QYEzUgQdg82/vhk228LVEusrhkt9TyC/oMtal
         DAvA==
X-Gm-Message-State: AOJu0Yy9mmeun5KAud1hHZtaf9ljk/rIu9wSYXigARXqgzUgluM/IBJ/
	kidRYR+SQgDGzl+ICWysQFFmoFzo2gfRQuIjGZkaVny1iN9Ext6926aWwStSBUft
X-Gm-Gg: ASbGncuzUi6c9+tCB5OoVRP2b5mZBNdhszKJPthkapmymRLFQ1cZeCywn0B/prU7Rq5
	gSmsNnjfNUBRPpTuSwogtXKcUmSb7CYaDJ6QuHP+WY3mKBdv1CgXf9MLC3B9dIok9KZ2g17J89W
	yy4qIthLCYrOcwhtvCMrSTx1bj4Putmy8nvm2RUq56cfpw8AgtGJYI3n5DkA9ayQOZQ7NaNzKg6
	YVCg4vp/Zrqh0pMY/m3YQwsBzSJLZGcLZ2pKHxB0sGklLxAloEMJEWpKELgEcWxifmttbsg6HP6
	UhlsT1PsVkZEwBxp9NHrkrWBpABCEnnZtYO9Wity2j0an3a2/L7Z4S0o9+iPdeP6
X-Google-Smtp-Source: AGHT+IGhVExySJ21bPEYM+/ONbZloTHE6Wez6zUD391NuRjzp4W+EQnYE9I8bEoEchx50GAvH8yWlg==
X-Received: by 2002:a05:6e02:3b07:b0:3dd:d995:5a97 with SMTP id e9e14a558f8ab-3de38c987camr172408595ab.12.1750740110331;
        Mon, 23 Jun 2025 21:41:50 -0700 (PDT)
Received: from localhost ([65.117.37.195])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5019df16634sm2097950173.60.2025.06.23.21.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 21:41:49 -0700 (PDT)
Date: Mon, 23 Jun 2025 21:41:48 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
Message-ID: <aFosjBOUlOr0TKsd@pop-os.localdomain>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>

On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
> Hello,
> 
> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
> incomplete:
>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong@gmail.com/
> 
> This patch also included a test which landed:
>     selftests/tc-testing: Add an HFSC qlen accounting test
> 
> Basically running the included test case on a sanitizer kernel or with
> slub_debug=P will directly reveal the UAF:

Interesting, I have SLUB debugging enabled in my kernel config too:

CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_RCU_DEBUG=y

But I didn't catch this bug.
 
> To be completely honest I do not quite understand the rationale behind the
> original patch. The problem is that the backlog corruption propagates to
> the parent _before_ parent is even expecting any backlog updates.
> Looking at f.e. DRR: Child is only made active _after_ the enqueue completes.
> Because HFSC is messing with the backlog before the enqueue completed, 
> DRR will simply make the class active even though it should have already
> removed the class from the active list due to qdisc_tree_backlog_flush.
> This leaves the stale class in the active list and causes the UAF.
> 
> Looking at other qdiscs the way DRR handles child enqueues seems to resemble
> the common case. HFSC calling dequeue in the enqueue handler violates
> expectations. In order to fix this either HFSC has to stop using dequeue or
> all classful qdiscs have to be updated to catch this corner case where
> child qlen was zero even though the enqueue succeeded. Alternatively HFSC
> could signal enqueue failure if it sees child dequeue dropping packets to
> zero? I am not sure how this all plays out with the re-entrant case of
> netem though.

I think this may be the same bug report from Mingi in the security
mailing list. I will take a deep look after I go back from Open Source
Summit this week. (But you are still very welcome to work on it by
yourself, just let me know.)

Thanks!

