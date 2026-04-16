Return-Path: <netdev+bounces-278976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KOtBn2h4GlukQAAu9opvQ
	(envelope-from <netdev+bounces-278976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:44:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363840BBEA
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 841A63034D9C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C5F3939AE;
	Thu, 16 Apr 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfceV0A0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWRu/g6f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA013932E6
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329080; cv=none; b=OCy1fLD4MP69+Rei7jPBL2jhGh8o11iA/mLcpVaR7gOIJKJ/19ipV3nZAlAEnKmE3Z5XFbSitQtlGnk9mQ37N3BATQQnrZ0T1x9OlEfItFEAjwMiYfhWe94FzSeTTLN5TLuZJfz3FRbTjx0tDe0cuKgltMQI9rwLO31/ztH+0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329080; c=relaxed/simple;
	bh=UGJ6qbQchBD643n+C9rEbNdzRkDADfsKl6p3tZjr3WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvAiwloRGS6ncg0v/sB6127B8RzZBVHST+lLKpI0uTbBY0+eNJOljCJByJj0S54rPlGLdlGju06NExPq95Bo8ZCsdNf9Rv35R/fvi9gQjPKJsbVHGMn+0eyfkfFNAe1CEgngMSdDA2txY7TYXwMyj5w4020KZyMTLaibrR19T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfceV0A0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWRu/g6f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776329077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeC7oMI9xA1ye20ekpAQ+wRGGOwOATVLAo/K7oEoUak=;
	b=QfceV0A0EUmk1ILh6tf5xgOrvcaxXklxh7ObZ9ggBgqKYsSTH0lmRa0XDIHp5ZjkOXoGG/
	+jU1Rr5mL6g7RfjB+srhDtSglAMBNB3FYeNK3WfuBryLv+D1RceLEma1CCWalZa0rGMC58
	pGurTlbCur++T4aUiuDeAHzd2qa+gec=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-02RD70AMOz-hVApJys9yZg-1; Thu, 16 Apr 2026 04:44:36 -0400
X-MC-Unique: 02RD70AMOz-hVApJys9yZg-1
X-Mimecast-MFC-AGG-ID: 02RD70AMOz-hVApJys9yZg_1776329075
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso41483375e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776329075; x=1776933875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeC7oMI9xA1ye20ekpAQ+wRGGOwOATVLAo/K7oEoUak=;
        b=TWRu/g6feXPhJQp7TCaSlNJBab0KeLfqPqRCnwOw06jsHxP2+fGDSNiXNSJniUXpGA
         8yF5ZO+7kUtINOeqgjJFvILlxmlGcW2DRaNmyKsVCE0hPGaBNz5AFaW8X2dvrsXFSxCv
         yT1ejGJS8nhceQQ5PHf0ly1aDKPshVtkpU2liS9f1nX9MbsHXdejA+AdN6kmmqLMsvb4
         NqOeoNSo+f9NamKMDb+SXfV/MN+N70reaCkCoplqJFMiQPE/SmZKU7zYXKx0VMORifJ3
         dwmKZ4XQ+QWeiww5IppmIvK0NnVajTRCw1L2+xik2a4dielCoMpkNMy8+j7NsAx40F6M
         D8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776329075; x=1776933875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeC7oMI9xA1ye20ekpAQ+wRGGOwOATVLAo/K7oEoUak=;
        b=TU3uGojCFXWonUpCXwkJr7U+Qa4ZkYZ1QEQ0xRxxSpbsCoAD+FDr6nbyXXO31A+sqC
         VZA+pMUqLbd3KzMt/MBTcmP5SqK0SPjkV9UDMTYGPaFFglbo8gQKfYFR9qFdv8wsH4XH
         75BoYCgNEjcyczY2rZ/aJLfp99kAZzQd/cuRYKiof2lWqxWPFSAIe2VwS7lWh1Ng3Izb
         vyxRGYwSn5r9FDFIKK+fd4iO+EhTJcp20S4xsafWGs//NOc/NMJ4ijVDM+l3ZhssIcZ5
         1EuLRkju6lIcWJcbYE6yXm8gmaEW76fAY+iw0dMvPJr5Ls59Ig9OoAuzhhCW7RhVyi93
         tUvg==
X-Forwarded-Encrypted: i=1; AFNElJ98SZ2Jmx8SuD/RbVMRRcqyx3f8ktpI0x5p+UYjriK/LDn8I0izxs9vXStrCMCQ1LgQplfGtnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+ta3TtxNKxeCImLiEjvC05pPM3/L5HXGevTzsVn7zzX95Lch
	u4srDtTREfCYHKhYR/q5W3mLi5e/uEQF7P1RbskpudvX8E06LoxxnoJ9bYRynGf+kWty+RxiTN2
	PrUHEI1RU0ocPWzeBbIDQkiBU64xnMYnm/OokknFIBxq/nrncWgTAvvLR/g==
X-Gm-Gg: AeBDieuANlmjCpbUSi39ALtA120/eVjsOWjJmUfGPwbToBSj2EuMGdG3Ujm0e1qztOe
	48m2as4a20XaPuZ1ZtQ9vbHzUvCG4RIhchIV60f6sQ1tVihwIKO9QVP9CIQcQKnnSdMcCQ89Ls7
	LgugMJulXT4HB9oF/9vDJh0GyhcjlMB4c/+wuiqEZpxNqotCuDlnd5ki7a7iYAQ8pyzD2twW6Ip
	6PQ6jD9ikgrikLKnAhjyYWIinqp7jC1iiFNz20mwgpCoZb5r7DyvmOAbLHAlKOJbPGPwETH+jqz
	/VqX+dDYKYluTWLBi2sbjdA8GPva2cvQZ28bhY5wqdnl2LsB1r1GbgSWIrjE5w0WmFdau2eKyOt
	DQezCuOufT3J7av18TbRR8wSn39FWO5XmgkZJRkj4DqDWJEX+ptTiQfUggBc7HVKacUI=
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488d68057cdmr323665085e9.1.1776329074615;
        Thu, 16 Apr 2026 01:44:34 -0700 (PDT)
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488d68057cdmr323664795e9.1.1776329074141;
        Thu, 16 Apr 2026 01:44:34 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f584e306sm42442665e9.11.2026.04.16.01.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:44:33 -0700 (PDT)
Message-ID: <f3315f5a-c5cc-4001-bbd3-bfb4aed080e4@redhat.com>
Date: Thu, 16 Apr 2026 10:44:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: Fix possible TX queue stall in
 airoha_qdma_tx_napi_poll()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260413-airoha-txq-potential-stall-v1-1-7830363b1543@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413-airoha-txq-potential-stall-v1-1-7830363b1543@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278976-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0363840BBEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 10:29 AM, Lorenzo Bianconi wrote:
> Since multiple net_device TX queues can share the same hw QDMA TX queue,
> there is no guarantee we have inflight packets queued in hw belonging to a
> net_device TX queue stopped in the xmit path because hw QDMA TX queue
> can be full. In this corner case the net_device TX queue will never be
> re-activated. In order to avoid any potential net_device TX queue stall,
> we need to wake all the net_device TX queues feeding the same hw QDMA TX
> queue in airoha_qdma_tx_napi_poll routine.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 9e995094c32a..e7610f36b8e4 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -855,6 +855,19 @@ static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
>  	return 0;
>  }
>  
> +static void airoha_qdma_wake_tx_queues(struct airoha_qdma *qdma)
> +{
> +	struct airoha_eth *eth = qdma->eth;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port = eth->ports[i];
> +
> +		if (port && port->qdma == qdma)
> +			netif_tx_wake_all_queues(port->dev);
> +	}
> +}
> +
>  static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
>  {
>  	struct airoha_tx_irq_queue *irq_q;
> @@ -931,12 +944,21 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
>  
>  			txq = netdev_get_tx_queue(skb->dev, queue);
>  			netdev_tx_completed_queue(txq, 1, skb->len);
> -			if (netif_tx_queue_stopped(txq) &&
> -			    q->ndesc - q->queued >= q->free_thr)
> -				netif_tx_wake_queue(txq);
> -
>  			dev_kfree_skb_any(skb);
>  		}
> +
> +		if (q->ndesc - q->queued == q->free_thr) {

Sashiko says:

---
Can this exact equality check cause a permanent TX queue stall?
The previous logic checked if the free space was greater than or equal
to q->free_thr. If the xmit path stops the queue because the free space
drops to exactly q->free_thr, the hardware queue will have exactly
q->free_thr free slots.
When the NAPI poll routine subsequently reaps a completed descriptor,
q->queued is decremented, increasing the free space to q->free_thr + 1.
Since the free space is no longer exactly equal to the threshold, this
condition evaluates to false.
As NAPI continues to reap more descriptors, the free space strictly
increases, meaning the exact equality check will never evaluate to true
and the netdev TX queue will remain permanently stalled.
---

Please, try to triage sashiko comments proactively. Especially on NIC
drivers, validating the AI statements is extremely cumbersome for the
maintainers.

Thanks,

Paolo


