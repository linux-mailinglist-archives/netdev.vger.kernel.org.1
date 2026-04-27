Return-Path: <netdev+bounces-281404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOs4NnaQ72nRCwEAu9opvQ
	(envelope-from <netdev+bounces-281404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:36:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4BD4767E7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2FF305FFF9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF78535AC1E;
	Mon, 27 Apr 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Teq2YLct";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXBM4sKF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DA352F85
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306749; cv=none; b=fojrMKdCmBgW7togG49Sx7sWL1g6DcZbE53SGyL8yihGZGsy5TVwb8ssyNassLWjYitCWTAaLaHh3N28EW9RcSKBDbdBpExQplw8ifCiqGfzP1XCcVqAdDKj82FcNPhzSYUs/SIblAsbaeLIGQHBLImWWpMd/244q3LfpwdsJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306749; c=relaxed/simple;
	bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAdb00CZVnVcZd9NqwVMOo32mQSTVXq7zQxZEmLUugqR2n18fqyUy2q2zExxIZFUJ+NIu5Y7CfIkiB4ds5Dhdh+yHhe08q79rwLYZGiYpXG6DNcEARM5GBPshLtTaa6L+s1t3hQpQj/ORQ2H+9w3cxY93/9bSp/2JFGbzBPYLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Teq2YLct; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXBM4sKF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777306743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
	b=Teq2YLctSPvuEHEL30ffcFUloFl8t3kj6MDMYIGXIIwcsdrOaNFLTnJTqcEhhP1+vBQh/H
	mdI4KzMqH0mtXWRYEjZJYkVDOK82UZcTnD1Y0WJSQlXmuPuEgUGVIR2//VZcFCy3l6bvSl
	6q3n3dySKDxTT/nkfgkM68D+f337K1o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-2kHisw6bNWyDqtLJwJLVgw-1; Mon, 27 Apr 2026 12:19:02 -0400
X-MC-Unique: 2kHisw6bNWyDqtLJwJLVgw-1
X-Mimecast-MFC-AGG-ID: 2kHisw6bNWyDqtLJwJLVgw_1777306741
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5c837c44so40921145e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777306741; x=1777911541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
        b=BXBM4sKFuUbQH9zGGjVnbAobFKoxlg/3kta653I97b55qMZH3d4UTTXU7KZ80b6tF8
         z9mppKywzO54P7m76RI/ArfNrU0GrjHGQFP0F7XC4aztNLgiAtdfzA/Q8MtI50Y34WEl
         pitFropHWoORTEJ3piUM1+g3orMrk7UX0jC6nubvMkmII3VFw3BIzf0HbU5AeHfJE2bi
         0VNWlrU66do/D5b0DOi6QaaIDQjpTjJbDdTMFPkX4h0ir0FoaArxEYd0zdIQlZQ7ri3n
         hrqbdWnjDLQzfIj8sWnNlafJ6jZhV+PiCPUNUI8BzDZbhRjOhhwfpOXrEOH11lRPtgGt
         Evqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306741; x=1777911541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TmyHGGc40+Ejt7OrxLHLyIGtdOqCndQ/a31sVdNcGg=;
        b=nLDGXyPBhcT5bCCNe1CRuGJDS3jXSlNZsrEJkJBR0NjvLuouym0Jj4Hbyw9fOa7qKN
         TVeSiy20Y+rwQWZYQ0mMBPSJziLXbIw49oYyaU+A4ySH0w1fqe5Ytdh8OL1lyLvGEpXc
         4oV4ca2d4INnUJ9OkZdjhtSobyBHE9W2upVkkPVO2pgwl1yqt3JRY4tz1tL5v7CA/rnZ
         N7KSpRVwZMmya2diBinwGpI27pjmAA6B7vBewNaMP8W2ByZNO/pv/SBOaEzfV2g76+a+
         jAj7SLnO7uKY58p3AciU2ZXzMVjm2nBINyd5KCg66NO6nuizbHfoJu2r/iyOqnRstsS4
         j9lQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XuM62F8HPjCae17/NcC9JFNmU9bH7+o5aFXBZoQ0GbJiop+XKeDuUPVRrSemYeKrSCzwwSDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJPwgVCwdZWSx0Exgz0k0agDcFuEKUianRlCbe3lTPQGyyXdU
	ruOHHWQmm005sOGG+mVCDserVHPM+qdmy95j5uZQ5/X+Dp47hiZf9WBRrMfHyBk7rk7szNj5icq
	7K/MXfhNSRbkZ54bbmjtl3c6aaYWiAs7hRygTOqV6ZG7WpWxlqY67it/I5g==
X-Gm-Gg: AeBDiesXFCl//E5UnJGmgg+UOaZlY7RNrk/UqRAU+RX1eCLwQVFe4eEPe3kDNUL6obx
	jnMioHV1FMxX7AAPiazQXO3+q1XAKD7fLwmpcykAtAkPe+8kj7VTCDABDpR/iJljvI5nn/FV8Dt
	RSufRWdnS4gPphYeMzYKjFd+sstI3c1jxpiYbj11uL+wwZW35M4Pq1YPIDT+3nl41H1JuztHquh
	UaQHKmlk9bZhQrwgFjBY3Vv60I91b6fTGWIG9Cm7F84LM3eTn4p6bolkCZCuKVbCL/qM39CDgjX
	KLN1Lr4o673haRpuLiIV4p387QZzKUk9cddaWl4vH/HgTW2EPs4iFFvBdBBJnKJR/yrJ/9FTyXs
	2RBH8Z1LbcTp6HAtcik3xkB3yzRBWA8eHZUUUeAn5W6R0gyVTQXcn5KgcDUy/VK18GN0/zUaIXq
	yW+g/6+Q==
X-Received: by 2002:a05:600c:4714:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-48a76f91ac6mr136635e9.28.1777306740902;
        Mon, 27 Apr 2026 09:19:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4714:b0:488:ab37:b442 with SMTP id 5b1f17b1804b1-48a76f91ac6mr136125e9.28.1777306740387;
        Mon, 27 Apr 2026 09:19:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm969836865e9.6.2026.04.27.09.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:18:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:18:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] memory leak in __vsock_create (2)
Message-ID: <ae-MTiL0vf-y7Ygz@sgarzare-redhat>
References: <69eacf39.a00a0220.17a17.004d.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <69eacf39.a00a0220.17a17.004d.GAE@google.com>
X-Rspamd-Queue-Id: 5F4BD4767E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281404-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1b2c9c4a0f8708082678];
	SUBJECT_HAS_QUESTION(0.00)[]

#syz test: https://github.com/stefano-garzarella/linux.git fix-syzbot-memleak-vsock-create


