Return-Path: <netdev+bounces-210377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8EB12FD5
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468A7189769B
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E31547F2;
	Sun, 27 Jul 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZU9gNhvf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB81D6AA
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753625873; cv=none; b=dJqgFeLPi0AiJVbc2XKl2AiQdNIV9+HctbsDpBnM5YoVAs7UWKuWmM7sQ7Ms8LhV/N2PMVdadDFr3neczN17yMHfW9xAv78pdY5rIgdCumlVg5gOputzdi850lF59ppyTkgYYduElRkdok+3hsa1ZfiNE5lnbfrjlOZjZiGZ8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753625873; c=relaxed/simple;
	bh=e5fKeQA/w6fVmtZ0grgAly8zXMb7UoQ1kyfp5pb23A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExOFXGsqRC0e6PLnSJYki9bDBhDJeFFZwm2PkBIwT10obM48UtlUigPo8kSJtNGQPVtBfmiaWjtbwed0/sR8hV5clpxkgnMea9u/tLfZ33GtxAEk4JK5UKe/GF9W/1gZsAtHJwB6gyx4Fc3pFNbVCBUakYHQthSWRJSlwFxHRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZU9gNhvf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167b30so32444575ad.1
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1753625871; x=1754230671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHk2qjwxKEyKH1zEFcYUwnej1YSve1frFngqFkZe3iE=;
        b=ZU9gNhvfq7W1yLqPHfqz8Jp0R8jHTcx3+vugR0cTkYKaVWRLYATFlCNFYd4Mzy8Mbu
         9qvOzBvULVurrII6QjmQ8eq92DHuQmcW1WZ7xutl895+6zKf+PAlG2ibSKEJWW/6DQJC
         1QNHPfvBz1NAuOSng8pHpyc+1+WwzjoP5wPurVSVFcRmzNRo68VM/CsI/N0Kou7BuCzI
         PTJBQHYQ5tHMKF3/J8fs3fQxgY9WnLloQCPCdTE952RRHldJCBKLWfpM8yjapUEdfqV5
         ulDGI0nybtOYjJkbD/OOjq5HyF6sqyooPLNbMe3xoduOPwy0zHFrmw/qCGapoZ6QPbgV
         yPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753625871; x=1754230671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHk2qjwxKEyKH1zEFcYUwnej1YSve1frFngqFkZe3iE=;
        b=ZDd6tEUy2q7XVBILRZFzU4HEpIgi7HsH9efxkE8NcRxG3kmGv6FRu0vY/hlf7hH2r6
         gDEJziwxugiNNxQ9YoXek1xjaVUwguAHAWSBHP6vdSqv2soPMXXWBv7ASNivB5Gzfffi
         qenpjuOuz20WIirbsEcjj8n393Y2rOcum2uqZxqR5mi49oOLpOqdvri3h4pc1kfiCZgB
         SuXMRAWgrmlpQv+/4X59uoiEL96aHQdeCk7kx8dH9bV/ch+NG0qoaBRGUXCCaAmzQKL4
         LSUL2jt0XgR57CXK/QK2tr4w9QdjvkjszPUWSUMWye0rSTSvc2+vGkzTzZXp3GGw9OKG
         P73Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgvIHZNEyjKGs+NUITp5Sxbx7LxS4ItKGBWca1FOKmbScDlMHAlV440CGUE6y4cZiVkdXFcaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68AG8XqVK+LKOVltc5bI+kDAdRGyv6p9GWgkGryGFCzJlT+Ro
	2yuaPfZR8U/tuc9rAtxPii7yznskYdKCYu8T26bKEU+koctye6ZtNGrNnMRmtz3OKQ==
X-Gm-Gg: ASbGncv7mkQIRkM8trskyBXRYHkokhzIPXW+yXdHgc7H9f3oi3gNF3oEh5fc1f/6mXF
	RF76IiCilKDlbJM4TbRJopCXRV9nkpX5rpM8JwSwBCWhtf7g+PKJhWpuYSlwoJ4jVebwCucfmpG
	lKFhkYw+bolpf7X3vhYU1/wJYyp2ku8QRoX/TsRU3pS0LJ7tHIsJ7kY+H5kjK/E0F224ff+UbsA
	lNYtdGNRD+OQjB2fVtXe/azQAsVYVMBRGVOdcZZeHvZOE7vKjqsd8Yk/4oOOuPPemF2U4cRoLwK
	ACAQHPwVn+dnuBMXi4BZbYheXW6r7EOwxiT1JJxqvQKwC/uJBokRr7hlCEiVTe3Mhtq3xWtWarU
	fTVlALjvUexzpUXW34Ppu0uKbfiXQ8EzjhKN7+Q4OuN12Bl606vPq9vBr/FC3QJnJqA==
