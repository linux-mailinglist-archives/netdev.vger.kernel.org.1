Return-Path: <netdev+bounces-225675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D99B96BF5
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E46C171F5D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1EC266B41;
	Tue, 23 Sep 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jMbavm5V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1142E1F01
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643598; cv=none; b=UmemntC92d9tH1zwTYKygs2lTgWIMD7DfeJ1q1Owm45xyWP6EGS5AHrQmMpnAuA9hY/mKO7HAAOajbtA6MYsQztVcGUgEwKF8RlB1ksX3dImGT34CIjGUVJlgTt4AEcyRAaanDKsRhINLzk5HK5dtBhpdLgKcqx093a1x8tLRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643598; c=relaxed/simple;
	bh=FVRF2MWvLEs/zklW95PhZwQh5yuXlKRQsTs+dtNDZvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGugS+fo94huswmTTSvZzRtsq/jAqACrMdPVJzLcQ+pUy4NMLrKtQFYkB9aNbNkrTUAGmFBwQ8AInmllCGZRrcLgo1zMT3qAbK7Aq1hvOMYYyKMQvZ7Gha5k1RcKbSOtjqiuYG8KqBODMY7Nw1Cuh2ZupEIAT0PK6RBTKISv9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jMbavm5V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698e4795ebso57665965ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643596; x=1759248396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bd4hQN+qvWGihEbtKGP8wbOZONU9V326xl4tL+0chGM=;
        b=jMbavm5VmHLQOwpYJtbUGlbUIrNa1CKZTN+ldN/SwRS4p0IXHm6su0aIzqzoFKhMRm
         mPmxgri+NEjLlPIN7GopbGVIRkbEUTwZ7FOovzU/72i5Rhnq/w1hodnmD9hkFFGKsKp4
         wMorWx1udJJ28qVB0SbAzgVTesWTXjKV0eYUTp4+RtVRvNrR/IwsGuP1UsnWGFwNbVnr
         2v6/TfOVAy4vKmzCpmagMZTLz2prCM1VzQd+Yeh4tUbZgKTyKXVb04GrHgCAm0Y0DoAf
         bqc5yivv2+8d7TlilZzyiaiBrOg9+rCMLyFjfvDThjrUpZtACM7zqEz7vwvLgSvcRkMS
         rrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643596; x=1759248396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd4hQN+qvWGihEbtKGP8wbOZONU9V326xl4tL+0chGM=;
        b=mu2jrOI1FzPWdX7gJ0R2dJOSBVRqmxUkrvERRvWzjGLp38QiLzjf6TU5/+U8pPkdO3
         yR8co/+nfu3/DjLsk8evq4/wdIcLQjDV66qUvfF3sk5SdEzJMw6f+yfL3dsmnQnZ1RaC
         LaeKWNZyQ484YEvcoqfH5NGH0YtBovBdjtfQB8MOmRkBanzvMkqmNn6o4ur0NZQB2DCb
         hQE03cgqkiaVR2QFQYoEJjX/pOgM0hqBfpzuD31LCe2Fh/s4jmqyLsueKMfgP/0jrv+j
         /+E3k1EeBnV6kNBn6HO1kLrJLIr+gK5c69yvLAiegOrz2BYO59aQxP+hIT4/1iFIwSwJ
         C7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4OaD4juuN+dWp+jeKG3SfeNzpfgaLaRi6CEOlY7dvNTQVo25mU/OjYMOHmYzaZpqkqOK1fV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyovkDfkrAvowvt9sOs3QKt831NYzOEsAINyO8K3XeALfJF8PO2
	FRQT2Vn5kPB0OGTlCvwLKEz5vEOs7zrnOTrXdvacTec3qGzROmsj75wMqtrRzeg3Rr4=
X-Gm-Gg: ASbGncv6XsCgCZni1CJwcOZJWeWqbm/b2z//7t2n5isrZgOioEk5KOLGOQdQknVskkc
	mhDB3ZE4zTDzVOUWX8rzm+xrI7mzkN3miCWIXiflv5/g6nTYaHrIzxZZ1tu/ODuc40Qln0ogH5r
	/vuN+IGdgjwLYuCGoeYswoze7J3O51FdWU9+nbZPDfaIkjh52VBrdtts8sDDxFNOL61EJUEM0uA
	nrO4PFbzJy1gA9OY/ynfzaTDhxZ3RM89pD2eV810rcJ0jkbUHpYm+lRMZxQoU6QcYZejaNL2/Fx
	4Nck9Rx7qs3WqL/AB+gby4BaZClgIc5lr0svjAR4Ge00+dOMqMYeuK9tILAD7MDF5kyDMYxP5QI
	3jgwtGtif2H4cjaACnydiHF0hjmEHZ70GuhF+5VqmDtd7npDIY1wFK5hXG7hbskuONnRwgziqyV
	M=
X-Google-Smtp-Source: AGHT+IGRbk4Hm1+Nv1zaxM0HUJGGlc91y96fYXRJcIPKNHCjlQw1SVCwLkTWUxAkA50cTLP1QrcvZw==
X-Received: by 2002:a17:902:da8f:b0:269:6ed4:1b0c with SMTP id d9443c01a7336-27cc2008c56mr47908505ad.16.1758643596262;
        Tue, 23 Sep 2025 09:06:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016b675sm161802535ad.36.2025.09.23.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:06:35 -0700 (PDT)
Message-ID: <bc473610-4a3b-46a4-b875-df945032a909@davidwei.uk>
Date: Tue, 23 Sep 2025 09:06:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/20] net, ynl: Implement
 netdev_nl_bind_queue_doit
To: Jakub Kicinski <kuba@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-6-daniel@iogearbox.net> <aNF0G6UyjYCJIEO5@mini-arch>
 <20250922182651.2a009988@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182651.2a009988@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:26, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 09:06:51 -0700 Stanislav Fomichev wrote:
>>> +	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
>>> +	if (IS_ERR(priv))
>>> +		return PTR_ERR(priv);
>>
>> Why do you need genl_sk_priv_get and mutex_lock?
> 
> +1
> 
> Also you're taking the instance lock on two netdev instances,
> how will this not deadlock? :$

Yeah... Sorry, we'll need to rethink locking in this function.

