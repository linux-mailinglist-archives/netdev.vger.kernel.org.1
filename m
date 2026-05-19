Return-Path: <netdev+bounces-289441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CmlKSNWDGqUfgUAu9opvQ
	(envelope-from <netdev+bounces-289441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:22:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC757E98A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B98913000BB5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F934C77AD;
	Tue, 19 May 2026 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRZjJq4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277424BCAA6
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192718; cv=none; b=EyNDnuy25gN8wTxfXdMlRF0ed0ACj7JM4QytSj2VE0kkmLM0kkwj+e2cxAEZnslSyCp/z1xLndtx0lrsBrcWLYwIOnoWwzVTNt6Ib7eqzYJm9uW/RC+MURPUmvDM323uQQukk9Q6eFelqN0LnPp6MkMnxlVdJZSDFvAVaxW7BVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192718; c=relaxed/simple;
	bh=IYaQaJj5MVcvrd+hSHbZutQNIAVNVlA6s1NlpyumyNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgFV7o94roEkv/BbtUNgWmECNn0FqzMfi+c1flF4F6nb5tv+pfWYHCefeN2EuAKhK8csicfHryFzMIvEe36rKniVnyfXvhKK4snAv79uHavCjKiJoeySYT6yrZm5U8okq1RIo8T1DFZTcJWqov3Quxco6+mK6nOEsrI0FvIkHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRZjJq4t; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so4860555e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779192715; x=1779797515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ww4CKOsmbnsFPVH2QTfL4TQf7KmUuJr3ZNu7Wd6tZ5Q=;
        b=fRZjJq4ttyYIGVGyskHuLjAE1hsUdBlf90mnpquzsTzMLlU/BbucUhUEvyorqfFccK
         h1lcmEBz/RmewteGB5Gd9f2LBcf/hKKpFcH/vD2z/WOkvAUZJ2zBZAo6tDiTDSsWXUFx
         6GNXIGV8I3LnQujh5qfWIH8dfKh73oIkQSzgVs4efaDYDqlr718V3OzviP7QL5k9xkWU
         X/HJRsoxhCKVNcClUtmBun+yBLrOUgrskIrQmLpu4iSplYi0l5vGTVmPd4vmbMTjdiMd
         bZTfan5gt/klXXhzGXQ5sW+8JsO7Jfm2DpMUeQ7guU6qZFNEFmSlAfdT0p7T6fJ2/PAr
         b3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779192715; x=1779797515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww4CKOsmbnsFPVH2QTfL4TQf7KmUuJr3ZNu7Wd6tZ5Q=;
        b=OxxWkYnKofSk7kb8PjZWO/mEXbZq9rWYyvwd6PaRBnNYK4sbrot1O0tXeWYOhB1Q3/
         UbeoBZ2LCxdAhlph+BdR2ut81rnPJ2wOsIPPNUAxwX2h68xHSjzjDGF5zoOFINgrvcl0
         b/Vke5q7ASVJKDsKdzjXHlKIlCM4oPtkLPAGw2l5RZSFwoCMp1LpntK62L8JLH2RgHzf
         IW9j63ttFuGSZSK4Q+UhB+DYdm3jcULbAioNDV3SviptzUmkxLD7Q4IEXb73NUHRdIro
         lD3VnZPrYUJSqBiBc6PttFiD0XF0rRoZhq0I7mCMImQ8McOVrKi7fXWEkwX1irJmXXna
         6T8w==
X-Forwarded-Encrypted: i=1; AFNElJ+Yjh8RgCfjywufsMOfamqmhtsVHKkdW2iYEZrGZZn+GZHoBmVgnGI9uzwLhewhLboRIf2k9f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7T/y6zPIebq+YAouYLdCINPagMO7H4czhzrGGyi9PnyvbBP3
	6Ke7+XRLIQNqqihLrbTR/Ux7mxGt9vjZv5vsg8KhKtTCv6ar77HxnScL
X-Gm-Gg: Acq92OEGDPlx2NtPncaPsa8GpFLByOb4L6afyQIb52rGz4oHlj65osguuDbgKIqE6t4
	jBDdHCz+0W3XH7Kdsdy5jrIPfvxN0ovko6huZVB1URnICn5FVawN3LwYKgmYrbb/YlryWnayXPO
	DeKl4g73cCd65zN5M+UoVcF7/dBF1NKyEXmAWBYBimpuOT/4WV9cjrw6VtlkYADybM+A4hVmO+3
	WotQ63y0L527JksQtnkMpKVu6HzD5JGSI9mWv+MO4A+6vUmgXeN1Dcs9/C8rvskB1GbObySqlKD
	XR+HSVRXFMw/Y8A3vUfC7t39sZfqvwZU7jU0rkLWcr9nNo1o7+C1XOo9+W9F/sGz8qIw87fwMcl
	0I4gdzafGGLFbx83SoN0RtrHWMS90WKVVmtz5GEPyIJW804WUjrD8geZUCLkRZvA8FThEQW77jm
	bff59hTZcq+VbvKbkzZZTmx61Nr0ZXumGSmosgcWya1UEtKkKut1YeFHI8+LAB4zmvmQcJC506w
	ECZT1K537jV+hnHTKMq
X-Received: by 2002:a05:600c:4588:b0:489:1c1f:35e5 with SMTP id 5b1f17b1804b1-48fe664be2amr136275035e9.6.1779192715261;
        Tue, 19 May 2026 05:11:55 -0700 (PDT)
Received: from ?IPV6:2a02:aa16:1105:8100:aca5:18d3:d87:7987? ([2a02:aa16:1105:8100:aca5:18d3:d87:7987])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm109146625e9.4.2026.05.19.05.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 05:11:54 -0700 (PDT)
Message-ID: <d864aff0-d9e9-42c9-87e8-0074dc35e857@gmail.com>
Date: Tue, 19 May 2026 14:11:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dev_addr_lists: don't WARN on GFP_ATOMIC
 kmalloc failure in netif_rx_mode_run
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Qingfang Deng <qingfang.deng@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519095557.3749407-1-yzjaurora@gmail.com>
 <878q9fod8m.fsf@cloudflare.com>
Content-Language: en-US
From: Zijing yin <yzjaurora@gmail.com>
In-Reply-To: <878q9fod8m.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289441-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,pastebin.com:url]
X-Rspamd-Queue-Id: A1DC757E98A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you so much for the feedback! I will address these comments in the 
next version. This is not found by syzbot by the way.

