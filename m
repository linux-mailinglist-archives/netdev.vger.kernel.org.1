Return-Path: <netdev+bounces-262431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FMeaI6F+pGl+igUAu9opvQ
	(envelope-from <netdev+bounces-262431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:00:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2040D1D102B
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F38253006788
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E71337B87;
	Sun,  1 Mar 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QGpbxEMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BF32FA38
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387998; cv=none; b=MdMtEGbZjoAnZiGU+dSMnM1IWIMifsZwyz205ObwoiwEHB75cG/IC+CQmRgq0aDy2m7B4WY+39sPlwLdEsFfyUkowrPQF7CDQ1FOLCNgSDx7PR6dv/agHAFfEG9GfdYBqGDR2YhvAgBZD+dMtMiw+nktBuvoGOI2YDRBjOP4Ot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387998; c=relaxed/simple;
	bh=waHuXg1cR/lNxdO7JwWx5WCgUHMStoTszzOXqaMK+2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xoui8dG+I4TmTfxWh3ScUD8M1qLSLBtRv9a0Bzsz4C3lOmxLYmBQJIKsWHHa2lK5YeR5QfjLBIkxQXXboEF+lFtT3NmcGXJXM8XGp7XclJz7DwsFM4T4ieudXv6VRrSqfyqH72r8/MFrB4Wd2mdnNd/4lYAb6p1kdDd9RQrtLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QGpbxEMw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so4115243a12.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772387996; x=1772992796; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUriLEKIKpf7k3NxTjsJxgBlXx8URXMNCEQZ8pvmz+I=;
        b=QGpbxEMwqmSi8MXhx1v2I3f6cbO6LbepsKDKJTqf57NMkiqfF2TmtRdLpl6HMe20si
         jyEWuXHOYsXfui+AsgbyTLoUyePaYxiwfXS7IHbXdyu2opV2GKAn+air1H67kUKGn6uL
         HCruFoMuv2AccDJ4Ck35qJ/uRtyNTHpGdhOgD+dt2GQ3QKSn26poFFdY7BWs6ITqZ0Jj
         VhkVjUvVOhMtyAXu3TBQ/VmdYaZAD/Hgdx5uVaFFIMClcdBPPeQvvY+QZRB+Yd6vuRKB
         xyNPnXZGyXDWGpsWZ/VdA/45gpBPzkFJrn242l0UAb0qtJltWrA16YMyhlUvVgm3SYWl
         RxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772387996; x=1772992796;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUriLEKIKpf7k3NxTjsJxgBlXx8URXMNCEQZ8pvmz+I=;
        b=JuQxKv/eJ6hdV8KTpPNhjaZb/Km1WKn3Y0E17t06qAbCjybj7SQ3tljeOXsj7VlBsN
         p8+vOjtqcfR1+LdyzVRVbhJcWXj8w2fNqyjB2VuaZvEP9U23HTAWUpvyfIhaePahcmnS
         SDc1hf3jLu/Xmphh55y0xK8o/B/t03wsu1UmyJpqWdYFl2oariHNfxyUh2Vf++uUcrXY
         Ay+ysdI7G6wlbwaCMDcAraAbQZkqycZEoDkmMxwhWCYYBVO7xepkqwnz2E5KvrdGuerp
         QRN4SmyRX9k22tq4bIt42II4tFaKEfCSSLqwbr1KYHmzJrpxbBOZ28IYoQCynjEdAUM5
         QLIA==
X-Forwarded-Encrypted: i=1; AJvYcCWhaQMIjI03EQEAlTyIu1GnTmimN2epcDOdANlw7jRNIvS1zC6cAFsEydOvZ0c//ihzOCPl8P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFF3DHIx970FlyeIIqE9MlckeEPrqCo2VC3Qzv97auz4FYxn7t
	FRpgK6PwfQJ83HYpwdz68ZBg40yw/jO+x96FwzICDceQIMYK3QBOynXn4S+pzsKypSw0RxMymHr
	5KrqA0IHRxQ==
X-Gm-Gg: ATEYQzx4Jr4niQxzGuMu4oSX2/XTYOK0qGcl45WmMcr1EmzaoojfOaLcYszThhvCGzX
	ykdZ8vHMMUSHj1xe3SDFQhg0FclHjeQIv7MgoNP58lV7dEA3l89NGZAY5gJ+ynD5oQodXsybeWQ
	pyQFa9fn1suXpNTtrHYqYl/op85cX+gcXzwxfBcAknAamu2eP6dCI+ylxnVFti3RNrBpv7Y6Ggh
	/jNSZ2+lMuh7BF7oH6PesJKstDkruX0pyoneEAb9i2jPQgdVPb+BiVcKU2+tMWhAb2fmdGTHIHw
	pvMXP6G/QKFWdpczfw4eT4zbStIExMu1HGdOEzmqIVXOrARNzqPw8JQYg9LPXWhUYI/bXjUh7pc
	lgs/drMqKw7+Rq+X8mXkYhE/B3+HujDB5CNP6tWN2AWIwbGmrC2+KxgeeFqy+VCDTB7gYrlfnvj
	R9SmGaHO5yOB3Bg4Fr+M0W3bUCruU=
X-Received: by 2002:a17:906:6cf:b0:b8e:796a:fd5d with SMTP id a640c23a62f3a-b93765110ecmr474922066b.39.1772387995610;
        Sun, 01 Mar 2026 09:59:55 -0800 (PST)
Received: from cloudflare.com ([104.28.193.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3ea3sm381222466b.57.2026.03.01.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 09:59:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  bpf <bpf@vger.kernel.org>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Network Development <netdev@vger.kernel.org>,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
In-Reply-To: <20260228155021.1dc9b127@kernel.org> (Jakub Kicinski's message of
	"Sat, 28 Feb 2026 15:50:21 -0800")
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
	<CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
	<87wlzydk12.fsf@cloudflare.com> <20260228155021.1dc9b127@kernel.org>
Date: Sun, 01 Mar 2026 18:59:54 +0100
Message-ID: <87seaje8h1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-262431-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,linux.dev,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2040D1D102B
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 03:50 PM -08, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 21:11:05 +0100 Jakub Sitnicki wrote:
>> So to exhaust all alternatives I gotta ask - would you and Jakub be open
>> to the idea of a plain byte buffer embedded in skb_ext and exposed as a
>> bpf_dynptr?
>
> I'm fine with that, but admittedly I (like you?) live in 
> the comfortable universe of controlling which .config options
> are suitable for the narrow use cases I care about.
> So I don't really trust my judgment. Adding Paolo..

Good point. Distro's would have to pick one-size-fits-all which won't
work. This needs to be at least a boot-time configurable, which looks
doable with minimal changes to skb_ext setup code.

Thanks for feedback.

