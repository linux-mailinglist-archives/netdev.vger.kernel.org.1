Return-Path: <netdev+bounces-270928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CjhCeBHwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:14:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F663046AE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 159E4300B18D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D12358388;
	Tue, 24 Mar 2026 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbjwEFuV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tLRjGBKs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A730AD10
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340027; cv=none; b=H/9JSTc6gUaImHpKAYnr3jCI2Nv+eYz61reP8Ig3XXq3Iryd09yKCjgbRySOAI/bmN6z3Hch6joObLMuW92UgbQv3Bks9yy3Zpd3gSBlXhHjda77+nnvv0M0zf0Xq4XAitCxXgTrSFxIE60MV8NtWj0falYoO5CHpBR4AHQEpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340027; c=relaxed/simple;
	bh=iNaf9eBN6ctYm3Zb4iv7+Xg3CD88VXO0Qx3TRMXdTrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yl5Up+DwbqPfiUxFDWt4vGnjdkYqd8kbYA2WGZF/OrMRF3fn/fAG23+mkr86T5dMx/skLMnSNxKWqtxfFmxWoX4bw+u196t+MB+AQdG33w37q+iM0Z/B14596Fy0lm6Lvke4PuYkg/g1d/fPz+r/GAkdOHpkW8aPU1XQuIO5O70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbjwEFuV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tLRjGBKs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774340018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts8QTgurhQrOhcbvZk0taNObr5EoxTyEYtshId05lwo=;
	b=KbjwEFuVqe+3MSvIDCuLMhDqswHy2DIsgTubivBIaRVDEBaUQAmMjkFXdGpnS69UpKF3Ba
	MVynQPG82zle71D8Safc6Qg9HZnn48J89Hut2VQBs8nHCWRI3kqj0CkESEJRkDIHHtQ2mr
	I7G47z7wCmeJJvWK9Ec+vAqUpyIIWvo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-r9LTeSeMPkqHP4_jRpDajA-1; Tue, 24 Mar 2026 04:13:37 -0400
X-MC-Unique: r9LTeSeMPkqHP4_jRpDajA-1
X-Mimecast-MFC-AGG-ID: r9LTeSeMPkqHP4_jRpDajA_1774340016
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b53023d60so3369760f8f.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774340016; x=1774944816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ts8QTgurhQrOhcbvZk0taNObr5EoxTyEYtshId05lwo=;
        b=tLRjGBKsWx2v3MkqFof6mhkeG72MBCIalqseUCWx+26IeUgmwOx483p21Vv7uTmGPk
         8Dn6GtmSnjS4K9yS0XgDPU1ezNssjfT3HKMI68OCBHuVEhWi8YgHraQXnBWz2LVpE2RR
         6MvG7IUHSxFglOcL1y9spYDIp8oDSS2ndlG9sCJPzmeFDbOyE1tNSb2HIhLrq6p1BGjL
         f8FrPrFsYXFc8Iv6Ykc/27hS5nC46VG9w1IFBiUfewv/i1qpIoqtmqY8YpLfGUIT8d9I
         1edNVHIpev48Um5iBxRsQ9b7Z5sZW51jfufsAVmS5U4zqndPB4iPUgOm8KqqkEZA5Yy4
         CtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774340016; x=1774944816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts8QTgurhQrOhcbvZk0taNObr5EoxTyEYtshId05lwo=;
        b=K/oN9gzNB9mY4sIrOZU8Ja6G55/z6xTZgW562aDzQLLFhkfia2LAkGtWR8OBRsH9pA
         pQr9Tt9Hv0lXiysq0cFmRHWGmqzh0w9c9q8ph174MA7xCJx570uE6SZGkWOeY72b6A5+
         MD5e5KC1i3FjcVl6RbQ7gw5GzoPDm7KeOKTBipQ1j0SX2dLcMSLlDINhHNEZHtEaG4nw
         s3zqz6Md1Fh6Ys9ilECZyHeBkVP1IyJtBE8f3Elmabs4wtjcd0s4iH6l0wRlNzIChdQ8
         gPDivPBbfFhXr3CEnf07DzZklzRjd8eljK3AOsikAhwJ/v0s6GC3hDNFGTPv5k1p52RC
         94IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1MzmCdHvNfNblJa66KJC/whcLI8GFW65c6rMvzCkOTeMZhsbwCV5oCRmpAOIH3EMCbmjhTOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfpu8i7nL/KDZueIiYou3UGqy4KjsPHLny3iKU6g0KN3wLicw
	0MD/GIm8CfYtwhQqtSZ347l++izPeWWdT/Xf/jE/3cyJsxwCKFCYjgMm85EIvo3TRJ5fPyN1r0F
	YhRSlrKSQzoRldy5OPBpg05+BAGu7lbkngCR1FP8tqolTSdpALS5sLZ5QqA==
