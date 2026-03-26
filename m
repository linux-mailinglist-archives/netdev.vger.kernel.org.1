Return-Path: <netdev+bounces-271813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCuIKm6dxGki1gQAu9opvQ
	(envelope-from <netdev+bounces-271813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:43:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20632E723
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF075300BE8C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B739099C;
	Thu, 26 Mar 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXClnkjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF172D8376
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774493032; cv=pass; b=RW82Hp8akBUFLLzLJf4WMn4e2ebAysAPhdK1ZKUvI7hoLHUZvhu6R4qR/PrY2OVQuQ84E20GKIJnc+t1LN66CMPemDtEbgMpFTrlUMf3kuEmsOnLbe92kW+FVtfZH86LfAO0KyfqtwzSUa3h9OaJLP/sCPZnG/byxrj2nXTQ0o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774493032; c=relaxed/simple;
	bh=qLx333URmIcSDNbmRn8sNbUnlkIvjnasy4zTLQtbW1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxktwyerCsFiOoG3EiuII4rXNX/r5b7HdSqURxJOsVdinnXnHASHf+5MEfI56kDShDdQHV4qXhCucRettKsQ+fQtx1Luv2wJNaS0jbYkW0ZdHWqtcQ/BCVSULRcz6ZzxOovcSpvz1xu+J1beGsw74/VfTdrRvPZygK9LRC3MeSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXClnkjF; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a46ebe2beso4763427b3.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774493030; cv=none;
        d=google.com; s=arc-20240605;
        b=PTDNVpVhCgnH3jp828u4WIoBSvCCTg/AijR7QMTMKrs0PgGeeq54M0zOt+S4Mnhb/r
         BixMjPbJtIOdfZLSx8wms6FPU1pD8jV2QawH4z0vmaccTAdmlJCPdTqXLY7nux8WuQ8e
         2qPPdNw+iY1PX4a5y3q8zvnqWfEZkD3rWwIMq3tCAgauL/H6S2m96JWeGrDUMGRzMP4n
         WzyOWYG3CSNys0w/UtRSvOHwL1WGqod9rstiwnYWczW/ATImoRyz/aA5JuiFThwWcn+j
         9fmee9oR/8en2wqjeXvfEnEM8wRoOfYcDPNBoCGOkSJyIcvc6/QdR1aljCuKvqbSOusM
         I/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qLx333URmIcSDNbmRn8sNbUnlkIvjnasy4zTLQtbW1k=;
        fh=rsONhIKZbfq9ssQBQbrisuyBw9B3Cb2cWzqTcA+/7V4=;
        b=W140Vjm4CXGaiJeHceZeJIQmY4+YNaHGraOUSCGuWZ/97mqTleZJGkAQBs1uge8dwl
         pZC5tsX83Hb7/38bNn1hqdD/l9hXK4teFQOtzriNFPEiwT/opyRcpM64/ACztgdoaiLV
         Lgrdux/SWLXxtgmNt0n+EnwXdEOz+ONXCRPoDlSCQlFmFnedzC8sAF+HHn33slg8OBu6
         IHhXC0Ucn8w+XEu+4dA6rPCjkLYm7Ic+miBDVqQWNlNzeLjwLLJAundjXkD708xJMptW
         p4LFBa3jMea6iKUeEm60dNIdI3rhapv99LFN2eT3CuuDV3dwt1ACRTnq6Kbr6kDo5dhM
         cu0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774493030; x=1775097830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qLx333URmIcSDNbmRn8sNbUnlkIvjnasy4zTLQtbW1k=;
        b=LXClnkjFvVYusr38mt8NwxpRrDOcsAfSuPZ1KEFVbpwjghsBEN8n0GZ68VQ1SBc9zq
         laeVzyaRtqNX3N+BP29g2bHS/7c4KmLhILJnhlck4rMonijCCF9EA1b7XPXGw9WAdwpl
         69CEaUqEnRwoiB4N7FItayT6x/KOsd3dxonF4iVNLQWHNXn/bH1EeGzRo9AmEaBaG4cB
         MjVb/LmMlz7fcIOnSUI0wcdB/Q2PaSNLrjrlGTufSfs9EGoL0YUenPHEMBVwzc5qWhY4
         EWcJFE8OS/YD1XmcajNKhO5CxyNsB0g9RxZO//U6uJXpKUOiCj+2qJcZXrwoM2GgcECb
         6HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774493030; x=1775097830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLx333URmIcSDNbmRn8sNbUnlkIvjnasy4zTLQtbW1k=;
        b=mazVhHS2JHjgX82NBlIlxdVqX6nhAt1eCC1qvA+lgCaBK3otvdYmpF9NTmQa/T/GCZ
         v4EUk6lq5rrHDV8yU7yGMK10RhCFb0KJ3hZzXm3sQYEhdtQb4nws866gbygZ2xWvYpTT
         y59vZ9GX1aM3sFqSe3CpxrveohqcKp1wQEF5fU80r19iQDIQv8Adiz9u1LhygDK3GHfb
         5TrBrd8a8+QHFnhlF7/2o8jO9ZkJTTnW3q+Lq/GbLIAbr/+49+dpRWo4Y5+Hn3r/8Kn2
         iopjWdIKuRhZDyliLRszr3425mILwM5ziVWlMTUSXugGzHcyKIjbtCljICP1TYRj0sS3
         5Vkw==
X-Forwarded-Encrypted: i=1; AJvYcCVKZPM67Ud2fMMpSBKAwpfjUfah9biwIkEUItg4OlA2mOhH4Q2pUjcFP+cWnnGu/9U8UKwBa1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOWJagakjGpNCdc7pZg4W/8hVmC5pYER97Kc2YjXFDk0LNySb
	Qy0zS/0HpW9iaVDGl/F5viINdwJLNGzE1qiCwCV6+st2j9IMEQOsWM52Buwh+Hu9TwsYT4fdTX6
	LO/ftbBFQIJ/EXQG3ma/Uy/sjLtbdN+Q=
X-Gm-Gg: ATEYQzy6pn90VUTTt0mGvZsJ0iVBGIOsGup4GiS96q7Dnll2swX5j9kH+/DXqZTx3Vk
	+22OV5rYNyHIAIkDx7WXyJ/QHJVgjMsRb5q2mrAxITtwAHoFEXGYx8h7hFJuRm4vKfl0A5uwe2Y
	F0Piy8WzAIp2Wl3D93LBC0/HwmvPYlK9IKTfLVDnDfCv3hRXbFcnxaJ5TXhvW6Y/RV18vvrTLyV
	NlcA9LdjEC8C+EMBhS/cVOPHU33PuuGf0Ve1/hpMJXYd5DBTemnawpUAqjulOadelH73uL+xUie
	MGBzq+SAE2n+WDKm
X-Received: by 2002:a05:690c:22c9:b0:79a:c31d:d4c4 with SMTP id
 00721157ae682-79acf69608bmr61632107b3.50.1774493030251; Wed, 25 Mar 2026
 19:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com>
In-Reply-To: <20260305013852.3769-1-dqfext@gmail.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 26 Mar 2026 10:43:38 +0800
X-Gm-Features: AQROBzAdfgjQ3EvaovMTRBjJ8zwYAbD4YryX23wkdd5nHdaS2VmnEjB2d85KrZQ
Message-ID: <CALW65jZRyKydW6bs-mYwh2mEn0dpv3opVEr=WczKn_0952_+Yg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xin Long <lucien.xin@gmail.com>, 
	Richard Gobert <richardbgobert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271813-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nbd.name,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BA20632E723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

In some cases (such as BIG TCP) a GRO skb length can overflow a u16,
then what should I do with the u16 length field here?

