Return-Path: <netdev+bounces-204166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB54AF94DF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52ABC4A7DB1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725231547EE;
	Fri,  4 Jul 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqJvNpo3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E18360
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637722; cv=none; b=YvgNlvHT/nmNjAdJ9ndzPbNgWthSpi7IrLREbwC98qaKEEn9q5jvpdXVjeGhh1nmpO02xtXZJNssI3G3N/QiElkI7eETzrwo6YmC9bRzb6T92bJgc/0uOorOszEoAzVOdQ+wzmq/MFoq9HzTiK70AiChPwFmDrtlerCI3jJoeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637722; c=relaxed/simple;
	bh=VXgjLGFQZY5smlzhnXRitJLgxLrq2V8G8Kv45++grJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/0M0uUyXwiETwQBx6hsn8r9qtNIoyzMA/kyrFQz6mYnCpuXRWmRNjGiZVXHh/jxFkT8IFugglv+YG2lARXR6zfqrj9SDRg2kZrox5nRETkrzClWwNTdSIWULWJeosf4/1OZemhGPYgHH2L4U3cpjgf5jEeJd8q5UtRalXPSCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqJvNpo3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751637719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDJUJsvrMWlhp5h/eTlo7zQDDwQebZVC/hQFX5FKCvs=;
	b=JqJvNpo3UckdI88k+ohXAtI1zHCAOciLldK++w7yNcPwa5nm/B3pHniFQV1quCqhnAjxOh
	OncwhCmsuKDhoFLC0wawzzvHs7HvD61XVGU4+SQdudUZgwaOQpoLVu/dbQ01K0Gh7Yfw4I
	mKMuD6co37xG0yBgeV6Btrh8tFr3TxI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-aMlPcBt4MMSfVCOIK0LYoQ-1; Fri, 04 Jul 2025 10:01:58 -0400
X-MC-Unique: aMlPcBt4MMSfVCOIK0LYoQ-1
X-Mimecast-MFC-AGG-ID: aMlPcBt4MMSfVCOIK0LYoQ_1751637717
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso528156f8f.3
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 07:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751637717; x=1752242517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDJUJsvrMWlhp5h/eTlo7zQDDwQebZVC/hQFX5FKCvs=;
        b=GWtDL4I7JsNJBQzKjiD+3ee8AevMAykUm1pBaOeeICAT1SjXs8QpKqm1SP/VYe/QDo
         UgEGBEiaGlFz5cdeRmKjvUy7xsFSV/VdxuyHg5dPpAP5TGsGHUQITO9edVQAfl8LITiB
         Nd3c9WI4s0joDGr3hHxo8g9zGILnm6ysXqzE7SFk2DFSvOjYoVP8TKNlC2pMpcE2Ct3S
         6a4K+6tUMJL5FoB2muP4ChFFueroV2jxCS84Noni1Dsnv7mPqbLh1cvL9roukwOxhSwW
         HaDXBv+NifyZwoZta0BV+EEt1M/pY3vX1WJQu/PXd8xU8LZvsQ0ySYbiG1viiYZVoIMR
         VKhw==
X-Forwarded-Encrypted: i=1; AJvYcCWVxqinuVcO5L7um+ENMSqSpTehk0OEAK5G6RhpnLg1LoBKoVfP/Tvk+6FCU8FMd4WIw2lDKY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8HC0u44R4OpE/UF4l4GpboQy9SpOwl6INa7PIae8aTMAJPRI
	Oj7HTe5JsH9T8yTGG8NPe/a+ssvefUg5iGROcJF8F5uZ4Fqu0bXH7p38D16GPFgQMQtVN36kiHb
	d0DbRUoxdEyByl/9uv7vSxhEl68qJK3JQWo9uPwaF9QyutlD3W1P2CKGOXw==
X-Gm-Gg: ASbGnctHyHlzRBk71Wswyx0j/5V62Iw3e8Osd1szCFV7bSt4u/gTitux7wQ2TAKidQf
	zAXW9rajhV+Vl4xc1AyyQe3AstrKk5WTC0WwmRaHnvp2IIOwYO+jlsgiYXgiiUEcqefQoYupUXN
	xfx0qbfEg2bAhOnmnVTjvQ4a7uCF40sPFLYVOrVhlmSQ4abNfJPrL/ZGoVwaXT4HYE4WciycQYi
	HdhJpyh+hiqQpQ6d6/hWnrIzEkTMIPMvXHcFIR7f00JzjqT0EY5Ol2eqK7YcvOfqEcPVWcdFK/X
	cVPb7ShvYutoYWEcA6bT0hxv/E5Et+sUU0oHlpV9ZXfPth0wg+bqEkZlfUBXtW/CEpY=
X-Received: by 2002:a05:6000:4612:b0:3a4:dd8e:e16d with SMTP id ffacd0b85a97d-3b49700aa4fmr2018073f8f.15.1751637716853;
        Fri, 04 Jul 2025 07:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEZW1CkQQkIbScRXkuM03LBvtJ1trRwGa4hPNLBM5cZZYDNsHlb9LNsTd5kzICSts2krWbzA==
X-Received: by 2002:a05:6000:4612:b0:3a4:dd8e:e16d with SMTP id ffacd0b85a97d-3b49700aa4fmr2017961f8f.15.1751637715879;
        Fri, 04 Jul 2025 07:01:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1698f54sm27228875e9.33.2025.07.04.07.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 07:01:55 -0700 (PDT)
Message-ID: <51c73a40-fd3d-40d3-b6a1-f0b15ce98239@redhat.com>
Date: Fri, 4 Jul 2025 16:01:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sched: Prevent notify to parent who unsupport class
 ops
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <686764a5.a00a0220.c7b3.0013.GAE@google.com>
 <20250704080421.4046239-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704080421.4046239-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/4/25 10:04 AM, Lizhi Xu wrote:
> If the parent qdisc does not support class operations then exit notify.
> 
> In addition, the validity of the cl value is judged before executing the
> notify. Similarly, the notify is exited when the address represented by
> its value is invalid.
> 
> Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1261670bbdefc5485a06
> Tested-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  net/sched/sch_api.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index d8a33486c51..53fd63af14d 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -803,12 +803,13 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>  			break;
>  		}
>  		cops = sch->ops->cl_ops;
> -		if (notify && cops->qlen_notify) {
> +		if (cops && notify && cops->qlen_notify) {
>  			/* Note that qlen_notify must be idempotent as it may get called
>  			 * multiple times.
>  			 */
>  			cl = cops->find(sch, parentid);
> -			cops->qlen_notify(sch, cl);
> +			if (virt_addr_valid(cl))
> +				cops->qlen_notify(sch, cl);

The above causes build failures in arm64 builds:

  ../net/sched/sch_api.c: In function ‘qdisc_tree_reduce_backlog’:
  ../arch/arm64/include/asm/memory.h:424:66: error: passing argument 1
of ‘virt_to_pfn’ makes pointer from integer without a cast
[-Wint-conversion]
    424 |         __is_lm_address(__addr) &&
pfn_is_map_memory(virt_to_pfn(__addr));      \

/P


