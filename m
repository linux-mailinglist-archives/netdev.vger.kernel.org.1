Return-Path: <netdev+bounces-233504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F06EC14884
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C0E5E7D75
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2946932AAC2;
	Tue, 28 Oct 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKRHWTXY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7F329C6F
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653049; cv=none; b=kwtK7dXmygA85RatgUL+ow1GopRnkr97UjAYbL482v7OHKdXtt9DfTqMbbzr9jsVujfVk85pwTBXGc4cq5ApsUSZxbBe5hzg0luOoHFvxLlv7/po4pqvbNSIIjTBHfiTAYGx25cIhp6rkPPAxWivU1omZuFKmzFdobmfdl1SVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653049; c=relaxed/simple;
	bh=WskojuOBnwIjjigUBWEDMhf7Assmbp3QvliKc3R2txY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOrIScd5DOJo00/I7ouqmK/vtCCEKV6cxEkqHzk5jnO66XjurqAXphfV9lgDRm0p2HFTzI407Ap799Dbn9t+k5UK5pw5JdL+8e2W8o2GMSPy92sauW8OC6pQOjRnjsWokkxavFgKbGgvkvYHdnJ5zkY08142LlgD67cPIZgNHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKRHWTXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761653046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
	b=iKRHWTXYRpHQZ27rlx7kGAwC2yo4XM2TpZMwucl0zC+hcG19lq94AlUPg0Vults/8Nn4R1
	OvLhgzBT5Oc96e2HtXq0vWlECA8eDc60J/WmvNEeosRJGMQHEbOXET7NUa8hUpR5QNenC9
	VUm/5wY0H96ee+N1SHdSMMMcyKVpepk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-pVxKXP0RN8udbqEq1qALOw-1; Tue, 28 Oct 2025 08:04:04 -0400
X-MC-Unique: pVxKXP0RN8udbqEq1qALOw-1
X-Mimecast-MFC-AGG-ID: pVxKXP0RN8udbqEq1qALOw_1761653043
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106720618so42259935e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 05:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653042; x=1762257842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
        b=Hn2CyAXaKpAERMf8csa32Pn1Imfmao4Bm/tgSlfRKtnUsO1e5ScFzysl5+gXQ1F46p
         vZLyDfhO4TTm+suJ1z2irMCCmWiDJFU73R0t7C4oBVwn+pUmV2+0OAmS89Fihc/t84eT
         85bPmoCIZYGKwg/N9aVk9/cTEjJojtHhwOOirV2ZLNF+xpBmEJC4rKrbIDIpGcwYcZ4J
         ZqIaUg/cX2FIt6Vc/mVP9sUAER5TLfInGvdKqcW2O/rLnc020rNy3kfJ6xvNGCgCEM5G
         WYCZLilMLpCzrdEei02MvaZYOaj5uKfbptm2tMvfvyL6C95je3JIeonRlJVkppFVn3MM
         nVQA==
X-Forwarded-Encrypted: i=1; AJvYcCVJYBnEYBJ61XeiICKTi7hvJnbswWZ5O+/OwI5jpR79EIWdLDMPXYBF/NRfRoxietjfLpHGkS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxK+P6vnaMMVItibGhRasSj9dG7dL/SmdaBaUEEIEHIUniIpSz
	qAJqMzx8G5hq02eBW3Y3G9Zthtq2m5AQZAqYpmffaohe665Mx7QZvFdlRIwe1sxYPelbHO535Vg
	vwDSNvIRhg9guYRbmK2RknL/ygIAz+UbXhSpCls9NMQGhGo/8VQvHGh8maA==
X-Gm-Gg: ASbGnctU+SPL1j4hnmqICrynDcYS6EGrEr6iK8WiS0evYLZ655/72USjTWmtVOJ+jI+
	W+lb7laLR42G8rZtOsQbgbntEwrinf4puJTVD2q2jU+8LxNukUN8uQDeosNsAWFcGYBC4DW/9Ih
	pnN+vBPAa/oxxhn/xp28JFDzRThlVDeDyGvYn5ae52jjn32/PCQ71gAG0zecfjZyqT1GqK7xx8N
	IOMbwZjjqmHFwF3m+Uw8pOBFi8bgbC1Qru614uS9W1SMvHXBeY7ydruaURl7q8X8+khNRlvufCU
	YVhNBDs/P042lyAyj1eloe4E8vrfmu/HUJenzfdFPR8EDjLuQamsjh9cLAYWBp8v5M+bTv4sKvQ
	kCZQOHTB3dNx+F9FnuKI4ImlKphQLgLWrHdEUlW+IARajUxE=
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30659525e9.4.1761653042581;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6BMjF+yCSS1WwGmhw2kl9y9f0ddjV6c/A0RrHdROCvFXSSyoxTUbY0rSmrFqSolRY/cH10g==
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30658905e9.4.1761653042071;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035dc2sm196120995e9.5.2025.10.28.05.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:04:01 -0700 (PDT)
Message-ID: <c5021188-593c-431c-bf01-6775f5b2b2ed@redhat.com>
Date: Tue, 28 Oct 2025 13:03:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> MPTCP creates subflows for data transmission, and these sockets should not
> be added to sockmap because MPTCP sets specialized data_ready handlers
> that would be overridden by sockmap.
> 
> Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
> MPTCP sk requires specific protocol handling that conflicts with sockmap's
> operation(mptcp_prot).
> 
> This patch adds proper checks to reject MPTCP subflows and their parent
> sockets from being added to sockmap, while preserving compatibility with
> reuseport functionality for listening MPTCP sockets.

It's unclear to me why that is safe. sockmap is going to change the
listener msk proto ops.

The listener could disconnect and create an egress connection, still
using the wrong ops.

I think sockmap should always be prevented for mptcp socket, or at least
a solid explanation of why such exception is safe should be included in
the commit message.

Note that the first option allows for solving the issue entirely in the
mptcp code, setting dummy/noop psock_update_sk_prot for mptcp sockets
and mptcp subflows.

/P


