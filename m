Return-Path: <netdev+bounces-258068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD0qFi4ci2nSPwAAu9opvQ
	(envelope-from <netdev+bounces-258068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:53:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4411A6AF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA3EC301327D
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F03271EB;
	Tue, 10 Feb 2026 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxYnvSBJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwDccQIL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D08319848
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724393; cv=none; b=m6bBz2MlErQ6WIHppibubvt7VvMyi+hRt9ueCglS5ai44kT0kggnPP69SXGTe6MmKURu59GKLH+rxtffEnEUAYuIH7QF/LXErltJUKNiIFuaFdnvnOlTgJAIuKKsnI6FfGblIRst7OwWv48aG4DeiEGC66NSo23aSYesgoN3Qm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724393; c=relaxed/simple;
	bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aruNSBQky6GSEORRVSdwB+TDl+bqfPbFIGxZVyUAsoxvgPGsA4Hw/Et/GMh0jfU8OkqcwcjTqtxOK1dUh8TFfCNVjAF959ZzvYxwQuf9m2GEGMV2axehxJkWaA1K0+cxyGdxcMro9YFGjqHQygMDARyfLR66f5TzPvG9Q6/jizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxYnvSBJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwDccQIL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
	b=RxYnvSBJfFWeujRnQcARi1UtqbTuaq07DcC+zxQ9eNTpo5Cks94s3/09CD6g9qLcKFmhXo
	Jg9Thhsit/8NUT3ivzIu1krqTrSV2vpl0R4bEHjU83q56lVLaiiD5yU3x8vZmW+qtr9dYk
	sejYz/bEbjQAS42vVqKy7fhkFTMaqdo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35--punahfCPvWgTZZ-oi6-QQ-1; Tue, 10 Feb 2026 06:53:09 -0500
X-MC-Unique: -punahfCPvWgTZZ-oi6-QQ-1
X-Mimecast-MFC-AGG-ID: -punahfCPvWgTZZ-oi6-QQ_1770724388
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48071615686so6450665e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724388; x=1771329188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
        b=VwDccQILtoPONVQxd8Cto43gtIoE7hyb3RWyJLReOtBRBmLYiQSRiXFZS3c/J7QjmK
         7W+PCZPT+BkG+QLEDDYhWp6ienIViwzeZaJGAt4Y2HEgB1J4M4bHC9XTj0cUuGqFINrX
         gKWKdR0irnAnZO9T4IZuI+5KYFe91hCqK75vXJtEobqLhLc445k/Q9UHneZsiA6KFnV5
         3bqG9WpEGS/t5KPmS8NGdeHkMSrt422dtmArLEUDDMzPrRli8d7f4YXj0nFhsdF50DxI
         YcG6BixRhgr5sB3B/h0o5Pt4LXuYZ5M1Y+pyGTZElHaPcdTUpnWcq9biPblfEGcxwZ51
         /rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724388; x=1771329188;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
        b=hQHpUkX4pgi/rCKVuTU5hpSXPp2wU8WqcjWQqcp8+2cJ8jNYzrA7pUcUi01tTbjMIo
         QqxaRRYYv2CxgxuDLjzaFaLbr5KYmS5M+3bncQLlYi5j3g98c8fZaLq2Alj1bCvnShAq
         BccyXsEtVU+oQzuO3UBCMenVRXt43GS3IfX/aWr5Vm4KyRtbnC1P/Qz4jK5GI5em9m9o
         yHpShP9gmIYlSt/eUpQU5wXTV8AAA2tqxbCi2jKckinSW2ZmXB6ws25BuaMZkGM2uuvH
         4t2PbjHZ/KleDgfu8HiKgFpZUUeJhtCjk/3fP74BikDeI7uetdOj8IBSwFN5EM25LYKz
         ERog==
X-Forwarded-Encrypted: i=1; AJvYcCWIvidMqNvcq5SBL39n7g2yN9N7df3lqlIqUVXwGRh6hecx7uqIlOg+zsJulJoFluoJCJCCOrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADUqkhfsIL0atcz8N8lLKWyKfvTTN0obzlgxBe0NLOLz/2bqa
	UnQPmsuizZQbfA0G5NKi2CeiaV7tbX5AfX3TEUdSyJKZAih3wOMNMvT5gwMsyBoP6invLx9rXTM
	n/zr56IwGcYOPSAP5JZBYHxf3cy9RYEtmlNFpqG4F0FQiC5mv6y/6Z8m/3w==
X-Gm-Gg: AZuq6aKbXSyCT8On94+J6+g+hvVsSWZM+wo2b5DtU2Izm/CEJkx7QsuW4/a1L9/Is2o
	MyaSX7A6QI9XG1//SVo53e013zphiKeobC+z0fsbLDnn3Vur4R4J3NZ64EFYesnuvMwaIHDucU6
	k3Fw+iuQtIziD6P6xQCA42wlcjVBcUAbtRP8FlnMJu4YWd4RbREHxIAZNKF79xuGCPA8Q4Fcds2
	onS5IA2/shIPcTjEFtOHIbnUwQfrpaaJ0zUDjVyNqpmeqAuRHMUxLqBjucPvDOBgM/Sj9UNnlek
	dynG6BBjkzRTj74NGt/+VcVFvfSKJjqB7rtSHYeIlRoMpaMW5CNvWIEfS/IvtXAHFuN1rWMauj8
	jyOYsATrmVvA5aFYzjnr1BOD2mVAXrSZ9l8Xq6w/POnoFKHQf
X-Received: by 2002:a05:600c:4e48:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-483201e408dmr184790585e9.11.1770724388257;
        Tue, 10 Feb 2026 03:53:08 -0800 (PST)
X-Received: by 2002:a05:600c:4e48:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-483201e408dmr184790305e9.11.1770724387866;
        Tue, 10 Feb 2026 03:53:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm323555505e9.1.2026.02.10.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:53:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4E89E4FE89D; Tue, 10 Feb 2026 12:53:05 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 4/6] net: sched: rename
 QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
In-Reply-To: <177039508262.2258217.13751577312338706877.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039508262.2258217.13751577312338706877.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:53:05 +0100
Message-ID: <87v7g4yfvi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258068-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 11A4411A6AF
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION to use a
> generic name without embedding the qdisc name. This follows the
> principle that drop reasons should describe the drop mechanism rather
> than being tied to a specific qdisc implementation.
>
> The flood protection drop reason is used by qdiscs implementing
> probabilistic drop algorithms (like BLUE) that detect unresponsive
> flows indicating potential DoS or flood attacks. CAKE uses this via
> its Cobalt AQM component.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


