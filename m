Return-Path: <netdev+bounces-293221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGnFB6zuGWoW0AgAu9opvQ
	(envelope-from <netdev+bounces-293221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:53:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D36080DE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59F6430373C3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7B3ACA5D;
	Fri, 29 May 2026 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwCKCvup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF83A8744
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084389; cv=none; b=WtPlFcg9joIW/91iIj4Nl8I9TLX2oHjYgeZHdCk6xUp6vm9PPFpNX2lDc10wpN9C9wPU4mxI7ZEeIPosShEy09LVf6yVLiSBiyL51d+nTAo3EVPyjqTbUdXKd7PJrNiuOxebPb61t96YMnKKQ+Q6lCvMQQ9FWf7+6EN0Fkw2gR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084389; c=relaxed/simple;
	bh=YLNgU96qgUYguOF6990i0/c6t7GLHzj0zDWTizb3ptY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EUFyLRqzK7Y5LWZUW2m50pyeGohS20TmAasZ3TY3Kt7AtJy0oPbyroe9UiNV4qToMes6n1Sy26b2uVa+bi3wuaC4hlJmOYvzYPIDcYy3cwDlehSqJjt28p2XTjDARDYgl37odfFFgNpDt7VJ9c8u9rQD3BiOJNK9El70dYwzxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwCKCvup; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dccb5f4b1cso23623817b3.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084387; x=1780689187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0IvgEA3XWc8A2GTKF1x/zibAoh62BV62KMPqPz2FA0=;
        b=cwCKCvupO+ZlHn+9TM3RU2JkQ/t5UqnnmWEQQBjxyTKaf3pAmPGAgz7uHMTQRR5ZBK
         gibTu2bi1F9Xr0vf5+HfBE9fvFlPx8/fXmAn8x7bGB1rgDZe3N05BzYbCf1fSwGUM13q
         Qi2a6+DciWvnwVjP5TofPGgXuXwqzjMaAldv/Arx1KP8vxYk49hhj2ZKCwcHTqPcw+C8
         RrfGujTy9Bfo3RFhC+3EiC2jRDHSA8eSnmrayTw6lJCEEnVyRIJpz/pYM3w8RCCrYRRM
         6jF9OX9CwmC74JxMZsasDlI/lVlU5M8LUNP2rNY0gCsCWlYufbhNVb8QVCrtDet7JpTW
         o+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084387; x=1780689187;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0IvgEA3XWc8A2GTKF1x/zibAoh62BV62KMPqPz2FA0=;
        b=JFc4KLOcowsZogP92+je31IW+2JoEsqvnUeGwc0hkGtqyZlZg/2n/YbIk0XPtIvjUK
         XcTh9mPGEeBcziiweDHuKXe9qbhzFieLc195wsmI/Li2ej/oygRsfZSGMuy8vvcEBEyM
         CrzClT7cFLdYnKh6qE7tWaoWSIZnKBqaB2hVVSMqQkOlKpEV7RsokuES+uhRnq1XK39k
         4UulWUz+wtmE0YdDEJmTyqoEo6+Ymw8MWzuK9AjCCKif1+g86gvO/LWCVasY6FJTZb6E
         KxsmxuXO5mfziW+0CcIiC9YsYRa6CIWZlSFWDP5H8ZhpE7ry18c4pkIMCMY7iJgyiACj
         oulQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hm+oQMeV02MtlD3AzYTfm56n60I+2BWFlRNq9EJDWbj2MJuDmTYmfzEc2I4wsd21w5JvaWh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zmDwEs5kqQ09SJGnO9R5ER+gRcympImyv4Rc6d9AVlSPjHfG
	O49taG0yTBpvPJWFOZQIstADNZM1PTIp2/gd8v5be7+8QbJIjw1A9yjK
X-Gm-Gg: Acq92OFqyXOD+CtczaVSFKD4eL9sDB9M3BZVgbhAVmGJ8zvyMBsNoDsMSI84OzR8ecd
	xCZ6L5Y8//srGmiKmfiL7Ju5Wn/RuHrEZ3tvP7fumkE+IEMhSWgakMa1jbugygMP34Roaqlbdky
	/2KFaraTsU6CAaakHXlvMbl7WDMtr9IH7U4GwNHB3wA8Cd2ENklISHn0VS3l2DfFE3108rn4nki
	tjVUjpfIvz4DsGbkKx76UQYBa4YOaRvRIDy70eOW4CyxbPLCpO2hHG9Br2pm31Y5pViKl8xhj/c
	z8osV6I2kpwoKcvx/macLRvFAgQ5hx85AeRO1YrHlitsK/2np4WDip62aXrhIUASeZLLch4am4i
	szfUoZ+WNGnxm5o7F9VNtkGjscCPoYaETEqllCdSOkxpqRnPUhkxsBz34xSALT19LOXfL+JifEI
	nfNbnQ3vecvzq8/GiJLyxAXDe6BG4b2+Xgdyar5pWd/mbNDRVOKbTEmYGuMsY0Ajr2M2TC4lxCD
	9fDMfk7x46CmHC91g==
X-Received: by 2002:a05:690c:f04:b0:7dd:6034:b465 with SMTP id 00721157ae682-7e058283b12mr8728177b3.8.1780084387506;
        Fri, 29 May 2026 12:53:07 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6e963a39sm9743317b3.46.2026.05.29.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:53:06 -0700 (PDT)
Date: Fri, 29 May 2026 15:53:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Neelima Muralidharan <neelima@ti.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, 
 Pratheesh Gangadhar TK <pratheesh@ti.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.1794b95d53a30@gmail.com>
In-Reply-To: <20260527-hsr_ptp-v5-1-158a7633eac0@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
 <20260527-hsr_ptp-v5-1-158a7633eac0@linutronix.de>
Subject: Re: [PATCH net-next v5 1/8] hsr: Add header_ops::parse_protocol
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293221-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D61D36080DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> af_packet uses dev_parse_header_protocol() to assign skb::protocol.
> The hsr stack does not assign a callback so the field is assigned to 0.

It does this as a last resort. It is preferable for set protocol.

Either by binding the packet socket to a protocol at socket() or
bind() time (but that affects which packets will get delivered to it),
or by passing msg_name (of type sockaddr_ll).

That said, good to have this backup for senders that fail to do so.

> The header used by the hsr stack corresponds to the ethernet header for
> the "first" part so the protocol member is at the same position.
> 
> Use eth_header_parse_protocol() for the hsr_header_ops's parse_protocol
> callback.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/hsr/hsr_device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5555b71ab19b5..a999ddccc46c5 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -247,6 +247,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  static const struct header_ops hsr_header_ops = {
>  	.create	 = eth_header,
>  	.parse	 = eth_header_parse,
> +	.parse_protocol = eth_header_parse_protocol,
>  };
>  
>  static struct sk_buff *hsr_init_skb(struct hsr_port *master, int extra)
> 
> -- 
> 2.53.0
> 



