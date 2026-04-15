Return-Path: <netdev+bounces-278830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H04O7Wx32lCXwAAu9opvQ
	(envelope-from <netdev+bounces-278830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72D406080
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44E78300612F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09E3E1CE4;
	Wed, 15 Apr 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqjTryjH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhP1L7EG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566053DAC02
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267671; cv=none; b=X0IDo3+y0KzIwowHpwDRy01H+G0oz4G3jz09+D4gpH9YF3ysV9vodC4s9pNSysUXLjArukBpvq30cjUtHEww9YuWJx0ZtPy5QnS72+lZsaKKgKtg2cullWMX/ZvmMeVxECoX81AuygeVs/0Tk5cFhPHklGXACkOABx/jDGXKsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267671; c=relaxed/simple;
	bh=2SsUYUfpJ6Cn7ENP9SVUB703hjWJHv3onCi+Vq1hxh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsg9R+JBJrVSXDDDBsQi/kvQHb7ZX5+8ga9yCnffZiZGPVhQ8FnWx/b7J20T4mPnHruR0cEjZ4qkdQNGm8Y1N0SCItnMsa9PvU5tqqvqYLt/QO5i32CHme8KUjDFaxrprpeSTwaVyQSefRLc1H5GrcUWskdunudsWzduAnKgAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqjTryjH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhP1L7EG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776267667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
	b=SqjTryjH7qhUBGLNcRp0FPPlpy6oAePtmYmX/l+DuHYjfKhNHF0YpwuPN9nEv5NsdTkWXm
	MdSNtpbfdLFhmlKIWfTnrdLfNCX0ZiiiaJxYWVhis6VZjPs5m3U1orIK8Ma50ttg69WGTY
	PHFCtBUbyOt5hBdpsFRFH43PpKPPVSE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-h8WLNxqeM7uza-Ho2JPHrQ-1; Wed, 15 Apr 2026 11:41:04 -0400
X-MC-Unique: h8WLNxqeM7uza-Ho2JPHrQ-1
X-Mimecast-MFC-AGG-ID: h8WLNxqeM7uza-Ho2JPHrQ_1776267664
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso40141135e9.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776267663; x=1776872463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
        b=KhP1L7EGSGj8v7+RertazyvQR/n+mGipRSK9QxpGjQFFK/qBvI9GeunI1mk0/tTtYg
         LWI0d6OWYUhct8O7r+mRTct6iEsIGYp1Zt8sjjUsEVxcKJzNU5y4COQ/s8Rg6+2oPGc7
         25nxsD7QB3G/cqgUCQzyI6mTuanwQ7lQBtzxKx/3eROx1u8Z0LAlsPhE8lc06A7DzIuq
         418d4Nnlfd01wzlzOFMjnV741yBJuLYnSQ9yrx++ZwSNgiF+TR9+etFJoUaudbM9E7Ks
         qmxZ3NaFJpw5kyss4rfavX1+uRa2rk2kAHr5zYE4VQ6cu9pgdQzuzjw4T2FgyoneU5kJ
         ki5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267663; x=1776872463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
        b=ixHjg3/JawL4220RVfTy3S12H8bqF3OmW0aX57N9w95M1UHD3tD/dXc41BLQsIr2Ip
         7yrulFJ8Md0ZFfKJLRkBJaKIAlV0EyGylI2xUA6yUOqppB564a8QeBU8q/VauJ1F+NAI
         z0yqSPoTV0cWrm7gJuT+mOt5h4C4powgCfQ5+Zt6xbr1sFZoscTG+ZDG15hTuO0bCSde
         mi5SsIOGCLz+3cCD6p9LbCg6qbX1UFcp22mNPjE98usj+2ceSPDFdkpHzhLX7Af+MbMq
         KTvNihQ1ChlNsLBHjx8YKC1s2kNsAShGwJv2RKyfiCeQgX4fHARr0LyZRtDlHgVyzRjz
         OHhA==
X-Forwarded-Encrypted: i=1; AFNElJ+pOv2LCgjxNVJC/ukfm3xnRZyUVusIC1ZU8vWZJo4aha9lCs0Nb+XDcrtFaJ6Wg2T7VVJiKKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXi+WWvMZSDO83Wf1oP0xw/6mjcFxV7YB77eIQG9+PBAtRifc
	6grAtYS79C9W6AKToks0SpHfMKXvo/a6EntYqBS9Z1rlRvXH6PWwQ/wLa9oQhHwilQ8WzvddAYF
	HHYLoYwQhF8hkSbCHoVDLKjCSOK59gfOJTmOwUl7hYDTDzSf6JeITJKGhfQ==
X-Gm-Gg: AeBDiesO6euEGtapI3UN5PZiGTejtKICPHq0uFZN7YJEnb6+34Vxo8vpftw4dup/P3X
	fWdNpi9BX2iPOdEXLSy6eLNj6U/lnbmR9lowl7c+eUkDx6L/oeEtbJZxydVRLfN9IrfvDdboAvy
	kKjgGPdu4ejAo/aAPmBJ6UeEwUp0Ow2YoeR56l7OkY3N2hVd+9r7HOktyjL9G0YQTq/1HbcJTmT
	efGYKU6NBaRI55Qiu+LBdl2ge48tgAG952UwwsrLuVc/hcGpWrLff85QwVMVz04OPr063U8bu//
	nqgCGSFQwONhx4VPpoM2YSimXSAljn7IYKi9J0brCalWccnPXduP3b9DYFnTFm8S1Q23fINZYH1
	2ilxGczWoP/ucQJ1LjSH8Ut28jUWbIz+4HE5Vstn62AZIM9/x3iD+rFtcaycYciWiUy3Vdarox+
	cWErp63g==
X-Received: by 2002:a05:600c:a106:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-488d685fcf7mr215995665e9.22.1776267663579;
        Wed, 15 Apr 2026 08:41:03 -0700 (PDT)
X-Received: by 2002:a05:600c:a106:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-488d685fcf7mr215995085e9.22.1776267662938;
        Wed, 15 Apr 2026 08:41:02 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm6314894f8f.20.2026.04.15.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:41:02 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:40:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad-xdCce7fPbBeyP@sgarzare-redhat>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
 <20260415-fix_peek-v4-2-8207e872759e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260415-fix_peek-v4-2-8207e872759e@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278830-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C72D406080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 05:09:29PM +0200, Luigi Leonardi wrote:
>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>`recv` until all requested bytes are available or an error occurs.
>
>The problem is how it calculates the number of bytes read: MSG_PEEK
>doesn't consume any bytes and will re-read the same bytes from the buffer
>head, so summing the return value every time is wrong.
>
>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if more
>bytes are requested than are available, the loop will never terminate,
>because `recv` will never return EOF. For this reason, we need to compare
>the number of bytes read with the number of bytes expected.
>
>Add a check: if the MSG_PEEK flag is present, update the byte counter and
>break out of the loop only after at least the expected number of bytes
>have been received; otherwise, retry after a short delay to avoid
>consuming too many CPU cycles.
>
>This allows us to simplify the `test_stream_credit_update_test` by
>reusing `recv_buf`, like some other tests already do.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       | 15 +++++++++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