X-Gm-Gg: ATEYQzzoqH4a/jisG5+YD8oHfuLznsPI7sI4tabNazaSE515WoFsWCzbI3NgIopppnr
	nrPeP2zNsWe103mfi629n0XuRBPeYhE+4eiK58acXmOtQfi3RqoI96HJZnrcxqvtSQWBDORkerO
	azfBWjwNkkGugH8n8Al5D/LnuX/ZmTlpzyjR5zE3msRrhN8shly4Veof5cvObP9wlHdqVS2HYvO
	HNHe28/ls0vhEflIcdHK0ZaOXMlE4Y53/OsjSHZY+tLA55jK8p9HKQDCHCVnon4l1h4T0HkIFCm
	x9Dyrz5ouTIcvpO3hZ+U+9mXQLlRgNdogWvfOZintVUOddYvulnWEthFobhkB2AApRnLYRaSUNe
	X1p9QTGqQQ0lccQmwJnuW37eGR9nCTMoe9CfGvge8mx7x5tMvmPCQwkkF
X-Received: by 2002:a05:6000:4382:b0:43b:3e40:222d with SMTP id ffacd0b85a97d-43b64244451mr22895143f8f.19.1774340015831;
        Tue, 24 Mar 2026 01:13:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4382:b0:43b:3e40:222d with SMTP id ffacd0b85a97d-43b64244451mr22895104f8f.19.1774340015382;
        Tue, 24 Mar 2026 01:13:35 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae048sm35875560f8f.1.2026.03.24.01.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 01:13:34 -0700 (PDT)
Message-ID: <c4e3c49e-ecc0-4702-9d2c-88ff420c4647@redhat.com>
Date: Tue, 24 Mar 2026 09:13:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 11/14] net: dsa: netc: add phylink MAC
 operations
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, frank.li@nxp.com, chleroy@kernel.org,
 horms@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, Wei Fang <wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
 <20260323060752.1157031-12-wei.fang@nxp.com>
 <acEIQqI-_oyCym8O@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <acEIQqI-_oyCym8O@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-270928-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4F663046AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 10:30 AM, Russell King (Oracle) wrote:
> On Mon, Mar 23, 2026 at 02:07:49PM +0800, Wei Fang wrote:
>> +static void netc_port_set_mac_mode(struct netc_port *np,
>> +				   unsigned int mode,
>> +				   phy_interface_t phy_mode)
>> +{
>> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII | PM_IF_MODE_ENA;
>> +	u32 val = 0;
>> +
>> +	switch (phy_mode) {
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		val |= IFMODE_RGMII;
>> +		/* Enable auto-negotiation for the MAC if its
>> +		 * RGMII interface supports In-Band status.
>> +		 */
>> +		if (phylink_autoneg_inband(mode))
>> +			val |= PM_IF_MODE_ENA;
> 
> I would prefer newer drivers not to use phylink_autoneg_inband()
> anymore. Note that there is no need to support RGMII inband in the
> kernel (nor is there any proper support without a "phylink_pcs"
> being present to provide the inband status.)
Would you mind sharing a patch adding a comment nearby
phylink_autoneg_inband(), explaining the above for future memory?

Thanks,

Paolo


