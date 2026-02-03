Return-Path: <netdev+bounces-256285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEuPF0jvgWlAMwMAu9opvQ
	(envelope-from <netdev+bounces-256285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:51:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F81D95B0
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB373072A57
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4956345CA3;
	Tue,  3 Feb 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF10yEl8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMxrHQHs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F019344DB9
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123048; cv=none; b=NexUpvFKZxBBtHBrHsQy1kDX3teDDva/99RpvPY4xxLdbmLdVwsWauN1zntf8SwnUmmo7Wzda8R+xE3glcO6cur2ukT+75X25J81xwkzUauP9/jodP4zsNf/Xd3TjA3SUbV/B+o01Wk1RRJ4jxpFZTl4hymBiCbz8wHjNdXIDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123048; c=relaxed/simple;
	bh=8KynJT2ddnzGhgGZ8pfYEVkha/4ppnwD3PQCKPf3fF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rvwmlTtp0ZKKn4Skkd3hXA+LOHawsRflkmBIN2YxS2B+yJT7bo/vpOVghIFVStfXt6kvjMPzvjLNsaUXIj1w8jy7WwwvNhUm15TJU/UIa50YKZA+OSGWhbuWiZ0jd3raZ4vwGJpLuVoXtfLCmj+Cw7sbfRJOHJ4sLiTyCL1qR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF10yEl8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMxrHQHs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770123044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEWONWPgIK5PTen/Dr95JAV9SFIx8z/zmIXZPCQZI9g=;
	b=bF10yEl8QA5shqdNZJzhrbmBo8CZ9uVbrgNs0xOhinG5t9g4TptvgwOkTfirb1mudi4DDQ
	u9v/J+jrMl5Gthdt62XzyYW59iBITvRHitGuUQeDq+t6x2JSOM2njopaqCLWRPB4TU3P9e
	sacBraryAcegH0aiEC4JM7xt2AP+yUM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-3TPotj6oMTGaHHPRRT7Nfw-1; Tue, 03 Feb 2026 07:50:43 -0500
X-MC-Unique: 3TPotj6oMTGaHHPRRT7Nfw-1
X-Mimecast-MFC-AGG-ID: 3TPotj6oMTGaHHPRRT7Nfw_1770123042
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59b7888640dso3521827e87.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 04:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770123042; x=1770727842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cEWONWPgIK5PTen/Dr95JAV9SFIx8z/zmIXZPCQZI9g=;
        b=IMxrHQHsA0ZqTfNWdggKaeqWMpR6zYgedPADfwgtQDIjOM0wxzGkzaVAz1kUC6Nv7h
         2tV4fD+KxeAQY6J4zO0gp0sZ2E3KIyBY9OSi0dA9eIDDfo8qnSCa+65o/HWWXybArrPS
         jRvMPOGzV336ckA2rOarL1IYXai9ZDrQVpM/5M5KZUQQP0MKGSlQ/paIOEG4ZjVEzeAf
         qyq7Vef42Cr5QDjDfvIAAHmGzdLLoEBgQ/+S93rbJWWp6yGrHn1ZGLbl2P5bm1cgJAWz
         zi9MWKXlAv/8SKk05DVRyNDbEoMDfdjURs/LM9jZfaRSBAF5M3aib+Sz/4jVOYQt72NU
         TiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123042; x=1770727842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEWONWPgIK5PTen/Dr95JAV9SFIx8z/zmIXZPCQZI9g=;
        b=nXuNpojZdUTgSGTw7L+vO2op7sIXk8HcCPUi8edbzHIoIKfJUcpIKPeNYOGHRUVenR
         27kWnBPsTsLsdNAKlsQc8vnrZ59Xt5Y6VzY9F41vgZmq7dpIl7HqhnWegdLbHkyW9fOI
         CBJ94InuYYgAMF7fDwZQWv45MKhLn63CpbTk6IIYmE0//9WWXBLvHTgKdVs6Tc/ZISq8
         cN4de+BQ1Okr/U5hHgeqJU70o3HQxoPCMODFTIUtHV1PgFkx26W4puQuHc8tzH2s4a02
         tyWbJYZ4Mbiikv7sOgn+ixP5oetSy4aNaJDY3M/X102XxAt0NtnT0xyV5+ecMfBu+/Od
         /7eg==
X-Forwarded-Encrypted: i=1; AJvYcCWpNvXRI5Rn5ZOTh3S5DIpvYnYoEQik6UJOQLiNAjCaV/egjImU+23sgWx3xRniG7HG0isR8yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBM9RHGatnmo3N/Mv01/gXhwPAsYBi2e4khmyLvRVTDMdeYYP
	q4NZ2HgWZaDndeEanTMWGm78o16YOjGqIusWQMeXqO6VE/kqN5r719iTyxueygqGe7YNo1oW3qH
	P4ECeC9E+Cjv97sEAaMesVqMLxZ/4Iw2eA6GJRFiJnbdGfB4vNo5hcRYTNA==
X-Gm-Gg: AZuq6aJYe2kLef7iMmSw4uLh9ZCkDVy46NB+FzIgKKFOUkIq+Ea/6Lgtf4/Lnx2rGE+
	6/pfEvO3knlLDVIYH/cTByfLHmgaotVwnUg6hmWAFkE8sYiOb34d8pinz6SQcx3xD59WR+r5XRt
	2OVPci1uyzIoKjJAEhQzZViqF6UkCzbm74V47+AJAiqqiIkYmSSgG3LPxHBqIDYlElEdNP8KSId
	6PKOLx24CF56N7zt3RngmD60hR/NpXwg1hGdfOAr1HTM72DsV8D+0CVM43nnPHU8lT3DVBPf/Th
	qxXIDikvyRzj3HU8O9aQuBQnEXmc/0thvxWU+jJSszXivFULucdFsqXqb0QGzH6VSV13Rc2d+yx
	RTTRjbmmmq3c=
X-Received: by 2002:a05:6512:3f21:b0:59e:429:932a with SMTP id 2adb3069b0e04-59e163f573fmr4674337e87.1.1770123041874;
        Tue, 03 Feb 2026 04:50:41 -0800 (PST)
X-Received: by 2002:a05:6512:3f21:b0:59e:429:932a with SMTP id 2adb3069b0e04-59e163f573fmr4674323e87.1.1770123041407;
        Tue, 03 Feb 2026 04:50:41 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e0751bb68sm4024086e87.8.2026.02.03.04.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:50:40 -0800 (PST)
Message-ID: <7df9baf9-040f-41ae-b292-f3155842b5f4@redhat.com>
Date: Tue, 3 Feb 2026 13:50:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 net-next 00/15] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256285-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09F81D95B0
X-Rspamd-Action: no action

On 1/31/26 11:25 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v13 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Beside the just shared feedback, the AI reported a bunch of other stuff
that are not relevant:
- fixes tags, IMHO not needed since the touched features were just
partially implemented before
- uapi breakage, already ruled out as irrelevant since the iproute bits
are not there yet
- pktdrill syntax, which is a little inconsistent but AFAICS correct.

I'm not sure about the BIT() macro usage in uAPI, which is already a
thing in many uAPI exposed headers, but does not look correct. I guess
it could be handled with a follow-up, if needed.

So the only feedback the could really require a new revision is WRT ECN
flags handling on retransmission - and I'm not 110% it needs a new
revision: please double check it.

Thanks,

Paolo


