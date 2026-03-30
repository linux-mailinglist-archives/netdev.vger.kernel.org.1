Return-Path: <netdev+bounces-273194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHwSAn1/ymnX9QUAu9opvQ
	(envelope-from <netdev+bounces-273194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:49:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431735C4F8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0A8300C933
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845FF3D3338;
	Mon, 30 Mar 2026 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGwWoDil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDB35DA60
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878049; cv=none; b=ftv8fvhCGEoSOnaYWDKcQiIbfESypq6U86+P9PS6LTYPTDipyYI7O3O79wda8+n4MiCm2zwXzJfDApuKAidVxZXSh90RPcOA7ayC50LiYUqWKHLr6aBh8uWO08iphR1z8BmHbC5g87bMGoT/pOnpWcButvX1WiyyTotBYyVog7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878049; c=relaxed/simple;
	bh=z2hYCuwGmmJTd9RReJNHxLCOcDA70fcmAabgHhNPlC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0KfnsuaCuWOY49zemCD/+FjJLcyrCXaGzDSjQ95CNnkkuLtiVWP9cckePcTTm6oZ5HH6CbW8hbRRVg960GyQ1rWE8giK2bAweTusyk/sBumuBJaqLf+nc+s6hmADVECW5cZdej8wIVflB200HXnrT/1iYnDVth9zCta3tvheTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGwWoDil; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-827270d50d4so4074726b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774878048; x=1775482848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2hYCuwGmmJTd9RReJNHxLCOcDA70fcmAabgHhNPlC4=;
        b=cGwWoDil3St+w59FwVkLmjbYjDuWkr9Ad1DBwYcHIsrlh4wioaw82DMu0/RFUAJ94M
         OmjbFSzGRB2TCVq7s62g78lycf2ezrUDTgBtJt1gOe8V71AqIYxk24iJyEeRFINHHVsj
         QChiXcZtQaKXixLIrzEt/5BoLUNlsK1v0MsPPCrTV2asBtoMfw3rd5IdD/Dc/7XQFF4f
         9KUH6Y+H5EQDezfWy6rn8jqSL4KiB5sfIkVT3czoBREu4AOF8d3aa7zVu94XZID4rbOU
         1HaeXmVuXkDi1nvH5Het1pslB40W0yrduiOVXQDI0cPZxBp+Mu0tDkBZrPKIJg7eUHaJ
         vSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774878048; x=1775482848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2hYCuwGmmJTd9RReJNHxLCOcDA70fcmAabgHhNPlC4=;
        b=AXyhrnpmzgzGDhdikwuzsNYLOf5VI79AsKhdNbLxBaRizGM6KECNmFMV9g3WGcwOrf
         gy5NaSfugKh83CqmOz7t/gQwHD0Q95FGQdZTn/lzEaXmtjoEGAbN8oEALJZL5/Wx2YqJ
         YbDQt3DAEtHWi9hhtaBXWgjRHpXoa8/el330QtuXCdj/tSDAirEwVNNQ7tXO4gTgVZYk
         PBq5pNZtBTAMCTGvf8Z7gJEIxrFo/Ulx7gUTsM3I3reDl9XI7++8LZqubTUuNAURtmdq
         JFvsIHyJQeJp0D4q5lYAGf9LVOObVaTR7YOoACiZ+B/i2gCqh3kYejjf8lggcLQOq4fr
         OYmg==
X-Forwarded-Encrypted: i=1; AJvYcCU/UI9l+f5A0j6J7bhC8YNz/4Y15H037S6VFjpbcLk8UvZxbl1pZU+hn+20xJDJYEDjzVYr1v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDaCCzWf8sAjImYT4uYpa6oLwAXGQ3811DaUU3mhxonV1wmOGw
	pS8ktJlFhLfJ+FoLC8PX7dJN8odw4bIPtDgqQUvSAMGsXlZ8YmKWA51jdDO2T7jvVtE=
X-Gm-Gg: ATEYQzxCPO+xtfp7OGH0Hd1gxlCHPH0baJLK1dYMlBRz3xWnAU5wlr2Mw+alJ6xwKq8
	WFlTFHmaWSxwOjtfW4WbjWG4RMAqaZceXMAkmwUKjAivp8GTGE1EmlzurV4qKKhoG541VmEc+zm
	BXyeVNy2DzK7Qrd5miOGDb40txQYxsQ+dTYZTj30YuHCja2aAhSTmh5VMzQTOOtiyIig8ZeQgSw
	x1jiixRC89lXpKhR8olh43NEHdbzKLG9BLDtwRUydIAR+1cCmGrV6AMQpUloylLUj5Syc4f6u40
	/9Tje8YdM9raKU3uY4xwOf2Kujj0H3g5e/jw+FA1nFEhqmSigVfmkpaasyu20++ukK7soSeoyo9
	Argv/YcUH789jC1N0p/AsSLpdNJlbSszKXJNfp0BZr9gtyeG8OxzDbggq+Ro5DMIfQaDDzIxSD4
	nndoH0t6wlojoghrm/KBkywhsnY/X3AdYbMeg=
X-Received: by 2002:aa7:9064:0:b0:829:6f9f:ea44 with SMTP id d2e1a72fcca58-82c95afc0dfmr12430869b3a.17.1774878047722;
        Mon, 30 Mar 2026 06:40:47 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8437441sm7800011b3a.3.2026.03.30.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:40:47 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH] net/sched: skip reverse bind walk after failed class delete
Date: Mon, 30 Mar 2026 21:40:42 +0800
Message-ID: <20260330134042.241751-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com>
References: <CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5431735C4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026, Jamal Hadi Salim wrote:
> Try these patches:
> https://lore.kernel.org/netdev/CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com/T/#t
>
> Same for your other issue.

Thanks for the pointer, Jamal. Please disregard my two net/sched
patches.

Qi Tang

