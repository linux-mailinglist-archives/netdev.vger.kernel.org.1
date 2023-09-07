Return-Path: <netdev+bounces-32465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9A7797B47
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96CD1C20B2E
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862A413FEE;
	Thu,  7 Sep 2023 18:11:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA913AC3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:11:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5801FCC
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 11:11:40 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RhK5P6LZxzVkbg;
	Thu,  7 Sep 2023 20:57:13 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 20:59:52 +0800
Message-ID: <a6dec380-1ebc-d495-da67-7bd61525d4a8@huawei.com>
Date: Thu, 7 Sep 2023 20:59:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH net] tls: do not return error when the tls_bigint
 overflows in tls_advance_record_sn()
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <borisp@nvidia.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<vfedorenko@novek.ru>, <netdev@vger.kernel.org>
References: <20230906065237.2180187-1-liujian56@huawei.com>
 <ZPhcTQ3mFQYmTHet@hog>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <ZPhcTQ3mFQYmTHet@hog>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/6 19:02, Sabrina Dubroca wrote:
> 2023-09-06, 14:52:37 +0800, Liu Jian wrote:
>> This is because the value of rec_seq of tls_crypto_info configured by the
>> user program is too large, for example, 0xffffffffffffff. In addition, TLS
>> is asynchronously accelerated. When tls_do_encryption() returns
>> -EINPROGRESS and sk->sk_err is set to EBADMSG due to rec_seq overflow,
>> skmsg is released before the asynchronous encryption process ends. As a
>> result, the UAF problem occurs during the asynchronous processing of the
>> encryption module.
>>
>> I didn't see the rec_seq overflow causing other problems, so let's get rid
>> of the overflow error here.
>>
>> Fixes: 635d93981786 ("net/tls: free record only on encryption error")
>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>> ---
>>   net/tls/tls.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/net/tls/tls.h b/net/tls/tls.h
>> index 28a8c0e80e3c..3f0e10df8053 100644
>> --- a/net/tls/tls.h
>> +++ b/net/tls/tls.h
>> @@ -304,8 +304,7 @@ static inline void
>>   tls_advance_record_sn(struct sock *sk, struct tls_prot_info *prot,
>>   		      struct cipher_context *ctx)
>>   {
>> -	if (tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size))
>> -		tls_err_abort(sk, -EBADMSG);
>> +	tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size);
> 
> That seems wrong. We can't allow the record number to wrap, if breaks
> the crypto. See for example:
> https://datatracker.ietf.org/doc/html/rfc5288#section-6.1
> 
> The real fix would be to stop the caller from freeing the skmsg and
> record if we go async. Once we go through async crypto, the record etc
> don't belong to the caller anymore, they've been transfered to the
> async callback. I'd say we need both tests in bpf_exec_tx_verdict:
> -EINPROGRESS (from before 635d93981786) and EBADMSG (from
> 635d93981786).

Thanks for your review~

By the way, does the return of EBADMSG mean that the tls link needs to 
renegotiate the encryption information or re-establish the link?

And is this okay?
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1ed4a611631f..d1fc295b83b5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -817,7 +817,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, 
struct sock *sk,
         psock = sk_psock_get(sk);
         if (!psock || !policy) {
                 err = tls_push_record(sk, flags, record_type);
-               if (err && sk->sk_err == EBADMSG) {
+               if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
                         *copied -= sk_msg_free(sk, msg);
                         tls_free_open_rec(sk);
                         err = -sk->sk_err;
@@ -846,7 +846,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, 
struct sock *sk,
         switch (psock->eval) {
         case __SK_PASS:
                 err = tls_push_record(sk, flags, record_type);
-               if (err && sk->sk_err == EBADMSG) {
+               if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
                         *copied -= sk_msg_free(sk, msg);
                         tls_free_open_rec(sk);
                         err = -sk->sk_err;

> 
> Actually we need to check for both -EINPROGRESS and -EBUSY as I've
> recently found out.
> 
> I've been running the selftests with async crypto and have collected a
> few fixes that I was going to post this week (but not this one, since
> we don't have a selftest for wrapping rec_seq). One of the patches
> adds -EBUSY checks for all existing -EINPROGRESS, since the crypto API
> can return -EBUSY as well if we're going through the backlog queue.
> 

