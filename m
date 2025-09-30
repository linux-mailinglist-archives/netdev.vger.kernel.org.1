Return-Path: <netdev+bounces-227321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D52BAC609
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053E4167B48
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70DE2F7AB1;
	Tue, 30 Sep 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv2wVNJN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230752F5337
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226235; cv=none; b=OsJt9K0yfo3BbPnqzdAs1PbeyCjFkv4tHUQns7C6xAJAUD9M+ufq+L8TDIi/ASBs/Uapvbll/5uuP00EZg/x7m0ArNU6MUb+0oT5eLnRP9jbOmReyENmFiPh7p4WHh4rIL2gJeYTJMgteqAnTaqWVXqmBvx8HaSYpktfOlvPYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226235; c=relaxed/simple;
	bh=Iby0dCV1k5FoMaSlf23PqKFSrLsu46FnHbptNvkg3QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um6oEgGwdwPrHaujCoicZKdzXfvDugPr2SzHANbQbmjId33hDn+4BCnTWMZ72szI6pg5eIngj3U6Ot3YePvLFsZzDDpDCTRA9uUoIH3n6QylGN+ErGt4EszmL/QN006Rd6DlYyUOEXfU4AsWokGT6hUjn/L9GsUnMYDkh5NKKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vv2wVNJN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759226233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srAu9efQeLkOrSNZBhuxJ9qVZjhUw1Qf2FT+xE0jzg8=;
	b=Vv2wVNJN973bhc28s50aMJBdMfeCsCLRnJ0VMRKZLV+l99P6q0f0xf/SXy3O9a8O6nA6mS
	Ttms9zIgj9wuW44h6fCPc1aiG9Ph1eUunQOAfSADUd2b/w8HBUcYHdcbJmrkF7dvDmPxqK
	8p9AcjSC5FeXbgtrHmzeWcnkDSUdmJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Lx18fENoPeygAxhOQiF-DA-1; Tue, 30 Sep 2025 05:57:11 -0400
X-MC-Unique: Lx18fENoPeygAxhOQiF-DA-1
X-Mimecast-MFC-AGG-ID: Lx18fENoPeygAxhOQiF-DA_1759226230
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-401dbafbcfaso3911441f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 02:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226229; x=1759831029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srAu9efQeLkOrSNZBhuxJ9qVZjhUw1Qf2FT+xE0jzg8=;
        b=YRITRvinMhSqAtT3yv9Gy+JZVxdpZZUVSMlpWKfGLypEiqEZdIqOIX8LYKTsZWM6Gl
         mYdQqL7/Vh2msdH6RnAvBJi40sbihlYIMOee68Nhrn2ks5tFfQuaA9RP/tfHwL8Lqh7E
         PkkFU1H1Ipp9dXkpPb7hd8WFE02jyzxj1IktuAj4QEs+Hb8Yru4bI0LyXUDc15saO7SM
         Pt0xpci8g/45kwWgjXgbvtfwSX9db9VLaJp+nAxOZhVNkwn8aEkMwYsjS5dcVEdKN/WI
         Bu8mp2QbchaGE5xfdgefqaOOwM1c9C/qKxR4RtBIrK4or6qwG6NOdy8ta1O6kvDtV/+1
         TxKA==
X-Forwarded-Encrypted: i=1; AJvYcCWPFkbW6nm5RSGeiqWPINyouCbuvXk2W1qbZRV/y6vrR1NCnFR8Npg7Yd38ZrxxHZNrP3ykThk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLavue1EpXngLFTypPkkbtus1FQWv19kQPImCWA3NxPR6kpgqr
	pl4/CS1knTkUSpbCEGEHp5/wwhAXZcPYxoHrPgJfY+fsEFqOXjZui2DdLXxu7HFlpvTjEn/9y4z
	g8kDmDijyO6Bpy0OTdbZa+hYY5hWppTYWjlllbJnwD89YuXodnGUPfhvH+g==
X-Gm-Gg: ASbGncuJEHZ3QeJ25FE+6MDEbO425FOSmoiLmDiAIZvJda+BeJ5eMeVigPlDuJfww66
	+rrbnBHRJ5zZo5VyVDTZcYLAHY0sX6b6biMRmYBL5jicRjayT+wcFBnc9joBzyalLQ+ggOvho+z
	cEdgIgQkFCIeeLsykcqu0EbpGIVjj4Q19CSOHnf4THBlYWH36wOJ18hqwUjm55wEkkdqSBs1vX4
	vdPOpPxZhLBUAyyeab9Rv9N9S0STCny+FiQJSW1K6NapHVXulIZCdZ/TrplmJkcA10pgKbr61wI
	uig1hfELiCXgCA3ARSsrqP04UzbBLVigftv6NrNYgFBpwjqW9PF8+JVD4z+7o2TJBRlfXjVlSIE
	tMSggOwNsx+gJ6xKaHQ==
X-Received: by 2002:adf:eb8f:0:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-41358755409mr11327877f8f.22.1759226229579;
        Tue, 30 Sep 2025 02:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRvdEuxPGd1K1hL6v0AssJUCVO28oQVmR6eHnpL1I8WvLYCEWr5PTILGebhv46wh47Za/SKg==
X-Received: by 2002:adf:eb8f:0:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-41358755409mr11327863f8f.22.1759226229159;
        Tue, 30 Sep 2025 02:57:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm21856303f8f.18.2025.09.30.02.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:57:08 -0700 (PDT)
Message-ID: <65e53548-2d68-464a-87bd-909f360cdb1c@redhat.com>
Date: Tue, 30 Sep 2025 11:57:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wan: hd64572: validate RX length before skb
 allocation and copy
To: Guangshuo Li <lgs201920130244@gmail.com>, Krzysztof Halasa
 <khc@pm.waw.pl>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250926104941.1990062-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250926104941.1990062-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/25 12:49 PM, Guangshuo Li wrote:
> The driver trusts the RX descriptor length and uses it directly for
> dev_alloc_skb(), memcpy_fromio(), and skb_put() without any bounds
> checking. If the descriptor gets corrupted or otherwise contains an
> invalid value, 

Why/how? Is the H/W known to corrupt the descriptors? If so please point
that out in the commit message.
Otherwise, if this is intended to protect vs generic memory corruption
inside the kernel caused by S/W bug, please look for such corruption
root cause instead.

Thanks,

Paolo


