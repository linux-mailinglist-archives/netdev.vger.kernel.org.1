Return-Path: <netdev+bounces-299558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FO6iJ3Q/MGqQQQUAu9opvQ
	(envelope-from <netdev+bounces-299558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:07:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE56890F1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:07:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=FMxk83QG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299558-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0E33035823
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAE82BE035;
	Mon, 15 Jun 2026 18:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A519F11B;
	Mon, 15 Jun 2026 18:07:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546865; cv=none; b=OaZUDM2ULwRnHyT4gZaQ1xo0Hu/1HZl1e/Cv1dJAcKgCzH1Yc7vRPlPADDBxWDjPujNcziQN5UxLuvFH0NGfrfS4aQBncJ7l2VglIR+FEBah7pE0QiiZz3+yhC67VIrAhjkPIK8bbkseabABOn0Dh3sHr9fIfZ9SI1W3HUdJHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546865; c=relaxed/simple;
	bh=OejRFYEqQHsqfbQLqhS/C+/zcfW3LEMjVaQAJ6BNhuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZn0kCOjxzuWTaLtQVIz7TTGOkedVc9sWf9+ykqXcwGOVXzzc0hPNE74zN3d6N7Zr5QFc2p53czKtRBIOBMzQ59yJzyw2aE05HBmOyZri8zivgfIH7GWh3DKtoHRWQ3ULB8D3qBODBLvTVYRXb3QhlqczJgnh+9S3LWaWQibtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=FMxk83QG; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id E46A7E83A26;
	Mon, 15 Jun 2026 19:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781546393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVdAzhnInFA2Y3/7I56HSI2bZc6O/wA+N/9tYWb3XK8=;
	b=FMxk83QGvrjFMjz+pyafd8ZVbxPgghPZuvdKtzUOr42ccBvOTweJrZT5Btg40QoZohvdX6
	M87/5vvRpyC2i02gIm21s5NKhXw669fTCJUbOZ5HfN+gAqeCR+4x5x4vkPhOypdBhMMu4n
	Ecs1t1XuP6+dfb3yetjhdYg/l+tUkZ/6s8RQVhXrVqhoGyrnV2OIdEeJblSJKHKZD+Ag1r
	KA6zrhP1gNMGzKKZJX9kgvctNqbqaGV4t06VRPmuiiMMafe/5bbIcMNjXCcH5qa9Zj05za
	OD099Uwjgbh025KD442tFmwkv6XS5yQfR131xG8bUTH3I8mbvvcEf94AMBd/6A==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id eTcQe8DxYgUL; Mon, 15 Jun 2026 19:59:53 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 15 Jun 2026 19:59:53 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net 1/2] net: pse-pd: disable IRQ before freeing PI data in unregister
Date: Mon, 15 Jun 2026 19:59:49 +0200
Message-ID: <20260615175949.827693-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601162506.GY2256768@horms.kernel.org>
References: <20260601162506.GY2256768@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299558-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,szelinsky.de:dkim,szelinsky.de:mid,szelinsky.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCBE56890F1

Hi Simon,

Thanks, this all makes sense.

> > Did I miss a path where the worker reaches pcdev->pi?
>
> I am concerned that this can occur if pse_send_ntf_worker()
> calls pse_control_put(). In which case __pse_control_release()
> may run, which accesses psec->pcdev->pi[psec->id].admin_state_enabled.

You're right, I was wrong. The worker does reach pcdev->pi through
pse_control_put() -> __pse_control_release(). For v2 I'll move
cancel_work_sync(&pcdev->ntf_work) before pse_release_pis() and fix
the patch 1 commit message, which wrongly claims the worker never
touches pcdev->pi.

> I wonder if you may have missed the AI-generated review of it that I
> forwarded.

I did, thanks for the hint. I went over it again more carefully
now. :-) Both [High] points seem to be valid, I'll reply to them inline 
on the 2/2 review thread so the discussion stays where it was raised.

> For these last three pre-existing items I think it's best to handle
> them separately.

Agreed, I'll send those on their own later.

Thanks,
Carlo

