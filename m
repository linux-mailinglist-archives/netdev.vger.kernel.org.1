Return-Path: <netdev+bounces-260812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA9jOIu+nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:19:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDF2194C7E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42BF73126A79
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5395937A487;
	Wed, 25 Feb 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acp3poik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994836D50F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010554; cv=none; b=SIMimdBfpwPZqiNUqz/SMZHsuNQ9d41TD5xShzsjUcj3b21FsWO4TpRr3G5H0RnpD3IyWb0PHm3uB9r/ragYOe4Tcu1KjEI23P/IBMgnFgmPCyPiBMECjqy5TWrtab0x/Cxzws2E2S/hq0BAVkM0tMS4t2kVfOnO3LREmZUVeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010554; c=relaxed/simple;
	bh=fCTVmXGRfDeKroAascDcUyK/8Nl8nzsm3T2lsUG1At4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFpxmcz4zez1FPjIFD/C27MtLQWjFdwMhn2L5Fz3+w2QTbNAbXaWX4yH+KyzD+Ou6pvduG6D4F57Mhlh4RnYeEUqI3fU6OLZ5PyPrhGiPhRBiEDwSEuGZ2CchsE1EM75H+tKmhp6+VvvnSFc9jQ9F84VsiWB//BU4PC4bODTnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acp3poik; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824b5f015bcso6177601b3a.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772010550; x=1772615350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7P/HVCAizDsdD/uDIQ7Tjrpu5RvrScGl0IVtzmtDGGM=;
        b=acp3poikxdyG6c9RANIRt26jIwzFwCUi0NO+QyC5fVyv2HILQl+ZiVcaqvqemcwhDB
         wqpt5G521h3EIBqZqdXFSnZnDLH7uyYqj/UuF5kj1OiqvNozJTiNE9uOdjQfHTQUAWMa
         FDE6U73WuJpmE0jQi9kfb2uV1VlMppR+gFaM0UxQMu5kidbdD8X6T0yHypoUTWoEbr/A
         an5n7vZhD3NtTlsgELoS0EHNAjB0m8yer7Qt0ZBPHEiheSF71aSCXikrqyEcY5NJOQdT
         K/nkatXeYGJopW82kR9mxjxLXfcVVyn/pqFyBKs3fn2JoSyvMaJKPxhFUBhekiFMe5i5
         MzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010550; x=1772615350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P/HVCAizDsdD/uDIQ7Tjrpu5RvrScGl0IVtzmtDGGM=;
        b=MiUbIpsT7cqEpXYd5LU4i1rk6k8Yh6na2Mm5YktXDd4Dvh2wuJNZa0OVP3ils+Q8zD
         1MlXX1ye1DsKtkDZ9saMKdoDvJQaxUarB45nb2FNhw0DDL+x/pzCv0A5bi0Efv8ey/lb
         szIjXgU6Tjyf9gnlY/Xlgqr4LLuByWO7qza4k8/FdVpoBfqAE6+2KZW4Tq3yfPT0zdE+
         02o/OFsKrr+nL1JRTMRlEEFyV6FYmcm3cMRfWmwd+eriGTyzqGCofj3+Xpzlswii3HzH
         NhsNM3ifyXSYGwK5LZwtCTnSwLAu1tThG4EqqqJwGGVd8QgQ7Yk5V7nGQV4vhlswMj6o
         BNUQ==
X-Gm-Message-State: AOJu0Yzqvwx0LX7mBpr1yAHeo9oQPfdufIBtNY0aUatHixiQkQc9r0NP
	5QSTYmjOSY3RjFXJbfsWnn3WotJlY/2h0wCWixv9Jhe8ZNBg6RfGxRouN7doN+Wu
X-Gm-Gg: ATEYQzyzxwoz0E0hWMBpPkVVmc3v8xYiyDss6+dNQ/6b//250J1Zswvkk50YeBktWCH
	9ExyS/h2lfpUhM78BDKNV3cITYET3xeaEBS+3St8Nb7yiHq9Gu0jzWjtK6+qeq9tPyNX9I1UBgx
	SgeYMQfmKxs8t/eAHOntktO3Ve5t7Xk/AYYhNgLt/w1gTp1oNbdfaFuz+wAulMhzoSrLl0EbUQv
	XW1TPENhL05M8uU+vxqnDNapNk3SCQiLlXO7sR0gp7s8bXDefmlAmJ3NuWUooa0NuyreXKa4wJ0
	FbUS8KBDanryI8iLoJdtiNJGmRbI1b1k7ZVZ79hlqFab/1kGeQdxQVm0cohH/hdJaqDAaDHIqNo
	LbG1+21JcEac30T27To6RIYjHcfBgG/VFC6HXLhhOfshybTRVVRiDknx4I/B3Sxum2JNUskt51H
	9H1JV+ujCBMOElY4TIjikthGynjPYFl98RLO9viLNHMGrG
X-Received: by 2002:a05:6a00:1d95:b0:823:1c3e:95cf with SMTP id d2e1a72fcca58-826da8f1a9fmr11699069b3a.18.1772010550273;
        Wed, 25 Feb 2026 01:09:10 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ecb2dsm12883345b3a.60.2026.02.25.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:09:09 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: dsa: yt921x: Add port police/tbf support
Date: Wed, 25 Feb 2026 17:08:44 +0800
Message-ID: <20260225090853.2021140-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260812-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BDF2194C7E
X-Rspamd-Action: no action

David Yang (3):
  net: dsa: yt921x: Refactor long register helpers
  net: dsa: yt921x: Add port police support
  net: dsa: yt921x: Add port qdisc tbf support

 drivers/net/dsa/yt921x.c | 537 +++++++++++++++++++++++++++++++++++----
 drivers/net/dsa/yt921x.h | 159 ++++++++++--
 2 files changed, 623 insertions(+), 73 deletions(-)

--
2.51.0


