Return-Path: <netdev+bounces-283564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PjVXLSz99mkGbAIAu9opvQ
	(envelope-from <netdev+bounces-283564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:45:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A04B4D14
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5C7230038E1
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7038910F;
	Sun,  3 May 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIP9x7M8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093C358D32
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794345; cv=pass; b=iMjIXSNl+1rivI9sKs57Aca/l26ZxYuu7l2ChzXYhJqKkzf+L2+bmBGp1tIn3sGQEDjT6/G2x9LEr3Chssznw3HVh+02s31avGSIB76b673L/17KkqL6QnQXmGZmPgqL6fj/Ey7XNy21WWRN3vpJBfHIHMcuXtL7t2+ipAtCGOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794345; c=relaxed/simple;
	bh=ZSJ7dfwziTUiJtRaFs6tTpfz5yzpl6R51uhuugyDCnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlSA3V5d98pzlbMwRjEHlTsnhvP7pL/G5rqNf2B1/enGl+wCsucvw9kmiZaZCqWsN/11/Jgn3ss6w66Q9RwwkCzGGdsRybXir2vC6dvcKI+DtmtgCnB/T6tolQACuj79/R06cElYq+SxOATM+prHyw3QPGdxvYK+MZtegepyQgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIP9x7M8; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e594413c2so19929971cf.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 00:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777794343; cv=none;
        d=google.com; s=arc-20240605;
        b=kE2q9ELB6Y+CYwg0bCeUJRDxdMNtexiLv8Ujbn5aFRy8sApJw6+lcA/cVS+15g78jV
         OCrgvQ4HlUZOYaKzlT7Ng+eE7ZLF2dGT4NP6I3OxGpKKlWLJHXxWXynR3gwuQ+HYsXU+
         ZRsGGc8uM8Ae3X/urbhW6vPG5EWB2mrxqjxHf6GpVJISQ6R41zFwOF1geMjGjRq85lqM
         ChzpjIgUnv8ved0bxHYxEdx9VmaJhfDwYJQyvH/5/+iXUZmNz8iLUi8ej315awfm3CWI
         V6vjP9nFH81i9F4ziJmtj96FczPruKefbTMQ18ZXZfVepIDRhflASG0ixAOr3QxNFTWR
         F3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSJ7dfwziTUiJtRaFs6tTpfz5yzpl6R51uhuugyDCnw=;
        fh=i3eU2K6OhQPdcdhi0nvpvkeUSnYrZZr/3t/ufEYJobY=;
        b=LeAlE55ZyuT5kX3Y8JJusZyBibH0h8wujJbwplMw1XGke0lHGchaiz7G4O/D0ikUv+
         QFEQ5SzgctBICaPKb0ATmH0iI2+BEGwGsuKrDBjvKHPMCuResxC5oN3rGe9v4gJrytgs
         E6o6FDgMdDyAyDBvcWrMWxPSF8vOH9Xm+UFpIMTr2jkwXzusBG6dJVOAAkBKSgPDU7g0
         nCzo+bLLKUfrClK0zbkA9IwFLXcaWbYIOeFsq2xGNTDthzMtUD6oazLt3vvwbF/jFpkW
         Vdz5b7j5mktc2ArNw1fGk73yOyKxfVrlNjlRH5tf41v7RLrrSLUJzj/03z9n92JILLDr
         jz3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777794343; x=1778399143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSJ7dfwziTUiJtRaFs6tTpfz5yzpl6R51uhuugyDCnw=;
        b=IIP9x7M8CcX+MVauJPnf/aLTQIRFX1BLI4I3886q2PqbVfSuUVcCnFMO2yVojOynCw
         njR91vwuWa3dVE0xBclc+vtn0mSSEKtjqUdKVFCRe4fdgWsvyLLsEck71BFTOu47QRnS
         32kW5U5BBQFRn+cyouRf30ivvp+GrYZeZ/kvb4d1fVwMJCP+rH4xP1sMij9wq01HXILu
         FvV4BiZW3qedlfZg/YQVMzkB7FJBroxbRSZeD3fuKQ+BwjWd/uXJn3HSf6RcZEeSXCEN
         i4rj8pyPKhoSYv1mASxFSMlzIqSGCxWa+jJBZY53q9YLkp4ejfRI7kM611mwBDrMyZTO
         zLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777794343; x=1778399143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZSJ7dfwziTUiJtRaFs6tTpfz5yzpl6R51uhuugyDCnw=;
        b=jb+4okJo73P2uFGkFcW9Di0xSPAIyuQik/BOdcJQGu6QIz6nVhfsIM3Tt2HWEgEG0Y
         08nnAU1C+S32nwVuuez1gci/+zc3YSZgiInrFtMa913k+7Mb7NsIMFA5o5oswNLwQSt4
         aAHTcpQnzSomCRXaQBTuv2A2lyn60i3piQQCleUNKFLpBxISvhnPDwrcWD1jJpF43gZ/
         0lyLWiqe4gvQeu5u755qnmktiIt1nbB5XYbdS93pEd6J8O71S1deLEedUgTZRQ0T5j/B
         7+42J3uGzeTqIliTVWRY7Gr6SR9Pvd8sCbzDVhyJHuvhxBQXrxpoB8nwj8fbftAwRKd8
         ys3A==
X-Forwarded-Encrypted: i=1; AFNElJ/SbL6YUhJ8y600ZeFq0JiNMIkdS/GfAUS3jpGF+GH+C1IieLShWhDUjNeEV1XzrwA2NNbQGas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3oTkA0j4wnmwGdZvwcjnyuCylPMJHL78CyI83L8tdQKnW6HSr
	HRmznJEShErH8Q2zH6dCIBhHnFk9Qm8g/3uOxsGiRh/3VrldnmbeXGfxapBBbLDfY0EuBphThFB
	b7wMN3Hwx0WiR7xrfgw9yXNq9qlU5ygPUMU9swIYd
X-Gm-Gg: AeBDies5zm2lKdhCiVZv4DPKU0mXkbSBJi8VN7RgPMfLJwcm0I2U3MJlE2qjUEmgOyr
	7QDZvokZfJKHcyDLSNyqrXY/ISKu+KpsxNFmwAxUp6Bv1XcKqM0+oSpaXECoIf+c6jFYuQPfd+/
	FpHCGh6z72acSn+zQb6JpiuvhtngrLO8KL1PoJBzQ36NGSaDMU+hbe1eRfKUK/u3psu0gZkWR/S
	hdBklGTzZUbkOFc0fhtOb7llVXRcLxmPacBuAi/GhzzFiydnp6RGuh+wFUHKGMlyesZCz1zozXz
	9qCtgCqRSTfl2u43va0t8DvStcPY4cNPtkEl2rClvEsjKnZ+lROzRi9Fc8he7b4PLbpki2BYvna
	HRU4FgIgwz9vix8jB2u9CyQb3CXR3inG8ggkK/a4ZdBwbzGqlRQ==
X-Received: by 2002:a05:622a:1aa3:b0:50f:c278:c007 with SMTP id
 d75a77b69052e-5102d099aa8mr165782251cf.2.1777794342908; Sun, 03 May 2026
 00:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428082851.3240821-1-edumazet@google.com> <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
 <CAM0EoMmHMMsAbORxETh72c0=CyyAY+PhXReXwP-woGp31YOkHw@mail.gmail.com>
 <CANn89iLTH=_=qYS6RzqpGeCo2FuuVW70h_yRycy2L59G+APiew@mail.gmail.com> <63c0e51d-77cb-4b05-80a2-adebe3317cd5@kernel.org>
In-Reply-To: <63c0e51d-77cb-4b05-80a2-adebe3317cd5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 3 May 2026 00:45:30 -0700
X-Gm-Features: AVHnY4Ilv8wUlS4iRfbwzrbkXPGyzVBWsAeBuf_xTcmB3VUC6ySUosT85gFJPzg
Message-ID: <CANn89i+vjX+=3NV=PNboyHP34fV0Cu5KU1KTnOaiU99+j8XMig@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc: use ll_init_map() only when needed
To: David Ahern <dsahern@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 137A04B4D14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,networkplumber.org,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283564-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 2, 2026 at 11:10=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> fixed the long line length and applied. please cc Jamal on all tc
> patches; there is a MAINTAINERS file for iproute2 to indicate who needs
> to be added to patches.

LGTM, thanks!

