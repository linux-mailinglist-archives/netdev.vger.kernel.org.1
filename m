Return-Path: <netdev+bounces-278382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG7tJGwX3mlBmwkAu9opvQ
	(envelope-from <netdev+bounces-278382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:31:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0573F8B48
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F30B301FA92
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2763D47A0;
	Tue, 14 Apr 2026 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kus47UvF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaWeuXMd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602A21A95D
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162346; cv=none; b=OC5bCcKi4EsAiK6KZH+ExbJNl0b06gFCBW+49EuqjwNJ/QJ85HtLE//9hojrOqsONNA+tvFGn6WjDflPrIOIOgEcHKuu4C0uKG0ErwX7fJz0cxuiv1CMoePl+1qYG/bHxepy4Vj+jZu5Sss0NgAgLl8lRTAB2vNvE7bJ81sVYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162346; c=relaxed/simple;
	bh=3QXD7GJIAqpZRmLtARP/utY396oJhDYWb3JERCacaxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDdD4C1tE6LHo1k2a2PuxbN9ZnfECrbV1zFz+C3GiggFpzWAYWYZn3NqtKRnzJn0PcjDMPzA+JShX2rNcmGrW97kcmiKYM5JomwAwmG38CeWsw9qAUEuW+UFD3J3MjOtfPvoHIEU0fQ3OCSMdtxMMJwZH9GlZUnVgrtw8n0nFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kus47UvF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaWeuXMd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj1V/752PwAsLzIkNf4HW9sYa+wm+QQJNq86aY3tyTg=;
	b=Kus47UvFiz59hrG4QWPMbs0leasAn1JHUv4K0yKFAtP7vOtcxL4ekqW60340EUaJTUbeTd
	v5kTC6t05JHjmIJF2NbO7a5vN688p4ZsSJvshxhT9/+n6kLRCWzSJ7qfg1nx0G5Hh4lpLD
	aj8NvHxy639J5gI8w5MAT+KtCNngZws=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-5KfQz5gONFOh_r2sLO65Xw-1; Tue, 14 Apr 2026 06:25:37 -0400
X-MC-Unique: 5KfQz5gONFOh_r2sLO65Xw-1
X-Mimecast-MFC-AGG-ID: 5KfQz5gONFOh_r2sLO65Xw_1776162336
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d705eaa64so2629313f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776162335; x=1776767135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oj1V/752PwAsLzIkNf4HW9sYa+wm+QQJNq86aY3tyTg=;
        b=MaWeuXMdOyagHfZNhjA7xxg2OLDySp7ABUTzrB8w7PCp0tChF9iJc3Azpmm68Wsbac
         erbxJriV6F9apbUBnCmzKus9ZKSpr+u7eVwW5K5cUi4+G1CfBLLiLD/Spne2wxDn530m
         /Xe5GIHzjC34k3zYZVhfv5EOS5BbWwTA4Cv+sNzq/kC1Y5c6/92H6djx9xg/KO9DEiME
         zF5b72R7Fhh9oR1mG4+5y8VC6K2DUPLup437BfZGPXpIV3qiWyBMfbhJRIt6/xqEvRVk
         62dXYbu1up3BSrVoS2n9Tny/BDNU8Fozwx4dkbTkoVcD60fN3E2uLNGiZHA8ba3EDkHK
         aQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162335; x=1776767135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj1V/752PwAsLzIkNf4HW9sYa+wm+QQJNq86aY3tyTg=;
        b=ZQOR+f2Hjq4HYi3657khZ1Mm+B+2gy/T0eEojaQqYmgHRroitlhDYRNmCeMqANsrad
         EA8BF8ULxMwzY8eNz76QuqNArI5bHIj2wFIc/Myn6v/kRk0Pl8/bCHNQqzcGaZsZeTkV
         qth2S/wmq7UT3EhMGgDOTIyvEP3wb7FzoVLydWrH0ncadfvcOcegAKHi38DSVJYjilel
         WNgCsNRfCPNlNn87b9U8iugV4chm8xXYbuaz8CboktBITuEHHLBMyeVJhqdDpnOZjaWp
         QeaI/lhZnxzzTQaRs6cMFsgP3L13WFoHUwX0vRIrHhZKNlttYY8Ij6F0oEES45351h/X
         hSvw==
X-Forwarded-Encrypted: i=1; AFNElJ/XbMsd2dw6NYou+Fz9rids3tLa+eDbT9weILNyHAvRzEGQ2qHlLquJi5QkRdKoS6aFXofToqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ts3k2VZMGYQgSoBb2RXh762yDWjwM+MWF63ZCCnrTfFn0/eJ
	ecS3dbWcTxPPbQAI6jrG90BXCMiIRltVSJ9oOrAkZJdi2jnFXLgYptZHOe063ajybAq+q1F2xde
	94f3IigBSjrLEd8Rlv8G+7oPIoysnhcR3rI1FSv8tXCBVxqtwpps4qFQsOQ==
X-Gm-Gg: AeBDieukVVO34AB1lGRJW1FDWpobRjwY5CtmN7lG31HGiYeQNriUbAc+Z3OCUw5Bqnk
	rPiGF7VSlnE7KP6XMAUhpE3+4mgp+1HbAWu9rb7v2mfClItdFQVU1e6cCrOJ5xMnYTB+hsqeQE6
	A+lq22CPi0DNI92AuIGVxiyNZo9de01yQiTgm90gxBw1GcMubrV17Hwvqv0La8hEJkkugExilbz
	0CUwmso41XZ2zpXHHUS2i00z1+Zc3hxfgoBMQRFh8NC97tLcM/PyhErXAKmeCWh9IhL6Sr/Zc1t
	E/CrnCMOSF3atXIiQ/UqMgGCEkA044Zq2WEq/Inw0ytRDMtQg7amQTbkIHrkWC5n9Qjl5BUn3ae
	FokQhEhmLuYtNZlttdyK4MQ8fszp3gDuUBYO5aNMKqN/fcP4+rBHueVMD
X-Received: by 2002:a05:600c:c0da:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-488d685c12dmr197561375e9.19.1776162335456;
        Tue, 14 Apr 2026 03:25:35 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-488d685c12dmr197560965e9.19.1776162334954;
        Tue, 14 Apr 2026 03:25:34 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1de4asm91719845e9.4.2026.04.14.03.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:25:34 -0700 (PDT)
Message-ID: <f9c028ef-9021-4405-940d-4630732cd122@redhat.com>
Date: Tue, 14 Apr 2026 12:25:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] atm: mpoa: keep mpc->dev referenced across mpoad
 restart
