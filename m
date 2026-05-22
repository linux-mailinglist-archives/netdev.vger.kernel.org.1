Return-Path: <netdev+bounces-290696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKQkDCAHEGqLSQYAu9opvQ
	(envelope-from <netdev+bounces-290696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF15B008F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D7F300DDFD
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFD38E5D6;
	Fri, 22 May 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="V3/jtv+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D18360ED6
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435033; cv=none; b=LNqf2zVOroRm5uotVgvMmugpJMOwn32j87AIIFz3ijxb+RbnDs0+COVjKjTSt8Jk3fMCmyb+/oj7Dwrv+YCPKZshxqa9deqAeOYLZVa0Z8soTDqO0arvfgBr1SDUrn9XA8gNmWbbzTR5rWflLYGQBnm+fwxNEnAaYWuGth8Skpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435033; c=relaxed/simple;
	bh=+G+WcX8gxWotuoCjkWfQjS1KdGm+dPlBcgAAenlIkCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUoHl27C3bKqT3axXgy/YqaGVXrBQVs3cE+jWdQoKyJFH1ZiaNsOdthIlrp+NHc52EUJo4sb2FyCcCBJdgTLAGuQHZhpfVcNBK0pV5f6+h2pxqrEzn1bd+SJEGJ2O51Uq4fRaM3TJanjSyYnNQq9hi5jL4y0vyfMye0Rr/ky+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=V3/jtv+Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ea5252a63so162124f8f.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779435029; x=1780039829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0RAn0u96GfobFXECWbhYR+PuAZ1QauCj0CfUQ4vS80s=;
        b=V3/jtv+YfDczYAzhpeSy/rTRhfKa0MAh15DAx+/WAMFcgGhPM+PsSoZHqiiTA6n/3u
         H0Ol0iST0ut5u4l5IwjerB9tQU0+3FaDHcSJDUyLQv2Rg6PFXNs/pEuEmucZ3m/r8qp+
         bttFB53iaKfuV9rlz5VDiKV3BQ6UjXqq0C6N+Z7WoQVR1hueCt/HZFRtPzlgrZPZjiRr
         Ki86SSBPPDcTTomPS/MgAZkJjyT2/14a3livrhJUF35Mmyt1Fven6m4AiXJi9IvE5ron
         uzcGpRY2QsOGRZw7JK5dGCgCwCZfmUnrkX2ZaKa9Fcolc4yUhGdjyG2hF7MR+zJjYyL/
         I5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435029; x=1780039829;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RAn0u96GfobFXECWbhYR+PuAZ1QauCj0CfUQ4vS80s=;
        b=BhFaa3wWiYQNtpVUYECL1GDfgHRSAaiNH48WYdGLkZbtx2w52aOOBkukmotWlSxkTW
         pVk7EncWKy/PiU+veXxG5I1BDJvFVgs9Wj/6mRSF39QP5spUzyh+FLTp6R/8nTx70lEe
         Lmuy+jAizBVsn0bpNJzDpQ/hv6o+sNdf+5DcTUZgSMko0cfxhim4D34rGzbj5ZBCCx5l
         uR911tjKeuNz3RbyBAiGK4DXzrxeoMdHVqdxW5ss9yhggPIHK9akH7eV+8gBQGhJR0S5
         6DL4e/L+3SduTSUU14dWjQDSEeyCLcTTEpWGJj3IIIGhrRma5cqqYpo4tU8vYXsOtNpH
         BERw==
X-Forwarded-Encrypted: i=1; AFNElJ9/IGxjnJgu8DlcJgI4/nhPuOmzM54wtRWvcsblq/9AZTxzFr3SoydUdhoWNVwzasZLVsdt8Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+QozHh2F4A3cYjbIn/Y4jk65Pwcx6JXGc8nblduDeK2zZQ1b
	YnXD6DhRGevcnhHhGEQkwxOMF40IIVhJ+Fuku33+Ccn8LOBn5PJBlopI5ojsnywEeMI=
X-Gm-Gg: Acq92OEajOTE2UE5zay9K8fLHOGmdRQoiGmZChUYFKZgCt4wTbbLdKzrTAy9VUv97NK
	uMoyawbgeq7B6H8KRRqc9Vw9DvbGLfEhHKKBYdiudeMfd1cq7uzK5XW675Aqx7/6uLFGirN2vmX
	zuSPfAfRCCaXdyeW9Q4959cSbgGzZ60KKkkTmMuHdY24Yi1RzuEco/d0RNsGnNwqVjAckbBQbWV
	jKFXnYb6QV5eu3z1YmgnodbI19K4dgpsi9X8p54k72OdQnC61Dk04CHfkG1+LY89tT8nt4+KxB+
	zJhkIFXDTwtll2Ia7kjGmtDErdsEMFW76oZ9b3F0CyaaRtuNSlGFjIAfEjwZG3XFimUXVleUAU5
	rsz8RoQqepjte8dav9ykh9dkH/AK64CUL85XXF97FP15tVt3qHYWK2RikKRamMS1tPUoKhy6/Su
	2tz/4SlpczUXO81Ikx1ug8avNWQ3RCjjbSg061DdyWQjuVxEHHOCGycIyB8+onrBCiZ+sLk3o9x
	G2v
X-Received: by 2002:a5d:59c4:0:b0:452:9709:40c5 with SMTP id ffacd0b85a97d-45eb369c6a7mr1253907f8f.1.1779435028832;
        Fri, 22 May 2026 00:30:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9de2dsm1893580f8f.4.2026.05.22.00.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 00:30:28 -0700 (PDT)
Message-ID: <5231354d-cf31-4b47-81a9-823644e648a5@6wind.com>
Date: Fri, 22 May 2026 09:30:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 4/4] selftests: net: add a test case for nsid in
 all nsid notifications
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
 <20260520172317.175168-5-i.maximets@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260520172317.175168-5-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	TAGGED_FROM(0.00)[bounces-290696-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovn.org:email,6wind.com:replyto,6wind.com:email,6wind.com:mid,6wind.com:dkim]
X-Rspamd-Queue-Id: BEDF15B008F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 20/05/2026 à 19:22, Ilya Maximets a écrit :
> The test subscribes to link events from all namespaces and makes
> sure that local events do not carry NSID in their ancillary data
> (even if there is a self-referential NSID allocated for the local
> namespace), and remote events do.
> 
> Assisted-by: OpenCode:claude-opus-4.6
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>


