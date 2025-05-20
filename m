Return-Path: <netdev+bounces-191790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D3ABD40C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4FF4A178A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E026A0A0;
	Tue, 20 May 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUIenk5D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934226A0D6
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735213; cv=none; b=B3qwQBoco5hS7tXBKLsc4pNTMEItAFx+uHDMIpFremPoJNvN/T80fi5Gl09xRMxn5t2R0YLRyzDOYvVJlx6Ti+Inp1Qp7JVVRXdql+Tls/DAgvnIDXGJjt0U8UHqBIWkvXsiAVgTNgP6qO1lqDgnmCc5wgMyzTVthxxmDLNZBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735213; c=relaxed/simple;
	bh=V35LW/nQwrBSZ0SSHfv5/VHFhKk+U/HLriCmAgR3ptw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N+CZnkHcHXA3WErV0+hjpxNF3+/f+Jitap/44+YJuTGvPPse4FR+5LZJELBF3i/mlGg83Q/A3EHVxHvyyMyJxjTSTzAcVyYfst81yQ3vd9k7RlrRAZpuIMBn+PpRjvYlOW2GjdVoy8wK20R5UUROzYRqcVUWnSKAnAPCw9URrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUIenk5D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747735210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovy79HPIsx1vRVu32FicMB6OR/2LefEMThzMtPSO4mM=;
	b=KUIenk5DLP2N/WAAdnPM1z9k7X0YwIQlAvjErQJmf+vt+n5RdLvq38aqc8nlwQb5b2J9Y2
	1h6t6ahOZqGqTXSoRyLHK/JDM7jARhYaW2yiFMjSMij3cRGRGWhupqTn5R8076CRuLnXkf
	w5XBzX+vcDNTIFe94kRb1MMjdX2KDGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-i--l9jJTOtOufVhlcPjZcA-1; Tue, 20 May 2025 06:00:07 -0400
X-MC-Unique: i--l9jJTOtOufVhlcPjZcA-1
X-Mimecast-MFC-AGG-ID: i--l9jJTOtOufVhlcPjZcA_1747735206
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a35c86b338so3036376f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 03:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747735206; x=1748340006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ovy79HPIsx1vRVu32FicMB6OR/2LefEMThzMtPSO4mM=;
        b=Sv8yYgMu7NwkAETXMI8Z8R3tZIRf1Ldr9HT9GLacVbL8de0pXcQ1tXk2C9HKNEqtXg
         Bek/ooxQ9VT7wP91SysiXgug2slcXhx27Z2G/WJUX9Np2LNtqeY24u2thbjwamH/lxaK
         6ETb47p6L6vztuGbvzSAZkP2IQoQ1XfXBlKPcjPAaIgXS/EwHJnJgC5Idk+91h4otiEB
         jaURG55Z7xkFBv0J822qjoQYB8KGmjpbMMWv9+jLYwTLXQMdY2OSBPkwRgxvIEIp0wQc
         JvcZxF/XDTcM138BZQAXKQ7qLLEWfazUd6jpg5Ixf/MY+laRvliv3gJ3Q1W9hbbqwGj9
         rIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqJxV/gZEot5Z4a9is0NFrPPjSjzvO7GfOSrnP/axGQ0HoDwKhRRmXh2yo23wsOz9qNirm0NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXkkfYm+hbyS3OxDjPBa2spkUkwzfhoRfW7i7fo6/mKJ9U3KO
	kR2g+ZNuTZyRqmraw5bMzNfTedm+PLmBQ5gSY+27YZGaNyxIqqzAWT6LQ49vt69MCRfykW/PJNr
	NyxIG4AWLKfCBh6ZZgGcD3kj8BHC+xcw4NWzSeggOcCJAr452cFuRiMRLIQ==
