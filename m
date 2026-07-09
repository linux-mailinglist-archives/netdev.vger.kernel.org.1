Return-Path: <netdev+bounces-306359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BXpIK6b7T2r8rQIAu9opvQ
	(envelope-from <netdev+bounces-306359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1215735302
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:51:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FwNGK9BU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306359-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306359-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94599301177F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 19:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE53B8BA4;
	Thu,  9 Jul 2026 19:49:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2739BFE6
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 19:49:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626543; cv=none; b=tix6ntnpXFQPgURxRwU68CQ493SDIZMP4qkif0bQn5spzFPdTmdEfv18poFjN+ayHgNjvfXuX5Y6u2WzfCYFw4RV9xgpieddZhX4RrTyd+fd9HGnjqSVRRajUyWAmWlM1hvvT3TzpScxw/PpH+vK5VteaX+VXofAOJi7XT956vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626543; c=relaxed/simple;
	bh=UFc5NYkNHpWBb0ABwv4btzCtbc/6m2TSiIZHIWB4Gls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldWU80XZCYiRvBOrTwxT/WIZCX62cQh5AIZLE8kjTh9wWHeSOErEK7RXQz1vDFO2CGtw6XkWITXmlr9Kvx5spQXOgbbSoolaWxZkpirmD062AmoFc96kCfLmuoomYu47BgPe08SH7Eyj6KdzzGzxQIYssAM9NF2GwHI/8Qh45+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwNGK9BU; arc=none smtp.client-ip=209.85.161.45
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a30bcadd96so171069eaf.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626541; x=1784231341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/r3c0ypjapIfRHS5El1n40WfDRGvPfw2APfHzflGpQ=;
        b=FwNGK9BUpzpo/XE9+lBzpbBDrj7G4mJ/UZ9X3eT+vqXAqjRBDLs4WhwFUveDXBpmby
         LZ6rK44oj+rNd7azZPzHZXZOyXQECtWUeisNPed9gPRthHn3xu8BeuQg7P4K1KIf03kc
         89ZmF1MsEzjxbf+MxLqKvDi+Z9tUt4ZkSipGua5lsyFmMg30SRG4a8GAwgwD95gx4jgJ
         Xo/e7hGc60qKo2Uq6/oR9PKzANXjmX4VWwQ5sCHBOK0KBcvzKLMdkESGmYqPGOS96lEg
         BROe1/ozgOGx+M0t1XvfcXk2WEklbFjteFfDqsY2WaFKal54CRmbg7X1CvxK+sQ0k0iY
         5V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626541; x=1784231341;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/r3c0ypjapIfRHS5El1n40WfDRGvPfw2APfHzflGpQ=;
        b=qK/rhmUrIC3KMz90xSlr+8pUIHZfM9krQs+5xCj0a0TzzHmuBGOXnT2hzX+oBlS49w
         KCOOZbbNRt4sMzMf3jF1ppc8dqXAnpmFQ313c0HLpQeAPxtqYn0R6UQS9S8NQu5p+wQv
         1sG3cFhDLEuHmSNvAz5NmM3cG3OxAsmuoAJl3iCuL2CSNc243iVLKoeDkudkbZd8z3OP
         bMeC3tObLqAy/s9FauJUVEMU2KRug/NAJFrwJffYTf3JKzErAbGeHQ1VDPEyRYidqjUh
         bsDET5qirS4vU0laa4yqtF+s7Q4/WMFJL+jHxAKEg+E7jajf+p2seqtc+uAoqJzAQ8zU
         GNZQ==
X-Gm-Message-State: AOJu0YxskcO1ZCU2uAQXJknnjyzfpyHjJyJye5qZdLbE1XP+PU/1qs9D
	5FrrXvg39/+hf7amID7sRolUqeg29MtrELSD9hCQcBo9+6QcISKJqlWB
X-Gm-Gg: AfdE7cmjCgl9WsJ9Pe2Kxngftv/EQnpAB01mhevdZjt+8QrSsIeSMT4dUEKqwyYvzDl
	UU6RIhmtVvFMV08Adg4I1phUCTvjaP6iUmk6UmzmCxDrlWEl93mtRua7JFGBqzurQZ0xz4qWZQ6
	NoquvOeInjHsNpEmh+x4nYG4ChtuynoWlZdyUW64Z7X2DcM0KxXSnbVYWpIR8V4AGsmpRNK+57S
	BJ14zwxZMn8vsA0Jmq2VHX8vBGG8HiHY/4hiVn3XRC3TnPrQNa1hku45zv5LqKrI/Fb8nDWuzKj
	C3V57MWzdYB1w0XRn+xSMKgnUGzJD8lNzLTHDdsYTj+L6eHp6dd9Sn3mlZkRgPUFWHIRnVflxPg
	e3NTLHND2oxvl4Nj2SM5PQg/T1NPHV6KTIchEFQ5+YGkwi1z0e89Xp8nkDV00jaqdU6c7nhRgS7
	oIxCUOferD3In90s873A8vRXpah3L4aeVp
X-Received: by 2002:a05:6820:992:b0:69e:97da:285a with SMTP id 006d021491bc7-6a36d98dd7dmr6355429eaf.29.1783626540946;
        Thu, 09 Jul 2026 12:49:00 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a66b668sm4932299eaf.8.2026.07.09.12.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:49:00 -0700 (PDT)
Date: Thu, 9 Jul 2026 12:48:57 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <ak/7KFNi7CJzgbX6@devvm29614.prn0.facebook.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708102904.50732-3-sgarzare@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306359-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:jasowangio@gmail.com,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:eperezma@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:kvm@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,google.com,redhat.com,kernel.org,davemloft.net,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1215735302

On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add a test that sends 2 MB of data using randomly sized small packets
> (129-512 bytes) over a SOCK_STREAM connection. Packets above
> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
> forcing each one into its own skb.
> 
> Without receive queue collapsing, the per-skb overhead eventually
> exceeds buf_alloc and the connection is reset. The test verifies
> that all data arrives and that content integrity is preserved.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 76be0e4a7f0e..b4ff9f946565 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
>  	close(fd);
>  }
>  
> +/* Test that many small packets don't cause a connection reset under pressure
> + * and that data integrity is preserved.  Packet sizes vary randomly between
> + * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
> + * in recv_enqueue, forcing each one into its own skb.  Without receive queue
> + * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
> + * connection is reset.
> + */
> +#define COLLAPSE_PKT_MIN 129
> +#define COLLAPSE_PKT_MAX 512
> +#define COLLAPSE_TOTAL (2 * 1024 * 1024)
> +
> +static void test_stream_collapse_client(const struct test_opts *opts)
> +{
> +	unsigned char *data;
> +	unsigned long hash;
> +	size_t offset = 0;
> +	int i, fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 0; i < COLLAPSE_TOTAL; i++)
> +		data[i] = rand() & 0xff;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	while (offset < COLLAPSE_TOTAL) {
> +		size_t pkt_size = COLLAPSE_PKT_MIN +
> +			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
> +
> +		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
> +
> +		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
> +		offset += pkt_size;
> +	}
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	control_writeulong(hash);
> +
> +	free(data);
> +	close(fd);
> +}
> +
> +static void test_stream_collapse_server(const struct test_opts *opts)
> +{
> +	unsigned long hash, remote_hash;
> +	unsigned char *data;
> +	int fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> +	if (fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	remote_hash = control_readulong();
> +	if (hash != remote_hash) {
> +		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
> +			hash, remote_hash);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	free(data);
> +	close(fd);
> +}
> +
>  static struct test_case test_cases[] = {
>  	{
>  		.name = "SOCK_STREAM connection reset",
> @@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
>  		.run_client = test_stream_msg_peek_client,
>  		.run_server = test_stream_peek_after_recv_server,
>  	},
> +	{
> +		.name = "SOCK_STREAM small packets backpressure",
> +		.run_client = test_stream_collapse_client,
> +		.run_server = test_stream_collapse_server,
> +	},
>  	{},
>  };
>  
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

