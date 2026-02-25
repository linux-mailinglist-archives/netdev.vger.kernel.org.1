Return-Path: <netdev+bounces-260746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBDpN9BunmkvVQQAu9opvQ
	(envelope-from <netdev+bounces-260746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:38:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A081913A8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DE3B30479CD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866A29D29E;
	Wed, 25 Feb 2026 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtIFK1Dn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664D21FF49
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990729; cv=none; b=qU/rHJU+VAO3GTlK/aGIVRifRvAZKW9R+1We2K+0HpKfCHuy0pHaNNFxst3FI9ddnItqn4zDNPH8tx/UDEEVMdKuNR2epuiPz4MlnasaJZt85b2rkKtDOgQn1U1mCSo9fOtZFIBYCiRKMIeTIOlHfim1WRBj5VZ92HTBRl9EKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990729; c=relaxed/simple;
	bh=CgQkRKZi8n6qzzxkB9hjDn8pnf1PBXTxjcBXQQvQt6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBtrig2fFJwpTN+TOFpPieo5lYMl61Zj4mzXirtxIZtBr4MT5hJM7+HB7t1LMATAvRcFRnvq3xQ8EsMHVL1YpYPtui4GEcHCaDG+rVCV7dVRiNyWu2yN0R2eQL+ioTpa8p+X1Y4LChnxC0JpC8rNQdJ7O+L5oGy8UrzUOYJrF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtIFK1Dn; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-358e16d7da4so916800a91.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990728; x=1772595528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIBkt8Uip58Gmu/ZZcPFAEjJpU3JU8q0pJGlTo8qLYw=;
        b=XtIFK1Dnt4tcqNGmpoj6BOeL3AIdwd4poBI5l7IyavqTLBsj10dNFs1bVW6HK0qhOf
         j6K43QYC3yGBTjdYB9ARRLZeMXs2JepmT2vYkyVU59ENe03vsxX68FyeWtpIAwVjkCBh
         ctb/wC/8y8rhN66p4KMAtWS/8KnBMni89vt0QnaAqUrDhYiEBpargcGRFmZ266yZpcT2
         TMhalZYlKCvA5AmOhCgsB28A88wH8/KYe7riD5PtsYw/eWMotNQCZG4iyFY9Cda/9w7F
         MveX3Vx7V5uJ2m7AVDMLoBgv7c2P3Q0ZKNuEkWHj1LcJxOyOztNFDxbo766whU+vyakB
         8JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990728; x=1772595528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIBkt8Uip58Gmu/ZZcPFAEjJpU3JU8q0pJGlTo8qLYw=;
        b=FJ3teHZ/n/7AKahwO1g+DRszlp+LsNSiYuRqy+0XLbkLx6Zln7LSpWlQsLsRo1vL9K
         VKY5nedTX/zR3rPaKxl1uot6sTqs/6+mheHG/hibtNkYIYdmFuQP051l8bVBlUI46ea9
         gHp8F8im0HCUI+qs1cu1OlMAG+3cGjhAzg959il53+/jarU3J3iopffS5onSAzAIFR0f
         I/yDByjVYn8CeHe+Mzt4lhqhOtz7FvZcejM38lfWp35TNki+AA+S0lW5BHccrkp73Gj4
         cZD0tkmE6lmdOAv4u4HOZfcHIY5AIY9cnG52wXj7L/jWw9zpmnxGHjciRVxVJSctwnjC
         9W6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+678rxRzSsxIJjwWjsczF+KMY3+SIVfho+9mtkz6aT36SKmIafzpFaU56vJ3x+ap7Rk3dZZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tyu5978FSyQtu6QXrmBaO+J3en4HvGmrgRPSOVl4nBC3Yg/R
	c2jOt3wzoGa/SDygJzxHd32UyCJJKBDXUg+ZJIOBva6uyzmx6OBhjVDUxriwidUSIhQq/g==
X-Gm-Gg: ATEYQzzRpyBlxjn1+19K6BxgaCiZqLA8AK9lEj7JOABlqHQOCa6HrBsGi8pGAi0eXfV
	PmicuCS1LGUBrCo5LELsiHtj2jS/kaH66hv7XD4r/K93DRs8dgp+pjUaHAdJ/XM9Vct/66cRTE7
	yPyo9yZTVq565vzS6NfYQYk2Nl5FMRBqVaVZbS/+wP33TZRp4A7rARc0Z5pLJnV2S+gvJhgp+c/
	Zkci+acNShp4+chfKY05FVMhSG5Lbb+bKsfCt+zeTQ5c6ctU7tYUmJpdHYqipZ96SjT74HxdnRf
	2R47pnHTfYGTEW4AQSSfifMt3XM30XG7VHqTXcTwQ3JDp6lkIwNHyGMKzzhzlBdgmjBca+8rDCp
	Ttv+xEiteHnMfXzT3b7BO6Z9GsTCDu+WXfWUQld6nmR0AdTrpUfcLS5D1G6dEigyYG8IatAl2c6
	lW1cEJyPHw57EQDi+bC0NjVYuhwzvZcCd+Wf8jTRlGl2IGytGv1kiNU+0FCW0IFzkXgx3+Xg==
X-Received: by 2002:a17:90b:164e:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-358ae8d80d0mr12854544a91.23.1771990727568;
        Tue, 24 Feb 2026 19:38:47 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:47 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
Date: Wed, 25 Feb 2026 11:38:36 +0800
Message-ID: <20260225033840.33000-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225010853.15916-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=ericterminal@gmail.com; h=from:subject; bh=1tb3uAWyvMrtFX3Irq/HFgcUiWj8AVbAWEAlYdlN66k=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5PjOL2xPl8orDiN9Vn/QSb/0BUXPKvm3L10KPZa0 znOjmuuHaUsDGJcDLJiiix3/++bm+t1a8517sO5MHNYmUCGMHBxCsBETn1i+O9fn/J4q9KXlT41 l/z2/fnWJGZ86GTOW+dJyx3eLk7MfLaM4Z+Ozll1w1OGChuc1/+1W/D54UbVPp8HRzkuSX/dd+p zfSQnAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,kernel.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260746-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A081913A8
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

This series replaces deprecated simple_strto* parsers in net paths with
kstrto* helpers and keeps parser behavior strict.

v2:
Split the original large patch into a 4-patch series for easier review.
Added a prerequisite fix for xen_9pfs dataring cleanup idempotency
(Patch 1) to ensure safe error handling during the parser transition.
Refined the xen_9pfs version parsing logic to use strsep() for better
token handling.

Patch 1/4 fixes xen_9pfs dataring cleanup idempotency to avoid repeated
resource teardown on init error paths.
Patch 2/4 switches xen_9pfs backend version parsing to kstrtouint().
Patch 3/4 updates bridge brport_store() to use kstrtoul().
Patch 4/4 updates sunrpc proc_dodebug() to use kstrtouint().

Yufan Chen (4):
  9p/trans_xen: make cleanup idempotent after dataring alloc errors
  9p/trans_xen: replace simple_strto* with kstrtouint
  net: bridge: replace deprecated simple_strtoul with kstrtoul
  sunrpc: sysctl: replace simple_strtol with kstrtouint

 net/9p/trans_xen.c       | 77 +++++++++++++++++++++++++++-------------
 net/bridge/br_sysfs_if.c |  5 ++-
 net/sunrpc/sysctl.c      | 24 ++++++-------
 3 files changed, 67 insertions(+), 39 deletions(-)

-- 
2.47.3