X-Google-Smtp-Source: AGHT+IGlJ+n9MaG4sRBkhB+GlJ74Zvs26zBgTsFXKI5TSWkpHhxsIdcZcbpk9Fn12sG9TXNl8rnvug==
X-Received: by 2002:a17:902:dace:b0:234:ef42:5d48 with SMTP id d9443c01a7336-23fb30d1a68mr147085675ad.38.1753625870551;
        Sun, 27 Jul 2025 07:17:50 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:526f:d2b0:a10d:d6b6:fa3? ([2804:7f1:e2c3:526f:d2b0:a10d:d6b6:fa3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9268ad3sm27778145ad.152.2025.07.27.07.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 07:17:50 -0700 (PDT)
Message-ID: <23059ce6-54b9-4788-bde5-013a6781e57f@mojatatu.com>
Date: Sun, 27 Jul 2025 11:17:45 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] selftests/tc-testing: Check backlog stats in
 gso_skb case
To: William Liu <will@willsroot.io>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com,
 kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, savy@syst3mfailure.io
References: <20250726234901.106808-1-will@willsroot.io>
 <20250726234936.106930-1-will@willsroot.io>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250726234936.106930-1-will@willsroot.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/25 20:50, William Liu wrote:
> Add tests to ensure proper backlog accounting in hhf, codel, pie, fq,
> fq_pie, and fq_codel qdiscs. For hhf, codel, and pie, we check for
> the correct packet count and packet size. For fq, fq_pie, and fq_codel,
> we check to make sure the backlog statistics do not underflow in tbf
> after removing those qdiscs, which was an original bug symptom.
> 
> Signed-off-by: William Liu <will@willsroot.io>
> Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
> ---
> v2 -> v3:
>    - Simplify ping command in test cases
> ---
>   .../tc-testing/tc-tests/infra/qdiscs.json     | 195 ++++++++++++++++++
>   1 file changed, 195 insertions(+)

It seems like some test cases broke in this new iteration:

# not ok 670 34c0 - Test TBF with HHF Backlog Accounting in gso_skb case
# Could not match regex pattern. Verify command output:
# qdisc tbf 1: root refcnt 2 rate 8bit burst 100b lat 0us
#  Sent 98 bytes 1 pkt (dropped 0, overlimits 1 requeues 0)
#  backlog 98b 1p requeues 0
# qdisc hhf 2: parent 1:1 limit 1p quantum 1514b hh_limit 2048 
reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2
#  Sent 196 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
#  backlog 98b 1p requeues 0
#   drop_overlimit 0 hh_overlimit 0 tot_hh 0 cur_hh 0
#
# not ok 671 fd68 - Test TBF with CODEL Backlog Accounting in gso_skb 
case# not ok 671 fd68 - Test TBF with CODEL Backlog Accounting in 
gso_skb case
# Could not match regex pattern. Verify command output:
# qdisc tbf 1: root refcnt 2 rate 8bit burst 100b lat 0us
#  Sent 98 bytes 1 pkt (dropped 0, overlimits 1 requeues 0)
#  backlog 98b 1p requeues 0
# qdisc codel 2: parent 1:1 limit 1p target 5ms interval 100ms
#  Sent 196 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
#  backlog 98b 1p requeues 0
#   count 0 lastcount 0 ldelay 1us drop_next 0us
#   maxpacket 98 ecn_mark 0 drop_overlimit 0
#
# not ok 672 514e - Test TBF with PIE Backlog Accounting in gso_skb 
case# not ok 672 514e - Test TBF with PIE Backlog Accounting in gso_skb case
# Could not match regex pattern. Verify command output:
# qdisc tbf 1: root refcnt 2 rate 8bit burst 100b lat 0us
#  Sent 98 bytes 1 pkt (dropped 0, overlimits 1 requeues 0)
#  backlog 98b 1p requeues 0
# qdisc pie 2: parent 1:1 limit 1p target 15ms tupdate 15ms alpha 2 beta 20
#  Sent 196 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
#  backlog 98b 1p requeues 0
#   prob 0 delay 0us
#   pkts_in 2 overlimit 0 dropped 0 maxq 0 ecn_mark 0

cheers,
Victor

