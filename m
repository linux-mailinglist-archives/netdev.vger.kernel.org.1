Return-Path: <netdev+bounces-306525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5lbNIXDYUGrI6AIAu9opvQ
	(envelope-from <netdev+bounces-306525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:33:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C735C73A46C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:33:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sAwpHPNH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306525-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306525-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAEC630413B0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36733C52F;
	Fri, 10 Jul 2026 11:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AC4192EC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:24:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682665; cv=none; b=BdgSg32vk/oi8hHHKTRp4MoVK8VTl16EKB7lS/VRreRAlQPD/JThy2Ta+8kkTXEc8trUsg7GvORkKtEHPrl4XkaxhPXreiMOTMiTZyTo/MmiUvra7oxvlBf/zpPpKOXnV+qVqXVxqDH3+GmfutzCHRogx+LciAJ9VsC0z5DaqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682665; c=relaxed/simple;
	bh=dDBt4FHRZdJL9ffdilgluXXJ+QmyubtcY3PKYDWBMCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF1OuPmNYYbLiEqcirF6IFcLnuchh0LSrMXMZhNQa7FZLuftOxay2YL69I0tLqUu7eKtOxxUr395YsML5lPhnc3B52qSuL0PLozHCafVr2q29Rbrj1yEGDDVNhl5PGSxXeiVLDH0GdB+sD4DRK78Ta4QPUOSIyWw/Y+DNpwHxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAwpHPNH; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so778003b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783682655; x=1784287455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDBt4FHRZdJL9ffdilgluXXJ+QmyubtcY3PKYDWBMCs=;
        b=sAwpHPNHXcrb9CIFGiXC+0tz7gpT6lI+L/fhMmTPo8zZl7VMYZ7iXDXrYKIHlDC5Iz
         +3T7r8UlDdWJeyGCrjtdMAufMyM6N3287omf53uHTqEEFvzCeYAItNe8qgvLWMd3kIJR
         oKTpvVXHW3hot4V15C7DGKOTLc6EHI/G5ehHPxq+5O2ZwTgTILp3NQnd3omTfy0sBlN8
         uIMYa7hrsr73TZUx29Sy8h1k+KPkUVkNn5VAcENaymoFgTexeA3EXXnLMsGNprFk9MNf
         K/6dQL/eOkYvjECiL3dIxLNrUNEhZfqpj4xhJN6QjXW25282pahMlkmnryJuCiPz5oyj
         TR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682655; x=1784287455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDBt4FHRZdJL9ffdilgluXXJ+QmyubtcY3PKYDWBMCs=;
        b=hs9KK0dxW2xglsKE/t4zpxZwrYMLLmQLolxeDbXzv/ldBQMbBjjQnjK9ecWImBoyp8
         AQF5KbAz9g/ZeeO7cNTbCIWOjNAxqFfwJel9dWd2xI2YrKx3X1wljxUW92zy+nVgtc9x
         qimwhZmlNuN91Z3ANQCvfK+0h5Cx01BfxMVYA/DnbErgZO5sMXjVC5+ByakCGar9cJDQ
         mCxKkeB+Jwdxqhv6rzbAXHhKiRe/AMtv8OiGiJI8c2tpjlDT4dw+EukGrRvF15+KBdAi
         ZXwgUd6HIebOh7llradzTZYOQiI/aluD84AR+oyWhnhZzBsjjgdEsFXVYXMBqkX8d/96
         9yTw==
X-Forwarded-Encrypted: i=1; AHgh+RrTsIZbcA50tzCAetTVLBeA+6U6zMPxMnFDylGX+MPmHw/OXVTZxtnrVEXTSoEv5xAKYVqtLFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjTc1+q7N1w/UH5d5bPI+MIFE74JICtFbv7dJpRvUSRPaCJLZ
	QAUnln40rcSwkf8VIHBsILcEwBwqO6md91VC0yk9hjqQz67Id4F3/DrYZ+8DGq8u
X-Gm-Gg: AfdE7ck7v+fmx6C3Sek72J1tgDdQR70BvIYFXzjTcAHa8fszZu6ZHgMaYtmRHYvt4UD
	MteY50ARnzC+41G11s770nQ6ZefYocHFS351pmXQD0k7sYk1DwHXTKyPH0Hrhxr2tULfNMpJvmh
	mIeuyEnDyHhEVO8P/44o4s1p0fhXyNwHX/YDLIkmX3xTzQE597ksTI8deO9A7Z9Uhipsigs0YO+
	wNnGzjpRQUvqi/lC/2C7basxsABSCZIih9OVU02cPgOiWf5QdMXfqCHw+0BryKXcXZIAiq69NNM
	9owqoltg6Ye5iYslPWMGI3TC6WxcD50iHAObXvqTvjH5k1G6Cf2y+HSfGdZggxpuhrR6HI++0ez
	t/e7ugi3u/KGhO7qhX4GepdsJB47cCOtsPMjafzBt5Q9bpGeGMtaHMIEbf9WlCvTcRoNgRh7YzC
	qQT3ZOAw==
X-Received: by 2002:a05:6a00:a86:b0:847:8704:1c54 with SMTP id d2e1a72fcca58-8484301d996mr10203899b3a.22.1783682655418;
        Fri, 10 Jul 2026 04:24:15 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm8541404b3a.8.2026.07.10.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:24:14 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	Andrea Mayer <andrea@common-net.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Justin Iurman <justin.iurman@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] seg6: add support for the SRv6 End.MAP behavior
Date: Fri, 10 Jul 2026 20:24:03 +0900
Message-ID: <20260710202326.cc-justin.end-map@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
References: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306525-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:justin.iurman@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C735C73A46C

+Cc Justin Iurman

Jakub added Justin to the Cc of the SRv6 Mobile User Plane v2 thread
[1], which I missed carrying over to this per-behavior posting.
Justin, the cover letter above has the context.

[1] https://lore.kernel.org/netdev/20260504182833.344d7b33@kernel.org/

