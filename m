Return-Path: <netdev+bounces-278543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCyDIjx03mkqEgAAu9opvQ
	(envelope-from <netdev+bounces-278543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C375F3FCD54
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5D08303EC3C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4FC26159E;
	Tue, 14 Apr 2026 17:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B322C0F7F
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186350; cv=none; b=FAdYIW/wHnYVVGUmZAkmHWI72cV7/jtMqn4b56mcoaceF8NfFI9RbasntfsVSNDiYjPIIUPNEZOrIFUne5vj5+sxG8B9SwSzgBay6e6wR5K/eri1bG+ATo582+rHUkIGsi+Q/r+1YZiGYLCsRE/XD4gDVxRZwp1bdQ/GPMx+Asw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186350; c=relaxed/simple;
	bh=gq3wRbVC4xiTc6eKlo03Eo/RVYblxKYExexEkzap//c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=I+8Atj9RH5Lund2tCSq5QfzHc1uxyb6hFoJFI42jLsIVKiM8bj6MPMUsARs3QM16dFYHgo+5Q60y8QxHwA7jrV3buTxpMmAQFek0D8Ef6n17uYbOpZG+JLIRvbiWAMiZJEz2HPfAqE5Z0iHlxUyU6GKcH09gzuQj3j3GJFCPafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-42394108a90so10472466fac.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186348; x=1776791148;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq3wRbVC4xiTc6eKlo03Eo/RVYblxKYExexEkzap//c=;
        b=X1xaO/iZ3/TIADQzNod6WwzxOpmbv3H8R06TWReiTj+jekKCqtnqcD9KvVHEVfHyX+
         CSkUgnMAerHIG/SihZHKDUodwdqGuJKANPGZVIqrWTwszSW7azsYYi4iQGUegdLb6Myh
         ieaurGvj0z8mRHhafJi0mUV4ZsNZmLGzMEsJ14VLnowr8x7jxqtYvfabIapn1X+PQpxF
         cudHKcleH/Bf0vqBXQ0Gl5sYw6JRJWGAYndNV4BxJ1YrWHSJYKzgEHj2yaUi5+eP9rpy
         toVw9HjNHd5zXUYIwM7CLW/o4l+MAe6niftuWr3WU8Nn0LFvOn3+HSTWJwTsyy7vaPAx
         9ogw==
X-Forwarded-Encrypted: i=1; AFNElJ8oXLw0XL3G1lwh+g6aAVdMRWupuBvD3NVLqzEvVrfh8Mv9SWj7/9Hj80iocepg8v4I1mC/8nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzykRBqD/oCkvs5UHFLrPiDU08z2EUq0k9CA+OVQZCF7D52L7GQ
	s/33G37+Xeb7YUTur5tpmbl5Yrb/mJW3KKYBCZGM4L+sZV/Ty5prqN9WLTy8Zkg8gAqekvBw4Oj
	tOFD8ODhQfpCvH9fcbIWexx8qCccZh65mahAhTGzYC5ZMHv5LAOypV4GRxSk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8519:b0:689:7ad4:cba2 with SMTP id
 006d021491bc7-68be7ee3984mr7566692eaf.35.1776186347962; Tue, 14 Apr 2026
 10:05:47 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:05:47 -0700
In-Reply-To: <20260414083316.19864-1-nogikh@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69de73eb.a00a0220.475f0.0045.GAE@google.com>
Subject: [syzbot ci] Re: veth: add Byte Queue Limits (BQL) support
From: syzbot ci <syzbot+ci113dfe74f48c7ad5@syzkaller.appspotmail.com>
To: nogikh@google.com, hawk@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278543-lists,netdev=lfdr.de,ci113dfe74f48c7ad5];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzbot.org:url]
X-Rspamd-Queue-Id: C375F3FCD54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the suggested fix patch on top of the following series:

[v2] veth: add Byte Queue Limits (BQL) support
https://lore.kernel.org/all/20260413094442.1376022-1-hawk@kernel.org

Patch: https://ci.syzbot.org/jobs/bf27b11f-8196-4c99-bc10-11843ded8a31/patch

The patch testing request could not be completed:
tree "net-next" is no longer known

Full report is available here:
https://ci.syzbot.org/session/31e795da-e7ea-4f46-8412-c30d420a5f1e

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

