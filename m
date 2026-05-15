Return-Path: <netdev+bounces-288362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIhGMcpPB2rBxgIAu9opvQ
	(envelope-from <netdev+bounces-288362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F601554289
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F1673394377
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98B3E7BCC;
	Fri, 15 May 2026 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PODxPb9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C703FF1D8
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862157; cv=none; b=LRjsSLfTdLU2/1jPYBC24J2y4WIIAcqUMc8xV/bPNhbdn+/t3/u1eQ5mSGV3GCxcJRUzTFtICjucq4wu5MVB9nLJVMXM5z0nRwIW2pyamFjt9uGLR8aStUSuKaSg/MEiQ0p6oQUTSN6zQ/bU5Y1NK/+Yw4PCUVH1aIW5G+TK2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862157; c=relaxed/simple;
	bh=Zflw/LLGrplI4taggf610iOiOzrA3g56bliHf6APE94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfnSWjD4l5GjhpP/1rtIzaVSpJHj7k0/pjM4GBnn/nOotvX7qGc+50hu7kCSl8A/yAg2U0gs5tgnAg4t2YgfMfWYN6MZ/vveMUY/rtAbyeskymdM89Yt24kbwUHDVVgFh0n1vJEuFagp4s4xNK96a5rifHRV9b8PqCr0XK+s9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PODxPb9M; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-453903ee4adso8076803f8f.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778862154; x=1779466954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zflw/LLGrplI4taggf610iOiOzrA3g56bliHf6APE94=;
        b=PODxPb9Mi9wMiMJNSqkPEUs7EQzQTOdLaElChPz2E5kegp9ylI1w+9bGpwOIeeIqxE
         3F24ILAq2bgSffY07eyVQXnJkhY419piX3v1HI58z6V3Oqb8Oe9Bj8q/RY6XXwVd6f6q
         XpBndOPdksHmT3W+iVU2pwiDxOJ94TbqoM9526B7rWf+uDuvqyNr68GLy08LZcrTZxS+
         0DvTGugK5jk+g3p0lo52MmXJ+d/p6HmBW9X+YsaHWRiMn1CEjQDGU5pRp0EWmATuh/NF
         9GwapSFgRvgHkLPZ5ubvfTpIxTgs6Z9FvpjXHWhFaxR3AKWcv8o+b6E9EWRF8mYvRxaw
         AKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862154; x=1779466954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zflw/LLGrplI4taggf610iOiOzrA3g56bliHf6APE94=;
        b=dYglD7MqMWyo8A9qJQle8Cl7XMqdFZRiWoHDXRTE0jYUH27agulJ/a5bPN0XaMIWXz
         5HvWPWs5n+tqNA9vQKIiKtirNV7sce11C8UD27MLhFQmT5FPXoQH2guX457aqFL4+tsM
         n4G0lZk+rUiT/G1qrPRlhrgVOItfIS45phPxFZYa5+PxacWOtXTDqMwGZUECiGkbHvQY
         Qb2kmxFgrFvMsECJ9+PQ+Wet7/dPWpTnB0maDTGPLnw8h6hm5no8Mc2oD4k3M6DlGyyT
         putCnxpVn41qh129uhlNYE9lAkSEbZqK5acrAcTpOqSIPi3robHo2VJZiJXExAfnF4Ue
         6o3A==
X-Gm-Message-State: AOJu0YyNcXb+3f9ZN0fqC35tTzSdcHezn8W3Tj4DddU/uwkX9yym9udR
	567+CMWzjX9kmy9/LBJ8pBKGPUHZvVI/HdipcXvTP6TVzeTgXAfXB6rE
X-Gm-Gg: Acq92OFK7lF+fzwbbLpldyabIgKlEZxlmZqjfxJXpvXeLgc7pJFXTz4lAYiODn3Km3G
	Pbn8qayjEHU4Ui9bi+JhinieEL3s7lNsHL1O790pxhiK2v+JCSeOQdke9szBViKcjt0h1vwqyJq
	vmHT4mC8MOD79TBjzxtsAfR7NM8LHp1evEWYvi+Nq2AjQrI0LR32V0b2Mjm/OyrUe1trQ5qnx6t
	qMhEaQTr+2+6WVztYCjpADbA07wAFHuvL5ZmqWcHxYHPg7Fwd6sJA20E6PoFFpLFsZuNTg7/XyP
	g7GklO5xeLjFDblqLMpHY6TzHkmm5XiHG8PKJSmdSjwfc5VMzQDvduK5EQsCZVcC2IEGzdh98xu
	PMRxZaag2795rDk6AyqLHhLib+2heA+3VIyuHJ1nQGTa/NzvQGtSiPYfT/gsxfvj7BiFpyrEOap
	y3/oMu4gNTgnWx7S1y+Xr+xh9+5B6ISTSQUPZRlBoPTqESNkRwnih+Dob7mOGE7Fr8IA==
X-Received: by 2002:a05:600c:34ca:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48fe60ee4c7mr70816615e9.14.1778862154203;
        Fri, 15 May 2026 09:22:34 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4862209sm72891535e9.0.2026.05.15.09.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:22:33 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	bjorn@mork.no,
	linux-phy@lists.infradead.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: Re: [PATCH] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Fri, 15 May 2026 18:22:32 +0200
Message-ID: <20260515162232.23758-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260515161834.23628-1-petr.wozniak@gmail.com>
References: <20260515161834.23628-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F601554289
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288362-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I realise I sent v2 without testing it on hardware first — apologies.
I will test and follow up with a v3 with Tested-by once verified.

Petr

