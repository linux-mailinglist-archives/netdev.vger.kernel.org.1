Return-Path: <netdev+bounces-276184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK6NN6l81Wlv6wcAu9opvQ
	(envelope-from <netdev+bounces-276184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:52:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C493B5248
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E98B301DDA8
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE1C37DE91;
	Tue,  7 Apr 2026 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL17tiM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCF37C922
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598759; cv=none; b=p1yapdLCt3Q0OeIeykNI+AWlytoODsYz4b0yu6rzeCpLP6R/5BZh/jLRzYgieJ7BGKqvP4oHA4kvFAzUZWif/AT8mHc7epttEz9gmH4RWMQFpsn52OSy2f1nmSjlG252VprXQaySmckZ3uDYU+rdPH7g8nzwfpGOC4B1R80f/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598759; c=relaxed/simple;
	bh=GUOIRPgsNNSFlmi7aDvlteP/x8XygeSuEUg4nnErU+0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gbFXJ7cnGWtuGcI79ZIgiEoJ2nbq1e+60Ibkf2hdqKKoGtMhwT71DNMB3fpt4JEQJwVa/LPhWuaRHoVeKUcb0v54wxmvZx7xUswMf3LiKvnKS741QIZgJpybyzkulAzjG1JMquYdBqH4AsfetY4UFclabF7Uzd/gnEuYMbTCDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL17tiM3; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ee82e853cso4281441d50.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775598757; x=1776203557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w95I/v5RzbUQ4D0ck4oEV5z84JMKw1rweKYpEZ2pxQ=;
        b=RL17tiM3idhwhys5KwE2WAX9aiOouHQB8yUbDs198uYp/0PgvHSj4Ny8ixuWGTR/qk
         6Vcv/d4fehwFixzVYtmkfd4KB/kZ4anjr1cJKvuwbZmyIFzSiy+Hf7qfiiANogh98Vi3
         JhUv+McrKnVspe693Rrij015rOPOw103801H9qzL6+DMjbX1HrKWSRP3uuBT4lm91zBJ
         If+IwKqb29LrWrf9qD3ezMLCV3WM5A+IjMWKGzdsY8Gq5sZB4vdyhsHOvqb3sjCNq9J1
         2rqBJt+RDpySCuPnxwiXO1QhEqW5TePxjXTg0SfuTW4S5cGJFfRwa1Rs5hrsMW/p4iuD
         Ayzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598757; x=1776203557;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2w95I/v5RzbUQ4D0ck4oEV5z84JMKw1rweKYpEZ2pxQ=;
        b=TmSknoecwPmu+t/togBLdrvlWs7IDhkc1DPZsaCobIAF0tcVQALxYTnKB+uwrvfe3g
         9QXR0DzYxzKMowyD+8rHVQoo65gxBgWTJOPpL1GISl0g+LmtE+kf5bDTZqzHOG6oGNgD
         x8EXtxb4BjOrFx4lF4xcvt88UwkMABl4CyqZW6ebSMKcGXTZLbSwZjDso4765UldfpmC
         fyMFqbGbFCrQDbDnKhmzyZF5sVTGAIJqNAgY3YpnXijhD03Nq3QTU6yXV+MoXWsmoRCo
         xeR8/a7C4lFkljIWKbm9V3rtVLBLAv870weGvzIhxdnFPvSBZCBMve/6RzUMLmrK4fCA
         FZwQ==
X-Gm-Message-State: AOJu0YzTxE4Us0cLC1zihKAvSuYzcZbs5t2IEiYfPiDgNwpArIBsbdpZ
	Kyk9zwiWY3jJBb/I0LV9uZsVXe6Xt+bS0bYcWjy+oxte4xN2ZBlajt1Y
X-Gm-Gg: AeBDiesC3cyKW408ZxFxJKCPHX4DvpbPH+k7qUxGPIwWlzK3mOtBm/xC+b9ZwfMmAh7
	cRktxxjzqfDLWmidYhUBAh4eF7GfvRDpsZdDvjhFIihdIO9Sv0C8tfudEpRHpO3C2h4b51Idob7
	QzwyAVUBokYy7Hc65kJcfo6SAHs1R1PW8JUR/hBiPSEvXpCwbZZch2zAD4cEHDAup5cmVfYwEnU
	cuxGmRpXY1FwYJg/n9a0Ob5orv9QcaQc1uLP1dKNemogDDeuK0blnog32CqOlntpl59IgY14KBk
	wIS+uGGgJpSq4c84T2daKaIvpjsJqY3/+Leq3pH6kT8zsR6nj1gjWSZE8fGWu5fMUsDq6HIJdE5
	iqpGfojdfClwFPIgRvulouo0F0haXVx/CPVmaqZcstc6+Gb/6p5s8lv9Q9TI6mvAhjA1Tvt4sKq
	P68rcf+uB6o8VFaO8h0Z7j4iRBu5v3AQkzOt8PXZ8IXDGQORspAqMcDYcVgHBXT33Iz8YIaZjJ2
	rBT
X-Received: by 2002:a05:690c:61ca:b0:79b:d362:4f63 with SMTP id 00721157ae682-7a4d86c1948mr191013067b3.29.1775598757107;
        Tue, 07 Apr 2026 14:52:37 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a4fc065bf6sm61978717b3.38.2026.04.07.14.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:52:36 -0700 (PDT)
Date: Tue, 07 Apr 2026 17:52:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 akhilesh.samineni@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.9cf8a81ff43@gmail.com>
In-Reply-To: <20260406222305.4111170-4-akhilesh.samineni@broadcom.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-4-akhilesh.samineni@broadcom.com>
Subject: Re: [PATCH net-next 3/3] selftests: net: psp: add crypt-offset and
 spi-threshold test cases
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276184-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 59C493B5248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Akhilesh Samineni wrote:
> Add test cases to set and get crypt-offset and spi-threshold attributes,
> verifying both the applied value and the restored prior value.
> 
> Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> ---
>  tools/testing/selftests/drivers/net/psp.py | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
> index 864d9fce1094..9253aab29ded 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -171,6 +171,38 @@ def dev_get_device_bad(cfg):
>      ksft_true(raised)
>  
>  
> +def dev_set_crypt_offset(cfg):
> +    """ Set and get the crypt-offset """
> +    _init_psp_dev(cfg)
> +
> +    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> +    orig = dev['crypt-offset']
> +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> +                       "crypt-offset": 5})
> +    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> +    ksft_eq(dev['crypt-offset'], 5)
> +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> +                       "crypt-offset": orig})
> +    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> +    ksft_eq(dev['crypt-offset'], orig)
> +
> +
> +def dev_set_spi_threshold(cfg):
> +    """ Set and get the spi-threshold """
> +    _init_psp_dev(cfg)
> +
> +    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> +    orig = dev['spi-threshold']
> +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> +                       "spi-threshold": 10})
> +    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> +    ksft_eq(dev['spi-threshold'], 10)
> +    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
> +                       "spi-threshold": orig})
> +    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
> +    ksft_eq(dev['spi-threshold'], orig)

These tests mainly verify that netlink works as intended. Not sure how
much value that brings.

Once crypt-offset requires bounds checking (say), such control ops
functional tests may become more valuable.

More interesting would be to see the effect on the datapath. E.g.,
a crypt-offset that actually leaves plaintext. Not sure how easy or
hard this is, so don't take this as a requirement. But maybe something
that achievable with PSP packetdrill (eventually)?

