Return-Path: <netdev+bounces-286223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 88GmCOe9/2mP+AAAu9opvQ
	(envelope-from <netdev+bounces-286223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:06:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C340501F83
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3175D302768B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C63BE162;
	Sat,  9 May 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iww0/cew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059030F533
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778367969; cv=none; b=eT7UFnBVMaQAESD266ul47fKLbzWhba/g3zloLEpY8b0nCY1ZdEMNKy1JbwC9RBkYamcFq8JNsGixWm39yvqpdON724Vs2SDggf3tGZ6ZUcKIEuQBqTjah66ddy1Wda1Syx8xsdIoiS8Xu9PnXwTSs6MOzdzsm8A4hF9z1jN6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778367969; c=relaxed/simple;
	bh=75RjdTFycC4KsbDdIrwUkIEJa2dRZft2gS3g6Gm0uUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODHhMiwfn9CY4N5BJ/nIiFUamFokCUhC/rTX9SvakowfWmCNHfKbwyepkOvkjY1k/iZtDZkI3NZXLX/qqs5zwBzhoqiRdULfW2aLXkUDzxhtgREuP9SJFV9dQtLcHgGyZhzyX+h25FOYsPdLKBx8cBI5vBJDf2hQtBxNK2JCR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iww0/cew; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1309f4ee97fso4055397c88.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778367968; x=1778972768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA3AvmC5tkbvB9c/fedU8uwKljV9TMh+PEnHBUwxSPQ=;
        b=Iww0/cew91tPieGFqBkrBMihSRrsE7TNu2JcbGP+vk+QnnFPWmLPVmgwBuGFdIx4Xv
         tJibTh2E6yVuc8NpzLPmyAJhbGaJ65InnkVDQ0ZifeajZ/YEMOOS1WiCYUichQ4/y5Hq
         fC4XBVb2lapVy2KWxkfVbXt9lUQThATWFZ/B1kBXGxX42APcKXjhePejZ3th3kNKgQ6H
         oK3n+46T57cMDd2CwiNvBAH+oU7hMikcmxNRxqr/aylaJ+WsIdz7KGiEV126h/Rl8IR2
         fvPuM8NkVXdDLkHHK2itPWKb/vtu9WlX2kWQwWoVUAS3W/WcOKVWscaJv8sO6zIIE2cX
         bl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778367968; x=1778972768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YA3AvmC5tkbvB9c/fedU8uwKljV9TMh+PEnHBUwxSPQ=;
        b=b0Yg2CgnNe9J6XIlTCUloJDePQGOhWaQbV8rMjf+L5LU/rOd81Dc0wBgb0YBqAODRn
         5IxYpTAyF0GK8oT5GSeLVzUAHmtf/nmA7hZB6xE035W8FxE2fZmx1I6+kKHIZNrvbj64
         Hj5IsyrJmI21LGrqVJjemFeuJyp4xaUkzQi9pIfAbAZ+bVjMUhTuX/XnM8j2t4nnTSmW
         G4zdDxkyKjKmD8nOTCnuevH1M2TAdR1TF8Uztr6yua73m0WRWBzEY/6A4MN3eVbD/xFY
         TPsiGrc4KNOCiYjnqr2LcoPan14qrlPak134tM2HoP9Y+boutTT37g+ssEcB/mZ12R/V
         OSCw==
X-Forwarded-Encrypted: i=1; AFNElJ+0EC++t/eNZngyg1Ex4dS/NQ24iNi2kqdAEpjblbXS0w8PEE572NdFhVMxXPg+XSdzDnzYSDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJhDT/IuGnUPcJyEHVR1/gkN4o9l9sVdvdwJ03FoF3s3vtYCh
	sgmv18692BLmOE/A9ohW7BkiHFfwnyoW5XmTzUVdVnTUFuQNfni7bz4L
X-Gm-Gg: Acq92OFzEl92s0sNdyu2IuTJ2+W1qrY1JbjFabUSm126e/JRxnRz4dHkUfHDFkG+69k
	NVDoWD87jBtpiTooZ7xq+rc/tv2Zcw1JqUOwSKf3iYm5OjfrvA0cQcTyv8yimfVYQAxSrGJgAXH
	7goHgWexYt27V98JbP4X/qRXo6cSKbbGQuR1DE/DDTefuijIj/p3I2Ieti37Hmc7hRVmXZJIlPt
	+YnwwzCQDBfv3szQ0XEygR3/8M1RY92uQ/ppTSgFkq1pvDosZtGKQfMfWcoLULlQn1d90DhRbbB
	LV6LmqZXjedx4q5an0mAVKQ1w+EnPIRBaj8GO5t3t6EWn1MKmA14tZDJsgqu73Gpjnzw6QGWoCR
	JS68mPfVQ5xkvT8c9AezDKHCTSa8wj5Chz+1h5QiL5jIghLb5+7jt8MsjCvYe92669NM34cGGmA
	/znblXFSODU9v9Op/D5JKlcmMwFZiSkZhO2q1/htou6RtDRq606E8Mf4b86GjbhFjJPB/3ZKSeD
	ch+cZDs3GUMjM/OWX9QVKfCxGwx5pKxCsu6HKml2MN4SpSncEfKyJCaYODsGVQ1LaRB1VXb5Ndi
	Vnqxy92uwHM2E55dcw==
X-Received: by 2002:a05:7300:748b:b0:2f2:5726:db31 with SMTP id 5a478bee46e88-2f54e77e505mr8831359eec.35.1778367967491;
        Sat, 09 May 2026 16:06:07 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm7702136eec.28.2026.05.09.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 16:06:07 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	macro@orcam.me.uk,
	netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
Date: Sat,  9 May 2026 16:05:20 -0700
Message-ID: <20260509230519.57607-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C340501F83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286223-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
[...]
>   - MAINTAINERS: Add self for the 3c509 network driver

Hi, Jakub,

Did you forget to revert the driver removal, or have you just not gotten
around to it yet?

Ethan

