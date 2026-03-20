Return-Path: <netdev+bounces-269849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJSiJp8IvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:43:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF22D7593
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1360130071CF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDC364933;
	Fri, 20 Mar 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="py0xTpPH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539B330315;
	Fri, 20 Mar 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996126; cv=none; b=TYt8Y8p3+8wxXi+9+fFByWNLGEB95ibqrayj2r8n5V9SK0pAUf9pRw50vd/FPOzpRoK9kPYElXtgIbXgBX9DL+zcJuxaDMPqNl0k5/w0z8D8y0uIV4M/npBXJLnr4DCGFBHlOWWgtiI2pbUcXeg6Jt0eIAsSPiKFOgrjowh2yUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996126; c=relaxed/simple;
	bh=zO+mvqsTq/FqjQ/HTVX0MRBmWd8ADYf0Gqg71xQZ7uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrXDm1kxu7aonzXTh9VaGn98gRpceSzugaUTw3MiIB2E4iG7xgQG2B4pda2+G3Bq/7VzZblwe8eV3eXs8Cr39gmPv19VaVjF4cBM1YaBkDwTUkDxEpEpD7ahkySpozS5YrFRIqiKn6YJAhgAfvyE4lMuhp0goiahHP6VFAp2q8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=py0xTpPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB67C4CEF7;
	Fri, 20 Mar 2026 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996126;
	bh=zO+mvqsTq/FqjQ/HTVX0MRBmWd8ADYf0Gqg71xQZ7uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=py0xTpPHS8fN339WVJA2dgI+xAHOnqod23eKmMzT373n8mUPjOYNbKqmBgcsBPPLr
	 Ci1rbCBIcFaLswarXeyJPZXt4UR+84ejGbnrnigu16/6drZn1A9dv9Kkm7eXhisGYO
	 DAShZAk57xa1ZFX5BBgtynGiBgIpQAgn2kALEXJN/j8U5DfGF9LK0EtJrCDlQubIBD
	 ZGWS2pn2oac+isGvi+cCUkO1x+NfG/meanGy9mpdUKpc9A9cfrzee/jmpmD2yp/f61
	 fgwuVt60U4lrOHtJznt5DsBdkrMvYFZ3sACzJO5xTjn/MQK3tToMac+doRtacAzEmS
	 IVg/GAmxpX+qQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 8/8] selftests: bpf: adjust rx_dropped
 xskxceiver's test to respect tailroom
In-Reply-To: <20260319175538.479139-9-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-9-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:42:03 +0100
Message-ID: <87ecleopt0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269849-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 10AF22D7593
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Since we have changed how big user defined headroom in umem can be,
> change the logic in testapp_stats_rx_dropped() so we pass updated
> headroom validation in xdp_umem_reg() and still drop half of frames.
>
> Test works on non-mbuf setup so xsk_pool_get_rx_frame_size() that is
> called on xsk_rcv_check() will not account skb_shared_info size. Taking
> the tailroom size into account in test being fixed is needed as
> xdp_umem_reg() defaults to respect it.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

