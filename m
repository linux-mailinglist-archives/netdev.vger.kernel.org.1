Return-Path: <netdev+bounces-269847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKEQOAEIvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:40:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A62D74E6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCCFF3002D10
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE136492D;
	Fri, 20 Mar 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM8vtQjz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B427FB35;
	Fri, 20 Mar 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996028; cv=none; b=mX/1UWkBY9chfFyENN8YKYy7C7dNQWTRtsKsPHTnfYojAPI5QhU6KyfoUoGABUow/20F9UPGvwQtccpIUZsBlhWgKePkL00S/56N/Mvsl/+n6ja/AZU+RNXQntRlEH4qXAPpPj3RSLTdGPJScxlssEOJKu32Q3IV6MQKy5p7yR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996028; c=relaxed/simple;
	bh=j4MjyNeBAQm3UCbDBVfDDLHOd5s4/rdmHfs2/FpS8jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjg7P4X/urOU62Rh9bDC/MMNJ04HiO1lslE15fkXe9PRIyAoYyf8dISj8tmTbGy48awNdm1rDsxbTy41TchTZ/+o40WDnib+2VhqFQvBs5FNhG/U5J0r4bzG6u3jHagjkZLiGb6zMuy0A1YiQJPrEy7mNyzwjh6X8Db2ftNLN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM8vtQjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74B3C2BCB0;
	Fri, 20 Mar 2026 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996028;
	bh=j4MjyNeBAQm3UCbDBVfDDLHOd5s4/rdmHfs2/FpS8jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JM8vtQjzO2lFrbPsJCJlN9D58mPE9h28RDKgZARVEHqtZPBYp2xdeCe+AG3xczdd9
	 GF2iFdm5Qnc/1/na8ZE0KXv660MBo7nwUvvM7I87GgJJPK1X2XPmuNQs9L6C96LAVT
	 +taLJy/FGpRG02/CpP4tzZBa2A2BpIaz+A4BlYZa9Wc/pQyY8XyExA5dNWqYKvcjgJ
	 hiapMsAMHa/VPSzI1psX0mVhKZJXuohcvwomn68aSilutZEAIWDYfmILVsatClsRN2
	 eTFmsV0Ux3nktmAcHGl8NXg+wfhXDbGthE0fN5FqPRi3bn+Bidg6226qA+aLFui9eu
	 3/RkPmgjXD+Ww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 6/8] selftests: bpf: fix pkt grow tests
In-Reply-To: <20260319175538.479139-7-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-7-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:40:24 +0100
Message-ID: <87ms02opvr.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269847-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,all.your.base.are.belong.to.us:mid,intel.com:email]
X-Rspamd-Queue-Id: E13A62D74E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Skip tail adjust tests in xskxceiver for SKB mode as it is not very
> friendly for it. multi-buffer case does not work as xdp_rxq_info that is
> registered for generic XDP does not report ::frag_size. The non-mbuf
> path copies packet via skb_pp_cow_data() which only accounts for
> headroom, leaving us with no tailroom and causing underlying XDP prog to
> drop packets therefore.
>
> For multi-buffer test on other modes, change the amount of bytes we use
> for growth, assume worst-case scenario and take care of headroom and
> tailroom.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

