Return-Path: <netdev+bounces-227620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306ABB3BA1
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 13:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B32A3BC2F4
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E930FC00;
	Thu,  2 Oct 2025 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AmxaJkEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE430DECF
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403977; cv=none; b=bykY1rjBf7HmQPWWEKQPYThADxHUaV0uvYtsu1rWUC1R9JTxnuh5KS9fGgvg/ezh68+piSuAXhgXBCqKftETe5gmRg3nS5skAbRaH+IjVN/YtMzOkcnIrgmFlC8/1fahJUeuBcJEL92nC5Phc6jX5/9EhbI/JiRZh9bUBW+I0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403977; c=relaxed/simple;
	bh=jnW0WHk1GTDuFbQivtHLAaEF0gM8WzI1319yM1qoIno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5INHG1UIKBX+xYr/TGFEwY+IUlmXLfuuEvg+D8u+QWPLpxTanEVDqBNLH8bUbYQbUjOsIgpIyI717a29drE4/UV+o1WH/mCOPZiqCgFsm/mAjR/4staJ+zzpjLiUno4kwU0TblFrEZNko3aU5uPoSZnPntk8Z3tL/1fMdHrPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AmxaJkEs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so7654455e9.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1759403972; x=1760008772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMea/o0YACa6PU/JEYi87hdh+Mb0Ql/ZIbRjPDYQCy0=;
        b=AmxaJkEs4l95ZNxAlfGCdR6U4Qb1+3E+OITVy0MqWgXeSbYgrmaMrIseG/6ETUUh/S
         7ukXxb+DLQ2hozO3oH7zS1N6LEkwZpRLXWThI3zhxpcY8aiFZuqCsoDgMv6rpaZrPzO+
         DUsJAUqgCxXeJdPzAv1wXfQ/ArT1p2LjI67lo0egegC0RzzjP0fclubmErZpE8t1lSuD
         mmdIVAGzU38pJx4GQr5HZcLshzFN6qBYtAzw4MK+Qdi1/TsfX9DILEhVCWn/6lrlXt7t
         LlUNSv/SVl/ImnwfGI9zAIWEdypg7Qx7tKL94iGMLlXi+MxlaREGYEjNQvDfYRscWUGh
         1kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759403972; x=1760008772;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMea/o0YACa6PU/JEYi87hdh+Mb0Ql/ZIbRjPDYQCy0=;
        b=EWrfYJKEfCspHuYiAx1JgFKsA3Qv+aRY/50Y0kuJlnMhKWEvz/Ep4Q/CSOwAVLVOqf
         W+xAbkmN2IRzfSCKxjbgii6xZW/nJkkX1uRTU95d2tz3VGwBJvrUAiqdcT7Dqxez5h+X
         MJ1Ry4fS0xq00CQsxhQH0uVeNXaVb2TBpw9xjMDZGFlMf+wWhw5AHQpmRF1BszVeORkC
         WCZ64MlVa7YGNa8nWpK67ZX2LCcGmEBfEx61lu3t+o7EMhYYN3PCvx1DJHqYo9bTpOIt
         DmnHFxFWm4F+HdS10FtrtUGm9yVeMiVtcjb0rOgVPLIiaObq/pJR8YzDCoaodAVoAckz
         TdZg==
X-Gm-Message-State: AOJu0YwyhPB2HGTwtE4FayfAqZmqGFcek5Q1EPKdyk7MM3A6xt1HXEvL
	+kYgnaG47PIrmkCYxhx0LBcVq2niD5MjGdoO89cZFeaHs42uMQ5TkZKcN4QL503d1FjRk/Gil9x
	boOsd7dB2JaHugFPtKQnCyY/EpCBWO0OLSpxBQ4x3mAdltOxXL2A=
X-Gm-Gg: ASbGnct2n2kPL2L3y7ZH/M3ZrHUQ+pE2NOpo7R/6yKcRMUxD375btbk7qdOpfmOhJN6
	PE1RbnavqNKx1Qepv35Tf50X7WWJyvIZEqnl/cN4QR1DKJnDmTpuqmZVoL50G6DP2P8brcUKquC
	latxdJKgm5/gSVjgcf20KF245RMe6Do4JGGVNOuvmyYV+FtB8G0nA0qr5m6vHGJ62ke9xTPYOph
	Dxdi6tJDzUL5LRpKFc8a7IsdJGWb2DUOxiUQkAiajqFo8PbytckxwvxbKvUtPCOqmHfalLVufjG
	0wEix/8NOocN3Lo1Idzmgi8Pfp8Fe7SXhF4hlGQpjLYXjuo6uqjFCUD7fbpJ3XAyJBLx9o9fST3
	rfILCy2sXJR35QWOTCgLkhPiHgr7DifCBXVvM34v+bdqUkal4Vp33qfX559YGBPw/MfcrP+OvI4
	lwodOn1ISYyQ==
X-Google-Smtp-Source: AGHT+IFHjRrAgQahzC7e/Z+ad8H1shbYDsTGKyNANpwhGEYiMDTuEHKQ8Zb9f1126LzKrRHkTxhI0g==
X-Received: by 2002:a05:600c:8884:b0:46e:652e:16a1 with SMTP id 5b1f17b1804b1-46e652e1dc5mr30118425e9.7.1759403972475;
        Thu, 02 Oct 2025 04:19:32 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9bfe:b0f3:b629:60c8? ([2001:67c:2fbc:1:9bfe:b0f3:b629:60c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693bd8bfsm30851485e9.11.2025.10.02.04.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 04:19:31 -0700 (PDT)
Message-ID: <4099a03a-22ab-48e1-85ff-c8b7d0288e70@openvpn.net>
Date: Thu, 2 Oct 2025 13:19:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: sort configs
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, shuah@kernel.org,
 kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 phil@nwl.cc, sd@queasysnail.net, razor@blackwall.org, idosch@nvidia.com,
 yongwang@nvidia.com, jiri@resnulli.us, danishanwar@ti.com,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20251002015245.3209033-1-kuba@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251002015245.3209033-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2025 03:52, Jakub Kicinski wrote:
> Sort config files for networking selftests. This should help us
> avoid merge conflicts between net and net-next. patchwork check
> will be added to prevent new issues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Antonio Quartulli <antonio@openvpn.net>


-- 
Antonio Quartulli
OpenVPN Inc.


