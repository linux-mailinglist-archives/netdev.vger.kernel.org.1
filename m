Return-Path: <netdev+bounces-251570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCllK0zPb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:54:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F949D7A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58BED6253AC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF079429820;
	Tue, 20 Jan 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a988cYxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88653331234
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931586; cv=none; b=f5IEl4h2S8Ckkx6dcdgoNAbiOScBe3RhUGEbnwO48tlf9/E313RoDl8balLlYBouiVmHoJJm47A10QQbagr9Zzg1H6Ljl3ffLhddxuETWV2YCo3jBwt1meb8eAexUBWA4JXxNCEXlX0xFskI2/v/SzCp8E1NyMTTgoRAOXPQ+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931586; c=relaxed/simple;
	bh=nl0W3qdMZBM1vv0gehcElnAQGY7Ctp7Sz0mFRO9mfIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccSanW8lPu5NKEiSBW929l1ZlrtZbcjOHI68EvefP6VC3ZL71LOrISqAoJ1hBVth8qs6k4U4fEVFM4Up29i9FT9Ri/yL3Oo0hPfpU/bEnuct+RE64KFMVvKNKLVaUQyrTug54yJoC7GrkkXeoNgr/KYCcvb/9OqumHb6DFdxH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a988cYxl; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so10497557eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768931583; x=1769536383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nl0W3qdMZBM1vv0gehcElnAQGY7Ctp7Sz0mFRO9mfIk=;
        b=a988cYxl1+Om4HJ/GWt0JJHZxmwnpLhwDCm046jmnwAfKiL7Ah8N42F03Lwd6L9wHV
         jpvr+CZfA8SjcCwF/a4FOXNlN1pDQ5PIfdbAOAbo9AqO7MmOzmtuGW+nsbHSFJuCJfut
         RsoxEbQKsb/LRbx8AXf/T0TJPksYDM408EsUmZ6vp7c3TFoat4s80yQ5heokSuBqRK/t
         ioZzQ2zUFckQpaCc/mu0fDNsSxtFquL7mOTuxOOSYiHYTeIEf6UvdZ6TM2GQw+qnU9ta
         qYa79xrNvLraq35uChZesI82N0Ejt/7PVVOOMsO9IBy1rl8tuSfWeZKcb1uSASexabG6
         6suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931583; x=1769536383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl0W3qdMZBM1vv0gehcElnAQGY7Ctp7Sz0mFRO9mfIk=;
        b=A5ULOSWrQbn/S9WJRsSEQyEHyHGFGW+zM1AP3bzkdbx6qybTEjAqeMbvfRkvN+t8wG
         8ym6Tv3HIjb9BVqy5bnJC0DF6OPu3etR+X0T+oiJRgIxNm/1K+mdWYUPBW1wet3H7ASv
         1hNvfSFpoTyiYqk4W1IzAxBBi3y9wQ7etUNjzun+MK++K5HNI8qKQEIafRKZsDcueAxy
         mv4wDMwMZBjM6a5ewyosBaj73W/8FW3LQiao4Y6Du5s5iLwLKXUKmOAczuNzwZGYbK5/
         WZCwgzmQHp3L6jnZCDFRiqfwrYLPsQ0+8gWtN9dA8oi9WB54KJFsC7tP+IKtKQ7aICzQ
         VQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4FyOIXxYKOmurCSebgKgQZhoNPwxfTXT+9ChI7PjQZiH+dRIgDYC+0wXm3sgCQUcTy+66d7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4bhZFpdJpotD+LjYEnbvZtC2zsEam5yvor8RJUAsOd8u7xUE
	imEPlu2v1b/QD0jzp1nJq4ylFjkArBvbXgeS5K+4xwnTBqn2RHzf40J0/H3dPjg1
X-Gm-Gg: AZuq6aKBc8nlLJiLJwwpTUHf76xCR+w9uUWsFtpxXdCaynQHjuWPYFvhZhI23NsEMwB
	VTns6Iu1/T6b+ybrkfb9lkg7KRj5RGRAGi4P4K1vCUudFzd/m8q1yjimeK0LwoDI64BTay1KMox
	Gf+LVqJg7lXY3aT2E0MH/ugKBTuWtMe0uhqvjs50h9o+2UbGVgdzyK/PywpYYLKmXdOvhKEc4w4
	BzaVWviOgzkKarhtcHO5sGIwp5wtobig7+GO3REilcSoRAgdCUdd0aGxpiV4vDqKfFwI7Z1lG6t
	hhO6Xx7qYLLGnhwspRUY1jeVPAwCMv/zeliNtl/vayiV25snkEgqQX4JZDp36c5MVYwQ1RRVOnh
	o5d42AzQLeS7rNs4xMyc7w2VmceiNI0s3Hmo43hGHavcFxHzHpP/7dEOouzuoSc5vo+GSxx2rKA
	mz5VOrWnVIXeewejtWM1Y5vbNFvQu3ODqVBpqWEzYo2G2rgtxUj8jVrQ4p2KpmA+fSb8hi
X-Received: by 2002:a05:7300:f10c:b0:2b0:5435:2e04 with SMTP id 5a478bee46e88-2b6b4e8f9d7mr12409696eec.19.1768931583432;
        Tue, 20 Jan 2026 09:53:03 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b365564csm18083233eec.27.2026.01.20.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:53:03 -0800 (PST)
Message-ID: <a59fbe952a4e4072eca8e3c6eed6d960307f4b4d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of
 bpf_get_current_task
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, 	dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 09:52:59 -0800
In-Reply-To: <20260120070555.233486-3-dongml2@chinatelecom.cn>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
	 <20260120070555.233486-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 086F949D7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 15:05 +0800, Menglong Dong wrote:
> Add the testcase for the jited inline of bpf_get_current_task().
>=20
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

