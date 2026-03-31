Return-Path: <netdev+bounces-273541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGluKtqUy2nMJAYAu9opvQ
	(envelope-from <netdev+bounces-273541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:33:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91702367210
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 026DA3022F67
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24A3ED5BC;
	Tue, 31 Mar 2026 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5gyz5N3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sLy73V32"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA43D903C
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949593; cv=none; b=nfj8jvgeKWVGZUenyhsTDqk7Fwx+tQ5Ce/gL2sziT/0JXVa9hbxCPA2a9jmIGOyiCrHFxhAWiOZ57DO9AHwU0LMYZUDfrfRlPNyktBhuvhdpBqt0ggWQ5TzOsdtfnjrYSp71cCOoX+3bs+w0TUjKVvzbJAVg1NrELy82YJCA0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949593; c=relaxed/simple;
	bh=UXqsQ0BBG7/4O3Wp7zNRvbriuKMnrUyPn6h4dz9TOok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LmEeTHU37zbdOTPexHQyfaiGZDFOtXt1P5SlKirGe+XEFbd6h9ndG8J/wbcpG5bBjRWS4t+QFymaXNw3EW4uJb5cyFH0OOJWO9kV24HrGaLCbC5vqqNVqhzkBsh1y2k+82KlAc7T0fk7iBYsdK3MkGrOIX9MHHMMfxrDylrYPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5gyz5N3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sLy73V32; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774949591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp9JL+N08mDhUd7pdtaI366A6NgeulMET6+HShC94Iw=;
	b=B5gyz5N3A77j4mq5HYYnOHyhRWU1HKfN9xJJFAd1juiVNL1n3HMH3UFXi3u2uXQUU1gnHP
	lWKPe65XhGHWcmSGcgoREkfcw7IC+iiep4iVBRgNSAJu1dVgipMLCachHm0k6FGPXBdyeX
	64AbW/qQXEW9jtIjaW8r1qpsYba1dzk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-1mhDegdyPmOhgORr02VaEA-1; Tue, 31 Mar 2026 05:33:08 -0400
X-MC-Unique: 1mhDegdyPmOhgORr02VaEA-1
X-Mimecast-MFC-AGG-ID: 1mhDegdyPmOhgORr02VaEA_1774949587
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fcc05b20so36598085e9.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774949587; x=1775554387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vp9JL+N08mDhUd7pdtaI366A6NgeulMET6+HShC94Iw=;
        b=sLy73V32vZB27HWug4g9fBQvdSoTej8qtkeyQEJYT9UVudnWnsu8hX7LMDICrJ/YbA
         efkFxQ1UWB+T4LS5ovHR6rMgRjRqL+RYhD29Q1JJ1zqljkqAUTDgnLFYpF7okP6ymfxW
         dSo8xbf7CDqYwYH9hmGyJS7Ig4zL4hVx4eYv2ZZhkD+J/3W1wEHZrgyugEahzjVPQKDX
         hiCb3VhKdFRkglb5ypAj8XSjxIjixJqNOx3QOu+Txt7d3Yl52CuU/EldLhgJwR6cw7kg
         tQXMI9pNeUeOtJfjveQd4whNKbxi2L18OiYCPtM0WTp9jShiLlpWEOREjkvjhuXgHd1L
         smzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774949587; x=1775554387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vp9JL+N08mDhUd7pdtaI366A6NgeulMET6+HShC94Iw=;
        b=aU6hZ04H6Bs6AXV0Ofke9ChRxCiuTEZDITlAXBUmSHbkNTcuMQhwdaNVBe8Jv3TkDy
         MGG0f6DhfElcEi68PHJzZl04PuyyqbP2dCDU/vS9jyVJaKD9z8jz5tMdI75KiS42qbad
         8Jx0Hxb1w8g1wmWWiT74Y+QTh/1OSmjxtIi6iezKAG0A6Ir6VKzABIyA3aNXIp7NBqGn
         zLFVtXAmjKTHl06MnFcopadPXp3rZE6E5E+lMUtT4jV1AtBzocYsOHvQn+OyMFB8hRRU
         LMSMlylun67wVrKQCtiQcOnKECBIY1jmtfuVRDw7Ca0L1h8zNNgpKNYiF/fCJ2DMz6Xv
         s/gg==
X-Forwarded-Encrypted: i=1; AJvYcCUjor1h2eSixnFPEAPcJ52TePqCXnFh54N/9v2JPn4/wW0ZeYcd96g0KR4a9fTmHNP2ujZ9i00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQnZv7cGESZH8EQbPZvrw3h531p1vpnXDq6s+AOwGesejCTy+u
	U/YIPYL/mnDmmCj7wf/KPACYHSqE9Z3M2Q9YN2G7QJGIPdqMGUCIHIkIN4AqFAKiL5OW0mqDq7l
	0VdKIL5wrOAV6dGgWlAdr24sTB0uJiV4uUy0LML6l26rQ3bUS9If1uh1P3g==
X-Gm-Gg: ATEYQzx8MiE4biHf40T8fGtKE48328tVDFLxX+dCaW2g/i4tvWWkvRekQ4JblIAtrb0
	AZay79WPtjBF94eN9JT287ZzS3DsUrNcSsEZjFjK6qBgq+0XdXMAz66IYkJxJmKNKRJurn3FlB1
	vEQg88pMzbEmiG9JvFqibNnsz5ToIwW2njYlU72uklKSMtJsOdB55Tg8xQLDBIFa4Jb/w2YNf3U
	Im4OLBn4/DAAxcctERHIhrnVxrI6VceEHEhrgINDaiFddx8V3JeEAKCfZ2NtebkMihbAKW0kZnz
	nTCYp7U5Ar36FROoYKlxswXk+N+YMpsapJy3IvgEIBrR749eW1sGCjkfZzbH8OTL9DgMb59mBuI
	weiQmBXCO3rGQb6YLKYJttb5Mk5HzSW2w+b6dXHGIf0ayThsVsnpjvbQG
X-Received: by 2002:a05:600c:8489:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4872807483cmr267365965e9.25.1774949587046;
        Tue, 31 Mar 2026 02:33:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8489:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4872807483cmr267365375e9.25.1774949586546;
        Tue, 31 Mar 2026 02:33:06 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm23911365e9.7.2026.03.31.02.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:33:05 -0700 (PDT)
Message-ID: <f0bc585f-b1d2-46e6-b0eb-801881862692@redhat.com>
Date: Tue, 31 Mar 2026 11:33:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: hardening: Reject zero max_num_queues
 from MANA_QUERY_VPORT_CONFIG
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
 shirazsaleem@microsoft.com, kees@kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326174815.2012137-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326174815.2012137-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273541-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 91702367210
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 6:48 PM, Erni Sri Satya Vennela wrote:
> As a part of MANA hardening for CVM, validate that max_num_sq and
> max_num_rq returned by MANA_QUERY_VPORT_CONFIG are not zero. These
> values flow into apc->num_queues, which is used as an allocation count
> and loop bound. A zero value would result in zero-size allocations and
> incorrect driver behavior.
> 
> Return -EPROTO if either value is zero.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b39e8b920791..a4197b4b0597 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1249,6 +1249,12 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
>  
>  	*max_sq = resp.max_num_sq;
>  	*max_rq = resp.max_num_rq;
> +
> +	if (*max_sq == 0 || *max_rq == 0) {
> +		netdev_err(apc->ndev, "Invalid max queues from vPort config\n");
> +		return -EPROTO;

AI review says:

Will returning -EPROTO here expose a pre-existing resource leak in the
driver's teardown path?
If mana_query_vport_cfg() returns an error, mana_init_port() fails and
mana_probe_port() frees the ndev, leaving ac->ports[i] as NULL. In
mana_probe(), the port initialization loop breaks upon this error, but
the err variable is then overwritten:

mana_probe() {
    ...
    for (i = 0; i < ac->num_ports; i++) {
        err = mana_probe_port(ac, i, &ac->ports[i]);
        if (err) {
            dev_err(dev, "Probe Failed for port %d\n", i);
            break;
        }
    }

    err = add_adev(gd, "eth");
    ...
}

If add_adev() succeeds, mana_probe() completes successfully instead of
failing, masking the earlier error while leaving ac->ports[0] as NULL.
Later, when the driver is unloaded or if add_adev() fails and triggers
immediate cleanup, mana_remove() is called. It iterates over ac->ports
and, upon encountering the NULL device, immediately executes goto out:

mana_remove() {
    ...
    for (i = 0; i < ac->num_ports; i++) {
        ndev = ac->ports[i];
        if (!ndev) {
            if (i == 0)
                ...
            goto out;
        }
        ...
    }

    mana_destroy_eq(ac);
out:
    ...
}

Because the out label in mana_remove() is located after the
mana_destroy_eq(ac) call, jumping there completely skips destroying the
event queues allocated earlier by mana_create_eq(ac).
In a Confidential Virtual Machine context, could an untrusted hypervisor
repeatedly return invalid configs to continuously leak guest memory and
hardware queues?


