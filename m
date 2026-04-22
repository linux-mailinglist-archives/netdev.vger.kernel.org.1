Return-Path: <netdev+bounces-280444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA+1JQ/l6GkHRQIAu9opvQ
	(envelope-from <netdev+bounces-280444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:11:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2686447B96
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7913019832
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B832C3257;
	Wed, 22 Apr 2026 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krIayGE4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C1221F0C;
	Wed, 22 Apr 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870275; cv=none; b=P5yb9agPF8Ygc3hLZ0nSOEW6TUZsxkAVjVZYHN9xCMPOZIgCF4B11NS1SNfTCo4GHmFaQNN7G8klrSpYp6rlyQZk4NpWIBnHYqisgtw6xMQ7JdK4I0A/TCAASoqkW0gJdZIzJqyoU0pmduJIRnNtUjLylzu13zwivVxX9WMIhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870275; c=relaxed/simple;
	bh=F6RKtB9c5NMsYq3hatvMo4jRKia2Q3VHjtemygkf68g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXC8r1+yp8SaYAnVBa3C4ONGiDJXH6F9awyUXz9bpTdNXAoaupympeGQN03ZKbW81KadK5b6pyMssf82sV0GfW2xeYHlipyMN+QZQsTYylN/mAQrq7k+7EnCoGMTu8LmkJuME0uJ/amuSihzaXInZ5jRBMETNU1BsUf/DZ9i6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krIayGE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8ACC19425;
	Wed, 22 Apr 2026 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776870274;
	bh=F6RKtB9c5NMsYq3hatvMo4jRKia2Q3VHjtemygkf68g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=krIayGE4TCmDTbCO9OAOXldfUme31ne4gun7oSWGgFPAo3zeKkanxDSEOU7y+1Mkr
	 gRng04c/Y4BrRCJQWJA+iZKQ8TNy6RaMk7wSr2QnCYLuVqjbgeNH5fmBKblmilt/g0
	 JE5IveefG4ehCG7A3k6T8Qi7tqgS3M6lgRQ6nGqnNv7fngSRyjLflassbQn61sPn9c
	 HeRCOhP6Xc3+4b+d6B8flPMmab06mr1wLHpZBV2E52dPfK23fWCX93u54u11X1TFfZ
	 5GPkiKykHtIZMuFvu1VmiGpMas6pr7UYJ5RVb6mK6e2sawSVFqFOAbGUdjZCJ+aOQ5
	 vZVne858Oqa/g==
Date: Wed, 22 Apr 2026 08:04:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: udp: fix memory leak in udpv6_sendmsg error path
Message-ID: <20260422080433.0e5a3b47@kernel.org>
In-Reply-To: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
References: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280444-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2686447B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 18:58:02 +0800 Mingyu Wang wrote:
> During fuzzing with failslab enabled, a memory leak was observed in the
> IPv6 UDP send path.
> 
> When sending via the lockless fast path (!corkreq), udpv6_sendmsg()
> calls ip6_make_skb() and assumes that the routing entry (dst_entry)
> reference has been stolen by the callee. However, if ip6_make_skb()
> fails early (e.g., due to an ENOMEM from memory allocation failure),
> it returns an error pointer without consuming the dst reference.
> 
> Since udpv6_sendmsg() unconditionally jumps to the 'out_no_dst' label,
> the unconsumed dst_entry is never released, resulting in a memory leak.
> 
> Fix this by explicitly calling dst_release(dst) when ip6_make_skb()
> returns an error.

Test this with cmsg_ip.sh on a debug-enabled kernel before you repost.
I think it causes crashes there.
-- 
pw-bot: cr

