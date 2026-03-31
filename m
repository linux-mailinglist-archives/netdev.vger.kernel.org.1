Return-Path: <netdev+bounces-273738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBmjJv0qzGkmQgYAu9opvQ
	(envelope-from <netdev+bounces-273738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:13:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A093537111E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49F9F300D949
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C782444105E;
	Tue, 31 Mar 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UV5gQCT1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C738F93D
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987778; cv=none; b=kM0WJcFdttkFJ/8NOMwQjkOMsTWeiRaeUB5O6IpbM1FWOHx97Ed5lKWe6ScR6YtPLctgUZLfq1fuzAyWCb5Y7g9fjWTv7ps1Wg0ZJfuFycntPKWuW0Vejfw9Ij89BXaNYuefQlw3KLS0Q8YNjZFtfgW3wKlRHkiLAb0BToHKul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987778; c=relaxed/simple;
	bh=FhNqwVSQY4PYFF8G5roI2acw0d3B6JJ9JEkTmXmuARI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KDvNQP7m6zCWVItVFYqP9yssAnO1nW88eTrKqgO7CajVIwnxvHXiH4zZpb+R1pwzPW4/3LyZintLuyz+Haq0GV9lO6a8t2IJAImPQ36oU+WdyTy6lcBUc8a7vMjVNTHXZVeS2i0wVZ4NPuV7Jd9aGa9ZVYgVsMqOPpXHzp7/flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UV5gQCT1; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-467fd082ffeso3815294b6e.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774987776; x=1775592576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhNqwVSQY4PYFF8G5roI2acw0d3B6JJ9JEkTmXmuARI=;
        b=UV5gQCT1YW1HA5Bjalt1a/719pg8W6SqtN2q2Othixi8qcANeJwHdCnMbG5LDmgeAZ
         ObNQe20xRvxXN9UNsFZHdhEyAwHwwxD/pDDiTRD+p4RJEAFq0tENz0mmcVxYXbL9F1/y
         kkiIMnDPxhCv14C9ueu1yo50EXu0DE4yX2CZ6Il9A+YoG63mEOKDJQc9I0qPZsk/bUcS
         WygH/6ht4pxt1vAUg+0ahUlx4vREGUqnP8HQil0smkqOudHEDtKX6dtaOwypYkLPD0cE
         fAgp/ycSo9M25qF5jaSltFawgsxaN1QSGoedubjrsqhD0DBNi+bBg/47Ax1Rl9nAU2l+
         n5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987776; x=1775592576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhNqwVSQY4PYFF8G5roI2acw0d3B6JJ9JEkTmXmuARI=;
        b=CJirC+O4ACyL8s48R6FKpf25DBM9MFAftICzzEmji2CA5Ess+wzZfhXKlr9uLctDZc
         MpcdOMrUB/y7tQ1a20wWpqY9M7NjYA7YQVlshsGAD5Vb2KeqwH0zh409MeGBoP+r/pDY
         J/4yFW7MKtnbF2ihOrifGsAS9X1ChV5BBOddmFYP96mLeBBpEA9g7K67LhBb7lJks5hU
         KYrCurd5N+hLjy5pfQa45JjcghahEgrjcWOVfVqxzzumfFk+AaG3AflxFz/fsfAbPOYR
         mVzNEnYDMgZnRFMJVTpHkka225fQR6Rj2+Nh32D1NaDn6yj3GFt28+wqyknsHUQxlWLI
         GF7Q==
X-Gm-Message-State: AOJu0Yy9H+wtfkKo7Qmtfc2rB9IcYYUFJs55epoSG4S5BDR6Bpo3uU4x
	T3eqP9XkV7SmPnrxLDKlVK6tcYxaGkkjvqVt7mOM/wfvBA5WRbE4lRpoqGDnhE+/WPo=
X-Gm-Gg: ATEYQzwP/rsSE40XOAk/oPIBQavTFwEQ6F3+1Y17YZeUNnt2ZaMKEzdneDqGqxJDjxS
	Ca3jj960Bv7I9a6gMFE5Sf5XnlGup5sMh9tlqrLUWJV+1gdoluTQbsLOKyYdteFSq8s1o3ZkSSB
	d6+/OVnSB8jJ9kQSRrQ0+ImhBOp/39gn2qqoOR4Dja+5sH++Db2BXTRTyU9H9O/EC8KxSAwv/I0
	oT4jiuI/04R0EaXIPbCuXoc+wpkIrpyJyuXIFgX/wnyrb8f+t79O1JVg7rJ1lAVkjUdSYyZbYYn
	Lmpd/Ys5yQPdrH9k2/O8ft2vCjiUGl3n7u6gH+5w9F+3O0cxNxDvNHSjxSEb6Wj2KBCNnQ44X/0
	Zx9JE4c5EX6xFj4fNQ0kUh3WjoSQCdRbzXKMKThyulCpjQy0YF/9OuKiKr+S1PRH45fus9F7BI2
	1k2V04E7Y=
X-Received: by 2002:a05:6808:1909:b0:467:2609:126f with SMTP id 5614622812f47-46ae008269dmr498540b6e.24.1774987776146;
        Tue, 31 Mar 2026 13:09:36 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:2632::3ce:1f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa03a9179sm6593649b6e.14.2026.03.31.13.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:09:34 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:09:33 -0500
From: Chris Arges <carges@cloudflare.com>
To: Weiming Shi <bestswngs@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
	jgriege@cloudflare.com
Subject: [REGRESSION] net: add xmit recursion limit to tunnel xmit functions
Message-ID: <acwp_cVAflwTQCBh@20HS2G4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273738-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A093537111E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Commit 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
introduces a regression in our systems using legitimate multi-level tunnel
encapsulation stacks. Our testing was with stable 6.12.y and 6.18.y where this
patch was backported.

One of the usecases we have are packets being sent to a GRE device, then
MPLS/LWT route, then IPIP device, then SIT/FOU device. What we observed is that
packets are getting dropped at the last device and we get the message "Dead
loop on virtual device" sent from the iptunnel_xmit function.

I'm looking for some approaches to retain the mitigation while still having a
recursion limit. One idea is to just increase the limit. Happy to provide
additional testing and debugging.

Thanks,
--chris

