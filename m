Return-Path: <netdev+bounces-240843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08592C7B070
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268713A31E3
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966D29A326;
	Fri, 21 Nov 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="tmY8RPHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125232B2DA
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745293; cv=none; b=ihGYjZ6iGqX4q9vV5FXrOyF5cE1CHbVMHCEtehl/fr6dbMEnqmOzCYnYBvfmv8C3PLLJjB/Qmdwpo/5T9QESkZTnq1VYc3mGPTDroFYOOPNAaDpCuS+Mp1S8iOmZAQHswHxB5TDCPdhUcFG4+QlQwvA4DJ9O2+yDl9GU9JTioAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745293; c=relaxed/simple;
	bh=9BzN6pC1GGXdrwzw8wjiYesifm7+I2vf0rXA5YKDHkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAavAoG9xN+kCNGor9xK/PMAkcG3zIcSpw+snEqwdvxjuSUYawI+RpPhjWGIKCX0sNPFy+O8X9WfYjkhvFLxfez5wFPB9tBESr5ZB2VQfqUk39ECsy9224m8ulXBmGlQZeGf6+0kJRecet2qf8CBHS921sPGxLI9v3wQrtKDeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=tmY8RPHM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29568d93e87so20783915ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763745291; x=1764350091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KI4P3ipTmobTgpfDGDvQPqfKrNYWqpgnGI/I2F7HDw=;
        b=tmY8RPHMtjoedl+yeygkmGfcIPD8dG7A9GMl6LJBAHOmhYMM1lxP/XAQLEEEekpQZD
         YmM9E2xgLeklV3TqJfIraTzjpdPUhEkhtlGJPdt76EkXEybrcgFb7sVxS6iqp2U5nR3V
         D6w8U9GAz/c7btWwB4W+r29JsFA4iCW77qVDmqhpQlTuu07gANY7YFqy8QOznkSM3mFY
         6hPBfpCHcVqva29E+GohxgyV/sqbzl99SeOV5KE5p8rgZTDrHDI7tbhXoM2o5QiZnn/6
         a2MprxnbTy0OaYNa7ZURiZoqdMDRShulGJPnX9SSF3nNfSssE8OGsJlOnlzwWJ2U8se5
         ZvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745291; x=1764350091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KI4P3ipTmobTgpfDGDvQPqfKrNYWqpgnGI/I2F7HDw=;
        b=Lf0/Q25xv1qDKTzUboyChqB8yX6GUKpKiRqfWq3GA/pUaBVf6/dgl/Az9/xETaCiKN
         zVX9LEb63uCq/BT5v53rSouLNd/SEqVYa8NZfpIAbETl/BhkwFr20L0ChzFtF8TZzEfy
         CLyIl0NLPFUo21CZoLCO4p/ipw0NzHFy7Tz/gSg/A/ggRlcFKS5WVt10myjMa3mNK71+
         BcW2BqocOM/xZjA4beFqWkZM4wkFl4gvx252vrbjqDwox0KLqgM1hi+m0C2Hc1qDN9HO
         dawo/HNfFtZHQbw+bLKQfHGpDJbSIHNz2KKFrlmAe7WrgLBqoUXcsq2m+PejmrNFbwuB
         b8hg==
X-Gm-Message-State: AOJu0YzSKstI3ltjivw7322EZh6uSRM7NCmFmbqZW4Us3WP+wfJZJonQ
	1uwCM37n/kMYMiNSsdtzDgj0LPaWTz1Bpm9TO6USqCw207m0B7dRDcDlmKxAnOIFCzQ=
X-Gm-Gg: ASbGncupoh1lhccKvzUUydCk3A1sCJnQZc6RM/z0VmuMkFrcH+Zpi+N7iWHr2IxE0vT
	t84GJUNoniEYxn5tKL/NQVnjeaM1v3TsIIH7JlN5cPHebunkLjLBrqbITgCeMgm9SN/9IUJP3At
	7F9H/a7aTwzH6IgpstVMLMe9yeMxfCVykuGKgjLL6cSUjyZ+AFIiSwEFMt7YeVKiY1Q5LVx46Rw
	HL+xyUbc/iHRgy9zdU06eLc1jqrRUhN1reqy466V7+YLD9THqhDz1BlUb45NKR0JmaPvPLykLqH
	Avz9mWv/yim9Oy2NmHsGMZ4OUf8Htg+wL/ZtUVuudC30neUph86Hxtr9heaG+1tf9UNy6Ux5A5o
	cXSU6Pk50FmsbcFfihejsqhdwP9vf2fzkZ/BhzoN7E30PbWlPlcic/mLGXGUu1Jo5/xQv1bKlBE
	iU7pIRmsyowwTxyYjTQ0fxm7V7JysorPaxeeOA9KMHAceXCCcvq0LbKLWHGY9HnTj1ChE+hKI5E
	BdpGX9vZNLLoB4HNQ==
X-Google-Smtp-Source: AGHT+IFwX+1n1CybGSFP8odZgHa3GgdFz2WWnfSVf8mv7RwE25JnDTUdQ/o3xOisWCfPlR7O9Mndow==
X-Received: by 2002:a17:903:3c43:b0:298:d056:612d with SMTP id d9443c01a7336-29b6be94938mr30401665ad.9.1763745291336;
        Fri, 21 Nov 2025 09:14:51 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:9190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fed2sm63058625ad.69.2025.11.21.09.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 09:14:50 -0800 (PST)
Message-ID: <1cfe74a1-092c-406b-9fe5-e1206aedb473@davidwei.uk>
Date: Fri, 21 Nov 2025 09:14:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/7] selftests/net: add MemPrvEnv env
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251120033016.3809474-1-dw@davidwei.uk>
 <20251120033016.3809474-3-dw@davidwei.uk>
 <20251120191823.368addb5@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251120191823.368addb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 19:18, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 19:30:11 -0800 David Wei wrote:
>> Memory provider HW selftests (i.e. zcrx, devmem) require setting up a
>> netdev with e.g. flow steering rules. Add a new MemPrvEnv that sets up
>> the test env, restoring it to the original state prior to the test. This
>> also speeds up tests since each individual test case don't need to
>> repeat the setup/teardown.
> 
> Hm, this feels a bit too specific to the particular use case.
> I think we have a gap in terms of the Env classes for setting up
> "a container" tests. Meaning - NetDrvEpEnv + an extra NetNs with
> a netkit / veth.  init net gets set up to forward traffic to and
> from the netkit / veth with BPF or routing. And the container
> needs its own IP address from a new set of params.
> 
> I think that's the extent of the setup provided by the env.
> We can then reuse the env for all "container+offload" cases.
> The rest belongs in each test module.

Got it. You'd like me to basically reverse the current env setup. Move
the netns, netkit/veth setup, bpf forwarding using the new LOCAL_PREFIX
env var etc into the env setup. Move the NIC queue stuff back out into
helpers and call it from the test module.

