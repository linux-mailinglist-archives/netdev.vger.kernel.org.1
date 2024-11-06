Return-Path: <netdev+bounces-142209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB539BDD04
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB00B1C230DB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC9F1CDA36;
	Wed,  6 Nov 2024 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVdZhWC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583B1CCB57
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859953; cv=none; b=RKeShDCHFxWzzl3RuYh1L8HAWsN3HIRNiH9LS3J39WSxkZu3BkLxEVaZ5gGKEvTT/xLjcg0gewGRFjQk6gm2hx6atChO5T0YUaH5Xm0M6lGa9ZbjdROhMI2s/luoV02PJK4QR9vd8FpN5husrrj7HfkBsCdf6GJowzLQKTDQYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859953; c=relaxed/simple;
	bh=wg6vCKX+30rJZWT1wBVHNeGiBRclvrUxBgg1Iu9aF6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dw+dNDig3oBVELI+JzhPjM98s/mwodp3IKXbi12XX96AeNqXPmi+vt85SXHdjxbHRUt5n28t9Qeg7IoCWA4pVLww4SlTajUZpP9/zqs4FXWMaTb8BFKKaEIHFt0zDDZfW9MH3aWYFDyWsK3SgFVRKfbZpvQW69yiRyTqV88konw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVdZhWC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C99C4CECF;
	Wed,  6 Nov 2024 02:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859953;
	bh=wg6vCKX+30rJZWT1wBVHNeGiBRclvrUxBgg1Iu9aF6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gVdZhWC+fwXgNc/OI71C1/NkUiCQFT8NDJPZ1ZMtZS/9zrqUdf/LFdqjH9q3ABry8
	 Ir4tgHn3rOC7+Y2GwRuhrl7SnQ2PHmAfBvmzBuj7yOVNFWhmfWL4ryge92//ScDw+Y
	 3QSNvO4LqLzrdS/AmyVtg62ZlQsZANMnLTneOQolaaYvbq9ms/wY8dJQGQvLBkfpdu
	 /f2psP6xA2UI8G/AeCx656CxKds8TSEu5xke4aWsqWRiXSk/VDDfRXPAZuajINRlOd
	 yoNGvvh6DjVUr5m+OvR9rx+UBNmGC5nP55V4+1DkmPeWL3IeWmFJeXMq4xH1tPLul3
	 txvlue0MCxcCQ==
Date: Tue, 5 Nov 2024 18:25:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, syzbot
 <syzkaller@googlegroups.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Remi
 Denis-Courmont <courmisch@gmail.com>
Subject: Re: [PATCH v2 net] phonet: do not call synchronize_rcu() from
 phonet_route_del()
Message-ID: <20241105182552.072b72b7@kernel.org>
In-Reply-To: <20241105132645.654244-1-edumazet@google.com>
References: <20241105132645.654244-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 13:26:45 +0000 Eric Dumazet wrote:
> Calling synchronize_rcu() while holding rcu_read_lock() is not
> permitted [1]

Doesn't apply to net, looks like it diverged in net-next
-- 
pw-bot: cr

