Return-Path: <netdev+bounces-277301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PVWCdS32GnnhAgAu9opvQ
	(envelope-from <netdev+bounces-277301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:41:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEA13D441B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DD663039830
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEF33ACEFD;
	Fri, 10 Apr 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4dMTgia";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH2ig9nN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB583A9D83
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810190; cv=none; b=l3eYtukHf2kMuOKM0QBKhGn1MwmnPdMMO1AxxNRe/RZPgefvNHmyLBE/8VaifWJJovzLpmEaVdKAzz7ivGdizKmloIafDBMjnbdC0SDYBErz4ZyrhMKUcI6lbEUZpNOurEEPw38HKUY4kl3wr+3nJJ9CR49zZtTuhtGZoDSaijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810190; c=relaxed/simple;
	bh=AxgP8c47gAUCi2wMx3yIR+EuLZ1MEOnbjNDACsoNfbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hlxr1UqWCDR0ZfGaTgrH0gJ7504J5DB5Thi7X8oTMw8mkIlhjbHI4IV9JdiGbyxZkVtjtzSlq2IARtn9h8emagEumLYd6m8VvpPrEHFHOFjjWQl/gAFbfv/iZ5kyiTC9/zGjCLrZyWhFZISTgTTW8eojaMD/K9BmL6dpZrMCHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4dMTgia; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH2ig9nN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775810187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxgP8c47gAUCi2wMx3yIR+EuLZ1MEOnbjNDACsoNfbg=;
	b=H4dMTgiaaZ/0nGsemDGuSy5/XiJOFnKkFb2ghNoZzaBCF3FjgXI13Kmrv7HQ78hM4zeof9
	REsstwXGrY1FFrk364iLdt2UgDCoL+7+EYNg3rogp+pI/DcXXKmZ4/pFwqFb1MPMk93iPl
	vZhZ5X6kR/Ruc6qDQ7MeWTrHpNq9oOc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-6yygPjUENZG7Zj4v87rEBw-1; Fri, 10 Apr 2026 04:36:26 -0400
X-MC-Unique: 6yygPjUENZG7Zj4v87rEBw-1
X-Mimecast-MFC-AGG-ID: 6yygPjUENZG7Zj4v87rEBw_1775810185
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488be33b7a6so12138285e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775810185; x=1776414985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxgP8c47gAUCi2wMx3yIR+EuLZ1MEOnbjNDACsoNfbg=;
        b=GH2ig9nNf3p8jf3cmd9G4lIeJ6C/YCtrp8KzFbD3roG40QNT4/6FRkcoWsrobxU+hd
         ZuawADGnaYTCs8CFGQ2KyR+k7QE2PY0bbp4yKah/xIovk2zVntq9C7ufk5xStcQqURum
         sW7gWCNvv0SFS7oPslt99jo+qdKV3wA3zyx5h9rnH5q1xfhTcyhgFtWcDH1+jlypsfcd
         54sjqp3aGECJshnFQpekytYQGx+4L8CeMmd3bWA9jA8Nd6NZ5moigi16kB5gT0fpdMq2
         Mv2tmhlsf4xJvA69y5+eY4yG+snpPxz3Usnkv9a+5D8rRBjE4hrhb19xZegGbd9bIaRp
         pGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775810185; x=1776414985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxgP8c47gAUCi2wMx3yIR+EuLZ1MEOnbjNDACsoNfbg=;
        b=GyRVsBiLsWk5S+DY+EX7U1DKzC05SJ/6L2KXuqXK8eF+u/yUbc7W9C5EBcyZabnC52
         fkffjhCS61vvl3xC4VjKhuW6y2XHRoENiAPAfrIIQqV+brO4M6FuPdcI2OD5EEEbkf5+
         QzHdwxftp9Zrz04rJ5D52jab56CHbC3QM2FxXQlsxPTjWLx9mtbc4Ly1Ft+q2iR9ZOZ/
         KziYnzUu0w1pFolyBEWKb4AxsbNFxAP5bgwBgoPzkCMgzuEM26daHq2Fz1lw/GtoY+6Y
         AS7hvPCGSuH5kz+AMQkxWqbRGAl87Jp1pdZoPG3cTYZX5k/d9DI5R8SmxadSHw7cLhhb
         y8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVE05Gf11aV3QvPpx9hK6hB1APza3FBCpPxoRrcArKjTFAL2B10/4N4WQDkesfrCzC2CekNOH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOHUiz3IzjPz5rblR2qc/Y13VCgMeCjqoqCwbSjYrYs/Kygh6
	Oc/mxT7losTpDkNo/kG8XhkQJjK2UXSiqwkv3Loy+gXwULF/eOoG/ctgovDFZOdcwVKKB60tuow
	jirGd5M7vpmG2JghGhxTwohelWdtQWlo+NSlrRbby/z4NM/yyElZG5jiZ2A==
X-Gm-Gg: AeBDieunWvJ3PKON8zPUufzP5RvFQHIoPxUTZZT+G7Cs/u9zUgJawvBtwp1jsg3G0uN
	u5LJ5DCgHwFy/Ia43cjHC/jj0JJ5CV0+Tp43JXxAeMCELF2QK6LtnWwGTdX5/4ix3BBgMnh9XBq
	W+DwZmhfxbtkHc7q06eVE8C+2zEx+V+0CmewDmI8CCxADg3zWLU/588cn7xJWc9HPLoUakMnoe8
	TtHcS+giWRWhQc8tS8QZg2EasxKw3KsnzmPI79BXFx5eJEtBkYE0YKEyyiTY4snezz18eZ8i+EO
	j4a7Ze9rtmhGaE7/sAFXsZZw9MPrbi5ClJOOY7pDaLKoAaJBLV9KjSB5/r2QHLFdPu8uPr01X1U
	wwOg40LGuJRa/MnKLjGshYt921Bm1IDCOm9dbFOHW7u2m0Jymu/fzrX9yv9N8CEsD1BcUO58PYQ
	==
X-Received: by 2002:a05:600c:8209:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488d684ba0emr25033295e9.21.1775810184725;
        Fri, 10 Apr 2026 01:36:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8209:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488d684ba0emr25032745e9.21.1775810184278;
        Fri, 10 Apr 2026 01:36:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d525c931sm56045695e9.0.2026.04.10.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:36:23 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:36:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] vsock: fix buffer size clamping order
Message-ID: <adi2chLOGW0pms1Y@sgarzare-redhat>
References: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277301-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[doyensec.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BEA13D441B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 06:34:12PM +0200, Norbert Szetei wrote:
>In vsock_update_buffer_size(), the buffer size was being clamped to the
>maximum first, and then to the minimum. If a user sets a minimum buffer
>size larger than the maximum, the minimum check overrides the maximum
>check, inverting the constraint.
>
>This breaks the intended socket memory boundaries by allowing the
>vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
>
>Fix this by checking the minimum first, and then the maximum. This
>ensures the buffer size never exceeds the buffer_max_size.
>
>Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>---
>v3:
> - Added Fixes and Suggested-by tags.
>
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


