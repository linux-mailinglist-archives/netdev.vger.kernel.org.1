Return-Path: <netdev+bounces-293623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G3XA4xMHWphYgkAu9opvQ
	(envelope-from <netdev+bounces-293623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6694261C26C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F9E3070F1E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F9B38D6B5;
	Mon,  1 Jun 2026 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyIYsDRd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF5fV+Wf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783D38D411
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304594; cv=none; b=u3ntDi7iTahrk5JaWFnbKe4uNFMX19gCACotgoCvIULN537bFUA4hwngeyL+2Jm6965eqCTvF8fSoP3QstYFsI3WEs2ViXAGfjgiqnHRLYlwG0tWrZAULUcybX4JlfZuHReg657VF4abHSh+GdfYsc/sKRNHwSC7jSAVR9MCcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304594; c=relaxed/simple;
	bh=iwdGIixbB7IOMHjvrCrRUD7du6GO/MdYTz5mqcpT0VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlvKa/GZlPA70jydoSeFdR4nHseZjCcft7gJr2+csx/CTyIh3el9nuQnn9mBT8rSqCl+v1fMh1prih64rgrpvVxfzp8vR08EZGhQr3kqcsyD0CHcPCQXF2KdMmo/d640TRsNfWPB1wPJ1MSCsK0e2w+0EBSiyiVey4JE3+UI/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyIYsDRd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GF5fV+Wf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780304592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjeavFCyvS+F4PVctKdom+5aTQFqQqXbjivYX79fNas=;
	b=gyIYsDRdGW3BpQzn+QdxdjNhfN+9IEWaU3mLzgi67mTWGDt73UZ7LNIkoBUDUY9JbOc2Ja
	MP5Kw6w3SQDHhjJuoPrGAtB3Zpksofu+fsFCZm8smuRTJUOWf77X7cbNDelFMfYBrCm2gt
	Cr6RTekuiYEJt4K2cxyvI1ZQEB6ojWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-A1geP1Y7MRyp9Uep7Q2Iww-1; Mon, 01 Jun 2026 05:03:09 -0400
X-MC-Unique: A1geP1Y7MRyp9Uep7Q2Iww-1
X-Mimecast-MFC-AGG-ID: A1geP1Y7MRyp9Uep7Q2Iww_1780304588
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae016853so1762805e9.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780304588; x=1780909388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjeavFCyvS+F4PVctKdom+5aTQFqQqXbjivYX79fNas=;
        b=GF5fV+WfyRo8YDhUkf9ux4GEwdtITpLk6oxuVC1HbQixjLBhTcRgogHsH5+/2CA+LZ
         UoPKBPy7DGqzN40VsP1L6fjOEup1zH8vGASn8lXwZlMhl/WvHI3Hy/AX+HrALp4+6a39
         eWTrh7eGk4bthVCC6SaHgI/JIaL1RNaQrKUILopFIkIYU4CPat4ebCxxPlLuq20cHikB
         hqRMO/PVleUVYEs/dv3xvDtfaVZ42kiLFRQ0bv/UUZoAF/2QVdQreziU+gjAaOkH5/Uf
         uWKvgZtkjkbn++ymxHiD53FXK46YHgvlJ87SNc0RTG+CxqZDkY8gjvP75qSn00gmy2IK
         ZQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780304588; x=1780909388;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjeavFCyvS+F4PVctKdom+5aTQFqQqXbjivYX79fNas=;
        b=n8sOrXxtqxdEkQz/noSpsqR7Olmi6Lqs5GUL4LodAMINtO14z1KTjMTAq8NzI//XnT
         O58T7C6VgiSJKr6/bxG3qG/nBtpJXl+7Gq6I9kQMkK8dPfnvW3qCi17auu5XmzZI19Ac
         kQc31IAfl7aUvZRly2lBtJTu2pH2jJBqh8F2GXLXChBw0k1XOi0jYTX09wS5YFRAvHH5
         +5FumQ0TpahPalCbzIn7E8qd5yFhboCv6+z5erjbqbERmpbJpEYGlTi1mX6OQDLd7sN7
         bllrWDw2mQSLehm4c3EtTiVdvfcTsSSfhA8nsAeSlW5m9y1bapQ4pdiXEJGBUN0bslvv
         G4QQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sp1DZ54HGFCe2bR1OCGFbwkiftxEXGv7s7K2dg0q9UFCm1rD/oG6h9qUl6MEWg/WiyUKwamo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6Ire279gH5RBZ6y566u+TtxobPFTWEWRSSDQcy1sfGJm3EyS
	+nv75w4naafNqK/MSCtClpk+AKWzPXagZgK481kghwsOvXHgeXVJH33ZLIa3MrLigt/3ocOiRO6
	RDIXw2ebVF+P3Q9bbUnYxiVcphSA2VwLWT0Jy8KPVeJbzzPmEiRA4w60FKQ==
X-Gm-Gg: Acq92OEcYvZMNH0s//uXKgfwbQ9sLGHVnjGDVRvq/vH7cUvpAItEmvp4FMod5CJonpI
	Ari7mHav+fe4XdB/dgZqIq3U/JmJyyAB1cPlNoZ++oNdct3/j1CRSFM4Rr1bzGfIcJK1sJX7kVr
	ZNqWi7t9/vphAhAKnn3zpigMkRaRSvBBXIQ9KZzvedxGJ36z9l3ZVRe/51iFMDhV2p8tX2jI8SE
	Fdy2rjfGx2jICPy3+7z8ukh93RfQF3a0UXVa6etrR+NR/BvtRs8WqkKkixV/5qiKSJkIugGcrlp
	mkze0k/durQQLbh+gbnZRsvTbdxAWtI1wozySakG52JeO8itWshTUHnsOIy5LfF3zE+1EIQlRIE
	0PPQ93bYT89nBulzCFFoAoOPMu06uO5ndUgLcNcLsVUPiV6IexskG3jBRsQqxcrlkZ88Z
X-Received: by 2002:a05:600d:8498:10b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-490a2915da1mr135982085e9.9.1780304588229;
        Mon, 01 Jun 2026 02:03:08 -0700 (PDT)
X-Received: by 2002:a05:600d:8498:10b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-490a2915da1mr135981535e9.9.1780304587780;
        Mon, 01 Jun 2026 02:03:07 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm261964345e9.15.2026.06.01.02.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 02:03:07 -0700 (PDT)
Message-ID: <ccd6cc44-1ade-4b29-9d7c-8e440de1651e@redhat.com>
Date: Mon, 1 Jun 2026 11:03:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/9] net: dsa: microchip: implement port_hsr_join
 for KSZ9477 only
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-7-5b63e732149a@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526-clean-ksz-3rd-v1-7-5b63e732149a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6694261C26C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
> @@ -1744,12 +1784,20 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
>  	/* Setup HW supported features for lan HSR ports */
>  	user = dsa_to_port(ds, port)->user;
>  	user->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
> +
> +	dev->hsr_dev = hsr;
> +	dev->hsr_ports |= BIT(port);
> +
> +	return 0;
>  }
>  
> -void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
> +static int ksz9477_hsr_leave(struct dsa_switch *ds, int port,
> +			     struct net_device *hsr)
>  {
>  	struct ksz_device *dev = ds->priv;
>  
> +	WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);

Since the new op is used only by the relevant switch version, I think
you could/should remove the above warning.

/P


