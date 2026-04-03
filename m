Return-Path: <netdev+bounces-275257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKkBGBVD0Gk45QYAu9opvQ
	(envelope-from <netdev+bounces-275257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:45:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07354398D51
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90CBF300824B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E234243951;
	Fri,  3 Apr 2026 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1i119mi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31C2AEE1
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256338; cv=none; b=hvq9XcIamJ8eOJogXD4wVtUeg6928vkeXZPLToeGdaV/a+WCm6aNGN8Lg8+KNdgppBjSiraDCi0I0AqobhpBGPBEYb3Skwxr/Kb467v3vMzq2rzs+dNq9+WT/MBvi+2dKMRWErCrkdNW4EZDTjXIk3Z9IopWkgcyIG235jAN7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256338; c=relaxed/simple;
	bh=OlaIPCXK2Sjbt11aK/KetL4kjEhVvvZu3fOpiCH8GyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWIgaSqobBThywpNViSOHT2ETUB849m0XNC3bYfINOFcZPB5z0ldthbQvPrrt1e4ubnuYQxSPqeQvsRmO21UxIU22YlqYXMlJt7dFXi5T4EALCWdrthpJ667S3C9E0fzIAe7jeXX5ixST1z/JeDD5MiLFVCOh2qRRZpGJGLqRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1i119mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78449C4CEF7;
	Fri,  3 Apr 2026 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775256337;
	bh=OlaIPCXK2Sjbt11aK/KetL4kjEhVvvZu3fOpiCH8GyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q1i119miT7oKLppNHhu8ZEX894c4qfXi1N3oClds5IjyAH9+P9XO5fnoRmilhf8pQ
	 0nb7KII1qwiTNBlI1KSbC2xls8UiiaGd7is3wipzs8FNFim9OuGPqG1u4TmavlHJ2f
	 sr28fi8A8c4/+eYZdhVc9cpho5XT5QkqXvnrQ/f4CMHwf+IoCW+lyMlLO6zpWijX4E
	 3rdNBG+6I99f6evZjVUF0KmBIgNwc1CgYXpZ4M6Siw6oGPXMZX9i41q2LFK72pGhVt
	 vDt7yEVNEs2ebl4cf+TWudhWCobTPTJQIPhdRYNG+aZQWcDiZr2KNX25yDxh9EHoJt
	 3AIGNHn01JnGg==
Date: Fri, 3 Apr 2026 15:45:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] ipv4: icmp: fix null-ptr-deref in
 icmp_build_probe()
Message-ID: <20260403154536.5decaedc@kernel.org>
In-Reply-To: <20260402070419.2291578-1-sunyiqixm@gmail.com>
References: <20260402070419.2291578-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07354398D51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 15:04:19 +0800 Yiqi Sun wrote:
> Instead, silently discard the request. RFC 8335 does not appear to
> define a specific response for the case where an IPv6 interface
> identifier is syntactically valid but the implementation cannot perform
> the lookup at runtime, and silently dropping the request may safer than
> misreporting "No Such Interface".

Well, my intuition would be to fall thru and make the check after the
switch handle error pointers. But I guess this version gives us the
opportunity to delete the just-added check on net->net-next merge so ok.

