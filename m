Return-Path: <netdev+bounces-288768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBjUAd0PCmojwgQAu9opvQ
	(envelope-from <netdev+bounces-288768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:58:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDED5636A1
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C5930071EF
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35A3D0936;
	Sun, 17 May 2026 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcIMHECK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F23CF04B
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779044313; cv=none; b=nqVi7ZBWhvMTpX9Pgi2TvuCkHvdPwJNRnacqf/INV0IR3mD+3jHL8gGhL5Ibh/Z0krPxri/r8g/IUcclRE+9qBBWwdedB1nMrP/6GeR1lWxBiGSRbkt5yFxUe2EjMd1HjuhS6IvSuwnzgB/pwWExTah3okwn0CQbKqsWblGvDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779044313; c=relaxed/simple;
	bh=X1N1Sjda9LNWM4D8Izzr8O60SMnV90ARh/HDZRX+9Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw8DJZbWOfih8gQmW91tk8FpRLxU7Wy9Z2poRRyIYrKm3vmBDy1WkHaHv6ayeacNrTFsocWsoTCy3UmRRJfzSBsSsavN0qHxB/tmYhDuK7+qJePQKQ+7B8tvyttm/vXPeiyid3PO6EB2znJx9GLTXcbDQnf/HL06iGtz7kAvA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcIMHECK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891b0786beso10739505e9.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779044310; x=1779649110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jILx5HgYMLBO/y0nEz7y5+j+tjFtA4u1txX7TsURbA=;
        b=gcIMHECKsdkn0YnRRe0ZZhYq4kl9IxkfmZK1C20Dh1tzlUVqh6irDHNc9JwABfd6F/
         JOJdXxayIaKxrUl0zwQfCVrqkQo/cDZ38Avhw8+FagY82mc5x554C38k3plLKjEtgO1s
         oEg4uM9n0D9vir6Xhdw/Lu2j4P32Pkgo/2zqR0i3mwRWIrKPBSsxD5jT2mgvvTPNkX4+
         D0z60qQVTBx4AxoGzxgP4QY2vaaXg/EZIi/gS67e2apFtVJDoaHPWh+Bc0UQjMfPSTz4
         jofz9lwvyxQY9Wkqa2SzXa9wIcM7R7bSo9Uu/b0L90rFDyFE0fsZ41wbS+p1Hz5Mfqbe
         zjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779044310; x=1779649110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jILx5HgYMLBO/y0nEz7y5+j+tjFtA4u1txX7TsURbA=;
        b=sHMttJdhBI2L6M4hMrvwk7GxN1AQAe2Zfnz5UrAlbAADyIOFD7aWY35qot0VnHcPao
         0UZz0CirwjMMRMg6JWiZXeyhtJyo6HAZzFXnm5HYEYzbenIebEUclefYGXnfopYtECYa
         D1d9KpTD+zvTyXbN3jVKygEzP/MsJUisHqqAC99Jof0ogrJr1Qh+ofgoM5guHDnXg+Jj
         rU5luUgF1Vo4SbATLtuVhA28HLz/MJbd0yG8hddkKbyZLGAVSNTNoYomc1ZDA3gHABau
         fJ52zflt8o4BPnf1V1jBchWe1DOHJbUB+EpBH2z87HNtj4gYRUM5jsXbHUZdaDGnGrm9
         UClg==
X-Forwarded-Encrypted: i=1; AFNElJ+VaBEqMUGsy1RPJ9YuNpoyr4OSCw4mPtpPhCWtYRkk+bSxznf7bmxrX+Ho9IJnoyZnMpWbzG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJuUmlgpnWB3SrLQ8C5Z5HRn28bqZwyuim4h99/ScFa+enxKh
	1NK7jq5Dz0IjvLTuWnuJJE2IBkOL7TCtYZZbiDC0Z7RGSmPQJ+FaRatu
X-Gm-Gg: Acq92OF3THgx5DjrEbgcvQ1GuYWTII7UvR9mlcXsFfU3jiLu0f6KcgTY5dlbXqgKr2e
	NLyhSFqY2Nqoyr9QQK9BR1q6CCRbCpXKDY3FwFTYy+MApmBHT/FNz8TfygrfZYeCnPh3/37oHTu
	mvMaZZhfavTVK+dbKGO8QBXsYUKCgy0VYVfHUZDNPsjYOSE1tcDHJhoULCYTrkpErklDsVn+y9J
	UF/KD8xhsUPWQ/3TT0qgZrwscLICiWU3Dcp1QlO4iuHqLzvZAkrqTljbZ+FX1UXc3hfxzxXChJK
	CKP1ZI3Rj4aAPhxGmerEAn4V23wt5wBk4sHUJDM4xkccuangrM75AEE0ONRmHrfCFjVfV51esZn
	dedZOvank38W3a7505nyZXxaFi9wFmCwhww+XXk22/06PJn6GQyhLeSApaYiB6603RnSfMJvpOL
	+feasNWNEWkiEvGutaqOa2OOPgu1FGdNHBTSBX288=
X-Received: by 2002:a05:600c:8184:b0:488:b187:3c with SMTP id 5b1f17b1804b1-48fe60ee4admr177131795e9.14.1779044310527;
        Sun, 17 May 2026 11:58:30 -0700 (PDT)
Received: from [192.168.8.108] ([31.4.47.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm208659265e9.3.2026.05.17.11.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 11:58:30 -0700 (PDT)
Message-ID: <2e7d302f-a03e-4df3-8e6c-9339166a831e@gmail.com>
Date: Sun, 17 May 2026 20:58:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: rpl: add NULL check for idev in
 ipv6_rpl_srh_rcv()
To: Weiming Shi <bestswngs@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 Andrea Mayer <andrea.mayer@uniroma2.it>
References: <20260515125530.3396293-2-bestswngs@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260515125530.3396293-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5EDED5636A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,asu.edu,uniroma2.it];
	TAGGED_FROM(0.00)[bounces-288768-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Action: no action

On 5/15/26 14:55, Weiming Shi wrote:
> ipv6_rpl_srh_rcv() calls __in6_dev_get(skb->dev) and dereferences the
> result without a NULL check.  When addrconf_ifdown() concurrently clears
> dev->ip6_ptr via RCU_INIT_POINTER(dev->ip6_ptr, NULL), __in6_dev_get()
> returns NULL and the subsequent READ_ONCE(idev->cnf.rpl_seg_enabled)
> triggers a NULL pointer dereference.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000370
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:ipv6_rthdr_rcv+0x3bf/0xe70
>    ipv6_rpl_srh_rcv (net/ipv6/exthdrs.c:504)
>    ipv6_rthdr_rcv (net/ipv6/exthdrs.c:691)
>    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:478)
>    ip6_input_finish (net/ipv6/ip6_input.c:532)
>    ip6_input (net/ipv6/ip6_input.c:540)
> 
> Add a NULL check for idev, dropping the packet when the device has no
> IPv6 configuration.
> 
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   net/ipv6/exthdrs.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 95558fd6f447..19002e551a03 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -498,6 +498,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>   	u32 r;
> 
>   	idev = __in6_dev_get(skb->dev);
> +	if (!idev) {
> +		kfree_skb(skb);
> +		return -1;
> +	}
> 
>   	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
>   			     READ_ONCE(idev->cnf.rpl_seg_enabled));
> --
> 2.43.0

The fix is correct, but this is a duplicate of Andrea's patch (see [1]) 
where Eric suggested to use kfree_skb_reason() with 
SKB_DROP_REASON_IPV6DISABLED. Based on the above, I don't think this 
patch should be accepted.

  [1] 
https://lore.kernel.org/netdev/20260428224816.11223-1-andrea.mayer@uniroma2.it/

