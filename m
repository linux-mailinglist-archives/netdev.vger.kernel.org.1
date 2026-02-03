Return-Path: <netdev+bounces-256367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKB5DiItgmlFQAMAu9opvQ
	(envelope-from <netdev+bounces-256367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:15:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A923BDC98A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5926D301A7EC
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A83D522B;
	Tue,  3 Feb 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXohSfEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CC31A7E2
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138909; cv=none; b=FRIUPab9U2kPS2I1TgvPsUedzeal0ONOwORHCtYz9+Gqc1joemxW4XxYMlblPXDeA5hQTfJ3tsvkQI2raOkkqCDDfCgXE10I5deZ7jA6r5RgZaQ2Ciygr1t4KrJDWYE6xiSDJNFAjhyvOIoRVUDTYXqnty83Ue504I+XPHS8tek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138909; c=relaxed/simple;
	bh=9IRD2kMQDNXo3gixVBTLfiMAznF+A3SRJbEHyG0LaeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5mn4EuLZQVp6H8NUR23SOim5Z2A0+PEZ4cqOI4B7BJyXOohFRn0gsLqhb8Irw+L8pZLWE/gxRevofJVpawMtBR7BEzhR17dh7dMVbJfuaEk/JJFDry7KATqPVtMsCcQHKaHCVDGFZxz4RMWMvNuHhyY2t5V3rxzIfP+r/l7xeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXohSfEB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8230c2d3128so3172213b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138907; x=1770743707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKGteedOEAarJEDtZ9dOVRR/FRBxzionNgqCYXsQ6tE=;
        b=BXohSfEBRzkU/ZLxmtYQqZ8Z/cAD1t5MdqdzEs463w9nAGk674w4WQPcBnSr8UcI53
         CzQj3H7x4T2Anj5RZDEzzDCb2KsRVNk1yc4XGfnQ5hl3O6htWNqty8A8bcAg3iKD+JlO
         BMokOF2xABpv+FFHNtV6DQ7S7IuRpjCy5DwaBUgHcV2rc9t6iI2CPEU3Itrm/q3C8OBO
         v2yZWCkmpLbEDxownbpQdXfI/HztFTF5rlkb6nawE9o1+UkH5QnIndH5F0occe1ISUsi
         7lYtRLrbJglRKF09zRb0gy6wDqnA/kHZQ+Yo1Oa7ldq2TSdacJwML8RY0OjL/Igrcz1G
         JRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138907; x=1770743707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKGteedOEAarJEDtZ9dOVRR/FRBxzionNgqCYXsQ6tE=;
        b=qlqS/+zjn+06Fn/D9B2VwnrIYw61WjlTTdXwgfpyTNA2U+ArhG9EGkLDhEDurK4grl
         NeqBUQi53S/MioPlHPEsYiRxAN5FX7o93flqUNwLaYriqrT+7OoIm1azIycEtksQhp1T
         qXhaGgf6mLpuwDgWARNzUb9cCgkg8qi5lkhGWqICLcRUfuGxd/4ZG33tJ5bnd8DnVf9G
         W25Y+MIjVdMwKP5YwrLAcCngw3++w5XRMRwDkS5QLx/O7BZ7VQbnQnJNzxL07b4bi0QX
         pzlJjvmk2bNRJjneroHw1z8BbMY6LcVZvbiogUI5RplJKMtYphJrMjHgzCR3w38sDapV
         pB1A==
X-Gm-Message-State: AOJu0Yym3n4DgHowfSSh4GjGowIVRwHBgN55PE2BVMFPBml34jo8K7zH
	KfmsWzD1HOmfP9qtWt6SNOr9wFjyhqnoxwIJXvZyNbdYq0P0W1UDEswwnMHyOyOn
X-Gm-Gg: AZuq6aI9LQ/z36uzuSMgRE38w+ZA6fW/TbJ08QwA35Uc5FraWXB6k1xHNnDA5V2cM2u
	G8+MfE0FzeryNnlk7z8xKP5GKZAuDe+neaxbn3gm1xf1nm+zzwkTD2ZtRYBNPKg4CbodrTW/Qyb
	m0ygtj7G2O6RYmNdt7Q9Xnvhc2G2/F6Av1OGGurPXU50WO8CnX5ZXMq6/ECjj+td7LBQzouKbgI
	aDvCYsoUvQFpoNrHlvfi4ThxL9qMOUjDavgZDTDlIptjxWDoXUL3LQd+EiO8yOm+80xuKYVnY7K
	R1m7OEQpdk64QOvkaWQV0DPLHqtkNudfg+WDbrPL9JofZmbIPJ8EytLYm9wHFSegwUklOPP29H5
	aw6k465+PXxg8MU8GTTGW1svrp3RdlnXdaprY8IU7yo1OBR1WSP+Nlix8QjSmsmy2G3UMfLqj8Y
	ElQjWuwR4zwFw7bLafrl9dB7xN5gUeF32FRd9qrrgZXphM5+UeDPVnUhagF9lUC5K6NhqLCXQv3
	MCNgskXae9+
X-Received: by 2002:a05:6a00:bd11:b0:7e8:43f5:bd4c with SMTP id d2e1a72fcca58-8241c67da15mr105990b3a.56.1770138907037;
        Tue, 03 Feb 2026 09:15:07 -0800 (PST)
Received: from d.home.mmyangfl.win (tunnel997320-pt.tunnel.tserv3.fmt2.ipv6.he.net. [2001:470:1f04:2c7::2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-823cdf6fa26sm11075817b3a.58.2026.02.03.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:15:06 -0800 (PST)
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
Subject: [PATCH net-next 0/3] net: dsa: yt921x: Use u64_stats_t for MIB stats
Date: Wed,  4 Feb 2026 01:12:40 +0800
Message-ID: <20260203171305.95085-1-mmyangfl@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256367-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A923BDC98A
X-Rspamd-Action: no action

Avoid load/store tearing of 64-bit values on 32-bit architectures.

v0:
  - Sending remaining part of
    https://lore.kernel.org/r/20260118013019.1078847-1-mmyangfl@gmail.com

David Yang (3):
  net: dsa: yt921x: Refactor port error message
  net: dsa: yt921x: Return early for failed MIB read
  net: dsa: yt921x: Use u64_stats_t for MIB stats

 drivers/net/dsa/yt921x.c | 270 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 114 +++++++++--------
 2 files changed, 221 insertions(+), 163 deletions(-)

-- 
2.51.0


