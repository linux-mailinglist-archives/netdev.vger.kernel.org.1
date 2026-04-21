Return-Path: <netdev+bounces-280184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOaDBAii52nw+QEAu9opvQ
	(envelope-from <netdev+bounces-280184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:12:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64B43D313
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE2D300CC04
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99331F9AD;
	Tue, 21 Apr 2026 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvCrjcIb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSTq/+3w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E22ED17B
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787438; cv=none; b=VljblJzHxqIID9s0K+4RmgW5od/OzB56WcrMcVXqerIswe3CVVDYuaW3XcrpzTm0ewOLDe0wpY4AztEYLTQ/eiP6bJGm7KbwORw3yHniDo3ftyWlQKW2ip69AcgjAgRTfZOuhTLOfRaA2WzQjAam+liwCktH6aANO0aau221lsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787438; c=relaxed/simple;
	bh=gjLgrhTXxjefi8l7r9MDNA+Fwv26ell29c+FLUhlhqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4+ntm8pKBPNGdoSVHavuBc9ZVWo+0/eTZsrTKHGrKXvhohL6ztYjANW3kDmKBEuDnJr0eYezz73U8KeViNnXpA5Jp+uUXkuJcBKLciL/zQaX6ogxD5NPg+xT4movDkvAEs2K4LZKUuPbnkGXFRifjq19ZHQgXI5g1FGk0iBdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvCrjcIb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSTq/+3w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776787435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbw5ujoYQ37+wfYM5Y8eFXhdYDFjUbxBsSkUOyx/ZB8=;
	b=TvCrjcIbQUIg4PrFGHYdgH5Axh6yConvYi7ZKOEl9G8DsQuUrk6KY/1AYxpSMfaSrtO9lD
	ljzuCYIuEbh/wzESNmtmwKTLrNRO87oEVvDIYBaUEABAPz6lmEigInZcrD+z9/xaiHIpYm
	A2WEvprsjPiHnNC2Zul6ApGI05rhkSw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-jpSVPLwqMSGVZkFHTEliMA-1; Tue, 21 Apr 2026 12:03:54 -0400
X-MC-Unique: jpSVPLwqMSGVZkFHTEliMA-1
X-Mimecast-MFC-AGG-ID: jpSVPLwqMSGVZkFHTEliMA_1776787433
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-440d12a472eso2010278f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776787433; x=1777392233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbw5ujoYQ37+wfYM5Y8eFXhdYDFjUbxBsSkUOyx/ZB8=;
        b=jSTq/+3wMoxU5KQy3RSsk8KkPH733R5RlzHgewrRzD8fIl10Z3K5sl+lZ0SlQXpuiZ
         Sy47SCm/O28vs8vkvYhnRC3ZYf+IBTjnNvlrYX43RLHzOCXEBuECq7FL5WGqUWLSV5Oh
         djZ4CJtAu1ejm0DHYxV88eGcAGKPoyoNSNIKLQD2sPyM9gJ9UTPsD3ZOkzM/rOn5ze3d
         ITJSdA6KcsiaA08l2xnYemT/iJCNyf/vdSYnZlI9mGUCoKqDy4a0S8NUnh0quhdxL0iA
         1PDkFClrmEsxXE0oTRXA1OOpz9xdonsUCt2RBtin/HsxJ7RJXqi1Gr19mMLT7pL20BVB
         28KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776787433; x=1777392233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbw5ujoYQ37+wfYM5Y8eFXhdYDFjUbxBsSkUOyx/ZB8=;
        b=Sir4cp+PIqJfpedd+xeWVNZicNAAW3bLPPfcgGNLcXfosfrOEBRs0jbdcYlwvoN/Kp
         KKQVjIlH587CElmiSQzj5u1yxtD3HuxeGoalbM/0HhEHu5hWndF1z69uX1wJTHYzmB6Y
         fr6UvLIoZ+gr2lQ2cj9yqJtfbmgTdbnGkagA3jOZpiI1voMUfRdQrrW6iV2ImzgcG1x1
         0t8P5MxcLwWAHElhrbpnPwFiOx8I8wBdTx99WBlRm5EPWWJ/i+X5UwI1UZaMDvDDPGV7
         ES55IjHtrmZ7wqvnGG4nkzzbDKOGsJr6crmlRXKj+BZst/YpecNReV0ODYCcrM7H8X79
         TVZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qJTpeQ7ATXdZtj9qVNQyMUYv0Nbkfbka1K23/5UsrgisOJcbwaULounCK8CNO0etXj9JYbQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+nCja/ZOHQslEqdmMVBL5YpP9LBwIylcPAk08oyXB6eMXP0U
	dFIC7D5eCWA8woY9M3fAeBGUJT5k2YhSvOQY7m5D8PCmbSmKMNENhEE5NKqWkVDb/HsLLhZ8cjC
	u7TGoP/Wpboo9GJTWYQohbOQ/MZ9xg98QdKEPpuOVCmVynbrMxrDxJDAJhBDAUZHG1g==
X-Gm-Gg: AeBDieudVB7enXnlzkA1aCTImtKzf+MlSpZt7d2r3SG43Zx5ZbjUMGu1U6jNajdmukd
	by0l5F8Agfp1Hzt0gxl2ybBwqUAKe3LKTIWr8/p7yhxiAa1Rgrw6pdyGrnjKHAH6sNF7RL22q3r
	TyLSf23Px8hhMxSDQ8I/sF5HBUb9a872Te3GrqpRRxgJqrNKvc1OrhqcqmDgClA5VlxE+11VdcF
	hgtGSl0tkietMfiucj6HP+bf6bsk2BA42MVxwR+DgFH6qGgMdqwJAzgPzLYKpyO9BG1TBgw2acC
	mEDzmF0Gg95cBwZX4Jt6ouvfHSh+x1m2WuqeR40Dsp26lSnV1MgYZx/KKHK41e+wqWGXoTSUVTY
	58tK9pdj2meyLXKT2p3AdNCsn2L37yQEMfMDa1Q==
X-Received: by 2002:a05:6000:1acf:b0:43d:7946:bae6 with SMTP id ffacd0b85a97d-43fe3e236c2mr27641225f8f.43.1776787431542;
        Tue, 21 Apr 2026 09:03:51 -0700 (PDT)
X-Received: by 2002:a05:6000:1acf:b0:43d:7946:bae6 with SMTP id ffacd0b85a97d-43fe3e236c2mr27641013f8f.43.1776787429532;
        Tue, 21 Apr 2026 09:03:49 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm9220717f8f.1.2026.04.21.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:03:49 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:03:46 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ss: fix vsock port filter
Message-ID: <aeefuq-s7CAeXVcY@leonardi-redhat>
References: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
 <aeeEXS0n3VpM791Y@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aeeEXS0n3VpM791Y@sgarzare-redhat>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280184-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C64B43D313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 04:07:41PM +0200, Stefano Garzarella wrote:
>On Tue, Apr 21, 2026 at 02:35:12PM +0200, Luigi Leonardi wrote:
>>parse_hostcond() uses get_u32() to parse the vsock port into the
>>aafilter.port field, which is a long. On 64-bit systems, get_u32()
>>only writes the lower 32 bits, leaving the upper 32 bits set from
>>the -1 initialization. This causes the port comparison
>>"a->port != s->rport" in run_ssfilter() to always fail, since the
>>corrupted long value never matches the int rport.
>>
>>Fix by using get_long() instead, consistent with how AF_PACKET and
>>AF_NETLINK handle the same field.
>>
>>Fixes: c759116a0b2b ("ss: add AF_VSOCK support")
>
>Can this more related to commit 012cb515 ("ss: change aafilter port 
>from int to long (inode support)") ?
>
>I don't know this code at all, just asking.
>
>Stefano

oh yes, you are right!

Luigi


