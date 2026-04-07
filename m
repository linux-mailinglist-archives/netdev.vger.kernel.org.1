Return-Path: <netdev+bounces-275995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OnjAoAI1WnMzgcAu9opvQ
	(envelope-from <netdev+bounces-275995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:37:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECAF3AF426
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74BB4307B4D9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188453B774A;
	Tue,  7 Apr 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF85sbCv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti1iJj5e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF63B7753
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568566; cv=none; b=hlEv3hT0LxTJZDAtJB2hB9TDU9F5b3VHuwWY6IpJxL5eP6DM+Fyn2vgXRfPr+VCA1V+ZvCBXzpnM0SBNBV/6h5VJpGtRJW1FX0FStcc2PwL6FDJQq0KcuQM1QunJV1S3+LevmS9R6QNDdvmPHJdCYvUJpFV8hIzCp1Q1ARYJkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568566; c=relaxed/simple;
	bh=7tA5C92PG8nI+vqli8+BWVx+xZUPGPyr52je8nhr8Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLMOoSTiNpTL7jfQ4sQhBHeDohepHKDBYsvIr8LtDWd4fq8aT40PxXaxIhiI6XVNkdXB7DZYm37JwujMcj3a+c2HGuMdoafOoxyYUwUQHu6kO8HCBJCh0oJOF3Pqnn2gfHyrxqWl7dF3KlSq3+1ZA7mZ++3+ZeQ7cl6tY4g9Lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JF85sbCv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ti1iJj5e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775568563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pelvdbp9V/M+qvKaYggT3terh3L8nysQjlcb510IJW4=;
	b=JF85sbCvWzlF72cMqzCKzWh4QdNhTaCk4cCK5pjQR3CtGC+YWBDlVPpaWbiB4rSW4jk4VZ
	U5TXq3OxPiqt7m6i8AtiF6c3xmmQC55geQB9/vvhhdP/f3AJ7vXycJ7cgDG9l+UawVkWkw
	RaAKR5Cco62WoZqnoPY5vTlBcaq+v84=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Y_V8AsAsNNCLyQh--i3StQ-1; Tue, 07 Apr 2026 09:29:22 -0400
X-MC-Unique: Y_V8AsAsNNCLyQh--i3StQ-1
X-Mimecast-MFC-AGG-ID: Y_V8AsAsNNCLyQh--i3StQ_1775568561
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d167a0c1fso3547468f8f.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775568560; x=1776173360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pelvdbp9V/M+qvKaYggT3terh3L8nysQjlcb510IJW4=;
        b=Ti1iJj5es1+jYEUCg1TRLcrNdAZKN31qQDXWr7tBk6msS2lsrCdjDNbQoPUiE4iGaa
         A3ASckDMDJLNg/DggZPEQSy8yb6jaM0bd3zmB2ugq9Oj5YtEPCpSezoJM2yJM+UVR5fX
         jTxkyyOpdD2uwTaq3GUsXhJy7fCO9nTIy4/4BPQa4IpDUi7Oaz9jNSt9Lllt5rNEz5fG
         nqCCqbcTbeh9+qBhGCI+5mdzS9YUuW60irJlC12Xop5ZQ6o4sn3QuQEnkqfAp9eQ51A8
         reaEmIWlDXNtl8mSqrnQRgPwlQ/KAwb4uZURgh15u7eVw8fFCodlJiBoTJKoj5Cea5ia
         EG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568560; x=1776173360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pelvdbp9V/M+qvKaYggT3terh3L8nysQjlcb510IJW4=;
        b=eQ8DNjzI4nZ/RfPAVkusupVvC4LCP3Pg7SikMnD2mChAwnk6rrNPZhdjDLgpKO8IVB
         PoaL+2MdCeb0Az2hd2HBv3gouxuo9kFOLG2Cad+udZzJYtvPv/ivO40sZvE2VkH15HQ1
         zhenL0HEGmsW8vxLXMB/1ZC0tdeYftQBwHn2lHXfPC5mGklR7b60n/KlW/8xVh4l4EfG
         EMHCWu+qLianAqYonFaJkO3It2INAI/XnJ6/KeO9fyTi+L4qq+1OsZU1qkkjIpcb3q/g
         H8CtHv0cRY67MA4KhWKjOoPdTSRCZaxK2a1PM6ri8zg1lN4XNEE1s3yyAXqikFFQCZBJ
         1N3A==
X-Forwarded-Encrypted: i=1; AJvYcCXnspnIIEVILYFzN4jxNBcuPaJrM5wqGNoc7x7Oo24feuQJTM0S9RrL7S+3jYgP6eYK4wOuBeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVJSXVUAxBb69+CUpXUJkDpEq65u+la6giuBGqoY6UIRny/hL
	O7s/yHII3lqMCP7m30UUZbE0T5PBo+NtVMwjrz+febI/pkXmxF97e3anGmCs+XzbWfpLQ8dyJ/q
	ZHTPEgHXd4ND5Ol/sGwN+G2z4uPtqVi7FvUrbWssyVDNZJJZkLzk0kBTIuA==
X-Gm-Gg: AeBDieuVR7sPo83IXQtusX+0xxKGgUbTzcGoXvVCsosX6mJVdSAXAhdRWYB/y+PdGUo
	aIfSPgXevshDXE8sCv6lY8nUSaObVa51GZatMKLYjISj+zNVig7N46B6Eq/Hadh2yc6HwzhsrDJ
	dnQajhodEST+lr1TTILiEGyfst8x5/sOWXkyEsLQKJhHX6PGh0EYUwKXdsz7AhYDGhqunQO49WZ
	CRAsLvP+1I/TraWWwThiHMSCBUEKRZDljxnFFNO0yhiM3oePHIzUA76sAnSqS62i458LugvzclS
	dsYBsjFaqCvHcCldZ3o1rDN2VQy2NXJb5nGLC4b/WLNmYQ0g61na3GPrhy+LuFi3eDllUfd1ION
	nOgdFSvaPLyhb0itqgTzR8n3dMA0VZtEudx/X9/FmmcMasLJ3mBbN6StLaQ==
X-Received: by 2002:a05:6000:1249:b0:43d:3113:6eed with SMTP id ffacd0b85a97d-43d31136f34mr15036381f8f.4.1775568560459;
        Tue, 07 Apr 2026 06:29:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1249:b0:43d:3113:6eed with SMTP id ffacd0b85a97d-43d31136f34mr15036310f8f.4.1775568559904;
        Tue, 07 Apr 2026 06:29:19 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d289asm49269433f8f.19.2026.04.07.06.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 06:29:19 -0700 (PDT)
Message-ID: <756852a4-b589-4eeb-81bf-963fa2e71821@redhat.com>
Date: Tue, 7 Apr 2026 15:29:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: hsr: emit notification for PRP slave2
 changed hw addr on port deletion
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: acsjakub@amazon.de, liuhangbin@gmail.com, kees@kernel.org,
 horms@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 fmaurer@redhat.com, Luka Gejak <luka.gejak@linux.dev>
References: <20260403123928.4249-2-fmancera@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403123928.4249-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[amazon.de,gmail.com,kernel.org,google.com,davemloft.net,redhat.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275995-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ECAF3AF426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 2:39 PM, Fernando Fernandez Mancera wrote:
> On PRP protocol, when deleting the port the MAC address change
> notification was missing. In addition to that, make sure to only perform
> the MAC address change on slave2 deletion and PRP protocol as the
> operation isn't necessary for HSR nor slave1.
> 
> Note that the eth_hw_addr_set() is correct on PRP context as the slaves
> are either in promiscuous mode or forward offload enabled.
> 
> Fixes: b65999e7238e ("net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP")
> Reported-by: Luka Gejak <luka.gejak@linux.dev>
> Closes: https://lore.kernel.org/netdev/DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> Note: routed through net-next tree as the next net tree as rc6 batch is
> already out and I do not think this is worth to be included in a last
> call batch. Anyway, if maintainer thinks it is, feel free to apply it to
> net tree.

The general guidance is to avoid fixes tag for net-next patches that do
not fix net-next specific code. In this case I assume you want the patch
landing into stable right?

I think a net target would be better, please LMK.

/P