X-Gm-Gg: ASbGncskB8Ei3R/KCspXcfjA1nPX//8fQQprpzMjnD5hX6ExyP7aD2jDYLUMIMhFsQc
	hCTUtQqZ0hZ2SIYR3Xi2YyGCI6FfWvzwwBCw2LclFoiQZJGPm7JBSdgoyfNYF1Jr1j9K9CAxLWp
	Kglvdm95kMT+d/+0HsVN/UdGW3m+EJ6BrymialcVzIxM9fomnLkViWN7vO2YtBiseSxar14BEhK
	hRTQ4SgEI19OnUSnmExR2ApaW7nDf2aCMywD2cKzDJKlONozGNG1fKzAvoAKpFRa4061ql3WfOY
	NEFteTER2NiNMVqtlvbGNZIJTLzoc8buFO+KLuG51y+59ncfuS8UbQFcr54=
X-Received: by 2002:a05:6000:250a:b0:3a3:7a33:c96a with SMTP id ffacd0b85a97d-3a37a33ca7dmr1495140f8f.51.1747735206377;
        Tue, 20 May 2025 03:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIRNWAVYHRnOH33ipWyYPABhiYG26BMzPeKKr8tdmXM1gGbvCqc/R+E0nOOiP3C8IUlUYdHw==
X-Received: by 2002:a05:6000:250a:b0:3a3:7a33:c96a with SMTP id ffacd0b85a97d-3a37a33ca7dmr1495096f8f.51.1747735205976;
        Tue, 20 May 2025 03:00:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a87fsm15500818f8f.29.2025.05.20.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:00:05 -0700 (PDT)
Message-ID: <344a5b1e-9cfc-4a77-b55c-84fe21c89517@redhat.com>
Date: Tue, 20 May 2025 12:00:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 11/15] tcp: accecn: AccECN option failure
 handling
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
 <20250514135642.11203-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -603,7 +614,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
>  	unsigned int i;
>  	u8 *ptr;
>  
> +	if (tcp_accecn_opt_fail_recv(tp))
> +		return false;
> +
>  	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
> +		if (!tp->saw_accecn_opt) {
> +			/* Too late to enable after this point due to
> +			 * potential counter wraps
> +			 */
> +			if (tp->bytes_sent >= (1 << 23) - 1) {
> +				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
> +
> +				tp->saw_accecn_opt = TCP_ACCECN_OPT_FAIL_SEEN;
> +				tcp_accecn_fail_mode_set(tp, fail_mode);

Similar code above, possibly an helper could be used.

> +			}
> +			return false;
> +		}
> +
>  		if (estimate_ecnfield) {
>  			u8 ecnfield = estimate_ecnfield - 1;
>  
> @@ -619,6 +646,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
>  	order1 = (ptr[0] == TCPOPT_ACCECN1);
>  	ptr += 2;
>  
> +	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
> +		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
> +							    tp->rx_opt.accecn);
> +		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
> +			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
> +	}
> +
>  	res = !!estimate_ecnfield;
>  	for (i = 0; i < 3; i++) {
>  		if (optlen < TCPOLEN_ACCECN_PERFIELD)
> @@ -6481,10 +6515,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 */
>  	if (th->syn) {
>  		if (tcp_ecn_mode_accecn(tp)) {
> -			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
> -
>  			accecn_reflector = true;
> -			tp->accecn_opt_demand = opt_demand;
> +			if (tp->rx_opt.accecn &&
> +			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
> +				u8 offset = tp->rx_opt.accecn;
> +				u8 opt_demand;
> +				u8 saw_opt;
> +
> +				saw_opt = tcp_accecn_option_init(skb, offset);
> +				tp->saw_accecn_opt = saw_opt;
> +				if (tp->saw_accecn_opt ==
> +				    TCP_ACCECN_OPT_FAIL_SEEN) {
> +					u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
> +
> +					tcp_accecn_fail_mode_set(tp, fail_mode);
> +				}
> +				opt_demand = max_t(u8, 1,
> +						   tp->accecn_opt_demand);
> +				tp->accecn_opt_demand = opt_demand;
> +			}
>  		}

Too many indentation levels, please move into a separate helper

/P


