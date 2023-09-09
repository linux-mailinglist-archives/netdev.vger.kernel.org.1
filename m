Return-Path: <netdev+bounces-32696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98927996C3
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 09:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48511C20BCD
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65063184C;
	Sat,  9 Sep 2023 07:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7217EE
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 07:58:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD719BA
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 00:58:44 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RjQJ65KyDzMl9g;
	Sat,  9 Sep 2023 15:55:18 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 9 Sep 2023 15:58:41 +0800
Message-ID: <c1a566db-4e6a-c437-b5db-bb380c74c452@huawei.com>
Date: Sat, 9 Sep 2023 15:58:41 +0800
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
 <ZPhcTQ3mFQYmTHet@hog> <a6dec380-1ebc-d495-da67-7bd61525d4a8@huawei.com>
 <ZPtO1VDcYSIFVnie@hog>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <ZPtO1VDcYSIFVnie@hog>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/9 0:41, Sabrina Dubroca wrote:
> 2023-09-07, 20:59:51 +0800, liujian (CE) wrote:
>> By the way, does the return of EBADMSG mean that the tls link needs to
>> renegotiate the encryption information or re-establish the link?
> 
> We currently don't support key updates so closing this socket is the
> only option for now. AFAIU when we set EBADMSG, we can't fix that socket.
> 
Got it, thank you for your explanation.

>> And is this okay?
> 
> Yes, this is what I had in mind.
> 
Will send v2, thanks.

>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 1ed4a611631f..d1fc295b83b5 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -817,7 +817,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg,
>> struct sock *sk,
>>          psock = sk_psock_get(sk);
>>          if (!psock || !policy) {
>>                  err = tls_push_record(sk, flags, record_type);
>> -               if (err && sk->sk_err == EBADMSG) {
>> +               if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
>>                          *copied -= sk_msg_free(sk, msg);
>>                          tls_free_open_rec(sk);
>>                          err = -sk->sk_err;
>> @@ -846,7 +846,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg,
>> struct sock *sk,
>>          switch (psock->eval) {
>>          case __SK_PASS:
>>                  err = tls_push_record(sk, flags, record_type);
>> -               if (err && sk->sk_err == EBADMSG) {
>> +               if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
>>                          *copied -= sk_msg_free(sk, msg);
>>                          tls_free_open_rec(sk);
>>                          err = -sk->sk_err;
> 

