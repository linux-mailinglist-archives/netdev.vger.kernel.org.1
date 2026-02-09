Return-Path: <netdev+bounces-257879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEtjMaQ8iWmu4wQAu9opvQ
	(envelope-from <netdev+bounces-257879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 02:47:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF910AE7E
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 02:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8153009B36
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70960274FFD;
	Mon,  9 Feb 2026 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeHdeQCM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZqr6xTR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416426ED3A
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770601631; cv=pass; b=ZpJrxiWZFnWQsOFKclXDFTSlEKbcJofuS4xWiGxAOndDsB6PlieO0+l7Pwv05u3tAZM3GGbbBBC9pK0uEkiSczCI0iGF24OF/cQH20AkIwiQxpzQOZn4+Ddig8T2fGx8ihC+Ke6GHGoL81Aq0WpMWfG6UMLVAIx1quAFxC76eDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770601631; c=relaxed/simple;
	bh=A1rH8Kup5JYGSVFNThtF+pJpdOaDs/TC/8Q/WXtpf3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ica2stxVdSlW37EDXKfXaK0XUSV2QEK9VpArNNcgz1vbDs2fMaT+gcz+utKOh04RySfq9ZybA+9Lt2XtttKrR0Swxxu6ljYB02q+LTUNsDUnAK/sKqixEpgomf7eIIOKpCXcMyg2yQd+s2nPS/wMFw0yNtSN1j2FBbso6CN/5Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeHdeQCM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZqr6xTR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770601630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VxKFt0XoIdgZui4JIVRnYlH952Cq7jQJGTItF6gwkQ=;
	b=IeHdeQCMMyO1y2Y22ws2wFqQpL+FJuADFj5/SF34+0PdjB1ifiMvUkU2WhViD+jbGaFYbE
	rGf3eK6AO8sX9m9gBGNhB+aGtILF/d7ZQjphEaQKGS52CuFbXMwd6nxdc2zsWqn8N9eTef
	NKm5E1RfDD6Vzejq56osEBx9LQcnoDI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-hkx2iunnOWStJpduzgQDRg-1; Sun, 08 Feb 2026 20:47:08 -0500
X-MC-Unique: hkx2iunnOWStJpduzgQDRg-1
X-Mimecast-MFC-AGG-ID: hkx2iunnOWStJpduzgQDRg_1770601628
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6dded42ec4so1010790a12.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 17:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770601628; cv=none;
        d=google.com; s=arc-20240605;
        b=YpgRuXKzd/dkJLabSkNQKq9wvTNPXFBH81vwTQHda7ljxqYvGV2mdDwHEVVZZ+3j+2
         7KzyziTzi20VJBjSzKPsyRYde9DLZUcs2ysBzPrle6ufx94BRHRAf2WBBnBY0NHY3gHe
         060z62w9/QjWckVlzOiQfVXAPX90I+0OfJtWPwXW0tDD07b+Oqf+azrPC3dVMGjXTc/v
         T72Wk/czqRkL1I3BFIGh1oCdnF4ePDmulX7MDs9+TstCi5OHeoUojRsJ8n3y7gZfRYHJ
         dan4Wm43ThK/JVxNSr6ilZmNPSBeMKCFAuupPTjPpnK5aQeUZplwY/lC+aFWzUoAZCvw
         mdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2VxKFt0XoIdgZui4JIVRnYlH952Cq7jQJGTItF6gwkQ=;
        fh=6KK/IYScxBj9yukIsr52tSR21Lggh60kKJmxqgiRdVM=;
        b=id8l7UJ52m+i3LCF0t2Nw5it2vYkVutY1h7UovmQkg3e1oYT1Gr2kURjvu7mbvAorl
         Py1AYeVYxvJELBTNYALqH/l6whYMQKflT/maLMIAbKYeE0GGzTTHUCYZTajhSLvotluS
         Ce01LgasPux6MZlHXqfpYTG2Bb0PQQVCPU48jMK4gqswCN+qWVoPQFCnIawbcBKUD77p
         tPktxbgBljnqeOZcK1xvI4ViweRfqOamiYGWBKrdREzFn3qz9G4TCrur6Y+12/qwDLJP
         orPZTn3zG/9sAx9AZCf4FmttIShSrOWXYkScFQKZ2l+ikPGbiRu7CoJaIrq/Wl853wIo
         /3HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770601628; x=1771206428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VxKFt0XoIdgZui4JIVRnYlH952Cq7jQJGTItF6gwkQ=;
        b=iZqr6xTR4J3Fhy6TXq92pOSxYUyE+nroOaLEgOALumK/zXY/DWtnH7G79Lzm0G1IcU
         yG6otCLQI7Ik2W54mQDi0e9Ex6adw/SywP9aGQZD9IxpBW2A+4EGpEkGnXWdM90D0thC
         bxosRZymYzusmVzhO4Kfqkx9AGmGdo3FT1Cc75t1xVBukePxwDKTkOPiW2+YNk9qcgi3
         Hk9i312tsT7bKBV/kmffbZ+ri2gM2U271hpHHJvYsMDvlZsEph0v77Fh7cy6QfPMIzyn
         gzWOZUDJB6kpEvZrJGfgHUOAisEv0D+jGNWKDmB/ZKdXEYO0u/aJZL8sZI5tfoJIOikX
         WfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770601628; x=1771206428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2VxKFt0XoIdgZui4JIVRnYlH952Cq7jQJGTItF6gwkQ=;
        b=Rfc8ok0dJ77hYkxhMGVKWQGdzJhcVWtXIhc16FEHeMPCjyVn+z3AMAKnbjzYMPK0p+
         67wlGx+HcIHObQbUudL4yRhHvKeNV6dIvwb0YXc6PYgYej6XAcH0+hZkt0SyILcd3qT0
         lgMd0BWimThGqMGbTIn79oC2Ge3FseNheyYStlrSXD225QFV0nGRoolm9EqGe0UV4+Eu
         +ZIiMKoLkYetvvcOBp/bG4e3BwT5CsGfhVgDW2ui5Y/w9PvypfakYaKdLVzgqHJemJUd
         FXl8KOkjy91+vXHYUcgAOlzBZeszIheyGiN7MHkR7JciWoF9b5FQaJOKNCIysyb6DapG
         cQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXWsffaJnsuQOkGYPU5fTWzDnpFvMJY/a9S8q+pa3f4U+6Ej8gCA41hcL29Kv0kAKntbSMujAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeAXU0w25/BZBdjZb5AEcWe5FPxBV8vCyu0AoXmsAd55Imatv
	JU2yflQQEm3yqfWKGLTujpuad9amXMX6c08Op4uWtHocsuwcwiMgn/TO8pyQO7I26KoycMvleIM
	3DE8RS40MSEqPbF/ZOdQJOdiG3pa3CdKlAHJjX2HDDPRep3mwoyrFGwUnO+G2yWxzIRWPFUsR/s
	rIplX2YqFLaCOcQ9DB58+5xEe3Tk4dY8q3
X-Gm-Gg: AZuq6aK2whZH3EMG5ZLNhKO01Tn59WrTM+jOIVanDTaCuwpQXIoBLQRlQhS06t6UQRU
	AdHKfb81TCt+jKNc0fH9WD6qm8LWH13RQM0i7aI6MxgPymmRi2ejjzY+99yUZJSXfIMTKAMR8lr
	OnQrKupfb5qn4qFX79OIhTtuVEOtXOQFpGgKza/qt/uK9drFH6EeolN5mM7E8ZHYSbXVc=
X-Received: by 2002:a05:6a21:4c81:b0:38e:54b8:60a1 with SMTP id adf61e73a8af0-393acf88668mr8796248637.4.1770601627823;
        Sun, 08 Feb 2026 17:47:07 -0800 (PST)
X-Received: by 2002:a05:6a21:4c81:b0:38e:54b8:60a1 with SMTP id
 adf61e73a8af0-393acf88668mr8796229637.4.1770601627369; Sun, 08 Feb 2026
 17:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208143441.2177372-1-lulu@redhat.com>
In-Reply-To: <20260208143441.2177372-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Feb 2026 09:46:56 +0800
X-Gm-Features: AZwV_Qi0i5ksGpVC-CJBln-eBH2tT-cjvtJdZLINPKQb7OLTsikREB_yl6vrqE0
Message-ID: <CACGkMEu+gE_K=Tdx8c8GSY4snGpSuU3MgevTq_Mh2wShmaH+2g@mail.gmail.com>
Subject: Re: [RFC 0/3] vhost-net: netfilter support for RX path
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2ECF910AE7E
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This series adds a minimal vhost-net filter support for RX.
> It introduces a UAPI for VHOST_NET_SET_FILTER and a simple
> SOCK_SEQPACKET message header. The kernel side keeps a filter
> socket reference and routes RX packets to userspace when
> it was enabled.

I wonder if a packet socket is sufficient or is this for macvtap as well?

Thanks

>
> Tested
> - vhost=3Don  and vhost=3Doff
>
> Cindy Lu (3):
>   uapi: vhost: add vhost-net netfilter offload API
>   vhost/net: add netfilter socket support
>   vhost/net: add RX netfilter offload path
>
>  drivers/vhost/net.c        | 338 +++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h |  20 +++
>  2 files changed, 358 insertions(+)
>
> --
> 2.52.0
>


