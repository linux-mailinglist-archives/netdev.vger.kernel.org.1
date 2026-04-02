Return-Path: <netdev+bounces-274549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B4DHg1wzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:33:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647CD389C97
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07A86304EF8A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D48D313298;
	Thu,  2 Apr 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfXr5cxK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qGoNj/5B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB82BF3F3
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136524; cv=none; b=H8DVu7gI3MlALkrmRUtlCwmYxPmOTzta2q7Y8YAUdJOTNLAYdGasjiNjvCfXX0wImm5RNUstp8PkSkUwlQOqctSbMauNna01g6mV/Jv7XB7zog0rf5jNMuuIbjmbRqwipzaDSijNqSzBjR4xkNZ3Hbv5Tm25h+eA8nrFat3F5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136524; c=relaxed/simple;
	bh=gGY/VwPUMO0SWDMiHLhnA/IVkYO3C7UOkCh7m+DwrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGKs51gqNDNt+56bx/GCHWgOopnb7B0MXgbXDRK+iGp0Ki3b45wfOcUvV4UdVlc6QfDr1Oz0Fdk/5ZkHtor71bkVPi48nEt0a6xghE8sten/ZlzJsXQwp/Y8aIdu0B4Q6SSv2abhqMLOGZSfQSPbA0tdZmg/PfcIa6IMOtW4wd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfXr5cxK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qGoNj/5B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775136520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
	b=FfXr5cxKtseQvhlftxRxqMTd17uSed8zW/N1vrrQILDgAMpS0YFvFToTz83fQKS6+0WmgD
	P94Dj5MnVxtENTrOZkkv+AmH7UwpocSjG7gN7xhOVQc8Dk8Hmk0LE9qLIzaqEvvbd9lft3
	ReF8X1W+mNtmAx9kMS+TFbqQE01cKuI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-vcpoLi6dMyGFms1kM8uq-g-1; Thu, 02 Apr 2026 09:28:39 -0400
X-MC-Unique: vcpoLi6dMyGFms1kM8uq-g-1
X-Mimecast-MFC-AGG-ID: vcpoLi6dMyGFms1kM8uq-g_1775136518
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d06133455so530526f8f.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775136518; x=1775741318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
        b=qGoNj/5BoZQ/TZsnU6J6WgpmzC/LkxUNcLo2ra+Ee909d2xOeE0md5kSKgbwcDJe2q
         2C0aAIV+IqqQ4xwKvhOEUUeW4KRP0VxYIjHEPHLap5pCsgqU5orG232wF5cyh9zSyro9
         A34stdUq+QTW1QxrWA8LQUNXC//UJUlocWBBB/ZxPyFMmch7PNqlZc18rnfVUkWF8zET
         7SnKZu4wGzrQ+scPi9nM+d7qDtMV5i9hOq/Gj8XROW0xqlJzkvWgKE4De++NRNHYyNfH
         4lBBT2H1GGNom6zGfWZly+aewNjBrkUhgd1aTPjHFtDBJgH5yBM/lBydp5q0qCHLQNHo
         Hgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136518; x=1775741318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
        b=lWxRFCONGHkDKlgK1qfpFlPSPeUgwlLBMdpa1KyVV20vAPgffycQi8795DHrj4/icK
         FXKkAlGG0dQ/n2jFEK/NWXrt02Tq9L7NAV+ReYV8gZJmN6PWwEEk7PshwAopkE2a8BAs
         hMeegg+kTCj0o1o8Eu2on52Zmd+FAxnEoP1RKG807dwV6iOLjzIWuKgKoxhwBbfvubDX
         khOgQO0O3WjcNkVJcue69p60lBHbm9Ndmg68vvOm5PfCbX0tw27Zv/Wtrs179UzHe9y7
         UUaKlmMdRJ8WFvwbuZGP5Tn13vBnNfRZaQI2EC+x/N0FvScIdsu4a/gf4BB8n8SSQlQ4
         M81A==
