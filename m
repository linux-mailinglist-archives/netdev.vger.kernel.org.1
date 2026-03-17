Return-Path: <netdev+bounces-268592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J6QIcNJuWnG/QEAu9opvQ
	(envelope-from <netdev+bounces-268592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:32:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3088D2A9EB8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85689302052A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2123C1996;
	Tue, 17 Mar 2026 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te8jkm00";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Adrdg2Xt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206BC3C0605
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750721; cv=none; b=DLp7LMyOvR4JEwzkO6Tm7RGIXzilALHX+UQY51qLDMqj8rXlLDe/YukaZQ50Ug/AYmj6FsZa36T8rKf0wL2RzJ+lIFq0Lt1BWPFg5eTU1R5FICelxmVoAWiceLwZ3a9h6PKlheJVffr6HJYwHg7ejFlHcWtCMpsCmO/DV1QviYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750721; c=relaxed/simple;
	bh=1jQ0Io1F3tQLKlbPYrvOiyY2JRwu/1WgFSk5RLQLW9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFyjgaAO2zOZYbQU+SASWK7HRCPAOQs5absZ4bp1/eQAREY2ukK33URgnpbrzR9aq3iJkpnQRbK0PhriW0hdyF+GsD2VaiPXHX0MZWPHBYIR4LSVApDG3O4udWX39FkImHtSffQ+UfFjebEAt4UF2GOsmNkoeilPWtD0qHGJfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te8jkm00; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Adrdg2Xt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773750719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iZiUbcHQjwJ43FxZPCYpG6wLuTswJ/Obh68aZ9hETE=;
	b=Te8jkm00TnPyEpXJVNEg0KxUxzHQIbEsonlq4p807udN0dclgVBXpacCW3bsBrY8l61BPG
	OBTgUrG411ngaBHigzGMMI/dZQXUw7PJk3jymg8B2rhdFr0zJg/H0ROdWLy7RuIS8jLjNo
	80Y9s6QN4Ia4qlGxmXP8oCroQFZayoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-BKNmDcjzNB6dG9tDFI8GAQ-1; Tue, 17 Mar 2026 08:31:57 -0400
X-MC-Unique: BKNmDcjzNB6dG9tDFI8GAQ-1
X-Mimecast-MFC-AGG-ID: BKNmDcjzNB6dG9tDFI8GAQ_1773750716
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439a9182148so3879697f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773750716; x=1774355516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iZiUbcHQjwJ43FxZPCYpG6wLuTswJ/Obh68aZ9hETE=;
        b=Adrdg2Xt/M212XjH+j/vIQnluu0qezxPVvwt24uFZxVbz/ELT3KdZDsBqKK6EgJqGT
         6e+ws63SinWIRzbp1tB424g0Pdn+ToHsE08wsPoEFg99q7e/LuZADMzOaO+CRmfrtrZx
         BB0tzbCyACOQ2unq7VmF+66rUF53mGCVGnVEscexeJhLnBWCVh9mXq6OCK1Fk8Pp9V5B
         STAYnF8gUafCW8m5F5XuGAuBkzaj/cv5ywlW6orOXd9cNIQlcRfReXrCIuFeuaChg7yx
         /ZT7djXczXVcj0P5XqDFWGnoKjHGUuguzfJG7uGzwITjMv6I7io04VFUmSkJPMJqcyoo
         2Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773750716; x=1774355516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iZiUbcHQjwJ43FxZPCYpG6wLuTswJ/Obh68aZ9hETE=;
        b=KcE9WExESFXo7XoURv/jWY3OEmeO/31PGy7p+qMZoKfIUtzMM3Si0cSAKFViLehW17
         yLyYEVLtdcT00Y9xd8YTXMpnXvLXmzcxDXKu+FzBq4an1A/q9hFZ3kZh0uUAYrWRKQBi
         sUQXhm9TlOUj31q7YPNx6XH80lhRDwKquizDoHBsLPYCMLrRBNaza++CTAO0VqhwKFDq
         XTv6S5Bdt+tlXxrS5zWOPawHDLhk6aIjtFKZp10mDQL2HR51HYIAUMQm//oTkrpIQDWj
         j5Ijo29OcO1vqaBfrhEVYEPLbkkfYe1KvMVhYbWADiD2yfz/TpKKMRUd3pa7uy1TP1FT
         3U4A==
X-Forwarded-Encrypted: i=1; AJvYcCWlIuFllfuTZaHApTUNY1tGqf11rdkKLxO04CKr367lT5J2iIGarWHMi7qnQQQsJgBXCUrO7Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUAIXxplIZjDvFO7E4qWGLGACSMqLOI3eeyF25TZWskEfom/hy
	JfLueBoZI5c3/3e66yzi4syZo0y4I2fPLAtIiPsjGJbUuH/n7Gjuc+6nD4GUzmmjD7NkliY1z+h
	qx+B+8UwXDmzULCqibfh5JE84MMP5PGg0eTewvIzYQ0Ot3836EEZ7Tb8Y+w==
X-Gm-Gg: ATEYQzyaf56UE6zuEKalDsfrLT4KILRNlE22E2//cSS4HsCa17avz2Xgio5X0KiGu8t
	BgAm2JV3bLMqTELS1klUcHp783IGzTJNlpkrPwlxmK3qfgDg9AssGI3qshdSPB4lU7CCBciZ571
	86Qnt27rRfFr8/k1B2ArBcdaUgmDCvnv/Y1maPMTu/6w+1CuMgwNgGTid4dlsTulZHQCAkjHxbQ
	7y2eKa53D1rsYDXUZOW4nghk1guzwCkBnkyuCR8tl8rW08UJM8ZxDfLr8jnaX4796tk+d/0No15
	cIKkwA9gQUYz9b4TPW+P6pV1vDvbAv+qf5oD8jAeDMRH4Ja5XFZ3J4JqsR6AO158Pju2uJ4SBIR
	H+mjpfMdvSPCihIYCvDq1aIZJxHdzI7MCq6r7CASVUqitLMARHwIaDdw=
X-Received: by 2002:a05:6000:2882:b0:439:b636:1fa4 with SMTP id ffacd0b85a97d-43a04dcbd70mr30275000f8f.48.1773750716434;
        Tue, 17 Mar 2026 05:31:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2882:b0:439:b636:1fa4 with SMTP id ffacd0b85a97d-43a04dcbd70mr30274922f8f.48.1773750715932;
        Tue, 17 Mar 2026 05:31:55 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bd9csm50468510f8f.21.2026.03.17.05.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 05:31:55 -0700 (PDT)
Message-ID: <78cc0556-7986-49dc-b7df-0a0d789a3fc0@redhat.com>
Date: Tue, 17 Mar 2026 13:31:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] Initial support for PIC64-HPSC/HX
 Ethernet endpoint
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <DH4DU4Z4X9MM.398FQ3BIZQIJB@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <DH4DU4Z4X9MM.398FQ3BIZQIJB@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268592-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3088D2A9EB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 6:28 PM, Théo Lebrun wrote:
> On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
>> Hello,
>>
>> This series add basic support for Microchip "PIC64-HPSC" and "PIC64HX"
>> Ethernet endpoint. Both SoCs contain 4 GEM IP with support for
>> MII/RGMII/SGMII/USXGMII at rates of 10M to 10G. Only RGMII and SGMII at a
>> rate of 1G is tested for now. Each GEM IP has 8 priority queues and the
>> revision register reads 0x220c010e.
> 
> Do you have plans to test higher rate? We might get our hands on GEMs
> that support >1G and would like to know if CCing you would make sense.
> 
>> One particularity of this instantiation of GEM is that the MDIO controller
>> within the GEM IP is disconnected from any physical pin and the SoC rely on
>> another standalone MDIO controller.
> 
> Ah, that means you instantiate the MDIO bus for no good reason.
> Code looks like:
> 
> static int macb_mii_init(struct macb *bp)
> {
> 	struct device_node *mdio_np, *np = bp->pdev->dev.of_node;
> 	int err = -ENXIO;
> 
> 	/* With fixed-link, we don't need to register the MDIO bus,
> 	 * except if we have a child named "mdio" in the device tree.
> 	 * In that case, some devices may be attached to the MACB's MDIO bus.
> 	 */
> 	mdio_np = of_get_child_by_name(np, "mdio");
> 	if (!mdio_np && of_phy_is_fixed_link(np))
> 		return macb_mii_probe(bp->dev);
> 
> 	// ... probe MDIO bus ...
> }
> 
> So to *not* get the bus we need to be in fixed link config. Do you care
> about that? I think that the proper fix would be to lazy probe the MDIO
> bus until a PHY (ours or some other MAC's) asks for it.

I think that even this one could be a follow-up patch.

Thanks,

Paolo


