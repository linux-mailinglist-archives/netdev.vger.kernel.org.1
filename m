Return-Path: <netdev+bounces-299176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7qmDNbZhLmqSuwQAu9opvQ
	(envelope-from <netdev+bounces-299176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B7D6809EA
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=C6HwtYwH;
	dkim=pass header.d=redhat.com header.s=google header.b=SP9T8oCW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299176-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299176-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4C093005387
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19FF395AED;
	Sun, 14 Jun 2026 08:09:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46D3955EC
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:09:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424562; cv=none; b=Tb58oeAY6sDmrPFhcANP6cLSruOj4TP+qnevgdULQxdnii7LsSTWtyLyI2f0It7/z7wVVDePl/7E7uKLXTM/habgWjUtRN65cPTNhAw/chf4EOCHEgd866525+eXthpmBU8L/luQj1mevhC+1nAtasoq+FBgSuYQpn5x8k9mhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424562; c=relaxed/simple;
	bh=O7QCnYsmC9T7DqPOfcZPmAFSh4iJuMkXDFQ2B/VoU+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vgad7FAYNc7xlCvJ69+G3PCGXiUmVklpUUrXawwxmSRzJSktgHXbyUWYJ4PbCSmWllO1fCTUfJHo5ScmJd2OHZYmgrdgSoyNLtQgVX15WJBhd9gZczPYqQlAsVkTfX1J8WT5LStQEVC2576/zj9PIlGG63mD8IUUIfjVaD3sY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6HwtYwH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SP9T8oCW; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781424560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gpPUZzZ8NEOkby5BaEtAw32WWn5h8dDgNhgJeg12mI=;
	b=C6HwtYwHMSarbCtPGv1svCZIaiv1W9/vd8bj/ZtCgrAGiP7FwPMeJ543qLsOEaq3nesY8L
	sKmhWRjxxJhYy5T+a9XR2crlQ19IFesVy9D453rTDfe9tyLkS1yXVh4mgVFkp2123B1GuI
	qTI2HqA4zpL2lY15ipE05++33vDMw34=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-m_jg1MQvOnuGFR9VLkyWOw-1; Sun, 14 Jun 2026 04:09:19 -0400
X-MC-Unique: m_jg1MQvOnuGFR9VLkyWOw-1
X-Mimecast-MFC-AGG-ID: m_jg1MQvOnuGFR9VLkyWOw_1781424558
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efa7755faso894181f8f.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781424558; x=1782029358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gpPUZzZ8NEOkby5BaEtAw32WWn5h8dDgNhgJeg12mI=;
        b=SP9T8oCWqVVVcrkAQFVsxVYjNEf89yz2Ocr5X/iqBxCvvsuBu/GoCf5ta0bgt/9mq5
         Ws7bRFUV2P1amYgjoZ3bx1Fkq8Vs4Dlx+50tnovSJN8Hn1UMQtJgyd9xy/BegRcPGD2A
         cv69napl/DsyTAzKGZad79ghBZ2drHepUQ1QqbTNV/10RSRdBgCzqjSACioRA5a/Bbz9
         KbWTDie4yNvRK/uYjOIowBRlaHfpGNEctni+PJvZITAV08Xip6IWFMB6gWWvOIH1pxMP
         uKCsnFSqIVJxS/w48BNelVog+jHiVxpEdFbft//jnfk3RYaFEpz21MilvSQa4qHNxnNZ
         y6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424558; x=1782029358;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gpPUZzZ8NEOkby5BaEtAw32WWn5h8dDgNhgJeg12mI=;
        b=d+AkstJwtjOkpLMZK0vthtZVORduP0dIp+90djKSPKs0DNC8I165SEg2JCbRF0cbab
         HndYogJoa3iUUhANSL0sA5FtS7T6p0AUwLAUfY5IMDX+37ZxnkFyElpmrFzxUyEP9Yr3
         yeNWGX8JaLemxfeICjoij/NNuPh3116VdazpnzIAas3Z4HaXn7yBFrKcq6EjzBMyUgSQ
         13bRj4JOy6n/O1zB9NhXGlHaIvizh3gIbFKpy1Sfvu66gYJMY4Or1NsM2UxgBwJqAUqP
         PR2+6t7LNizq7lGwH1ZMCSOaDbegXDlRdCnY+F09LaNSWKaIy4MWFL1P2wozVEwb8Bfo
         dWrQ==
X-Gm-Message-State: AOJu0Ywrmh0LuKF9m03kNEq/sKLa5kC98LBRjmvDp8fRPyslRQZ8EWH5
	yXMZOtdsDTaQG1c0Lqyiam29pOjjzKIsBM+Fvq5cUBoCTk9WskVwJvOwwLnYsZuxHfCphxpqjWS
	q7NAvbq5jAxYQR1l9H/+1Hf7V6CZxKYQXWKcvUbtIDf8BqNNFcAyNZ1MQKw==
X-Gm-Gg: Acq92OH3zvOiZ1NFu2kzp9H8Y1qHjKi1RAUJ3ZFYfJU4ihG1I1TWwfufmJlrHEz+Cec
	E9xwWT8ZkUeJDzl7RbEy2zT0x0LF3nohiAWd0o84V1OaNl481CU9gCMqJobToKh+8rdIPfDFCf4
	tcTm8lCHSbWRnfn0eTdFm0KQbrVyqo8dbgQZxAHnaE8hLEEjUrAAdoz4dDYwmy1Lan0a+oZRXfI
	+1vb10toqG0wDer1eRINXy7AcTNFCrnB3T+OA+sdIzCyWPQ8L7dwwMdCMoYuXyW0gXUbeEZSQ2l
	HE8bhfvfnwKMhv0EKwqXwMtz8wfMN14K8cU4RaIKW4w2M4ULoPXeX4Hw7hgTpnfKJEcXrgxa8yD
	MliwvjdexFTHJOVK+WlZmfytety97C1ZlrDqiYCCxzL8W6KeYN++TWMQ=
X-Received: by 2002:a05:6000:25fa:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-46074b84e56mr6664949f8f.31.1781424558002;
        Sun, 14 Jun 2026 01:09:18 -0700 (PDT)
X-Received: by 2002:a05:6000:25fa:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-46074b84e56mr6664920f8f.31.1781424557589;
        Sun, 14 Jun 2026 01:09:17 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm24168006f8f.35.2026.06.14.01.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 01:09:16 -0700 (PDT)
Message-ID: <cbfca457-d118-44cf-b51e-9b0221ae0973@redhat.com>
Date: Sun, 14 Jun 2026 10:09:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, sd@queasysnail.net
References: <20260614014102.461064-1-kuba@kernel.org>
 <20260614014102.461064-2-kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260614014102.461064-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,kernel.org,cloudflare.com,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-299176-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B7D6809EA



On 6/14/26 3:40 AM, Jakub Kicinski wrote:
> TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
> Bugs which may be more or less relevant for real users but they
> are definitely exploitable.
> 
> We could not find anyone actively using this integration so let's
> reject this config. Adding a TLS socket to a sockmap was already
> rejected by sk_psock_init() through the inet_csk_has_ulp() check.
> We need to reject the attempts to configure the TLS keys (rather
> than adding the ULP itself) because checking prior to the ULP
> installation is tricky without risking a race with sockmap getting
> added in parallel (sockmap does not hold the socket lock).

Aren't both tls_ctx_create() and sk_psock_init() under (write) the
callback lock? Isn't that enough to avoid races?

/P


