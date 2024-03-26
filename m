Return-Path: <netdev+bounces-81864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC988B6E6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F228A3001B5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B01CFB2;
	Tue, 26 Mar 2024 01:32:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12B208A0;
	Tue, 26 Mar 2024 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416766; cv=none; b=DarDgrgoTZQN5xgUyuTLyL/8vqDzFR720u28nuJpswa0UoxtV9Zl7lg7cZZGc6AlTmL75vcXS/4cGQfB158+WnggMi6hd34AVwC4S0Bs+37RbfcJVs5W7lVvZaAEsLdlsN6fg3aNWXYDFJGODD9ESZGK/WMjIZ0qXmK/i/tDJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416766; c=relaxed/simple;
	bh=eMFRjUtUMWrhAeJB3edtRvsRkLBoPsmMFoOB9SZEFg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvqR9hnVW7yX0rlwIpI8xhGxjkARoSgJEUTs/+Bz5mWLuNdyIvjsSFG0rbFlGNNFf6e9A1oqcIvqe0LV8WTx0RMrrVnSFo+QW+fi5VS1ZHAwbWzePfllCV+RjNwZm1xTTGnBLNFxoIN0mZHgLtHzDrXamc/ppNomvWECKg7u6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3XNf37p7z4f3kKH;
	Tue, 26 Mar 2024 09:32:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6C2591A016E;
	Tue, 26 Mar 2024 09:32:38 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgDHNQm1JQJmiy8KIQ--.2494S2;
	Tue, 26 Mar 2024 09:32:38 +0800 (CST)
Message-ID: <0e84058c-a097-4a30-a95b-7b9080e26fae@huaweicloud.com>
Date: Tue, 26 Mar 2024 09:32:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] riscv, bpf: Fix kfunc parameters incompatibility
 between bpf and riscv abi
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>,
 Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?Q?l?= <bjorn@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240324103306.2202954-1-pulehui@huaweicloud.com>
 <CAADnVQLhfN7f6AFxa_19E0g2_YADEkrfPPffi43HeH9VCi8MqQ@mail.gmail.com>
 <c0890fc2-53ea-401a-a3b4-a9bf6181a867@huaweicloud.com>
 <CAADnVQKnTe-7KhziOnGSesbz1WDkNp4nyCN3qp-y=ab0jMxr3Q@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAADnVQKnTe-7KhziOnGSesbz1WDkNp4nyCN3qp-y=ab0jMxr3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHNQm1JQJmiy8KIQ--.2494S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWxZF4DtF1xWFWxuFW7urg_yoWrtw4kpF
	1UJF4rCr4kXw1UZr12qw15Jr1akw1jy3W7ZFy8tF9rCrWqgr93Gr4UKrWY93Z5Cr1rCF17
	X3yqvF4akw18J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/26 2:34, Alexei Starovoitov wrote:
> On Mon, Mar 25, 2024 at 8:28 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>>
>>
>> On 2024/3/25 2:40, Alexei Starovoitov wrote:
>>> On Sun, Mar 24, 2024 at 3:32 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>> [SNIP]
>>>>
>>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>>> index 869e4282a2c4..e3fc39370f7d 100644
>>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>>> @@ -1454,6 +1454,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>>>                   if (ret < 0)
>>>>                           return ret;
>>>>
>>>> +               if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>>> +                       const struct btf_func_model *fm;
>>>> +                       int idx;
>>>> +
>>>> +                       fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
>>>> +                       if (!fm)
>>>> +                               return -EINVAL;
>>>> +
>>>> +                       for (idx = 0; idx < fm->nr_args; idx++) {
>>>> +                               u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
>>>> +
>>>> +                               if (fm->arg_size[idx] == sizeof(int))
>>>> +                                       emit_sextw(reg, reg, ctx);
>>>> +                       }
>>>> +               }
>>>> +
>>>
>>> The btf_func_model usage looks good.
>>> Glad that no new flags were necessary, since both int and uint
>>> need to be sign extend the existing arg_size was enough.
>>>
>>> Since we're at it. Do we need to do zero extension of return value ?
>>> There is
>>> __bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
>>> but the selftest with it is too simple:
>>>           return bpf_kfunc_call_test2((struct sock *)sk, 1, 2); >
>>> Could you extend this selftest with a return of large int/uint
>>> with 31th bit set to force sign extension in native
>>
>> Sorry for late. riscv64 will sign-extend int/uint return values. I
>> thought this would be a good test, so I tried the following:
>> ```
>> u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym; <-- here change int to u32
>> int kfunc_call_test2(struct __sk_buff *skb)
>> {
>>          long tmp;
>>
>>          tmp = bpf_kfunc_call_test2(0xfffffff0, 2);
>>          return (tmp >> 32) + tmp;
>> }
>> ```
>> As expected, if the return value is sign-extended, the bpf program will
>> return 0xfffffff1. If the return value is zero-extended, the bpf program
>> will return 0xfffffff2. But in fact, riscv returns 0xfffffff2. Upon
>> further discovery, it seems clang will compensate for unsigned return
>> values. Curious!
>> for example:
>> ```
>> u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym;
>> int kfunc_call_test2(struct __sk_buff *skb)
>> {
>>          long tmp;
>>
>>          tmp = bpf_kfunc_call_test2(0xfffffff0, 2);
>>          bpf_printk("tmp: 0x%lx", tmp);
>>          return (tmp >> 32) + tmp;
>> }
>> ```
>> and the bytecode will be:
>> ```
>>    0:       18 01 00 00 00 00 00 f0 00 00 00 00 00 00 00 00 r1 =
>> 0xf0000000 ll
>>    2:       b7 02 00 00 02 00 00 00 r2 = 0x2
>>    3:       85 10 00 00 ff ff ff ff call -0x1
>>    4:       bf 06 00 00 00 00 00 00 r6 = r0
>>    5:       bf 63 00 00 00 00 00 00 r3 = r6
>>    6:       67 03 00 00 20 00 00 00 r3 <<= 0x20 <-- zero extension
>>    7:       77 03 00 00 20 00 00 00 r3 >>= 0x20
>>    8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
>> 10:       b7 02 00 00 0b 00 00 00 r2 = 0xb
>> 11:       85 00 00 00 06 00 00 00 call 0x6
>> 12:       bf 60 00 00 00 00 00 00 r0 = r6
>> 13:       95 00 00 00 00 00 00 00 exit
>> ```
>>
>> another example:
>> ```
>> u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym;
>> int kfunc_call_test2(struct __sk_buff *skb)
>> {
>>          long tmp;
>>
>>          tmp = bpf_kfunc_call_test2(0xfffffff0, 2);
>>          return (tmp >> 20) + tmp; <-- change from 32 to 20
>> }
>> ```
>> and the bytecode will be:
>> ```
>>    0:       18 01 00 00 00 00 00 f0 00 00 00 00 00 00 00 00 r1 =
>> 0xf0000000 ll
>>    2:       b7 02 00 00 02 00 00 00 r2 = 0x2
>>    3:       85 10 00 00 ff ff ff ff call -0x1
>>    4:       18 02 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 r2 =
>> 0xfff00000 ll <-- 32-bit truncation
>>    6:       bf 01 00 00 00 00 00 00 r1 = r0
>>    7:       5f 21 00 00 00 00 00 00 r1 &= r2
>>    8:       77 01 00 00 14 00 00 00 r1 >>= 0x14
>>    9:       0f 01 00 00 00 00 00 00 r1 += r0
>> 10:       bf 10 00 00 00 00 00 00 r0 = r1
>> 11:       95 00 00 00 00 00 00 00 exit
>> ```
>>
>> It is difficult to construct this test case.
> 
> Yeah.
> I also tried a bunch of experiments with llvm and gcc-bpf.
> Both compilers emit zero extension when u32 is being used as u64.
> 
>>> kernel risc-v code ?
>>> I suspect the bpf side will be confused.
>>> Which would mean that risc-v JIT in addition to:
>>>           if (insn->src_reg != BPF_PSEUDO_CALL)
>>>               emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
>>>
>>> need to conditionally do:
>>>    if (fm->ret_size == sizeof(int))
>>>      emit_zextw(bpf_to_rv_reg(BPF_REG_0, ctx),
>>>                 bpf_to_rv_reg(BPF_REG_0, ctx), ctx);
>>> ?
>>
>> Agree on zero-extending int/uint return values when returning from
>> kfunc to bpf ctx. I will add it in next version. Thanks.
> 
> Looking at existing compilers behavior it's probably unnecessary.
> I think this patch is fine as-is.
> I'll apply it shortly.

Alright, feel free to apply it. Thanks


