Return-Path: <netdev+bounces-32774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1679A6A0
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066DF1C208DC
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0EBE5D;
	Mon, 11 Sep 2023 09:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB169259B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:17:01 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA4CD2
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:16:59 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-_60d2C_gPcC0bagAINy8ZA-1; Mon, 11 Sep 2023 05:16:52 -0400
X-MC-Unique: _60d2C_gPcC0bagAINy8ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53AA38F40C3;
	Mon, 11 Sep 2023 09:16:52 +0000 (UTC)
Received: from hog (unknown [10.39.192.47])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BD8BF40C6EC0;
	Mon, 11 Sep 2023 09:16:50 +0000 (UTC)
Date: Mon, 11 Sep 2023 11:16:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Liu Jian <liujian56@huawei.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vfedorenko@novek.ru, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net/tls: do not free tls_rec on async operation
 in bpf_exec_tx_verdict()
Message-ID: <ZP7bAbz6I8L6Yirp@hog>
References: <20230909081434.2324940-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230909081434.2324940-1-liujian56@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-09, 16:14:34 +0800, Liu Jian wrote:
> I got the below warning when do fuzzing test:
> BUG: KASAN: null-ptr-deref in scatterwalk_copychunks+0x320/0x470
> Read of size 4 at addr 0000000000000008 by task kworker/u8:1/9
>=20
> CPU: 0 PID: 9 Comm: kworker/u8:1 Tainted: G           OE
> Hardware name: linux,dummy-virt (DT)
> Workqueue: pencrypt_parallel padata_parallel_worker
> Call trace:
>  dump_backtrace+0x0/0x420
>  show_stack+0x34/0x44
>  dump_stack+0x1d0/0x248
>  __kasan_report+0x138/0x140
>  kasan_report+0x44/0x6c
>  __asan_load4+0x94/0xd0
>  scatterwalk_copychunks+0x320/0x470
>  skcipher_next_slow+0x14c/0x290
>  skcipher_walk_next+0x2fc/0x480
>  skcipher_walk_first+0x9c/0x110
>  skcipher_walk_aead_common+0x380/0x440
>  skcipher_walk_aead_encrypt+0x54/0x70
>  ccm_encrypt+0x13c/0x4d0
>  crypto_aead_encrypt+0x7c/0xfc
>  pcrypt_aead_enc+0x28/0x84
>  padata_parallel_worker+0xd0/0x2dc
>  process_one_work+0x49c/0xbdc
>  worker_thread+0x124/0x880
>  kthread+0x210/0x260
>  ret_from_fork+0x10/0x18
>=20
> This is because the value of rec_seq of tls_crypto_info configured by the
> user program is too large, for example, 0xffffffffffffff. In addition, TL=
S
> is asynchronously accelerated. When tls_do_encryption() returns
> -EINPROGRESS and sk->sk_err is set to EBADMSG due to rec_seq overflow,
> skmsg is released before the asynchronous encryption process ends. As a
> result, the UAF problem occurs during the asynchronous processing of the
> encryption module.
>=20
> If the operation is asynchronous and the encryption module returns
> EINPROGRESS, do not free the record information.
>=20
> Fixes: 635d93981786 ("net/tls: free record only on encryption error")
> Signed-off-by: Liu Jian <liujian56@huawei.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


