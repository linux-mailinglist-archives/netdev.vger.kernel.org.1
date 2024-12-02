Return-Path: <netdev+bounces-148030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837949DFE0F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BC8280F22
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403A1FBCA0;
	Mon,  2 Dec 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpCjkYpa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C11FA17F;
	Mon,  2 Dec 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133876; cv=none; b=WJSxQonAN7ZPl1zDljSEpFYjeZOmfwalygZo9AKFVOAgNx/zpk77N2BA1TZPtE/0WO2h+o6dBlj0ba5RAT3geFVUJVPR2P9MVOvXwOIGkd2YDR34wmwrwQYWzJ9scAWz6Btpv/aImFl5n31hhqNIvkpbH/j46jnjX1Bpk0rKToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133876; c=relaxed/simple;
	bh=//0MAe6pSHy6YWCnRR5EagEeiBWl3fP+h1f+eoKL2D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv+ofWUjcSv3V5kjrQUvpn4GvPY+QtT+CjL1pJZDzjV6XcSIL2e2a8czzF8rG9T5wwcjmaHcNVBW5V5Cu7OClYw1Kh8KhIrCow9fsHpM1aAsWJQY6sUTqzoYw02fQr4We3Gtehavlf5MP6+JZhmB7LYFLy6rmsFGYRjxWMmYkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpCjkYpa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385dece873cso1291634f8f.0;
        Mon, 02 Dec 2024 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733133873; x=1733738673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sgaf5H+6BR4uuayPQNK9MMI+wxrNCGfTUbRdoLwW1ds=;
        b=hpCjkYpaqoypQaj4ded496kge9+ar48oEn1LUD7UzIlo5bVpB/Q8XD9TOuxj6rosi7
         WXb2fotsRP0Z27Bu2DL0zc06G4/Pso32518xcqu0vyWXOHMcPsUpMYssxGN0QzLQi9bd
         Z6r8Eijq/tfH6HyOfMI/ctQPDg2ALRtrS2doBrcB3eE1Wa4/vsLDfWrdU0fQCtn/19bp
         sMLVpUIskU/SaUUb8pnVzSPdw+RzAyPNAQ5SieQeA3OWSwcxtL3rSVNdPlUyGdS2y+w4
         cHpe/6l5ciicoF3UjCfzYnIWZvjbY/VqHoKAOpIM+fike50HygXnEDK/Os6zqkm0LyXB
         yXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133873; x=1733738673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sgaf5H+6BR4uuayPQNK9MMI+wxrNCGfTUbRdoLwW1ds=;
        b=QIAgy2+XDeRm8e3GhPsBDPx3DfQiiTRwNz3C0bJAYBo75lESDmdKHPnpNmRn8iNty3
         uVhwKr8Q+xGxz2goN//OFV/N2ynpKfmLGzxZmm/Tcci4EZ8HVWmjHVBIHtd+4X4bhgNo
         FUvwmOFfbNwo1ccRS0FQywQWREkAkmkEbhVwLDfnsu1jsmV5/LMw0E2TEPouw7mLWb8P
         8+YsPs/bzhts7PO1joSX/Qxy9WmAK14qX4CnLsEntXF7bXav+HPHgow3m6WhZ2u5w2Kf
         fpz2mq5LSkAPWkkFh9XDtSboVZkScGJKuJFczt+1Y6Vq5pRMIDQizWq7VtNhR+XO83p5
         /qPg==
X-Forwarded-Encrypted: i=1; AJvYcCVpdnyLAnQS7Dx+bL9zsZFUq64uUSqoMlOcva9dXuA0c8i81K8jfiMScFiP0ljIDcL/raRbHMpQWlKp0ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAC2roCHk45dRt07k+iXjrU6yUl7f+zSQcojUwG+pGFY+d6sZ
	5e9iJL1bqRT+6LJzowK93iN6lPKj97YGVmYjgG+8Ke22DZZQ1ArD4ep5uw==
