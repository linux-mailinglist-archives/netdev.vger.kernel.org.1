Return-Path: <netdev+bounces-285345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHy/LRqe/Gn3RwAAu9opvQ
	(envelope-from <netdev+bounces-285345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:13:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAC54E9E6D
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4337C3023DEF
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844F3E92AC;
	Thu,  7 May 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEOaYx95";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jZvhCvgw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB237BE60
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162924; cv=none; b=uK7h84PZ2N8OkwGY0Ty18+Y8/gfBvLNo3MGjCthARsk75SYzUkudjRsUV/2FXlcDc3Aq1DXDdZQR3K5+NA9twhPZO4yPIzmSEqeO6w+xA6JpPwR+/lPRGuAOr4O2ADcXEiOGAGW1MaQaagF/Juw9L1THfn+IG4i2outuXkGSZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162924; c=relaxed/simple;
	bh=V0H+uFjPvZq71PDhJj6Mg13maJnYoEVsPn9f5ZUOJ8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=somMA7pm/gMm/5gpKmoHNNCCMpcF/O+x+lCt2tLWa9jR/+LBpz5YEa+5YMPAlYCPOs0cGTl8FAXIqxSie8jXiTsWPrDHPftb0mymQ5P3Xdlha/CamVNli9oOHN6n9Dw5PmqLbba25TuYCby5mNycUGQWTWJkTxPK2Z9N25kntus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEOaYx95; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jZvhCvgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778162922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2nhovRvFw1+XQcDcRJ+2hvlsNXDoa4sYKL7qfbTHmc=;
	b=eEOaYx95GBPZ3m0mH9Y31Z7AWpWvDl1/uYFJAqXw/Ur7qEdtPT8tE1zXQNaS4YJr8YwOia
	oohaYj0QiCKy6FeXxY+oAwLdtPl5McBaLStYMcDJHXaB6hZxIotn2ZZbGfxMvQoxRnqh6w
	pb4FqVmfSszCJzbXBVZkTN2/84lHng4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-BWsry_MzOWeNmXN1jPGV_A-1; Thu, 07 May 2026 10:08:41 -0400
X-MC-Unique: BWsry_MzOWeNmXN1jPGV_A-1
X-Mimecast-MFC-AGG-ID: BWsry_MzOWeNmXN1jPGV_A_1778162919
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so4126435e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778162919; x=1778767719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w2nhovRvFw1+XQcDcRJ+2hvlsNXDoa4sYKL7qfbTHmc=;
        b=jZvhCvgw2H9F591bEDoKNQ+lHBu41wFBvJS7JIXu+bum4Sk8wyr9tIK/VqvsmaTuws
         GHyJ4w4HRh+isLc3NVYIETOn7Hzuz/i42ivTPcHKmdJdWddBDiRhs9GEPAJOrJ/U98Op
         YUsGdAe75O2U5VSamzawPhkVk971rVeeE0o4tw8OdpjbfOaBhcP06RT32GyILc8Y+9rU
         HSOGjh9heO4byR0Def+g5DM/Je0GGJjxEylXXAae1l5Yu7lgQWrMg5GCQBkx7wXttCx6
         KfPatBYFKq3XhrS4pFvG7vEV6USU+cOmaEj7eSHuDuEqe5zZ/uaeDRieqxuu0Xwl4PZ7
         lvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162919; x=1778767719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2nhovRvFw1+XQcDcRJ+2hvlsNXDoa4sYKL7qfbTHmc=;
        b=HkM3RH5jxotbdwN+/XaPLQCV8n+VRgqWTNBnY29a8LDmholoag0os4GaG++1dn5+rC
         tC7KU1z+ahNEKQ5cmXbwaMM8SyH17Cl5FsEovRh/OyosgHXAVQ9NMpEFYzu3K6/DEVOH
         T3G9DxSOxg35/fmCsYinngs8qKX3c7XA+6rn9z9bS7gL+bB/ar1i5ZdEGSUXtjZLobLf
         jbdvFpnTTcqSYMz65PCD3mBkEg2jycdNJB9jo8aHcVyhFVjQy1VUhMkZIKVQJ/ryWub/
         rhzb8DEaDNxAGvUwiJ3k22y2iOltigGN4jrbeTsysekHZZ6PfnjH+WOY4OGSIoOjNbmd
         TeNg==
X-Forwarded-Encrypted: i=1; AFNElJ8bD0OEk9l6Gqt0+UrO74K6ZFTctHJjjMO3Yp0VSp/Dvk5DOC99MAYrIs5T8ELDaHFO9pJmeJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YItBgRXhCSKrHh3lZSFMWWGtCVjZfOO6prm54qXq2S0RSKyv
	5xGc4H3mLyM0TVS+VZeJd0+eUw7JNolLblGLe+nblnU8JBs2PAjOqBzrRUj4K2m9Gf3dmmcYQD4
	H/6XS8v8wiPnyNsH/Mfdf9McnYjg/RKTuvbs/jEgGLlmMITb5CA1CJ6x6uQ==
X-Gm-Gg: AeBDievVXWnMyye7shnszigIDGDfew/n36ND/cTw1lACXQ8ecfCgqJqHdWqPaGrtJ/l
	7zZB4g2a1PHrk4rPXzl4179H9/GU051OlF1cCGuR3fFu5/KMAR/OMgr+fTeJlJC4EuXXg0TaBea
	Vm88iVtmeBu+y23EkdVMt4KWupwJ/opbwiLlNYgE/TdPbtfr5aREDbDHl3n6mMqK/w6v+W8gW8q
	pzlvAGC3zm7Hp8KX8JUc9gqW0ZjQxMqdnx/RyF7VmTmd8oiIRq/IAjYrSw29rZ5HnMBto7QY7it
	s7x+Pmtb1w2qn/Sa29FAAxl4jVovrSrFkqPltleLAc3/f1sDC6uerZVZIo3wjZYq6riwHSovlZO
	sdmC3XLP6OopDy+o7PYiLEa2FPsWs2w8eSAweKw89bePsMDcWlejEhQUYjEFElJzdhiGtAvE4jw
	13
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr46917745e9.9.1778162918812;
        Thu, 07 May 2026 07:08:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr46917155e9.9.1778162918260;
        Thu, 07 May 2026 07:08:38 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530d8691sm91116195e9.2.2026.05.07.07.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 07:08:37 -0700 (PDT)
Message-ID: <dc0f052e-797e-4849-87c4-a98b8ede19d3@redhat.com>
Date: Thu, 7 May 2026 16:08:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net: dsa: mt7530: fix FDB entries not aging out
 with short timeout
To: Daniel Golle <daniel@makrotopia.org>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 DENG Qingfang <dqfext@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1777986341.git.daniel@makrotopia.org>
 <f285707e09a0febffd1b987f204ff4eb71736489.1777986341.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f285707e09a0febffd1b987f204ff4eb71736489.1777986341.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CAC54E9E6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285345-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/5/26 4:16 PM, Daniel Golle wrote:
> When setting a low ageing time such as 10 seconds, the algorithm in
> mt7530_set_ageing_time() finds AGE_CNT=0 and AGE_UNIT=9 as the first
> exact match (starting the search from tmp_age_count=0).
> 
> On the MT7530/MT7531 hardware, the per-entry aging counter is
> initialized to AGE_CNT when a MAC address is learned. With AGE_CNT=0,
> new entries start with a counter value of 0, which the hardware treats
> as "already aged" and never removes, effectively disabling aging.
> 
> Fix this by starting the search from tmp_age_count=1 to ensure entries
> always have a non-zero initial aging counter. For a 10-second ageing
> time this yields AGE_CNT=1 and AGE_UNIT=4 instead: the timer ticks
> every 5 seconds and entries are removed after 2 ticks.
> 
> Fixes: ea6d5c924e39 ("net: dsa: mt7530: support setting ageing time")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/mt7530.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 44d670904ad8..b1903da7d500 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1027,8 +1027,12 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
>  	if (secs < 1 || secs > (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1))
>  		return -ERANGE;
>  
> -	/* iterate through all possible age_count to find the closest pair */
> -	for (tmp_age_count = 0; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
> +	/* Iterate through all possible age_count values to find the closest
> +	 * pair. Start from 1 because the per-entry aging counter is
> +	 * initialized to AGE_CNT and a value of 0 means the entry will
> +	 * never be aged out.
> +	 */
> +	for (tmp_age_count = 1; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
>  		unsigned int tmp_age_unit = secs / (tmp_age_count + 1) - 1;
>  
>  		if (tmp_age_unit <= AGE_UNIT_MAX) {

Sashiko noted that the above will have problem with secs == 1:

What happens here if secs is 1?
Since the bounds check at the start of the function allows secs == 1,
tmp_age_unit would be calculated as 1 / (1 + 1) - 1, which evaluates to
0 - 1, resulting in an unsigned underflow to UINT_MAX.
>  		if (tmp_age_unit <= AGE_UNIT_MAX) {
Because UINT_MAX is greater than AGE_UNIT_MAX, this condition will fail for
all iterations of the loop.
[ ... ]
>  	mt7530_write(priv, MT7530_AAC, AGE_CNT(age_count) | AGE_UNIT(age_unit));
If the loop exits without ever finding a match and entering the if block,
age_count and age_unit will remain uninitialized. Could this result in
uninitialized stack variables being written to the MT7530_AAC hardware
register?

/P


