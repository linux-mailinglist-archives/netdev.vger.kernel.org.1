Return-Path: <netdev+bounces-302447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HDSLJ+3gQWqovQkAu9opvQ
	(envelope-from <netdev+bounces-302447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 05:05:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 019936D59B5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 05:05:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rcpassos.me header.s=purelymail2 header.b=EIibuIXD;
	dkim=pass header.d=purelymail.com header.s=purelymail2 header.b=kHO+K8Bn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302447-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302447-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rcpassos.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DBBB3015CA4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 03:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2937BE6F;
	Mon, 29 Jun 2026 03:05:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060537BE7D
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 03:05:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782702307; cv=none; b=YuvrE/X1M+hb2fvPtA2dIzKs8jQ+xXEghnjCEdKN7Ix8SitGM8X+dZeTf5VdkymcC/+wMTflucz3ed+2srdG9HnbAp5HEIVKSXBU/B1c5mrU6Y++dZcC36jaGAZ1l8fBQhcbVOPh/oWY+eTsyJmMLmsRZWFw34NvBu7FkDtDlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782702307; c=relaxed/simple;
	bh=oxCWPESbNzwIFVB4kYj7psqNxYCoUW/bo0AUA11NdOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Apujb8qUBKzZm9t8yaE7phPmcRdp+A6Eyn8rNa4ydjgpFueO2LzH8x+Udylr3Dn22uZ8pdu9oVk7J+6+Hpz20Xu4Y3MT9bcQTpTVKhS9AaAKXB/NDNFMiPgRR9e6upwEJlPgsW2h9Cnp4FGPQ3ZJWsUEz4vK4e7BXLTfgLJK/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=EIibuIXD; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kHO+K8Bn; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=EIibuIXDCikSdjCUDVOb0Wa4HMb7+unZo9guX4Iva30iJvDU3dsbewUVeLflc3u6h2TP5+JE5azYx3YBlF+kBDgOKNk2MizdwenfpOYcGi/x5+obCD6/l4t71Uq+Jn6ypG4rlLv8sdgITjy+OcU48UUvsEzJsxSjDXOiDPM033MHXNrJtuYnl3yn51SIdexmTLTPBnJX8h4Z7Sm6A5O7zJpR5UZENLkEm7PazHwuHuKT7gWCgKco+v7g+Jj7d/v8vLPQMVMGhErNB7DXCvF5/knLWnVNjgCDSbw86HOay9lj3dWYCIrcGzgx6J/3F3TK2EFmZZMX/LtPVVhN78TpEg==; s=purelymail2; d=rcpassos.me; v=1; bh=oxCWPESbNzwIFVB4kYj7psqNxYCoUW/bo0AUA11NdOY=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=kHO+K8BnHLCk2mKmPQ20cBTbpWwELDm1rqwmrYi9+Gax5L8iwcbJyXGyiKZn2SoTGHvoWvPLrFg8nS06MTg1VokIztAb/jn5DXiv9HlhM3Mf/k8sVJ35lRAD0oRypXC0lUpIve+NKF22hahnBFNhmHvH2IcIBwUAYeW4W3l/ej1PeyOJanJ+mgeCJT05ac/qJ2ftVuPpkSQQ4xbws9BbU2AelNZB7D2uSs+h50vKjTXH71YG8tCSiCE69mxv/6UkOd4kRK4+Y5BlVOn7iCpfLQaGx32NMf/orb1WlDUAtZxXLqMCmfuwf8KrSQFIdhz86JazXJ2MUMBGX9tZuScvFw==; s=purelymail2; d=purelymail.com; v=1; bh=oxCWPESbNzwIFVB4kYj7psqNxYCoUW/bo0AUA11NdOY=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2003467226;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 29 Jun 2026 03:04:49 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 00:05:08 -0300
Message-Id: <DJL786MPR9HO.BWHI3U37PDVM@rcpassos.me>
Cc: "Rafael Passos" <rafael@rcpassos.me>, <Jason@zx2c4.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com>,
 <syzkaller-bugs@googlegroups.com>, <wireguard@lists.zx2c4.com>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Theodore Tso" <tytso@mit.edu>, "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH] Wireguard: Fix data-race in rx/tx counter
X-Mailer: aerc 0.21.0
References: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
 <20260628203823.144789-1-rafael@rcpassos.me>
 <aa423184-7465-4bc9-aff4-d3d671beb3c6@lunn.ch> <akHY4UEa1ab2PF-j@mit.edu>
In-Reply-To: <akHY4UEa1ab2PF-j@mit.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rcpassos.me,reject];
	R_DKIM_ALLOW(-0.20)[rcpassos.me:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302447-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rafael@rcpassos.me,m:Jason@zx2c4.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wireguard@lists.zx2c4.com,m:tytso@mit.edu,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rcpassos.me:+,purelymail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9ca7674fa7521a3f1bc2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,rcpassos.me:dkim,rcpassos.me:mid,rcpassos.me:from_mime,purelymail.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 019936D59B5

On Sun Jun 28, 2026 at 11:34 PM -03, Theodore Tso wrote:
> One of the reasons why kcsan and syzbot can be quite noisy is that a
> human being needs to *think* and consider whether or not this is
> actually important.  (One of the reasons why I'm not all that worried
> about our new AI overlords taking over the world.  :-) Consider what
> is the worst that might happen if the tx/rx_bytes counter might not be
> completely accurate?  Is it worth the performance penalty of using
> atomics (or the memory overhead of per-CPU counters)?
Yeah, I guess not.
Still, it was very interesting learning all this. I only knew per-cpu
counters by name, and Andrew's response led me to actually understand it.

I would like to thank you both!
And if I may, I would like to send my v2 patch (as a response in this
thread) just because it was very fun making and testing it. And I would
love feedback on it, if anything looks wrong. This was an amazing
learning opportunity for me.

Thanks,
Rafael Passos

