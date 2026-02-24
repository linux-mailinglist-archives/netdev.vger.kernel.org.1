Return-Path: <netdev+bounces-260548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMpbLIuynWndRAQAu9opvQ
	(envelope-from <netdev+bounces-260548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:15:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D81883EF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CFCE3043D9E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD139E6FE;
	Tue, 24 Feb 2026 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzrdriR+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZvH4fX7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA022652D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942522; cv=none; b=Jc+tEnIYoXELZW0/QnSA26MfnFQbh8on0v9HbMVEssOp1yJK9mncRlQqs6eajKlWcfh033lDierOJKzQwADIX/VidoI5nuZBnmB71Vq25Lk4c3F3fpVwYCzYEwbrOb6BQe1lr1TSsQGqACSQK7NC081GzwY0g7S0HEfTzGCbFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942522; c=relaxed/simple;
	bh=e61+aXIgngAz3QnH3JCZeUm03SQk81VVw+SzieYNoWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFjb92TYzCqZPtwtEyPWahYytde8dKz5lDuerf3H/iCjTnw4IwkBgMa3GAAmjgQRoxLVzvOFWHCEgNXFGsFpx/w8v85p5YiP9Q1EWiyEFTFQwS47Az8M7hLb+GNFjWHwFQrRfP65hUkCVtUwfFZHpo6v/8/N0ZC2fwqtId+9OCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzrdriR+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZvH4fX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771942519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CydiyGSI3+wz+SOvxf4hH8gsih6DM4qWLoeGr5B6fto=;
	b=MzrdriR+nmQCMCrMmJF1m4WTXLaGlaXK5QI31lRs0d/q8m4joisdhXnBwO3WD8Rr0bCIiw
	XPBTetd+CHeICq4C+n10xhP7YJzLoT9R6yo7jGvUmq7NZ0uCwCq34Y5A+ocJSvjmBwwabO
	a+QrOX/u5HlcrcfdTt6SnhO3PTEgi3w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-w49y2fssP2CioFWLCdrNoQ-1; Tue, 24 Feb 2026 09:15:18 -0500
X-MC-Unique: w49y2fssP2CioFWLCdrNoQ-1
X-Mimecast-MFC-AGG-ID: w49y2fssP2CioFWLCdrNoQ_1771942517
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435db8ebc98so5410655f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771942517; x=1772547317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CydiyGSI3+wz+SOvxf4hH8gsih6DM4qWLoeGr5B6fto=;
        b=LZvH4fX7MMHCca6r/uRxLEIOiJojH1KZwBhIDvVxh4wZsSKbh1o3fy1TEMW72F3Ve4
         pxyxOrON54myIcfCmiBjTAVTJ+U+ZzsnW5TbOIH7fa9PSxpCLxPN/AsaiSfDiwTRK0Tc
         Ol4I6QGMZPwYHDndAbBVoumESY7VDIma7yN2TPJsVxoBS/HIxk8plXyRFxDZ5h3gts+y
         VgG8/RjkcJKCr6IugvQQoRWhOJG5CR5DHMulhrMT8AEy5N5lsiMdwu2nAkV/+JnAUsKT
         t1R0tv9s/J7t+G3tL3IijzHszFPoHFDmjm7jk/avgXzIfKz2xQ5BoGfkClAIqzl1AahI
         l4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771942517; x=1772547317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CydiyGSI3+wz+SOvxf4hH8gsih6DM4qWLoeGr5B6fto=;
        b=Xs+zRf28V6EEFsZKUOjpnX0ogXmerXXa0l2o4Uhhufp70MsjqdD9iq+ONRgL5CzvX6
         YkSgiYaUCKR57kIZfL5wABS+k1GgTeMc0Q8W6tFKDMhL5z6ViYdXOAI4droBUO/+B5z4
         bNEH7l22al/Km99dp8Z9D2pSK7YwJ5bXrMALFfzxIa/J55bQ9VzOW0aVUqUVeokR0gto
         uYkPY7KsJHd3Uu9S6dADYE5ytCHR19EiMc5uqK1FukjXhRhkLt8l1HfHVgwZFH6JcVEk
         f+MUniexADc2u9AOsi697/z0ZPd8eCinNCuFF+lvctbmmVLc3QXYO3KeVu+JNrCZci6X
         BogA==
X-Forwarded-Encrypted: i=1; AJvYcCUHYUaS11ATvbEqtLX23DurJe3rIfHINKGwHK4SidmVDyIcq6nSd6bUmAOlFZOd2Cyf5BXPciQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89uAdo7hB/j5rg1+Ae3ze1vctAwQxeEXH0j65wp1YWakJTPzZ
	CYFSBABCZ2NWEV+DcCDTg82u2FZjsKIL2aWXI59x7jP8+yOcl+OcPfYR1/YAII0wNzCc0qKwGA4
	xRgyok7yuE7L0Rt2QtSeYTI8D1ib8rTx9JAAh3pM8LHmZj/Zpc20HV0TCyg==
X-Gm-Gg: ATEYQzzeZYSh0x0F/ERuQ0Xx8icQuwhtZxq2dkt9fvyD6AzTeATUO/+LJttVYD5KlZr
	dyniP5cZIg7iiqA90GkUGZ8ZV7nuKLm1AUy5RW8ra8/uDIrN5pFiVzL4IYfCv91717egx3cDrxm
	1alh9LuXIA290pXotODfA1eJjvYsSwGVfA8Jp/R3rgFMmlTvQ2hj93XG9Y9JCdUHOYwHW4N5SeX
	4PZETX7ecz9j7+eHgR9llUPsnhNkxeDHUTdkueqqbuG/9uvb4XWsfkT2r25vW5pksGFZirEqeaX
	oXqB1+B8lzraXDc13tzDcEYJBTix42R8CzngqM9YkEDw6oW+Ka5EwhYFsQolylQ+hKXIBiRI7fq
	aDg3FWcBiua6+7LGHIL+p
X-Received: by 2002:a5d:5885:0:b0:436:b87:ce5c with SMTP id ffacd0b85a97d-4396f153bdfmr23759016f8f.20.1771942516620;
        Tue, 24 Feb 2026 06:15:16 -0800 (PST)
X-Received: by 2002:a5d:5885:0:b0:436:b87:ce5c with SMTP id ffacd0b85a97d-4396f153bdfmr23758958f8f.20.1771942516122;
        Tue, 24 Feb 2026 06:15:16 -0800 (PST)
Received: from [192.168.88.32] ([216.128.9.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d5463dsm25262649f8f.34.2026.02.24.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 06:15:15 -0800 (PST)
Message-ID: <62ceaf20-6bac-40f3-80aa-d6718b7bd742@redhat.com>
Date: Tue, 24 Feb 2026 15:15:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: cadence: macb: add ethtool nway_reset
 support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260223091454.44153-1-nb@tipi-net.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260223091454.44153-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260548-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: 827D81883EF
X-Rspamd-Action: no action

On 2/23/26 10:14 AM, Nicolai Buchwitz wrote:
> Wire phy_ethtool_nway_reset() as the .nway_reset ethtool operation,
> allowing userspace to restart PHY autonegotiation via 'ethtool -r'.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 43cd013bb70e..47fd85cd9613 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3945,6 +3945,7 @@ static const struct ethtool_ops gem_ethtool_ops = {
>  	.get_rxnfc			= gem_get_rxnfc,
>  	.set_rxnfc			= gem_set_rxnfc,
>  	.get_rx_ring_count		= gem_get_rx_ring_count,
> +	.nway_reset		= phy_ethtool_nway_reset,

Please use consistent indentation, i.e. align the '=' above.

Thanks,

Paolo


