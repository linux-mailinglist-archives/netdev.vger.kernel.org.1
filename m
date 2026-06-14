Return-Path: <netdev+bounces-299227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1QgYLGq0Lmo72AQAu9opvQ
	(envelope-from <netdev+bounces-299227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:02:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EBE6813F3
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:02:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=g4J5mzlc;
	dkim=pass header.d=redhat.com header.s=google header.b=YIhxdxpe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299227-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299227-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB5BB30037DE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4A73C4547;
	Sun, 14 Jun 2026 14:02:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843863AC0ED
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 14:02:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445735; cv=none; b=KZQVShwu3jgoFn5wo49I7et2e8uugsJYffaE4Qha0XZUw6e+BdNVTK3dTwkpFNcqr2vYiCaGZNUxQ7UeL+QwFOp7/gliiXeHR5UTjVe76rnRzfhzu1nhTODs+xaJsSdth7GiGd3R/odwAlVNnsCPveATQtWFy5HKc8gNf/nsiY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445735; c=relaxed/simple;
	bh=ZDvGN5+4mBpraO3qVXGe216HGXmWZwGn/ri8ccCpOsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeOS1rf58rngm/bd8F85paSXLkvv9j5/Y9Ky/Wkl68PRR0skfGmFNtsAOiDEWOGI8N7/0OMvoQuxAzZlb179UVq1NToWslOXtEBdlx60ztw3FKuNYlRs3UYuwWfyLPmPxejFfyQjUJ8fEIZuhCEpuPUbZLLgBAQeqt9vUtwJP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4J5mzlc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIhxdxpe; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781445731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+/NIJvNnBLV3/zRUcgfTJOXWpJU4hnOkzHbWXbEQRQ=;
	b=g4J5mzlcUlkcZhWhrCMFZtq+8q+6w2aTj5k0XPDtjb0OHOwaeWrGWQnyduKQGL2ut+wtfb
	fJuELIMAtTTz9OOcHErNhtQHwXgvl1mjXNsWI3pppLx/avbgWeVnW5nzfqJ0b4mL6EPN6O
	xyxjL1fu8asoq6Fbp7f+htYRkUhzp7s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-cmhrgVQFMmarGwA2TyUCNA-1; Sun, 14 Jun 2026 10:02:09 -0400
X-MC-Unique: cmhrgVQFMmarGwA2TyUCNA-1
X-Mimecast-MFC-AGG-ID: cmhrgVQFMmarGwA2TyUCNA_1781445729
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46067b07571so1524163f8f.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781445728; x=1782050528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+/NIJvNnBLV3/zRUcgfTJOXWpJU4hnOkzHbWXbEQRQ=;
        b=YIhxdxpeo8f8d1XeXGMx+FpbWQ5o6aCrK+cnlTaFvF8KwRUznem9q5Mh+L5ikot5I6
         sTf5PBqWO8lGxdFwq2YOPKA8e/kY4dKBvFsZRzAdI7pMJz5WuXBjODHzLcpAHr+/jlyk
         HmIY+tQfbXSAr3Vx9M2EZGZTAw85r80uGxfoQpuh0HXPjMcr3vlmdQQ2/MRM+Q7/cpZC
         OcV58K9YVRBntcSR/g2lvCc177czKQVrRCaCEd6kYmU5cRsw4yy2sJOxR2KV9nFobVuv
         JigDX7f6ZRD2I9F5h731Y5e97aHeKWNM/DY+yBWWCoHlEH894PizI9GW2v6mQJjOd1gf
         vFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445728; x=1782050528;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+/NIJvNnBLV3/zRUcgfTJOXWpJU4hnOkzHbWXbEQRQ=;
        b=ffuZfdBAOgru/CLc+Feb0okyvFUuWfDEnmjV8ozA+O1Yuf3+MsLibhnNMV4f+zfvEz
         lR9PIpwD7OdIPfqj1PV+4rLBJtPfHWmoxQ8xTYLGMtEn/LDA8/9ojkf3HJ9vvZx4gGdt
         rn70DykmHVZf1fKHrNJHagBOQKtpAFZv9yHcWxegNN7ghCRMiUAHULTp5upReKQZLxhp
         w4uh5x88u+b7M0BTw7K9FfHPlBsrC9xEjRW291OuA8HffMJfCBftjREMDA9n4MtEgLJj
         fqfDLVBQmnTeCoFAwDr+yFzPYeOl8Q653KlgeWThTUELXo9Gl55ct5YOkdX8DC5eRCGS
         exdw==
X-Gm-Message-State: AOJu0YxDiXa7g0HyYfkF5IfsCI+uAwW3fpO5JNfceW3YOG+n0NdW9VQ3
	Wzab4XCj5bloI/CVcHNeHyxQq8PYSfGZr+LAFMbBXf9yiOMwSxOsyF55wV96lzqm8m9vZsQt0yQ
	vrQLv6OFwpSL5kJUpHdJqW6DseqG7yFHoHocE6qtj7POwInFyfyplHeTUzA==
X-Gm-Gg: Acq92OGplhHB82WXSdMPR3j7JSAirSPovCULtisWAnHPvkESuGvv8VpOtAXVC+RzF49
	Yox3m3vHSkbLc/XgLzHA0q8kHyhZIUasqxPQA4PtJrc6R1zU+YcsdnxMhj6t5OnfsGh+Gz0a+6p
	qHoolSLVMvVodGrzANBl8jDbBDPJU0kzjjrHGr4Azb7m7CbfTEOG57a2hjTJ/J56KrgAFw8aqfg
	kCW0W/GPu6Apccdi3Ly3cbaGjqsW8kx8MV6EO4VEeq7zF2fxXZAPPMIQFPOHtKWtng+H/QOKUkR
	6cUFiF1xXw33fjoCImwJAcU+zSAuxG0z9ErgMjSHBzjuOVR6hbk5zgvxC83O57MGEvZkIjrXuK3
	ZVgrQneq06k69mVnNcE1SY/7IiaU2rzVewcwamm6umdGrRuv6DBNzb6Y=
X-Received: by 2002:a05:6000:1788:b0:450:ad00:86aa with SMTP id ffacd0b85a97d-4606ce33976mr12692816f8f.15.1781445728376;
        Sun, 14 Jun 2026 07:02:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1788:b0:450:ad00:86aa with SMTP id ffacd0b85a97d-4606ce33976mr12692751f8f.15.1781445727757;
        Sun, 14 Jun 2026 07:02:07 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f4f6sm26917675f8f.16.2026.06.14.07.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 07:02:07 -0700 (PDT)
Message-ID: <85c6016d-fb15-4c61-aab9-61448911f934@redhat.com>
Date: Sun, 14 Jun 2026 16:02:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: protect egress device access in the output
 path with rcu_read_lock
To: Hyunwoo Kim <imv4bel@gmail.com>, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 andrew+netdev@lunn.ch, kuniyu@google.com, jlayton@kernel.org
Cc: netdev@vger.kernel.org
References: <aitI7sLX8SIC5RqQ@v4bel>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <aitI7sLX8SIC5RqQ@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com,davemloft.net,google.com,secunet.com,gondor.apana.org.au,lunn.ch];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08EBE6813F3

