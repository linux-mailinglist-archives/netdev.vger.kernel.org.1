Return-Path: <netdev+bounces-299836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qiM+FV9FMWoZfwUAu9opvQ
	(envelope-from <netdev+bounces-299836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC9D68F7B3
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pEo8i2LW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299836-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299836-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39408303110E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE8361DCB;
	Tue, 16 Jun 2026 12:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B3361662
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:40:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613604; cv=none; b=d9pqcTevvifHf8XgiAbGdzm20qlmIzACgy5dh9PYB+4nQdoTmtvNwttKy8a2fCwmqpuKBTS4dP99iMTm1rtqr55Fh0VOjDMuL2gtvLhSCkHaEWY7Fun5SeWejjFS5KD3WR/50XzNkc8HQItNuBz5NCfS0mG0Qm8rW0N66HAHHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613604; c=relaxed/simple;
	bh=+qoGij95oCB5Tcj73SYSEIQXpI4gExKhrc1Em04cpas=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NdCUDYe2IoJcjwWI9/E/STuCBX7D7tJLVqeAplDlcObou4PEYu4xW7l+2+9PSU9vRdPsVBs9dJSnlbgthMre9+7bqbZ+RvegC78BY1J7jKOKn2t7MDzAcwDboPTFmjoIOUg2FznYzAVx9t+IR5y15IUqjT8GcjtpgGPEXsmZCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEo8i2LW; arc=none smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bb2df6fbbso1333490eec.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613603; x=1782218403; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qoGij95oCB5Tcj73SYSEIQXpI4gExKhrc1Em04cpas=;
        b=pEo8i2LWRYoozGPu5oIpXOukzWB/Elcq6XtfxfC2tyRr47iSJC2PG5aoWpB3A7wP45
         Flsjf4/D7ahJd/dr8sDScT/0slGgGKOoRNo7Ri35sBqrcPRQWkoqhRtJRTX2KaETNbR/
         B4/pRdjZCrDXMtB3kl8qbpIhvJP4MfPUuQmPoFqvtZbI/Px5Po1TagmF6BunWzeZALf3
         2UnTdQzgJtfknLPVvkQ1yHVRj0LesSqvCgZik/6xo4MxO8EPhVTQAWRLcdJI5eXtMnky
         rPcUwF6cgtCRXTwZKZRJ2wCBOgImHacR5A4vTsUAf065+C2+be3qxoVp6dxqK8TUtrSZ
         hLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613603; x=1782218403;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qoGij95oCB5Tcj73SYSEIQXpI4gExKhrc1Em04cpas=;
        b=GOPvqubAt4BbxQPJEaUwKMQwX5OXEZD09OsdQ5KL0wfedZB5gHPdVYJmXZoFnfSJkQ
         e5IF+/lupBenUo3piLT9gqR2mHfxDw15JHlWZprpZgzY8ta0XPPi2HjQzJySTY6Jp4EV
         LTP+daFN/LfFC0rSCITNYGPi1frcOu9R3hMZyk6hyENkR7jwdOkHjzj2q16+idkaNgC5
         vXhKMMMUjYtcuf1ZEzosIaz7q7u3MUGyMqtTb3uTnEp46/CdZpUtvKQZ0icesmLj6OSz
         eFdKJIE1gINBGRj6KtqFGjXhl+Yhd9JAZGAsWtVEZNac5ZegZ11btxckQx1zm9LVIYVe
         e8kg==
X-Forwarded-Encrypted: i=1; AFNElJ8l4infTuKdgT0UzDs6ijcqrmBC6zAoSQ30vkPeVoc/J2YkG2mYGkJ5GC/fE9ViqDjHWbvfftQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RGfDZxrBhzo19ejF/gk70QNYYzxCLd0IYvCiREHarHQhvzZF
	eJHUURDX5YHQUz0olERJr8gxkblenk4dilr8HNcsA5JcGx9UIRke1kDv
X-Gm-Gg: Acq92OHt8D3/9zIFZupx3t4yRACLUqOVkD4UHU/2gn0LcCuz5hjSwaDJ5CzdWZk2qja
	/dF8xagfx1ofh+2ZYlK+hs4R3HWuw7We7ZiiPLtR1BhCzP8NCS+LFx7L0FOP3s7RA3vz0oRZgvy
	KPxRzCDgi339KppndG/LWiiu+ZuFt67ugUIw3kNROspN11inI1haSBPmejj8gGoUVYKB5kbMes2
	vweB2eGRMVBechClt83HkVrXrnNbFwPFqJnDllvb6GkWVgaJH7HYPfEENMZZMDk6wG/099Eeu1N
	P57WlShmal4/baH+pW8VIJq8w/e3y6/RLoCoJvWf59pf70BDbahyaa8Z7TG9cYqbWb8zCBIkQAs
	cXnM9OijIy1YOXvBZBFJtuZpGLOllCqMnyzR1Zp9sM4xwXNWeK7iKMJjwlMmDrQQ7/J7pN5+tuW
	/9/CnNZgDDOdkfSmZcykGy43TQIu3EIeQ3dwEwnHiwa4KUd+wInrc=
X-Received: by 2002:a05:7300:d10:b0:2ed:e12:3773 with SMTP id 5a478bee46e88-30ba5fb4473mr2390102eec.35.1781613602609;
        Tue, 16 Jun 2026 05:40:02 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm18872680eec.5.2026.06.16.05.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 05:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 20:39:57 +0800
Message-Id: <DJAHB7Q63R2X.1IQUT9806HSE8@gmail.com>
Cc: "Chas Williams" <3chas3@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <linux-atm-general@lists.sourceforge.net>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH v2] atm: fix use-after-free in sigd_put_skb()
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Weiming Shi" <bestswngs@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260609162107.2865310-2-bestswngs@gmail.com>
 <20260612161051.2d4df09b@kernel.org>
In-Reply-To: <20260612161051.2d4df09b@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299836-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:3chas3@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:kuba@kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lists.sourceforge.net,vger.kernel.org,asu.edu];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FC9D68F7B3

On Sat Jun 13, 2026 at 7:10 AM CST, Jakub Kicinski wrote:
> On Wed, 10 Jun 2026 00:21:08 +0800 Weiming Shi wrote:
>> sigd_put_skb() delivers a signalling message to the daemon socket named
>> by the global @sigd pointer, ending in a call to sk_data_ready(). It
>> reads @sigd with no synchronisation, so it can race with a close of the
>> daemon socket: sigd_close() clears @sigd and the socket is then torn
>> down and freed.
>
> Hm, we intend to only retain the portions of the ATM stack which are
> still used in PPPoATM and ADSL. I don't believe the signaling stuff=20
> is used there. I will post a patch to delete this code.

Thanks, that makes sense to me.=20


