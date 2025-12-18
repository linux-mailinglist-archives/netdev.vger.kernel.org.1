Return-Path: <netdev+bounces-245339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B1CCBC28
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898AA30802E7
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA60A32D0D6;
	Thu, 18 Dec 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfuBAzed";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSh5/SVW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D300327BE0
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060090; cv=none; b=qhUH5DwRV+lp7GSGxFX8nt5YFsOM+5meVav2rZJkB5JnB63T6d1Mupwy+Apd+mppmBF+KER93ACBshSi6hOIrFz+9ae2zc+8F98R9SYy7AC0ssBDN/AtRVfNtbuX14MWZk35Zm87HDB7kjkG78kDvwKtMLWyzxt4VMZLpdgzO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060090; c=relaxed/simple;
	bh=zZq/z6A+c1YO3amUlGXD/9ir5S5QJCBcNizEkWsYebE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0FNZPMMZbIahqP6kMfLhCgx9fmEuEVd+aDu0bNYp96hhqNkc45CpLMx/Tuzn0OAdt5SJNy+sFmNOs80KOMWcSkGtYk5z4MwwHN1BxpdS5z64y59gqZT31KoeGcjBp2e6MAMS6cYMBR6ZUM65i5eXp6aFxnIDC/2wbAF34S6dIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfuBAzed; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSh5/SVW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766060087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgRR9HkYxgKFCBqZFhUlWNzAPSgCWmIS+3s3iTb+nEc=;
	b=IfuBAzedwb1bHDHO+23+VbFcPaEGPAQFXtsTK27SVwNSquY2Aine/DeUH8o3/40WK2oekd
	fG0bHPSS2+wAe4Sy8eI4sPNF5w7GwKQiUHh1bdG87ei93FuMSygEKmguTwkFuwLU7mNoAT
	zk0l8PQExubnhCVQF1kRty1XlxxvmhE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-wi-krd86PqaiZ2SGq_fKtg-1; Thu, 18 Dec 2025 07:14:46 -0500
X-MC-Unique: wi-krd86PqaiZ2SGq_fKtg-1
X-Mimecast-MFC-AGG-ID: wi-krd86PqaiZ2SGq_fKtg_1766060085
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso265149f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766060084; x=1766664884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgRR9HkYxgKFCBqZFhUlWNzAPSgCWmIS+3s3iTb+nEc=;
        b=hSh5/SVWDSBolN7b/O+rkn5o90BSF8Jh1b/OZBrfmdsdzCL3/Mjr7t0SL6JTJgvn7t
         bul5M8D133L9sgpOPZCkxYPl6jQqrn7pMizhdKiSsW9cMCA2tLiUUTeiFmGSmCxSZPQZ
         ChqcaOVcPoOwGhx3U6DLdGDPDVlCLOiISWYOnL1acwppMalX4R8ZMJqe5a1+ozr+Earm
         UECARwXRgD/N3Geg5qsBBrZp2l60Mum287Bus2hgTWpofmrlIDcdE6FIXjKQOSTZWW1o
         KcEt6u5gk/nsFdDNoxz+8OF5dl5SpHnPBtz4uNOxJePiYW+pDSqatrhWuhxGrMqkMoc+
         Wl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060084; x=1766664884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgRR9HkYxgKFCBqZFhUlWNzAPSgCWmIS+3s3iTb+nEc=;
        b=SOdPD0kBADk3jwcLgWpeWJVjc/Yt8Q/Od8bxBT+Gn/NO2ZPjPF16QEUc1RJ1xQusHz
         hi56Y0cLUch4ZCa//ULbWgpdLyE4TaXqEfrzilfauzfwRARbm99bA3ac72rabuZMRcuo
         atTETVrooiIld/mqoiiUFquV4JyUkJDdiPQhbHj0sTE3KsfSfB8mkcuOtyXgYDDYhbrD
         qLGYwke9nVnbq7AuHn5Uj528Y4kK5tiRDob7z68cOX/u22auKACiy/JQdGZOgXnF/xUE
         hBeF1pE72ZwGBv7OQdVCN8oo5Eb02leOfnFHWafGWEf3xofMEIwksQBGWobydh4uJgPQ
         iCYQ==
