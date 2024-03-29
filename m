Return-Path: <netdev+bounces-83632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677F8933A0
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0178E288F00
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D614C599;
	Sun, 31 Mar 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNGe8T+n"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055F14BFBE
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903104; cv=pass; b=jJFjp3ySaAHEe/BlbhujJKc+5LKk2RqvQm2/zkJOaHzYy+ifujWgmRivwWWM4hkzk2srd23l/0iPjro8qVP5aR22PNPS4Z/EPmWfBs58SbJwj/TNa59/uQH9+dlgv1Hjgw6oSk54buZW3AGjOFJpXnzYuSiKBaNPu0oZXnUVjkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903104; c=relaxed/simple;
	bh=VUmYEKXDlF4wS7Yo8cNwCnnm4QOfOVJSj/3PTpcpBsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-ID:Date:References:
	 In-Reply-To:To:Cc; b=eVUfvoO9mUN7L6OSEbG0tmrglK5E9JCF2spLe7n5CVCBj41fFCpZIyZZIVn9+zgZEVv/QAG/ZYGQbY/+6zIvc5wVVRHA6R0DbzqCtDsgYhdzrV91f2dDi0QnwARNlOsakNaPnKBKkSYzbdDl+or6iWX/ej2/9ovIQQ8Pb1TE7bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNGe8T+n; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 11D3A207BB;
	Sun, 31 Mar 2024 18:38:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSd-XRnLe6Nn; Sun, 31 Mar 2024 18:38:20 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BE2BE2083B;
	Sun, 31 Mar 2024 18:38:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BE2BE2083B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id B19B380004A;
	Sun, 31 Mar 2024 18:38:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:38:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <netdev+bounces-83479-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAKEmmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 7558
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83479-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EE9F520883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752028; cv=none; b=GJNkldxqScu+Xle1n6gFjgdWR/nj3x+2cDUSIZUPohDuaHYAZMILiahAJRCzTWf/rgL8xd40eIbE4LRjXi2Ob7aMIGeqSGrXvm5Bcd5KQnRl2B2wqRF1bjy5xnIGwg9vcvRqBxA05NY+sNuP6eYzX1rTiuw/xqtPppWxUl7uLLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752028; c=relaxed/simple;
	bh=VUmYEKXDlF4wS7Yo8cNwCnnm4QOfOVJSj/3PTpcpBsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KUYZnS5mQTWnly8goiYxQJaJZWQn5fgqjIPGGgveMCOqa/7nmAU/Vu6pm0lrQxT5QLB/URGAQP0lnDJdUGX4XO6RIOKPDB9fPP42HoU55J1qUyBQgToX6NdHuhVmluH6+G4gQ7ZtG33hZt5KproWoURaWbDBB7DHj13MLog7y0w=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNGe8T+n; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711752028;
	bh=VUmYEKXDlF4wS7Yo8cNwCnnm4QOfOVJSj/3PTpcpBsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lNGe8T+nmkqRsk3h2OZtTliMXK1Jw/jrQedrderw2QF0C41aHCA7hfBKgzXObbI/T
	 mvQSOpIyQ8F6q4sXJSQ063k1bAogBj9eedWzHgrgEzdqltKkvfkFJN6l6BVMeCr4Zv
	 4E9NNxn8n/cARj4cx9O97tyBYxnjhwExxKHlnnC3kaWQa6SYzxRsOtOtADghI7IRMS
	 TKp2Pud8nrXyo6vTV7AMPj15X2c/1QOH5R6N6rXDnYibmOWVYqUXyEfBwC7inj/bJq
	 m8/GK+kpsFdz+ZIV4kpZGmgVT7WLEWcVy4RLceKA2vJQwfiYFIwGHQ+sNzkS+A/IDd
	 TOLN2qIrRiM+w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: introduce type-checking attribute iteration
From: patchwork-bot+netdevbpf@kernel.org
Message-ID: <171175202819.29251.8300719399855725690.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:40:28 +0000
References: <20240328203144.b5a6c895fb80.I1869b44767379f204998ff44dd239803f39c23e0@changeid>
In-Reply-To: <20240328203144.b5a6c895fb80.I1869b44767379f204998ff44dd239803f39c23e0@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 20:31:45 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are, especially with multi-attr arrays, many cases
> of needing to iterate all attributes of a specific type
> in a netlink message or a nested attribute. Add specific
> macros to support that case.
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: introduce type-checking attribute iteration
    https://git.kernel.org/netdev/net-next/c/e8058a49e67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




