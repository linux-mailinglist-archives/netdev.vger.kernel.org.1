Return-Path: <netdev+bounces-184277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4FCA941F4
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 08:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FDB1897AFE
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 06:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF087175D50;
	Sat, 19 Apr 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ruL31zuG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7E184F
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745044923; cv=none; b=G/AxXJIU6/ekRknV4s4cqDUri2363KTkhnDr0XAx989KulOfcIl+ITYIbZF6hJHRBeqv/974sjHhxpVINueK+O5SOy2lH7DnS+EBUZFW1hEW9KEH86AbVFDcl5IXMJP5NrCUgCl/5pd9ZZ6ACKGzDXPELXNmJmscWBXsdJt0RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745044923; c=relaxed/simple;
	bh=dwfegz5E7yhUv5wGWmn8LAB/4tuZa5IyvqOOeH42idE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSvgxjkJBMH7WR+YvuMXh6V/DQoYffT6KmJZBz3sjHtZzpIvhmjzkAeXhOIQH7GAaa/hKjOpLD2zdDXQ3YTNAedu/rui9vClfRR0ijG2rud/Qeye6+Wj5HCo008oSss1ly6txiBQLmLXFEuiNLwNt1lc4WedABdGLNJ1hUNi89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ruL31zuG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so440077466b.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1745044920; x=1745649720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CcAbqixIuGQqthd7kNH9FiBKY02ut5UY/pBA+EHL5U=;
        b=ruL31zuGwxhiEsWxgnwRCWSTfdL8GWx6/Kl0R965SltIMbrB7fn3Y9HwzJLA76KxLt
         bkRvQafAYCyUiHU3QIwnYZbru8owCw8KYixtsbJ9vl9Rpxw+Xov+a8joNtfvoUbCGSw9
         pGJE1XOVvaXiiC04GXd462CfSSzDxEmAvgjX2qb4HeaevSNXshmsmEc9tERteoirwVkW
         6mf7glEXF4fF4DISnlAMu+zDB+Vt323YktUqprqwNM5b/AvPNVNOs4Sq9PpMuzi6Vtdb
         NrZ+glLHwv2pGfLy1WvEer6Ul8tZKcL9maAYxCoFLJO9uDuCY4PNF+wkTn45hsBd2rNp
         ckpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745044920; x=1745649720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CcAbqixIuGQqthd7kNH9FiBKY02ut5UY/pBA+EHL5U=;
        b=kZE2xKXIzyUrvmGtWs/LMb1iSkMwpp5FClWDYmtbhWly2DGItu8v4JdavgzSran/L+
         fPIHpEyaAQfSOTC6H2NZjeKZELdxBKktTjYQ9dYm/uZG/bKG3C9Occ04usJLnJ60jbLF
         Ako+2fgipozSXhcMjRLXTrleIi95slxm9DuFWm5H1BhFeGftocfPlK9fzPPjgu8ZERIC
         aVJmUp7d12TiJ2e0tlZvYALS/6ohRYcUpmtAPyZCtC4384YGSWZuyr0VOzVNkjM0sb8J
         TlDNCUw4/apRnr9QyirqdLjClmCS1tYaGudbiEz1TZ3Lx7m8JV1J/xZdiXnX83XA7HTG
         qzjg==
X-Forwarded-Encrypted: i=1; AJvYcCVmQC1f802XtkZ68jdJPifBEI7Xcmq8k8vKZu0jr8I6g6hc5z10CqnISHwlEo57dsuAcndrCX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldRKqswo0azALQGTwce8S+cHSUIrUYtjDqdCCjSqCy7SmviGh
	NFRokfW9IU5lxJln8z38AH3wqM3jBfBlA66Gvqk/9ZSyYod6QGOgejNHJ+pZ7RY=
X-Gm-Gg: ASbGncsED5as5AkncVx9menmvlBPWwmHxW51B6mfkfPlbbNElMugZEkQDvVdu1USgh7
	+gfo8HDrUXTpmi0q7Y3y/ewDELLMVHY90ICJH+nCAGCxaCZGTQhHof0Xwat32ZDa9jGf8toj7AV
	w6qni/MztkoE61RmSbZYggJojD1RDNou0iBv2DqtPCFpkHkBGVXqzM40Wrqal64aP+rJ/FiVYcx
	V013qIEb552zgEeEXXcyzRTudM7Z7dqX0iD28py2+btu+JYtz4Y/n1Q2IIBldMA2mfehJ60tObX
	AnEi71nLYklB4S7ZmgPzVaFAPSj6mGHvIX2hPbGugSTzdhpmYJt2emXRXk00moG8YS7kT2JsKMy
	2NC8YKGk=
X-Google-Smtp-Source: AGHT+IHbtfuzzLcA2xcM8p05Ap1rPOFlrdSx9BRr3j8cL7IztIjuqPw8h7MzO2V1NueWtCGUqsGoMQ==
X-Received: by 2002:a17:907:2ce4:b0:ac7:3323:cfdc with SMTP id a640c23a62f3a-acb74af286amr415673366b.10.1745044920282;
        Fri, 18 Apr 2025 23:42:00 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcf76sm222642266b.100.2025.04.18.23.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:41:59 -0700 (PDT)
Message-ID: <c10c2e0b-3243-4f48-9795-6c31d98f97f4@blackwall.org>
Date: Sat, 19 Apr 2025 09:41:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests: net/bridge : add tests for per
 vlan snooping with stp state changes
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 Yong Wang <yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1744896433.git.petrm@nvidia.com>
 <cee6216f125ea6c829e22c879b47a47c14db9af7.1744896433.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cee6216f125ea6c829e22c879b47a47c14db9af7.1744896433.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 16:43, Petr Machata wrote:
> From: Yong Wang <yongwang@nvidia.com>
> 
> Change ALL_TESTS definition to "test-per-line".
> 
> Add the test case of per vlan snooping with port stp state change to
> forwarding and also vlan equivalent case in both bridge_igmp.sh and
> bridge_mld.sh.
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../selftests/net/forwarding/bridge_igmp.sh   | 80 +++++++++++++++++-
>  .../selftests/net/forwarding/bridge_mld.sh    | 81 ++++++++++++++++++-
>  tools/testing/selftests/net/forwarding/config |  1 +
>  3 files changed, 154 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