X-Gm-Message-State: AOJu0Yy+G96DQWpx4hTnTqCen/Kcf5SnsB+smDGT1yTgo6kJG1gQFFJJ
	mv8yfHVZL8d0DLimXTNT5xTAIq7r7deJwYMJdQMIgUTqY1C8H7V4qf7//lTdTwFjlOI3IIW4fgd
	+BPiNIqz3+qJWwa1FB7MCrjw4CKqbHPRXvsWJPkemiZYzK95rU7tRiYSA45PWT4RviQ==
X-Gm-Gg: AY/fxX7SJaDrV+I0Sc8H3rY1C2EhoktPN9pi5RllCGOS5NKRzPK9zZbGRT99i2bqCZ0
	s1VGFR0W5EkP8ZUCTSJ07w5kXkpS/3nLkmpRCspusIBjQRG/TkhgCanGDG1NNB7tLz59jCjkpHL
	KW4uqxOH6l3VGN55Ea+j551oKCm5LvmVDP83qBZrLMz3V4HPyaLPClwtRlPYkUsUGkNUpN+W8IU
	vEZnvGKZj7NGFTDfH+Sd2WPpISpLdDOXvje4YHcjqfQVx79rLuocRxmrHoWO9WyaCxZILshDdbm
	TfbgSJxkzwgKm1QkqrG78JU7WhW8fNPKv9lB5l47PgyfPCPlIP/2zOEOU5Mg3stjSL0fxHDFVWK
	c86znflB7Q+AtBw==
X-Received: by 2002:a05:6000:2f81:b0:42b:47da:c313 with SMTP id ffacd0b85a97d-42fb4476da0mr21110614f8f.3.1766060084543;
        Thu, 18 Dec 2025 04:14:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0An4Sok3enuv2kgkb9o1arBJPUDV09ozAK/U7xjG+0Sp9Co7WHhQ+s/88Jm0Y8UT/MGGhcA==
X-Received: by 2002:a05:6000:2f81:b0:42b:47da:c313 with SMTP id ffacd0b85a97d-42fb4476da0mr21110595f8f.3.1766060084083;
        Thu, 18 Dec 2025 04:14:44 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934cf5sm4767319f8f.1.2025.12.18.04.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:14:43 -0800 (PST)
Message-ID: <f73dcdc2-a63f-44e9-9c3e-c1c6340d099f@redhat.com>
Date: Thu, 18 Dec 2025 13:14:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: macb: Relocate mog_init_rings() callback from
 macb_mac_link_up() to macb_open()
To: Xiaolei Wang <xiaolei.wang@windriver.com>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, rmk+kernel@armlinux.org.uk,
 Kexin.Hao@windriver.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251209085238.2570041-1-xiaolei.wang@windriver.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251209085238.2570041-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/25 9:52 AM, Xiaolei Wang wrote:
> In the non-RT kernel, local_bh_disable() merely disables preemption,
> whereas it maps to an actual spin lock in the RT kernel. Consequently,
> when attempting to refill RX buffers via netdev_alloc_skb() in
> macb_mac_link_up(), a deadlock scenario arises as follows:
>   Chain caused by macb_mac_link_up():
>    &bp->lock --> (softirq_ctrl.lock)
> 
>    Chain caused by macb_start_xmit():
>    (softirq_ctrl.lock) --> _xmit_ETHER#2 --> &bp->lock

Including the whole lockdep splat instead of the above would be clearer;
in fact, I had to fetch the relevant info from there.

> Notably, invoking the mog_init_rings() callback upon link establishment
> is unnecessary. Instead, we can exclusively call mog_init_rings() within
> the ndo_open() callback. This adjustment resolves the deadlock issue.
> Given that mog_init_rings() is only applicable to
> non-MACB_CAPS_MACB_IS_EMAC cases, we can simply move it to macb_open()
> and simultaneously eliminate the MACB_CAPS_MACB_IS_EMAC check.

This part is not clear to me: AFAICS the new code now does such init
step unconditionally, which looks confusing. I think such step should
still be under the relevant conditional (or you need to include a
better/more verbose explanation describing why such check is not really
needed).

> Fixes: 633e98a711ac ("net: macb: use resolved link config in mac_link_up()")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Hao <kexin.hao@windriver.com>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Side note: you still need to include the 'net' tag into the subj prefix.

/P


