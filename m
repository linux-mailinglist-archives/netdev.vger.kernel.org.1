Return-Path: <netdev+bounces-304556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DTCgFiO8R2qxeQAAu9opvQ
	(envelope-from <netdev+bounces-304556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84778702FD3
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:41:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Z/O/yb6E";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304556-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304556-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0AD30A3FE9
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2941E3D810D;
	Fri,  3 Jul 2026 13:31:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767237EFEF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:31:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085517; cv=pass; b=Liu3LXYYp0Uln7umAegq1k0zdo+lJRNvrPukn+4PU8wk7SmWLJEGWzlQ2AdAoLDtXXtViR5/TPQjQNEzN2UyRIaJew4o2YRN5pVjWJGCElAaq4W85paq0iKa78KuHeAzQqCiotJCk+e3BntitYdIH3zucgPijo/CXVFeVrr+Ks0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085517; c=relaxed/simple;
	bh=Rs9iGR2bHKFpwo4peauSzAgzh8atdVXGd7+QypRLV6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1wVKbS4GrCm97b4YsGkcxQ0m+lIyWcwjwfJAX/Q3FYJ7jBmg2K87zRcQamQj9hC1g5tdYHGu5lCxf7GBtlcXZHx3rnTgKN0MuIguGB5u8yoPWfNr3xt6syaIoslMz2UjAITWhxLY1f/5QpXM8VbDKYlgmp7LaJPZ/PBBMSpzUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/O/yb6E; arc=pass smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1268f71572so244335066b.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783085514; cv=none;
        d=google.com; s=arc-20260327;
        b=FEBf7bHWfShHhzy0n0Vd1pRDFwnE2dF8YLWBc6mPF7EMs2Mdlqtcw3txUPR61EW6Kp
         zGfLnf4gthdSNpZba2xct3Gl1zUVY085KWP8J7nmVaAxzbtx6r0o8fgp6z2j5tHjOBD4
         jcqxZ9QinwV6EcSoWbWGXtzpUyCVbhLeAeAdC+oDJb3wD//iZOBs/+hImG2uh0uEwz3S
         5lQ3tFsJSEQlblZTZPPnxOYVXQ7TpZsdBXi8F+AWzsB499PNBhX0iSYXfOrNlxL3UDYF
         56gn6cKVLP0IXRQiMm3bK3pBK/lreDq5Xxv+EngP5lGJkqo9wd++LgQ6i6Z+tCzNtUKf
         OGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rs9iGR2bHKFpwo4peauSzAgzh8atdVXGd7+QypRLV6g=;
        fh=oo8SV4DMo4jd3OlPbjlslM31K5EdAm6zBGya/QhJ7YE=;
        b=qFKC2ShyDVstGy54CPS7Tiqt7YLZM2gKXAfWNjfyMFY5yvdIVEPF4+2Mtv4WYi4n1S
         U5xPgUOGEZqsYFHTnEvRS3OaGojECJMfF/f+ouNgcPmu/9P85vcn4stTRKoPTZ+D+cUc
         hiqhSVvuYYpCiPr2wyKh3Iotd4dldWiLWm0uEXzEAfR6+7lFwpp3EcUwLXH6y72UQEGY
         maVarNDsqULHAtcDrQKDPr7zNxceHR+KHHj4A288/gZX8FPuGi5vDkUFhyJFmXXt4Tei
         0brBP6n+tojjTADK3P0BV+wVwIwByNdAx8sYKR/8dxRMfXkNauszWMtUSr1PPyqRhqqK
         xhTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783085514; x=1783690314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs9iGR2bHKFpwo4peauSzAgzh8atdVXGd7+QypRLV6g=;
        b=Z/O/yb6EuXzUDIHVhu2GthLYTkpAEV0YyJ7OAECD1fqYtNaCGk2USywAnwv7YyRwv5
         5m1EAgQaec4gwnahVCuVv8RYgX0/2ky6764cNTbf5pSiwUlHI9pVvO+R1B6qeHVi7Ayx
         q85uBL0xKnb5Rjepr19qmUCxHKrhcxZLQs1Of+52fKxIXEibBp6Vd3L9K5mwPyj40WRC
         suy7Gl4sErl5K7tLDtFIRGccO+VwtYLgVaX0gf2TMohSYBWu0Es4eHYnqJUe3JYf2LsF
         m2hfvsJrwzyWE4q/MPPrEteBA+x7KcDzfPIhRit2YSM2Yq5K/QN8DWHFrZm878U/PH5d
         S2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783085514; x=1783690314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs9iGR2bHKFpwo4peauSzAgzh8atdVXGd7+QypRLV6g=;
        b=Ni8l0pLgZVQc9b+t2UEQqLTBDeKXgA/tV3HSp7MIXg+cCvHn+Zw5pF4N4dbwPgb4Hu
         iBPO1VIScPaY4FTKXWcVH6Dh2Zvek61uto5EsGeSu7F46cgm9TEznPekd1aXOuX7bf+9
         PrbqIuCviqMFHhxE2JyFoA5IXwZl+HoSq4coknauQ7E0J35yZ9SipXnTymoiFCsk8Ced
         aZJm7qi7CTLZoJCT60NLRegXUQdxYhpDyaSoIsXhEgeemk02aHv/5QDoQoitqCxhHRQY
         eg4WOG1wPrSHQzN82yEreiwSy14gODpxC1F3N8VAv4ceAxpjHXN8kntRuFHzxXnR5kzL
         bbcw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6CuBlnp1TTFspThymVO2bf52pvEYxcnCVu6QQDqtWqRNUmhFW+rtdpYzcoZ7cGNEdxUJg1LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5QdXP6QUoEXUKsJEvh56IIiQGy0EOWDBQ53T6Lu7CK19WvuX
	Z+pFzykYncEhk0DhZvdEPBMnwvt/x0w+C6fh4egKD9AK6KUiay73wuoSvZiUMYFH6QTusioOV89
	sd0rbQwFuhUS9r1iIchSDVA3ZsLyWANA=
X-Gm-Gg: AfdE7clCdtYEc5Tm/ur9RD69Rw3q1O6qTmuYdxB0Wbs/UHOM9nmV4PcBZiqYrgFgUSs
	7Xth5n35tQUIUrF7VeeVnm0p6hZEGIQJv5XRcTl9YTAu6dXWdUrkb6LG42WZR7YMomV7vsBn1NW
	T84hWdi+Vpd8TpRJE0wQp2IUIXB3PtgddWXz4tlGC37m38WpTKBc/jQZWvp8pLa4uxI7RQDEeUa
	USMco0X/LcLI0NRODYKExCtg1ZHX/6O9NZhyBnQj1yPveGdyDBukSUeFAZId0r95gATCzkqeQ==
X-Received: by 2002:a17:906:630b:b0:c12:91a7:9cc3 with SMTP id
 a640c23a62f3a-c12c9d6bfdbmr210765266b.13.1783085513713; Fri, 03 Jul 2026
 06:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org> <20260630-rtl8366rb-improvements-v2-5-05eb9d6a37f5@kernel.org>
In-Reply-To: <20260630-rtl8366rb-improvements-v2-5-05eb9d6a37f5@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 3 Jul 2026 10:31:40 -0300
X-Gm-Features: AVVi8CeUAvaO7TW-9PwgQx39MnofLAnmLECRc1hofax-hJCPW-BhUJaWN0gnZ8g
Message-ID: <CAJq09z5m7zrFfM3X=Ba5KcCHCmnCYSaNTyAaND5xpAS=nccAuw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/5] net: dsa: realtek: rtl8366rb: Switch to
 generic learning enablement
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304556-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84778702FD3

> Instead of just writing the learning disablement register in setup
> and a custom handling of BR_LEARNING, implement the generic RTL83xx
> .port_set_learning() callback for setting learning on a port, and
> call this in the per-port loop in .setup().
>
> Instead of the custom rtl83366rb_port_bridge_flags() function for
> setting learning mode on each port, use the RTL83xx generic
> rtl83xx_port_bridge_flags() callback.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

