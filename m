Return-Path: <netdev+bounces-258428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I3jDmagjWky5gAAu9opvQ
	(envelope-from <netdev+bounces-258428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:41:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992B12BF81
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749BB3013787
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35E2DF6F6;
	Thu, 12 Feb 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgYLzNUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0902DCF7B
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889283; cv=none; b=QSALHbP8k8Ta9xJth7EPhsZD4+PjbwiX0KooMy9I0VO91yVT2DvGxtm6i0+3dgqeeEJPd1nYsNGwzHosKZ7aCjUpXtpwQgOsilEBbL3ZQYzg7uM7ORbjpgqkqRqWPsZRLFE3hpnefUTJ2NfWcephNZI1B8vmUwiwHDv3FtYLfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889283; c=relaxed/simple;
	bh=yIY/11Dq1CPkCm/A2dAowYLqnGZWKwSB10TrnqAw+10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nufek9xMaoVi83I0+bO/2Z65qzce7mXqe3YHMSKHLQx5NtIlNmZ3XX51aGJ46f2o+O/VuEXCRUXdPqGz5D8R19qSVWLpI0Nq5RBtRSUt/UDe55vPgt1JR7KZv5PXnrGissqj69rOMd8NEI7rP0ILSEqV4sZ0OW6h8cSKEYOCiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgYLzNUU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-436309f1ad7so4299374f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 01:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770889281; x=1771494081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwjxeLZCnF17rcxqGqeGmiS56iGGEOFnXmQIiNjxVnc=;
        b=bgYLzNUUZD2HqtlSiww6qDfu0GL/itYcSfZ9JKl3P6gq8f3VcXGcQXQ8eXrRWRNnnG
         2KPWACV64CVhls0FL1j421mdxVf5VeDlkUfzxEmzvfH62RsweUL+6WSsrIxpVLAjXgE8
         LYYfyfsu/7f1iNPSU+yCRO8aohRvWbFQV30a93WpBJxWVS+vFquTLmHYI3JDiIpfM+OS
         W76Fyz5xs+Xz4Pruom3UfmA6BAlWZI1ANVvEYsueQIw9xv9N3y7ApRtCO+SF9fNcrVG1
         SJJsohE03108YMOSgNVuM8YqgeYlQjW8jQJ0yjp4ZizhCdAPAljpNb30ZIygNMa9kZTs
         emeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770889281; x=1771494081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwjxeLZCnF17rcxqGqeGmiS56iGGEOFnXmQIiNjxVnc=;
        b=trCC6O0HiruXadGY19BL7B5zC4SUKMpF5x7tIIh6pIeSkyJw1Qp13+UxQydNys8g9Y
         LlWSfZ9jrI9qiKmMVp6X/bWG0pHFvM6ue+yHieKTeqvNUXihi742VtuLbPCHwriw6q97
         HbM7qjD4cscXCm0f2BLSoj6rAGlMdmP7lhsNDIwWLZISLa1Rg5KlX5HEPbVSm8iSZPTQ
         j27JISXxXiQTnX4zJusvKSCppWPaaO2YEkiPGl+M3S0vGh5RWhuRkhMaOfYDQz9xOd6a
         5UarVJRt2LcX5u/e2Tbdr5taInWZ9Ww+Lr78OAKM2lXdUzCsroFFXwVpZtIfIT41cwhS
         zY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlhdsw2FLihrqzWvQzyJPhsp62vvnD5PW6XV5nHee4koziaVEqlTDSHzd+Y1zV54nI12E/wLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlu16xXKcgPISOr238lquVO0eo+4oI+mkREd8q9Nt2w9Ebdtsz
	gSegqA5Uyh8MAcsuD9sd1XPdAt8gkY3fAkBH7plY1BJXd8Oc4jXUBRJ4
X-Gm-Gg: AZuq6aIv9jlSasotx5RUvzjQUbNpee6WTPMzmjvjCIBCVfpjtv8ED6OLfA5CDfyTk/7
	U0O0Y7ClkkF5/3jqL3t8yxoj4G/PQN+4B18UyWBoYfwUada7NC1cXCMp4M++PSlImnWq1jU0yLe
	05HiCUEEHqyThxqXlsmpGi97D5kpkqx5J5WI5m7Dl8JSkocwDUWv7qIci5xnY4KSMDpo25sL0T9
	ODB5b95qNVxYrq7GVpd2qo6zAoC4vnBql6RSX8ktLgsO32xan5XpDWBkPMurv3P4JH8izaCt7Fx
	asQmZJ6Hoo+9GcepU+oGYgf8hZpahOTPv1VGPC2SWlvyYZiI3M7qazndFlNoqX4dRszJ6aG0M/c
	eRJw3sa5ftiXah2OGbVdbgc3n2E6p30QjNlWqyxI6gPphMNybFix7s+XCge1J8K0dxcl2IVscL/
	C7qzSfbWPzfA6xuBFIAgif+TbyVhlOOtcIvYqAWIUQQYp3BQ==
X-Received: by 2002:adf:e50d:0:b0:437:8ff8:fea3 with SMTP id ffacd0b85a97d-4378ff90099mr1644282f8f.21.1770889280803;
        Thu, 12 Feb 2026 01:41:20 -0800 (PST)
Received: from [10.221.203.72] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5c550sm11501359f8f.36.2026.02.12.01.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 01:41:20 -0800 (PST)
Message-ID: <dbbe9690-996f-4a63-90a0-baec52c27236@gmail.com>
Date: Thu, 12 Feb 2026 11:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: rss: validate min RSS
 table size
To: Jakub Kicinski <kuba@kernel.org>, Yael Chemla <ychemla@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 Willem de Bruijn <willemb@google.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, noren@nvidia.com
References: <20260131225454.1225151-1-kuba@kernel.org>
 <9f535014-80eb-4f57-b047-3638579bde9a@nvidia.com>
 <20260211134319.39710c1d@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260211134319.39710c1d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258428-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9992B12BF81
X-Rspamd-Action: no action



On 11/02/2026 23:43, Jakub Kicinski wrote:
> On Wed, 11 Feb 2026 22:10:56 +0200 Yael Chemla wrote:
>> Thanks for the test addition. I wanted to raise a concern regarding the
>> spread factor requirement that may apply to mlx5 and potentially other
>> drivers as well.
>> The real issue arises when the hardware's maximum RQT (indirection
>> table) size isn't large enough to accommodate both the desired number of
>> channels and a spread factor of 4. RX queues/channels serve multiple
>> purposes beyond RSS - they're also used for XDP, AF_XDP, and direct
>> queue steering via ntuple filters or TC.
>> Artificially limiting the number of channels based solely on RSS spread
>> requirements would be overly restrictive for these non-RSS use cases.
>> In such scenarios, we'd rather have a slightly degraded spread factor
>> (< 4) than limit channel availability.
>> We'd appreciate any feedback on this approach.
> 
> That's fine. In fact IIRC ixgbe (infamously) had more queues than
> it could fit in its RSS table. So none of this is new. At the same
> time if user _does_ want to use a lot of queues in the main context
> fewer than 4x entries in the indir table is inadequate.
> 
> The test is based on production experience, and provides valuable
> guidance to device developers.
> 
> I'm not sure what you want me to say here.
> 

No doubt that larger factors help overcome imbalance issues, and it's 
fine to recommend using 4x (or even larger) factors.

The point is, when this comes with a selftest, it's less of a 
recommendation/guidance anymore, it becomes kind of a requirement, an 
expected behavior. Otherwise the test fails.

This ignores multiple other considerations:

1. Existing behavior: In general, mlx5e today implies 2x factor, so it 
would fail this new test.

2. Device resources: In large scale (high num of channels, or high num 
of netdevs on the same chip, or both), it is not obvious that increasing 
the indirection table size is still desirable, or even possible. To pass 
the selftest, you'll have to limit the max number of channels.

3. ch_max should win: Related to point #2. Driver should not enforce 
limitations on supported ch_max just to fulfill the recommendation and 
pass the test. I prefer flexibility, give the admin the control. That 
means, driver would use 4x factor (or larger) whenever possible, but 
would not block configurations in which the 4x factor cannot be satisfied.



