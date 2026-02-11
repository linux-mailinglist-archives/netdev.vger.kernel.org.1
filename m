Return-Path: <netdev+bounces-258225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAk1IaBHjGkHkgAAu9opvQ
	(envelope-from <netdev+bounces-258225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:10:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C37122912
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4AA4300AECF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80F7354ADD;
	Wed, 11 Feb 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO6S3d4V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7zpdHyL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770A3A8F7
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801053; cv=none; b=IT3Mppt1/R9NVNvpCXdP7+SURJKAsu0nSatBQ9FByaQDKO7kuOxqxqRz+/VRUqnz+tTUCyIy8HiqORgwf8HgfvtyTVWqDAIuaoHyXLnk0Chmp7gfTIuAsMs04GNJx4t3SKm1stKOWv6mxpnSGlpuiCgQfoxSh6FCAelQJor+rK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801053; c=relaxed/simple;
	bh=KacShDOWNOlO5H/VRA3buaVoCqG7ZDsYgx4xGNdyX8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWG7fD0rjOTGvc62fyN9WbO1gkrqcwM9sp5kAO1WXX3qJjdQpC4px6AX8q88MuXFL9iYjj/+9FDwkLkvq7a6zl+e5Ps5g1Oww9jaUlerqPXBcbBpy+0Ktcv6kICsBmJDDsm6fU5iZrTgUiLe39iaLIPqJsV4C8BBeUG/MUa/6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZO6S3d4V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7zpdHyL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770801051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4wey9chVGopV4Q+iboK1zGvtP+HzRe8m12rmTHLNaI=;
	b=ZO6S3d4VXAM/ve5QYaBhv1XLcnpWkNJNj53+I+CQet9oJKV9pWVSTT/ODP+ccjeg0UsA+h
	ZzsqoRUJqR4RbRqvOzTiMabU/Wv2sQMNb8UT2P3+KU3rQkbYRTs+bm19K2UY5RTG5DShT+
	G1EQI49eb6pJDvs0xg+BBsNyXnnKGMg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-BxK0Q3oCOye_Hplyzccqhg-1; Wed, 11 Feb 2026 04:10:50 -0500
X-MC-Unique: BxK0Q3oCOye_Hplyzccqhg-1
X-Mimecast-MFC-AGG-ID: BxK0Q3oCOye_Hplyzccqhg_1770801049
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4362197d1easo1376965f8f.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770801049; x=1771405849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4wey9chVGopV4Q+iboK1zGvtP+HzRe8m12rmTHLNaI=;
        b=I7zpdHyLB1ttY6xQNXvkTw+5i9XTYhhAtvFxbTtTSfGaSku9hFzLA3VwG6Zakcw0E8
         13HpcNnTSIG9+F2lSaXRTMj7KixEMDQwg3Mc9sTz/aNS+zVAOEmmggh6Q8N0wh8m16Ig
         3H+FTUACCXeukH5U8bxcpRp8g02uS13qKwCm3xmj5KQEN+STjRdH3Way7b/c/Hb6ERFo
         6wenZecQPjEGobsWEGKVN3Nq8MzJjVcUB2R94CqwO/bSbKnxa480ejOWkE9mwjXwIfPZ
         Bc7/QzFrxK+KCxLrbxFyp1UeZ7gmmk2Dw6trFbah2T9NrKUDZbFCsOEsG2hjMN+OM9xO
         oAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770801049; x=1771405849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4wey9chVGopV4Q+iboK1zGvtP+HzRe8m12rmTHLNaI=;
        b=lHpsarpFWLfYFNif8JL+n8l/4zLwVhAM8FeVq7jtcB7wuxAvXRvsE648h4PbpxAoLB
         dIHmPJZQjSXrBeLheS3o45Gv9hnZQoxVL+FKMiuCSOaZtG3ghJwKiN0zSV7t1QXzV+TQ
         nYuCg5IJHqX+ssrydYFcCfAFZvixoHd33815fnrmPhZyu86Tm6pa/oKDGd2LIMWiPaz3
         8dXV5/G8Z2+pFNR88JuoPPLOhUO2Ued1YfCUjGY7BXhSJ+RsX3N3iluq1ula+hMnOMLW
         4s2FAKyBrjCqbSkfF954weo2pFdlOr4Wh/TuvfUNibPKRftQeDWPTC0YS+mSIhvyGwJy
         6zrA==
X-Gm-Message-State: AOJu0YzmEkNfMa6JQISdGmYzfAWJ+qpD9DMENf7lKnQD1S3eoNQ93suA
	2TTw3QemL56b+BR1qYhRHtJt9JCbcgW2z4Zh3WUzrEqKe8NiOt/aCXXYqx/skOmqZjlo+ayZb3v
	0jUCtWDiNHlpNg6vBSUfat/ZENvvk/560PCEGncejIyCV0PCqzMjZ/SaqfQ==
X-Gm-Gg: AZuq6aJmJI8rxC1AvtkQkBe3X6yE22mYcTdCF9HF9VGoaAqfiAiv062ZTSPA6U+APBy
	kx7bav1hRG9L2a2JSF66UzwVNiafFpdyKnm02xgjugctujMY8iuIUcK+r6Je7jl0qmrZA/ZfKDZ
	nKFf3hIvVbPxpEUb0vxstltNQXBkCZo1xE8E8vi148I4UU6OUt/KY9zzLhnPEnjhKmyb1RdkING
	vcb8omuzpUY9XDLc7AHrXK0O3CEg5PSYRDAn+y2/bBlyVtdV6EYzP/f55xwY07j3x92//Q9mtis
	HgG5KJHP/ctKSwEUMjt7VpkXaMBNot7SNfjkIaLS+WPJmYXO2Kf/h02PyKRThbq2JeQgD5DSjEJ
	pqpRdhJuUI9m7B4dRHsZW3Ll/Qw==
X-Received: by 2002:a05:6000:2890:b0:437:6b73:ffa9 with SMTP id ffacd0b85a97d-4376b74046amr18910056f8f.5.1770801048705;
        Wed, 11 Feb 2026 01:10:48 -0800 (PST)
X-Received: by 2002:a05:6000:2890:b0:437:6b73:ffa9 with SMTP id ffacd0b85a97d-4376b74046amr18910004f8f.5.1770801048244;
        Wed, 11 Feb 2026 01:10:48 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfda66sm3414895f8f.22.2026.02.11.01.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:10:47 -0800 (PST)
Message-ID: <76522b83-682b-4cba-bdb4-d4a922a49973@redhat.com>
Date: Wed, 11 Feb 2026 10:10:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_emac: remove member
 phy_id from struct emac_platform_data
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-omap@vger.kernel.org
References: <5bc19909-0fc7-485c-a573-4819eeea5b5d@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5bc19909-0fc7-485c-a573-4819eeea5b5d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258225-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org,google.com,davemloft.net,lunn.ch,kernel.org,ti.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9C37122912
X-Rspamd-Action: no action



On 2/6/26 10:53 PM, Heiner Kallweit wrote:
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removed the
> last user of member phy_id. So let's remove phy_id.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 24 ++++++++++--------------
>  include/linux/davinci_emac.h           |  9 ---------
>  2 files changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index ed8116fb05e..df51441a2b8 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -329,7 +329,6 @@ struct emac_priv {
>  	u32 mac_hash2;
>  	u32 multicast_hash_cnt[EMAC_NUM_MULTICAST_BITS];
>  	u32 rx_addr_type;
> -	const char *phy_id;
>  	struct device_node *phy_node;
>  	spinlock_t lock;
>  	/*platform specific members*/
> @@ -1418,6 +1417,7 @@ static int emac_dev_open(struct net_device *ndev)
>  	struct emac_priv *priv = netdev_priv(ndev);
>  	struct phy_device *phydev = NULL;
>  	struct device *phy = NULL;
> +	const char *phy_id = NULL;
>  
>  	ret = pm_runtime_resume_and_get(&priv->pdev->dev);
>  	if (ret < 0) {
> @@ -1502,8 +1502,8 @@ static int emac_dev_open(struct net_device *ndev)
>  		}
>  	}
>  
> -	/* use the first phy on the bus if pdata did not give us a phy id */
> -	if (!phydev && !priv->phy_id) {
> +	/* use the first phy on the bus */
> +	if (!phydev) {

AFAICS emac_dev_open() is invoked also on resume, and priv->phy_id could
be not NULL at that point, the new code could lead to a different
behavior. I think it's worthy to at least mention it in the commit message.

/P


