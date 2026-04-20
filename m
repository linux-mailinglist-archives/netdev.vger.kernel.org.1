Return-Path: <netdev+bounces-279835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEauCOVD5ml/twEAu9opvQ
	(envelope-from <netdev+bounces-279835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:19:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A7642E095
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D12330A0021
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01783A875F;
	Mon, 20 Apr 2026 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="eCAl0Tn5"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F93A875A;
	Mon, 20 Apr 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695188; cv=none; b=r7KN09wPUx4jhCvIWYR1wKphD+wMB6Q2FX195s8ISjR/nB/W1syfiqcAKQC06P9GoF5UOvPVy3KjqZ5JuY5X62caeElNa1Glk3q9lj6gZExJ0rWoCG/tYjHbp0rF8fUK0ePilznH5Za/8IdD1YNjj6xJTVLgkmQJIbhHEtzddqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695188; c=relaxed/simple;
	bh=MXNjwz8DeRWo73w8E0VQYjWQbOWp5j+rveE9IpnRlMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fT0dsBat4oopiK32dvqgzKQDA19AEzFtKzi4EBcuu7c/csFGAyy4ohXe+sV8cFRV3Qxa91fya6thpUS8XKMNkeV0rjXypKygzF7c8j3/KGlASjE2agcnVAn6vGb1pRl8HlOJD1NGzJWgy79aNsajHF/tLjfBWu+uq+xkIi2IdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=eCAl0Tn5; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=eCAl0Tn5;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 63KEPKK62792785
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 15:25:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1776695120; bh=oslg2wOvWNrDwV3tASfHPGU0tjIxphyCc+dh/D7VjA4=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=eCAl0Tn5M9fFpQLQw3XCdrgxdMRcI+0wrZlMwsXXRqzm1EVnEp5O+FhUgOkaGDYaM
	 ZgJF61oYO896LJ/OAYNtUhJUkR6YHWNtq4jgxGWw3/+76CzCNcw5i2VvyK25la+nVR
	 fmfH5h5CWe49bl/8XkF0l0WjLHheCw+BuEpldsM8=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 63KEPKJV2780929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 16:25:20 +0200
Received: (nullmailer pid 2893984 invoked by uid 1000);
	Mon, 20 Apr 2026 14:25:20 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ericwouds@gmail.com,
        frank-w@public-files.de, daniel@makrotopia.org,
        lucien.jheng@airoha.com, albert-al.lee@airoha.com
Subject: Re: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
In-Reply-To: <20260420134506.35164-1-lucienzx159@gmail.com> (Lucien Jheng's
	message of "Mon, 20 Apr 2026 21:45:06 +0800")
Organization: m
References: <20260420134506.35164-1-lucienzx159@gmail.com>
Date: Mon, 20 Apr 2026 16:25:20 +0200
Message-ID: <87cxztr9nz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,public-files.de,makrotopia.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279835-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mork.no:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88A7642E095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"Lucien.Jheng" <lucienzx159@gmail.com> writes:

> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.

Sorry for having missed that.  I assume it explains a rare issue I've
observed where a link down/up sometimes was necessary after a cold boot.
I've been running with your v2 patch for a while, and cannot reproduce
this issue anymore.

Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>

