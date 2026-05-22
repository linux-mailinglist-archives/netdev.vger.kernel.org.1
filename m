Return-Path: <netdev+bounces-290855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zfPyKetmEGpJXAYAu9opvQ
	(envelope-from <netdev+bounces-290855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4AD5B612D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22EBB3037997
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534754219E3;
	Fri, 22 May 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih6VV6iL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB27402BB7;
	Fri, 22 May 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458723; cv=none; b=fvdv++YowkNr31ppb1u9Dy7BoYTuirOBSjqy43LGd3sF0Mi2rocGwJMcOAFAA7uIwUrgyGQzIulXQkPMSuRN1NQ3a1EmnX+lR/m7FlU4Dykhn4wkLN700cVMQdbRB+v1Q7/HAE6fCmbF5OppKEkoA4eDgCTKVck3uWjKJYCKu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458723; c=relaxed/simple;
	bh=RqcLh2LnvS6fXzVR5beWGIhEjU/YJR1gHxXKe4vDf+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j410poMn9hqF9MvZtYNbbO9qndpUn8Sbmu++CNf9yQvm1ldEB6IKuYpdEtsYZksvtNR3FYKVTjWTBS7g50v1L47rnsDH78EcKT0/5F78eBUqu9AG5ynv4HqDyVYjE8O+heaIfhrY5ne9bENNQ8QxWFBltKigyKIHM14aVXjx23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih6VV6iL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786941F000E9;
	Fri, 22 May 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779458717;
	bh=jZBuRXNonSLJinDq4udon3aMozFZI9+NktV5rS+ed34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ih6VV6iLK1YrGAueUjmW1vxc8p1E2PJYy6A5JjOnkRU4LnN4uKVxO2lAUDYZFoZh1
	 xISyDCD206o9TB2Kogw5E6A2oTvtTtJxVelSsQGgUnxh72X9najNQrT2DUEFIa1waJ
	 Xf03YklXttLaWf+ajCph6B8Rf74ygNtAw6JE6wKQXTIH5NQBssZ87p2LUvF8TpJJCR
	 HVp/ephzmTq14Ic+gOCvx+Y3b2i5YcO1f4t1sBw+KyVhQgYa/+LXWPYrEYnSFDhWIa
	 f0DaVi+nT1Tws9GvGQ+5GMyA+y2TZCQcueumowMpH9Itq+Mq8ekTvS2mAAUgKDWZnr
	 3W3dSJO8AHMEw==
Date: Fri, 22 May 2026 07:05:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] fbnic: Support larger io_uring zcrx
 buffers
Message-ID: <20260522070515.044d7d97@kernel.org>
In-Reply-To: <20260522113225.241337-1-bjorn@kernel.org>
References: <20260522113225.241337-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290855-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,intel.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3A4AD5B612D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 13:32:19 +0200 Bj=C3=B6rn T=C3=B6pel wrote:
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  29 +--
>  .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |   5 +-
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 168 ++++++++++++++----
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
>  .../selftests/drivers/net/hw/iou-zcrx.c       |  28 ++-
>  5 files changed, 176 insertions(+), 60 deletions(-)

Hm. What's merging the frags? the hw will serve them back to us in 4kB
chunks. Frankly the iou zc hurts me less that the fact that we run
out of nr_frags in GRO :(

