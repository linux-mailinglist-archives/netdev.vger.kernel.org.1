Return-Path: <netdev+bounces-186721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44DAA08CF
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E314F1B65BFA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219D20D509;
	Tue, 29 Apr 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L84mSrcS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32A176ADB
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923558; cv=none; b=uVqAmXpL6Lk9x4haDSCisF9gMggjxug1t+UVCrBBLQ45c8bU1KVDfempNi1CYa5E1zj7mEPa+PI8Fo7EPByAO1zDrkSxfaEHn8PJOJmXfa+nMLX2KDhoTToJoL72XAG5F+Cklrv8f2+OtN29ReKDPkYeljInj3lMKd9IAYsvTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923558; c=relaxed/simple;
	bh=0NSKurciESBFEUjfZdIo82rXaTeTXcfkyDzLrLZIYIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PYtfUIK+T6lFxLsGfvUzWc6cFqoitbvVRd6rbqaXPONDfsdHPDkMBS8CgjiqHxzKWsdxVF/QfCJKea+MWLee+ld2DwyBbrW5rgsBL+iCDdx0bTGCPjEFrfLcVCbYi6o8t/bydFZ9LZdTX5PpYVbshfemcx5Fxt092VoegCm2vm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L84mSrcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745923556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN+UKNlb4Wy7kol3NSyz5lz02pJ0x8EuJYg2sYbM+jY=;
	b=L84mSrcSu7ocwOKurliAqhnA7QSYblF1Nlr7KtbYHKmhdIW+VSGSTpvsCvCfEFEzuqg/6v
	/gEX7278ymfSdpDxWl+BflUzP9q/lVNDAVU8i8x2PLMom0GnFsiXzP3wxZiLqVlA/zj7dI
	2MFWGv4AiNxwOMwobQQEKrW1HHhBc+U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-FZuN0ZonOYGbFPEjlg4FnQ-1; Tue, 29 Apr 2025 06:45:54 -0400
X-MC-Unique: FZuN0ZonOYGbFPEjlg4FnQ-1
X-Mimecast-MFC-AGG-ID: FZuN0ZonOYGbFPEjlg4FnQ_1745923553
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so714151466b.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 03:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745923553; x=1746528353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aN+UKNlb4Wy7kol3NSyz5lz02pJ0x8EuJYg2sYbM+jY=;
        b=cSaJEjvHV/hWVJkn6rOU6oR3wr7t03RN0ZFGr1x1vD1bh89hiZr9jqAtACKbToXTlL
         zpoT5edSuFrkW/ZKT4sRwt3ebm3aOMu+6MnxInm2ivfmzFYK5qxgm5C5D6UP56xnYZI/
         Jo0glr9tvjF3EP+lHcQTUm+TLn4FTyl1JUfH8i2ns3uCYRdIoqdIcRUGOqu/HxZbYqF1
         kZ9viSBiZf2ucZkEzvc9BdkcFfmKJrCdLm4pbKA3NEuFW56gXTVM2qP8AgCsg0KEbLlr
         Q2h5k9AoGiyrm7EGs2VYe/lQJC7yENLN0EeFhbK0ec9c+zF281j2vRR1Kkq8yt3GNskI
         XMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXlRB2XK1jHilqlTSO+MIdMh81CsSxyhHTF4oq4kLYwuvmf2XybDvWgpB64sWM6XM93UEYDRjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaW5byBHP7zbuLh86PSqIYMHSKDRBbqP11eE3eB+D9hLt5c6zw
	wAg2CJ6RTxDgYVcHl3EpPIDtLWmV1JIvNmliMgLeb13/jy8TIv8AOIONGzVaYEHqP/OZYZWp7jS
	UdOGPnj9KMBoU79OKj0pIYegep5YEcDol2LmbHU4z6kRe3kkeAobh2g==
X-Gm-Gg: ASbGncuUlxh1q4kZuvoNCGniefIchNWDJAb9Wa+/jbWCrgLCMGKVITxoItbE8B6HA6R
	dNy09Dk7idBf+XPwL6KG+hHajv5+DT23yV9gW0hP99b7aP/XTnjgZXHD8NrA2MiSdPGxIeOeyTY
	z8M25v6H6cZ400tC42otHxA04YscYJCaieSbtnmfCdA8xG9lNIPDStrXgTI/rsUkyrOrYQUcdi4
	/F7jj1njS8A46kQ6HL2e5P5eYG5U/AQ5Mt45rRYjBHMwzxumolFglrl6tQEs/jkzO62nAa5+WII
	8uo3mk7OCVzkdifvnPib5pVJZ2suRLYG6hL6caNFlCezG9+v66TGUP1DT/A=
X-Received: by 2002:a17:907:7289:b0:acb:52cb:415f with SMTP id a640c23a62f3a-ace84b279e1mr1102945366b.48.1745923553458;
        Tue, 29 Apr 2025 03:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGozcf6FjAPnL3LZPQMJPZBCYzwfasWb1qRqTn81hns/gqHo3eKbml0IfXHZplrtmlSv+ODGw==
X-Received: by 2002:a17:907:7289:b0:acb:52cb:415f with SMTP id a640c23a62f3a-ace84b279e1mr1102942166b.48.1745923552966;
        Tue, 29 Apr 2025 03:45:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cb08sm772460366b.19.2025.04.29.03.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:45:52 -0700 (PDT)
Message-ID: <5f7897f3-5225-4f86-8596-a5793989a9c3@redhat.com>
Date: Tue, 29 Apr 2025 12:45:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/15] tcp: accecn: add AccECN rx byte
 counters
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index af38fff24aa4..9cbfefd693e3 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -303,6 +303,7 @@ struct tcp_sock {
>  	u32	delivered;	/* Total data packets delivered incl. rexmits */
>  	u32	delivered_ce;	/* Like the above but only ECE marked packets */
>  	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
> +	u32	received_ecn_bytes[3];

I'm unsure if this should belong to the fast-path area. In any case
AFAICS this is the wrong location, as the fields are only written and
only in the rx path, while the above chunk belongs to the
tcp_sock_write_txrx group.

/P



