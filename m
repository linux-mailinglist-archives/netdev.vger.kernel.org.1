Return-Path: <netdev+bounces-175764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE6A676BE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDEC16CB3E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722820E038;
	Tue, 18 Mar 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+pL41oC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAEB20766F
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309242; cv=none; b=h+mwr3OUFe0oXhjyb1svs+i4DF2AA2+eT6YWcl6K7oFtir03xkWdJTpMNz4/zafqXCy8WFoC+nUs9Dtzq1EoJA0H8AiDe6qqtmTeaS6ddJGVZf7xcLalnnxJuX1bJFqqAO6Wi6OjkgQIauPdpYWQc+YxpBDbje6f3KktviQHXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309242; c=relaxed/simple;
	bh=2igutHsuDhyuqY+mS9Se6RVpng7XykRfcC0cv+45kv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4MPbkF2QQblVXlC2VKJmKvsy0p9zyQhAqux3fwo44afeMkdSV9WGCgKLd48DadJt5qx1gCfVuGmHNcxYrwFqo/z3+tTUySp0Y0klmkMYsq2mCiMufopeXt+MRsXTI/xnIh6MCWRZazAk84ovYG3PCu//PTHAqiKsqjD2kvfY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+pL41oC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742309240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7O+pdl8v8v7EK7Wkd4nKpzLh6vnro4c8ShYrpyfa7w=;
	b=O+pL41oCMZ5mIbO5Kb5QMdAGjH9NzMRMREEMnyyqZBknhkriJVIwpmxyOZTvBnCM84FQos
	iPlwBtvlqpID0NMfPrCuFFQlrmW6nxHmOB9+0h9vteUVrvR9uVxxkoiYh/r7UV/FCu5Clr
	qOCeAC8uTUP0CAylhUnvvmr9DUD1mbw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-FWVRp9RUMV6MqWKe2M0MTw-1; Tue, 18 Mar 2025 10:47:16 -0400
X-MC-Unique: FWVRp9RUMV6MqWKe2M0MTw-1
X-Mimecast-MFC-AGG-ID: FWVRp9RUMV6MqWKe2M0MTw_1742309236
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39142ce2151so2658111f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309235; x=1742914035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7O+pdl8v8v7EK7Wkd4nKpzLh6vnro4c8ShYrpyfa7w=;
        b=U3++OgZfT/9kdvoXjK1MfVByRWTjMDoIDBEwEm0vWvQv+JWUh9UlGpJP+Y5Z6ThY8x
         oD/CzmiqZCR/bjGmEznV7kIJJlyVeer2H9y5yADiNcVE2XCdfTl9ylSAw49pc6IkX25/
         5x36s/oNrblmDk9pT7XUBR1LG4KT0OVSH7OCl6eWRQ3YSK/PHBejmhk78PDSsbQlWsWB
         VGz0nZlU6ChX3cKAv8fyvgtBbI3jEJmxO9WjKFLVNvjhIyjRDnXi65MqSwaBwnYCwP0K
         k2WIeb5J1NkprENsQOw6PExpejxKkQzEHPVwHHbCR0dnyTE2U+/L8cu8mWwyUNZ7C+VN
         RuXQ==
X-Gm-Message-State: AOJu0Yx22zYmFVfitu/054oT93gIath0y6MCV5Bc0zVRda8ULHU81nqC
	riPQ786Czp0Eo89USw+zjRsDUAB1DIJwIyO225222203M7CF8o07Y/5UqPmepxJ4ty0dio1S28t
	4Yfg8fNdol94+efqm8nfy6XpFm5uOJXqYaC/u7jLE6IfbfzfvRZfsVQ==