On 6/12/26 1:46 AM, Hyunwoo Kim wrote:
> The locally generated output path reads the egress network device from
> the route attached to the skb (skb_dst(skb)->dev, skb_dst_dev() or
> rt->dst.dev) and uses it as the 'out' device argument of an
> NF_HOOK()/nf_hook() call, or for direct field reads, without holding
> rcu_read_lock().
> 
> dst->dev is protected by RCU. When a device is unregistered its value is
> replaced with blackhole_netdev and the previous device is freed after an
> RCU grace period. A section that reads dst->dev and uses that pointer
> must therefore hold rcu_read_lock(). Otherwise a LOCAL_OUT / POST_ROUTING
> hook consumer (nft meta oif, selinux_ip_postroute_compat, etc.) or an
> early field read can reference a device that is no longer valid when the
> egress device is unregistered concurrently with transmission.
> 
> Rather than taking the lock in each dst->output leaf, take it once at the
> common ip_local_out() and ip6_local_out() level. This covers
> __ip_local_out() / __ip6_local_out() (the LOCAL_OUT hook) and
> dst_output(), and therefore ip_output(), ip_mc_output(), ip_mr_output(),
> xfrm4_output() and vrf_output(), as well as the IPv6 leaves ip6_output(),
> ip6_mr_output(), xfrm6_output() and vrf_output6(), in one place.
> 
> raw_send_hdrinc() and rawv6_send_hdrinc() do not go through
> ip_local_out() / ip6_local_out(); they run their own NF_HOOK() and also
> read the device (mtu, LL_RESERVED_SPACE(), needed_tailroom) before that
> hook, so they take their own rcu_read_lock(). The device fields are read
> under a short rcu_read_lock() at function entry that is dropped before
> the blocking sock_alloc_send_skb(); the NF_HOOK() itself runs under
> rcu_read_lock() (added in raw_send_hdrinc(), already present in
> rawv6_send_hdrinc()).
> 
> xfrm_output_resume() is left unchanged. It reads the device locklessly
> and is only reached either under the rcu_read_lock() held by its
> dst_output() caller (now including ip_local_out() / ip6_local_out() for
> locally generated traffic) or with softirqs disabled: the async crypto
> completion runs in BH-off context (cryptd and padata invoke it under
> local_bh_disable(); hardware crypto drivers complete it from softirq),
> and the IPTFS output runs from a HRTIMER_MODE_REL_SOFT timer. For the
> same reason __ip_local_out() and __ip6_local_out() keep the lockless
> skb_dst_dev() accessor: they are also reached from xfrm_output_resume()
> via ->local_out() in BH-off context, where the rcu_dereference() based
> accessor would trip CONFIG_PROVE_RCU.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v3:
> - Take the lock once at ip_local_out() / ip6_local_out() instead of in
>   each output leaf, and cover the IPv6 path as well (David Ahern, Ido
>   Schimmel).
> - Drop the xfrm_output_resume() change; its resumption paths already run
>   with BH off (Herbert Xu). Its synchronous entry is reached under the
>   rcu held by its dst_output() caller.
> - Also protect the early device reads (mtu, headroom) in
>   raw_send_hdrinc() / rawv6_send_hdrinc(), split so the lock is not held
>   across the blocking allocation.
> - The now redundant rcu_read_lock() nested in ip_output() / ip6_output()
>   will be removed in a follow-up.
> - v2: https://lore.kernel.org/all/ahveCu-zzFlpeVut@v4bel/
> 
> Changes in v2:
> - Changed to a net-wide patch that also fixes the issue in
>   raw_send_hdrinc(), xfrm_output_resume() and vrf_output().
> - v1: https://lore.kernel.org/all/ahqIg6vURwYI0LJ5@v4bel/
> ---
>  net/ipv4/ip_output.c   |  2 ++
>  net/ipv4/raw.c         | 19 ++++++++++++++-----
>  net/ipv6/output_core.c |  2 ++
>  net/ipv6/raw.c         | 16 ++++++++++++----
>  4 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 5bcd73cbdb41c..26b51ef0763fa 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -126,9 +126,11 @@ int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
>  	int err;
>  
> +	rcu_read_lock();
>  	err = __ip_local_out(net, sk, skb);
>  	if (likely(err == 1))
>  		err = dst_output(net, sk, skb);
> +	rcu_read_unlock();

IN RH we are observing small but measurable and reproducible regressions
due to increased number of rcu lock pair in the fast-path.
ip_local_out() is invoked by __ip_queue_xmit() already under the RCU lock.

I think it could be usedful either providing an _rcu less variant and
use the latter in __ip_queue_xmit(), or open-code ip_local_out() there.

AFAICS the ipv6 counter part is not in the local output fastpath.

/P


