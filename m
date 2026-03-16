Return-Path: <netdev+bounces-268181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCbMDTcZuGn/YwEAu9opvQ
	(envelope-from <netdev+bounces-268181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA85829BBDA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22A4F3027971
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D472EF660;
	Mon, 16 Mar 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DcI4vo6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CB2ED846
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672683; cv=none; b=cWvEQs4WN+UXyuQ905QYZLGCnQ4nRK6S3nH9eIW5C/Fq38YaSxvBFhOAIhEWHhI7eB4591Af81CwDhQnfli/J8wlYBkah+YdYUrJ6FCQ829kNpcQL9iSZyTp4QKrvV3XWLSwsO8rF9pQnmnvX93O7xBff1+WNE6X2z1YPgovSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672683; c=relaxed/simple;
	bh=JOC8TluRZ5LfoZmQsiDxTcli1TkS+BCArlTy4qOrkrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcGxGtykdenKYfhaopvzu7OaygR5KjeeTiJ3C91teraqTiLFBwVIP/uF2ggdwDz+HdPtZe1T39yHPxlHpBk1up+CLd2mbT6MnuDotA+/XXBAg1MuFlT9E0oCzjlveE+OaRHihrkg7EUSGaDWfQAaWtoiND3ENjhZZBC936B/izw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DcI4vo6b; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b9b1900bso3033978f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773672680; x=1774277480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MCrOxQ7WUV2RUMrZWJgAQ3A3Vue8UTWjby4ddZSv+WA=;
        b=DcI4vo6bOHdXoF7fstUxv3qj/xqXzPwjmrDlUiaUIfZaTbt/2jsfZa7KenmwNlklOf
         egbiDVMPOA2m7vX1CXoQLAUZFelc5nR2Wiuj4JJRRljgeUlKxkT0mM/9cQSdkLqJBjxL
         nHdjXO40kp1R7NBrfpNYZzBRAKQv0D2shBUonT4vfXCArkIzZ16eCTzas4Z0hPlgKMk9
         PDEchjA1KXEu92Q1UwheKM5OcPW4pIXhOtLQn3jFsi8zcSDp9OxbakuhEZCU9w33ecj6
         gMcVLlyFexfVPm4OMr2EGmEzwXeAWKXOwO1jk8Ytx4i8NNX7NzwPK4A8LAdHMTAB+gnd
         Tsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773672680; x=1774277480;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCrOxQ7WUV2RUMrZWJgAQ3A3Vue8UTWjby4ddZSv+WA=;
        b=V1Rpu2SlzsdICOZnW/nz67igxByl0c/x3bezLPk6V8EsaG9wx4I2A/n1IpHVeGfnr/
         Z9oDe95XKyjKIrD9LRervzEYYh0olfSP6zvvRfR3b8Vpn3VuYbZ9cde/IICpDXLudbnv
         NjPf/kcSNFohkY4s2lN0e4oDXLfH6q7BCFIfcvSlYpBaJQOxTWByTkc7rXTpN+fuPzJr
         KB5y731C+qInVOShjJIoIuS+Aly+a/V3/99A8I52ZLCnUP3vtMGlmJqvp2JBigic9ER5
         930HVcEsixH/xsbMv3WuZKyIL8ofYQW6h1dNfQjmJ/sTDqyuBVZtqVDEs2cbhup7Amk7
         mQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCWt7JI08jqfXEgyMfKdAmEv+M76JffrYMq3sAU3qoM/00MXJVaJbRMzDrRCOUXUffFK9jbE/H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8rl/zxubk9U0A5IjJYDvrdEV3126n9+HjcwtWn5GE1BnBsYn
	SHRTR6KfIMuvC0kpwi4ACez+iBMgdDNnt39koOSr5TmJS6YyKqUuNZ1IZu9nCcskLSBqCPbUJnO
	sAW6T45Vm9lqjw71Wu8pgomXFUe+qszivD1SxNPngzTtugBVdeNU=
X-Gm-Gg: ATEYQzxBINgEN8SKNU6BIBgVvkL+R5KaIDfRR2iNOJWgFFQm52QtmhUzaOyhHUaTS0a
	/6AgcAi9otVj/IIXgbAYAd7IartdO4AlYcnoGT61Tpta0mN5WYrj3Rkl6KvYA9OgPBmGJYt+cHt
	L131BUiyuQM1nHZyLCbc05nvuXfZWn84szhNanouuDmtonAFQ43TAtkXyQonYMZSBt5gBEtwwVO
	k8/SpmVypV+VCStpJVQ1gsf5g4vzstdoyExxsbUaeo6erJzf1UZXL7PvYXSn0YSGlCT0BQs4u6E
	JFiBaOLtcA9CdKkc+P1Ec5oBKlTkjuAT0lreg9MIr+kEqBOsr+DNzn//jozSjdSeLL0s7X/liBL
	Mrl68jmwiAnEi/0RoSq6Kq9V7vDJd9aV39TrrsOuZGUWQHRNEjmz1QwOhibRyCCv5jmIqgb4etr
	5PA8y0dU16jo1nefHqCEjpAPVk+fCY5zkKlLgwjjvKEijsFY5ZD5n+BtuMSMySjvHMuqdVwQ==
X-Received: by 2002:a05:6000:2403:b0:439:b564:7a71 with SMTP id ffacd0b85a97d-43a04d782c1mr23135253f8f.1.1773672679557;
        Mon, 16 Mar 2026 07:51:19 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:ac7c:99a7:e90:f86c? ([2001:67c:2fbc:1:ac7c:99a7:e90:f86c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b468cf785sm4968408f8f.12.2026.03.16.07.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:51:18 -0700 (PDT)
Message-ID: <792bf7ef-6a0e-4929-89d1-d8ba81bbd7cb@openvpn.net>
Date: Mon, 16 Mar 2026 15:51:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] pull request: ovpn 2026-03-13
To: Jakub Kicinski <kuba@kernel.org>
Cc: ralf@mandelbit.com, Sabrina Dubroca <sd@queasysnail.net>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260313205139.2950-1-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-268181-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Queue-Id: EA85829BBDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub,

the AI has identified a valid issue in the commit message of patch 7.

I am gonna fix that and resend the patchset....

Regards,

On 13/03/2026 21:51, Antonio Quartulli wrote:
> Hello netdev team!
> 
> This is (yet) another resend of the previous PR.
> The selftest Makefile has been adjusted and we have also
> addressed all AI's concerns (some were valid).
> Thanks for pointing out the nipa URL, so that we could
> double check the Makefile locally.
> 
> 
> This batch includes the following changes:
> * use correct constant when declaring nlattr array in ovpn_nl_key_swap_doit
> * use bitops.h API when possible
> * send netlink notification in case of client float event
> * implement support for asymmetric peer IDs
> * consolidate memory allocations during crypto operations
> * add netlink notification check in selftests
> * add asymmetric peer IDs check in selftest
> * add FW mark check in selftest
> 
> 
> Please pull or let me know of any issue!
> 
> Thanks a lot.
> Antonio,


-- 
Antonio Quartulli
OpenVPN Inc.


