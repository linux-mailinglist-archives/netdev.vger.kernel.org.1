Return-Path: <netdev+bounces-271851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INFvF/fKxGlP3wQAu9opvQ
	(envelope-from <netdev+bounces-271851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:58:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747B32F8D3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C3F830266F8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B0B3ACA50;
	Thu, 26 Mar 2026 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf02eqKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D132E692
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504691; cv=none; b=rx3xt2rjw6rtmk5GTcDIIl9xQ0fXUhHsRrSqwuAyAV3YF9xERCkbohf3QrQRjpoG8kezQ78I368Jyu/bZpZFqv9NIdf3ixn7pYDZfoPXVopP4cpB8cTdhwe0wHL6BfLjgBThMeLOOG2eGh3CAOFR7MIw8mZIUsu943U+gIeTYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504691; c=relaxed/simple;
	bh=wkCtGoeiLb2rfBjVCj0WVbn1wECQPqQ3lVJV8ZIDHHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JoHUAxZzjc63dbHau9vx30QwyyjS+jBCh7JWpi7taM+UcATCymZiZaJxmCTcR+XA1SFZzO+fImxcv267RO3nTAgHTmDSbFJSujnw1Ez7zna4Rnblk4wbjTLUYsFzwqGUPgDEOUzIy3E6tc0nYMWTjYsfV8C2SQvSOkHpaPcg7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf02eqKN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c742d4df00cso706857a12.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774504689; x=1775109489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/WFOK/vH5ISCB0eof2793eZ54ZVXlOYGnEGW6kLrgQ=;
        b=Cf02eqKNdiPZfd4L6lEwKXQDZraOKDys1Wb8EpvPaDiSBihjTfDPUE2f+hEDvYlWbU
         j9jrPHH72OMj8XZ4Kz2Lc0IrjXVgwdaKk6th0lLw05xoEF0YjNNNES7bJ606Wu4ZfMU2
         v7Yk1qXT9+BMuE0binTTmevqWujnWbatsZfdlNQ7EebMxbiv0y/eR64SUMxLw51jM1KI
         E1eLePOf/33HE80pn/9LEvrFBotVhz9naBUWE+Z2aqt/uebZpG7OJIpGfmNpVZJIoJ7J
         0M/gQpmV6NtKAe0Y8FyHGAB1untwW5qstCA1dPlc4y0YHx4iqP9+YGqs26qjgxU/U7Ps
         7+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774504689; x=1775109489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/WFOK/vH5ISCB0eof2793eZ54ZVXlOYGnEGW6kLrgQ=;
        b=kzXLXzbllE9oY65itORvLcW83BUm8c5xltpRYajcIEP71pq/pIelgKDZup5BlptIZH
         EqRdADlwImbBbFvwXlgbIGjdRw30tO7z/8FDDifpP/XYSsLAAoNI/dSPqdBXOO+S/2Vt
         l1Y+wz5S+KaFyYJDtiedUYJLyXvh7YWoIzSpN2O5X5VvzTXo/WlXXEh3/iqhqgMl+Xip
         G/1Qszno6Fp2S/m8GowPHlahpbD4TWv6aoJ4OaFlOfMbxW37KEAE4wIjaU1+dJFqbqZS
         e3/IHW+r6frMLNynRGmJkp3KHTLYqV6eI+vaAnIIFmgkHXcfAJ7B1EYf2mpTVfMCbWfm
         hKyw==
X-Gm-Message-State: AOJu0Ywv/Rpf+i1pwZYnfzYwY90GmZYQOe9tNJlj87oFMLCIhcxzxv5S
	ckFEryGdwfrvQsbXQgXS+NJIBWplW5m2hN4KpIPVfV5j7HZ7TCt/hICEldsZW07oiZs=
X-Gm-Gg: ATEYQzwRCVPFcl940xcIeYpTMJLS0CkjG8F2YI9cRMxur3tFEfjdKQK99MLg2XDG5C8
	14AfwLuC4Y58HmmllO0ybJOrtkgbGtWbt9jGjP644m6IqGE/0Jewx5Vnou4OzehyAJ86KVXjcG3
	WZcsaUsBQq7/Ofi40d9A3pvl+IufVQg4qscjR+mqmj2zA79chN9JBUrwh74YkY6c3pb2AEb6LGA
	PuZ3ynkKLRgECV2mnNMEvcTZLFmtrXWk9Z4rEKV7aixtZz/czhX2+ZgN6kvFQE2b6jzn0bi9sa2
	bVRN8RPKWgvOdgBfmHgj7Y3YNKXr9UWC5ag5xzf180TWD+RcXA2/BWFmQn1LZ7VTeaE1r8IPzWj
	lve8MVs4DUhYkRqKL8UA4JyyWkwPKqIedLKdtHJo+sQp2Qq37JGCsUuCfBGe2HAVF9qla0g1R4M
	dRI49I9XpGe03adc+uL7cz9CM=
X-Received: by 2002:a05:6a21:6d8a:b0:39b:e810:f625 with SMTP id adf61e73a8af0-39c737ca6bdmr371571637.32.1774504689213;
        Wed, 25 Mar 2026 22:58:09 -0700 (PDT)
Received: from nixos ([240b:10:ff26:df00:3001:9be6:4399:d681])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76737f28d6sm1243558a12.6.2026.03.25.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:58:08 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH net v3] xfrm: clear trailing padding in build_polexpire()
Date: Thu, 26 Mar 2026 14:58:00 +0900
Message-ID: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-271851-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0747B32F8D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
v3:
  - fix Fixes tag to cite the commit that introduced the bug
    (was: e3e5fc1698ae which fixed the related build_expire() function)
v2: https://lore.kernel.org/netdev/20260324013742.939533-1-yasuakitorimaru@gmail.com/
  - add Fixes tag and Cc stable (requested by Steffen Klassert)
v1: https://lore.kernel.org/netdev/20260321210421.2504711-1-yasuakitorimaru@gmail.com/

 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..ee31ef482be4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3948,6 +3948,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset_after(upe, 0, hard);
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.50.1


