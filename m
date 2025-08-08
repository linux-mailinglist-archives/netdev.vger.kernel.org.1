Return-Path: <netdev+bounces-212132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE935B1E378
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9544A7A4B3C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 07:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E582727EB;
	Fri,  8 Aug 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jec1pppl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66982727EC;
	Fri,  8 Aug 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637961; cv=none; b=cM3iZj18+m/NFWUBmP6TkhQDzpsx4SbqoTsURRpCXLVXpgdoKPzFpuj4jcbpSUsnNyIydDiyNvLUEUxEi/iAr2H5N8HnL48fgHFHcQESLTe/Y/+y55/YfQgXAgf4DRhC9tA1eanGViTyv/nyC5t387u2Tn2gkU9hHAwzyzj1TT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637961; c=relaxed/simple;
	bh=v99kbMIWKT1gSbp4MBDwhcbuLTRICTgVOKhRkrvL90o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9XVW3IjoibekohhQ/2IW5IAAek+ZEdyIeCxmA0vm5Mahu60tN/We4odrQ3DYkSIkw33Rc+I3o9iBsF19NZ8O+c1fnUZj0+oZm6SaFrfnPL5tqgK/1FUF8C19J5AHhOitAROaOkUsyswDmLZMMBVNlsoJa/GvKFPHOhXo4wpf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jec1pppl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1363495a12.3;
        Fri, 08 Aug 2025 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754637959; x=1755242759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+w3axXai/UtW73ThtGKJHbQUS3xBpWeg88zTzqK2pw=;
        b=jec1ppplVf1ly/IoLgSlcF0y+ktfLxMyx77nAF95yGsmcueoRGK+6c8Q65Xsh03M6O
         cBeZL5hHrFJL7/1BhoaTgjbIR9kyUYEd9Yo4utY7PIMPiioN0nWikZLkf5ys+4fL3M3a
         sbJB1qdYaGuPvvsSoa6JXCx6Xq1+IqUrZ7XcTq9cpvrxQxC3ecXcRmiludaYKYr8gyzO
         uGbEZ2WCl74ZQ9dkY7NNaEhv76mMBOHFlALNcoQed69K+NVivb8VoQ4U64iqOrJ7bQdJ
         e22dKTHl7xPJOvMYP+d+OFRPgGMzlVdHjxebkdb/HKHCLrWe1QDdvRNiMN489yZemIrC
         I5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637959; x=1755242759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+w3axXai/UtW73ThtGKJHbQUS3xBpWeg88zTzqK2pw=;
        b=k/qDclKR+/wkJSoBSBRfAZIsiwgK21kSCutXSCAL4323spMSHJ0Re7ISXrgOgdmEle
         1NKcfMPCg3s0gQJuRPT+SOA5drwZB+555j3TEY4XcKDp7BaajsJ/ydLa6C13YPuyvn5W
         DfwS7NLGT35ToeWf8Jurb43BFX1RHuM3hqnVz3uBJgyJo8D+YR7ZLiLxxVQTj12Do9XM
         DG0lY1ppx9qeMIkRJlXC/cH44FsWcT2ZsftbBjTcwx2jXXNumJo05lOxZHkvgyKtxn7l
         vBHe5fJyvwzTPEpW1QcKGEQ6OtNkjzBMJqenPIsEqzCDH0IfXvlcUiFwpKiB0KuhfObs
         rTaA==
X-Forwarded-Encrypted: i=1; AJvYcCUUE7lOzcj8oOqatTYG/qnC6Cd2B/hAntt4sxHGtc+DMKk5zgNdIEGX6CcQUHYGt8ajO9JM03llIQrunH4=@vger.kernel.org, AJvYcCUg4/cJ5X0eN8vuB2OJHiqugPjbGXhclvzTrQYWCxIE+PRreH85q0NFrna4nSoUhBoOBjO9FABq@vger.kernel.org
X-Gm-Message-State: AOJu0YzwzRDNUagRRDR8+8lQIrY0KwpI4W2dy8aiGpT/auRD/NTpfrNE
	p5yos0Tg7/gbtCrNNd7GfNMr0ut3WJU0gOdep6+9TR6ILKj5dgmaWaLA
X-Gm-Gg: ASbGncuXt3RwQym3cDxW/8A1LOxVRjAle4RE15RvwJgcHTRFcn8PeyxtcI2Khdk6L+I
	MVErAal31W8I6rTApQ/MC13IlWgFFE/uJ6UyNJ6xEbNiNaoGP2PsXYIzksXAfYacikBobBroFRk
	gXWOu/CriyMSdUkqcIbNkA+RkVg2JoMWUzA0771GGTAlhBxOS4rUmn1XFFZ19aWGvu280YDwqcu
	xM+7fKS3sJtp5Cx+mqc3hekNn/oo8WBg42xNpp2vRgBjk/hsg2GA+PUVnwnKXRyJpII4GZawdZ3
	FfMw1AyfT64ktpYyXFM1B17JMeTZEibpIRc51KLAWiCG9pUh540A2SscNnGQdj++rWiomAHbfkk
	fbS5pKKpYqzmiV1r7KsBh/xHyHg==
X-Google-Smtp-Source: AGHT+IH+BOHmBGxowe2FnNX3h7QUib3N48XSR4eZZ0MEEWyLgwxzWx6m1pzQKL5wnLBbHG4viJE9Cg==
X-Received: by 2002:a17:903:40c5:b0:240:49d1:6347 with SMTP id d9443c01a7336-242c221b477mr28279985ad.35.1754637958692;
        Fri, 08 Aug 2025 00:25:58 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm186893565ad.63.2025.08.08.00.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:25:58 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com
Cc: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC v2 0/1] net/tls: add support for limiting the max record size
Date: Fri,  8 Aug 2025 17:23:59 +1000
Message-ID: <20250808072358.254478-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a handshake, an endpoint may specify a maximum record size limit.
Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
maximum record size. Meaning that, outgoing records from the kernel
can exceed the negotiated size during a handshake. In such a case,
the TLS endpoint must send a fatal "record_overflow" alert [1], and
thus the record is discarded.

Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
support. For these devices, supporting TLS record size negotiation is
necessary because the maximum TLS record size supported by the controller
is less than the default 16KB currently used by the kernel.

This patch adds support for retrieving the negotiated record size limit
during a handshake, and enforcing it at the TLS layer such that outgoing
records are no larger than the size negotiated. This patch depends on
the respective userspace support in tlshd [2] and GnuTLS [3]. GnuTLS
patches have been merged.

[1] https://www.rfc-editor.org/rfc/rfc8449
[2] https://github.com/oracle/ktls-utils/pull/112
[3] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005

Wilfred Mallawa (1):
  net/tls: allow limiting maximum record size

 Documentation/netlink/specs/handshake.yaml |  3 +++
 include/net/tls.h                          |  2 ++
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 ++--
 net/handshake/tlshd.c                      | 29 +++++++++++++++++++++-
 net/tls/tls_sw.c                           |  6 ++++-
 6 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.50.1


