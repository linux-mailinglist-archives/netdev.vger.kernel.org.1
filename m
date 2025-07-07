Return-Path: <netdev+bounces-204659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15884AFBA54
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F96E4238D2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E06262FDC;
	Mon,  7 Jul 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciG85D93"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD11264616
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911434; cv=none; b=g4wEBmdoYtyrNBmOQ3dDu5S0uT844ia9+zvgKrNI44tZ9wNRX190EacJKelhwSDNws1+XjDLBAcam9D8aBtxxQSHINqpqjo+GX2De6EqdHrllPy/DAgb6aAmCjYKhQI9HVsBBB3qnpMKXfqe9AwoOb87s90OJvfH5AXvlvNixMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911434; c=relaxed/simple;
	bh=qLmpGUd91FEXmPJz6AHPFUTG/m9+3BmrWgn39stKJO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8580wpiLqBa4lY5e+WgIFLdXjGzzuXvEjC6Yq2S4Nb9hOaZ/bafJL4b8dr/UzDd5XqJcgg1vFCc4RgzkmmJkHh0EMvxJ49/QLmMCPw4HDp0iRRKmmfz38NBXtIGW2T4bK4KJB69B7FtHrgeDeT62L5TVftCHRXrN5WojlfGdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciG85D93; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748e63d4b05so1829957b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751911432; x=1752516232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RBpfeSaXGmMxOYas64pNMIZBpkQhHhPA5zESBqdOs0=;
        b=ciG85D93V42HvPe5ZPFAjrgvf38Yyfq32HGNpTSf+xDOlBCa24nIsjWBckQvtbEiao
         69ImFXfY5N3f2WB6waxVT51vWdWXQs/xvA+ay4ZM76XT8GyV0PDTxWBJWKZHln6wRldo
         QQq2z/hSOZF24YoIFRjKCDCq4HUmGkG5kNcTCOQHvTPd6VBiHFryvg3rFQSbtCpXnBoY
         maSCyk6GjV8ePe2hBP1HbBCwCrxZgGD2YnLC8gSIh4BkJ7PSgNqScQ6qe2RwmVBTbXNE
         XPbroTHKiPd7L3lP3tVuTA/c5rolOgVrfbQH8z7ImH6l4aEgbZ6H0tsv6dxQ1cZmsInt
         sBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911432; x=1752516232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RBpfeSaXGmMxOYas64pNMIZBpkQhHhPA5zESBqdOs0=;
        b=WN5fbYiDld5oIeryhqVdg0LO/RaJY+/APQW4MwhL59OUsog9qPbYyTRztldq7noDCb
         DeX9a9CHT+ri4aXaG+AYyjuiumGwAAsPIkBDfy/BFwXmvbv3GENQBZ2A/4Ww1XPBGffb
         cWPwOK1PtLFapRCiUt/4FB1JQ5iyzAV0tKFNgKo48JhvsODTgnxhQfLuCZXXyN3HeAyQ
         6rwS8S7XtJvr18fybfaburHpQlqjGb2WKy4a8cvzpag+3C19yvPNJkK56HL6R8Bp6tuw
         Dy/eZYNOxt/NjINW7qMrR0aOx7LHdQHYUazQ8fAOmskmtL+7pXZz37HpU5c+/a1z0wmC
         NtBQ==
X-Gm-Message-State: AOJu0YwXTcFGWkDFcRoIw26BGyT20s72qRp+7aP9SFfXYx5FyM9igiRU
	uuXJcu63Iz3CSCIhaPNMtmCU1xKX0Kw5iVQd+1ZleNiPKYPP2fxfEkGF
X-Gm-Gg: ASbGncvKpy6nK+omI/AuftMw3GXGDPQfSPd8hOzKhFJquiP7BATLjKbr5wbd2YpjD2K
	JdnlrI9El17GRDgokHWafH/GYOB3VDOY6XmmfnUrBz9ff/z3q+gCq7YRJxmqquZk0qL4foW6tQ4
	IkHas4fpGaJcVT0HgW8QBbI0vt0xOFRHhbzXPYu1ICQhAFFWHd8WyC7YfvnqMxhcApIQZFdBfOv
	QCKiZPPIONZGas55ILuX+mFne0x7K09VVzB+NsT5AZm+c9uBM/yqfXxXWWMVhMy1Z0N+yY7NET6
	4XzaKj3wCBYnCOrTLJozuNPhhp/kMzKGryW8Yivl323vmNxKPbuydKOoREIXygXXzg==
X-Google-Smtp-Source: AGHT+IG32rdpmbIs4tS4DUHkB/+UX8oOZeieMcWR+UE+sYeCY4mIxZa9WImG2a7LdkfSf8n/CHvrNw==
X-Received: by 2002:a05:6a00:2389:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-74ce880fef2mr16839204b3a.4.1751911431695;
        Mon, 07 Jul 2025 11:03:51 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d4f34sm9643388b3a.164.2025.07.07.11.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:03:51 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:03:50 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aGwMBj5BBRuITOlA@pop-os.localdomain>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
 <20250705223958.4079242-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705223958.4079242-1-xmei5@asu.edu>

On Sat, Jul 05, 2025 at 03:39:58PM -0700, Xiang Mei wrote:
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
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Although holding sch_tree_lock() for control path is generally not
elegant, this is clearly not your fault, the current code is already so.
Converting to RCU requires more efforts, so it should be deferred to
long term (net-next).

So as a bug fix, this patch is okay.

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

(I assume you tested it with all tdc selftests.)

Thanks!

