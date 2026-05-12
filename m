Return-Path: <netdev+bounces-287003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK4fMiXlAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-287003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C851CBAF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1321C3006D7F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA5492514;
	Tue, 12 May 2026 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="icI9PrrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630E38C41B
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574564; cv=none; b=k0mLzq5jqFQ82vwjJ9IC7ji2zGYl1p+UD8rEAdDSyDCVgpZzypRtBtIu17BjYvXKdqy882xg2sa7BMVWFxAWWhQ8qZS/YJuXk3+/r55AjxTN4e4doVnXLFhKklLeFlcH14R/JAGZ78iXKV+ziPTRJb4+WaIJvgUYfmyC1swVBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574564; c=relaxed/simple;
	bh=XSUKlyPXQjtYXxb7m5qC2pdYB0fFCekz9mHLMvhuEPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZVL28aE4AsDt9EG+DPmsnSzLFT3332LWU9c7/8EHI/8ACA+zQSJHPMPKFzZkKyPK2oVnOwp4enbo//qdLuTrDDEifPh4Petu9XI2ICDNCSjFVpA4v4Ty0iiRyFNw6GN/TqlpsQ/R4b4Ipsoor6LB1SZ+8eHCJGnhw+t01QH9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=icI9PrrC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso2981658f8f.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778574560; x=1779179360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXZa6qDwstyRO0OpnTlrlrZgvCtyoANqsIG4MYUa2C4=;
        b=icI9PrrCe+B2f4KMqOCbhWkKUo5JNb208Jj+7Mu2ZGyRmaxgzqo9xUlL5CiZ1WG8tO
         /KSBth1nCFC3+w5B9vWZN6nBy+QEZy6ZmYjug3/P6i80sl2ajh/gnQg2ITrnch9ia9Y5
         ekXmOox/hysBwEBS/T6P42PxFmi53cNXA9g1C/wacum3fpGrT3kgWbDRCGOBTGyP4JvC
         9AmpH4RFoJ0tnLpXL0py8Z1B/oehz3xPxMMyNYHDiEvgGwwfOQbEOtNbHkBrAptFR+ZG
         sI6MFfDTNX3LhJ58GB08kylFUUEKWskA4qpnX042GM+NjnYg50p/Upk+DW08qoUu780l
         GnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574560; x=1779179360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXZa6qDwstyRO0OpnTlrlrZgvCtyoANqsIG4MYUa2C4=;
        b=AOQ5Ft9ZpmCCp59iBLNN9vn6dEsSs7I0y8CWxJvpqGwLcnpUvEipxJl/YqVNLsZIQY
         0PD2AnZ6du3kF253CAFuYocB/ndqkXmlNpVDVKXfQLekaAirk1NpoYeZlyeM3AOSpZyy
         8fT/u1Z3e2T9AeXDtU0fpQXpo/JA9X9AjFOVyfdsraHBp0+Xd+vBPzMmHPqcHodQNKZv
         EH5FZcpSOFlOzei0Q82UIWzjLlLXY08ZgF7xNSinytsWHHKYzaJTLZU2OoiqMgSxO30d
         gLuwe2pyaREwZo4Asfy4NP+URwXJBUy+9+3rLwo7QUjTQmuGToQ+4qCqmz3UgB1w5zVj
         hZtA==
X-Forwarded-Encrypted: i=1; AFNElJ9KEfPBmYaumNllz0fv99BkIV4N/2fI2fLNArANzcYNVDicd84OWFiPG9ln58E29PhPUene93Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx80UQn2fHF7xjHj9NUSNXY2nC0rCzVfgk30my938F7brucB7I
	+mWw+yR1IuRztjLa+nW7SKLwSRq12ZQdsNomydZaOMWvIyGhpMJytS2CvItGjNHZkhM=
X-Gm-Gg: Acq92OE7JASu9JW5vNcdSnR+vSv5Dq2RRzntMyiKcbgtDAshG3O0sm6r1I3whhFtQoW
	aETJLF90L6RcxoVOvqJeBXArrhmShk2U7YFH+HT2IXqbq4E0Yt8kY4VYHTAvfQ65HrlDZzzW/n0
	6VMlXWWqKL2VBAaqvNUh9v+bmU6ebn7NZkl0r2GTga1tfBOIwxvhQOs5TjPNXiLh4AVFXQtMlye
	sWZCQx310O1eWILpEV+JwMOxREUYPX+UTlXtIqBu/DC6vwOxl/ICbfJSpTGf789FOjwR7Py628M
	2RnIZe1DDCG+4QjOp5AvIAwFzWg9T/2wt3RQpbAQ41CfpquY+vKInGgh6XukjyxicbE+v3GI1+M
	YWvSrHtaeq3x1UTZ7X926AmtVxkO2Z2sameMVIDMzg+R0wgwE+3cI2EPlbmKscnnQ/75qGtMPjI
	T8Sd55TKi1+RvNBRaEO7Uj3+Axfy8ux28he6gUcTWOJ8q1KO7jctILtAow+T6SuuA8
X-Received: by 2002:a05:6000:2207:b0:441:1cf9:4f06 with SMTP id ffacd0b85a97d-45b13e57a90mr2629777f8f.31.1778574560083;
        Tue, 12 May 2026 01:29:20 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm30756065f8f.14.2026.05.12.01.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:29:19 -0700 (PDT)
Message-ID: <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
Date: Tue, 12 May 2026 11:29:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing
 port
Content-Language: en-US, bg
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, fw@strlen.de, davem@davemloft.net,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, tonanli66@gmail.com
References: <cover.1778504155.git.tonanli66@gmail.com>
 <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BD6C851CBAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FREEMAIL_CC(0.00)[nvidia.com,strlen.de,davemloft.net,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-287003-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,blackwall.org:mid,blackwall.org:dkim,lzu.edu.cn:email]
X-Rspamd-Action: no action

On 12/05/2026 07:31, Ren Wei wrote:
> From: Nan Li <tonanli66@gmail.com>
> 
> The bridge local receive path may be deferred by netfilter and resumed
> later. By the time br_handle_local_finish() runs, skb->dev may still be
> valid while its bridge port association has already been removed.
> 
> br_handle_local_finish() unconditionally looks up the bridge port from
> skb->dev and dereferences it for source learning. If the port is no
> longer attached to the bridge, the lookup returns NULL and the deferred
> local receive path can no longer rely on the port state being present.
> 
> Skip the learning step when the bridge port lookup fails. In that case
> there is no port state left to learn on, so returning early preserves
> the normal behavior for existing ports while avoiding access to stale
> state.
> 
> Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")

I don't think that is the correct commit, it seems to me this bug
has existed for a very long time. From a quick search I think (Florian
please correct me if I'm wrong, but I think NF_QUEUE existed back then)
it was introduced in 2010 by:
  f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_port 
pointer")

because that commit removed the same check for a NULL port.
The patch itself is ok, it restores the check that was there before the commit
I mentioned.

> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_input.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 2cbae0f9ae1f..5b0d7450de5f 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>   	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
>   	u16 vid = 0;
>   
> +	if (unlikely(!p))
> +		return;
> +
>   	/* check if vlan is allowed, to avoid spoofing */
>   	if ((p->flags & BR_LEARNING) &&
>   	    nbp_state_should_learn(p) &&



