Return-Path: <netdev+bounces-144749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1789C85E3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7011F21FF6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CC1DE3C6;
	Thu, 14 Nov 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/26cZcc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FD19148A
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575869; cv=none; b=myFlOlxBPVyqUcDe38ZkMV2MtLyTHlrG8DCcdo/5/8zgQCzMPLZCTYRYXRmM97aMKbcqvbjCI8a6JtCVw1vIO0fA/t1anjhGjnj52I8v4HenamkYY9TP4w9b3GOA2WN+zyK08hhmAv6HVf5RlM9abRUIABl5FcWocNNEE/T+98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575869; c=relaxed/simple;
	bh=2l1upWdLGnHpQBTsx9xJ7gWW3a/Of3mHuYaCwbe2cPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DghkbTjZN5sjBbIcKVr3dopkct441QHkR6NfPOEKTaz3dZ/5wXNBTDWfDdO0tkZWfaCznefpUhpUvaiAzik6EejzSnbzQ3SG6I2Q4maVk3Xioa0C3uScTJ/bEfVaFbB8WXc0lzsnnaas6m8xEBGCHn1SIR9uKxwmmJXqY3ttHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/26cZcc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731575866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YTMof52wjObhgZR9ofRlLiT7bLjMKTtBkm72KHuyEs=;
	b=S/26cZccnaADcVRJXWrtoANjqeng87moJEvwpsduo25OnIvv7oN3WmP6z/CL/BMDLRm5rh
	ezq7wPag6DGr5BuerhCEk5t40Rd6EdKF3y1LbQ6vyZjWrDzRL9pPwMKLGBDxxH3/w5WphL
	11QovecVdr0FvuwAOyd/i0UtyQm+erk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-f9Cnbwz9N4ec-w9SDNiMcg-1; Thu, 14 Nov 2024 04:17:44 -0500
X-MC-Unique: f9Cnbwz9N4ec-w9SDNiMcg-1
X-Mimecast-MFC-AGG-ID: f9Cnbwz9N4ec-w9SDNiMcg
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6ee426e3414so7354947b3.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575863; x=1732180663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YTMof52wjObhgZR9ofRlLiT7bLjMKTtBkm72KHuyEs=;
        b=XANrS9zGbGZxy7/jlDWGw4rN43NQb1sIuPMpcDSeuGCkE1CRDWWKUuZfRR6qVZeBDH
         NMCWPZZ+/VVFS+p5vAtilveYCa5mdlALzzvsTEmdhRqUP0oUgnvE/ZGkB4Owle6TgCvS
         1zyXcZEbEp+TA8RDhvZCDD8q81dOXsuNSlDuJtfsy5eWOl210ocNLWjLq0punGOrUTqX
         1eNh/DmW156Xa9eZ9aEi8KQ+TdTQTEMSIPSFEHFxRKepgiDo+4+KWn2N0gWP7LVOiW7Z
         FUxvcv+fz4WRJZLf+S/gh5E5ej2oPvyceHBl9nkSV/yVcCV3Q7Qv6mgh8D2ANpLU4Qce
         9h+Q==
X-Gm-Message-State: AOJu0YxX14Qw5Xnr2I2V8tZBsZyQ5B9rKcM1r++TyI5dZjg04S8BoEqu
	H6bgmLn+kVnGdWuNwlRj3hR3Qhhiz7jhVt9ro+uzwDnzOW1mX0maIaHw3OuxBTMhawf+PM4L2oY
	qJjMSUw7G4SadyxsH6UI0NGED6MbmWvmh29oU6AE/TbH/5IODsDTUxA==
X-Received: by 2002:a05:690c:3504:b0:6ee:40f0:dda8 with SMTP id 00721157ae682-6ee40f0e2cfmr16971207b3.30.1731575863546;
        Thu, 14 Nov 2024 01:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsiQSf8ZdEH6QnDVrnxq7SyDxajgrhb5FvkPicA2hLnRMRhzQMJ0Rdc+FgVp0To67bMvJMyw==
X-Received: by 2002:a05:690c:3504:b0:6ee:40f0:dda8 with SMTP id 00721157ae682-6ee40f0e2cfmr16971077b3.30.1731575863247;
        Thu, 14 Nov 2024 01:17:43 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9eefd0sm3301361cf.27.2024.11.14.01.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:17:35 -0800 (PST)
Message-ID: <9e64f1ca-844f-47ec-8555-4ac1e409ec16@redhat.com>
Date: Thu, 14 Nov 2024 10:17:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/core/net-procfs: use seq_put_decimal_ull_width() for
 decimal values in /proc/net/dev
To: David Wang <00107082@163.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241110045221.4959-1-00107082@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241110045221.4959-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/24 05:52, David Wang wrote:
> seq_printf() is costy, when reading /proc/net/dev, profiling indicates
> about 13% samples of seq_printf():
> 	dev_seq_show(98.350% 428046/435229)
> 	    dev_seq_printf_stats(99.777% 427092/428046)
> 		dev_get_stats(86.121% 367814/427092)
> 		    rtl8169_get_stats64(98.519% 362365/367814)
> 		    dev_fetch_sw_netstats(0.554% 2038/367814)
> 		    loopback_get_stats64(0.250% 919/367814)
> 		    dev_get_tstats64(0.077% 284/367814)
> 		    netdev_stats_to_stats64(0.051% 189/367814)
> 		    _find_next_bit(0.029% 106/367814)
> 		seq_printf(13.719% 58594/427092)
> And on a system with one wireless interface, timing for 1 million rounds of
> stress reading /proc/net/dev:
> 	real	0m51.828s
> 	user	0m0.225s
> 	sys	0m51.671s
> On average, reading /proc/net/dev takes ~0.051ms
> 
> With this patch, extra costs parsing format string by seq_printf() can be
> optimized out, and the timing for 1 million rounds of read is:
> 	real	0m49.127s
> 	user	0m0.295s
> 	sys	0m48.552s
> On average, ~0.048ms reading /proc/net/dev, a ~6% improvement.
> 
> Even though dev_get_stats() takes up the majority of the reading process,
> the improvement is still significant;
> And the improvement may vary with the physical interface on the system.
> 
> Signed-off-by: David Wang <00107082@163.com>

If the user-space is concerned with performances, it must use netlink.
Optimizing a legacy interface gives IMHO a very wrong message.

I'm sorry, I think we should not accept this change.

/P


