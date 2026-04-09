Return-Path: <netdev+bounces-277116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF6vLu4L2Gm5WggAu9opvQ
	(envelope-from <netdev+bounces-277116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 22:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBF3CF7F3
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 22:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7843300C7CE
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1230C61B;
	Thu,  9 Apr 2026 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmG/uT3v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1F271A9A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766503; cv=none; b=bP83PDRfTx9FdieCarPokcfhkZu7y3JaZul5EOArVnmzhrpLpD4zmQbmHjH7/mrGRZvAkSvxW7Gf3ywmrfHucYqDWu8xb2GrkSEFEZZWO51puPFdGCozZ+O6aOnxgsVJuOgltCbzYTAVxx+w1FwblaPyZwCYUQVGO3giLPcAKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766503; c=relaxed/simple;
	bh=t17D4EbdduWXrTX7hugrjnsvI2RAttx70eAujI9t0fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wot884FEIjMtpvNscpa1wM/mcTGQXhDM7iRRhVOsp2GfD75km21cgavQyaO9QImivmTkyWOFbhntcZ3OodEvmUjncnYTn2DCL7u+2gQ5RUSlwV7Mqkt1n9kUXRzPs2BBwbgL7cEyHx5huki+SbboV0We83fN9odUQ7SyvwCNAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmG/uT3v; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1785106eec.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775766501; x=1776371301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZW4/FYr/TJOQAnQTjLdgFoQga/P4omv2yM1nIJFsTE=;
        b=mmG/uT3v6j5FGFWbBU8YvBdA3CynvAuqIlkZ1yDC209ldYvYkzay5jwQuQaqdraGls
         eBaaeX/yVrS+m9BlkxTrHTtInilMhq+fCVrHiqRlYl2nkk+ywKL8A6mW+QbbFz/gs9oz
         p2r91brLrQbyKZTTrC7/F1hLchDXolBgeW9ic/kK/waKbak/7h+W9iRQQbdI8VPCS0SZ
         KWuurkULIDIbun+3/AvqvHodVOtEYCI8+WbXsHmWx1hr7o7vrQ6KHEo8znvn2bCIDvVv
         rzOMIgBhmmS/fwkwPYuAflk1qJ7K5WI22NhZ+mSbEtldsXWLiE9S4AYnZtaLg0Gkb4n7
         x9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775766501; x=1776371301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZW4/FYr/TJOQAnQTjLdgFoQga/P4omv2yM1nIJFsTE=;
        b=ayDnnNvqdeSHrr3cfVyp7Om692Fa7Vw85hD9u/ZP8/FEaQ/7Z7Hp/yWD9uMdV7tn/s
         OWBQD2JZmFjBpz5l/wbf9Ymm7dSdCCSnTshuuv/YfjcjjJt37NyEE9DlyTsmR2JFLk+J
         vPrvBwjmo6Cryw3iNYNTsKd7/CDrfzzFpYqCsjSWr+/kXzueHbXgZ5W45GfvURedaCeW
         d2xEo3g53d405ElizN2j6/4uKk5pWfd2mNLFjkQMTc4X+wRZ9foaMI+1NYWsQSRu0rMt
         kmTyLhIqG1OkEaPFgbxSv1QQ6iOAwJUQYKsxcHIfdrHur4RHJpWmjGj5cJQ1huct0Rdc
         Mvxg==
X-Forwarded-Encrypted: i=1; AJvYcCXeBN93kmWYL+7sMrVIltHmPBQmewWuwJgqf1s7mkj6DKbuXuljyOFUVb3zmt0XWl0+b0HliGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2lw5un6ydSrok3VGWrBSYvh1Ueqf5icI8tTKht0FKGO5SJiqX
	U56iqbL3iU4Lc5RSSyiw5+z2DtK3z188H1gJ9iEqUVxQK/Qoq5SMzJLL
X-Gm-Gg: AeBDieua+s1xlrfc78MvH/0wua88CGrG6MqQnAHJWTS7kQxpkwv2fk00taTvMs6qI1W
	R0Z82a6CkWK2q0vf8HuBbjv4RsjrUeqQAE3uzdhvt5ELKfWlcdjHCeWNwBi2SSsaLAQEQkXrqLc
	QSOlrADuxNZldFwynGSN5csKdqSircfJRkdh1LaIPpgqM+SfwlmWyHsVSmWHd271BIXVSimqxa9
	Ky12OO45Q92Ty5j6ncUIJz+R+xivZY/4YdLXhWkgSa6nCemYVbPZ/PhR8IWCC8Yc3Wglp3xmhZG
	N2sRCbmY6wSb5yLfkRpmBSI25GInHzgVf9IEcw7WDs/N85KxksSJRquSXTOvXQZV0C7xJ7ftgtC
	AoNlR2Nw00u1jmYYjwWeijviGOTN//8SRu/kTW8CbLDVd7LjB2XyDytML/aDTsA7yM3HUyLp3Vp
	R/8LqsFXNG5FvssJPbayPuwOleaHO4HGV4uG/5co3wCnHTTh6NJIZLSu7W2NyFIKRHoP/y02mbW
	XF2ysYI+wo=
X-Received: by 2002:a05:7301:1003:b0:2d3:dff7:13c0 with SMTP id 5a478bee46e88-2d5891766ebmr333903eec.14.1775766501331;
        Thu, 09 Apr 2026 13:28:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::50d6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa556esm1531480eec.8.2026.04.09.13.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 13:28:20 -0700 (PDT)
Message-ID: <7de45664-d468-4f6a-9a0e-2bd56aaedb47@gmail.com>
Date: Thu, 9 Apr 2026 13:28:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: Add ntuple (NFC) flow
 steering test
To: Jakub Kicinski <kuba@kernel.org>, Michael Chan <michael.chan@broadcom.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Petr Machata <petrm@nvidia.com>,
 David Wei <dw@davidwei.uk>, Chris J Arges <carges@cloudflare.com>,
 Carolina Jubran <cjubran@nvidia.com>, Dimitri Daskalakis <daskald@meta.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260407164954.2977820-1-dimitri.daskalakis1@gmail.com>
 <20260407164954.2977820-2-dimitri.daskalakis1@gmail.com>
 <20260409085055.0834111c@kernel.org>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260409085055.0834111c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277116-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0FBF3CF7F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/9/26 8:50 AM, Jakub Kicinski wrote:
> On Tue,  7 Apr 2026 09:49:53 -0700 Dimitri Daskalakis wrote:
>> Add a test for ethtool NFC (ntuple) flow steering rules. The test
>> creates an ntuple rule matching on various flow fields and verifies
>> that traffic is steered to the correct queue.
> Hi Michael, how accurate is the stats refresh timer in bnxt?
> This test is seeing ~10% of flakiness on bnxt, fewer packets
> got counted than we sent. Could be something else but I suspect
> the stats just didn't get refreshed. We give it 25% margin right 
> now.
>
> Dimitiri, this skips for some drivers because they don't auto-enable
> ntuple filters. Looks like other selftests have the same check and also
> skip in netdev CI. So probably a separate / follow up task but I think
> we need to add code to enable the filters if they were disabled.

Sounds good, I will follow up with enabling ntuple filters across the
selftests.