X-Gm-Gg: ASbGncuWYEvP0uFyP1hlpHkYiQWaxrZD+LloHIYR0mbSldjZnuJ7kDYPj6MqBu5nEBO
	VYbfeTlvNbnx0VYMcNBj8D93SygHfYVA6aXu1k1I/IS1/bqp7u/8DRpC50CjlkdaVdJtA7q5Jpr
	IwaItrXcoA1Zp9bFBe2elDJ0uSvC86WDtZc9Y5KqPJDmNOKGSjR5JSqYzeLZemQgIYxLTLKDZHB
	1kIaQtdWOhPJ6RJfJLSGXMV1xQuRvK2vkJB56U0FjNCb9kCKTqjlGHjLH6iw/x7GGkauBxhZNfo
	5/GTLobzf40388AqkyUFcZej1WQzqz1/+dvceEe2PF1HlA==
X-Received: by 2002:adf:a197:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39720398c12mr13493657f8f.53.1742309235537;
        Tue, 18 Mar 2025 07:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1+6DV1Pcv1e0dGpotv5cbfi8peLombI/S233B67fHsuG9MRleiVbauAu9kTexCe5GwpJbpg==
X-Received: by 2002:adf:a197:0:b0:390:f6cd:c89f with SMTP id ffacd0b85a97d-39720398c12mr13493607f8f.53.1742309234992;
        Tue, 18 Mar 2025 07:47:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40fa30sm18491849f8f.68.2025.03.18.07.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:47:14 -0700 (PDT)
Message-ID: <a360fcbc-19e5-4ee6-9b80-2621fefd9ad6@redhat.com>
Date: Tue, 18 Mar 2025 15:47:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] selftests/net: Add mixed select()+polling mode to
 TCP-AO tests
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
 <20250312-tcp-ao-selftests-polling-v1-4-72a642b855d5@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-4-72a642b855d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 10:10 AM, Dmitry Safonov wrote:
> Currently, tcp_ao tests have two timeouts: TEST_RETRANSMIT_SEC and
> TEST_TIMEOUT_SEC [by default 1 and 5 seconds]. The first one,
> TEST_RETRANSMIT_SEC is used for operations that are expected to succeed
> in order for a test to pass. It is usually not consumed and exists only
> to avoid indefinite test run if the operation didn't complete.
> The second one, TEST_RETRANSMIT_SEC exists for the tests that checking
> operations, that are expected to fail/timeout. It is shorter as it is
> fully consumed, with an expectation that if operation didn't succeed
> during that period, it will timeout. And the related test that expects
> the timeout is passing. The actual operation failure is then
> cross-verified by other means like counters checks.
> 
> The issue with TEST_RETRANSMIT_SEC timeout is that 1 second is the exact
> initial TCP timeout. So, in case the initial segment gets lost (quite
> unlikely on local veth interface between two net namespaces, yet happens
> in slow VMs), the retransmission never happens and as a result, the test
> is not actually testing the functionality. Which in the end fails
> counters checks.
> 
> As I want tcp_ao selftests to be fast and finishing in a reasonable
> amount of time on manual run, I didn't consider increasing
> TEST_RETRANSMIT_SEC.
> 
> Rather, initially, BPF_SOCK_OPS_TIMEOUT_INIT looked promising as a lever
> to make the initial TCP timeout shorter. But as it's not a socket bpf
> attached thing, but sock_ops (attaches to cgroups), the selftests would
> have to use libbpf, which I wanted to avoid if not absolutely required.
> 
> Instead, use a mixed select() and counters polling mode with the longer
> TEST_TIMEOUT_SEC timeout to detect running-away failed tests. It
> actually not only allows losing segments and succeeding after
> the previous TEST_RETRANSMIT_SEC timeout was consumed, but makes
> the tests expecting timeout/failure pass faster.
> 
> The only test case taking longer (TEST_TIMEOUT_SEC) now is connect-deny
> "wrong snd id", which checks for no key on SYN-ACK for which there is no
> counter in the kernel (see tcp_make_synack()). Yet it can be speed up
> by poking skpair from the trace event (see trace_tcp_ao_synack_no_key).
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241205070656.6ef344d7@kernel.org/
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Could you please provide a suitable Fixes tag here?

Also given a good slices of the patches here are refactor, I think the
whole series could land on net-next - so that we avoid putting a bit of
stuff in the last 6.14-net PR - WDYT?

Thanks,

Paolo


