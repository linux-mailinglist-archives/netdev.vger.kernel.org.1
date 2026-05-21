Return-Path: <netdev+bounces-290475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL5uGV4XD2qVFQYAu9opvQ
	(envelope-from <netdev+bounces-290475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:31:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C442E5A7518
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1057B339C27E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6A3D904B;
	Thu, 21 May 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haL/Vvtz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR9ZRlfU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912D3DB314
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371660; cv=none; b=VxWFCk/G9Jc/tJnjQMeHV5FrrPEdScyVJoq1I3ngpy8Rb+OluD1snUaAKmnXmtfeJDYeBP9703XImCBNzEcUEu3ZKkqhKsUQbHxvQXS2NzQqBVrvuK8pTpPfFIZQQVeeEUN7sE7Y4rYBybGg7yhEKkputFdceASkU/8zuQoYQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371660; c=relaxed/simple;
	bh=Tzbrlyk6EvI6Gpf6kF7mrLIY403hGtobLCVySFasVjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuO98jbBX9O3JBcs6OFE7hNYGjXuLgo/DkFgf/j/AMOxMcJXVLr8tEULV6e+1PON5eFl7Jj28wYcRLlYiRTOP9sfSuVKHrG2gvr8zlmfqHGgNJZSVpWtRdHH1NyFWeBowQYA9KoGAx2Kvw5GlezDGNpJ6vfM/8cW/MlL4z0r0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haL/Vvtz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bR9ZRlfU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779371658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBLWXev3FccdzkJq5D0J1DCSF7WEsoh1qu9aui1pYpE=;
	b=haL/VvtzW13t09yLHtDXLxI9HAztdYlKDs9/j3Xic3nHP/kxJ60Y0IUF7RPP7SME6DU3ve
	EBExp1jU3tvzp2AATtNUgZ+DtSN0dudJ9sbpjUJwBGokxGdzSgXvRxBPOxnp0KO8yC/CrM
	SMzDYfA3sh0xmFWCaSZPT1yvQ+nG6pI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-QK0R_SGJOEOWMdiFYuTyFA-1; Thu, 21 May 2026 09:54:10 -0400
X-MC-Unique: QK0R_SGJOEOWMdiFYuTyFA-1
X-Mimecast-MFC-AGG-ID: QK0R_SGJOEOWMdiFYuTyFA_1779371649
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d83e45febso4905547f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779371649; x=1779976449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBLWXev3FccdzkJq5D0J1DCSF7WEsoh1qu9aui1pYpE=;
        b=bR9ZRlfUe1pW3N2KObt5+BR00cXyfXzhC4zBJrMWZWsjghDCMIBCxmcQsQGOJ/jhER
         xh5+Ou8xzU/IEjombfa8tpg4Z6SXrgdAntDvOootjm15AIayriCP7J3+d14XYtR2xlsC
         OQCj++1zQse+kRC50OwZeoGElYMePSwm9b9LGaOFEXTd/xSn6IWmC596Tb8ofsedpyRs
         8V0S3Vdc3xJsvfY0RqrC7KNH/6ZBsVAJcxsWsyP7YrrZ8MI120wEneSZEsFBrkLL0sVN
         HakWubZMogwrMUvOmgLmyv9I1msMriRZw9/MQ2ncqPOx+ITOJjZ4mAZjuRHo91/kkLqi
         loaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371649; x=1779976449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBLWXev3FccdzkJq5D0J1DCSF7WEsoh1qu9aui1pYpE=;
        b=L35KEdko7AJYFJR85ZeRuKiJ7aKQ1/8AE+n05l4/rmztj4b2hjY/S8MDi9gZUcgsbR
         GP+0CVZxLR6Qv5YQCDJ9khd1GHYJAOMFAF3h2q4xU460Qzd1ZW6ClZLhUjvsEMPG7Uk/
         9yk8DSw6j5hd8A71J6unwwaSsF+dA4hlXNCp9pA2PzJbj/KAq640mNE2BPmUbGyci5Ys
         ckHTMMkOXpa7Mj124JWVJjK3KtHn7KhYI7MZK2oymNsOhxUVobqw2jUAb7RWbAn+cQ+v
         bPbcVGGLKcJn+TqrXYrwNYCVpNNnDYFH8+xuamfYBv6qe7u8muR8/o3QHgvabBuBCaBR
         4BzA==
X-Forwarded-Encrypted: i=1; AFNElJ/hTzpAvvkxaYYao7yJusk5h1lrMn7yFo98wVlFUYudRXqv1nf/79xnkzQN+3rgNktpGuIjCHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8V4+G3rThOJKWr4NTIBVPNap+qxqizjyoObkTFsTGvUYSWsK
	244eoUgGPFLQJc0vpXrgEhSZVqsCxR+j7D3PL5WDuGSw2rqy1VRimcXR079ycDcjOc2VT8sQEao
	z6EkYRMc359xr51hYGF7XbSrs3W9ih9K5Hm2GvTNxxRlqByVghnojNiURqw==
X-Gm-Gg: Acq92OGbhQJV5e7+JHizZktpraE/85brjELHdJdKGL/2sjmzuxULHkquVqvBpdeMpQX
	z2RDmPiiB6qXvQs+gJlfzfLKMCLBLXpYAGqKEaKbKeOdaxuhQmNIIdUwD2l/J/lVpfFDSYiGeMY
	q0EK8GV0gHDsWSYAI3F+WXY8XPQcRQQkLWql67gScBRCazRshw4dlQOZiGkndPQcB41+BwirY62
	Fndaw9Gon+yRiAlXSN2i7jP0UMClQ/ydlK73ANw63kH2wUDVqncCfTq4uMhnKL3QnLkVsuhjXWA
	0zKyih1hW6lunZQz5ZFwRB4K22672tRZO1hLaj+oFyRE1EC5GxbP8au5qKNI1JPHEioT7Wt4evc
	S5aFFRoWX32Z2qLC2eFmI4TkLrE/bWx2u5uh55VQaB0R4cQztZHl0JDNAaQ==
X-Received: by 2002:a05:6000:184f:b0:43d:78ae:b785 with SMTP id ffacd0b85a97d-45ea37bdeaemr4397701f8f.21.1779371649272;
        Thu, 21 May 2026 06:54:09 -0700 (PDT)
X-Received: by 2002:a05:6000:184f:b0:43d:78ae:b785 with SMTP id ffacd0b85a97d-45ea37bdeaemr4397644f8f.21.1779371648776;
        Thu, 21 May 2026 06:54:08 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa9358d0sm2825864f8f.26.2026.05.21.06.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 06:54:08 -0700 (PDT)
Message-ID: <545dd8a4-662b-49de-a5cf-793d20989571@redhat.com>
Date: Thu, 21 May 2026 15:54:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 1/2] net: hibmcge: disable Relaxed Ordering to fix
 RX packet corruption
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
 shiyongbang@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260518144253.1568118-1-shaojijie@huawei.com>
 <20260518144253.1568118-2-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260518144253.1568118-2-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290475-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: C442E5A7518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 4:42 PM, Jijie Shao wrote:
> When SMMU is disabled, the hibmcge driver may receive corrupted packets.
> The hardware writes packet data and descriptors to the same page, but
> with Relaxed Ordering enabled, PCI write transactions may not be
> strictly ordered. This can cause the driver to observe a valid
> descriptor before the corresponding packet data is fully written.
> 
> Fix this by clearing PCI_EXP_DEVCTL_RELAX_EN in the PCI bridge control
> register to ensure strict write ordering between packet data and
> descriptors.
> 
> Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> index 068da2fd1fea..319551caf047 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> @@ -420,6 +420,8 @@ static int hbg_pci_init(struct pci_dev *pdev)
>  		return -ENOMEM;
>  
>  	pci_set_master(pdev);
> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
> +				   PCI_EXP_DEVCTL_RELAX_EN);

Sashiko noted this will not survive a device reset - that performs
pci_restore_state - and you should likelly call pci_save_state(pdev)
afterwards.

/P


