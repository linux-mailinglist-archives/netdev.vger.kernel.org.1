Return-Path: <netdev+bounces-271329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFbGNl0Vw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:51:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3D31D788
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0360D300404C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B403C5DB6;
	Tue, 24 Mar 2026 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVq7gNw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A43C5558
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392595; cv=none; b=LI64f6B03iFdbhxuHm7oeQ667Y0WDuEBQMULPzfW3NskdA1JzxE9TwJR+TBBewDe58ES1GeViYtpIW1IEYGUVK6sBRZyfvc2It18oiMI8UGPh5H+mapuGink6KTVTPFSMUn3hCeyZ2oxNqunhfxy3WVdvnAJ04imTwkzkrJ2qrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392595; c=relaxed/simple;
	bh=/NueFm3/CazP49WvRA3Xr6pCyu+b38Sp1Lwfij/nZmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZhENVNAv0bHiIQKJ/Hp6/3XRJ8OhA1LyrfFAf9JwY9Dw/CE6gOqhggiBH7hhSC3M3lG/BRv8cTy1d8puc5YG2nZ96/5WVhPkSBfy07sm7HvnJYji2E75LMunNZAAWOq9+BOgtZxcfHNXnx61iXeGZJnhqSrGjZyzPBJ644aLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVq7gNw1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1795078f8f.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392593; x=1774997393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZibpwI/cvMwdZUDTWkM0UWWOXbQKhbXzaML3B8rLT4=;
        b=FVq7gNw18T0LDH5X6jIAD/KTpzGF/UscBiFXLPRU7EjnVlRmDpl/emBdB+Qhei7vT2
         m0xXXj3rn9nFccWMMFxQKWjVhwCvk3RKPVxeMHb2i+qqs5vhDDn8KIKitGHmQ5K2OJLf
         JKLI0t2+Jcz5dZk0bXgXcRClWYc90Uy5z2ivVipcElOwct7pWFo1kRn5ADxIittk1O7N
         I1g6LwisQteSGFIPewPhrFXIJeD/EOUNEmui1ZrZbOZ2wnikoBPvK6tlf19zxjqRbgXx
         vomADLQJJWc5YcTmm0mlBHQes3Vxt5BG44XoNOs03MUF4+ImT3P9QonM+7EapxSr0dqm
         w+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392593; x=1774997393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZibpwI/cvMwdZUDTWkM0UWWOXbQKhbXzaML3B8rLT4=;
        b=A4nFoXQXY5Q/W/MKjbLkS9KhiMHmZLa9TCOvu2rqp0kdX/Yd/iD6E/xfnagNKaBRPx
         9QuYy6WtE1hS4lV0da4r4B8h3LD6KEtkKkLD4Uw8uxx6o6tBrtXjrtg/cPMjV67mcvga
         GytNiRCe/Op0YkdvZi4tUUI/JUHbKk738Kun7d+O26QF7iylhIQ8QlsduNsbT2eJM8tq
         BbNe/aRePl+FmvMDfi5gLiFdy58W4qLZEoqb7Lh6bqpDbkl7/XVeMpO/EfCT9ylQ84GZ
         l7veKdswSBqAO1f5WQjxxOewfh3Xga3Homr5UyBKbkqvZ0W6tGjBEnVBaxSGRqxpqz4U
         U2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXMkywLhW6iu5Cu2erkQnPwvfUOY4lRG53HXlTYMZ/wCsg/AIxS+NEAoKZj+vl5zyGl42jA+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhstBpv7SHslukHyNj9QkZ5CyImPPJnB9Wahbwgi9eIEAGbJMK
	sQ3WE79WaY+jEcAH8zyMa27irDGVqERz5gnNwHjyMH6KDKsrenNylRRj
X-Gm-Gg: ATEYQzyHrP7GHu0b6KF6lKqYRX2ycssN47uJfFKNqMcEv2/phJWVq8tmyNaatNOKQzn
	F6LcfNtZ3h56n4wu176nA8wQwAgXf0c1ZTKxDPB11Ahu7BnuBAcOuO0vdsjnVVOjdBH+g71Ado8
	1jLa+NmFNQtga/2jT6t0ULeJ9Y3Kd5VtPxTBePKavsxg0uR3mj82tt+BwFD0Nn8T3qLOP6jHeTF
	0ohBFHkv2y61OgwimFxNECTcGnUf3bsxBIc5NN6u/Yz+aTkXbW2OdXyU+7yz4grddp3bHzVCqlF
	ofH4cnfK1liumf/OXYWTrf1ZOyKyB3jFrOSdQH6WUW+Y/wXnG1ohFbNLYjzroZsWWqjE0AV6Wmc
	6aZ3hxoHF/h+Vra8JE8b4cpzzUukNJRa+VdHZplYu7J1bW3+lXmUp/o+UwmKHz44/dVHJT8ixSD
	11lU5wpKT3bHyO
X-Received: by 2002:a5d:5f93:0:b0:439:b4dc:1e1e with SMTP id ffacd0b85a97d-43b88a0558cmr1695700f8f.29.1774392592899;
        Tue, 24 Mar 2026 15:49:52 -0700 (PDT)
Received: from yepc2 ([141.226.13.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470393fsm42653742f8f.17.2026.03.24.15.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:49:52 -0700 (PDT)
From: Yochai Eisenrich <echelonh@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Yochai Eisenrich <echelonh@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	security@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
Date: Wed, 25 Mar 2026 00:49:25 +0200
Message-ID: <20260324224925.2437775-1-echelonh@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echelonh@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2D3D31D788
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When processing Router Advertisements with user options the kernel
builds an RTM_NEWNDUSEROPT netlink message. The nduseroptmsg struct
has three padding fields that are never zeroed and can leak kernel data

The fix is simple, just zeroes the padding fields.

Fixes: 31910575a9de ("[IPv6]: Export userland ND options through netlink
    (RDNSS support)")
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>

---
 net/ipv6/ndisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6a5d8c73af9..186e60c79214 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1209,6 +1209,9 @@ static void ndisc_ra_useropt(struct sk_buff *ra, struct nd_opt_hdr *opt)
 	ndmsg->nduseropt_icmp_type = icmp6h->icmp6_type;
 	ndmsg->nduseropt_icmp_code = icmp6h->icmp6_code;
 	ndmsg->nduseropt_opts_len = opt->nd_opt_len << 3;
+	ndmsg->nduseropt_pad1 = 0;
+	ndmsg->nduseropt_pad2 = 0;
+	ndmsg->nduseropt_pad3 = 0;

 	memcpy(ndmsg + 1, opt, opt->nd_opt_len << 3);

--
2.53.0