Hope you have a great day!

On 19.05.2026 13:22, Jakub Sitnicki wrote:
> On Tue, May 19, 2026 at 02:55 AM -07, Zijing Yin wrote:
>> netif_rx_mode_run() fires netdev_WARN() when netif_addr_lists_snapshot()
>> returns non-zero. The only path to a non-zero return is -ENOMEM from
>> __hw_addr_create() failing its kmalloc(GFP_ATOMIC) -- syzkaller hits it
>> via failslab, and it can also be reached under real memory pressure.
>>
>> This is the only allocator-failure site in this file that WARNs.
>> __hw_addr_create() itself, and every other caller of it in this file
>> (__hw_addr_add_ex(), dev_uc_add_excl(), dev_uc_add(), dev_mc_add(), ...)
>> just propagate the -ENOMEM silently. GFP_ATOMIC is a may-fail allocator;
>> callers are required to handle NULL, so a returned -ENOMEM here is an
>> expected runtime condition, not an invariant violation.
>>
>> The miss is self-healing: any subsequent change to dev->uc / dev->mc
>> (every dev_{uc,mc}_{add,del}, IFF_PROMISC flip, etc.) calls
>> __dev_set_rx_mode() -> netif_rx_mode_queue(), which re-queues the device
>> and retries the sync. The only cost of a failed attempt is one stale
>> rx-mode window until the next update; nothing in the kernel relies on
>> this attempt succeeding.
>>
>> Demote to net_err_ratelimited() so the condition stays observable in
>> dmesg without tripping panic_on_warn.
>>
>> Reproducer (syzkaller .prog format with setup notes): 
>> https://pastebin.com/t7AQKx9v
>>
>> Fixes: 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work")
>> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
>> ---
>>  net/core/dev_addr_lists.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
>> index d73fcb0c6..c6fdcac74 100644
>> --- a/net/core/dev_addr_lists.c
>> +++ b/net/core/dev_addr_lists.c
>> @@ -1275,7 +1275,8 @@ static void netif_rx_mode_run(struct net_device *dev)
>>  		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
>>  						&uc_ref, &mc_ref);
>>  		if (err) {
>> -			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
>> +			net_err_ratelimited("%s: failed to sync uc/mc addresses\n",
>> +					    netdev_name(dev));
>>  			netif_addr_unlock_bh(dev);
>>  			return;
>>  		}
> 
> 1) I'd go with net_warn_ratelimited() instead. The promoted message
> level in syslog might cause operational pain, and as you say the
> condition is self-healing. Seems unwarranted.
> 
> 2) Since it has a Fixes tag, should probably be sumitted for 'net' tree.
> 
> 3) Was this reported by syzbot? If so, there should also be Reported-by
> and Closes tags.


