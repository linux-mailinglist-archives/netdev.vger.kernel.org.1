Return-Path: <netdev+bounces-245152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA388CC888A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C00A6302F908
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AE535FF5D;
	Wed, 17 Dec 2025 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7e8AreG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1A35FF5A
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977079; cv=none; b=VwL3SslW0wjPCV2koiUVNI9QT7eV5UhBbiFyPi3Stea1wp/kfF44ePpBmMMxAJF5Zws7oPqmv0lSi/s9cri2SQu9uraLA1faPzrsYoNpz8XNrmF+TFGsdXLL+47JX+M52tafUarxH++rNfTvUzcvnud3hSVi9eMyydCVoJtPU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977079; c=relaxed/simple;
	bh=Om1TnknF8svFxwcbl4KqUtDFwkHFW/Rz+8ty3MLobM0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FzrxXRB6ue9Y1iCQhQ3SFCLYyH2a/y/g1HYF6rpueLT9isV6Uma46WPGCqvby2m6JfkshkqMWYopCW+BdINnaZ1x6MBwXF1/jGHXYkApiki6LnK/eoTR3O0qa3h41kLgOY/chehpKiRZf5AJPAv8A8X9L7hSJDbtPbNMAc6iU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7e8AreG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc305914so3734833f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 05:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765977076; x=1766581876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Z4HSgH6g7AvwtCkEH+wMmW4znl93Jz3EGhls0Goj0M=;
        b=L7e8AreGtJc2dH2t39XXJenUCk3Iop8HIUMbw00TQT7A02YSjnr7pyPuYhlTdUEA5J
         S/sXnEm90OVTKPBPqH87asdqGxPDS5Bbg6FgSWoM1IjHIhBzdppLMYVfASxWigWvLxr1
         CVUMkSMyMv7cBRY0zmMWaIgenojCMNvQG7LJAzumpaEUCSt7YNW6yTUvuniF3gxxh3nE
         EfM54uInq1mJ4hYW12WJ16ZAYN28OXM0rx2Bh9yUrlF4ZIv1jyGkr0x1tQ0OH2Y6tiOZ
         NcMuTcM7erVh2aFFcpRMNmeUgdocOBHxXTqm5HN/VRO6118w6WHNVegdM95OLHNK+H3S
         aMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765977076; x=1766581876;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z4HSgH6g7AvwtCkEH+wMmW4znl93Jz3EGhls0Goj0M=;
        b=ovDOOH3NPIM2edNtIC/yxTSoQgUQdo+PQJWFhidWj4/jzzS84grBWoIRm4U+EAHcVF
         KxKxLS61fHf0VZkHKXMhZp/2ScFACbM2h2HV8CLJNRbv3AG/hKGKbvmRITNxCP6uy20U
         ycCwPVdvXE6RmEykeYjp/4vjwbxsngULd9GbaTlep1NepO2HZ3dwVoq0rC7kvjPbrWFX
         VYetfnIF4UqsQmEdf73j+rckWFx4IWXlvE5x6aUXk2qAY9DUeH4naerIfgqhCHG3mtig
         bxqRADM3RPpU756AtQmxFsBKxpYsa+rRmmZNTNDCiUU5k5DLJxnU+4wWDs5Pc0r2inKy
         J9cA==
X-Gm-Message-State: AOJu0YykukmQja52vvur1lEU92Vnsqm9ts6/7a8mBm8Ct8fEHFnElWdM
	EcR0gT+IWcnpMCTtI0ARk3U4C1IBieGVnl7VBotgdD6sy3VCCFxLm00e
X-Gm-Gg: AY/fxX7x9TgP+drRmbX3jJIxU7GZPzmXHc8aKu83R+SZa8tyO1aR8OxHMDj4x3CdPM+
	nsh+BaK5E48Z0DWKm7SpbfCzjqJJuhpXB3BxIbsIno5L2BbxTgk3OgltA3LsOddRI8ch6U1J0F5
	sfiPsZs/zc84wRc84OvMj2VJKA/pIGRG0Bw7fsY0KBQUyAOY+waCkv00oSVAzGBR8ZIztkX0yfi
	OETchwY9/bRJf41CmVNOnPTsf+4P5ACKWGh3Ds0tk44+x1dwRUkpEL5AGgiF8t4mzt4k4xYCIAU
	w9gAsvcT89dIog1LRHqOBV8ce4y9gT649Mq+gD4iTmoqlVkgMjLEAwxfAPGYs8oY9HiNvngwNFY
	i5zi4F9cPA/3kfwNN42uF7rKoDEu3TRobarFRSp+tKa8qrhMbPgFazNdckHE77iXaVnKcMRNc1G
	MOZyHvF0bgqSwC22yVQXHL/t/GkQ8v1Z76vey76D9qlmFs0XC5alfMugqJWuJe5HjAbv46qpe+7
	4Dc4jB5/WJGzurMwQz50Fpha8aC1dBuHGF/mQZuiRwJBpM3NHQcTwUDOaT97DMm
X-Google-Smtp-Source: AGHT+IH4M27L0GnkKa5YZjgEGFIEggORP144TJzRSbqK2PgPBt0czr5vNAg03Rt65ew76snUH/SXqg==
X-Received: by 2002:a05:6000:2083:b0:431:16d:63a3 with SMTP id ffacd0b85a97d-431016d695fmr10732866f8f.46.1765977076158;
        Wed, 17 Dec 2025 05:11:16 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm4849071f8f.29.2025.12.17.05.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 05:11:15 -0800 (PST)
Message-ID: <37b642bd-9f26-477e-9fca-1e3c931c0efb@gmail.com>
Date: Wed, 17 Dec 2025 13:11:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next] ice: access @pp through netmem_desc instead of
 page
To: Matthew Wilcox <willy@infradead.org>, Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, david@redhat.com,
 toke@redhat.com, almasrymina@google.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
References: <20251216040723.10545-1-byungchul@sk.com>
 <aUDd9lLy76sBejrP@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <aUDd9lLy76sBejrP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 04:20, Matthew Wilcox wrote:
> On Tue, Dec 16, 2025 at 01:07:23PM +0900, Byungchul Park wrote:
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
>>   		rx_buf = &rx_ring->rx_fqes[i];
>>   		page = __netmem_to_page(rx_buf->netmem);
>>   		received_buf = page_address(page) + rx_buf->offset +
>> -			       page->pp->p.offset;
>> +			       pp_page_to_nmdesc(page)->pp->p.offset;
> 
> Shouldn't we rather use:
> 
> 		nmdesc = __netmem_to_nmdesc(rx_buf->netmem);
> 		received_buf = nmdesc_address(nmdesc) + rx_buf->offset +
> 				nmdesc->pp->p_offset;
> 
> (also. i think we're missing a nmdesc_address() function in our API).

It wouldn't make sense as net_iov backed nmdescs don't have/expose
host addresses (only dma addresses). nmdesc_address() would still
need to rely on the caller knowing that it's a page. An explicit
cast with *netmem_to_page() should be better.

-- 
Pavel Begunkov


