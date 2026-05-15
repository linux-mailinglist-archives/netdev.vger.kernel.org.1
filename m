Return-Path: <netdev+bounces-288236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKJPGF3bBmoxogIAu9opvQ
	(envelope-from <netdev+bounces-288236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:37:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851054B766
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEF64303E404
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705A52B9A4;
	Fri, 15 May 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca4hlb5P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLtsEzkq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F14014BA
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834104; cv=none; b=IHLdi+ABGt5rxX8MRfykF68C4Q9FROtrzMMq5Ig2vIVTFIGGjGU57q1gVh8x+12YWe91IVZuroY0PCuD3MNeebAktk+CYhZVc3knQN4XTXe8gbqGg+mmLVo+oJJ/Z7C/p5cW9p+o7/kJRGYFiA16DOSH+yN0OqoOt3e+QeOfIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834104; c=relaxed/simple;
	bh=J+YfgonHj3/xD9IJ4zrqETVg7kXEqUkH6/d/z1scO9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DemEwBO28Y2+1CxHPUJtkvbZ3fHM3BqfhYzkKqGipnJD3YxhGnnMeQZ4dprcp29vx+WKB0UpfaTTOClLbxUKeFE7f8nTZ7nVadvNs8moA4tRA3IsfinijU/aODtIies+gvfINoQyQ2+1xiI0Er13NcC9hAqrM6wZCMC8OHZIIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca4hlb5P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLtsEzkq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778834101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4ozBn+0rPODjqtQvXUj7u7B9iwrcNai0ZrheJfjpbE=;
	b=ca4hlb5PRPzPB5/G7rDKmsxGdInHmtV9IlmeBksFvy9cLErpCYPfvZLYTj5h11hzhf1Unz
	fsWwnqebVV02bWf9UH6QwWMN0b5A8DiG5kwdORRoUFchL6F7sReLsQhyLVaJsi15mBJCIJ
	vEJGtZssIvLCHqiRO/n/5YvqhXBZ4FE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-2EPnV_SdMpO4EnrVix-EjQ-1; Fri, 15 May 2026 04:34:59 -0400
X-MC-Unique: 2EPnV_SdMpO4EnrVix-EjQ-1
X-Mimecast-MFC-AGG-ID: 2EPnV_SdMpO4EnrVix-EjQ_1778834098
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bcdbb46dce2so674970166b.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778834098; x=1779438898; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4ozBn+0rPODjqtQvXUj7u7B9iwrcNai0ZrheJfjpbE=;
        b=VLtsEzkqUahlpDqmOI75ub/q4K1F9qxpO0lkn6QFZc8Ee1Mn9eVbGZy/tUTEwcpsIq
         s2at3UUk/tCyKN5n8XrZM/d8qIkVH9orKe+CM6cUXwyf1DCSyfFQuEM8OvqDL9d+hChv
         lkWF7FIGSpMd8qmeNL4x+PecefWhPqzM9e2Nc7rvN4CllJIsnqY9vRvJuAhtc5DFBJtm
         zxxOvWWTycvaz8821QjSvF0c0JgBy93q0yBIrJseiuB00+3H6MaMdn6JVHMY5RA6yUlx
         efopwLmCVlYOj02Fs8gkRYjD0d8ThekJ89taexyE5Z8EDxNFYruMpTsNhUAIeL/DdyWX
         mikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834098; x=1779438898;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4ozBn+0rPODjqtQvXUj7u7B9iwrcNai0ZrheJfjpbE=;
        b=OVDfGghJLPSENOcAN1ZVOaNq4BhYs+q5CpjdfO57yqYPB+Zk6y3/698GB1yIBM3/Yf
         h6LmSGh7bpIWcFG1jh5rABVEienU6CCJFvuSsaOGzfSkBoI8Z6nROyoJK17+9jIW6XdQ
         uTG5e3BcxjNrS3jEnB9OZns5PDV9DJx4yWVQPuyE9PqP6twy6KhRGk/3kHb2VyEKN1rP
         BHgGuhJtCjMEfTBCoDsUehcmJcluOGqSZYotxZ8goewRpXwdg0H7IJD1RmmL76wPAju1
         NFqWsQtt2EAQlG+f9BBz3Q3reXgqepGNEHCM4ifmzX5prOAms7T9hIclbguAhiZSrT0L
         knMw==
X-Gm-Message-State: AOJu0Yz91xZwpR8oV4pgs3QAXlXySmVfaO4czMRG8tdrwRtpnT7rMUKc
	K5ivW1wYDbKbJXK53kxBkW9wESVCETHf32WnqzNmWh0xhscar/4BWMulqrq1pt/o9FuG62YcfKa
	AWh59eynMiUyBs5uz95XLHo8/o6r4XnjCpkw+n6SWwffguM5VzkOh1hjxEA==
X-Gm-Gg: Acq92OFbAar3C+UvwSdLP9JulYvbhmb9spDeIYVIikuoy8hOVJp2WFYxTzgAlTY+2pb
	x8cm0vb36htE6LZB4fOaRLG4WKCL7iRUuTtI+ylTEPMISdIKlQ3DM8rauGZL5xdZ6jMPd+HZCiF
	oDzcMPrb4w+UFG2M/ohqSIv2hjyVh1EVowcUollju+Fdwx21GhYBnVo+RPpNnwhzyDtCn0fUwj0
	7Nsc5dvFGHc+L3/M+GBegNhpcH6oyDMJQgia2iBcp7Jr/LW7sZZVUcFblXtnHbgEvPv/t3iLgbD
	//M7cWexQ9kh/CaGu1jMT0EFp/ywHDR+HNV/K7CFAMjcrjMEP05RYU9mJZS8ZBU1ZyruMN6S9ro
	ZK2ToVXjHxdOjw/GxWmvCX9YL6om6+UslHrM2ddTOh/ZWed3SZwkx1mnGnOXvfsweRqY5XA==
X-Received: by 2002:a17:907:1b27:b0:bd4:e62e:d399 with SMTP id a640c23a62f3a-bd51797a024mr149535166b.26.1778834098189;
        Fri, 15 May 2026 01:34:58 -0700 (PDT)
X-Received: by 2002:a17:907:1b27:b0:bd4:e62e:d399 with SMTP id a640c23a62f3a-bd51797a024mr149533466b.26.1778834097666;
        Fri, 15 May 2026 01:34:57 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bce1a4sm193291466b.5.2026.05.15.01.34.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2026 01:34:57 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] openvswitch: vport: fix race between linking and
 the device notifier
Date: Fri, 15 May 2026 10:34:56 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <6181DD15-23BD-4236-9A91-9152BB437183@redhat.com>
In-Reply-To: <20260514184702.2461435-1-i.maximets@ovn.org>
References: <20260514184702.2461435-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0851054B766
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288236-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 14 May 2026, at 20:46, Ilya Maximets wrote:

> Sashiko reports that it is technically possible that we got the device
> reference, but by the time we're linking it to the OVS datapath, it
> may be already in the process of being deleted.  In this case if the
> notifier wins the race for RTNL, it will see that the device is not
> yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
> dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
> will take the RTNL and link the unregistering device to OVS datapath.
>
> Eventually, netdev_wait_allrefs_any() will re-broadcast the event and
> the device will be properly detached, but it will take at least a
> second before that happens, so it's not something we should rely on.
>
> Let's avoid linking the non-registered device in the first place.
>
> Note: As per documentation, RTNL doesn't protect the reg_state, but
> it actually does for all the state transitions we care about here,
> so it should not be necessary to use READ_ONCE or taking the instance
> lock.  We can still do that, but we have a few more places even in
> this file where the reg_state is accessed without those while under
> RTNL, and many more places like this across the kernel code, so it
> might make more sense to change all of them in a more centralized
> fashion in the future, if necessary.
>
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Changes look good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


