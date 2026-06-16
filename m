Return-Path: <netdev+bounces-299841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D75xAbdFMWpXfwUAu9opvQ
	(envelope-from <netdev+bounces-299841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:46:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936CA68F894
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:46:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dTZIT3Yg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299841-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299841-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A09F230065FE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60D3382DC;
	Tue, 16 Jun 2026 12:46:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5D239E6C
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:46:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613994; cv=none; b=UCffT1WHBjvr7T8Z/pbvXt5XOMhKtLwNLGIgOR4cxfkB/0SchrkHyXGw50xQP0vsg723Vtkfjk6cTljz+7YES34BmYvzRXvrACeO2fM+CXp2PxBIjILNnBvoWW1/mnRf9ee8Lc27hLjbfVKkR4LU1KIBqflq+q20HQAAqHumzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613994; c=relaxed/simple;
	bh=KyRc72+NguvBY9yPIfIA0NmYMPUItZRpVrU4CEpFR50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwlmfdC90WvQSTEBAq0O3QsezZzI+M7TVtZOkqLiefdD0IJbyAFQoxkiRqHNNmZEXq4Bql5KfdxjHjTczn/8DqH5/EGRIwYbPnWeD2p5y9fgTh2utv7wD/RUEK7OeqJ/fOSr4dymjLxF94bUxb3ksb/4bFWJRNNAFndgXAxMq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTZIT3Yg; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46013161068so2268571f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613991; x=1782218791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2wC+3zzoiNCbeuds87FJRBM3s7JRdJtWIi8U2VjAZE=;
        b=dTZIT3YgwJcZ+A8KSMNgAOnVlEIwOKtmL0QOUguV2HVIcoBw7pzRwu7CWjj0iO1Fh+
         Ibi9/T4KiBU1hMyKpNwydv+0GSWUYwbrgXE3SzyOgQqdAt4cP+RsQKGiC9LJ1x3XNzqi
         pca3eiHub0xiH2A979eur+viwN24f59oYtj2NWAPT566JF4JBHmFbPjvjrHeavkOXFV/
         FaCcITVPSVJ8uuwsg0OdKtVX7nHuvW3In0rZHoe3zkCrFIJpJwbhdDxN9hlvc+JgC9DH
         2GfQXyBfWQrvemgDlqKZSldsZhmylcaDNKhxPKL/dfnfLDfoDAKsosm40vUQZBxGwS65
         l40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613991; x=1782218791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2wC+3zzoiNCbeuds87FJRBM3s7JRdJtWIi8U2VjAZE=;
        b=EbbLWe6p5zIwVhxm5c+EL9o+YGCVjhkQeHLtCMrZ0b8/GtbTObhWq3NArMsVBx5bXZ
         4/U1C3VJ/23kcdTpGobGg3xrO2zQGvDMIEdYTd+Hk7/uvL8ZbQxnflHXMYfRUf++jG7Y
         go1Fvz2oaK6lAwL7mECR9RozPegxlO1ZeZ3Mh7B5CdzEq1+HY+g/YCp2xU4SlX5/eyxF
         /LIgTfXa4XT5JpwYbOhumSQC+L083kFu107GqrclAC4RnUfuBSzSPaQGqf+sHFMotNvp
         8NQ7pLfV6mmE+zTAeAGpfscEIC76ve2ck8NysBMDtBEfggqTN1Y0LP8PKvN/SUbxzrJJ
         avzA==
X-Forwarded-Encrypted: i=1; AFNElJ9bwUwxEbfavV7EEQd7RKf4oXmxV/vt3W32Rt9JD6KcPhVVP4N2upqBhdwJ5LNqq0GTnG85+QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgAsnOEljqd5tqJpxUO9gL2Qghmi8wPITBo16iGQHoWUonN8/
	kQ7kRXKF5wG4zWviSY1SuA0XXO4cEJugjc4x/vCtBSIs0xlZFiTs7IYH
X-Gm-Gg: Acq92OGd7TZvifu0AA24ewcvy1sXNdKnNs1ZduV9dWtD45XF/cF86fu1nYssSns7hML
	Zd8KN1CAgtdpirKUxeUyQWxeH5Q1BkTEhIim0W6WGGe3u8JXRTYwbMr+XVVopB47ZEWcHH3Bkpe
	kf0cx6crUppZY9C/oWYI7sV0il7DiC39IMytbVZdVHsb6kj4+xhkRnH9CTSbK1VafeImN1BEiPq
	3c/zHRnkFIOjYKXTnuRkN35zepoK1rGCoE2GD6f1IX3eKo+OPRHwdLZ2vhYUixRR5hioIUOCbsa
	ZCtGO0txU5yVQQiFZzLupc9lt/k8cpO6a0iI/ceL42PWVgZPpk8qGrkHEC98kP5+wTNtBToe6fF
	g039AQGFnOa5q0ZOuuxRLIn/xLCDg10E56Y0vii9wv0oh3bW9BB5+m4QDd3mFGutd0GdZVgBTw8
	VmRq319ofKeyH+yXvS0l5/NHJwLkidZuDRaCWd5Tr860JJnXnBXEPko3lcPdXa
X-Received: by 2002:a05:6000:41f6:b0:45e:73eb:5119 with SMTP id ffacd0b85a97d-4619f3abcbcmr5896293f8f.22.1781613991000;
        Tue, 16 Jun 2026 05:46:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm44484375f8f.21.2026.06.16.05.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:46:30 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:46:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 3chas3@gmail.com, mitch@sfgoth.com,
 linux-atm-general@lists.sourceforge.net, dwmw2@infradead.org
Subject: Re: [PATCH net-next 1/9] atm: remove AAL3/4 transport support
Message-ID: <20260616134629.41017dc4@pumpkin>
In-Reply-To: <20260613201032.77274-2-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
	<20260613201032.77274-2-kuba@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 936CA68F894

On Sat, 13 Jun 2026 13:10:24 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> AAL3/4 is an obsolete connection-oriented ATM adaptation layer that has
> seen no real use since the SMDS-era hardware it was designed for (90s?).
...

=46rom what I remember they weren't really used even then.
Apart from 'uncompressed 64k telephony audio' pretty much everything actual=
ly
used AAL5 so that data could be compressed.

I do remember PCI ATM cards that could be used for TCP/ATM to the desktop.
The equipment you needed in the network rack to make it work was stunning.
Completely killed by 100M ethernet over twisted pair.

	David

