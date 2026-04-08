Return-Path: <netdev+bounces-276421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AsaMxIo1mnqBQgAu9opvQ
	(envelope-from <netdev+bounces-276421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:04:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4EC3BA3D0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC218300CA3D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDE39F192;
	Wed,  8 Apr 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDfDZ6VE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dW37Um0y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C73ACA45
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642632; cv=none; b=ZNYL/U7yzJzUMBJFmbuCUWM6oyW6y3s/Pc7PQrrz7l7Syics/Zrx3xO7s2iVEstAJSE0BXHOuqKSL2LMthimz3ozqiUQ2S/0hCkE8BfJsbL4gq93owQzzHLJOPSKvhOenlCq2j+E2pUeN+hnTS3LkTwgoKUUhSGADKCSqGzDf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642632; c=relaxed/simple;
	bh=o4+1SC+5gK72xbVuKMA8stLflF08ngrXS2p6EHL26qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDpQxw8UVJ4LD/gi7zayFEid371hIKJ5e2CtGEqZznzWSMEwZ5ZO26SmzIn0PfpA4N5lFCyYSp9Si3wYi9Cndzplv5ADJ63c+H35ue3WsmZjB3qwjHRK6nTV9Jcnfc2HO2/JUUx+0ZVxwu6enSH/M4dygAofe7OAVPvpx0FVWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDfDZ6VE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dW37Um0y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775642622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
	b=gDfDZ6VEH4OgGWkxTxJwPZ2wMYOH0Zi5oTHPONIFST2YbBD5Q8ZtRiLLpyI0GHYNsR1QUb
	5/Iy+fGWlHEg7cAoyjaeGn13rRQXbyW0gvJ6E2LDUAKimgUAXm/8Fsze/SF+lyWC8kDEnp
	A+ugLuY4rZEa7xBaYLzR3AI2pFNiew0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-pDuzeNNVNh-FpRz1Q22dpw-1; Wed, 08 Apr 2026 06:03:41 -0400
X-MC-Unique: pDuzeNNVNh-FpRz1Q22dpw-1
X-Mimecast-MFC-AGG-ID: pDuzeNNVNh-FpRz1Q22dpw_1775642620
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4887d32788bso48139535e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775642620; x=1776247420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
        b=dW37Um0yJUwUNhEWHFvWOPzxRIKwRzMfQpEfBAq6y6MxUk9oq2bjDjM132CtYH5OfC
         gDrphBEEtfCVA3wVX62QsAj47st6CF876JooMhBisLtCYKb9A8aEG22BHQH5Et3XmTrm
         5magswqJI0GV3z5gbtTSgAe1J9KlQm4tEEDENi1q32lKSeisnghGD3q+UD6SNxiKuVX9
         uOuNehhXKWXPs23jEop/hjgaBmfYGJO35FFOuCNQV/g5mg89L3PJS7hdi8Nm6ciNFIYV
         PKxysaVtIiANmpHcG74MrJfGFB0LW0nMTOTQV3FiHZIR0X8d+x6lYUvjhU2TEVMRzAIW
         V/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642620; x=1776247420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
        b=HlRSrhl+CR0XHXUX7BqR7ZXC7KEp6Fdt59ZAjRv+Ge91Y7VwzMpUKbMdnflpnxFuKN
         CR1qo2e+IP+HAODqiiW8IE7ks0UaS6Q5AuGYuY1VCUvM4CUfVbABtBLMylQr4s3UpxLv
         8sugBtMkq1rrap3OaViRq1bKEnENITPonM8XEy9LBIwM7cB0KoZpG21MotuW9DKc8M8r
         3fkNPw1ZWKWH7bK5WKP04SZ/CEIyuooGiBy3ma6QQu1IAEQeRpXhhxrpXJA4fRKgaWgz
         XjBXHOxsQThDTTsLEUjJru/abZh9t3wuBzS+4/R9VXhou+PWpijdQc9p/5yLT8eTqhV/
         8ONg==
X-Forwarded-Encrypted: i=1; AJvYcCXRTQzDihNZKR5J02d9gTE3XCeRWlGx9PuJa1JwsuK73MLxqX6S54JQy4WDfNlrRl30E+mgY/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNHv7F4GSA04ZPPh248lQoGL26TB5TjyaJo/xqcpGY7YcL+Lu
	ZG0yEkaTedHxdFXR2rlCuUJWLqdNWk1sfSswK9BM99uI7sab4VkJazaIVbhJmtOezeAxYO+Os2o
	QX5wLuhCO8aGYHmu9IrhEu5YIjslALxKOyzJMPeMJxH3q6kNsUYKdzPp3ig==
X-Gm-Gg: AeBDies0+RCLqT1slTdfkw3dOcFiCfyai7gqSuVPsjJPMfYbtxcIxVvgO91T9aA4WCK
	PMBucFS5MpDcEQDQ7osWfaujeU33lLl5W31JFALSQrsfGo/m48JgalPhTjUpk2+4BZ8Ne/+sO+9
	b/lBSLCbh8SbTgkxkj6ks6NyoexzoyW4S9dZ+XUveQv7GsFnglOudNqWdwsv92qenTCNcG/CS51
	0O6NeTYILGFcnAPC6HLm8j9kAoSQ7timzW8DYFakeRD8agEwuOxvF4s2PLktN3QjKsiXlRhI/N7
	y8k6BvkLeqgkAduE6hi/aRoybDwuFqT/JnjduBjvHsyug63LijXLDhaSSjUSrd42lgQC/Kd6Me3
	AWlPlRUu0/KBv3agp6KKA/9QlMJxQWJ3WOQQu04zn4FjtTFTS/BaIHBwgCo6RSqzP+BI2TsAEUw
	==
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr291773245e9.23.1775642620054;
        Wed, 08 Apr 2026 03:03:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr291772635e9.23.1775642619553;
        Wed, 08 Apr 2026 03:03:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b0c53a27sm229454385e9.7.2026.04.08.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:03:38 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:03:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] vsock/test: handle MSG_PEEK in `recv_buf`
