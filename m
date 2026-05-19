Return-Path: <netdev+bounces-289234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLHlLvG7C2q3LgUAu9opvQ
	(envelope-from <netdev+bounces-289234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:25:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564057608B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B02633058BA7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB12BEC45;
	Tue, 19 May 2026 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUDGCFzk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFE2749CF
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153782; cv=none; b=WwwWgDRLuO3ZuNdfFFSgW+y0I6FMMv4uO4uMwcfSk58pkZgLIGbj0kPRos3fX571ycyPjSg/dT4wO4ZAckYZndNfW4cw6mOBCv3qZwC9IjSoHZJ3pv2IXCGVmlruqDFtvyYpj2wjQzMJQSudOzDSvx1jm//Vvs9cOJ3cNaYLpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153782; c=relaxed/simple;
	bh=Y08IJeT7eg1AM0JqdRzNKlNYQAhW+GW1ufuXhwZO65Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qu/kIm1f6b6q2zB/MvKdjOJtM5Le/s4/yF7+/AdeC17Atq6gkTFfYkQamu7917G1axOjgu/8ZCW1kiC8PAoJlvS+iWDs3TKxpETbduTAZhdnVuQ1zcpBuYpMPTmwS1+nfX3K6nn+NPf7i8IirHAfkvHg4ynn5zXVeqNWF8R/YxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUDGCFzk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891b0786beso20790345e9.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153779; x=1779758579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVADxebGolKTYEx0uBYNzU/+4nP14YmYsqJ1cjkXF0w=;
        b=QUDGCFzkcVBMZfROdKaVoJzpEXnAiKA7dJQVzF8qcqlQMf1qpHvIqc0+ihojkDWUG7
         k4XSTZLqjq4H9HR/3ZG4rRQa/aUAsFv2seqCuRocfmSN9ToVK6QE263x0YVoF1Jte+Ug
         KsumIl9NsoC2UzR1O/LVuoOlJy3JgSB6VabxmOQLUPIZk323VRa8i2dyEl7/jXpSQyNw
         I1pn04wgh3s+BY/P5QHgrrGQ+7MIG+WEzN3v4to9nAbBWoiClGfXgBvXuEL/ZT+dmoZz
         vQouI5aolZhQmeUnkzM0/bEztiw+ePUL1QlVYhoouzTpBhGz6EgmmgkLc4fDMeSvgQ0t
         m0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153779; x=1779758579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVADxebGolKTYEx0uBYNzU/+4nP14YmYsqJ1cjkXF0w=;
        b=mE3PuLDQRyOGw/oO2Bpdhp9pPx9KmQsCnhVjaH+xBUP2VvTTw5UKoEtfktKysFrYfI
         bdh9qC8QbZpcptHagXhHR839y67qk1QXhl2ADtWcQFeDRcXqqRdhVMyQg7EOlDN0DuEP
         ldmMKeKGrhYayWh14Kz8RJpjeXn0sA/KK3Gm2QmG9sCzwo1DPCqEpFUiphP90spM78Zn
         MvQ3bLTKFHGreyWR815EScedybYOmXsZ5wqCd4UxYagVWlJKi932SjyK8UFRdNIIU8Y+
         K9ehNJGQwsP+Uf5WfKdq3qqQS1xnSTtdpegNznuZYlVFQKEeD6qV2lX6BJj3JWl1IUHP
         zriw==
X-Gm-Message-State: AOJu0YyghdjrAxUJYi68o9UiMqmGjOsZ3XpGFD91+0Nz9q2tExDDKdEx
	pMCD3TORVyoZ5V/jHNodm+q8S09c9ME6DUGwEKPYDAN2se+0kk/wIVq7cNiBTM22d8c=
X-Gm-Gg: Acq92OEEL0xOi6Mvjzh+itv6hf7a9ad9RfN9OLmidkxu9LlstPNppw6xrBHoGnHeXsm
	JlaZ+FOcLBQEadU1ZJrY6733iO8/kQ7C+dP8d4/GmadR3WsfC+IjkZwF+Ep8BM7PUwwTB38/fdP
	yCXqL3SNNrZL1HnQzY/1dVTVD8E1+13gH14PUNqegIaX6FAy6GsG4YBny/cpTL+I34wxfXwFmIu
	wfMCpq32jsQTlOkiVyQxenCPB+0nbBLL+4TwRHQbzz2ATmtAc54kmJdxxH0PtLDSw5AwLAxW5qW
	ktRpklb96muChqQK7mkQ8+H/6n5ATfkkPvO4Fq7rT1MmhwwFJlg6e2odFhjtDEetbPM+FE+PsnA
	82NzHqooLpq32hfWudrIUnNS/1cI5LuFir2pqnc2x+Ok+NjxMylPFhJ87cQ+e75HJHh9a0f+gqZ
	P+xgXRgfcXWcXJRMT0JwHRb5nXP9aAXrDJEMNkxQDP34xf7aab300gqwjXJk8UTj0NLrwYjQfDc
	Q==
X-Received: by 2002:a05:600c:46ce:b0:48f:d2b5:d7 with SMTP id 5b1f17b1804b1-48fe60edd2dmr255838215e9.12.1779153779331;
        Mon, 18 May 2026 18:22:59 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm44255416f8f.10.2026.05.18.18.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:22:59 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	david+nfc@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net 0/2] nfc: llcp: fix OOB reads and integer bugs in TLV parsers
Date: Mon, 18 May 2026 21:19:35 -0400
Message-ID: <20260519011937.12903-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,ixit.cz,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289234-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,nfc];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2564057608B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes memory safety bugs in the NFC LLCP TLV parsing code,
reachable from a remote NFC peer via crafted LLCP frames.

Patch 1 fixes nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv():
  - u8 offset wraps to zero after 255 (widened to u16)
  - OOB read of TLV header on truncated buffer
  - OOB read of value field via attacker-controlled length byte

Patch 2 fixes nfc_llcp_recv_snl():
  - OOB read of TLV header when tlv_len - offset == 1
  - OOB read of SDREQ value via attacker-controlled length
  - SIZE_MAX underflow when length == 0 in service_name_len,
    bypassing the sn_len == 0 guard in nfc_llcp_sock_from_sn()

Previously reported to security@kernel.org on 2026-05-15. Willy Tarreau
advised posting to public lists as NFC is currently orphaned.

Muhammad Bilal (2):
  nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers
  nfc: llcp: add missing bounds checks in nfc_llcp_recv_snl()

 net/nfc/llcp_commands.c | 28 ++++++++++++++++++++++++++--
 net/nfc/llcp_core.c     | 23 +++++++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

-- 
2.54.0