X-Forwarded-Encrypted: i=1; AJvYcCWVlITA7lRMybCzIGRSZa9EMMSLgpzsLKlLTx3qxQcJmIMB5Pezp7qg2mxggq+fLrPlLiUf1+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1qYxkwUZM1XWGZpMysnF8pJkWwuZVpp5LNwqL15Jmb1VaPLa
	+aoNSOCnb+/DvlAirUvfbh5OUkAXkcawnHXN14BeULaFJlhfjOV2XwQROcdhIfgHgU9wu/qjMSy
	psKcQCrrhvlYJKOBAS9SQa3P2Avu8K9gKx/C3lHN9/+p1O57rj3lF2c+qPA==
X-Gm-Gg: ATEYQzw9Z7+5mL0AK+yo1/DFNqMHjZjspa0/TWIkCX0glCZzsStMeqqWKCq1pCEtpzT
	KTy21ccyN/DnNcwBTHwfeGsEIc5qZXWzkbc4uTmRmOmojWdILwfCaQxcXvRszlCiRw+5orfhh5+
	VKFxMZlT/qbo17j0asC7NmNcVkbNheRAsZoer95T9gJlJcO6jVga5SSEoRG9f46PMVJjmweuQb2
	Pt9dZmI+NRh3QnOWyNE9QhV3j2T+vxQBJ31PqWWm64OvwhZeE/5gIi5YE4+mwX5Qkev5CFioJc4
	nOdmsyvDU4Yx3FcerLPFj+YBeOdToAcDFvFXIdDKxmWJRRcxNMNkKVhCOYkU1oIny8HXhKO8rrd
	qCu1L4G7s132/RyRbeP1A05aHgUB4hcxSHGe7Yj/1A2cC1phvXLH6Zu49utuw7/0QLpDnUbxufD
	DD
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr140993725e9.29.1775136517994;
        Thu, 02 Apr 2026 06:28:37 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr140992975e9.29.1775136517515;
        Thu, 02 Apr 2026 06:28:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm244763235e9.0.2026.04.02.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:28:36 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:28:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <ac5qWSEBM--HuKQK@sgarzare-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274549-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 647CD389C97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:18:02AM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the `virtio_transport_stream_do_peek()`

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#11: This is to test a bug that was present in the 
`virtio_transport_stream_do_peek()`

>when computing the number of bytes to copy: After a partial read, the
>peek function didn't take into consideration the number of bytes that
>were already read. So peeking the whole buffer would cause a out-of-bounds read,
>that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 64 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+#define PEEK_AFTER_RECV_LEN 100

Why 100 ?
Better to use a power of 2 IMO like we do in all other cases IIRC.

>+
>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>+{
>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>+	int fd;
>+	int i;

nit: int fd, i;

>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < sizeof(buf); i++)
>+		buf[i] = (unsigned char)i;

Why setting the payload in this way ? Can we just do a memset() ?

>+
>+	control_expectln("SRVREADY");

Why we need this barrier ?

>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+
>+	close(fd);
>+}
>+
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>+	int half = PEEK_AFTER_RECV_LEN / 2;
>+	ssize_t ret;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SRVREADY");
>+
>+	/* Partial recv to advance offset within the skb */
>+	recv_buf(fd, buf, half, 0, half);

Why reading half of the size ?

IMO is better to read just 1 byte, since it is almost certain that an 
skb does not have a 1-byte payload.

>+
>+	/* Try to peek more than what remains: should return only 'half'

How we are sure that the sender sent all the bytes ?

>+	 * bytes. Note: we can't use recv_buf() because it loops until
>+	 * all requested bytes are returned.

Why this is a problem ? (an useful comment should explain the reason)

>+	 */
>+	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
>+	if (ret < 0) {

Should we handle EINTR like we do in recv_buf() ?
But I still don't understand why we can't use it directly.

Thanks,
Stefano

>+		perror("recv");
>+		exit(EXIT_FAILURE);
>+	} else if (ret != half) {
>+		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
>+			ret, half);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_tx_credit_bounds_client,
> 		.run_server = test_stream_tx_credit_bounds_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>+		.run_client = test_stream_peek_after_recv_client,
>+		.run_server = test_stream_peek_after_recv_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.53.0
>