X-Gm-Gg: ASbGncthguNzxkCa71VHfnNy9VDguzyrAqQCa29A7gmC7sXI4G7PvYx0dJiA3gBGpSl
	KdMKssdx6JLohi+k1DAo8PRSaF8hNRo1siBbdoO0/O22CJAsphjsTD4NZstLg9pnUWtnxFoM1No
	l0/EU9+PiUT/CnPVvuW9FXn1buOeMao452oB/hgSY5TqSiBPF9rA1qNFSfcPk40TsPGK6QalTom
	kjKspfyII846BifoFN/Hv2B72BH9i1dfyzPG1yX99B9FwLa6w==
X-Google-Smtp-Source: AGHT+IH80g7ULS7rKcbL2AoMeU1jpiGZyt3N7OkquYoCku2xtN11qM7zuVwy193TAeqVc0ooykNDvg==
X-Received: by 2002:a05:6000:5c4:b0:385:f5b6:9c9d with SMTP id ffacd0b85a97d-385f5b69f3emr1834887f8f.33.1733133872725;
        Mon, 02 Dec 2024 02:04:32 -0800 (PST)
Received: from [10.0.0.4] ([78.242.79.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db59sm12029473f8f.11.2024.12.02.02.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 02:04:31 -0800 (PST)
Message-ID: <83df9d63-0c27-46a4-9321-ef6337bae1c5@gmail.com>
Date: Mon, 2 Dec 2024 11:04:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "Kernel Warn in af_inet" in Linux Kernel Version 2.6.26
To: cheung wall <zzqq0103.hey@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, pekkas@netcore.fi,
 jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAKHoSAtVJ=oycBBrcdxrTqZ8yW9dS=dWUU=mxQitJ+f73mGWcQ@mail.gmail.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <CAKHoSAtVJ=oycBBrcdxrTqZ8yW9dS=dWUU=mxQitJ+f73mGWcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/2/24 5:30 AM, cheung wall wrote:
> Hello,
>
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 2.6.26.
> This issue was discovered using our custom vulnerability discovery
> tool.
>
> Affected File:
>
> File: net/ipv4/af_inet.c
>
> Detailed call trace:
>
> [ 1788.473836] KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc))
> failed at net/ipv4/af_inet.c (155)
> [ 1788.473836] KERNEL: assertion (!sk->sk_wmem_queued) failed at
> net/ipv4/af_inet.c (156)
> [ 1788.473836] KERNEL: assertion (!sk->sk_forward_alloc) failed at
> net/ipv4/af_inet.c (157)
> [ 1788.473836] KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc))
> failed at net/ipv4/af_inet.c (155)
> [ 1788.473836] KERNEL: assertion (!sk->sk_wmem_queued) failed at
> net/ipv4/af_inet.c (156)
> [ 1788.473862] KERNEL: assertion (!sk->sk_forward_alloc) failed at
> net/ipv4/af_inet.c (157)
>
> Repro C Source Code: https://pastebin.com/qs5y6Bcy
>
> Root Cause:
>
> The root cause of this bug lies in the improper handling of socket
> write memory management in the IPv4 stack, specifically in the
> assertions within net/ipv4/af_inet.c. The PoC triggers a sequence of
> socket operations, including socket, sendto, listen, and accept, with
> crafted input data and parameters. These operations result in
> inconsistent states of the sock structure, where critical fields like
> sk_wmem_alloc, sk_wmem_queued, and sk_forward_alloc are not properly
> cleared or synchronized. The kernel fails to maintain the expected
> invariants for these fields, leading to assertion failures that
> indicate a logical inconsistency in memory allocation or deallocation
> for socket operations. This issue highlights a potential lack of
> proper cleanup or state transition checks in the network stack.


Please do not fuzz old and not supported kernels.

Or do not report to us the issues, _unless_ they also trigger on 
recent/supported kernels.

Thank you.



