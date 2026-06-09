Return-Path: <netdev+bounces-297141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W+JoD1A7KGpFAgMAu9opvQ
	(envelope-from <netdev+bounces-297141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:12:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39B6622EF
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:11:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Y1n5zQ11;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297141-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297141-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ACF0311BF91
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F8F481653;
	Tue,  9 Jun 2026 15:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAD480DE6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:41:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019666; cv=pass; b=HMGXCavCx+GHuvcxH1J9fu+iNKUo/Z36zcoBeJwj1Ly5UIhVzoLQlreLFMM2Tc+r8MFUMgFsimIO5ztPfPbB38mlUfmytoFECwEBV2a5ogYCy9oWB5F50ODVdJYJxNeckLDtiXW/tU8sMsZTEEgGyC01jvMiUcK/nsX1Nj7IjCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019666; c=relaxed/simple;
	bh=3GAnTELKE5MATjs2C0Nk821QUo58J8OicUl8Ig/dNAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHm4y03yU3iAYMPjCiGv6xE1Qs9/RZgtc3lPLvwl+fTqKobw6ZzqQXXVrURsddBFm93FtDCIyRt52XNAaZukNxOA9LSRBrYgfxrrPRMN+KBbQZr7Y/pLb/1beSQPEbgqHuNRFbka3CWXIe3VXmSgSAbQUqHoOzItT0QRdowKX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1n5zQ11; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5176d4c14f5so46393461cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019664; cv=none;
        d=google.com; s=arc-20240605;
        b=dslLJ03IG+ByD5z8qnuD1QrQdblngFFc2zfr+/Qy8P6WjwG1rA9QORDxN/G73Yyhod
         lJGJcDwfIBdILo38gO+fhcAq5hMWxhECnbP8p00o+CeFg7c6qq/l/niYjSbqkZAa2X3+
         QYSFVhSOLA7JL6gtcyG+vVyMOfCPMIiOWH17Q56RTXE8wY6n2uFtYhWFZVSZChCdYXnM
         miGmkKzkdNz3ZSctNAk5U/WuXiRlqEV81YSqtWIr6jyHEBgoqYdlSRZ9tuIWZ4C8rZNo
         eS69mL91EOB+UOou5ynNX2b0uFKshQkUzLjv1XdpNQ2IGdD9l9Vaj3rorN0tnKA+Zbc7
         b9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GAnTELKE5MATjs2C0Nk821QUo58J8OicUl8Ig/dNAM=;
        fh=59hfGL5Yr1WA6HHL3RMrgUiEg7HPnbCbDQNJ7lUefw0=;
        b=Qs4Dlg2vP5BdcYkpVTt/WGYgMjS8wVK6taRk8vHb91NAkx3rNPqAQsI2p3rxaqmzff
         U5PsSa1m2iyNP2rMc2saMTbKLGkna3mjxM5N4obplGf7EL2SsbDDxyxUrv87HBsCuEFi
         +aGUMlCQ8s6pWcInZxv9XSg/FBrJ9LfomtmZEdQka7fl85WhnA/Kv21sl4/VUxSSnmKA
         v9lbXRiCU3zJiNq1lfCKRfd1Mzv2xuKxBOTTe2P3oLzyl7cweMGad6SDSBcErTpyL5Jz
         naAoqcePyDl0haWPY/y77CK3ZP9b0VyUkCp1Cf9vppv+TV4opMOzrxOlpBNQJ3kKnAl4
         vnzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019664; x=1781624464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GAnTELKE5MATjs2C0Nk821QUo58J8OicUl8Ig/dNAM=;
        b=Y1n5zQ11KVM+w3Y47hs5CO9j1IevWlmN38N4/QvogMPFKBR0SV92A+V0TsXaAeP6Dn
         mPn97jegUhMZLQ47qUK58MgymNus/TPRUQaZ5RTSsjt8PjVwwWoDUeL0TqzmQmt4B0ns
         cdSzErQehTYSHBP3krB11l0Y8ttxoIIRPGk5eSUpsG4bXTaYgZ3rSgk87W88R7m0tu9C
         Osf4EKCS9PvVaDkb7PDGJ5awqWVaD2EFWfj0GfOk/jN+YnotHxfsexK0+5PByklq5/pE
         G8Chls0s1ifKeBiJ2G6EoB4cjX9TXcqCMu6tkEnXqdipDkq+lsb1bo1G4z67JR106ewJ
         2wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019664; x=1781624464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3GAnTELKE5MATjs2C0Nk821QUo58J8OicUl8Ig/dNAM=;
        b=s1iM5vdbcgEqOUmiNjrNwOFHEbR8uSJhRAnz5iqEwmxcCK7yxyBck1NmLK9Qvqba9a
         JJm5wwdeEkDPjt+lN0epLPZnLj9sGfGrCeQp3JFYKY99k9X7MtJ5Tdoal7cj3kgjHgru
         2Enio8Lasig/fGWh8fHNfNjAEsVpcAHyJonZHrnu0yLoOd8jsxIpKOIaryqcRSBvXLMV
         7yoTGcpjXiacr7rOoskr1YPFa/zMP0HxSM5Vi5/iQ0gfj1J1LzII2bd6aa9/9OroIi2R
         0QYEEPVsIV0k1QvIBvzdvQoJ32xyeR4d/GHaDQ/tT3WFsLlmD7uMSvmviRSA52n9KcFW
         5f7A==
X-Forwarded-Encrypted: i=1; AFNElJ9UafWHsekBtHSf5AqPSwTZXt7Rzwvbkg45Y+Zqg9J7CWYUsnxx6HMnj2RTUset23fZNieWa60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ijCl0j6d0AI/qhAMxKeICwq6tpq183rLBtf8yhCmihQ2EKid
	ToUZBNPNlP/Q9Nq4c+6cMPMKbsdkzh3brxndgeJFyL3wZgqXZpTKgLs034jGn6f2ZhNCOtt/AMf
	5QrLZaKaOE0+gtgRwQ2s4dscr2bgBLuWBT7D09NMc
X-Gm-Gg: Acq92OGZF3OGC2LxB6vh38Ww2ia7+8ocpVYFImST3Z/zypSY1VAO9+mV4QMPC34qv3Q
	weZ5V4Svd65vP7CbmmL+xeQJGsnJeXGw3cDaG5ngUBEiZfptwisijee4Iht80yBe/xwPRcVZfgV
	7lTpH9nQVulB2HlFAiFZAsE/Q2LgSsT9JOoxjvjYDXG8ppVbZF1lAy7iAM9PDiMZj6VgFCbxntn
	NDDNtUZtkKv79BheW+/61bkhLs1QWPtD1u0Lbp0xupbyHn80qDOFKcwLDqwhfQRbC0wDFTe5HcE
	vnzfz4ucm0Z4AY3PfxIIjd0EjtDfJjwh8KptoJ+p4RDm6sRXU4VbgTVULwaAmMx9s4g2NCQAisd
	aLjOrkqvu1BeQjFtAHFbGVr1HBcbkUR3nqLcgFD9Q
X-Received: by 2002:ac8:7511:0:b0:516:df73:d67a with SMTP id
 d75a77b69052e-51795bbf6a2mr203972241cf.33.1781019663262; Tue, 09 Jun 2026
 08:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-6-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-6-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:40:51 -0700
X-Gm-Features: AVVi8CfVy8tenKpjic_q5bv_SlcaHKaEEUFlJDl6PH1LTlibV7QZlMPQssTNlKs
Message-ID: <CANn89iJQihA==_z_SyGYW4ibpjmRo+PX9U5BPDL+Lw9sX4oWnw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/12] net: ethtool: optionally skip rtnl_lock
 on Netlink path for SET ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC39B6622EF

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Make ethtool not take rtnl_lock for SET commands when operation
> is performed on an ops-locked driver. cfg/cfg_pending are now
> ops-locked, since only ethtool modifies them.
>
> Some SET driver callbacks will still need rtnl_lock, most notably
> those which may end up calling netdev_update_features() or the qdisc
> layer (via netif_set_real_num_tx_queues()). Let drivers selectively
> opt back into the rtnl_lock with a new bitfield in ops.
>
> We need two helpers since Netlink and ioctl cmds have different
> values. Keep the helpers side by side in common.h to make sure
> they get updated together, even tho they will only get called
> from ioctl.c and netlink.c.
>
> SET commands which don't use ethnl_default_set_doit() are converted
> by subsequent commits.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

