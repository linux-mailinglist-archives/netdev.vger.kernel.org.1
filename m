Return-Path: <netdev+bounces-278756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCsZOsh832lAUAAAu9opvQ
	(envelope-from <netdev+bounces-278756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:55:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9BE404100
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B32E3010911
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101E37C109;
	Wed, 15 Apr 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNJeWyvg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="POQMktme"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349BB34B693
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254097; cv=none; b=DLbJmAVG2j/Qb4uWvi62IMS/6yIHP6OQZ6vy3X8dbioylyrgiPfZ5H21LCXIDr1RwIOVrLhSxGCtchLgqAFK3WNVu/bE9OURapxp3BoAIf9Wx/aaLOXihYqjfxt4BgC0VAxXNVM7mQePm4f42+P3rakcnqT9E4nDyz1fP4rY/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254097; c=relaxed/simple;
	bh=IhundK6gvmdpIbwTKJkzDNzcKDA2uur/VnVrMcwemEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSCwxE5Ca2ZiJs38sm2tnySUlM+noFUtp8uuwzLaGuHgLM37k/jUyqublEeyh2tIXjf2Y6HjJgzJeFUzOG6XcudQV571dk0uoSS7JbHhqOPL958ofEAcUaS1wPB1vBreVJM76NFQ5IiRjTJ1kdV/AGvrAp4C5MP88LbwIuP0RZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNJeWyvg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=POQMktme; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776254095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
	b=TNJeWyvgXt47PAoVCZ26U/ITKYba1KnuvK4JL98UQiI5UPgUM0EHGK+SLn9z0Tyi59B2FX
	yR03GMnGv8PQAm7vz0QUsOiE/8qWuxY1Szgb5BjHFK6fNzDclkKXOxjnOd4ndmLg6Aq1m9
	StCUXHPkc2huYELElYdQsjtcr82eEVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-wx2-XcQJOgy2cu2u2W3ogA-1; Wed, 15 Apr 2026 07:54:54 -0400
X-MC-Unique: wx2-XcQJOgy2cu2u2W3ogA-1
X-Mimecast-MFC-AGG-ID: wx2-XcQJOgy2cu2u2W3ogA_1776254093
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d56f87e8so40381915e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 04:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776254093; x=1776858893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
        b=POQMktmeR77UJQ5tzSfoHErVyKUoI0Mk/GBD6UxFQsCwZE1d6tNYfkzpQDVcumcwWA
         ZqrhPr4mh9lruF9OO6LCzD3iH9Kb12ASWS+i66wPZbAmjulW1T/J8A7KCCTv1WnspXci
         hGhH5NIxbOQLEmCm9FFdkwJPGOHz2z7LAE/ttDJWI8zA0FCo45i6NqocTBQQHimtfUY3
         a/7q0SbOvTGrXGJWgvWAGuIk5+8UhwUCJ6XSJKu2AbrJQy7pUBVglx6fQI0H4IMvONbv
         iGcfIXSKhRurFm4LY44ssk20XdVqmEQUWPhIlBGdVYPcLWxBxWuecowZ/hut2Rv6TS4Q
         08xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776254093; x=1776858893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
        b=rPz+NOzCE84690Z8XE4DHh6H+Yv3EmYp3hN+zoMH6UFUprR10ZEBTTQvspsW9J8uiO
         /MbNkVs4rvzWXmWMjt/J7AgG6pQ2IBWhwHf1fWBEG1HUyZ6EJ85xK3fN3ZakNbd33Z74
         zfHFIifoOI+3w1N8roqz8nnfo+ix7yAzqprbJmoF8PMkUm6ZNZVNWTVu8riNfJ344Pgt
         qPs2rhb/m0sHMgtz1kq/8rGHbbJF7K2CrHqeqJEdHd+XR8tWZ4U7ggyG8SUX7Z2ynjpA
         h8ebXtfitzZ3uc1Y+cez6hz2mof61i276Gdfk8WUJbda9xr0IApVhpvc35Yj9kKpa2Pz
         nb1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8mPhi3iooYXMKfCBNPVx27Fa5XQ3pWddp1akgSTuIU5LKRuyk6Zm/VBYhb5JWKYWalkec3KsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHu25bqDxdbHseXtSEOQO/NXOGrEEKjHAKS9Z5D53ObH5ZV6O
	fASS7QrVzEhKYpbfmg4HR9rWw/tXmNBNWfsO/l4jmbsari4dFljy/BIbpY6frt8jWiFw7u7Q6g6
	Cum+nL2u5cZK9UoX8qGsLzbnjAa70EdjlUd9Lc7rJgen0I4ldP5PqJQ/8bA==
X-Gm-Gg: AeBDiesKahcLeTrbyHLqjc4ZbUY/rxv3FrW3hWRTzVfXDl4D7yK5eFSYGxH8iyFSQ1J
	zaNWZXzlqoHVEC+No+lRVDwYhEvf9lptAx62J+R+6AgOpt6z/41OQF1k6mYvy/NY6jHpG4Elrpv
	OIRtBXSQCpaMHPrURgM2nvVa2IkWKftG7XBUM6cmp0w9yPebvPKKsT2t57mQ/7U/9OFrw4L1jb1
	xvm7TpxwakZFVQPPt2Pk97ORghDw4LUSVlbRhp46Q4VuJr0xgIUH9S5QFpIopKL/S4iZPBrsiW8
	rl14omGPH7LNtxmiBu7MLCp7IWDnOqx8D5SxhX9/TBA1vqqpoat3i++wHmw/r5trijOVM/vppUX
	3Cyde6euWgKkI6OZ6I8CyNYCT0jALInKI740foH3qOw4LHMJ3Lo5h5MYLSykPSsZWOIZxC+C+cN
	1lVsOltQ==
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr301858485e9.2.1776254092778;
        Wed, 15 Apr 2026 04:54:52 -0700 (PDT)
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr301858195e9.2.1776254092308;
        Wed, 15 Apr 2026 04:54:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee038752sm128635425e9.9.2026.04.15.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:54:51 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:54:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad96TgXHW_jKitls@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
 <ad9uYrUjgCkW1D_k@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9uYrUjgCkW1D_k@sgarzare-redhat>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278756-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC9BE404100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:31:11PM +0200, Stefano Garzarella wrote:
>On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>>`recv` until all requested bytes are available or an error occurs.
>>
>>The problem is how it calculates the amount of bytes read: MSG_PEEK
>>doesn't consume any bytes, will re-read the same bytes from the buffer
>>head, so, summing the return value every time is wrong.
>>
>>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>>requested amount is more than the bytes available, the loop will never
>>terminate, because `recv` will never return EOF. For this reason we need
>>to compare the amount of read bytes with the number of bytes expected.
>>
>>Add a check, and if the MSG_PEEK flag is present, update the counter of
>>read bytes differently, and break if we read the expected amount.
>
>nit: "..., update the counter for bytes read only after all expected
>bytes have been read and break out of the loop; otherwise, try again
>after a short delay to avoid consuming too many CPU cycles."
>
>>
>>This allows us to simplify the `test_stream_credit_update_test`, by
>>reusing `recv_buf`, like some other tests already do.
>>
>>This also fixes callers that pass MSG_PEEK to recv_buf().
>
>nit: this is implicit from the first part of the description.
>
>>
>>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>tools/testing/vsock/util.c       | 15 +++++++++++++++
>>tools/testing/vsock/vsock_test.c | 13 +------------
>>2 files changed, 16 insertions(+), 12 deletions(-)
>>
>>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>index 1fe1338c79cd..2c9ee3210090 100644
>>--- a/tools/testing/vsock/util.c
>>+++ b/tools/testing/vsock/util.c
>>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
>>	}
>>}
>>
>>+#define RECV_PEEK_RETRY_USEC 10
>
>10 usec IMO are a bit low, it could be the same order of the syscalls 
>involved in the loop, I'd go to some milliseconds like we do for 
>SEND_SLEEP_USEC.
>
>>+
>>/* Receive bytes in a buffer and check the return value.
>>+ *
>>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>>+ * reads cannot be summed. Instead, the function retries until recv() returns
>>+ * exactly expected_ret bytes in a single call.
>
>I'd replace with something like this:
>
>   * When MSG_PEEK is set, recv() is retried until it returns exactly
>   * expected_ret bytes. The function returns on error, EOF, or timeout
>   * as usual.
>
>Thanks,
>Stefano
>
>> *
>> * expected_ret:
>> *  <0 Negative errno (for testing errors)
>>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>>		if (ret <= 0)
>>			break;
>>
>>+		if (flags & MSG_PEEK) {
>>+			if (ret == expected_ret) {

On second thought, I think it would be more appropriate to check for
`ret >= expected_ret` here, because all subsequent recv() will
definitely return more bytes, so there’s no point in continuing the
loop... and anyway, we’ll check the result later, so just that change
should be fine.

And of course I'd update the comment on top in this way:

    * When MSG_PEEK is set, recv() is retried until it returns at least
    * expected_ret bytes. The function returns on error, EOF, or timeout
    * as usual.

Thanks,
Stefano

>>+				nread = ret;
>>+				break;
>>+			}
>>+			timeout_usleep(RECV_PEEK_RETRY_USEC);
>>+			continue;
>>+		}
>>+
>>		nread += ret;
>>	} while (nread < len);
>>	timeout_end();
>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>index 5bd20ccd9335..bdb0754965df 100644
>>--- a/tools/testing/vsock/vsock_test.c
>>+++ b/tools/testing/vsock/vsock_test.c
>>@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>>	}
>>
>>	/* Wait until there will be 128KB of data in rx queue. */
>>-	while (1) {
>>-		ssize_t res;
>>-
>>-		res = recv(fd, buf, buf_size, MSG_PEEK);
>>-		if (res == buf_size)
>>-			break;
>>-
>>-		if (res <= 0) {
>>-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>>-			exit(EXIT_FAILURE);
>>-		}
>>-	}
>>+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
>>
>>	/* There is 128KB of data in the socket's rx queue, dequeue first
>>	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>>
>>-- 
>>2.53.0
>>


