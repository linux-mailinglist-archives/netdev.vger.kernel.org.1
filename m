Return-Path: <netdev+bounces-262207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGyROgZco2lpBAUAu9opvQ
	(envelope-from <netdev+bounces-262207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:20:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F41C8EEA
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CAA93349BB3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85613176E0;
	Sat, 28 Feb 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ay8ef+dD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845E313E31
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772308308; cv=pass; b=XV1DBM++FA25QNzUX3zUkul6/rAufay3ZMbdM62zjLhXsm6HZoyd5sa2ywqf+IM6aRNWD1V1OuK3jeTFgvNsB8h8cGShAV0JS5IB7lAGwuHRT8s+j7R9hI9uGIjlX/VXdAubNf4d+eyZjjBpnZjVLXy2QjxHyNYl6hEFvqkqHt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772308308; c=relaxed/simple;
	bh=0aQgke/36F/Q4be2OdMfZRRQ35gNR4CmEwjlgme9W5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6btSrUc0uZ0hQ5FtfttqwVcV3mgkInzlOBaIgOrK4xI9Vd4mvqbXy/+j3YZTe5p5Z8vIr5wj0kXYegEFS1147RnO7jAGbeiRIfI/WcSgdoHyUJW6S8m2nhh4pmFeCl22AIFSBOquFKHe9/0srSmWuOd2jzJcdjFppAnuyBsz8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ay8ef+dD; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bded9bf7a7so1341654eec.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:51:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772308307; cv=none;
        d=google.com; s=arc-20240605;
        b=HZ5Jtg/7pcvp75bxiLmvRPgQV9B7Dv83gqBvsk9U8r3Thhnxq5YbGa0Cw9Z1HCNHSR
         nygWO+0RpimgtF+DzqzWP2zFH1DQ8RmjaY0EPK/p7JVD/P1TUHuiF/I4j9b/ohtv/kGe
         lNUHNP4YZ4nNdj155qync7pq+Irm3mJ0KhyyQjaS4JbAotVZN3+Yw1jRDtpTd0EBai1o
         0qV+zsXY0xnBYpRcchBD9nB9U3FQp1th1Uf3vj3/v3fCcRT1bWJYK6Fcu0NR1fRM3Qg9
         dKxctec0OnrBxwjv/0fcWd9ozuCki47LdNlBhNBvk0mncONHGbQgTX3aQYw5Umyl7jPC
         s8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0aQgke/36F/Q4be2OdMfZRRQ35gNR4CmEwjlgme9W5c=;
        fh=6mwjrH4k/wEFPuxoxZHDOGbQJ3qqjZvdDoufW2bryRU=;
        b=YCnF76EIjd7p6lRGGR+SttPx/eUY4usizZG8AYaHZVCNWE3QT4RzrFCKiutgzR/Woq
         FJk3Ktlu+OsfkCl6py/eKwe8v3evy7eidkRACvIRijXmBNEqhmZR7F27rQFWuTqc1LnH
         yezCtnRMpAlHln3eXLP+asOermWD23Z+mDdLCCGmitcqwpUy0EHC6s4YwcOgNCdbDOxE
         doRWpNamgOhY5PmQBbqjlVrpDbzP3/IG6Y7rFbneCQBzghEORC5NJbiAwqpuS+yG5PzW
         Kl4j6cmRyD7TNT0Yu1WMLBgxozaXe9y8RZIv66MzUCEohJFAMh5zg6wVxKgGh08r8IFU
         Y7AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772308307; x=1772913107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aQgke/36F/Q4be2OdMfZRRQ35gNR4CmEwjlgme9W5c=;
        b=ay8ef+dDuOvDxmeC1oVHmY430KqBEAgeeGhM6g2lzspENuqHStbl2HO17EnDvzHPzr
         x5go2WGYn9BVbrzOPPcwVoJofXdqlpEF9u0YNyjM6QR23pm+lc+xaUfI6qpdDhwOKg/9
         wL0xHQwpa59N5g34UAvOZ3NXu4afnLtivA14ZCxr8w5i45pqCqpkUMag5z8q0i49thsa
         QtraPzOInX35/YMPr1iFJEIhoFP9Jcs1WUd+6/IPzazbZBWBNkwAJFoaz7TE7ZVrYAI6
         AxxuOlMbbREHt2VmGCmMif6B01CE2IICPLglwUCWPZar/h1ORCMgglajsSHfm4T/Xsbq
         q2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772308307; x=1772913107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aQgke/36F/Q4be2OdMfZRRQ35gNR4CmEwjlgme9W5c=;
        b=T4XDC9UMsKF7nkZk4PV9ZYm5gIBv34wyp0edv1yoAEo1DEEw3UmnkHGe2J8vEw14ky
         iq4fwJ731IYmKKDbkDQc0rJyWIP8lhSEt7jDhquO8AKLeUpeCaMnPMAi+Nyb2C+p0SqE
         ZLct8FdaABX4q3pyc9ZKembyGR4u0y1DoMYAm71W/HDaNz/4x+AICW7KQtttywk4TPY6
         624NDbA//4OfdIUSmDcponL2EOlre1VIk07i11Wy3Wr4avbobY6hfD7htk44xGi6/MZY
         XtyJjq2Q3xOihpUL1lLYuoBPYtMU1kuyDTNvnG12eYjYLEJB52EqZbUZDSRvAlp9uLJE
         G7jg==
X-Forwarded-Encrypted: i=1; AJvYcCVXYULftF4jZ9KED8XNKAIsfvFZo5mwOow6D5GWvf22BcmT3XXlHiKElF5kkllaH5qN+EeT2Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+gOpw0QLTDeDRQHhGq5R8subRhh9LyBW4yWMpV4TTyhvGhzE
	Ljtc0JaZt+zgy2P43d+5qmw0BxHt1MExq3eLPyBHCxE84Lvo6m3Ph+407OE447NPIsHoX80AOuV
	6xjJI8Clw5cohu7E1+BITLPx97EwKCf30zV+r1apk
X-Gm-Gg: ATEYQzw26sF22qfYrrvb6rsz6qY4nqYmXFQn+AlszzRw4TTAghuPMQwwk+zWdbuyLS0
	SDjXr2NG2O+iitoMqnff2a4BGuCRoI41/X3vmewI02aFXyx3Fjp1YAUvBIexiSgRGlwWUF+4sSW
	pq9ZH8qMkQw4ja9w1u1eyzIhatZiTJqlJV/7UGjcKIED+IpgIq3HFRVo9564KXM11GaWfibDB5o
	PK+K9sF0DAvl1K0k6rJW3e1jtA6H7f20L6Zf27/5dJrfTM7vLN7uiao3ujHIaHOH5L3gOBiGIqh
	QK1QeC6swI9r3Y9m0vhffOyOJQ3VhHwMkiCdvFsnh6YQ5wW93rWZiGuFFEl8E+RjOQDE5aU4
X-Received: by 2002:a05:7022:128f:b0:124:9acd:328e with SMTP id
 a92af1059eb24-1278fcb60bdmr3015746c88.27.1772308306062; Sat, 28 Feb 2026
 11:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228141252.435509-1-edumazet@google.com>
In-Reply-To: <20260228141252.435509-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 28 Feb 2026 11:51:34 -0800
X-Gm-Features: AaiRm504rLtb7hTGoMtcuH3XFTWy78DJIWOper8qqIOiVwC6TUEKYg9DpgvMTrI
Message-ID: <CAAVpQUA1fAK2j51YZf_8UtsVRnXoHCNUa=ovERrPdjYiXcfk6A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: adopt SLUB sheaves for skbuff_small_head
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,suse.cz,google.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-262207-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CE4F41C8EEA
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 6:12=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> skbuff_small_head is used both on receive and send paths,
> serving potentially 80 million allocations and frees per second.
>
> Tuning it on large servers has been problematic, especially
> on AMD Turins platforms, where "lock cmpxch16b" latency can
> be over 30,000 cycles.
>
> Switching to SLUB sheaves fixes the issue nicely.
>
> tcp_rr benchmark with 10,000 flows goes from 25 Mpps to 40 Mpps
> on AMD Turin.
>
> Other platforms show benefits with tcp_rr with more than 30,000
> flows.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !

