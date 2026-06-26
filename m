Return-Path: <netdev+bounces-302235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rRfoMR2rPmr+JwkAu9opvQ
	(envelope-from <netdev+bounces-302235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BD6CF2C5
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:38:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ImNjInA5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302235-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302235-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B51BA300BCB9
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8803FC5B7;
	Fri, 26 Jun 2026 16:35:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC673FCB39
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 16:35:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491727; cv=none; b=AM8+K3UWudM5PbljSnTfakYk6PwWVSqdJkcEMJWNN/r4C5c/sMSAmt2t0ioW+Vhhg/k6lQUyeXxoa+vl0TaE+9YGjZ2qwrd5jApgpJ9h7GZgxffVr0iWXJkW+9fnpAAsLdFiRzLmqpEDXDYrCo95SX6MAmrLnha0t/tn2rMhJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491727; c=relaxed/simple;
	bh=G0ur+VGsK5u8uehJUY577XPYpSiXqEDgqalyWKWqXew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDPLPK7cXyRpr0alJ8LJTCkfedGY6NiJoz2pkJjsQgTdvNMNs8uPQEIPLGRsJ6jGHeO6F0WQnXmqS/9Qdet2dLI/9fnG6QFAQDh4Boy616LkotYPgZEtC07irG4bfaOgYdd+8r3A2fiC8p/puK4Hr+cZmVZuNr7gLF7fnl6rSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImNjInA5; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so11528715e9.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782491723; x=1783096523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9JIf9OJEzVS6CWv1FSk8ReHN3mioJ8+p1Xh5mgkJRk=;
        b=ImNjInA5iKioWKD+XL+xYCLmU7oLyGLf25sa+a19d17uFXgl9+atFON9qKpenByXne
         VKaI/Oi6oWkeM35rcLzmDSD1QytduBqaKSOd3H2iR0b/K8QAtXZGEn4mzD5n3j6TMLV2
         A0FkOJPlBc/ClIXvxcW+U+gY3xgBwKoY3ehV7P56MajuvzcxC1zRjezzLBZ/WhGozvcj
         Q5L8gcsmCGXHtFTpjwhKXVl9RuLbi3BJ2was23bzqwoo+xcloBBcrt1PJlhqdXs4PTC3
         PgIGiFzb1QphOzS7UAu1siRgMMyMQB1I4gK0I68wpmjHcpKmQIaMHzIyqnPjU84BsS5j
         zR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491723; x=1783096523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9JIf9OJEzVS6CWv1FSk8ReHN3mioJ8+p1Xh5mgkJRk=;
        b=sEOV0mge3/0P3N6JVqGcHjF3khzKQ+2I+DU9tgRj7OhBKutZ6TumfPOQMzKzrXdIJJ
         n8ZMezfRUY7futXBkkr0HEHOiliPU4acAv0oHdYT2OnGK9+zUz5q0qORNG1xUG+6Zlia
         3PYVqmYwKhCnEf5Xu/GQsXgNPHvxqkKJKphttyoFexbsnluh4IL4dGn7MNfglpeBBBKF
         EzFBbMYyeC4csDLgfwjwDH441lGUmH3aUu6tUX8kwUV6SKP2IbCxgOJhha19X2Z6pktq
         K9apLl4ggyvWHfkpmDMdR96NTGoCYgPyewZi+ryq30r2UUDPkvuTIR6lM3KV/MbRp4z6
         CX3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9DVq39h6JnGDWRm58EQxoMQU6LETu3X/MTl4SCJeub8fOf8Mw7lzPu7+17nfHiv2ogc9uQOkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BrNXN/3TA6c+ZfyF9wKp1XuQyMo73vMJrjXLfkevzBMfMLPI
	6bVCWearSIgVN7nSZjTeaoXUS5QyQP7fA8sawluXUW1hBRe8c+JXEodL
X-Gm-Gg: AfdE7ckBCvqo4wpukF09xDAgbN1/b/KQzWI+VI/zhK+Lffur3NnHdsjg0OqpR9kF3Hq
	IAzkXjNsd9RqNsOP6+0gi/UCzBc9lrOLLsQKLPPhSpUcwFZR0waN0f1FK+XtbrDsKN+6CU4m7/i
	yDCG925Gcsv9311YbErAPIEXXE13Q9eomnMIvB5y8tPXVxt/mIpbkYcUkdOzQ8iWxLv0XHhMPiL
	9Ff0rd1hAdyxGMFZmVQw58q60XvDIoAQSHtjMdooxmkwfNLS7g3/30TElPUqhSBYoMUgaKssww3
	HtJV0ODtYgpPBUkSaksDx4Z0JvGu9B9AhEIh/VkuzOqH2IQGZJZ/1HNfWRie+58oeJeq4xPMJOz
	PcZsiQZ5BadO0G0vsj0+XJclnADwZWPP1db2ofceHXsU3mxTgWu7Zc8T+1AZj1zMpM+RaUMf/Na
	mdmw17WGh4GUYOAZfK7suBSmDNvgzqO2/CiZnJ8oRFwZyl6C9sXPxbtvXKzvIZnxujfBee8Si/M
	xpDLf/DCENMJ6a8HA==
X-Received: by 2002:a05:600c:34ca:b0:492:58d6:2565 with SMTP id 5b1f17b1804b1-4926689dfe6mr106861335e9.25.1782491722478;
        Fri, 26 Jun 2026 09:35:22 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071e49sm89894875e9.10.2026.06.26.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:35:21 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: maxime.chevallier@bootlin.com,
	olek2@wp.pl,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	bjorn@mork.no,
	kabel@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
Date: Fri, 26 Jun 2026 18:35:19 +0200
Message-ID: <20260626163519.10678-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260624084814.20972-3-petr.wozniak@gmail.com>
References: <20260624084814.20972-3-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302235-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:olek2@wp.pl,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:kabel@kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,wp.pl,armlinux.org.uk,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,mork.no,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D2BD6CF2C5

Maxime Chevallier wrote:
> I finally got time to test this with a RollBall module, and I
> confirm what Aleksander says, the RollBall module's PHY doesn't
> get detected even with this patch. It does work on v7.0 though,
> so before the bridge probing was introduced.

Thanks a lot for taking the time to test, Maxime - and Aleksander
for the original report.

That settles it: the deferred-probe approach in patch 2/2 doesn't
actually restore genuine RollBall PHY detection, and as you both
confirm it worked before 8fe125892f40 introduced the bridge probing.
Sashiko's static review flagged the same thing (the probe bypasses the
PHY discovery retry loop for slow-initializing modules), so the static
analysis and the two hardware reports all point at the same flaw.

I only have RTL8261BE-based copper modules here, not a genuine RollBall
one, so I can't develop and verify a proper slow-init timing fix
(module_t_wait / a retry that waits for the bridge) without the
hardware to test against.

Given that, my suggestion:

- Please drop patch 2/2 from the series.

- Since 8fe125892f40 regressed genuine RollBall detection and the
  deferred probe doesn't restore it, I think the cleanest fix is to
  revert 8fe125892f40. I'm happy to send that revert if you'd prefer.
  The 5-minute RTL8261BE probe loop it was addressing is handled in our
  downstream tree, so reverting it upstream is fine on our side.

- Patch 1/2 (the mii_bus leak fix) is independent of all this and
  already has Reviewed-by from Maxime and Larysa - it would be good to
  take that one regardless. I can resend it standalone if that's easier.

A proper fix covering slow-firmware modules really needs a genuine
RollBall module to validate, so it's better owned by someone who has
that hardware - happy to help review.

Thanks again,
Petr

