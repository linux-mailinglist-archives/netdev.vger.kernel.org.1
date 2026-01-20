Return-Path: <netdev+bounces-251410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72622D3C3C8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C35E52A335
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFE3D349F;
	Tue, 20 Jan 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFtTGZHF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1263A1E88
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901265; cv=pass; b=QgdjEIEIySuwnfP683EayRm0QErRGHaymI8hIwDWWbDnRBMIRM4DRWGQbxVuJhXRTCyHdmg3KEFbgj142bhZDLbTF2qepP/8RELEEIMAtuZzOP99KqzOutnfitIA3g+D7w9GhT3RDAdUBPR+hzmY2zd7Q/bUvU0pEo5f3emS1zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901265; c=relaxed/simple;
	bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKHcrbV5gOWpYsl3sIF/zDnGb98vAnuw4sc7cJXzeEBMy5PY7ATzsE/f1BLUZGtRTZhSjCOdCGfpsyUN99R3G2MpU774ceFVSODScBBZ/WaViLChc8Iy5Un3vwjmm07jhg4G/Fzf0zad9g2IaOAsIf23AkFQeWmOML9b8UtA97o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFtTGZHF; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-501506f448bso29287451cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901262; cv=none;
        d=google.com; s=arc-20240605;
        b=H1UPT7/Zx9nkK91hSuvVNdAFMf5cHdktyHwzYkbLVipVxB6gaQyUeEZCMI5trdNnGu
         wJYLDhzFXzN3pTTgGkpTPZYgFSLGr45R68xtcRYZWhM51dlNe/rnfeiCdbhcQYbBp6FZ
         vteJjofeupoZRNPCN8y1O1ugp+g1qU0gKAiSbDD2XFUtrb75NLmD1diWuZ2QihTYhdir
         SrkbfrXy8BaR6c84M6CBS+Q0HdAP/GC330xOfGkEERBq7SRHtgd4bUO5OelHEZPrV3m0
         aYsF6BkiO02QrawMn1CN+yo5EjBvQZoIPc3l5WJPsfHKhHbe2z7ZoT1E13sMPc2c4fkN
         9ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        fh=L8lOlWONXFKge5q9IubxyVIN5opvY1SRpwkDqgJAHco=;
        b=LRQpDXt7MSNxJVqxfD8BlTSWNUIcbiblCa1ZbdO/xm743I2VXDPzy4wusfzgOhc623
         i1Shnz5Bkh/5E9Z3XBeXmXkaMqLfy/Ne5P+uET/J5MLsvVrFLeiKhjDaKSNJktRMcVv3
         g2jvBv/LiJXFZAUIP+9vSQnx9cPjFllazhop6QC4lJcT2UP0RjDx5qk55HC/h4zxgPE9
         ZcOBsYmH7ZRrjhAwH6xjGWiC7HcjQSgr5bQlfhzuNjwotAjjp963L22q0UjsinMGthzM
         oYrTYLmAOJEe115nXpNEyji5HPSsunh1FO8cpeHQMyNvs2G5VkAi+CCIY++6EbZrzyV/
         vZgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901262; x=1769506062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        b=SFtTGZHF9NsJIabBnvYroZCzVEpdC2Hb+eE2ztAAX+AP/pxQ2GQn7gUzykX3xJE1T9
         Ic3+0XhwYEuVO/+V7CTqq8bK8EbVBGm14wXQZAdOhxbgZZMUMf9Znai9ninsnRo+wuBU
         tu+6U1tkqdA6QIiB0ZZEWgrBSf0CwqLCg11DMnxlCHHx1KnfwFltcwLKdvLS81XGy3Ib
         L/g09oZlVwkvnAM5lZhMgbe4I3ro46YYjP41sN8IevjoS/Ikjp6uK/5GoMwOTCddfmBZ
         od9r0TIDu2IfiN9us/4iZw1g2e/ZpWXGGBJWpcln/Gof4PS9uLDQvaUkilSORvAE5IYo
         jpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901262; x=1769506062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        b=Oms7J9CS8VivYbmCn1i8jf17xRT+LKy/Djh8R3ux0wVa+OCmqrD3m3qWC0m3Etv3bm
         tQKSeJ6qGF4n9gSIbOxFLAww7V9QYjkj5HPaVbqWTrB2OXDlrh6kurBp7U9ndhSQzLOh
         i34wi6O4fZ6Sgzs4O/cHVCfciB/V6YfPkh2T+DySrWdLpVxVIhOLf/8xfcreuUBDG3bl
         81HCixrClLgUxXSDwv/xaATT5aAN5fKwfVWFJIo5S9iB0amLiJCPS5iKWJmo5O2HmbfD
         3VJpFGT1q5ML9WiMFBsyXzc3llPoFR4XfoPJ+8LU8CuLmo51uZrGfePYgrvjf2jS+A5E
         ONeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeK/b5YKroIdbvbn67HkInnnfOcWoL6zSxyZIXTIU4BBxBs/U7UuRmtrHkwHmQi5KKz3nCzIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BOUjWKh/H8WCzMyPt5n2ivsYw5cL5C3VcYBpL3Kk1T+uES/k
	CyU2CTH6PGWRsg5JeVW6fNhlawZMzqJ6DNy6tJiUuf9DIYndoMHlWWJvGmca2spo6fKgQK67o0Q
	wKYS/GnSGefvzr3zi+vz1dEGqM4/DhiFNKrt1xi3d
X-Gm-Gg: AY/fxX6FUmR4mux61WpnrJddQH5utvyKA5Xk2ZrXBopDTuH1R5lTCbb1JzggX83noiv
	6EmhF3Y8IFwAgWK2oXUzcRDpILd3pUMQMD+sZcvBJnN9UWOc18njfyE8WdDuy/WByRXhe/sn8j6
	3TiK8f/Y5uUqMr/mP3GGfGggqfxHIoJRbCQHrPMwVAD1PY6X4LXvMcWHVCY/2DhUGDGdA3bT/9+
	wg9vTP3ldHVZLObMlzxoQ51t47pU4J8wI7u/l2+oMouTaWhJWkKVpltKdgAGUhCMnGEyt8=
X-Received: by 2002:a05:622a:180e:b0:501:47d3:217a with SMTP id
 d75a77b69052e-502d829a969mr10411241cf.25.1768901262067; Tue, 20 Jan 2026
 01:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-2-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:27:30 +0100
X-Gm-Features: AZwV_Qh2C6qterbUps9ipHoZiFx2JUtmLIyzTtH8Kko470SyemAziOwyIlRmsJc
Message-ID: <CANn89i+44At=GtWMjksjjMmARZONeVAAiDgqAP2jXWSK3BxJLQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Add newly acked pkts EWMA. When ACK thinning occurs, select
> between safer and unsafe cep delta in AccECN processing based
> on it. If the packets ACKed per ACK tends to be large, don't
> conservatively assume ACE field overflow.
>
> This patch uses the existing 2-byte holes in the rx group for new
> u16 variables withtout creating more holes. Below are the pahole
> outcomes before and after this patch:

Reviewed-by: Eric Dumazet <edumazet@google.com>