To: Shuvam Pandey <shuvampandey1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
References: <20260411115958.64827-1-shuvampandey1@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260411115958.64827-1-shuvampandey1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278382-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5ec223ccb83b24ef982f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 0C0573F8B48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/11/26 1:59 PM, Shuvam Pandey wrote:
> atm: mpoa: keep mpc->dev referenced across mpoad restart
> 
> syzbot reported a netdevice refcount warning:
> 
> refcount_t: decrement hit 0; leaking memory.
> WARNING: lib/refcount.c:31 at refcount_warn_saturate+0x70/0x110
> ...
> dev_put include/linux/netdevice.h:4466 [inline]
> mpoad_close+0x1fc/0x3e0 net/atm/mpc.c:889

The full decoded backtrace is preferred to a small excerpt

> mpoad_close() drops the reference held in mpc->dev, but the mpoa_client
> itself stays alive and keeps the same device pointer.
> 
> When mpoad is attached again, atm_mpoa_mpoad_attach() reuses the existing
> mpoa_client and its mpc->dev without reacquiring that reference, so the
> next close can hit the netdevice refcount warning.
> 
> This reference is owned by the mpoa_client/LEC association rather than a
> single mpoad open/close cycle. It is acquired when the client gets its
> LEC device and is released later from mpoa_event_listener() on
> NETDEV_UNREGISTER. Fix the imbalance by removing the dev_put() from
> mpoad_close().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
> Link: https://groups.google.com/g/syzkaller-bugs/c/qhZ5MJfLBOE/m/UnotmgRdAQAJ

Preferred link is to the syzbot console:
https://syzkaller.appspot.com/bug?extid=5ec223ccb83b24ef982f

> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
> Changes in v2:
> - drop the atm_mpoa_cleanup() dev_put()/NULL hunk
> - add the syzbot warning excerpt
> - add a Fixes tag
> - clarify that the final dev_put() comes from the notifier path
> 
>  net/atm/mpc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index ce8e9780373b9..90ab8f2889734 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -886,7 +886,6 @@ static void mpoad_close(struct atm_vcc *vcc)
>  		struct lec_priv *priv = netdev_priv(mpc->dev);
>  		priv->lane2_ops->associate_indicator = NULL;
>  		stop_mpc(mpc);
> -		dev_put(mpc->dev);

Sashiko noted a possible regression introduced by this change:

Since this patch removes the dev_put(mpc->dev) here to defer the
netdevice reference release to the NETDEV_UNREGISTER event, does this
introduce a leak of the netdevice reference on module unload?
If the atm_mpoa module is unloaded while a lec device is still active,
atm_mpoa_cleanup() unregisters the netdevice notifier and frees all
mpoa_client structures without releasing their mpc->dev references:
net/atm/mpc.c:atm_mpoa_cleanup() {
    ...
	unregister_netdevice_notifier(&mpoa_notifier);
    ...
	while (mpc != NULL) {
		tmp = mpc->next;
		if (mpc->dev != NULL) {
			stop_mpc(mpc);
            ...
		}
        ...
		kfree(mpc->mps_macs);
		kfree(mpc);
		mpc = tmp;
	}
}
Because the notifier is unregistered, NETDEV_UNREGISTER will never be
delivered to clean up the references, which would permanently leak the
netdevice reference and prevent the interface from ever being unregistered.
Should a dev_put() be added in the module exit function atm_mpoa_cleanup()?

/P


