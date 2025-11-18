Return-Path: <netdev+bounces-239528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A6C69503
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A570D2B25E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749F350A1A;
	Tue, 18 Nov 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcg0IXDp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oLIeIMCE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B792FFFBC
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468072; cv=none; b=sjMUAwoV+aTKiCUQw8fCen+mg8qiZcEDutb2Z1rUrWRK2t90+F8oDnIF7J8a7l8vJhGqtRnDw/oifyF43bMz7WME0DO2g5uLZE+MMRuMzGv4fs/cVcmOddbTYPKeAsd+sI8Y1sSoAAt2nbM/sicpMlOb2UvoX4Ls/Diwbh+EX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468072; c=relaxed/simple;
	bh=ImZWzph7mTWwkohu9lyvahWKCLQchy6l2VlEx8q1Poc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uB5cK4l6FVgdxtcagnNw48NHwXV8MLexBd+wVlU5sz+rLGUHrB5+ZL60voB4OxxfED8/OoA9/Yyo55dS+4AeoMR08kXaWzRdabxsof5L7SxdqdjaWF8A1nSiPSZPnSO/jk2XjUK/7zDhGlxLsA+9Ml2nvUmZlPPJPEEe0tdhNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcg0IXDp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oLIeIMCE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763468070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BCjv/CGdgcWSx02tEn5XWDlQF9iUwwpCMljkc4+gpo=;
	b=hcg0IXDpAJdZtgzqplOFtjK4rVH/CRqdtb0/crbzR1qK6JlL/l9rCS9EOYYsQg/mKb3xGU
	BBkod/E5h5AUqIyvhZar+1w2LWqrUl5MvBzRjz2yNQj3hYw1DPFSI9Af8qZCUUHoDtS1xY
	THl+IPurzQtRKe0m//SzCA/AUUii4YM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-BWNYLUC2N6u3g5LmvlG5Ug-1; Tue, 18 Nov 2025 07:14:18 -0500
X-MC-Unique: BWNYLUC2N6u3g5LmvlG5Ug-1
X-Mimecast-MFC-AGG-ID: BWNYLUC2N6u3g5LmvlG5Ug_1763468058
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2e448bd9so3447996f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763468057; x=1764072857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BCjv/CGdgcWSx02tEn5XWDlQF9iUwwpCMljkc4+gpo=;
        b=oLIeIMCElJTKvOrIRloJeEjKzP/+i8UlXsW3TG37K6DPDuom3PBXUFYoJf/wMcCHyN
         oNebRpWyM/UJjHLDg5AzQmehE9aVF7OiijMX8mR4M/uFi51lL/R95pWLghcFcnJXzSst
         48jORu4dVC3TOaVGaaCg7nQGO1DSthhgzjrLFvcO9FcL/7mMon+1SBY2xlNrJAr+eC1r
         UjgTeseIO70sV+BCldlo2LkwysEhyWoFMjnwcRVSi+3hqR+eFmqMLEhJMSn91d8zQGIX
         y+ScJl29Ocjwn6qz1zU5o9PuNzEY970o+cRC90H99Juo7CEIfUBi3VD6zuPYkI0cttma
         KfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763468057; x=1764072857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BCjv/CGdgcWSx02tEn5XWDlQF9iUwwpCMljkc4+gpo=;
        b=M5TVJDDhmMViNk3odEEXKm0TFehGwGkSO39ndE020opsbd8SG1JaZO8a/tTWS5ARvv
         LpeNUdShdixtSFmVmBvCSQeUM8zzwUiue2wmDkJGobrht8IpvuzgEyf9d0yvrEJ4fWSE
         MVHgpVJwDyi0LDmLmMPgmw/MylzMVOaAnmcBW/VAclvfBXlpGm6Y+1EY3ilfmC7GzgJ0
         4p5jqoPRHDoRyemSILY3DQwRKM0K4E2fLr9C8w6xEkd5hVvFMVcvEPYRDahTtxigxK5X
         PIqq/BorjW/0UEifKBqR83fT5PW//RYlFoyc2Hk+exUYW8vnb1dYAi6rmj5TeALJeTdk
         in3w==
X-Forwarded-Encrypted: i=1; AJvYcCWiD/XdsaMDUPrD7YGNTtRP2yFqBMQrT0BjJGg7MwZB3oDu9lXzxdNvD6O2l3mZW/6ktNULfOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFAhRlKjDm8KdJ9w2xpOmKssHQYC3ffDIjYKw3UFwquarQAWS
	4UDLNlPVIU/IjJtun7fxPWQt1AwC3Euwm9f5stSJWGIcMB23wtc5jZkBZvJIW6gSPEe8pnGAbL1
	FS8m9ECuH4nfKSOiRKmGchYql1ek3NHLcl5PRIHtV/puhedbahInPR86ZfA==
