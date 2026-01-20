Return-Path: <netdev+bounces-251607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDqvHanzb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF94C42A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39E2AA838DD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFCB472793;
	Tue, 20 Jan 2026 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S/cKKkM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13F3D34A6
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938127; cv=none; b=h8+TReydpsfs7PNILXO2FkdFTN2VwiMhTaiTn8IXSJkY/SNIaUFMkU9xqcOo3U6+kaD+vNu8drNhWzNyo7U0ddOp1wl51l/2Oa8NrJH5zFHGO0Jyp9poh58t3btiNiflpKn1pTGvvA0WB41HX1p7Dyd6gdhSOuGzq3SGGhk/XRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938127; c=relaxed/simple;
	bh=DIoY+22eO37j5t7oVY26nJ56ABVXG2ybuHCG/zkYEQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q5rObXeeWvpwW8N/laPuFR44jBUZMUaXJ/M41R7hB1mWvz9NkML4GcgKUn0C77V/oWU5zSTR7UMRFHxSy9kEMpyZoNBPqHFsBy8ntWyAFyspxhhtl1JIdjxmmGjk3DheLsSE0TparAFlhZzctv7ZFtwlyp6os7xRzitqUyHBJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S/cKKkM9; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so3434863a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938123; x=1769542923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AonAFsFnqliVcLZEjIfBaBeevri1Y0om7hgYL7HSTA=;
        b=STMifl+jsWo3mj+DM6m8M7XGiUbfFPxW6sHZdxKWWN1jEmlLeYCHgRXbncsYYmN58T
         T1aOySZ47WvJolcq6/UAN6SN7/Hz3zYc8wxjlmKJZTsxMQcGPff/BZ+TWSO127vAq4z1
         p6CJTXI6Ox4BWcryUNIPNCiIzk5wRLtGM4SlmlGaM7xwFm9nV59Vf0dpGK+Tna7/eiZr
         leobdDXzhwAO7HClhuSBnmKxkuoK6HVKaKGDIbpmG7RMJtQoIKhjS72ngsSZusrjkNeU
         QP2IScoIGP42oqQ/u9iQePOkkE3xrarhca875oeNDyh8zmh/Ugd7CNLjUINepgGe0tKb
         AtiA==
X-Gm-Message-State: AOJu0YwaNagU+hq/65LVnX4w8aWxL1mHWEwGZxNzZH/ssjk3zDr2F59Y
	smN6+vCEUeHowtaye7ZaW+3x+nONlFN0WbiMbRT3yWTvTSO3L8oY6uzXMpW0q0OYNINq7K+a96h
	qUZnVNpRdxYQdF6KjvnvvDXbumJrNMsnbs9HEFrAOx46X/tC+pubDUDP1Z0XvoY1Lgm1Wn+HjKb
	7N/CIF7ZEJnbDF3kZpG+IPJnIXdZ2xAqUS/yKSelqBO2ndhH9fLoG6KeYnIOxVFRU3h9DdL2BGz
	DBVxGsZVA==
X-Gm-Gg: AZuq6aJ3FdZM37nfstpY4CUPy0DinnWZIsnBUXoHEekSbAfxwVLmKE0hf/N4vcXEGWh
	8HwZmZKq6hCrnbAn/kN+12ELc/iAkUt/4jhelDAiAt2ELLr26x+04Xr6jt7OimM4Ktl/FvITivX
	6agTq2Ww2GX4LL7+hpxL7HqWrmy8GEIgoaPgm9yMfxeq2AtzE+ZSz2CGhE4kBGRwT+1xp68utcC
	fgrMd+ZfpW7c6LG6HpDP2In5zQxZ/h5MgDcx954DmwxRHynm780/CHwDHuBxxL0TbXNY3+tMefY
	LXBnmK1DaEPNYrPs/bPIPCBIjl38FA5DyI8gAiuBFJ5DN+RB5J2dzdXMqNSioFSWFheYZnkq0iB
	qMJZaVs5DjO08vbtXgAnwW72VDhB1jsRIqisfVh98cLL6ipb5ok8u3pprg17Tn6Ef+Sf1RD0WVZ
	0w46VR8Xh/HN+zvdGnbBXReBpDHirfFo/L9dAmXLq+98c=
X-Received: by 2002:a17:90b:5344:b0:34c:904a:d92 with SMTP id 98e67ed59e1d1-35273274567mr14013235a91.26.1768938123239;
        Tue, 20 Jan 2026 11:42:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35273124917sm2026741a91.6.2026.01.20.11.42.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:42:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89471079a13so1414846d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768938122; x=1769542922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7AonAFsFnqliVcLZEjIfBaBeevri1Y0om7hgYL7HSTA=;
        b=S/cKKkM99AeTgdS2eJZGNN1Ipd+FBBpzrvo+3c6lsD9nvHzibJtNbbQQDew9Z2hjT8
         SIIYWmLnMJ1k9rNpxrwQWcgrOrhmRWTWlMDKMhEUPvpSeH0uuTj2RAdzMUU4L02Z3FMf
         8D+Yt89zLqJ/z193Wnct0R7JGDi7auvjD04s0=
X-Received: by 2002:a05:6214:2528:b0:888:4930:797f with SMTP id 6a1803df08f44-8942e5abe5dmr190202916d6.71.1768938121704;
        Tue, 20 Jan 2026 11:42:01 -0800 (PST)
X-Received: by 2002:a05:6214:2528:b0:888:4930:797f with SMTP id 6a1803df08f44-8942e5abe5dmr190202636d6.71.1768938121242;
        Tue, 20 Jan 2026 11:42:01 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c9b83sm110887586d6.46.2026.01.20.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:42:00 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 0/2] net: bcmasp: bug fixes and clean up
Date: Tue, 20 Jan 2026 11:41:52 -0800
Message-Id: <20260120194154.2047656-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-251607-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0CF94C42A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Clean up and streamlined some code that is no longer needed due to
older HW support being dropped.

v2:
Dropped a bug fix patch and sent to net instead so that it can be
backported to stable.

Justin Chen (2):
  net: bcmasp: clean up some legacy logic
  net: bcmasp: streamline early exit and fix leak

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 32 +++++-----
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 36 -----------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 63 +++++--------------
 3 files changed, 28 insertions(+), 103 deletions(-)

-- 
2.34.1


