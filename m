Return-Path: <netdev+bounces-256545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wr7HDSjBgmkpaAMAu9opvQ
	(envelope-from <netdev+bounces-256545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:46:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84076E15AD
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3156C3055CAB
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1F21A92F;
	Wed,  4 Feb 2026 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxwnGbCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7DF513
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176805; cv=pass; b=JGP4ime0WpuAnTznN0EQkXR2Ctt5HlHgy2iIXL8wDyS7ZJ/F4nyNK7CFy6KBbsPXPbaVhRv46g9BcBglY6PD9Vd8oE8t5c2+XiRa7kfnmIQa5bXL4QH3GGjipV6c7yLUmnlil6j/NqU/mKPeEaT0QDD6vkaJmdPxZX6+AjSQTKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176805; c=relaxed/simple;
	bh=+zZ69uJdXjUv4UzmPsfk6198FDhvAKQzPdCVmWWhBg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIVvTWbuRJ0yJtmoKwjaVStqKiW37X56BJ89m3rmyu+m7z3G8TjdxZ0CLjQNkOi4VOa7tCdmg/nmdRqlsqjXVEl+KJApiO7WtQ7D3FMzxh+VHY7xMB7GMyNH9VLwfKQhgK7HlKXEI4zQksL9cgsac97qZ99pQc098te2A4AWQjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxwnGbCt; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c7146b0854so707405385a.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 19:46:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770176803; cv=none;
        d=google.com; s=arc-20240605;
        b=hDFiTIM9SPClbfzUDH5spTGeX7kGZnMRb9Ge8X6jZtCIzKbHjVhFr3sA+G8V6gzpdd
         hPq+kGC3IIKV/bs3gAxPUFWDalLmYywPuPneYjI/eV7I4iKFuWyVLfTgVVUHxqB59bFh
         LQUi+uEu0oZnJW89xnb4HxJ4uKo55ngjaBnsBo7NvnyC5wtg+ZwfddK/oBDnw4P5RxBf
         Ww7K/ncrr2W+S1JuxDAtOX8QfdHCLg/PUAiltGjTkdG7Q5w4a5M2SuIdkL1HZiH/p6Ml
         rxeMk+usaUScBChEdC+H6M1/pMC/vyYlxW5IqZ32pXOxvsn3qsGKyqvCXbVWM98LmJs0
         4xRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zZ69uJdXjUv4UzmPsfk6198FDhvAKQzPdCVmWWhBg4=;
        fh=VCmfrtEQhpQJ6nXlVo1vN+zu7KKu5p4CLXMp0oKCPcU=;
        b=fR4J4SpyTdQwGMw6SNBQ2fRV8ToEsufHW5a81kPo8GJM2lGUJrldSPT6NTlyikgx6o
         9pAd/5hnfPkD3XdjusYWioPGrCTlC7uPNjXFrtcuJ1N+mbh76W8kF+3iIkkcBYUGmLwZ
         7rNDRzFQprc31sMHZ8D651VIAQt1KXHkZunJ2FXU37vwPbCKsuyjE0VM06STj81CpSlh
         UNczBSDCtK920sJj3QzEo8Jg2owVjBvmicTZWE6ybFfaMy9R+Ppc/iqvXQOLgXMpflwl
         maizEHOo1sGvlxcblUl9d1k6JZSPjaFXEiO9Qo8mBkl23/9lhUNgrH54LJuFXaFB0kTM
         lTRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770176803; x=1770781603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zZ69uJdXjUv4UzmPsfk6198FDhvAKQzPdCVmWWhBg4=;
        b=ZxwnGbCtvsGKLAOXYinkyIhDTj7+3xhPmWY5LYOdl7qEK6TWfG8YA7xa/D4gh/KZZB
         62mL/mseYDF2WMXS/jCfu70U9Qro4hc8TnEThmF6kbcclJT8gtdbdoEiZEVPnCct3Ojc
         Lzy4MyhEbHUc2CNFTMyXCAUe2W2QLb1C1j0x/r1lPnC09IkUxfYr1PKo85XSCHrPZHfP
         f1BVpeW8nPGjyPe/EtGj3yO/QESg9M0jEIr8PCqf1T+hvtO1ByYF2JT2xLYJnod9T3dD
         WXiv/qegpinYeNO7pYfjoewjFniBtYOxyP7CVeEdBDhrifmWAzJBQ3nVLZmNtCH6Ofnn
         ksSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770176803; x=1770781603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zZ69uJdXjUv4UzmPsfk6198FDhvAKQzPdCVmWWhBg4=;
        b=KeTgNheN2RyfMj/6P2sNigXHlDkRrWdkbiF0pT0oHy2qjk3fAlFHUMdQFHbkaBT0q1
         agndn6VCIHDHj3bjDvOxgy739brKWgKtpl7b/qPCCVSwlveiM57R23/6Y9O26HuoeXDA
         lY1iC4ifYBJ+UnJHwNpv6yBZn81Ku5TJCaWkamGDC3Ykk6f63GhcJQcpefqyzG8/vTIq
         P5ywkHJgiVGqwDdoCoTvmTS/n0EiLKp+P+53TDEdS9XbytJFC1QKo857wBTv3ABMRNsR
         VRVaobK546GHuW9379bZvpu7ILsSa50QRdRT9ZYAHrjIIO4Wiuc0XCDBNgO2Sppt/pEe
         I+og==
X-Forwarded-Encrypted: i=1; AJvYcCVRigCsU08Ul1tPiXZ5UuI4AwqJOXskOBW4YXAkjfec5xDrzO4D5IPnGNQZ1uKPzrf4PGCfgh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyW4Tr5jIVpeCVapgwFMMszyNeg7x1Eql4iSicGn40y3fXJAj+
	VXLz2Rg6KNMRGG8KDrpa+kiXEnTB77zDCKLQJIOh2r9HhwCjwDH8TM+RLf1mTKM+Bu+Gd/Ryt8n
	X9+5gYs8GOpXtYB+bvVDyOL0ic1qGM8I=
X-Gm-Gg: AZuq6aIlX8zdLz060HAHvkgkdx7PvolwmnW9G+95tfQa4DPAyyM+x6W2sIF0HQkSHqn
	dd1hdfMpuH/ydUxEzJNI18BhUotBewqWixZrIXfIP9zaVa1b3KTsbQl+Y9nLQiw9SMeXoGsjV6h
	/RCjCl4dQRg5hgzVspaz6DHan0+Wwvxop1ne3tT2Rr90XSBy4zR7gJeAhjJ1N7eZyxr+vtZf0bc
	tiUXkh3DUpNWbJI6/XNsulC7ioTvHuWMz0olaKhYY8J2xFY+aaje8U0Ynn2QuoN/IdPdQ9mbXTQ
	u0z/CsIW16RtOC4yQYMsZp8Mren6Y/gUT7UN244I6bR4/+H0Jdgsybef
X-Received: by 2002:a05:620a:2a07:b0:8c7:fdc:e871 with SMTP id
 af79cd13be357-8ca2f861783mr230977685a.34.1770176802874; Tue, 03 Feb 2026
 19:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203013924.28582-1-enelsonmoore@gmail.com>
 <20260203194317.07432b29@kernel.org> <20260203194447.0ce4ffd7@kernel.org>
In-Reply-To: <20260203194447.0ce4ffd7@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Feb 2026 19:46:32 -0800
X-Gm-Features: AZwV_QjJJWZn3YATkwJHIc0Jls6kF3BwllQz6vEvZ-iE5Q2T_u_GTfWm_amU-cY
Message-ID: <CADkSEUgoOyeUqGHXqimczdo1M0S6C20GOpKH5OuEeaRhFnSTDA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Eric Biggers <ebiggers@google.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Peter Korsgaard <peter@korsgaard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256545-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84076E15AD
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 3 Feb 2026 19:43:17 -0800 Jakub Kicinski wrote:
> > Not sure these annotation on the get are useful
>
> * annotations on the review tags
>
> synapses misfiring over here.

I will start moving them to the changelog in the future.
Do you want me to send a new version with them removed, or are you
going to do that when you add your tag? Either is fine with me.

Ethan

