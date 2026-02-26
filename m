Return-Path: <netdev+bounces-261378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIpIKrlZoGlPigQAu9opvQ
	(envelope-from <netdev+bounces-261378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:33:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B83691A79B1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0151D30B7A89
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174EC3B52F6;
	Thu, 26 Feb 2026 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRS2lvn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1B3A1D05
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115114; cv=none; b=rM5K4bN55qHLseVbO2AJfAX3f5Ks97uOvx3NysLFUXiFNvDlcu5BS79j8zXKOyrwZ5GtbflzJBT8FjfVIrHSq1CVNW+8QmCXf8JV8AqE2R+7hXdziTuo/LYPJ01PhF+1WKmN0y4CIQXVTMKS0/4qNaEZAjWXjTzxq3AuDrJ0dhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115114; c=relaxed/simple;
	bh=IWJI96C1hm5T5E8JU3McSYrn42gSEdOiuSDzu++GdB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulk1IFwEQjLiVlwMy7DURhkUrqzUZjmI+55Y+z+PlrmuyJOAqF4wwmCzhnU0+rl6Zv3F6I7OKX0TGvqGMei1j9gx+Sn1IdCYbhQcciVUmoAlm+5R3049E52PMMQlOqoAEGiYmsFa4ZUuzsJ+wry7f5UHKoU5EeAjc3jiVeNCyCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRS2lvn9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4833115090dso9568155e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772115111; x=1772719911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elBwMb4z5MofDN6jcMpR4NV6A6fCLcuI5CqbFDS4134=;
        b=nRS2lvn9hoXh+cXMIYLN8219IZ+Mrp3hBhk2CC3ysDVb+OjKrRxMTd87Ll14JQg6VH
         gNYf6Mp1wUqLGD+9mLDdZb4WP5mgdq1gBky4tELzvYAml+Lf8EZPIaLxFYF9UkRXXlHQ
         /0Kzp2aCCvo7r5tmYg4bGnqQDldKSjAZc1fU6EKEjGqpjIP4gfZtwiIrSZ1lvRgKryoS
         d76WYTWu9X4Byb15QNSRXUVv0NudOmAjw3KVu7uEYOlHxoQh+jLibM/N+PWRoPWqEOEi
         z/WNrGzFYzFOXsz2cR5biuckptWd6/PQ8yUAO5ALi4G06nzj/Jxic7mvgX1iL0/TpIY8
         YJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115111; x=1772719911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elBwMb4z5MofDN6jcMpR4NV6A6fCLcuI5CqbFDS4134=;
        b=fM1tcTrXH7BlGiGW0C11AZy/NMshUFD0cFIZcFQJkkl3c0rspWM6yvHBgvIsrLMrka
         FN1/T+0LFQnQlssuBhyHEfy9qpQOt6QE+q51aKYC+8HaPd06urkRwKqVqfD+vK1qKtyy
         qVfmHu2DJr5UZbMBvp59ngOiCJwKBT0YRwvIDpUqfxVf/S5v48JqYwAB6TYbukM60jv1
         gLEDHQNvp+2D+kM3991j/qnNUDOHxJqJ5TB2rLsVhI91lFD7eo9WeDvL18xGiHXPz7U6
         1/Ki+bSDYa+ueIUlFc3nWJ6eI2nHsLDjVdZtCPKIvBy7Uljy565BH+Ju7pGZ189Fe+jL
         IIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV32Jj6oaDxRLXglIX1ICACEw7cAZ/nQtqKgPQolOO7M++t85pgoV8k+CfOKSBcAN4hoCLei6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlWs5V9ol/f9QM88ZqFQX+OoGmh6pSoz/Xn9s995CXei5hzh1
	ZmzGWP3EjFum/sjBmxVSz345vOjcyoUV3g+udug1Ki6ga47aKykzT5+/
X-Gm-Gg: ATEYQzwfmLqLCKUb1SwK1GmZ9pen0CZU4hNX4Lmm/r3+tVNk+Or09FJQfxOh0S2mhEq
	BCUDrHD8pkLvvuUK0woJcwHek50TYEUm8ftt4aCPVs73ujqCy9CYKSlldT/PXGx1tOZCZYQmiwX
	H/Rc477E4TpT5Vo34rx0tV183dG+USoymdpdsR+e0l62h+LlSLvZ2r8ET7Wwh5K1sF83CeABOan
	7rvQvJBqjdl2ta46Bp0ROWZWf3/8T2cVGAgwAOS5XiN7Nf8OPw4t9cyHIKYwceFz8jVDC8tLrY2
	F9jRMcBKu26vf2U3tOBGOntY4HPnvyZW150qnfRjvseTT+cTV5cjrwcuGEMARhpObE/BI+N5EO3
	HF8aXHgmQ1ErtHw+JLGJ9Sc+GoUzmQYrdxZf+dF8d6qNjguWIaiVQ0tbRGPstdBxb0m2jqWKYCL
	EdiqntvvQLnu+VngWSMY3wh0E+OiSOC20JyqeRanh5sDMpc/7JDn5kP+k=
X-Received: by 2002:a05:600c:4e93:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-483c3df874emr36999745e9.34.1772115110675;
        Thu, 26 Feb 2026 06:11:50 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:2818:da16:a542:ef07? ([2620:10d:c091:500::1:a491])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439899da8dbsm19894484f8f.18.2026.02.26.06.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:11:50 -0800 (PST)
Message-ID: <aed01ac3-a393-486f-9fee-09928fea9a94@gmail.com>
Date: Thu, 26 Feb 2026 09:11:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v2 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 willemb@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 akhilesh.samineni@broadcom.com
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
 <20260223191154.2800616-2-kiran.kella@broadcom.com>
 <0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
 <CAPHeo3eJRYc503Ta24h9r+Uu1cGqb1dCfmnxuZQ4MJLCTFd9Lw@mail.gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <CAPHeo3eJRYc503Ta24h9r+Uu1cGqb1dCfmnxuZQ4MJLCTFd9Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261378-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B83691A79B1
X-Rspamd-Action: no action



On 2/26/26 6:46 AM, Kiran Kella wrote:
> On Wed, Feb 25, 2026 at 2:28 AM Daniel Zahka <daniel.zahka@gmail.com> wrote:
>> The lack of support for netns is a bit of a gap for this feature. It may
>> make sense to see if what was posted in
>> https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
>> is sufficient for your use case, as it handles cases where upper devices
>> are in a different netns from psd->main_netdev.
> Thanks. Went through the changes in
> https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
> It is sufficient for my use case too, although it specifically
> addresses the cross-netns virtual devices use case.
> But the same net-ns stacked devices like VLANs can be handled with
> this patch implicitly, without user intervention through dev-assoc.
> I think both approaches can co-exist without conflict.

I agree they can co-exist, and automatically propagating psp devices is 
useful. I was just pointing out that support for upper devices will 
eventually need to deal with netns, because when I looked at this patch 
things like ipvlan and macvlan came to mind.

