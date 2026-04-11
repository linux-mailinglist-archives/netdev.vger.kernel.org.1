Return-Path: <netdev+bounces-277671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AjqXL/3l2WmhuwgAu9opvQ
	(envelope-from <netdev+bounces-277671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:11:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7E3DE822
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63BBF3016514
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 06:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02330EF91;
	Sat, 11 Apr 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHqy0YZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D262DB7A3
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775887866; cv=none; b=qZNqveoEHfiWKSM4KH2aO6qcZZotYpgJGD/73fUKPFfFUtCwfQzGKP8KBP3Vn95LWoF99rJdtB4uqQiE43Pwwe5CK5GCriDHd0Xp589i0eyipN25yF96fLOmVwTRXCDRzmcRPraHG+ivW+cZQ0c9VkSxsmr4JDQMNWW/THpczog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775887866; c=relaxed/simple;
	bh=cYL4j3V4ytdXyZuUC7kV8oR2EFEG33w0zTt0g1Ke2Mo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZRcqk49Hx/4l0QqELit1y3ifL+/Qa7NX+ea8Vj9VphtyGbJj3PYGbS1wyVmImvBbh95lJgRFsTCr9O6l3YuD7Q0tmWPhDSNGDkZuAguI7O5IjTdl+p8D5LyLwkI+aYYvD3mtJGRtn61VSTUaJre8ZkYWTOIsa5moM5Zbbxv7Swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHqy0YZf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7a299d84b7dso20293307b3.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775887864; x=1776492664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/eTqprS95K8wlJFF8+XPts5K73Fqnj28VTy+rHT1rA=;
        b=fHqy0YZfOrFx0++GBzITpAJRe1dwa/6F1o9uCZinBD0eOozbaihDEGurdGwhYEM+xu
         jIAv0QlCGepim1HP9pFA2NDnycUwTYaSokgMxtE4WFIgqoTpjUMB7Ph8Cn/NfcxiruWu
         tHZPrU+0HHhjpFzUujeI8cPSQhqXQrrlKUT7K7nZypE9Yv+HSZ8WxY+8QzvpFJIofE89
         +X2o2knUwIe/Spa/O3TYyPrmIS4tZj/qm1ieYYHpyM1cnN4ipgOKqlwIirHKOFYW3IFM
         0x2iVstgu7SobbmNPZx2KlvbO12Fl5B/NOcXDLGb+tiJWYtRxqqVjsmUWE3WaQi6a8/j
         z0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775887864; x=1776492664;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/eTqprS95K8wlJFF8+XPts5K73Fqnj28VTy+rHT1rA=;
        b=n8ZMflwdOOlP0UmqM8/TjPUVhOwgb0//OORXW+3jKt8PNaVP2p5oqUt6vSJHPhhej+
         I+y7vMYF2IGjXbGgK8QGOtSQaujG5PHxOm9dEiVSpqucEaN+Y2rFM7L5NoOEY/PXnGLt
         2zcOyd3fi8ZKrEDQ8vZrrAnZ4pKKx9ufnKH7CvD8o5dDvJ0f8QLBTXB9BsLL3u8qsMo6
         b5ARj3VFmrldYQwd1D5OtyGobH+5nppWMVc35O+FVdlo0/CSUvt7A95zmNLl2JTfOioA
         1MgYGmEnSVu6HpHQvkqZsM6KgbQBXUP1Pj2lhfuQQtxXP5Y2ummhLNqb/NjtSTDs41/+
         OMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe0P5MhQmFUY0hgishTJPlur9mCJm/eVpkEZnLlp21z1PHWORdGlF+zyMDtrCVnQOBC5uXdW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGejKeAK6X4VA20Sa6iHI/0/5DZpHyyks4JaaFK3K0ZAA3uOif
	aCr5iStE2D/vLfxgwkiWXo8pcAyUa3IFbOcOwM8XETm69fztySK0GrkN
X-Gm-Gg: AeBDiesjsacRkYv+2LPleg7N89iKgOjthFk1KfUCGM/Na9fdFHDBp5nOaa81tvoYqZ4
	5nS1vgTcGP53Qkn6W9Ah7yAgICi0JcI4QIeVtCNnza5m8HTPFm6JnD5QUVBy/jo62DtgMrHVp7i
	yIgKyKMW82xcwrdyNYxUx5eCDCPgTTb5Jkme/WVElMiD92/nCIBnGlXbobl4aMNvJCGNA3ugRtI
	jkkHirhWWue/jtZDJ9lzYi7nKvR+AZwpe5t9merfY1MWW9xv0auH+9yHeGR/fUMLlbVFRzrboz9
	J7zstONSSgUqvvs9VNbuEm0PY8zgNQgZgSFuiyrzGuJp7bSyZ3bOZNh3WGPOJ8/VYTU2HfHrMxP
	0umOSkJbF9nQQAHkSVaaTTuYxnVV0rn+KbjNYncQxSSyVJbHXlalEm9dC7KZa+X11TRZY5u0sI2
	wxvV2xjzB2ObfVgQRtm8zdjM2kmEE/DfF508Yzc1gN8Vo2Gh5DucOEbYOJPyBvAj3NezQWrMkzP
	cg7
X-Received: by 2002:a05:690c:e3cd:b0:794:cef6:64ee with SMTP id 00721157ae682-7af71b53a6emr62867087b3.41.1775887864494;
        Fri, 10 Apr 2026 23:11:04 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8deca7sm24992327b3.3.2026.04.10.23.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 23:11:03 -0700 (PDT)
Date: Sat, 11 Apr 2026 02:11:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.1517cc562819a@gmail.com>
In-Reply-To: <20260410135736.4bc7ed46@kernel.org>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
 <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
 <20260407180432.102073cf@kernel.org>
 <CANQF7iDj1E6=3pod078-++5wbweyMg0H7gpeq0kbGFZHNytDdA@mail.gmail.com>
 <20260410135736.4bc7ed46@kernel.org>
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277671-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0B7E3DE822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> On Sat, 11 Apr 2026 01:06:06 +0530 Akhilesh Samineni wrote:
> > On Wed, Apr 8, 2026 at 6:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > On Tue, 07 Apr 2026 17:37:41 -0400 Willem de Bruijn wrote:  =

> > > > PSP defines a 6-bit field in 4 octet units. Does this need bounds=
 checking?  =

> > >
> > > More fundamentally, were we to support this -- is it a device prope=
rty
> > > or an assoc property?  =

> > =

> > It's a device property. All associations under the device will share
> > the same crypt-offset.
> =

> I don't think there's anything in the spec that says the crypto
> offset is device level.
> At the very least every L4 proto may want to have a different offset.
> We should probably hold off adding this until a real user appears.

On how it is configured, the spec says "The crypt offset can be
specified by the transmit descriptor or by configuration".

So some devices might indeed selectively set it per-packet, e.g.,
for specific protocols.

One real use case is network telemetry, exposing the inner transport
protocol ports. For that to be useful it would have to be enabled on
most if not all packets.

