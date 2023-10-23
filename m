Return-Path: <netdev+bounces-43481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217757D38CE
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF3628133F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615619BC0;
	Mon, 23 Oct 2023 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C11B26B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:03:51 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F7C2
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:03:49 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-orEJjE89OeeGCSgho3wybg-1; Mon,
 23 Oct 2023 10:03:28 -0400
X-MC-Unique: orEJjE89OeeGCSgho3wybg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59E171C11703;
	Mon, 23 Oct 2023 14:03:14 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E23111D784;
	Mon, 23 Oct 2023 14:03:12 +0000 (UTC)
Date: Mon, 23 Oct 2023 16:03:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangyu Hua <hbh25y@gmail.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <ZTZ9H4aDB45RzrFD@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023080611.19244-1-hbh25y@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

2023-10-23, 16:06:11 +0800, Hangyu Hua wrote:
> tls_rx_one_record can be called in tls_sw_splice_read and tls_sw_read_sock
> with msg being NULL. This may lead to null pointer dereferences in
> tls_decrypt_device and tls_decrypt_sw.
> 
> Fix this by adding a check.

Have you actually hit this NULL dereference? I don't see how it can
happen.

darg->zc is 0 in both cases, so tls_decrypt_device doesn't call
skb_copy_datagram_msg.

tls_decrypt_sw will call tls_decrypt_sg with out_iov = &msg->msg_iter
(a bogus pointer but no NULL deref yet), and darg->zc is still
0. tls_decrypt_sg skips the use of out_iov/out_sg and allocates
clear_skb, and the next place where it would use out_iov is skipped
because we have clear_skb.

Relevant parts of tls_decrypt_sg:

static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
			  struct scatterlist *out_sg,
			  struct tls_decrypt_arg *darg)
{
[...]
	if (darg->zc && (out_iov || out_sg)) {
		clear_skb = NULL;
[...]
	} else {
		darg->zc = false;

		clear_skb = tls_alloc_clrtxt_skb(sk, skb, rxm->full_len);
[...]
	}

[...]
	if (err < 0)
		goto exit_free;

	if (clear_skb) {
		sg_init_table(sgout, n_sgout);
		sg_set_buf(&sgout[0], dctx->aad, prot->aad_size);

		err = skb_to_sgvec(clear_skb, &sgout[1], prot->prepend_size,
				   data_len + prot->tail_size);
		if (err < 0)
			goto exit_free;
	} else if (out_iov) {
[...]
	} else if (out_sg) {
		memcpy(sgout, out_sg, n_sgout * sizeof(*sgout));
	}
[...]
}

-- 
Sabrina


