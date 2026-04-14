Return-Path: <netdev+bounces-278448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM6YKBA83mn6pgkAu9opvQ
	(envelope-from <netdev+bounces-278448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:07:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCCA3FA505
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A215300F17E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13B3E5ECF;
	Tue, 14 Apr 2026 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeFgOJH2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lq5AZQ66"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352641F8723
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171886; cv=none; b=KhBZuWMkja26YgCKDsKufNU7AQFo3/Ccr3/IRPmiC2L0EvTYnrYqcYE8jKuu0juvReNE59H3Xwtk4nKvkwlE+881N34Me2pqy+W1b34vGtOeeif8eWb5khbyMYTQh25V132Lu1iQq+wdtYMGAsuM+HPRoGqKUavEyodtVWRxnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171886; c=relaxed/simple;
	bh=fgU/EJ8fhNjWG9tUrnCWQvq2hGfoS2SKtGyUgO1KF7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzWQ2VnAYHbl/dVX8bZ+T98m6mBO5zo3UoSQiCEW0zeMmg1d7sFL8H/J/tiaTCwDO7k4VnRGgvhlAEOXm1ASSMMLxnbWuVQ4duVLz7cFSBp+N00pO1oy9Qdf4eJAHQfV3gjO93KeTk82fVcZD9OlFGR8BiR2iFldv0ig946fI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeFgOJH2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lq5AZQ66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776171884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SB2FdFz1cnEJeeU7lmGtgbspb+2GXG652NxyTVE25c=;
	b=UeFgOJH2cHBsNxYcIPxoD5G70EDFerZkHk5SaCjQviGfBSfaPFxf21YGNM4Fv3KfOmR+NI
	SmN4fbBfXj94aFWPGS02IuPUJHodvO4MhkPVxncLrMhGiH46g3vg++OtU52O1AhJizhKU3
	wfQV6F78r5IhvgBdZ3EHQ+ofUbiugdg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Vd1SDyJcNEWVnSgZFREnJw-1; Tue, 14 Apr 2026 09:04:43 -0400
X-MC-Unique: Vd1SDyJcNEWVnSgZFREnJw-1
X-Mimecast-MFC-AGG-ID: Vd1SDyJcNEWVnSgZFREnJw_1776171882
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d705eaa64so2818768f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776171881; x=1776776681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SB2FdFz1cnEJeeU7lmGtgbspb+2GXG652NxyTVE25c=;
        b=Lq5AZQ66P+d/mMchyrqkp9+0oBZhrBlDw4kp2dCfRccm0IH/s3wHhrv8zflyRo+jIN
         oMponaP0GudRomxu5uQ28XDR76kOJ6ti2YFlVH29fbqsAWNb6lcLxQpPx3kNWrYDklCP
         brPeo8nyXz2mO23TH82HfQWxElE7Q55T6YRfG/tZLhUgbumuE4aTqRxk4rD3Dc4z/Adk
         FMilINgDYDS/JASE7gNmRAhCQhRYygFaQP4paj2+zqf6NlriTG9m249v9wLQK19XxexN
         RD2DGiqP0CLYOcm1l7OTm2YYPPc1LfXu6C/N5fJ62CxhOCfQYMzdhUg5QVQftu6rX7C6
         U6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171881; x=1776776681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SB2FdFz1cnEJeeU7lmGtgbspb+2GXG652NxyTVE25c=;
        b=h3lvw+nqOZ38+QkBANUecGJp8YfczZIr9qKF0vj6lBQY+o935G5gMl9vfsGbKcUG+A
         csLPEA3JKm30rPcCIp7kZ4mD6H0JBWrG/ssoEpDdxc44wixGpzIIKS7BoeBxWri/jVYD
         JzkxJw/e+4Rv5nXuKfJSKNFweAqZXTnxYThyxBRsJFnPYsfKO83gWjDui7JvlE4k3O8e
         7AdRJXJALoQkALWaD6IkrZ4SSeV8Px/b3pPHq7khCmp64UKZZU1oievqY+QBi2WwrTNW
         LTBbEMjdeUTFW2X7JsWCPtBJv5OPDnftYPFyUQk9UtPqECbnqAs1htIgR187ogX2NZoR
         j1wg==
X-Forwarded-Encrypted: i=1; AFNElJ9TxHgSjF3/bLRN8zBmbLz9eci3HO0uU9ItZ4KqPsIQMttun01g1aqbsg72XZ2bRCCraRdSuDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdE7iDV3tSoOcT4bXCrn8Q/hzEvFgefmCOoP+BNdLyn7v1GB+
	EN6do1fbAvktY5uLNsMqniUhO0SaD1xJAj+0cyDwlUGWkXajHH103Mr7cyrjQlxK1uYfHyALVOe
	y5cRxKhg67RVijiyDIv5gZuYN4eMre4beap7SVgXCfPsdTK6SKYDxuDxbIgPk6Rv73g==
X-Gm-Gg: AeBDieuL7OdEE4koVxAExBC37L0/+koOW4WfUAfFbWQ/eegdESIsaTpEcRxxAvUYldX
	TWkuVMANYxe/SQ4JzBuLUzBWQKOIXJiDwTlH3k3/n6QN/KoUtS9tQklyj4m1e70oHg+HbxyYEcw
	AMLOU3XZXs+aATCI9rvIjG5Q7fULkOPImnexHj0l55edGFbvgZ+IbW/hASm/NV3AfK0tCs/T9Jk
	LHjqQ9/idxxShmUJ7OnRzYQggH5JTaFtEMoU5HzSONoVa4nDRUBEoYTQJPPnx6xNuxxylP8huZe
	RFJeYoWugKZ5+GBAgwZOQwGcXXK65IwaxznH0bkaa+6tyqUCzUCdybyWUB785M93w8+zClRk/cz
	hWmuvSjnSNUjuPYvc2ofTdSmkQk7IDunJh7Fn/kSjee65lPxrmPNlZvCW
X-Received: by 2002:a05:6000:238a:b0:43d:7883:87c2 with SMTP id ffacd0b85a97d-43d788389b2mr11234917f8f.39.1776171874779;
        Tue, 14 Apr 2026 06:04:34 -0700 (PDT)
X-Received: by 2002:a05:600c:820a:b0:488:b675:360f with SMTP id 5b1f17b1804b1-488d6889a6bmr214737225e9.27.1776171861891;
        Tue, 14 Apr 2026 06:04:21 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b128dsm200877535e9.2.2026.04.14.06.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:04:20 -0700 (PDT)
Message-ID: <5767dffc-26e7-40da-8be9-46b878795a85@redhat.com>
Date: Tue, 14 Apr 2026 15:04:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: Fix max TX packet length configuration
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260412-airoha-fix-max-mtu-v1-1-333030d0a564@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260412-airoha-fix-max-mtu-v1-1-333030d0a564@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278448-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FCCA3FA505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/12/26 10:09 AM, Lorenzo Bianconi wrote:
> According to the Airoha documentation, REG_GDM_LEN_CFG() register does not
> include FCS length. Fix MTU configuration removing ETH_FCS_LEN from
> maximum TX packet length configuration.
> 
> Fixes: 54d989d58d2ac ("net: airoha: Move min/max packet len configuration in airoha_dev_open()")
> Fixes: 03b1b69f0662c ("net: airoha: Introduce airoha_dev_change_mtu callback")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index c14cdce588a7..a81ffda72b39 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1629,9 +1629,9 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
>  
>  static int airoha_dev_open(struct net_device *dev)
>  {
> -	int err, len = ETH_HLEN + dev->mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_port *port = netdev_priv(dev);
>  	struct airoha_qdma *qdma = port->qdma;
> +	int err, len = ETH_HLEN + dev->mtu;

Sashiko noted that the above may cause regressions, dropping max MTU
vlan frames.

/P


