Return-Path: <netdev+bounces-275006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKmBENKqz2kPzAYAu9opvQ
	(envelope-from <netdev+bounces-275006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:56:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F454393D50
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC30D3011F26
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9183BD22D;
	Fri,  3 Apr 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC2Jp9pn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZ06MBsC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA783BC670
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217295; cv=none; b=SY6B7BBPwfUz7XHuZze5JHhuQ1njinbDAcq4dBddbMW8eX82zOntKpMyRdzfCCBy0VCX91MknB5h819r37wqTR8sHQX/3ZpdpxJbZsmyZAkKCDf6xWXnnzU6VBXujzH8ePn7DiouiDtl/aM1Bnhfh5QdfCWwkbUOxKPielyeYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217295; c=relaxed/simple;
	bh=9nv3rHylIcejR0LY+UFbQCkM/FJMlEN4udaemkrS4Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWPnk4w0lsYGC5qxH8OVutFEGfCTXenxp/542f/pv9Pw9b+6hEXWu1Qi95G23BDGaqk/GUEZJ4xb713jhXv9Gv8hDlxYFQDEZZbs4FG1DwwwE5ZqOHAF6r0/ug6PdlmazWvH6qu5HxraKVw+Zlf6lCtuFbuiBVGoc6VVjHwdrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC2Jp9pn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZ06MBsC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775217293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nv3rHylIcejR0LY+UFbQCkM/FJMlEN4udaemkrS4Cc=;
	b=jC2Jp9pnYZQN2cxZxpRkKhaGrZUFFyF2SFDEtfedQ0uuBjSYuscS5tn7MMlGUjDcx5+NQ+
	vZoUNbCJE9jVlnrtTkJRoGdkn3lIasCn/ZHjBSmOlkeKLOTmCv/la7jG/q4USQDGY2GDeX
	C2RkmmaWzWoCIjvdPjUw5v4Boq1g074=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-4072BK21N4-y55DSQtGtdQ-1; Fri, 03 Apr 2026 07:54:51 -0400
X-MC-Unique: 4072BK21N4-y55DSQtGtdQ-1
X-Mimecast-MFC-AGG-ID: 4072BK21N4-y55DSQtGtdQ_1775217291
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so21533845e9.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775217291; x=1775822091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nv3rHylIcejR0LY+UFbQCkM/FJMlEN4udaemkrS4Cc=;
        b=WZ06MBsCCjW20m0ZmZWT+To7Pp+xc+fTDuWbR9sTYn+e4A6YI4g/zzL2BO0KrD6kCo
         QvUqVrsEux3M4puy96tq20j11kiQdr/e+1zwk7zZSf5gZWTXFWD7DieXV6EoVQ3NM3wQ
         sPkNAGaNeXdXzJEhcsUurTpa1OA8OOyUl3Q9zfgTLlBPINWch3jYkvlBY9Nh7BkxD7MR
         KisfaY1cBACUnv6yR850vQNpKOjEWOZTKwFkLjwm4lpRsRPtShdGdfK+U++vlpnKXMAU
         kWD04QZCIDZ0o7VN0YrKL2QQxgmf+3Gre7xJ4POZ4MNED7s58Ni5F1Q+5oVJ1JhUXyk5
         qFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775217291; x=1775822091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nv3rHylIcejR0LY+UFbQCkM/FJMlEN4udaemkrS4Cc=;
        b=XG8GtYEYi7BN4yrTpnSgG4BeaSh3c8t18th06VwAL4niwDRAI/9zSva4Mvq11McRfC
         JCA96kIxsh16P7rspj+71Lfih7xs+YgTbXdj2wF2wWYFpY4oqwn+fYNV5EXuZGqVJXsz
         5104J4nM1KO+pqsVoJavn5J/P5QwTqODwA0nBSRCJ725um9GzG5J/pIOOAol79tfPGaI
         uI3krVVCPSX5dQp7xt1FDBbbooFdjTgKitLXlaJ28tlq2jz8ZoTBmIN8ExSku3L1HMBn
         pF08bd0WRcI3TlMxjDUQtagm3IEhuI+iqtXRyhV+Wj1pPIS22+Jw62gZI7zwWCRlgKou
         R70A==
X-Forwarded-Encrypted: i=1; AJvYcCWm0N91EWhfF2nXT9AB5geZiZiZ8QoWZkHSjdAAykSzLEvGy1zOMrOYmiYMWF1EnykmkAtE+Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgqLRGJohDXLgp8L21guLdrnzMd1/ckBB3K5cJ8Pq5Vtmgt71
	U6o0lydQFkm35xjjw9/xCkcocOLcrh9I5cf066+nHNL+zk5TFRSfF2h3RsdaK0Ic/+eU65vkt7Q
	GdeAb8WmXIspW3Zavau0+fhSI0xQ0dWdlEBX44lYTFn32d2KCUtTTXrzOPg==
X-Gm-Gg: ATEYQzwh0woH1ewkwDunOWg/1ysmUswufV2K5Gv6ZZSXjMjs+sjFpEPbdQON1/+TaEa
	KPe3XeA5XP70PXdcUPctdkGtj0bSIfia5YHpKeCwht8XKDFkBGQ1fH2zRMWE5JxGkhP3WDDnarn
	G2EptSVjaLzRWWmNoLKg0Brf8op1vNDWEEjWUcchOyz87JTEsdinXuApCYfWmJitZbAVgKhLbY+
	V/PmWLf1hHQal1/Ns10xV7i81TbsZsCnlHNaUMPIDetZwLS7/Quqd3aGsI+b6WhhmF8Hrt/5R3O
	9YSQgX8YdSAZNBT72KPfAFAJplkGeaz5zVvdsmhkSy+B69WBUikfjT2/rj/TDlJPuphhnb8jHUT
	EWAOF/EaLrDpKSXHaY14js+wnA1+t81G9HO+W53TTurgrCZOGKEV7aewV9Q78diAZrqNr1A3Tg1
	ST
X-Received: by 2002:a05:600c:4447:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-48899785c7bmr44502725e9.17.1775217290578;
        Fri, 03 Apr 2026 04:54:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4447:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-48899785c7bmr44502235e9.17.1775217290029;
        Fri, 03 Apr 2026 04:54:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm279873525e9.7.2026.04.03.04.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:54:49 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:54:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2] vsock: avoid timeout for non-blocking
 accept() with empty backlog
Message-ID: <ac-qD9dQU_JB9VvY@sgarzare-redhat>
References: <20260402204918.130395-1-laurencerowe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260402204918.130395-1-laurencerowe@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F454393D50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:49:18PM -0700, Laurence Rowe wrote:
>A common pattern in epoll network servers is to eagerly accept all
>pending connections from the non-blocking listening socket after
>epoll_wait indicates the socket is ready by calling accept in a loop
>until EAGAIN is returned indicating that the backlog is empty.
>
>Scheduling a timeout for a non-blocking accept with an empty backlog
>meant AF_VSOCK sockets used by epoll network servers incurred hundreds
>of microseconds of additional latency per accept loop compared to
>AF_INET or AF_UNIX sockets.
>
>Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
>Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>
>Patch v2 with feedback from Stefano Garzarella and Bobby Eshleman:
>
>- Move prepare_to_wait before release_sock to match previous behaviour.
>
>- Simplify not connected case.

Thanks for addressing them, now LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


