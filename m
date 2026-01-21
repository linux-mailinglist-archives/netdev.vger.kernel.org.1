Return-Path: <netdev+bounces-251836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC2EIxSlcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:06:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F3354EA9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6012760669A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1F47A0CC;
	Wed, 21 Jan 2026 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RXGCbdmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E203033EF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989248; cv=none; b=CNXXTAt/DX9eDf+JsansP9UdiKAkiP1vbaPwrt/P/GZZGmWgmEXwdhPgK9WDY2QiR9koDUkhy4Leij8tCs8Rd+GaigZDJENO7O2ro0wPFzjCsr5df8jlYBHXHCp8X8KWl6sq8DaLydXK8HpP9DniQQd85MpEb8Ti8W1T5bXmd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989248; c=relaxed/simple;
	bh=NTgU+udkmo8b+bys+frUyrVCx9K0iFIwxoI71xMSPM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTrtOAvVprVXi8UO/JvZ9aj2Ak4fQQKKDla713p1ZE5fibtSqQ3ZJUfwVUZ9jcKTK2o5o3rP560fg6VHrXLz1h5MfOaXT6y+Zc5LogTTNYUDFlXy791K+4ulWdqTG+LqgA1Xpit4CBt2n8DSLSiKaGwUYKLoayNOWrUC8K+wlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RXGCbdmr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b86f81d8051so111199566b.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768989245; x=1769594045; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ekpQy0hYQiLZMiu4CpOE6p7zPKqu8L39urLy2shV4+I=;
        b=RXGCbdmr9/D/mJ5FbZbFN24EUGUyaWqh+RAny1ML6NCgVzhFJ/jUDYtLBB1/ooCaUx
         S2m1bc32x/jvY0b+xrlUu7vLT1w4VdCIEx45HGTMY3v0r6fWSI2ZzQ/g7eBsxvP9bbgP
         GGIBB1SGQqkzmYT0uDXYNt+paT3r8pSNPNsHoSwopTJ9W5HGQNh/SdcJMrLnxsumYcgS
         qLatRrYcYdB+7+XSxCqKJgwC03yWyI7179L/K5Vqiw+vJGBSuFV3qOnlrJRXwDUPpe7T
         cRAXuCOEwOr+zVDqLRDNdvq9DPqgkiCSy7mcm70GaljmPD1gENeUlb7uvstoPveEz58/
         LPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989245; x=1769594045;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekpQy0hYQiLZMiu4CpOE6p7zPKqu8L39urLy2shV4+I=;
        b=lR414DXtz3O6BjRl1VXuDLDcv8thFNuI/6YdRacBqv8AAb2WFXEeNbZMf5cGXzaDLS
         27xOD5jWTNcCnj7nD67cH06Yv2wcb44H4RLmPrafcfxC0wHc46CnTPTAoqbZf0s6A0/X
         rpkoNQ7PxGf2yo+wVEse+Eh8R3AlKN3bFj4Eeuq3pPMXCAGSDje1WBQ3sD5y6qS2VDyC
         xa1wB1RZsObt9QLgggoPCWerliP06ra/rtUvO+c93kRIHn03Wm2K2ubEcrcMl5hGCZKy
         wQfurYFvXbrbuEjDRX+ritRXWyQCOw3o2j03WVjm1JquToY2k5LnRsFLDwWkz739zS0d
         PNew==
X-Forwarded-Encrypted: i=1; AJvYcCXJGvivEoFVksrPFGMoQCGLrgsN3d8iJULKtUUrP9qAweRhGTQEC1GmXmjbYXNMrDsg/T2HLAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqpAw+8b+ZnKdPToVlJZMxUnpw6iZT7wy0uhbAvRBQZrtUiyU
	U+nL4xD0+AVVf2AaD1ldDkxu9T1ylEj/E4Tt7N/kvsU57V40Lyt6hH+E+8xN7e0zirw=
X-Gm-Gg: AZuq6aKIrJPlmLn52GAZJgCQyeRddHvzWZDSL1aQgh0A+o2CMkTS3AZ5Il+LujKe9IP
	oe8CAczJ5try1qUolZpbdZOllq/CRMDexTZ+GsAOVwVXJS4F34CfSuGQdkDZ8X8NubusJmteNdo
	P3YE3PMEsl7z1CJikZteevJyfTmR37GWkw/GtmRwdbpyxiPKwj2iM/MM61YJMvL6kp1vscp2ncw
	SAQXyTjEHdaAw4Z8G6m1mqfhCuOTDNm5e4O4DNWwzzmVpCWJv5WxVRKIUq5tQmzd01DJl3fN16F
	xjGMCMRnR0zlabjYIFIsiaAnLuI8jarMeAYM4NXoPQTE2p4Ew/CdrHKhn7xjZQhAYAcinSWzSMo
	vI2/Gqx6bO1HQD5QyudisKGgVR07yFFIQEmrsq13YVtYmH5i1vGqWoZpFpxDCHYSPliqe9ueQK9
	z+Fw==
X-Received: by 2002:a17:907:948d:b0:b3a:8070:e269 with SMTP id a640c23a62f3a-b879389056fmr1832883466b.14.1768989245421;
        Wed, 21 Jan 2026 01:54:05 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a31fafsm1474473066b.66.2026.01.21.01.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:54:05 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Amery Hung <ameryhung@gmail.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Remove kfunc support in prologue and
 epilogue
In-Reply-To: <8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com>
	(Eduard Zingerman's message of "Mon, 19 Jan 2026 14:55:29 -0800")
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
	<8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com>
Date: Wed, 21 Jan 2026 10:54:04 +0100
Message-ID: <87h5sfthoj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251836-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 58F3354EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 02:55 PM -08, Eduard Zingerman wrote:
> I think that patches #3 and #4 have to be swapped, otherwise there is
> a selftest failure when only patches #1-3 are applied:
>
>   #281/17  pro_epilogue/syscall_pro_epilogue:FAIL
>
> If we want to keep selftests passing for arbitrary bisects.

I don't have an opinion. I assumed it'd get applied as a batch without
fast forward, so bisect would be going over merge commits.

