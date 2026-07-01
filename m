Return-Path: <netdev+bounces-303781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VyiNDbBLRWr0+AoAu9opvQ
	(envelope-from <netdev+bounces-303781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:17:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7376F0450
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:17:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jfarr.cc header.s=fm3 header.b="B 6HZxm1";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=dqbaC0gn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303781-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=jfarr.cc;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7591030A1C25
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1123909A3;
	Wed,  1 Jul 2026 17:13:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0333905FD;
	Wed,  1 Jul 2026 17:13:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926031; cv=none; b=UVSLNK3iE1cdvXDeGHZaRSi9MpO/RK6mTmqwVf63qyJZVfSnxTH3bUBvgDcq01QQoMT6MUlgLY43/L6zIs6hqxT8rGjnONA7y5DtQhYeQaAuQvfxZpHEMn7/NvVdVMkGjD30zadUCgDS7bmljkzwN4+GAmPQt6lz97yYbcA23sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926031; c=relaxed/simple;
	bh=8HHfCXosk9bds3qhL/OMtnaEsG61dm/HE1FtI3WqEeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJqHCpVdIUjlXLhRggJNRz9GAAm/hjWDflt8a0OkKzd0W8IRjVihV3D7C86Tb0zLVgOaOQtTycKzpmtC+/2EEZfV0z+kEnyw/8C4usu5g6Xs/YblS2adVuXjpz/3HZCAYZ2prVwSl9p/GVaesSC8r/StstIKPJ3D78fi8Ffpiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=B6HZxm1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqbaC0gn; arc=none smtp.client-ip=202.12.124.155
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C39527A007E;
	Wed,  1 Jul 2026 13:13:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 01 Jul 2026 13:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782926028; x=
	1783012428; bh=8HHfCXosk9bds3qhL/OMtnaEsG61dm/HE1FtI3WqEeM=; b=B
	6HZxm1ta4djUAF62MRXY9vpM/YyvSnqKTtPNJDTh8fPuevREkp51D8x1FMZZ7SEl
	lQV/s5AST8hlZ5ZEuitsYfcrNhej2YFLEDAQVLYXq3CJ8LM7/cEWpAFVzlc+LBSa
	z8gk7MKq0/ALnjUc8/bLTA9iOjRMQKA9M9e89GrzrJdBsw1IQjCKrPRYjr+6tQrr
	DuZA2TYlNUZy6u+PplhcmwGGhBPtDYJFE3w9rN81C0DnC+M7k+084aNplF16Xm9h
	PgPJmAEAL+gCvA9qD9DbpAKnXmYK5Dxp05YX8FeeLabtdHUkZ70VMvB7/1crbM5l
	LgpYdZ25mP2TuA22s3PGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782926028; x=1783012428; bh=8
	HHfCXosk9bds3qhL/OMtnaEsG61dm/HE1FtI3WqEeM=; b=dqbaC0gnmCKfP2Fvz
	KS/JNpCs93a4hyyYv7alxo598x85Cb680ieBYvfxs+ixXK6Nffd1sJ2XAUl/k72X
	QEbGDrUYWp7EvB1TOkyxErWist0TccKMT3muusFLoPefjSrIma8OVTlarpjZ1XPS
	T5g1OAYmY8ZUYpSM7ND5irm7eos5PNFqryKfBrxWgJuBJLy5F8O7duupB+WhwNEC
	Klr3D+2GxcjCoXX+sheE/a+3KzjEgT9HosKTa7drFTQhpctvsVDPQ/Z84UVcVTGF
	JiUGdd5wgWQPooYoJZ84TNgnANX2hW6MOzuZZQRkZMbuX8WdsxiXHbU19tCqWtcU
	Z2Jbg==
X-ME-Sender: <xms:zEpFapjea9ux_IhUrTfXhYCMx5ojdnTrXmgMjqf0aVnaMP_JvKi7XQ>
    <xme:zEpFamIoCYY03XdU6ZcY6KwzZ32fTnTOxqzcgSQAOC4E9tf-a4u6xmBK5WB6bUfEO
    bEBbkiaCYBJj898ApRBUaFsnx8XVR_EMzR8paC5145AaB7ZwfcugQ>
X-ME-Received: <xmr:zEpFaolLH0yk1SDRs1BckyMw56fSSEWie76CVuw0xkev3LiSxf8GTnfKaO7j0Rv-zCPLgdM7fsAAIcDcHkmostgJkockLdiHrPLasF4FIHsZ>
X-ME-Proxy-Cause: dmFkZTFEq/RU0gPNqPzoIji1nltzjcjaE+0T/yA5LNODFyhfV5a0OV09gNDuR5gvNHCHvY
    MarStHiTB/FQBOrQ4QH7xEtIXkjCfPfBdDGnhejJ+RnBBakSV+6pQryPPOF/RlzuakGlwP
    kZE/t7TNS23rBifaJGbkZQBAy+v2ODmHyJz46kelQ429IJyVQ8xkYVw5uEGlvYeQ/goQkf
    Y7H9162k9KkuwoFAai3DZyo0IkBUt4MG7DQEtfYCtp7/TMoJT4f8OpoGAUkdYwj37+30ep
    RIFouEcOI+TNTkAQac49UKYkLPYE2TOPWylONYpo06bJ5u8JsIBVpC1WGDZU8ppFjwQgRG
    CfcNbCS5O9V/fGSxF4rp12khz1wjzKlNs+RhR+8BZuzmUUvIcE7LW/aVUHiJ3dPx6bJxkn
    6BwZalCnJU6BIDMDcjeap0Jw4anXhXYKhVgzJLSHc8CJuhbS9FicSzM+pNdJjvKBU71JIQ
    vRKSR3qURku/QUGRqk4f9OX0U0WVsp28AbdPeEZH7nPlDQJGaS1gvlWnmCrYEf6L5vdN5m
    kvA8eUtSHuOmUgwaVweaLVUPBswH+5zqvpGS3VtZnlc7OYunmM3wHFn3vn8Rnl7WJHtt96
    O3rUVoRyeHG+U9LeM/4Wf/2w6XF/ORbBzAp9qud72b7hUucl0q3QzPzhIjQg
X-ME-Proxy: <xmx:zEpFauO95knYJyUtVFIrT7AaEijur2SAlZXCSHtUoEldDyw25MBenA>
    <xmx:zEpFai7tDCoXkk4TZIYSf6c2XY5ndPF1m768iW0piUs2OdONoZRdqw>
    <xmx:zEpFaibwbXTQSeB3oozqR7N3GkVZsLLMyMf1KnfHHEXrbr_k-ydq-A>
    <xmx:zEpFavdug0gIFsdkSFJUxg_AaWmw5YraqN3EOc5-8nmI_DXpgI4DFQ>
    <xmx:zEpFaiOpH_BnOFieQXaNAdKJosfPBkVa2v--on6pQvx44iy-dF8E4G6e>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 13:13:46 -0400 (EDT)
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hsu.chih.kai@realtek.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	olek2@wp.pl,
	pabeni@redhat.com,
	Jan Hendrik Farr <kernel@jfarr.cc>
Subject: RTL8159 firmware
Date: Wed,  1 Jul 2026 19:13:27 +0200
Message-ID: <20260701171327.2916132-1-kernel@jfarr.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[jfarr.cc,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jfarr.cc:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[kernel@jfarr.cc,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,realtek.com,kernel.org,vger.kernel.org,wp.pl,redhat.com,jfarr.cc];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303781-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:olek2@wp.pl,m:pabeni@redhat.com,m:kernel@jfarr.cc,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@jfarr.cc,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jfarr.cc:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F7376F0450

Hi Birger,

it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
Could you send it for people to potentially test?

Jan


