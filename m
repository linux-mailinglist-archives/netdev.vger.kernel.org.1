Return-Path: <netdev+bounces-274977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH2lC7+Qz2lqxQYAu9opvQ
	(envelope-from <netdev+bounces-274977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:04:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D623931CD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8F3D3012D21
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FF33FE15;
	Fri,  3 Apr 2026 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0aFu8t9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2cYsJVC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712637FF44
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210673; cv=none; b=mwVSXbTq9mrvhB9R0vXo/nVR44ZWW0Xi1N+wjwfR5httPJywMMCKQzgPY4kw9x4ldP88b1Qsuna7i5MQr2nWTsT+ejMlkrrTQ9Mtu6vozlIcYLV9aTsJbVWMnPu8z6D3/al+/RIC38xykkdBMk5RBu/yKXu9ABDmEx7Pmd5+2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210673; c=relaxed/simple;
	bh=u074NOceth/+r9Ei9g2pssvboQrOKX4SPpJBbPS2SPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWB1l0UTKzSBEkiZavHqsc3TFmAxzRuAYRA9tQnjiK0FDt/D8avZ4rrz7LPG/ZZSwR39A1H/q7+ZhHuxlqN+8Gh/apLPLuh+gfr1Eex/jEaNIswZ9K39cRLpqgVaBC/IpvNpSupQd+AuN45DpHu62Li/DAPS/mjvqN80D+Wirzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0aFu8t9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2cYsJVC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775210662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u074NOceth/+r9Ei9g2pssvboQrOKX4SPpJBbPS2SPA=;
	b=F0aFu8t92lwz9Y+5rNZKFnhw4JCHKbwRVziKjtOlvXW+Esx5AotEPkcPMvkzmuyQYFRgBm
	udnu5rS90f8YxpS0VMPC4QOYyY3iGFUvF5SVgXWMJ1y4+5OJDABzxqAdwrcDPat7aqgcYG
	H0UBM+CKv6JZG17Zew4Zs9JoIrAa+7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-AYuUTjSIN62mkYTMJ_3T4g-1; Fri, 03 Apr 2026 06:04:21 -0400
X-MC-Unique: AYuUTjSIN62mkYTMJ_3T4g-1
X-Mimecast-MFC-AGG-ID: AYuUTjSIN62mkYTMJ_3T4g_1775210660
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so20783275e9.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775210660; x=1775815460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u074NOceth/+r9Ei9g2pssvboQrOKX4SPpJBbPS2SPA=;
        b=W2cYsJVCSokhdFOEb4xhRVHolAKaHOVrR46ktPhoswj3uKg2m7+KACOEoX5Jnc/MUB
         vGzHrOLlvGVd+zQMIX6Zcnn2E+QZ63QrHooOXxGYs26/SNgK9h7ecMPgMTZMAs6JYaug
         IzQcwyZedPjlcLiUk6G9LJcMmExmX7Iet4Bp7rIdRX//A4IMDi7zcCPPmOpzlAGh2Ajr
         7hKU8P5cUa0WKxY3QTFUB8Un96CrhjmvlWQlMgB4ECAHHHpSXv4GQXG6Ry8+8yXddpG3
         vgXnuVHvMXtFxZj1Bic/yyXDfp6fYxIEqybe6zWfFcjFAvrp4MNSsuVV/O7kMRMuuSat
         qk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210660; x=1775815460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u074NOceth/+r9Ei9g2pssvboQrOKX4SPpJBbPS2SPA=;
        b=pptN+mvDx1yHPdZsVzr3cSUPZTqfpfRNIdo4Fko02yIatam/Icqj/X8bYOQRJXEqTn
         3TGkLD/u6liKxPHlYPd/J4JYrUGINvhbB8JdbNkYvg5awG8MqU5Tzv+M/MRGf0wxOTnS
         knLR+E1DvWqmAW7c61g1drw7DpLGTPyIvqNQymzY+PNsBk5H+62zOZTLDpkqSGLOihsX
         QNnB0a/MGwrYWJ2lvhXKMcvSPtnNjtPMalNBRUMtrWKdidWJ+g/Wzw9VASNpbmWidWGo
         O3UNyoqo49EnknbnhUbyzuuwNX576BViKqoacr4HeCkrK/qVU6IfVzQUUViNn39jwmn2
         I1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2QLzi0P6v20J1GqWaZhYIIxCE/FEPFip4u4XwGshDiB8o6Amz5Tv7ytT2nJxIHX96GELAWo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMf46kbPS0YOgSayDEAF5fAJwrRuFTkRD3Z6yp0643DORyqZdn
	rIL624XuFo7OauiHMb2EgOVMXEin0kWjug/R+f/Z00Mpm/xqBSpG11ia7RrdSmLybNcTznlNzq9
	xtBz2ahqZ41nbEIVT+Iw/NF8g4eyQenrcXRgJNHm9/0QMjLnprH3X2uS+cA==
X-Gm-Gg: ATEYQzwWXpKAMp0zm8CP13O5b0ROL9jlUq+aHDb9+xtTWKUqms2+zRet7T08BSCocBM
	2MbuJJG9+adRqsIgGh6o1efRkNjFKy72o5mMQ8jVkFMog8Hj4LWK1Oca41rswv21F/eAinoaAi8
	1bYpRe/6qvTn7e0yXf5AO2yzxU/YlDfbwoR6zFb9x5a2wODcSANMBNkc+kZHE+Md+ILj+A4Djjf
	z8EKFRwce2hIriPQUxCvKwJyQNKlIX8FC5tvquVQCPcqNESsS1ctj1PFs9a079lrd91yox9fL/q
	/dZ8zOKoCaR+U8Xb0B/E78tyOIn69IvFDFAOlXE5nzo7oxQqeVZieQ9SRIAY34rvUj4pOS83IsB
	vckgtV1P9FVkm4LUnKCz38Ojts4bDXBlnggHoflATu9rTQn+CuMBHHIowlNUVkJ+gAWQA1/rwVJ
	B7
X-Received: by 2002:a05:600c:3e0c:b0:488:92a3:dd4d with SMTP id 5b1f17b1804b1-488997d32fbmr37461755e9.29.1775210659759;
        Fri, 03 Apr 2026 03:04:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0c:b0:488:92a3:dd4d with SMTP id 5b1f17b1804b1-488997d32fbmr37460995e9.29.1775210659150;
        Fri, 03 Apr 2026 03:04:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm335385945e9.3.2026.04.03.03.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:04:18 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:04:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with
 empty backlog
Message-ID: <ac-QdDNhpuGuAzjr@sgarzare-redhat>
References: <20260402044637.73531-1-laurencerowe@gmail.com>
 <ac47PYPeL0IyRtY6@sgarzare-redhat>
 <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
 <CAOycyLR-otKw4jTcNpo3pUBbDx9DVJyPU7b0T6uHib6mSrAvVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOycyLR-otKw4jTcNpo3pUBbDx9DVJyPU7b0T6uHib6mSrAvVg@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274977-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4D623931CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 04:30:20PM -0700, Laurence Rowe wrote:
>On Thu, Apr 2, 2026 at 12:22 PM Laurence Rowe <laurencerowe@gmail.com> wrote:
>>
>> On Thu, Apr 2, 2026 at 5:03 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> > >Scheduling a timeout for a non-blocking accept with an empty backlog
>> > >meant AF_VSOCK sockets used by epoll network servers incurred hundreds
>> > >of microseconds of additional latency per accept loop compared to
>> > >AF_INET or AF_UNIX sockets.
>> >
>> > Not related to this patch, but should we do something similar (in
>> > another patch) also in vsock_connect() or doesn't matter since usually
>> > it's always blocking?
>>
>> Looking at vsock_connect it's not immediately obvious to me whether it
>> is affected
>> in the same way. I'll capture some ftraces and follow up after
>> updating this patch.
>
>This does not seem to be a problem for vsock_connect since it checks
>for `if (flags & O_NONBLOCK) {` in the while loop before calling
>`schedule_timeout`.
>
>Timings and ftraces:
>
>https://github.com/lrowe/linux-vsock-accept-timeout-investigation?tab=readme-ov-file#a-quick-look-at-connect

Thanks for checking and for the fix!
Stefano


