Return-Path: <netdev+bounces-257219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHBmOr6thGk14QMAu9opvQ
	(envelope-from <netdev+bounces-257219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:48:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B18F43AA
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E87C30796F5
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97D40F8D1;
	Thu,  5 Feb 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="2vEPCYcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB975407593
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302694; cv=none; b=cZPKawkZoS1xkBppjdOY9Dga/VSxJRfpTwM8ZpAFVe6uvVhyLLWvJAX+WUvPG+gNeHoawXhEeySiTqLXyThhUAyI5qnuvTrHqFos2MPcgLNn1Gzim8KEIwUrqDlOdF0bMfzInfgk82zYUArylEN7jiR0mmW0GSwadIzkSiDDypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302694; c=relaxed/simple;
	bh=Ip8egWymmNIZRQpL/yLSLzyJGyXIDWQvB7EnInDwlQw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nJRRLXaa+hqraxf9Ah6jnlD1qAT/pcX0yUA8CvUjKJjEc7dTNJ7Q23m5VyFop9+j6SD0unXiRH0h0DrL0xAr4VNFXmE7ebjPNO3XrLSw2ZMGnirEKbPT9FZY7v4sK2kMZ0L442qCq+DaHkCgA5L61Y1yXkBtRACED5O9gMk1ooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=2vEPCYcK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso2059997a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770302692; x=1770907492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGuGV1Rjxy0b39caRNbzTsFTwfMEJia85m6jesueSeQ=;
        b=2vEPCYcK1Py+VhyJltVRdjpNoH0RgQmPypEbfBTnBITFsspwaG5RCzqwoUR1gCLGF5
         I+jqr7fcYUQP8KC74QnbKGD5d6FTHwyzYq29a1QZzVwHamlaW93gwxbwDnzXQmMhsE4c
         LUcp9HauZjUz9C/uvoBxIOVVh3L7MNIqNjLchouV5+7N1VxYiOB56GfMRXZpXlQSarDh
         FbGfzjx5ROLLd1smPaxH1eBontPSHsOLhOVNfe/IKnGdfUpfqp9OO9UQhBj3G3CDjxfU
         OC/D8q2sNS6Hbfbshydj+0w/jeWJZx3sT21qiyh1g1GphK+KCFww6lkdMPTbR/YlGvr6
         Y/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302692; x=1770907492;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGuGV1Rjxy0b39caRNbzTsFTwfMEJia85m6jesueSeQ=;
        b=I94xTMvPanI8VTheoWSeIKbhNvCunBVPMa8Xy8Hx7v0ievKEMcKIxuzLUSaIDPt1Vg
         Ij6QPm5+gfM9YAxxzQLneRU1OJuuHCXqaidtZPnU0Zt85PNgeMdo6d1Qz6NOkpftDTzy
         Ez9RLPbgqXJ8gdIX0tuPU+ZAqf2FXfvKxamzGzZKpTMhGl7HaAjvOedenAkuDtOUGzH9
         7zfduB6CTHyMEar2iHTvE+O1UT1I+Nq8mH8A2pXoyC+ugaTqqD46n6AGavMZuaxIRfVD
         GC0YYThFrDqfmOfKFQ5EwWx7uzrDlj5IERZdL7P3SBXf9ErewwWUPlbJQrC1L9TcZfKj
         JmQg==
X-Gm-Message-State: AOJu0YwmEW2OEB83q/HXRbRLm9ECxFPM5EDJWEJ6DZChF9H0RRLIdYpM
	egljt6ZvLEeAm50h0tfN5E3+nqww1nZgaVV9l/KQzuXdvcCSM16St3I47l1SePMrJ2A=
X-Gm-Gg: AZuq6aJHri0sgrURTMMe0oWj9RXcU6hnvtNRqF14L+KI6aGX2oGM67ROGxSoIU4vrGR
	KAVabSnpOm8/krUQOhGPu02I69OttjxyGknwWG/0F7H1utqRjl8jrNZpj98yaOJ+8AxLdYgG+fG
	2jzngXOvk2N8xGYpFA8SBCX+vRHahDTIMJlKr1mEg5Lz64GP1WFF/KhdzVYDDAN1MKpmt9iFFnE
	6hsUYt2N/kcfzEBIl5twNvbhO6plxLg8G0IhHtrx5dMKdSyyEsVVUe1Viz1M1AGoIG3g81sQ1v4
	xo3Yf4QhtlF2xkOPBvjO39w6sOwhPv0f3vgFucKOIglGytegWplQbuwvQH1tViRh/xIrkYMMxyC
	zJocgCg7LFzpEw8pYyLAZFpsMADSBahkxeGjaqheay98FiGgBIwKfF8lODA346l9R7L9WBiaZuz
	6NORLTYxG9xIZhKX3j/ubMxhfH967t0B4EwJmv
X-Received: by 2002:a17:907:928e:b0:b86:f194:9eec with SMTP id a640c23a62f3a-b8e9f063ademr467878766b.18.1770302691747;
        Thu, 05 Feb 2026 06:44:51 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::159a? ([2a02:810a:b98:a000::159a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea00455adsm236432166b.60.2026.02.05.06.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 06:44:51 -0800 (PST)
Message-ID: <5b8bcf37-5cd0-4c32-b0ba-3386142b7795@cogentembedded.com>
Date: Thu, 5 Feb 2026 15:44:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
 <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
 <d6a9356d-6fd4-459b-9c5a-2f3e20368bbd@cogentembedded.com>
 <TY4PR01MB142829D9748A483ECAF19FD3D8299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <25ff0841-545b-433a-8e88-6e463ea718e7@cogentembedded.com>
 <TYRPR01MB14284CB75C7DCD35381BD17EE8299A@TYRPR01MB14284.jpnprd01.prod.outlook.com>
 <237bee8b-a7cf-4c14-9946-8bf72dbddde5@cogentembedded.com>
 <TY4PR01MB142829EB0EDDE13B588F949298299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <a4cfeba2-23da-4fdd-870b-6533b5ce267c@cogentembedded.com>
Content-Language: en-US, ru-RU
In-Reply-To: <a4cfeba2-23da-4fdd-870b-6533b5ce267c@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[cogentembedded-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-257219-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.yoush@cogentembedded.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 47B18F43AA
X-Rspamd-Action: no action



WBR,
Nikita Yushchenko,
System Software Engineer @ Cogent Embedded

05.02.2026 15:41, Nikita Yushchenko wrote:
>>> The driver was originally designed to enable hardware forwarding when not less than two ports are in
>>> forwarding state. When only one port has hw forwarding, there is no destination to forward.
>>>
>>> Nikita
>>>
>>
>> The current driver allows Linux to use the bridge port as local port to the bridge. The offloading
>> Also supports switching traffic to Linux through the bridge port. Therefore, the offloading shouldn't
>> Be dropped if only one external port is up on the bridge.
> 
> "Offloading" means - forward a frame from one hw port to other hw port without inserting it into CPU 
> queue. Offloaded frame is never visible to software bridge.
> 
> There is code that allows offload only if the linux bridge device used to connect rswitch ports does not 
> have anything else.  If it has something else, offloading is disabled (because there is no way to know 
> when a frame can be processed within rswitch hw without sending it to cpu).

A frame being received by bridge device itself is not a subject for offload, ever.

