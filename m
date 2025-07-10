Return-Path: <netdev+bounces-205938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54444B00DBE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABA464577A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84472FE31A;
	Thu, 10 Jul 2025 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp1FuqKq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384A23506E
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182948; cv=none; b=DOuwwN6kcS0pqDZt6SDF+STw/RROEUg7VGGdJRfKgV48CQ3Gq5oJRVGLUwiHVfNElo7dreY0pJEz1Wi72tnlwNCnQadtL9DALGlZVui2KSmFJn20fwTBdfKATf71RBuSzBQNn+Hhyu49wJEsxmsfd7MAK2rYmTODS5jNyjvk644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182948; c=relaxed/simple;
	bh=+u0Sf+6dzXDz1Hms/Q6cDVh4m4w2yVh1bevZG8JaA5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhyCZuhel98Gd/UHW4NFuJL9Uwa4LeBWpEwoR1+QR9G+eStg4wPYOC9vYNDBIFry32ndwt24C58cu6LVModjl40IApyQ4NWlr86lv7BpujiQ/TKSD+9/ibq6vN7oW00oIrgB+5oS7t9rUuiGs1fctZGmUHgD3Ahv8A8nltaxL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp1FuqKq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso1663375b3a.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752182946; x=1752787746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpDJpyCiiZ90jTUDrcwe8h14+Lp264EARROBydownq0=;
        b=kp1FuqKq9W6v9ytpn6dV68e93msuLTaYbxNuSCkGe1lRhvQ1EwbMDnbGAAJ4AinepV
         AAIN2vEDJPhTIGs9AF+n4uSO6zUTdpyIgvyyYYuNYTYtZtwym73T10fQu+/63aHDG/M2
         y0qRsLqOp/T82Mbe7o2ejchXQRS9D5hdkTDFTe9gass+ziX4wwvi/irzD0WLBDHSgpfF
         3lpwX77ak6iOxL1UDDpQvJUbwOugAoqcrKwaCg55/9+vutzkSNgDanDXhV3i9cXS+mHv
         vmBzNfuC+CQ9ON+oiPLjlTJkYcMzAwPrxlQ6ky0FphBQeGPoROphF3JqN4BNTxio6U0z
         9hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752182946; x=1752787746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpDJpyCiiZ90jTUDrcwe8h14+Lp264EARROBydownq0=;
        b=KAJ38/4RDXvBK5utCQ0nUm4vMy7MLulEh70Ilc3b44ATvcNHZCXDaROqdIqcja1cw7
         u30GZep700qJed1WfqQuyfSEMDh1hMXyrOARLBEocT64FCbCEFKrWAk0ECfTSEDrmmeg
         VYiCuKqGgVtVpmtahnfz7pgliU3YQlxAJGJ4ScJPJmDqngs3r46mr4p95sYX0lS0Kr5+
         ioQDHjDJPBIwiBEvYOJLqWwyJsrp5P9HD6chgp7+cnTpHDpIr5iXlulrd/f1u/lBNgHa
         k4eODhxtykWBgKIX0Ht1I2dfKgK4pDpLzBT2J1gAr9JQBx6sxLcIqiWxt9Frhe6HC9ZR
         dHKA==
X-Gm-Message-State: AOJu0YzGIsRI1809rgWiIbn4sEMTqGob6cDQ1A8lArw+HNU0eS4o8uRH
	8KaGZdWl+58Ko01d2ChHPtXMGIw08y79wIUMRqUXVXilAF/809XRZKIw
X-Gm-Gg: ASbGncsYqXvdni/9WX+OrwKTPxDxhsvNzbx3zbOPfbohsSoCoADuDSWMUChzHKMmOVw
	T6PvAwMezQTKVBBWE0jlvrS+97hgymlw9PAdAN8mUIddkVKTD4QxYitIH6tnpEjiac++4eiUbLg
	uCmsKrCwfS4/L2UrMJBWMzDZmQFPDe67EfGve8u+mJcEST9RWWWiCdVyT86ZeAfJIgGFRhDftm8
	jp7ogwU9x8C5XBKRg8kpkFcNBS49mV2tWtlXAlYFCrDEHu1LiH6lQ97eKZoH/76VHvgY4jPLkjj
	5jLda0NLSNtDyB9NdfI1hzQN6Fl+3X8UPOELco2PkPT9GcghLvogQTR5EzEiCaSxRQ==
X-Google-Smtp-Source: AGHT+IHdl5dkwBKE3rn9rMU2SJLCsH/cRxgkqup65SEnwM65ZZN4PdHrIw54U0dYk+98zmzHUg9jOg==
X-Received: by 2002:a05:6a00:39aa:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-74ee3437398mr764974b3a.21.1752182946400;
        Thu, 10 Jul 2025 14:29:06 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d337sm2972361b3a.73.2025.07.10.14.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:29:05 -0700 (PDT)
Date: Thu, 10 Jul 2025 14:29:04 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHAwoPHQQJvxSiNB@pop-os.localdomain>
References: <20250710100942.1274194-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710100942.1274194-1-xmei5@asu.edu>

On Thu, Jul 10, 2025 at 03:09:42AM -0700, Xiang Mei wrote:
> A race condition can occur when 'agg' is modified in qfq_change_agg
> (called during qfq_enqueue) while other threads access it
> concurrently. For example, qfq_dump_class may trigger a NULL
> dereference, and qfq_delete_class may cause a use-after-free.
> 
> This patch addresses the issue by:
> 
> 1. Moved qfq_destroy_class into the critical section.
> 
> 2. Added sch_tree_lock protection to qfq_dump_class and
> qfq_dump_class_stats.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

I am looking forward to your net-next patch to make it towards RCU. :)

Thanks.

