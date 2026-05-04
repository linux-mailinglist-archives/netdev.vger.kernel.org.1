Return-Path: <netdev+bounces-284075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHWPFCYk+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:56:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D857F4C49DF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EDCD301DE10
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1538BF67;
	Mon,  4 May 2026 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZV+R6HH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8AE38B14D
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935255; cv=none; b=RpTITU7v+MhTq5MppEicdK7gxO8Kr/gpmDS4nAxu1lrFLVHI7xtSOKRiP7aPIeb7PmRtHl0SXT382pXZrKTf8jJN6CEI7gRLbE7Z50I+z0yPEtArSdIzl3PTPXsAcypcZsC8DYKWfu5bOARSD2oLEmCyUyH0kh/Ji43Hqu5SeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935255; c=relaxed/simple;
	bh=GJA5seVahYpViKnGZOh3rNiBjtA0B+KD0LRZTUEpgoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/y7zIldk7UN4SallQwCduuYQKzWitj7UQzpORODcwFFiayhSBMby3cMGwhmkD1DWpcoNj31621zfz3OmkQlFrd/yV9EiknajM7jDRjBjsD4uLpC/A1iAVSuTBpReMKGC9RqwbJqOHCBQpKAdmgcsP3vozLBfkrtMZVFZdQOpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZV+R6HH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36536771300so1094408a91.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777935253; x=1778540053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ugfH2lM7nQgOC3+hZY16zqoQboC9qbhlDerkTWHT2Q=;
        b=DZV+R6HHRl2Ey2t3N3yv3xwGuB30C/kzGN7Tq/IPskIxfiKxxF0RXYE5d19hJeWkh7
         M3eceaUMnvjnz2yu5bKALKMVbo5tTJ0zSQOEwetuBV7Y1jQFJipQ8SV1H7OSIHHoVA59
         HIsPgRuPqqHCtqWkKqzRugFIbu/QbGOHWLl6QKrCi4zCBp1GurcsCSxu8O6fyKaMfNam
         +OFzRzwSGViW00TaV2NafVAphvxP34SKk4SB7j3MiJdW1avgzQRsNLxknPA6tMS/l/oL
         ssl6edK1TGxxm4uJR09O8l1RmfZyC5o+fr+xYWhEuJQzE4rtGSTmuxt6faHImSwEY+Ry
         raWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935253; x=1778540053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ugfH2lM7nQgOC3+hZY16zqoQboC9qbhlDerkTWHT2Q=;
        b=rqvuQWTt7Jg6w9mU40bhDItEsohdAEAWg4OyjCeNga92PcHMssIgAxnNa92OZRr8Bl
         OWim7Uy2MfQdV7Wcm2e7z0tUgRKiuKG+nUL9WAKWnQ7EDJP8mWkbN56CRd1SIPNuL5z4
         tCloJkUpMqJJnxIoKr0Hw6NnLYV/16QimP96LZt1u15kSg1Dsfw5G0wINrIZaGHo9vWS
         UUDl/GYBit2rNZgCx5NeU0szhAIkOIDA5vvsQui63fdCgErE56TQNrlPAWRKvyxw1PQs
         Nd9QP95tWUhVKr+wGsaFiCK5ANeGlG9Qx5ygJ1WxcMWes5mQtP2EQarvJmkVqivWPr0s
         jbRg==
X-Forwarded-Encrypted: i=1; AFNElJ8H8ygZQBwpw0X3CzpSFw1m1yrVpZhOWS1SPSoII6mj1JwAWdJ/yHSeX6sz06fuGVZTCeRumxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzPmgKZwo7Yx2DxLiT7vQ6bXAKj0jqdfjksJZWnaFl3ty4S2X
	lJfIfAg5tkUZkTfroU3Y7N36sxGWFSWn/UsCvRCKVO5d0oC6VVG+x5g8HkST/UJBJg==
X-Gm-Gg: AeBDievEOreqvNmzz/sMmunQSpmXFSjbrUycSEqSN+QIu2ZfwYzsfaASTk/TtDhsiK4
	HkVZDkhbwJ/LQERbcYseOv2L7RUfAVD9mYXPupq7ktBXhXJaRoaxjkcfVCX3REEvYJ3cTbMeydm
	jmCvRSZY0xoj7613E/mHF6zeLa18cFi7xgvCQBGL7TlMQg5HhJX6/9SvFtP8LP7QpTDapEHsd5Z
	7bk7UvLjLOKHfOQg7RjKhLT2RjTe5cfVHzAZtAe2fak5Pb5v9SPTIAOujqXY6XtIWkO1c38JF7p
	WXIaEUY6BSVwIfMBmZqnwoIDK58jwT8gUtkmtTEJObhzU8xeXN+WO6JjhwjsD3oaHf5qtIrFqh2
	J5aFwXo6QCbirC3lPE2jJOoW8qPe+kxoMdyKs/SY6gLFDk103tPL0DqZQu2a5GjBwhYQqx6qrnd
	6li7BGR45nZg4DbW1KNSyYW+eymAjVojy6tJg0aZoz+4tE7kGCsgM9+ENnAUeBh7DcAgUmOTXIo
	HdfuQ==
X-Received: by 2002:a17:90b:2e85:b0:364:a497:db8f with SMTP id 98e67ed59e1d1-365727322f8mr956720a91.9.1777935252914;
        Mon, 04 May 2026 15:54:12 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9f0b21c4bsm88242915ad.29.2026.05.04.15.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:54:12 -0700 (PDT)
Date: Mon, 4 May 2026 22:54:08 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
Message-ID: <afkjkBq8B-4KjhS_@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
 <20260501164314.GA1381708@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260501164314.GA1381708@nvidia.com>
X-Rspamd-Queue-Id: D857F4C49DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284075-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qemu.org:url]

On 2026-05-01 01:43 PM, Jason Gunthorpe wrote:
> On Fri, May 01, 2026 at 09:11:11AM -0700, David Matlack wrote:
> > On Thu, Apr 30, 2026 at 5:08 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > Add an mlx5 driver to VFIO self test. This is largely a remix of the
> > > existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> > > to issue RDMA WRITE operations which effectively perform memory
> > > copies using DMA. Since mlx5 has a stable programming ABI this
> > > should work on devices from CX5 to current HW. The device FW must
> > > support the QP loopback configuration.
> > 
> > > This entire series was coded by Claude Code in about 4 days.
> > 
> > Very exciting. Josh Hilke from Google is also working on using AI to
> > create a selftest driver for Intel IGB NICs so VFIO selftests can run
> > in QEMU [1]. So it's encouraging to see you were able to do it with
> > mlx5.
> > 
> > [1] https://www.qemu.org/docs/master/system/devices/igb.html
> 
> Yes! I would feed DPDK in as well in this case? Combined with the
> kernel driver it should be doable. It is much easier if you understand
> how the NIC works, of course. This worked out significantly because I
> guided it through sufficiently small steps and knew where to find all
> the quality reference material..
> 
> > >  - Make it work on a PF too (this is surprisingly hard!).
> > 
> > Can it work on CX VFs? We're interested in continuously performing
> > memory copies across a Live Update using a VF via selftests to
> > demonstrate SR-IOV preservation (when we eventually get there).
> 
> Yes, I started with VF because it is simpler.

Makes sense. I tested it out and was able to get vfio_pci_driver_test
passing with a CX7 VF.

> The PF support flow requires a bunch more complicated stuff.

Do you think it's worth supporting PFs? If anyone with a CX NIC can
enable SR-IOV and run selftests on a VF then we can keep the driver
somewhat simpler.

