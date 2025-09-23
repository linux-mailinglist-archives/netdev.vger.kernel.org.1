Return-Path: <netdev+bounces-225539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81542B95439
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C40A3B0751
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4C831DDBB;
	Tue, 23 Sep 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsRWyaYs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6330E0D8
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619975; cv=none; b=kvMHsjJnyfVjFBzGdZ2jaWosuPgDDlbpQRuiqjDMdWc6jGDfsfsoBtvvT8Ow1AfR4zQU0uad5NNXEolU64iMfBjfbO4K9+Skic9E1qAeUjjRyIQFoKlj2ffeWrjlrXGRMlSu6KKvcnZUX+wuJjWYvH/mu2zEOXubYdGfbkqwRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619975; c=relaxed/simple;
	bh=tPB7raWfWGID9fR86FpK1VHZrKtm3duV7JMnG1ZKvQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qFowMNnzodTI4utqQNqdTkVp0whG3+El6jEKT4WcpHu16OB6xax1XG+2mjcMrN/iTIgLOcdcmiTYAVXehpxlBstJVWmpFXI59pQfTlL4v74+Uum4YCf+/E5e7UBA+TouhyAYRBYl9518725SeXTcIpkBztkrbTEG2gpvbNt7IGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsRWyaYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758619973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nfMQGoI76BBPiGl3YfZGIEopu0bozaW6TiCupIKqWQ=;
	b=FsRWyaYs+a59OiMTk7Fss3TlPeRNgdAZI433yDCLNUlgZaUF3tObZF50kOMyf3iw+iX4cu
	YQhz9En0L6wcfDbSi57JcRVx3rzJH9zHtDBIRJwVUOWLjZWJNr0fPP0Fy7hE/OquGAZT0f
	aS6JjYDCRfeQ8JQo+L3iBMJfS3q0bJc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-exMtQlgqNIGprmpACr-qRA-1; Tue, 23 Sep 2025 05:32:51 -0400
X-MC-Unique: exMtQlgqNIGprmpACr-qRA-1
X-Mimecast-MFC-AGG-ID: exMtQlgqNIGprmpACr-qRA_1758619970
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso44426175e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619970; x=1759224770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nfMQGoI76BBPiGl3YfZGIEopu0bozaW6TiCupIKqWQ=;
        b=UY3YUlZ4ceCgO4qk+RF7FmPbqjQKrLHF9V/rB5b4qP172izEn+JwiCgzwSIKp+Rmjy
         k1L8HnTRNv33TephvUs8/4gNu6XgIAQVNem/AYMxDEseetJvHyFbNHdOUJAVIl1meaRl
         OyyROJUioXsu470RqdK6qA2+etmuAy/cw5WmpsWWI/0o5Idzmvpq6Aj1Gj9p50Ny1TXa
         dHcgBnM734ORkxgnsMXz19/gVozYze6/cvoRARoyjaftQYhNxladuRcIdEXQWszrAh9x
         /jqHketQMib3QZ2V9MyIzUMSFSTZ3qEPx8mQCOdtbubo91sXu3bki4KeO0bckM4Xwtel
         hApQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyfvb6/j6nr3TbJWG2IIQCIZN3LlJui1hTQ17CRY0/PovlQOgJPR3vkiYgzq1WtoYYhJKroOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIoFcpr0v0EfOEKmwLTUddo4I1K6L5ieg8S0EHvB/TyTULUU6Q
	zVcAfzjyuKHKyaCACfw/iuMEoNZaOJVzCrJiBI3phZ2f327i4K98j8Iml69nXOX2attPQplxStB
	kN8Q7LXVYXQqRqid0osmu/H4Eh3XfA3PlB21mR82O0L8jAaP4jjPxe52MMg==
X-Gm-Gg: ASbGncua+DeLYH2jOD6+uVSVH4yTbfmeC6e0E9/VvqkcMUF+DbFAQskshdLAfLSkzMR
	4cRpbIo1/I2eb7lR8zUgk1q6ckIJbIriwJBxUxBVv3q3dVMWBBulxvkMpRnVsMseLsqW26Ngm24
	U/8pndw81+YI8BL9F43+TQ39+WSzorNaxeo4rSlKXPSa93uDTBMa8r996uaSW5bfMHbbdmRtTlF
	d/QhuQvkEtge3nraRrbf8UMSPt+Cc4Ue8CxTZY99IKqE7N6FH/GgBVt/MZ+Y6JFAPnF1qk+ZPLF
	nqTeC9wPUDYOgtApAvP5U1GRRsI8rnDoxfB7EuaMY0lss5NFsmhMRUVhn9K19Lq5afktyqmbopw
	McTSQk0pK6nqQ
X-Received: by 2002:a05:600c:1390:b0:45f:2c89:a873 with SMTP id 5b1f17b1804b1-46e1dac904dmr18754255e9.35.1758619970400;
        Tue, 23 Sep 2025 02:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRjW0E8LgYXwe/Hd1Mr/o19iMfwq8X3jZyBkMmVWt+MhwqmWqz4pvjlLgA+mFsqOcaCMAy4g==
X-Received: by 2002:a05:600c:1390:b0:45f:2c89:a873 with SMTP id 5b1f17b1804b1-46e1dac904dmr18753925e9.35.1758619969994;
        Tue, 23 Sep 2025 02:32:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad30csm271970905e9.23.2025.09.23.02.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:32:49 -0700 (PDT)
Message-ID: <edfffc1e-a737-4074-98b1-6a2d60f50051@redhat.com>
Date: Tue, 23 Sep 2025 11:32:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 01/14] tcp: try to avoid safer when ACKs are
 thinned
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 9fdc6ce25eb1..0b25bf03ae6a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
>  		tcp_count_delivered_ce(tp, delivered);
>  }
>  
> +#define PKTS_ACKED_WEIGHT	6
> +#define PKTS_ACKED_PREC		6
> +#define ACK_COMP_THRESH		4
> +
>  /* Returns the ECN CE delta */
>  static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
>  				u32 delivered_pkts, u32 delivered_bytes,
> @@ -507,6 +511,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
>  	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
>  						     delivered_bytes, flag);
>  
> +	if (delivered_pkts) {
> +		if (!tp->pkts_acked_ewma) {
> +			tp->pkts_acked_ewma = delivered_pkts << PKTS_ACKED_PREC;

Can the above statement overflow pkts_acked_ewma in exceptional cases?
Do that need and additional min_t(u32, <init val>, 0xFFFFU)?

/P


