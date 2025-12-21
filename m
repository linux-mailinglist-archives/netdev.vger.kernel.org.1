Return-Path: <netdev+bounces-245642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD9CD41A4
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 15:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49B0A30081AA
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D4C2FE577;
	Sun, 21 Dec 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SDXNpG2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CC2F99B8
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766329167; cv=none; b=tReEf4vxKL8t5CePtv4SEevoQ+bwzd1GeSabO3f5qZLo9IAt1mVEzW94K45+9lYcLxr1PuDT8ia1B+atBkHx7jdZjFku1C9ItEhDmMZVJOuOGUbO+ttZV2YcCumPqfEEXKbPWF7LqfJW85Tzfv6pb6/yewgri89splIlVbtk3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766329167; c=relaxed/simple;
	bh=wnhdy8ymoLVKqvtAArSDJZar79glM7NZ+Vgw3IPa3BI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oSR+J9nADWxvNLzama51kM2t59ivMI0HnAbrNawvZJPhl9wBFhMydOx8vmQojvXUyiYXloUEYzRdQaTmf9X2OrIU5furh4RD4Byz2h1o0cbLb+4KJ4B5qQcphpl5jjiDyRWoVzw6+zm4TNbYg0Q9NXaXD9t59jJP+s7VLt+MdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SDXNpG2/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79f98adea4so476629466b.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766329163; x=1766933963; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnhdy8ymoLVKqvtAArSDJZar79glM7NZ+Vgw3IPa3BI=;
        b=SDXNpG2/ld8oxG6q4wzAY9mDZkd95ie5pS5hnsNWsiavXY/Lggr8dGW3NjeZrb+7T0
         luUg6UBF+tu5XyFUt0gylCNWsiyAewfmLpladrt2nZ3xmzO/go70ltE99pfnZ77tXARh
         uZv+Qh58ImqRIiwFtkn4S9iDJyrmguRyilP8cPdF2oceNT8pMMXqiNvpIkSVIpZKVA3P
         shy68+t3dcfW2L6eaJNBz1mbqjAr8VjuiffSWGbUPBkupyxQ0UCvPMgKe6GBEm0/FmKB
         lPZtrXeRbTC9SFh3elm7xloLhQb3AvqkJbM06sKvIpTnURxLXsezdB/1EnbsDsoSi3gj
         DjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766329163; x=1766933963;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnhdy8ymoLVKqvtAArSDJZar79glM7NZ+Vgw3IPa3BI=;
        b=UVupw9Q7RnV4udVUOCpBvXP4f0Y4DflotKv17zTVffHlxxypoBcxLqoF5td+PHrsIq
         2SOq4gXPGX59Hd5FOwz6RPpzNKLD4RarDYNxplE8rNFjkXTRYLeRPPKAdLp77KLTYIEM
         tswnzhM/9Zq2VPtAbPNnJonVYICFy7ujEpryGMIrE3Ajr4sQp2xeVTxBgkSJ7cHroeZt
         +vezq8yXcM/xc3sGYET8wYB7LAdb2lEnQcNL7vg7tMIZLMo9PQMTBqSZ3oAaokNgXW4n
         e4aelz5u+aSgq5VbiSJf0rAEZfkP036KSAhWhmQVOA15cU+WLgeRaM7CzQlyEQAgd83V
         ukXQ==
X-Gm-Message-State: AOJu0YxkggZ84q4Jf+z1u8HnIPKuNq1z2hyq1GUelhmalconCW2+hKye
	mbetGLDeMfwhkEjJe7VltBzXSv0XoRgyB24y75K9vPBipDShuTpR3gzNGpCsksGMLAA=
X-Gm-Gg: AY/fxX6l3buuN+DJvbddMkp3ZPhHEy98OW8JpLEx+iP67Mssph1rm7qRdYwu7Ctpb3j
	HwYsZSGMalazIKjLCDg4cCYN5Ugsv6UKgclLLz4Zsw3YWSdI09gN4Jct3BfMJz5uDCBK+kaIVmK
	5peSVABDOk8t3raFrf25XEXW4hsaiPPhRtW/EFrnOHtKQMVU+f2IaC6xoKB4TziwEqlBGBoSa+f
	0JoQxUHNmUUT1S456EOfvvM+Ow1NNquS6EvYZ+a40+C0A2GyopLBW75kARRy6Ry7btUuVM4pL/7
	TdprUOp1/iX1xtNMOWfhF5XBwcAbwU+4an7SU00s4VAwI5TAxhoS9wk4pSpycNQ3mMfw0N8xdP3
	Zab6M2wQo/5pVzKVe5xXbKLIY6PnzP2+HRMy4rz99hawVXTVAtB/bcSTiLW9FZTglQVv/8UOlJQ
	==
X-Google-Smtp-Source: AGHT+IEkCPNzQ5e82IsVboI0n7YYBJlXdYsfKuIyWXfeqElgjGBXzeXsUbx4p69DY/H06b3K/k07KA==
X-Received: by 2002:a17:907:d2a:b0:b73:3e15:a370 with SMTP id a640c23a62f3a-b80371d6c20mr977219466b.57.1766329163464;
        Sun, 21 Dec 2025 06:59:23 -0800 (PST)
Received: from localhost ([177.94.145.206])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69b9e9sm5197702eaf.12.2025.12.21.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 06:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Dec 2025 11:59:17 -0300
Message-Id: <DF3ZFGNY9DYU.HO1EOLMCRT8T@suse.com>
Subject: Re: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Cc: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "David Ahern" <dsahern@gmail.com>, "Fernando Fernandez Mancera"
 <fmancera@suse.de>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com> <9a3f7b60-37e3-470e-b9f7-8cda5ddccb59@suse.de> <9c979662-cdd9-4733-911d-b1071b7c2912@gmail.com>
In-Reply-To: <9c979662-cdd9-4733-911d-b1071b7c2912@gmail.com>

On Fri Dec 19, 2025 at 12:51 PM -03, David Ahern wrote:
> On 12/19/25 7:51 AM, Fernando Fernandez Mancera wrote:
>> It would probably require some work on the test but I think it could
>> benefit from using two different network namespaces. Currently it is
>> using PEER_NS and the default. I think avoiding the default one is
>> beneficial for everyone as it ensures the state is clean and that the
>> test won't interrupt the system connectivity.
>>=20
>> Other tests already do that, e.g some tests in fib_tests.sh use ns1 and
>> ns2 namespaces.
>>=20
>> What do you all think?
>
> agreed.

Thanks, I'll send a new version later on this week then!

