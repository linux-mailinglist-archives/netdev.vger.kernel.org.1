Return-Path: <netdev+bounces-251109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6042D3ABA0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3096330010C5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C15336C0C5;
	Mon, 19 Jan 2026 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Wj1gh4QG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A5361645
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832505; cv=none; b=l+fQ4s8+MYWyRgwIhC/BpoSi52K8FCYdXl+NuvDfO4bJ7MvX6KClHXc4+oxmMAJ6Ir8FknwpXLMSfrHGpn8bLnwcHzT79VrlbTkHJ3/20RsPF4bFk/s44BH2Wturm2gkixVhvY0HO8tyzceC5AQsgF60JnKw3qd2pir0VQdjslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832505; c=relaxed/simple;
	bh=eUscMd11fUzX2cc6bInocUYE06/GBO7n5whFK4x/iyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ned9dXyhLZXfMWRllyONAjTeSnT2H8yUP+E5M/tnNZgpFAAX4YkIihyPpJXysHz7saP85FdVUpspa67VdHkI4tGmMQFBO3i9Y7IiTzxkn1kc19qIKgxpPMSFWOGBwI+s9X98VTO+b0vrbcqprMFsxfoRaLTcDJSWde2X+GyjWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Wj1gh4QG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso29954665e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832502; x=1769437302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7E7gxSK7pfoztFG+T4kpjsWfYYsLocKrXFy/WiuFtSQ=;
        b=Wj1gh4QGjmiaDprsg3tg1JLMg2zrthU67ofu3/zmVXPsHb6+nEe8MwlBzgtgXDD/ct
         cuLI3k/Vc2YpSwKpqTq0a9spqqbo0MDb8XqtfofaHkcggx7bfbpCDO59BX7HFG6TDWY+
         u6NvA519xXcZjBuj4cfJJT6lqLRISgJ6/G/nCIOufwzhwLO9hJmIEIpvAlP8dc8RWwzy
         XcVsDDM4YaQpiL4zZ6BnORydqPYLaETtMULgBSN0wc3laVmiX0KSI55QA+eAmwWuA0tf
         R2J62/JM7zE3TRRUiCd/J+Ra1alJYx58DEngFZECF0rHo4ollz/q/bafwFqSIG0Eoaro
         a3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832502; x=1769437302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7E7gxSK7pfoztFG+T4kpjsWfYYsLocKrXFy/WiuFtSQ=;
        b=h54hbQEHT2mMaai6adl9p4DIdp7UfHfcgUTTcE9CNejV61xXQRLX1T3reA4lLU5B8Z
         m/qNwA16CNtLOioHmiEHASG6LS29oUEQDmk5L+YogbgsaKQD+VMw11aDzTgRrOIvMdh1
         bNL/3/bwkc0lWv9WLZS43N+cFB4lKdj7lxwK6JPmb9OvoAyiKLMCn0FRcc13z3OQ1x1x
         uVMI1RLc8QyImwHL0houcMZpwqoVfA2xkBXDtPdbM5xI9BNAWfqcIXNHK8LTpNtwFB23
         T7lYUYmSBf7RjbsBC6E5+VhMVtyd4D1mnnzRVr9Z7hG9vSwQjvWsag3c2U5o2x8c8dLJ
         18aA==
X-Forwarded-Encrypted: i=1; AJvYcCUEwMzgCY9yQOehzUb9LkiA1I4feBIG8QWmuSwzjDfs/ufGorw4kTSnRnmtRTdFqXwCQycbtaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+W7L7dwFnGQIQCn0jDeiWGikttYL+jtqwurrVA36qxIvoqEVr
	W7EGrXCAvxRaXDeg8HOIKNKRzHIsVQGXVJi1WD8pqUdjUUi2njIWpoD9ncAwbh2PGvI=
X-Gm-Gg: AY/fxX5xPPofV/ygMGdH+Iofg4njlksjosF5niAl/20AxF+12ca+uQ39dJOaEJYNZqs
	lXvHvyZFxPdta20puigBDoWgCY+qly0M/hHD/VDRVQJyj7iWvdJhDQWkv/W7sKYMdVVufwjdoLj
	tpLdovDLUNSlkNpcYr5O42GKpmknAh1lgfRV02X+hqUNzbif6a7mSxG+gn+DqrrGpV8EDFLwyXc
	vu1k38EuAKhhuoLw9UxOyrTzAOREufL2WWzkyJc+QJeLXwNTHZX9HiKUfZ3pVOLY/9Nexwpkry4
	EjsjgO/QUjs3C6J9REJ3P+Y5obhfCnfNYZnyIwzemHlxCRnGbE6oeAWjdy/C5KQtuGXIheeL/iF
	WZOH1/+DcbO2LCfuuUiJ+ojY6Wn01emiH4GyNz52JbC9vd+4D6Ic7I3k5WGlGkTuh32NtDlkdBQ
	V65wr4legcBzMQAdA9IqTnMbm6es/017g2yvQjRWtWrx61TJ2ovQYnCeSj++FcZa37Algq0A==
X-Received: by 2002:a05:600c:3d8b:b0:479:2a09:9262 with SMTP id 5b1f17b1804b1-4801e30b49emr118719455e9.9.1768832502135;
        Mon, 19 Jan 2026 06:21:42 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm312840825e9.15.2026.01.19.06.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:21:41 -0800 (PST)
Message-ID: <25e26e82-f7d1-421e-b7af-766d99654fcf@blackwall.org>
Date: Mon, 19 Jan 2026 16:21:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 07/16] xsk: Extend xsk_rcv_check validation
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-8-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> xsk_rcv_check tests for inbound packets to see whether they match
> the bound AF_XDP socket. Refactor the test into a small helper
> xsk_dev_queue_valid and move the validation against xs->dev and
> xs->queue_id there.
> 
> The fast-path case stays in place and allows for quick return in
> xsk_dev_queue_valid. If it fails, the validation is extended to
> check whether the AF_XDP socket is bound against a leased queue,
> and if the case then the test is redone.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


