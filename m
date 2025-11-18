Return-Path: <netdev+bounces-239644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5DAC6AD22
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5984E1D82
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647030DED4;
	Tue, 18 Nov 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="sqzEzDUu"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB00320CA7;
	Tue, 18 Nov 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485112; cv=pass; b=ZZe2rnWswMjtxw0Zh7rS7mET+t4nxltM+gszm/bbN+zU1v+90a+w0mImey3gDqLyFlvruG6R42aGQP1jHmW53hX3uucwFuIAnSzLaz4T1yVHenqEcW9iaNFPdyUs7TPiEKTQyBAy4lJgBnzNkLXqAOfa+/u2pg6pJE9OnbSYsnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485112; c=relaxed/simple;
	bh=xZhjIiweoUHnoJYfxxzJK269EJ2G4yOXHv5wm1xAg8k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=i9UovRheUglT8+FRGsx45gByAmZj55LqwKvIXClAoFE1DZavAKKAwsF73iJcz82fxHNz/tvO5UGeEntpRkqKGXx5auTPjG5bh+860Wq80RIJG7jQDwoQQG991zU7BJb54RzuaGSK5wAI1heNaUj3TnhQn/6zye5WcC0sASkhQ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=sqzEzDUu; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1763485084; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YUL4TfzEiW2RUv4LMx/epPavGOiCu0gKd/wWIqfd+SXB9bReQTK/3sSSazKrAPEuARBMN3+pbsIYECZ+IdTh4GzeSSef7rxkJDgh50ZRknCHuWjvdbJ0dSMo/Ck53rFy5IaGWgDILx+2GdExqPtJNcT5wx8bz4kVLEjqLK9WkVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1763485084; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ioid6xcG1IUJc/v2a6BtP8IHijlsAybh/qyCB5f699Y=; 
	b=e6c+DfX8NsQJJ+XagYt2E1dvje3jlRWQWXtfqkLhXwwJOgW+CXPCrIWrJgVmuJvo5Ef1BVTgND5uPSzeQ9riSYx1FQSka+uBnrafqh9qMCZHezka47Fz6Yqu1mt1wIitlzc7gn0WgoSRETBE4Nv3a1/zfy1SMNCRvCB9BpF4kaY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763485084;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ioid6xcG1IUJc/v2a6BtP8IHijlsAybh/qyCB5f699Y=;
	b=sqzEzDUu/BD7rRc8sKGbXKexxV2Y9XlErWm1px6gNcbn4h9g0RDJ3muC+825AoE8
	V/mr5Ltk7Witw6cXFaKVYgo5HnZ3713wqyLsqNhTpaacfuuGy6vmcrUAHmkfl96g25y
	qm55OtICKYOZbrb9boHBMFH281Db49ULj96K34yo=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1763485082304818.3052362153074; Tue, 18 Nov 2025 17:58:02 +0100 (CET)
Date: Tue, 18 Nov 2025 17:58:02 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19a97e6e2a8.e1c4ccce20888.2202702737503651650@azey.net>
In-Reply-To: <c73cfca0-a43f-463a-a96d-7da3ede8fde0@6wind.com>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
 <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
 <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
 <19a969f919b.facf84276222.4894043454892645830@azey.net>
 <e5e7b1cd-b733-40d5-9e78-b27a1a352cec@kernel.org> <c73cfca0-a43f-463a-a96d-7da3ede8fde0@6wind.com>
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-18 17:41:14 +0100,  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> Having an address in the same prefix on two interfaces is not an "obscure setups".

Sorry, just a clarification on this since I didn't get the email in time before sending
my reply to David: I meant specifically the case where someone relies on the last route
always being selected in this scenario, setups that don't rely on that shouldn't be affected.

