Return-Path: <netdev+bounces-258071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDA5BQYei2n7QAAAu9opvQ
	(envelope-from <netdev+bounces-258071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:01:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E563811A7F0
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 215473008C05
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5F7327218;
	Tue, 10 Feb 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADRFrgf0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kUN7YN/i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7B320A37
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724861; cv=none; b=oYC1IeLDNi9hwwaU1m3siB7Fp6L0kNWrhcXbFcinN4KWmuhZK1mJKyFitrI9wEFJG4HHM/5ASPuuVnswo2JX6yU7d6Onz+ojS0cCIBUDTBoaEBM5H3DAA65TsvwcQDSp+S1erwb/nVWes0sRz80vt6YjHxxxrnCljqCYbtd8guQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724861; c=relaxed/simple;
	bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V87WEme212qf82hVVbZGaS611zBJv6gwUpTWg41lECe3Llm2poeplRPDqSuQyHL8NzrqnfH5Re26BVxrR7Nb5OGsVIB0Fwx61CjcArO9aqFzcl53m+OxePW3zgeZnKZI9ZKuXJdAUc81F0z/6w9vf4uIFk+Erzx+MKL1JARisTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADRFrgf0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kUN7YN/i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
	b=ADRFrgf0IZSeAYfhFY2FtH4ybwm8mw2A2v+QenUvdNcCC5RB6bCOgIIX3s4jYLzyPzgllf
	Hobfd+sjlqsM2MYAEYfEn8D8vOku+vrmucxEVy9jsi+L0Vk6/fkuOD4VrmAPDEnJ22eOFH
	LRoz84DbfSFuHM3Xqr5rWxiBTzPA+mc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-2y81IbT5MyKIy5SMN-Gwsw-1; Tue, 10 Feb 2026 07:00:57 -0500
X-MC-Unique: 2y81IbT5MyKIy5SMN-Gwsw-1
X-Mimecast-MFC-AGG-ID: 2y81IbT5MyKIy5SMN-Gwsw_1770724857
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43635708e98so1521985f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724856; x=1771329656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
        b=kUN7YN/iouu5rY84KQaRvw+PfCR+TVfgTc/9zfUGez6na93nCCWljgm3n3+3X0yuhR
         aACbbV7l8BevDzOL0SsmYz04jkA3LJbpS3tje2K44+0t+gjtUlE4HeEQ8EP5upQVZafY
         iFc/Z0G09CUR4c2RWfL47GlErDr35HLA4c8sXpIaK1NTzrnPfiwV3xqvo1aqiA/Qpn8E
         dymS0y9Fn422V0K/7oJxJVYN2+eh1p7jM7xuejKl2ZKaP0jDmx+BSCvwizXuEBvMG96X
         UfEl94HHj9MKNYBOv4sErsJ9ZlfQOyqLZF5k63pEPya3bmo1qe0PP4k5fFrCXJkhptuc
         JZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724856; x=1771329656;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hveGr/d+FQYMTlccMNoSD3lD1Dur23sNDD8P8EjZjNc=;
        b=Xl+/UlDwoLjyU3UjnHw/6bm2r5uTiq6ZlG3mnzan7s+lZQmppPsZAUaSn+J2XMFyBm
         2bcSS4ORYU1CySfcAGY6U4VlfONE1d5/n6G+MIr3gQ3L0FUPRTiQOVEfj2fpvFBc2R+x
         XrI+To6vUjAX2yKealQp8Akl6r42Tzp2YrtpQvEzqxRxJ9RngvXwD+PQ9M6Y7Sjj/Y1J
         I14M+69aAGiu0B8//2Zh+qyl4AEx3mOwdvmtumwzvA9SA9UJO2/Y29zhsV92i3M+HIPm
         hG8ylz5cUoUWSQjF6c1YW3AmIZ9/GQqH+Sj0G+a0URaX4+nlE9zPd3ffYJX4a/O7+ep5
         J6ig==
X-Forwarded-Encrypted: i=1; AJvYcCX6s/eFoxQtozBG7pxSJsXjXKS6y947k1m7YXYgnhHj1/Q/XQP+79U6ukT3rS6fWt270y8Sd1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5ViloZ1rscgXAPHvDwOlGaeXDlUiSgZgX8s/dfGcWU5rFfRt
	7Hk7+rWpscsSs0imJBJSaL8VDFxWsqSn4UlHEYZjkaNy5utk2YnNsbbsD6oPMa4O0zE3Wo1n+gA
	x6ttLH0nr5+QeDfmQ8cGbbOCcShx2hXUrqiMsJId73eGkL24CjowJefnIiA==
X-Gm-Gg: AZuq6aLpRON91/ghdDxHCdgf1VQV7BUZW8HwjuqE3HOLA1yxG0RoqCCtAos3CDPkh4j
	TwmOKTnIx2KvU6QAAdH+NHJx34YaQ5kfR74xclRrF8HgAUIhD+NFjbhhURBq03n4dVYhcn7ie5n
	5+Na8y/QtzLYo9fOBW1vJkVIz16Lqsc1N/VxfcnFHpAJxSY6xdXh37FykS9K+FcQbnosrEcMr4L
	aqmsxRgoLpgxc/FXOm8WGBHRbMdPi2zauGrqhRHjjXtLMWuj/cIknLmC/DwnIsy/Q9mF5NzTlw0
	pBfc/L4bf2/iYMr2KlXYCWSBLp1GqjJMdm4go3mGTAsqY8Un8gjRidWGBjH2jASGNEIgWqD4rQK
	YWYd/pr95LLgQ4DosEvzk7R1G23VhOlRiHirZgJ93GOBLEQ==
X-Received: by 2002:a05:6000:2601:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4362938a448mr23078114f8f.46.1770724856493;
        Tue, 10 Feb 2026 04:00:56 -0800 (PST)
X-Received: by 2002:a05:6000:2601:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4362938a448mr23078050f8f.46.1770724855993;
        Tue, 10 Feb 2026 04:00:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376accfc58sm18883666f8f.16.2026.02.10.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:00:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 65B754FE8A4; Tue, 10 Feb 2026 13:00:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 6/6] net: sched: sch_dualpi2: use
 qdisc_dequeue_drop() for dequeue drops
In-Reply-To: <177039509565.2258217.3624858167198291525.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039509565.2258217.3624858167198291525.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 13:00:53 +0100
Message-ID: <87pl6cyfii.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:query timed out];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RSPAMD_EMAILBL_FAIL(0.00)[hawk.kernel.org:query timed out,toke.redhat.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E563811A7F0
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> DualPI2 drops packets during dequeue but was using kfree_skb_reason()
> directly, bypassing trace_qdisc_drop. Convert to qdisc_dequeue_drop()
> and add QDISC_DROP_L4S_STEP_NON_ECN to the qdisc drop reason enum.
>
> - Set TCQ_F_DEQUEUE_DROPS flag in dualpi2_init()
> - Use enum qdisc_drop_reason in drop_and_retry()
> - Replace kfree_skb_reason() with qdisc_dequeue_drop()
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602061240.CRDtcOeX-lkp@i=
ntel.com/
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


