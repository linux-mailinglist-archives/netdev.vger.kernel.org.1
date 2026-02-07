Return-Path: <netdev+bounces-257750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ8bLU8Mh2mQTAQAu9opvQ
	(envelope-from <netdev+bounces-257750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:56:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 932FD1056BA
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE45A3008C0F
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493232BD030;
	Sat,  7 Feb 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5sg9NrS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fF1bc/dh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4E3254A5
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458184; cv=none; b=APOjG6Ovq5GH8hEFxX6P+Ptcaf0uv+DE8dF/oxiVrV3DAw6IGdenZIfbo9sZLZrnyqmmUIq0UkB4rA28U/MMzIRDUuQUIs1qlFDY1xWPv7yuVuO2TibBTX9V8PeUOaFXnb9rkfDGSiDPDyl3LMawgSVAKkIZigpkRKi3L69zaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458184; c=relaxed/simple;
	bh=Emfr+9M3FTLUOX6E+ELk+kwQTMeILIbImZa7UA1b9mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMGgJuU1MYhD5EoKqsQTj1aiIg41Z+x88M1m8S6TtM43fPlOTOJ4js6wL6BVdsPPnlOYhATwGAYya8eymnAVh9ImBSpWVkuW3J77+CjaR9bJMRyCqPbR9yDZPVQXgEDT63Ni8iU8ExgBXVmKP24S7aEkvjbie3NKpkp5efZwVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5sg9NrS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fF1bc/dh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770458180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgkhHo4dkLMI6TIjRYX8zZ+2vJLI82aDL+YBdRqg+7o=;
	b=P5sg9NrSw4V+Ioj9uLWBh/ahc2O/3T5Vn5/GLKBPoIXDV2qtqHqEGFKNcuzCbJC8kLey/m
	zPkVVaDjPwF50GVZsTFdtuqyU4hDXK2Ku9aULMh6njhVV32Q9+Miv7T/Rj+ZQImY4xL83W
	fp2WOrGfODEJbozQPRft9zjgxm9NHf0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-SY9O_d_nNUifx5QnRfE8Cw-1; Sat, 07 Feb 2026 04:56:19 -0500
X-MC-Unique: SY9O_d_nNUifx5QnRfE8Cw-1
X-Mimecast-MFC-AGG-ID: SY9O_d_nNUifx5QnRfE8Cw_1770458178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4801bceb317so39261565e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770458178; x=1771062978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgkhHo4dkLMI6TIjRYX8zZ+2vJLI82aDL+YBdRqg+7o=;
        b=fF1bc/dh4DHwD/KRaAiKSQ92jFUNbQcP1wYV0YjxaJFT8M39m3ILXxC9oBeOEl6U+1
         JogtLFg8H6iH4U4TbIILm7FfPYY33yLC3OuJf5C1w59RDxw6MYX5ubAgVSzMAS5woL0Y
         nWxxyg4eejXLn52Q4EQdZ1tLQs4YL2FCCG5fLv2UHK5xRBIiuk0cO4pBt/xP5XweYf4s
         LRvxuUHWPh9znzpTORc22+M858uIOp5Jnxp7Y0fZg5o7SqEtY9cKv3yrXVij5UgquFNZ
         k6Ap6mzhB5g39AQ3G39Kgjca3AaZkx+TrcfgY1iX8FKVZS6wXQfyxRxIfkNEODhPOzqh
         N1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458178; x=1771062978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgkhHo4dkLMI6TIjRYX8zZ+2vJLI82aDL+YBdRqg+7o=;
        b=Ik/+h/D5UjRRTUokd9YQK13KLJtd8U6fHzgawCu5UtN6LkR9NviJOb3GSdf3LfxwG1
         38iBpLWQJ1BIPJAKKlhB0+BxxYdgZYWXoaUbHyEkFaBPHxKbgD/vAqoOK40W+hgC8HrG
         nBgGTv2KnbQ5+MtqQ2vcWFxKZFCreKsJHjwj9qfPQWP0fA+ge1jQXUOOwChrKVOQc6pv
         8g4S46CDvgd4qGPjp0M347Opuip3DJ9KLtGl0PlCumoLn631rrmyjxSvhiebYdDUptzo
         Az0aYX7a6mdr8UMXFioEGniu58+jqRp7F00DFbtmX3srvOUga2gC1JU3yeYU7NUuNJFo
         rhVg==
X-Forwarded-Encrypted: i=1; AJvYcCXwR1d2Ooz6Rp55QmdSHsQ4rY5AQM6REoUSSAsdaOIn6HHs8l4KUteC672bk39GWOWNlTjLvw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXcxvOJVUdjWR0sRJ2BbgIu1bDWHvvTBf4wFCTQ2nIxuLPV8i
	g8IUPfebzxQlbBorV9l1vSSnkuO2UGmfFpQgpabkpg6f5INIHSk5eBViepLus+0qgWGXeEOwY5J
	t4XovzzGik0L6Mt4HmLCjyRBnulvdaZXA4ru3cN+tO2QO97Xly9TGw2SlRg==
X-Gm-Gg: AZuq6aLXIILVHysR22t89R8U0CvG2xxJ9tVVOJEY0o9f2+5apF6v610Wd7rQIjZuaur
	Xtoy41Qo/oFQOKysPGNrNOGM1PlL1pc+vHqPSyXuJmkakMS9VxzqQ6BAdmz+9HqmK5pttoooskC
	56C4Zi5BW/c3is2nQJQAhOTkOuJqwSdqzkC7n08qFSuGVCIHcV7pA5DceyELzfETgEFF+F5hYG7
	Ppyw8AWGq7PMxBO8DPmsaAiRKAJk4oUo15fVRBPGPqD/cKDZMzaaWmqmDDcep7r2AbobYne6EOX
	DwE83NXN+onovnKTf0FgY9PzbaHObOTxhJBzwAN4J/Kyr1d8sSsU9DP4fga53pTcfPebV9XLcgy
	wKixLVmC4Nvj7AezMlJzk0RX6m5HJ82/CuQ==
X-Received: by 2002:a05:600c:64c6:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483201fffeamr73947465e9.3.1770458178040;
        Sat, 07 Feb 2026 01:56:18 -0800 (PST)
X-Received: by 2002:a05:600c:64c6:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483201fffeamr73947285e9.3.1770458177554;
        Sat, 07 Feb 2026 01:56:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040a3cesm68665225e9.3.2026.02.07.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:56:16 -0800 (PST)
Date: Sat, 7 Feb 2026 04:56:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, pabeni@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260207045416-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206191308.7fdbfef4@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257750-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 932FD1056BA
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > align with kernel's standard RSS key length. Add validation for RSS
> > key size against spec minimum (40 bytes) and driver maximum. When
> > validation fails, gracefully disable RSS features and continue
> > initialization rather than failing completely.
> 
> Hm, FWIW clang says:
> 
> drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
>  6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Which is kinda annoying because the value was increased in net-next.
> If Machael wants this backported then we need to keep the check
> and follow up in net-next? We could try to cast the u32 away but
> that feels dirty..


I'd say yes. the warning is harmless.
so
patch 1 - this code
patch 2 - replace with BUILD_BUG_ON

but i ask then whether this code was actually tested against net-next.

-- 
MST


