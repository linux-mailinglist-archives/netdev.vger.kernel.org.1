Return-Path: <netdev+bounces-288152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA/lOdR8BmqskAIAu9opvQ
	(envelope-from <netdev+bounces-288152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:54:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2F548946
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EE193005178
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325C3002BD;
	Fri, 15 May 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaqP2WHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7A282F21
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778810063; cv=none; b=dyk2+NSAOzElXxvwwB0Y1TthZlcfEIdEqfk0KQtW65a+l0GO8/xTZPMRffZjUusoBWn33ZGxkI6/qRU6rSmKM4hpPo4e8A1sYW3vqTwcIg5tRZ+9SMCrsU6VgI/1Gbt4COM5X1ETX24dL/73LjpderXgvIVm0GOoKy9ReKxSfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778810063; c=relaxed/simple;
	bh=pz0h4UNCAo14J0am+TiW9PpM2Ri6BTU/add2v13HRFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMe3GK2RH1i3NPj2z2XSGCCS+etTFoFdnM1QA3jcchQwS6418k0CBkkleH3ZrZOo+c0kp5EaRincxtJtX0099uIhAlyf8deFdH9lomH/kxyY44QZbbh8BVCUr9wN6UjuuOD/HMX4S+stpiIV7cPAOXVy3LpZ+QoC0DGk7H40N4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaqP2WHd; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so14281361eec.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778810061; x=1779414861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6aIIgsz68MZV6oUmAQjwz2av5i5wsvnZFL9Y0CDyu0=;
        b=eaqP2WHdyYEroFXRCQ942OGQvNAf6YR7NN8sMcZ0Wd/7qN+jo33FS/+xYWXGwYcFUc
         KqzXr8R6n9o/dt358f9J1LJ7IFmWeb7Kbb6JoHWnykadeZjBUfNbl/1nd0S4UD3mI740
         P9JI6L3PK+hcWRy0/dCURJM4GAQrIuYgdLFKYQ+FkTQIcJJBoks3SA31uU4B0Tm6ClQT
         6o7q1ZUsrlm4OGbmM+GRapE4bNB0RgE8yRYfd/Op1qa7OvTfdrSYFsGeYtAwtZPKDrAe
         vsYe3DebYlXTbyAsrkujBtsp+iK22q3fKop6rKkXnNQ+r8TRiPhFgYSDGE+wXP43cmsP
         NkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778810061; x=1779414861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6aIIgsz68MZV6oUmAQjwz2av5i5wsvnZFL9Y0CDyu0=;
        b=p8O2XqJnPL64qAXskhvFEHosAmH1RDv9qydtJmL6Bh/PLgANpWaruJBN6HjM4q/oMV
         5WLIixtKS6wjQfVvPHFD57bMP+w7AerA8DfGTyZ4WRvSH29aa43YRAwC8ee9vrrMvVT0
         kxS7INZnERuHTXOmC6f2QEuGSX00Rz1IwfV3hsZlGbfZnsDQzlLXRMGBdkJudDW0WK3E
         Ex4mL9JV7REkm0eLxxfd24UWgxL8koz2mdauVfCm6IolVW8Jqs3yuIUkdfJRK/XDi14a
         CMaXOQLcMsc1Obz6gtrzl15q38XtMuSO/CZy6WKjLVvzciwqSM7c19SOyrDunmoiFciq
         Z+Fw==
X-Forwarded-Encrypted: i=1; AFNElJ9Xyn83CR34r+oEpj2Vd7CdSE5oT0zbKJPpzloVD7FjYwPcH3RocGO7BjmuhE70U3a8uuQmb6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCKI26ad5br3Gp94fqLYPuzpElN+O3XzvjkOEGWEki/O0UYIJ
	RNEHxs4uN26VyahAJEnQlhBUtOTZ32zQ0VA0PJ8OiT5UJBd/NR0DPhVRWMqN6lBuUHA=
X-Gm-Gg: Acq92OFEMH+KzPZP9GsSJQ3iKf09N1GUOwEJPtX9V/M5dxT173uoihiFJNTIP2bALuz
	IW1ZXjx8e3yCPiO3nTm17S9c1JUkYbHSnEfQ9AYYaEELzGwhtqGf9WGcjswS8g4lzT+DPd58kLs
	0y6qJ1IG4ox9Bav9sYzkXBDT74gLkjb5+U2uRM6+J4mufc19bg5FGgbnDz9P27lKpYYrA8ohjkH
	KZnJ6HSOUD8IBvkpqW2USlDeUa482kSl30yRoBIOZ5IZIFiMOa6E486mto3yEERQf5KESpfWQAk
	HoZx98MBQguHJQ/zeX6k2jHgHLY8rM7wkgMO/9T8UzqlMWDG1VdWEuAGtqPXtzfJKQs5fTW8q0v
	oxtmcI3IUyA75VEqQshDZ/4ZLq0AEO+WUnxOv2INabXerEJnbzJiEt/1PSzu6epcLF49TgYx1Ns
	LIpEMQFdHm67XGAYqSrdv6iNhgSt1YoXajaQ==
X-Received: by 2002:a05:7300:818b:b0:2da:45f8:1b41 with SMTP id 5a478bee46e88-30398618bdbmr1053214eec.19.1778810061432;
        Thu, 14 May 2026 18:54:21 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm5373421eec.4.2026.05.14.18.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 18:54:21 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: casey@schaufler-ca.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	lyutoon@gmail.com,
	paul@paul-moore.com,
	horms@kernel.org,
	huw@codeweavers.com,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 09:54:14 +0800
Message-ID: <20260515015414.186955-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7e165421-a688-4025-a33a-8eefbb84c4b5@schaufler-ca.com>
References: <7e165421-a688-4025-a33a-8eefbb84c4b5@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00C2F548946
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,paul-moore.com,codeweavers.com];
	TAGGED_FROM(0.00)[bounces-288152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Casey,

You're right.  "SELinux/Smack peer-label consume path" was wrong
in the CALIPSO patch.  Our reasoning was that both LSMs call
netlbl_skbuff_getattr() in their socket-rcv path, but we only
actually verified the OOB read via SELinux's compat path
(selinux=1 enforcing=0, with a CALIPSO DOI installed via
netlabelctl).  We never tested with Smack and shouldn't have
included it.

v2 will say "SELinux" only on the CALIPSO patch.  The companion
CIPSO patch keeps the Smack mention since Smack does use CIPSO.

Sorry for the noise.

Qi

