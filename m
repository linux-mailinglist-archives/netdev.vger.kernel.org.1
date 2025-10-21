Return-Path: <netdev+bounces-231153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4BBF5B93
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B08B18A4EB4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15FC32B985;
	Tue, 21 Oct 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtividXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5902777FC
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041648; cv=none; b=stbQbBigefdfQCIjDZ9hZUHvx3yn35W/ARs2JBKg9MrwOdnpOTljXwDcwzlKeD2wRHzbUtTGYE/11YfJ+1GpOT5e/IggqEk9dcNMyBy9ybn7lcOyXofxAJGYePhet4a2IpthqezvzVkJtRTOjN8/tdCECVSw5461QnjTOZexOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041648; c=relaxed/simple;
	bh=hZFYqccy3hrzjkUJnAWqrJtsjPd4X/Rq5BGUoMThiBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kywawzlqtGObYLeFG0I5JdMp55s63QW2Grcr3JMqplZMrbD/HSzcjeURFvWPVUQEMyCrm3Z56DVgPD+rRNJqJknO2Ybd+yEI8UcCRNgQStbX3GqticxSI38od5XC73bgkERGwDVFwnEsG3bSF3omd9d0pYTFfQP6fFFbyS7pZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtividXJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63bbcab353dso908116a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761041643; x=1761646443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY4sUqJT8CNQPf5hwojWc40WBK5K/UWeQgITdbU7s54=;
        b=UtividXJcfovqe8wKQVSC1Iwlws+W3vm9+YGgu9nqkRy3ZOFluhjxN9jHfUPQwf8LG
         pPrDc4wh5WlXIWv+a4wea/lw3U0FpnvBljkCmvMD0RozwB67Q9aP5zeN7tCA485hujDU
         5YZiZcOlLL8OZPmNgmwI16zXW3+vpD6pCaaKyNSgCa8ypWpFwDZCCLji3knfQtlTnbx4
         0chBktbiOp+kM7Kkbsrp6hfQJnimQgGLa3l7jT5ztxZGnkyKo5XlQ5JXq3H04Q324olL
         Swb5G+4gqTnvnjE1k6TLXHTgz4704Lu13NplwlW2DPk5yvHit/KLgnPMw+lXVozWxlMB
         /1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041643; x=1761646443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY4sUqJT8CNQPf5hwojWc40WBK5K/UWeQgITdbU7s54=;
        b=Eeb1W5yV2zdP5g0pZoCghffTEfPBkao0DlZcDR/Ibh36srW9xjGctiD15UC4CynY0A
         97wGQXRr/gjSS4ntHFKC+uYfhvBWWU04hSh1b5xx8+eYoIPrFF+DmevNC7+3mb2qnVUF
         P4WJVA3tTfF9btfZpi5ZU69PMeTdjz/rDAOgcDU8/CPilopqZg+sVTp4tidjyDy58gpG
         qNy7+rtWFILmoglpz02mklpdvH1JMpfSlLoHfn+svoD7ZTacWC6B9tjw4fpLjnsAYwJq
         b17xigAynZBJFSt1D2Gbj+WZHDtt4ENA+hAPy7cp79aZwhW5kVodUu2tOSPuOVSopJst
         Kfiw==
X-Gm-Message-State: AOJu0Ywukj4hmq7mDi7NbzsW5lIQTW67VkGB0s/C0Z64OzXrssmSWVBf
	LxvnusQXSc7mGaxcB+C2lUqY8S9MffgPXjeSXvxn1+/A0FOijz1YIBbk
X-Gm-Gg: ASbGncuLUinjHNSa1uQtFjIpGN7thyqnDWiN5ac0vo0lLHfXRATho3ka3W4//Ki2xpr
	lqppEy43Mtbez9oBevH5MFRM+Ci6xFD0FTBS1XpktfeaoQWfwt7guLoIQJLtZscV52wBxk2y6gC
	SAnze8yoxVHeIrXark7mLQ8XdffazjjCZaFGUlXroAq34PvdPb6/HUPYEZsXJa/cEmtstLn5b7i
	m/CMaUpET6trRMm0Jg+MjbWdq4XYUVowJd935eG4wcALCn5gRWHCKXTPwcoulbHcU7qvc9H9H+L
	TdO/GAXMDlZ3ma9s2gY4MTtVG7cPwlw+koVJQ01P6KP2DR09qJ2Pn+hCMGDjE+PHnDEh+eHJ3xt
	V3ggy1p+lnbPfTGieW8yiithOJ07cz1CGSzPh7Ag5QXJGC41dxqzy6lkiZrUOPp1Neh5N13ETS1
	PBmYwm2/YvsUCC4ovhB77uL2qdutKi
X-Google-Smtp-Source: AGHT+IGp3+5iFHi5zRWLe8YxHSX3njxzZcoBp1BcVGuZR2w2gCAwViee0Dzqam5RCqIQMql4fNoXCQ==
X-Received: by 2002:a05:6402:4307:b0:63c:1d4a:afcb with SMTP id 4fb4d7f45d1cf-63d09d3bd06mr1476817a12.0.1761041642678;
        Tue, 21 Oct 2025 03:14:02 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4869746asm9018625a12.0.2025.10.21.03.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:14:02 -0700 (PDT)
Message-ID: <4c849c04-6647-432c-807c-5fa7afa7fb47@gmail.com>
Date: Tue, 21 Oct 2025 12:13:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf/cpumap.c: Remove unnecessary TODO comment
To: Jesper Dangaard Brouer <hawk@kernel.org>, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com>
 <e0901356-ef48-4652-9ad4-ff85ae07d83a@kernel.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <e0901356-ef48-4652-9ad4-ff85ae07d83a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 10:37 AM, Jesper Dangaard Brouer wrote:
> 
> 
> On 20/10/2025 19.02, Mehdi Ben Hadj Khelifa wrote:
>> After discussion with bpf maintainers[1], queue_index could
>> be propagated to the remote XDP program by the xdp_md struct[2]
>> which makes this todo a misguide for future effort.
>>
>> [1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
>> [2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> Changelog:
>>
>> Changes from v1:
>>
>> -Added a comment to clarify that RX queue_index is lost after the frame
>> redirection.
>>
>> Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec- 
>> aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706
>>   kernel/bpf/cpumap.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index 703e5df1f4ef..6856a4a67840 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -195,7 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct 
>> bpf_cpu_map_entry *rcpu,
>>           rxq.dev = xdpf->dev_rx;
>>           rxq.mem.type = xdpf->mem_type;
>> -        /* TODO: report queue_index to xdp_rxq_info */
>> +        /* The NIC RX queue_index is lost after the frame redirection
>> +         * but in case of need, it can be passed as a custom XDP
>> +         * metadata via xdp_md struct to the remote XDP program
> 
> Argh, saying XDP metadata is accessed via the xdp_md struct is just wrong.
> 
Ack, I didn't clarify that XDP metadata should be propagated via the 
bpf_xdp_adjust_meta like mentionned in the link[2]... Maybe I was 
thinking more in the technical side that xdp_md->data_meta would hold 
the value internally... I will send a v3 with appropriate changes.
Thanks for the review.

Best Regards,
Mehdi Ben Hadj Khelifa
> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
>> +         */
>>           xdp_convert_frame_to_buff(xdpf, &xdp);
> 


