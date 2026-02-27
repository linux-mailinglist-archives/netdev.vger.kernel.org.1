Return-Path: <netdev+bounces-261836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILJyBkOWoWl8ugQAu9opvQ
	(envelope-from <netdev+bounces-261836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:04:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF511B7718
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 443C8301ABA5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0FC3F0762;
	Fri, 27 Feb 2026 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRkqP5R9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600912032D
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772197439; cv=none; b=BLw3l3+SE1TSyRC+VjNiTi4tn7IX3o8Az73NrS4CVv70K0MTQ5bjq9NqyjppOudAkjnfwu8VZQbHfb28A1EU6u+azk1zoisNWhbYcb2VpMBJmyPFUKDRyNnzdXRpvsPnb9fXU06l1SeqqRbM6EQnIz28CWicYYDdPpm1Yjvzsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772197439; c=relaxed/simple;
	bh=QxRNqrOWtY4W9PsVH/ATqeFPXiahp4CeK11M6wq/n98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYRpg4scFYk6OglnOJxYhoYRhl+ykWq1bbyomAkvbr6FVQMY+GqH9HnRSkt+mDDJrsQ0Kr+mUutHvUIWVi1kc+1WoMlp41YXzxTthSsnRqgPooP1/2sZmNvOiDNP9WjsyHAWT3oPdz27ZVAwrmfSHHQ2dWuLYot+dgSAOM7PZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRkqP5R9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b886fc047d5so338023966b.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772197437; x=1772802237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=290JGGfAoFlThz6wF0wfNkvuCjanUoBb4lMREKo2BoM=;
        b=lRkqP5R91yknEYSPmmgKqMAGrtrQVWMND6r+g7wnG2BzIt5wsAyGTPyo1qaOIZFVn9
         izVzoObWmyboEqTWim40L5NeAwc5JYrLhAweIzxYpaU8VT2rYIqxqvjEYkpraoGRzXdE
         dSEogKl3n3zJu+BjjhrXuUjI2GSvFKu8aiixBPE2kdkPc/smH0BuSRoVI+6dwTFyvmU/
         Fl9wKy+24R2cVM/N1SppLJ91lBYI5lsWR3tUil6zilTIyb4DX54t1xcwFaKBlwYYymZj
         nQtlB7jbu+MSHMSDZE/s+zsfeG783N3fDqF/MvPL8a4vuK7QDwISQFs8HCOwX4BjeUit
         PDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772197437; x=1772802237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=290JGGfAoFlThz6wF0wfNkvuCjanUoBb4lMREKo2BoM=;
        b=eMhUYikReWnS26i5jYOwATjFGwjY945NB6yn4iHaVJFdEGC8zQYEjq54XBbKujFy1f
         Q0JLqtfGhPm61uZcsnpE9ojxlBxTytwRR71Luu99gY0k6PuTi4vbgODX1NCIT3TaX5ga
         nPrTGCrW8G9YR23/ihCq44D63aQ2gN5anQ39sHNsnJ+J21PdTy9WZsGaVKlT+TrOf8Gu
         Vy8HX9Dz9uen77jxCZ8IHB8s9KiKj4T+VLtctJnDkg1whBiStlE4m1fu4Al8XqFzT3Ai
         dj4tw0as1XUFhpzr3f/RNn/HUAKxfKcW5kqYm9seNSum4MhKdsXhtmZRiQ8VBFAujUGr
         Pz8A==
X-Forwarded-Encrypted: i=1; AJvYcCXbjq3umPK+/73OloHBHJb/n6wWV8Tt52McTFrmhkCSrN5IXSH3GlpBQUfu+fAcar/mu8KF0hY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56QWyq5doO4GLduiluxWd3mob7TuRwJ7UY6gJtWsfTNqfR0/A
	/JZBTjUvTF8OY6rFuyyv1ARCkbkR2iLZKGRkHNbN6rWs8TGo5dwQJ4Cz
X-Gm-Gg: ATEYQzx9G21VFL9lQmzeS4XtPxnjiFAhDWk1lp4br+6FOA/gVllxSP1eZw8LH2VFs4h
	kwTt2aR/+PS0TYs5M3t+KJhNiC3lVNP+RWLKibz+8bdU3ZZmEt4XflA0X5zhYOwcn2jClrUAmH6
	/DFsa6D8pQ7+jWLE1rKuJb+JLyRN4eawvxMB8DypE9Dl7LXBODrVw4vkFc6JQ33VnHHTpa82iE8
	V3M6Pd4MAKXDoLM40G3hSA+labf57gsNBvm4y0qjP7mEMbkhcQVefdeV6LDPO71I54Zwny6ilKV
	SI8FX7Vq3kN7rcJqQwzVTrSJPZZ4R3EZ/n+Dos6o2XmPv+4B9yrbEN15MhCPKYjFR0gwM25qASi
	d5EJpRoh+0TOjx7bkymya/Y8ZBVgkQa7XlJVQVaCf+aBuZ5TH+HQ5SF3zaDqkWhuq2sxOC9P8+Y
	KRJeL3laqBgkvydN4xRowmUXte+DIE7KbR2HS0aQ0Hq/AK+JlmgUNdPVIz10cXexE2xu6/nA==
X-Received: by 2002:a17:907:787:b0:b87:718:5da2 with SMTP id a640c23a62f3a-b937637a69amr164082366b.1.1772197436358;
        Fri, 27 Feb 2026 05:03:56 -0800 (PST)
Received: from [192.168.178.48] (80-218-237-147.dclient.hispeed.ch. [80.218.237.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ae65662sm147297066b.41.2026.02.27.05.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 05:03:55 -0800 (PST)
Message-ID: <53f850f9-8f05-49ba-9247-ef2f823cc2b2@gmail.com>
Date: Fri, 27 Feb 2026 14:03:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: claudiu.manoil@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zefir Kurtisi <zefir.kurtisi@westermo.com>
References: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
 <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
 <20260226195158.sagjq3hgs6l64w2u@skbuf>
 <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
 <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
 <20260226195158.sagjq3hgs6l64w2u@skbuf>
 <786338e0-0a6b-4b7b-9e22-8253bb655aec@gmail.com>
 <786338e0-0a6b-4b7b-9e22-8253bb655aec@gmail.com>
 <20260227115708.lkpbea3b24ztdsgl@skbuf>
Content-Language: en-US
From: Zefir Kurtisi <zefir.kurtisi@gmail.com>
Autocrypt: addr=zefir.kurtisi@gmail.com; keydata=
 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
In-Reply-To: <20260227115708.lkpbea3b24ztdsgl@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-261836-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zefirkurtisi@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EF511B7718
X-Rspamd-Action: no action



On 2/27/26 12:57, Vladimir Oltean wrote:
> On Fri, Feb 27, 2026 at 12:28:17PM +0100, Zefir Kurtisi wrote:
>> While I was debugging the issue I extended enetc with features that still
>> might be useful; the first change was to selectively process only the
>> pending BDs instead of looping over all available, saving a significant
>> number of unneeded calls to enetc_clean_rx/tx_ring(); the second adds a
>> fail-safe mechanism for potentially other issues taking the same code path
>> based on the fact that now a BD is only processed when its IDR is active,
>> which means there must be BDs available to process.
> 
> We'll perform our own investigation of what is happening when
> transmitting short frames. It will take some time.
> 
> But I'm not sure I understand what you mean about processing a BD ring
> when its interrupt is active. NAPI (Documentation/networking/napi.rst)
> works on the basic premise that a single hardirq is sufficient to process
> a very large batch of frames, and keeping hardirqs enabled is detrimential
> to performance. Instead, NAPI (re-)schedules softirqs until there are no
> further frames to process, and only then re-enables the hardirq.
> 
> Perhaps I didn't understand very well what you mean, but it sounds like
> you want to circumvent NAPI, essentially. When enetc_poll() is called,
> you seem to assume it's the first time it's been called after enetc_msix()
> has called napi_schedule(). But it's not. It can also reschedule itself,
> when the work done is equal to the NAPI budget (complete==false), with
> the hardirq _still_ masked.
> 
> The correct NAPI behaviour _is_ for the hardirq to be masked for a very
> long while, when subject to continuous streams of traffic.

The change proposed does in no way change how and when interrupts are 
re-enabled or NAPI is re-scheduled. What it does is:

assume there are completed RX frames, but no completed TX frames:
SIRXIDR=0x0001, SITXIDR=0x0000

enetc_poll today does:
* enetc_clean_tx_ring(0) -> nop
  * read TB0CIR and find out it did not progress
* enetc_clean_tx_ring(2) -> nop
* enetc_clean_tx_ring(4) -> nop
* enetc_clean_tx_ring(6) -> nop
* enetc_clean_rx_ring(0)

Proposal instead: as long as SITXIDR==0x0000, limit to
* enetc_clean_rx_ring(0)

IRQ remains masked until NAPI is completed, behaviour is same as before. 
If there was an RX burst and NAPI is re-scheduled multiple times and 
during that time a TX BD completes, the SITXIDR would get the related 
bit set and TX BD would be processed in enetc_poll - all before the 
interrupt is re-armed.


But if the improvement is not obvious, it maybe does not justify adding 
the change - in the end it spares some function calls and register 
reads, which might not be that significant.

Cheers,
Zefir


