Return-Path: <netdev+bounces-256924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPESOhIChGk+wwMAu9opvQ
	(envelope-from <netdev+bounces-256924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:36:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF0EE00B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA022300B45C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23515288C30;
	Thu,  5 Feb 2026 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMdy/gax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEC1F131A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258910; cv=none; b=lyYdUGSAeW+Vwg4Rwk0IFUY/rSGRq2O71MKWhP23FWWj5n9A5Dg9bi/2v51vPcaVT7eCQdm5nwi9g/XUuWEdq3L8A29+oXFhsacYCylURTFnxj9SzPiWtQpdRdwSf0SPll3cqGLsf/FcSIZU6Z3b0iQCW2wPCIL2KnaeCcqvQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258910; c=relaxed/simple;
	bh=u0GBB6+Hj7CpJN+vOTxjQeBme661T2E1y0ZZW4Sej8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYAbl1B5G8MOWfeA5GL3br7nAzdF/uGtC4Ic2G6/m5O0C2nx2jQ0yApzQU1su8it/iZHsVRqak86o6jL5DngQwFOi/TdcnkqwE4fDiUflKpMZYFZhubOY8FZDERZXr6yXoqUjco5Ty7vL+nGdWsSnVEVuCSovV+WZi+ZcxhV/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMdy/gax; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so174000a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 18:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770258909; x=1770863709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0GBB6+Hj7CpJN+vOTxjQeBme661T2E1y0ZZW4Sej8w=;
        b=ZMdy/gaxUYPVr+vAJrjm9JTey8OJLSfHfDQFMqsz8GRTK1ugim/MZdkwStTER2yFPX
         OLrsvVMTPWBgvqY3ZiCfi7ncLDaspF3vr9MOIFxDfO09KbX/Pee48C0SiRXR6T9kUn1j
         j02xglqRRwR6XTD6HeTrc9EHrtda2mVUQNaQe1PqM6tzps5l0sNNUi9E1LSaLxmZNn6R
         v8C59n2up6QhcL8lEAhqSxBGyzEgCpe1pf/cAx5PvikKa7CsVTOvO9q0kXHpsho5f5oz
         33TXyaehAhXz+bEPBCFfAkEfT3yaVkF456baNkMya0DAr5IQ2MhTMjQxuliLvq6LZuuM
         Y2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770258909; x=1770863709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0GBB6+Hj7CpJN+vOTxjQeBme661T2E1y0ZZW4Sej8w=;
        b=uY8sRo8CqANlG54lNyyp3wd6s2KPxMozyYUolDviMDAO4Ei79KZpkuvZW4fHyGlVSu
         VbsCHxn8cVjKJmAQbi/YnPhfVxqUjmSO+JHbmTOtENwDIK2B1/ZvLUm32r+u7ED2Uvir
         TWVdsfk/GYkQlpPRP8cVIWabbNfqYnkmrL0MMx0w5993ugdzKwsP/0ZQbH0HgzOxwfI6
         lfDXshagbmsItERAhVOOr3tSGNJFyXhMq7zSnBwVjoaSn6lQG3/u9MlT8MqVbIcU0/zB
         tNuEICGL5dYmzuKuRs2h2XkttL1twMwtvW6mJ7utqp09qXsn0qCF8CdwuWYmmN0FsOFW
         WCHA==
X-Forwarded-Encrypted: i=1; AJvYcCXYO2y9QGKcusEIKyAekgaJ7c5oCJPF11AcSxl5VJehAHALtZVWPS62oHttLfTDD76NGUViKow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTtrsUYR3nQYKI/MIvqCsRBPiN8GNiRisyKhbK6MnTkE+umTt
	kRMjVIntGOo12jy1ZaKpKkkO0FTw47nQP3Tv0UY9DtFilHsP8Uef36Ps
X-Gm-Gg: AZuq6aJizZhs0dl1szOZYhoqmjci0Y7GsN07LTD0XELUOmbt8/EubefLe28ic0SZPTP
	RrCGDtMpiA+PdMGiWM+xxaM/TbesvTpt7F5K4ahYoNToZLPY74Vu4SbUHxvrKhlSMhtyWxH5+b2
	evR9M7BuAcQUlWAgYRUJ5MZ5QF0hOXFuZAdm7hRBP8y4vJnmO7c+sF80bATc3CyZDFBkEE+rUD0
	qN1aZifKvaQgfXgxpbZkP1wEX4Dxzpek5D2Jt30wFDm1WjCfJr0CJ/+U62R7eLLCDsleikvkcqp
	s4sc4sCmsnXSP5j9+xb0hu26Ubz6foeuhFniQrkhvqds43OV4FDcocoRIpmKoJJS9VtSPH5OeI7
	YXF/gKjKAW4pGiNQ8xyLDOtT2fPIvDjQLB16atShmcQLe0eysxFImYu1t5O+PMBOf+DA6kfMWT3
	9jAu1BGvSA8Aa4RCYkKenFDlO9/gB2uVVoxOkepZd6ZTyqodLXfUkw+cIuloMqGuUkFTPwXIg3
X-Received: by 2002:a17:90b:1b41:b0:34a:a1dd:1f2a with SMTP id 98e67ed59e1d1-354871a9551mr4399957a91.20.1770258909166;
        Wed, 04 Feb 2026 18:35:09 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c28204esm712679a91.10.2026.02.04.18.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:35:08 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	kmta1236@gmail.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Subject: RE: [Intel-wired-lan] [PATCH] ice: fix race condition in TX timestamp ring cleanup
Date: Thu,  5 Feb 2026 11:34:36 +0900
Message-Id: <20260205023436.208694-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <IA3PR11MB8986EB459D2FD1697644CF98E598A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986EB459D2FD1697644CF98E598A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256924-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lists.osuosl.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 51EF0EE00B
X-Rspamd-Action: no action

> Please use proper bitops for concurrent flag updates (e.g., clear_bit()),
> or show that tx_ring->flags is not modified concurrently.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thank you for the review. Will update the patch.