Message-ID: <adYkNiNL18aOv74T@sgarzare-redhat>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
 <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276421-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 6A4EC3BA3D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:13:56AM +0200, Luigi Leonardi wrote:
>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>`recv` until all requested bytes are available or an error occurs.
>
>The problem is how it calculates the amount of bytes read: MSG_PEEK
>doesn't consume any bytes, will re-read the same bytes from the buffer
>head, so, summing the return value every time is wrong.
>
>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>requested amount is more than the bytes available, the loop will never
>terminate, because `recv` will never return EOF. For this reason we need
>to compare the amount of read bytes with the number of bytes expected.
>
>Add a check, and if the MSG_PEEK flag is present, update the counter of
>read bytes differently, and break if we read the expected amount.
>
>This allows us to simplify the `test_stream_credit_update_test`, by
>reusing `recv_buf`.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       |  8 ++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 9 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 9430ef5b8bc3..f12425ca99ed 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -399,6 +399,14 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		if (ret == 0 || (ret < 0 && errno != EINTR))
> 			break;
>

We should add a comment here or even better in the documentation on top 
of the function to explain better this behaviour for future reference.

>+		if (flags & MSG_PEEK) {
>+			if (ret == expected_ret) {
>+				nread = ret;
>+				break;
>+			}

Not that I expect this to happen often, but I wonder if it would be 
better to add a `timeout_usleep()` here to avoid using up too many CPU 
cycles.

>+			continue;
>+		}
>+
> 		nread += ret;
> 	} while (nread < len);
> 	timeout_end();
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5bd20ccd9335..bdb0754965df 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	}
>
> 	/* Wait until there will be 128KB of data in rx queue. */
>-	while (1) {
>-		ssize_t res;
>-
>-		res = recv(fd, buf, buf_size, MSG_PEEK);
>-		if (res == buf_size)
>-			break;
>-
>-		if (res <= 0) {
>-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>-			exit(EXIT_FAILURE);
>-		}
>-	}
>+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);

Not sure about this change in this patch, but since they are just tests 
it could be fine.

mmm, on a second thought, we already used recv_buf() with MSG_PEEK in 
several other tests, so yep, better to add this change, but I'd make 
more clear in the commit title/description that this is at the end a fix 
for other tests using MSG_PEEK with recv_buf(), I mean something like 
this:

     vsock/test: fix MSG_PEEK handling in recv_buf()

And also pointing out that other tests already used MSG_PEEK with 
recv_buf(), but it can be broken in some cases.

Thanks,
Stefano


