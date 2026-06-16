Return-Path: <netdev+bounces-299888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eFgNNRFtMWobjAUAu9opvQ
	(envelope-from <netdev+bounces-299888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:34:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABA6912A1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:34:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RtROIlVW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299888-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299888-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F30A03030001
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FDC37DEBF;
	Tue, 16 Jun 2026 15:28:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1C30C360;
	Tue, 16 Jun 2026 15:28:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623698; cv=none; b=rKwGyCHmqyIVEnMAeSb/22/0cUx93T0MrR5Ycv3WOOIwAe8U+VxNn+LEsGY+H1IRwTSdd1z66AhgW205YWDQUqmwKJYPb5AqjmtfhyoEG7l6J+/FGAAh1Ph78ijh4i2Qmhs7uQ+UR6YLlQoBZW2j1uRZwMY+jiZbJDK1hvwtMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623698; c=relaxed/simple;
	bh=dG3aCjWHzXlK/CrBaTp9hhKIOKwceiZ58uznZuOOItE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4rBSBxl6nDScU4F9Fo6n3GZ7cabd/pNlfmu6mACkUUgfIFgQeSp7U4a7UOjoC8+wGX1fFOXOxurLlfoVY5cicHzepzFFAQ6vp7YPvA3VXb1kQ2Yrf8b996kne4nsmyXhEpxLJyv4NyZz2o1kaNNQmIXOKgcWOrtcq/xDuWkkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtROIlVW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C321F000E9;
	Tue, 16 Jun 2026 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623697;
	bh=2YmFjgIegVntrewsDF0Sira48rsDIiamJN0j6A/1Dv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RtROIlVWp62Pm1yEM72MqVFDp4zN+V66skf322uzQRJUTzdcU2/v5F6pC5CrtLGMz
	 GGpz+G0yGi8DmBz+dDw/H5xOX0Zyh6M79p/3LxiHW4jpuuIsZmOv8C+tNKqKy8hISa
	 zvO81AFlAjwAWiAyTgvgarnu7DV0oUKuGvTFCkS3NCKkCGYnQmfJVIdGxGRxENzJSr
	 h/Hyl9b0M0gUA56BvWVsEs+wI51qSiNI91BLNCDUL6ePDtQiRMQLJsvzS4G0Zf0zEA
	 NEfdIMaOJUlXooAzsqWS2R7gyJONgFRxUKM8rRg9dFTASbh2iZ+Ah0R+eFumhQye2F
	 N7gGMV/0UhhzQ==
Date: Tue, 16 Jun 2026 08:28:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in tls_err_abort
Message-ID: <20260616082816.4dd0f035@kernel.org>
In-Reply-To: <ajFpejsl1ukTbG96@krikkit>
References: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
	<ajFpejsl1ukTbG96@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,cca46a9d1276f38af2ae];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DABA6912A1

On Tue, 16 Jun 2026 17:19:22 +0200 Sabrina Dubroca wrote:
> I suspect err==0, and sock_error() consumed sk_err in between (the
> alternative would be err > 0).
> 
> Something like this?

Makes sense, but what's eating sk_err? Don't we depend on it being set
to avoid further state transitions once we hit a crypto error?
I thought that's why we don't consume sk_err in recvmsg and sendmsg in
the first place (we are not calling sock_error() anywhere)