X-Gm-Gg: ASbGncteo/eBrqugQao4CPoXxttXf4jBE3Jzut7nTQrICmooirchtaXPnCiZQoYQACK
	6qbp+cqFyIL9MYQoDj22ZVNuxJFYmkbZzzZk/Nn5Ilh2YEKjZ025OtdKDzfE98N+nB2bPHmEu3I
	lk9gH6Br+ht3YFQ6m54l5SqMWPgH+c1RWj6iJq6HK3kc7NL2lcYUvxGtopCqqiY7tzn6nvmkT2W
	OxG8Z8RsWQxtHIMX54Sh5Uuvq1X0TV8oNc50S2dqNbh9x3mA8qITK1dmYnFPTxLTv+7E66/xIXr
	QllWa5ZGYVqCWgvdGuyLBnNy5e0Nm1GdkYJBM5XRgvi9UX3/Mcs3nfMdTdQdc5yqLGfhi0I3Fsm
	a0P9NlIfH7Odq
X-Received: by 2002:a05:6000:4186:b0:429:d19f:d959 with SMTP id ffacd0b85a97d-42b5934d6f1mr14360736f8f.15.1763468057539;
        Tue, 18 Nov 2025 04:14:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErQTLe3bQ/i474JHpwGcSyu8Y7j1VvytPeuMCoBPNChkmE/I6UW+IYqaTo4xS93xhgJz9RAA==
X-Received: by 2002:a05:6000:4186:b0:429:d19f:d959 with SMTP id ffacd0b85a97d-42b5934d6f1mr14360710f8f.15.1763468057114;
        Tue, 18 Nov 2025 04:14:17 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e97a87sm32474774f8f.20.2025.11.18.04.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:14:16 -0800 (PST)
Message-ID: <92c77477-9945-49c2-90bd-6e05761e2a3e@redhat.com>
Date: Tue, 18 Nov 2025 13:14:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 04/14] selftests/net: gro: add self-test for
 TCP CWR flag
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> +/* send extra flags of the (NUM_PACKETS / 2) and (NUM_PACKETS / 2 - 1)
> + * pkts, not first and not last pkt
> + */
> +static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
> +		       int rst, int urg, int cwr)
> +{
> +	static char flag_buf[2][MAX_HDR_LEN + PAYLOAD_LEN];
> +	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
> +	int payload_len, pkt_size, i;
> +	struct tcphdr *tcph;
> +	int flag[2];
> +
> +	payload_len = PAYLOAD_LEN * (psh || cwr);
> +	pkt_size = total_hdr_len + payload_len;
> +	flag[0] = NUM_PACKETS / 2;
> +	flag[1] = NUM_PACKETS / 2 - 1;
> +
> +	// Create and configure packets with flags

Please use /* */ for comments.

Other than that:

Acked-by: Paolo Abeni <pabeni@redhat.com>

> +	for (i = 0; i < 2; i++) {
> +		if (flag[i] > 0) {
> +			create_packet(flag_buf[i], flag[i] * payload_len, 0,
> +				      payload_len, 0);
> +			tcph = (struct tcphdr *)(flag_buf[i] + tcp_offset);
> +			set_flags(tcph, payload_len, psh, syn, rst, urg, cwr);
> +		}
> +	}
>  
>  	for (i = 0; i < NUM_PACKETS + 1; i++) {
> -		if (i == flag) {
> -			write_packet(fd, flag_buf, pkt_size, daddr);
> +		if (i == flag[0]) {
> +			write_packet(fd, flag_buf[0], pkt_size, daddr);
> +			continue;
> +		} else if (i == flag[1] && cwr) {
> +			write_packet(fd, flag_buf[1], pkt_size, daddr);
>  			continue;
>  		}
>  		create_packet(buf, i * PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
> @@ -1020,16 +1045,19 @@ static void gro_sender(void)
>  		send_ack(txfd, &daddr);
>  		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  	} else if (strcmp(testname, "flags") == 0) {
> -		send_flags(txfd, &daddr, 1, 0, 0, 0);
> +		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
>  		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  
> -		send_flags(txfd, &daddr, 0, 1, 0, 0);
> +		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
>  		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  
> -		send_flags(txfd, &daddr, 0, 0, 1, 0);
> +		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
>  		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  
> -		send_flags(txfd, &daddr, 0, 0, 0, 1);
> +		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
> +		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
> +
> +		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
>  		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  	} else if (strcmp(testname, "tcp") == 0) {
>  		send_changed_checksum(txfd, &daddr);
> @@ -1163,6 +1191,12 @@ static void gro_receiver(void)
>  
>  		printf("urg flag ends coalescing: ");
>  		check_recv_pkts(rxfd, correct_payload, 3);
> +
> +		correct_payload[0] = PAYLOAD_LEN;
> +		correct_payload[1] = PAYLOAD_LEN * 2;
> +		correct_payload[2] = PAYLOAD_LEN * 2;
> +		printf("cwr flag ends coalescing: ");
> +		check_recv_pkts(rxfd, correct_payload, 3);
>  	} else if (strcmp(testname, "tcp") == 0) {
>  		correct_payload[0] = PAYLOAD_LEN;
>  		correct_payload[1] = PAYLOAD_LEN;


