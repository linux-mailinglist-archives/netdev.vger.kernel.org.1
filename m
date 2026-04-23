Return-Path: <netdev+bounces-280704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OJxIo/16WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4F450C42
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AEEE301E995
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19042386444;
	Thu, 23 Apr 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqXAP9E9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2E37D127
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940427; cv=none; b=FaK5cWpnaOcLNM3q2OkuT9DdrbnPpZpvXht9XSRV0ONl0AUcbsN9v0thKtsnerKYDR4kl25rHulbeNL7Fm25cWcn3FEPQPjQqHMRLzQLFIn/zAnXm+F1goE6r7BUK31XiyroJm6LYyagfAXoPKmD0LTo8z4tiOHbUuCPkkeMORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940427; c=relaxed/simple;
	bh=JB0AMGcFjkY9bWcUlSMC3gnGNhtYYvNztyoAMc+8nRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEyh77lGDug3GQiB1z3rDePF5Kgjj4LecC0QvkKBKAR3O2QvhGd9P7bCF4KUk6YCo5hZw1oip4eIcGCO/AUQaoU4mLRdkijdG4q5aITAnAATfesjqWjadijwZqNQRFwXGcdnM818jySQLweVpoVEjvABn4SHWFImXpHKMM3Ly3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqXAP9E9; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so7163593eec.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776940425; x=1777545225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU2fB1hG+kBEp+Z15zImyMutLvS0MfhU4gRUy1hVlf8=;
        b=MqXAP9E9UrPgFhvxzgOc4JwQ7cNbD7jE6DrLI94cVSNqwdKWH2sY5gDibOifdbDF/Y
         ypVT3PjioZUVlhnW80mO5dmVmfY9uH/XtmwZWFrFS9GG0rkDybNWemzOmzCzFjqLUgGs
         kyy5EC8bA8M90Wiq92OXP0qK5N6AF2chwE002krvsBVDYdOS2E446ddT21zECyQMNYQe
         svM5rzEfbVdEjJz4pE+rTSmW16nGwOEcOZDCmEZ1C/iSCfd4PeHbOv00rP/8CwNo8fAU
         IiuGpI1TezyvZ3VPSMiu6QEu5XSrMKrGKa5QFMu5O7ds9OjkFabG3u7Yk3mgOn2GmMF6
         5Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776940425; x=1777545225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BU2fB1hG+kBEp+Z15zImyMutLvS0MfhU4gRUy1hVlf8=;
        b=HDqURLbcH337+OQdKqAjZfRNA6tNETvk4tfDRid1cBgoaau1ZgET6jYgKJAl3yezGk
         ssDZ/WXonafmEmg1XZQHQ/IBOo85hN2DVe5FtZkjqW715R1dGxxCNKR/b1pKZMdBaBUQ
         bRWvvYMjLW6yHSLSCw2BgnjFp/CaZyxH09NLUOtIspW0mfZgFd2PQ2T2sycbmkRV3k2i
         UdytiDyNJeY/FBTcPirCIOZ2a2GZ5cVJ+oC9TpH2yVcwXneT1sy4Mj3B/lrqG06uhyMK
         Z4Q49K4Hmpv6Dfotx+vPRaeoyAhoJVXYMQeW7YAk1pdF7TyJy4p9n2drvJ44jkBk6+bb
         +56A==
X-Forwarded-Encrypted: i=1; AFNElJ9l9rFqdrob1z8jUCp4sLz8wpJtP7Y9NmDxfojACIzHrig2Ys0g31U0sP+7BPW1rmSkhqvhO/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhs8g5FZdh4UHIuqb4/f7+7mB859VIYYLxo2Vw/ufxBIGI78E
	QWS+5PWvto1bmXt13Zbt7430gAT7VMXNkfe5mj5UO+IDYgEUk5BS8b9g
X-Gm-Gg: AeBDieuEr5HCtkuf9U1VFPyWw/8lcQIR9L28q4AaY6x/jbEPmyEe8yJxvSV7vfrmTqZ
	QSS6EqfvRnbV0iI86A3GdPWdSFE7Jl43S+hIDIo1NYmpjbc2GR1JDL6Xyhb/sphX4fZeLQ5jYHW
	8L//Lsz1xewGrn/a+fxpoYZCJtFuvUzoOZmUXO2FYo7vOu57aN6aoBiA3hGdl+xnofIzpBCMI2G
	XQO/mMrG9C1ySEskEwAKzaLLPCE8teIJn4TNDPHBXqv814t+RSuH7KdM0zRIopBbrBCBEQgHWJD
	x7M2UwKJSVwYzY174fv3GeaBTadqD+Vj9cpMF17seQbsjOU0PTIIn8tHtDRiNsIeyvNXH5uPAHc
	N79QN6RvQPCw5fSy9EZ6ikocv3nxWAkp/LOcvZyP65BR+pptLH5Tcq+2Q7rQJ9fM6JklJb2Y+/U
	Ac+JiCmsrXc0nOgbUOdDeRVgStgkdMriD3cnpydCaJFZniga8EYxMu
X-Received: by 2002:a05:7300:1351:b0:2be:142f:d499 with SMTP id 5a478bee46e88-2e478a2f186mr14131699eec.16.1776940424968;
        Thu, 23 Apr 2026 03:33:44 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm26578635eec.21.2026.04.23.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:33:44 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net v2] ipv6: validate extension header length before copying to cmsg
Date: Thu, 23 Apr 2026 18:33:39 +0800
Message-ID: <20260423103339.3991950-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423102255.3752004-1-tpluszz77@gmail.com>
References: <20260423102255.3752004-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-280704-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2D4F450C42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please drop v2 — it was incorrectly sent as a reply to v1 instead
of a new thread.  Resent as v3:
https://lore.kernel.org/netdev/20260423103238.3987364-1-tpluszz77@gmail.com/

Sorry for the noise.

Qi

