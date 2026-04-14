Return-Path: <netdev+bounces-278500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFHEL95a3mmLCAAAu9opvQ
	(envelope-from <netdev+bounces-278500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:18:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F93FBA91
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF270302BE33
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543963D6CBA;
	Tue, 14 Apr 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs+9c+Kl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4814B977;
	Tue, 14 Apr 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179906; cv=none; b=Htrfb6fz8Gs7xqi4tbtm33BEQXuu+bRBOn1cd6CZDStG/Id3ZMPJqrvk5FyKFQmNohy+9YfTojlKgMJ8SVfSET52JfYBFvq3Va3ogDWVioxG/7nMMS2LBGcNebpre1puG0h9NWn0XiEusISBJDPA2+fpyE+1TUvzjxxatgpZ0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179906; c=relaxed/simple;
	bh=CTs88kR+lYg3YXafFIcO3Qff52Oz6AF22ixIJ7VDM3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBnR9ADkBojTqU0tTgYW64rwFyNP42P128KcdhryG6fw8O8iXf9tJmijM/c/IBYViqEG79g5u1RRlUBOxMWD+E61vyUNsGM1qD7hcsqwh3o/e9i2tBfGNifQhYThPfIIZkVzICrAgdMgZl/amp4xQw60R26eIKwEDxceNHjjzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rs+9c+Kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D8FC19425;
	Tue, 14 Apr 2026 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776179905;
	bh=CTs88kR+lYg3YXafFIcO3Qff52Oz6AF22ixIJ7VDM3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rs+9c+Kl7G1HTOCcI2BKv/3KbyBk5RFrut3aAcLVPxflKbCGwdAiMwSkUAW2Rubtl
	 REDENYaPsjgQOVCnFX8BkqScY1fL6uoAoX7YsLkpd6O6TwuUNQDnd8ntMeKENc0XGf
	 9OBGw+57y25XBcwsUKXt7E0NGwI1CBWtlfLe/8QOSpcqqdTeYWGvt+b3Jm2K3k/4Ib
	 Dv9ZFBwbhS9IUvw26garG+Y5j9fJleBRuVmqARNqla83yNPQjSW+CioTETAuPMY/V1
	 HeF1EVhmm5jw5MxQb2vw3aL/C9PY7UmRe9518skDgzZp8bjxVqXss7/gv+MUduLQRi
	 dslGvXVWyhxRQ==
Date: Tue, 14 Apr 2026 08:18:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>, kuniyu@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com,
 syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] wireguard: device: use exit_rtnl callback instead of
 manual rtnl_lock in pre_exit
Message-ID: <20260414081824.0edf6113@kernel.org>
In-Reply-To: <CAHmME9oXoXykXq_emkA3v8nG2VR28CmRP2+WmhrvGJc0ZbPfpA@mail.gmail.com>
References: <20260413151232.1004611-1-shardul.b@mpiricsoftware.com>
	<CAHmME9oXoXykXq_emkA3v8nG2VR28CmRP2+WmhrvGJc0ZbPfpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278500-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,google.com,lunn.ch,davemloft.net,redhat.com,lists.zx2c4.com,vger.kernel.org,mpiric.us,gmail.com,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f2fbf7478a35a94c8b7c];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 449F93FBA91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 15:28:37 +0200 Jason A. Donenfeld wrote:
> Thanks. Applied to the wireguard tree, and also added the missing
> __net_exit and __read_mostly annotations in the process.

Hi Jason, while we have you - do you have a PR for us for wireguard?
We're going to be sending the net-next PR later today..

