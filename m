Return-Path: <netdev+bounces-19080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB554759829
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F14281946
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0391154BC;
	Wed, 19 Jul 2023 14:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524B154A4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:24:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C2F2690;
	Wed, 19 Jul 2023 07:24:08 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R5dJQ0gzxzNmKd;
	Wed, 19 Jul 2023 22:20:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 22:23:40 +0800
Subject: Re: [RFC PATCH 05/21] ubifs: Pass worst-case buffer size to
 compression routines
To: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>
CC: <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>, Haren Myneni <haren@us.ibm.com>, Nick
 Terrell <terrelln@fb.com>, Minchan Kim <minchan@kernel.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Richard Weinberger
	<richard@nod.at>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<qat-linux@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mtd@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <20230718125847.3869700-6-ardb@kernel.org>
 <20230718223813.GC1005@sol.localdomain>
 <CAMj1kXE1fND2h8ts6Xtfn19wkt=vAnj1TumxvoBCuEn7z3V4Aw@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3330004f-acac-81b4-e382-a17221a0a128@huawei.com>
Date: Wed, 19 Jul 2023 22:23:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXE1fND2h8ts6Xtfn19wkt=vAnj1TumxvoBCuEn7z3V4Aw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/7/19 16:33, Ard Biesheuvel 写道:
> On Wed, 19 Jul 2023 at 00:38, Eric Biggers <ebiggers@kernel.org> wrote:
>>
>> On Tue, Jul 18, 2023 at 02:58:31PM +0200, Ard Biesheuvel wrote:
>>> Currently, the ubifs code allocates a worst case buffer size to
>>> recompress a data node, but does not pass the size of that buffer to the
>>> compression code. This means that the compression code will never use

I think you mean the 'out_len' which describes the lengh of 'buf' is 
passed into ubifs_decompress, which effects the result of 
decompressor(eg. lz4 uses length to calculate the buffer end pos).
So, we should pass the real lenghth of 'buf'.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

>>> the additional space, and might fail spuriously due to lack of space.
>>>
>>> So let's multiply out_len by WORST_COMPR_FACTOR after allocating the
>>> buffer. Doing so is guaranteed not to overflow, given that the preceding
>>> kmalloc_array() call would have failed otherwise.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>   fs/ubifs/journal.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
>>> index dc52ac0f4a345f30..4e5961878f336033 100644
>>> --- a/fs/ubifs/journal.c
>>> +++ b/fs/ubifs/journal.c
>>> @@ -1493,6 +1493,8 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
>>>        if (!buf)
>>>                return -ENOMEM;
>>>
>>> +     out_len *= WORST_COMPR_FACTOR;
>>> +
>>>        dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
>>>        data_size = dn_size - UBIFS_DATA_NODE_SZ;
>>>        compr_type = le16_to_cpu(dn->compr_type);
>>
>> This looks like another case where data that would be expanded by compression
>> should just be stored uncompressed instead.
>>
>> In fact, it seems that UBIFS does that already.  ubifs_compress() has this:
>>
>>          /*
>>           * If the data compressed only slightly, it is better to leave it
>>           * uncompressed to improve read speed.
>>           */
>>          if (in_len - *out_len < UBIFS_MIN_COMPRESS_DIFF)
>>                  goto no_compr;
>>
>> So it's unclear why the WORST_COMPR_FACTOR thing is needed at all.
>>
> 
> It is not. The buffer is used for decompression in the truncation
> path, so none of this logic even matters. Even if the subsequent
> recompression of the truncated data node could result in expansion
> beyond the uncompressed size of the original data (which seems
> impossible to me), increasing the size of this buffer would not help
> as it is the input buffer for the compression not the output buffer.
> .
> 


