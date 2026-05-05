Return-Path: <netdev+bounces-284233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIweF/yM+Wkc9wIAu9opvQ
	(envelope-from <netdev+bounces-284233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:23:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAD24C7322
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B99F300CC0A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 06:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2458D3C196F;
	Tue,  5 May 2026 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KJbDvQal"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C53B38A1
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962147; cv=none; b=grBmZwWKhGX2MeaL66LNfYLCOvPdmaKG9xQqq0kwZFo3GLtreS1K45kSuQy7YmXoXBg5MW1IAyUHEYRlFxoriqaPHLeXyOaZ0FmdFjD3Ycphr6s3qR2t5WwImVolmRTEIr5GErIn9415JVOKcDY3JoSxQqDzArQjd7ZmYsjqIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962147; c=relaxed/simple;
	bh=OngZ2fusFSZ6prz7j8sCWOee2sbX1jvarWy2nk69Og4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AU4IbEOW1vNh06GgfblcDa0Zy8GB1XIWoOhOI9IbJqf717oJLOzGT7Qh5BQfAmwLgnX+oiynT+CsBG2TQgXV+mIpiygj0GeXkGvzeoMpOBGoKbv/Cmw33uHr+ePFpa5o7r9ZAaB6F38iOhwb+nUbIDQBXXjz1tYUfrmGLqg5jeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KJbDvQal; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso50838375e9.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 23:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777962142; x=1778566942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbeCRIhLk/9kzzeeJn9oXL2oBVgHxV7FJ8Zz2qL39dw=;
        b=KJbDvQalNNtFctIUIgAheW7ek0F7a06GFm4feRJBiObOJL/MkLMdrbQ/DzWvgwhSyk
         nGwIcSxbjJyPV0r6eHrH0RggNh3h4Hg1P5G65AKpXkdfzKqEesnr8ulwfbH4eU795Jx+
         Bnb2rrGhsm5L9ofib5ggF8IWhsW4mqEESPjGgRjuULGCowH3G+NL/CxE2miQKb60ut8n
         yUUuUck2fNuze0Ngpo6IRhvPq8RYLY0uCA2x6gNTRRyWaeGMbiRUXcat+0PZVvUGYszh
         f/d6WJH6vZmpo/LIskVYd9nH1hquXhalj/iZAgdWyctMq75oKrcr2hqft46mI9ocIvH+
         qRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777962142; x=1778566942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbeCRIhLk/9kzzeeJn9oXL2oBVgHxV7FJ8Zz2qL39dw=;
        b=mypaqKlIgQeohxIzBJX2WLSJooIerk1uLUXOpBlUg4hDss/NCVfhEGPoXwE4bK046p
         /2q+1nCZAq+SR3jApErbd4jHDrCQQ0a+4aoZKHFIfUr5wK1ntm9PRSPlj2evwFO0hBSW
         aEoSX8kUxkeAMjqrkSOuqJ2Ec7PlivlRbpAaui18gRvZSiDST2LgWV2CZI9VQasIHhXz
         I+2r7KdzqBxE4IHjrF/aIBar0+vpR/zQVahfdK0Pl3H+2NKYrWV4heVa+/9sFW/RQywm
         Ua9kuxaMULeGfWRp857m1NXlU83Lx60VSnryFQSXzPUoZ2dPlikivRaMyVkS0qG1xgJX
         1hZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Zrvghc1Jcq41hC9XvkrjsuChfpigDGpFPBO4WfDanon+60s/bNqBmlv+FDy7Fj8w6N9Do3nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlW/4xS3CLN44VqijgtDTaD6hQ59CIhlGl3Y/aStF3t2n01XFJ
	8rljbFqz5iKKihGI0V+S4KyK0Oc0xXhF08igcs7LKvylB6z8z8muQTtgUeRphJGRNXg=
X-Gm-Gg: AeBDieuJUX/p65C7Wj/Y9OAxRtJCao1B9V2pgmiwaYKViehtAhGyOqDL91RtnHRBhf8
	vo/fV0lm4PsuyJTCEphVtguiXZoJPAm9iujzDQ5tjb0/gEHBx7AnilyJTwIkUWPp2AFaFCCsifc
	5/hPoztoy4X1YvmzzcRk5BjrtMQld+gXtDKR2Y8BpoqU3MXCkSaSdIo2Z9qv52lxfXWC2VNMbxs
	vcce/Vz1ntwE7851jc8wYyfaLMEPalt/Fon/Rg8b+OmAWYr/z+fm/JXt64xBA4THtSRuT6S4mYe
	0e4X+8wi8iql1O9HLVBUyMcSPCxqQcB3L7RgC7mWJG6qD51/YYFYViPqEEP4rOvlXHG1AT9S9Fi
	A/ksB1ZFDn/jUBT5nljs0Mttfhw4mUhHClPBEEp+HrbI7nJUg8DDJVQVr3QLl3z8YbDSeZojjGC
	3JxdMCcjIb1+rZ/u6obVPdVUbc0UjAgb6oUqgVJoPBPBK2V9hIpkSrk/bxhWLHw21M
X-Received: by 2002:a05:600c:444c:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-48a986691ebmr206195685e9.20.1777962142318;
        Mon, 04 May 2026 23:22:22 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba6f83sm314550095e9.9.2026.05.04.23.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 23:22:21 -0700 (PDT)
Message-ID: <05d26a5d-0382-4e1a-ba0c-d946509e1db4@blackwall.org>
Date: Tue, 5 May 2026 09:22:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: replace simple_strtoul with kstrtoul
To: Aadarsh Chandra <aadarsh.official.xz@gmail.com>, idosch@nvidia.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260504150146.457562-1-aadarsh.official.xz@gmail.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260504150146.457562-1-aadarsh.official.xz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DBAD24C7322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284233-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:dkim,blackwall.org:mid]

On 04/05/2026 18:01, Aadarsh Chandra wrote:
> The simple_strtoul() function is deprecated. It does not handle
> errors or overflows correctly. Replace it with kstrtoul() in
> brport_store() to ensure that invalid user input is caught and
> returned as an error.
> 
> Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
> ---
>   net/bridge/br_sysfs_if.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 

This patch should be targeted at net-next (PATCH net-next in subject).

> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 1f57c36a7fc0..3e948d781970 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -318,7 +318,7 @@ static ssize_t brport_store(struct kobject *kobj,
>   	struct net_bridge_port *p = kobj_to_brport(kobj);
>   	ssize_t ret = -EINVAL;
>   	unsigned long val;
> -	char *endp;
> +	int err;
>   
>   	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>   		return -EPERM;
> @@ -339,9 +339,11 @@ static ssize_t brport_store(struct kobject *kobj,
>   		spin_unlock_bh(&p->br->lock);
>   		kfree(buf_copy);
>   	} else if (brport_attr->store) {
> -		val = simple_strtoul(buf, &endp, 0);
> -		if (endp == buf)
> +		err = kstrtoul(buf, 0, &val);

You can just use ret = kstrtoul() here and make this simpler, ssize_t is an
int on 32 bit archs and a long on 64 bit ones, so it can hold the return val.

> +		if (err) {
> +			ret = err;
>   			goto out_unlock;
> +		}
>   		spin_lock_bh(&p->br->lock);
>   		ret = brport_attr->store(p, val);
>   		spin_unlock_bh(&p->br->lock);

Cheers,
  Nik


