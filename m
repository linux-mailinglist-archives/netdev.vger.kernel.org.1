Return-Path: <netdev+bounces-102407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D454902DA8
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDAB21681
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F153EBE;
	Tue, 11 Jun 2024 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2ZQlGiB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3064C;
	Tue, 11 Jun 2024 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065642; cv=none; b=BKfr3NpPJJVEop3cTFEzp8LFHRS5XXby3+mpC4yhoroT0/IKJB9Sy65SH+1AxrQnU1ip3jm+u8LN6VAz4uZUJ5K4JMYI7yq/VWL2RWW7BlycUTdr+CmLJsj+1+UhkSLdIpKrO9aOHYyL6RU/MN+uYdhb0gYgq4UmH1b69UCDTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065642; c=relaxed/simple;
	bh=/3nN8LqGm3cTRDAunyUSBY1I0Mt1cWvs8XDEfR2ayp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+wZecEmnp0Qbv28sb6MB8Y2dofWxvik0lz7+X5b4wBkO7MSG7o+71bY4H6cndaXggPhppIYaEp0BpmmZDl7DliM/mN16+FDlxlANN8DH1LNoQvc6Dnf6r3lT6/0YBjWCCq0rkSBldJlTBQ9z69JuXs/1jZwLAlMfFSE8+Vs9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2ZQlGiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E06C2BBFC;
	Tue, 11 Jun 2024 00:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718065641;
	bh=/3nN8LqGm3cTRDAunyUSBY1I0Mt1cWvs8XDEfR2ayp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p2ZQlGiBn0dj7GSV4IYsnwq2oNbkRmGVgx6360xzuZoAr5dBrXBVfo6I+PN8LDvB1
	 zixFjA30ZQywMrAr+pJ5jV2A3I35gtZymzYhGeTaOOPH9Qm5SFrmuuVCYyQ9PcupPJ
	 f6eKMwFnMG21SXPFT9rRUrUpDqaHyYiTX1fLdTajwNYSblGudxHwr9+rj/ahsNrEAw
	 z36V0OtMQxAgZCDYTM9K6ok5xcANwUBwnabHkQnFRtl/9uKFYhoku5HlehY0rIiObB
	 YW+6qN1S24Y1cYZT9y9+milIYKSQtFghmBQb77UJtwzfVeR4u+qLMgwloRbjQwTRTw
	 xu8Xj3rk5gQsQ==
Date: Mon, 10 Jun 2024 17:27:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: joshwash@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, stable@kernel.org, Praveen
 Kaligineedi <pkaligineedi@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrei Vagin <avagin@gmail.com>, Jeroen de
 Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rushil Gupta <rushilg@google.com>, Catherine
 Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] gve: ignore nonrelevant GSO type bits when
 processing TSO headers
Message-ID: <20240610172720.073d5912@kernel.org>
In-Reply-To: <20240610225729.2985343-1-joshwash@google.com>
References: <20240607060958.2789886-1-joshwash@google.com>
	<20240610225729.2985343-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 15:57:18 -0700 joshwash@google.com wrote:
> v2 - Remove unnecessary comments, remove line break between fixes tag
> and signoffs.
> 
> v3 - Add back unrelated empty line removal.

Read the maintainer info again, please:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
we prefer no in-reply to postings.

