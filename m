Return-Path: <netdev+bounces-191787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26961ABD3BC
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF7D171160
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB52690F4;
	Tue, 20 May 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H20gj8sS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186EF268694
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734249; cv=none; b=B5vg+5Gz1BnmTDpU2BX34oboFjVwDJg4nzXvdbA2iSFDhOdrR68umUpGJgDO2+jcvPkDPzsEZNY6DOsL1ejXfWHnA6AFJuLJ2RF62QeajaPBJKK02tuYNTUbPdiP/uWOmmMVRbhs/QzAuaju0qZBXtQU/r00FE/FIMZ8zQR3iQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734249; c=relaxed/simple;
	bh=GdfrJ9wEalOSO5bv0hmoFkzoT7yB2DwWV6SQJUpoaZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dDAXq58WrYrVsnpn9iUFvoTBtDhuqKd/Ri2l5B0kp26gWQGkYvu1mTKZ31XMg9s0DmLec3LKpfeTC9r4JYVJtsyAz7egORm6qAtl/l23tv6iKkENkF3crL1xpCAz5EIm+NBh3E7NqsMm/16wQ5AKbKkiWZI3jPe0dWyXp8g4xeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H20gj8sS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVjYCglGOjhQOwhRRoCVF9gAuVp//nFBUyUL3xi0qNE=;
	b=H20gj8sSkKnuFQyMUepG6DhvAQXcSVeyQGpMPZexZDAIN+neRxihb5drYJtDAR7oPEdEyB
	p45hTz3bmuxLesJOOoixE2wRy3SO+rbGcb4IDJrcZr1OaanrZnruzldF5IQfc1+bfP55r4
	IsYzBDxeq1/kzYA2dk7SYTE+Sle/drQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-DBFOlHwgPBikOxoHqgWfAg-1; Tue, 20 May 2025 05:44:05 -0400
X-MC-Unique: DBFOlHwgPBikOxoHqgWfAg-1
X-Mimecast-MFC-AGG-ID: DBFOlHwgPBikOxoHqgWfAg_1747734245
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a34f19c977so2560519f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 02:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734244; x=1748339044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVjYCglGOjhQOwhRRoCVF9gAuVp//nFBUyUL3xi0qNE=;
        b=tsLG2FQm3R9Ld7ZR7T20cH9zVwYoKEB/3sAwyp7KAYEXzkxaX9pFwRq+Hyd+1KDrm0
         4LGdFVSUILz6ZOE1muuJv7v77dPhmBqjiIPb5RspOWhrLygw9rOMcthCWkrikY80NeHS
         RZiaVfbVyHI+vYzHxoyzeXSOVRFC0HA6+nK+E6z18lymyYV+OPL7EQ0DNcnWIA2pCyNo
         Cr1t0jZSI5GCqPhi96DHKiojePhiq8NHo8I2eM5nekKp1s7QkQdm+YCs8CBIjDCb/QbS
         hIvMortpWPC1bxgWAo2OYTTgmb50Rg62dxPIcWE/M9MlirBTviTAauEmhv8+CfhNl9+m
         JJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/14E9XhIRWPIBdoThJcgch5oJZpQSvUsG8LaIQyMwVJJJkJJYIaO+NUiGAo3meaBaKitZuxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFby7kmCMqtWbDUpFZHHZzoEfqh9pw/zThKl3sgE96+c1GUTEj
	m8bDZ16ODZcjq6jab7t8IwvgJo5H+9kFxu7WIEOFGUJy568d4OkXh4nlLFldW7PQifXcI85U8as
	oly2lWi03CCwtvePBmGfPrPHx6t9QO92gRyavDmBdusmcFFDp6dni2qmFpQ==
X-Gm-Gg: ASbGnctyAgY46tqaYKdVAoCBVbtANptEv8kQhD3tXIzSxClCvGyaV/8fc8P1/tFQQRU
	KSTNbAtt1p80WRQVtlIajbDJZnTUx8ghTfh4djfZXAQJ+5PMhfL/okqXjcp16MK2R2axenKt45p
	7bZo78LSqqkKL5em9/+yNh/KMeIOq43GObbL3Iww//mf30fYJGRCbqDwr8N8acFXKAXjZFr1PnI
	5EWZJ38YqgCGPCNMmd4I+R6hHtUuSPCNtHaUwz0lrqWw1ZlpiRjGKiyYDPsn5bMbpeV7JzVlZIu
	1diTCeIdhugUjF8a6FiSBI1epoLREe7IX+Tsw8QGewymL/dBWd9trxzGORo=
X-Received: by 2002:a5d:5f4f:0:b0:3a3:6d25:b8e2 with SMTP id ffacd0b85a97d-3a36d25babemr6669830f8f.6.1747734244573;
        Tue, 20 May 2025 02:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2oghOI8vAadYac9W7SXycaXiUvUjylnYzfxLoDCc2r39zb/TatFV5FbKXsSsW2LJtvpmuhA==
X-Received: by 2002:a5d:5f4f:0:b0:3a3:6d25:b8e2 with SMTP id ffacd0b85a97d-3a36d25babemr6669787f8f.6.1747734244185;
        Tue, 20 May 2025 02:44:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a04csm15574156f8f.23.2025.05.20.02.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:44:03 -0700 (PDT)
Message-ID: <f0941549-904a-452a-aafc-f42763d13d9e@redhat.com>
Date: Tue, 20 May 2025 11:44:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 06/15] tcp: accecn: add AccECN rx byte
 counters
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 779a206a5ca6..3f8225bae49f 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -497,10 +497,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
>  	struct tcp_sock *tp = tcp_sk(sk);
>  
>  	if (treq->accecn_ok) {
> +		const struct tcphdr *th = (const struct tcphdr *)skb->data;

Minor nit: please insert an empty line between the variable declaration
and the code.

>  		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
>  		tp->syn_ect_snt = treq->syn_ect_snt;
>  		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
> -		tcp_ecn_received_counters(sk, skb);
> +		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);

There is an identic statement a few lines above, possibly worth an helper.

/P


