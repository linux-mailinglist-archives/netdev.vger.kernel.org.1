Return-Path: <netdev+bounces-283543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VNdUL2vh9mm0ZQIAu9opvQ
	(envelope-from <netdev+bounces-283543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 07:47:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB614B4832
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 07:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E343009B3A
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 05:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F45B35B632;
	Sun,  3 May 2026 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJdoVGAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BAE35959
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777787241; cv=pass; b=uYHTlRBMx5AnzrnsM4rupEJOEQodklUPcEn+cEfbTpKIAmodDWT+kJmiHvYrjxzsCJrQCjx/46hFTXtwbX4YSPEVU+Qvh1jgGgR9GISIavKnLg5ao6axNJM3duE4ex0DE/oo1EEFTl8bJKRZxYAsyz6MnLIlBJ8EZQMMif4AM5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777787241; c=relaxed/simple;
	bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc2iONn/NBVmYleXDs3FjUFe0o59OROey6ovV3UbvgHXPPkUCWQdyzq3FmO0j4FNbpzQGdKUi8NHpLza9NRXdL4XZw9/eYZdU+siwwgKa61u5t4AcqtA1dEgrKTh/f+EOsSi3YFyEJsUmbQlEz1pcLw8jh9Sgv7HI8CE71FBGvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJdoVGAc; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so31450425e9.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 22:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777787238; cv=none;
        d=google.com; s=arc-20240605;
        b=SLt1BaB9yd1ofcAIPbNXI+opkRHXZZmmOQ8V1uWitLRYE1WnZGPEGgxBrKJK1GJlcY
         MSCKqJJuOWXX57BnuDNKeGZxM9WjZaJdeybfBn9ZEL3eb25wYK985GVeBwBXtOiXFySZ
         lUDbbuajznYJaQRHOILuxX3wi00d5U5/8vDjVPgE7l0DnKGSC2kdll0rhdhUBWqNvbQC
         /YkB0Omy3Snhbqq3QISrPX7tgnLuLqIPnov2LxOloeeXRZbo8jNvd9XfTvZ8YYfC2wdb
         K9idl+WsIWTRTDlMVpv4uKkixXGN95+JT/cewnJzXUt553ASZ2dgsDRojW5tGKRXWE/4
         abNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
        fh=ZnQ7iPpJXAIp+KrR2a1MhwynfLzSi7bBROW4Wob2kFU=;
        b=RUfTjGWoMb+4VI+1zGv+9zWiohpRRBaoCraN4acOiZZm7yj3Ibe36GXdtTuZkCVMi6
         E71N15Rh53ri2J3YWLurR+JS9mLA8kbFRowk+e3F5XjgiOpHHxm97/UYHf1aVqQjhZZ/
         HGEPWutkolMGdl2ehcLJ3M6o+6kDVVTOAGWNfOgg7uG7rwkqAZOjhmzWbKflhCj+dAHy
         QybfzmAeKHiE2LdSNXGvWN/QsyZudL+piAE2kAjLg3C1+rPMx4bT1kMWAUdd9ZYpRMNY
         A1YTj/YEk4IRQt10dzqesSFSnlzGEZJSqv8LA7aEE/KAbUCZCWxSHXyokgg1ViWlz+ro
         fsdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777787238; x=1778392038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
        b=nJdoVGAcEkcwvwa2YZYPP2mz+YhC84bimEyCWPP+kbuBLCvkU3IkAqUHU7F9d4aG72
         NwxRy0qKroYp1kNfgg3bjYeonrFqgH2NtjnNI5MjPnUZMVt7gIiQ2EN3RX8AuhybMRH1
         wvureBrzTlW3RifpBIIRcCoit5gMWlKX4QimQhomim8qUwULBoI6V0tO3hKi5Fg3zn+G
         gOSbC1raMyKFM+TlaumxvoeuKYqXHO4gJuZ0xKtvsflwVwJRR+I7Y8r1zxupXelrHPZQ
         rt+TRenDrmdVWVPgew41vQvZJfY7V12riaem5j5c4xlvE6A6SQbLfKGsloGImCgz6i7E
         006w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777787238; x=1778392038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwi6pvb3hjcMt8fTNF3earE9PfFGE1h1a2RJcXF/9wA=;
        b=Jrnx+oD26Lk42Miu7RpasTnVXFN3E2BrCw5V9uklRQJACRSVpvduYrguP2L4UXK91m
         ldA0KAkupnzibtwkac53p1WZ0BGaIIqQ8Fn7sh3yMeXjrTBU/MsbVANWJpcqitHTVTmZ
         C3dj0HkYF6np5j8q7A3Ub/PnDXL5rrmBa4j97wHISMPO7Qhg7dphYJ6DpXoTU6YCU24N
         4O+H26cRRuWTUSDM5Wuavq/tCMZBAbCb5PHDW+/d7Q77Jzs19h8VCf01CUqHHE6CAA4d
         fCwsXXcff5Ps/y7S9eapBlN9yABKe9xgaiCZURe7KdQYXF+/99xoV89X5AMEhe7DVIb4
         cnBA==
X-Forwarded-Encrypted: i=1; AFNElJ8JvQ7J1UjdZJ8YwUeP5lUfK1Y3DOkTzX+K97XA1A/E3rSnJ0E/2jgdiq5/7/OqKe/5dA8dJAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXlougICR5WtvKwqjpncLA6o4emuMnJ7VKMccrFLQls75HBPUw
	4eDJQ4jxyikX6OUV+xqFXfg9+g/YUE7L9moehYW4U5TNqrheuk0Gu1HlSPyiYfpyIoEeNxD+6JC
	UfnPPWLNrwrtgaGHG+NgoGwF1gELONHk=
X-Gm-Gg: AeBDiesHQFxZzr/w6LSL0xgzP/wMOXn4icGbcdRQ1JMZgxuWIcoQ94Hkt+Rrsevy/OZ
	ezkC+8He9ETvioXvhVwfusSZ6jhxPQSoBvQVVWEsrNsUMgNcTb5vvvWusWNB77oxP/trB2bRb49
	wn077AuAhcXEtDTyMQDLdzEhU/kVJysVZheAq1U+pDFJ4bWX4WMgxHN/yQR9BBAdfeaMlbJqncB
	T+c/LB3hmqW1bp/5o3DhiDxp1keRqB3EJUp4VGfqyhX7S7GYkVUAm/D2Ip7BJUpsWd/5tg3Eswd
	X20is/MoscW0Zz8fhQ==
X-Received: by 2002:a05:600c:8903:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48a9886c261mr50519415e9.4.1777787237939; Sat, 02 May 2026
 22:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg> <20260502095359.496aae9f@kernel.org>
In-Reply-To: <20260502095359.496aae9f@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Sun, 3 May 2026 13:47:05 +0800
X-Gm-Features: AVHnY4IEGWL4tTeNfR67_PQ1mfQ_U47NZBvXSzMFrhIM5oPqayxpX6ibwbvdygU
Message-ID: <CAHPEe=HWWpXR_eR6OLgyPATeBW3CmyyifQrKZ02JN2GPGP9Fyg@mail.gmail.com>
Subject: Re: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	dsahern@kernel.org, kuznet@ms2.inr.ac.ru, willemb@google.com, 
	willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1CB614B4832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283543-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sat, 2 May 2026 16:54:00 -0800, Jakub Kicinski wrote:
> You're getting emailed over and over by the bot telling you not
> to send new version of your patches before 24h passed. Do you
> not understand that message? If you keep violating the rules
> your patches will get automatically discarded.

Apologies, Jakub. The 24-hour rule was clearly stated and I should
have honoured it. I will respect the 24-hour minimum on all future
revisions to net. I am sorry for the noise.

Best regards,
Maoyi

