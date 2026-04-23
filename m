Return-Path: <netdev+bounces-280815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AAKJ1lT6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:14:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BAC455627
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85E19301168F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5A37D137;
	Thu, 23 Apr 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajog3ugN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC136495D
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963652; cv=none; b=NSuCnLGvKJPf9PcpZaAGEWWlaszWBeG2siFUIMCP/uNptWFdXb3qnT1Ow/9snm4xzlcR9ZeqhDS4XrsjzZhdmoNG4Xy2Vwd8jh5lRlsYV224T4GeYjdhOht4un1lbeaRkPGC/kmV67bgU4gjBFNbDPjHlJCzs/Pt39WNUVHkFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963652; c=relaxed/simple;
	bh=Keo+Uf96fFdaulWA4oibMtL7z5MHBt0b6K1Iv0Vr6Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONXTme4QUG4IqkSjMogwqZ4SEvQzrJuYEfh5tjnwLRzzYE0osLrNpbzfzivOWGGqKKPqFp8cQmfq/L4t/fiSiU5d2vqdh4qUnxAYJVt65gr+nMjtLXwJd0btUAHxcCXITArfb7fWIx85DYS11eTozZbqn2y/u3YqeA4rFgddevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajog3ugN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480C3C2BCAF;
	Thu, 23 Apr 2026 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776963652;
	bh=Keo+Uf96fFdaulWA4oibMtL7z5MHBt0b6K1Iv0Vr6Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ajog3ugN3+lRmy0Jj9QedUiHYXqJp/aQna1usyAOZ6wng/NcObCDOYdUiyWydU8PI
	 VORpGtE9WiNtVD1QzvAWkCos7hDt6SYMiCqjWAGEdUVrvYq3jBuJdYbjChqBqYfXVl
	 7ARQkqmg2DHrPoRbGaAkIlq7IovHAmrnBGhiDmWRo/7kfJqdMnrrfpBN2P+xNYQaxZ
	 HqWX4XWJpbROo80vLKBdJp4Lv1O/A9Ql9SloEioqv9wVGVXOeyVr0d+zN3gh1j+b+m
	 pcY6QMYXxqAIzAMICQQdggiQoyEms2yZ1HXCEsZE243oiYDFn0xRZqYavR3JlB8ico
	 xt3aEL6eFTT5w==
Date: Thu, 23 Apr 2026 18:00:46 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	andreas.a.roeseler@gmail.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	caoruide123@gmail.com
Subject: Re: [PATCH net v2] ipv4: icmp: validate reply type before using
 icmp_pointers
Message-ID: <20260423170046.GG900403@horms.kernel.org>
References: <0dace90c01a5978e829ca741ef684dbd7304ce62.1776628519.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dace90c01a5978e829ca741ef684dbd7304ce62.1776628519.git.caoruide123@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280815-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 92BAC455627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 12:16:31PM +0800, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
> That value is outside the range covered by icmp_pointers[], which only
> describes the traditional ICMP types up to NR_ICMP_TYPES.
> 
> Avoid consulting icmp_pointers[] for reply types outside that range, and
> use array_index_nospec() for the remaining in-range lookup. Normal ICMP
> replies keep their existing behavior unchanged.
> 
> Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> changes in v2:
> use array_index_nospec()
> v1 link: https://lore.kernel.org/all/efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has generated a review of this patch.  I do not believe the
problems flagged there need to be addressed as the array indexes used in
those cases have are always valid.  However, I would appreciate it if you
could look over this.

