Return-Path: <netdev+bounces-206890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2AB04AB6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568E67AF8BB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83671E991B;
	Mon, 14 Jul 2025 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFeyunAp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947651487F4
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532344; cv=none; b=KrHiNIpTlgTgxDMj1iKRRJpUpzPL3Yf4P3esl3MsoQS2ldGbkOdV/Ov9hrN4b67CyNnl9eKi23rnF6MyJnkROymn3Lg9fkwn4HE2LpLH4qbrKbvDQu7VEeo0zgsUn7W03w1/QJyUuZkwGk1EbxZAk4BOU2/I/9aleveGRpi2dVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532344; c=relaxed/simple;
	bh=8z2RSaCpKcYog+G/OOYoupqlRQA/+lQSTfISVDMEa50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll0qOwt3FW/j55nxaowqahiV/BpNmAeaW2MM+TmeOHrjz/tMqWiJUe7u9dvZelq7AFc7gkTYBbMXU8zWjed6PVNmeONBhPUA+9uCZL7w2JBRxxvUUiptNY7FFrHUglDYZ9a0v1eqqiAetfppWmHDpbYr8vivFephfIWpMbHJ6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFeyunAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B4DC4CEED;
	Mon, 14 Jul 2025 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532344;
	bh=8z2RSaCpKcYog+G/OOYoupqlRQA/+lQSTfISVDMEa50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fFeyunAp0xQmOlqGDN7hHAu9/IuGVSiOmdGVDKZFdrXdBrPkMNos7AIQ+WYmw1bU2
	 pFon4gJt2NFxgj7mlU/wM5n4K9QFFKQknuFbIDOQ4HZFlKEy6AJBonfwDjZ3kA2oHN
	 k/F6tiQpGyrF8a1oQh/dbK2Og4OPAgAEqcYYxKKcFlfvWaaiBLQnvDYkfXg2vrPj0Z
	 /pejQYxUHn9L4rekT60n4Mh1T6EXPkacJOQ1gg/gQD8rIX9T0cI3ao3zWjcU0JSYiZ
	 JFjh6ViITo/ArNgRmDVHg174Kmm6ZmXXhMjw0Io40LKoKGh76qrEE9AeEmLH27MhmB
	 k4XKP1En7upzQ==
Date: Mon, 14 Jul 2025 15:32:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <20250714153223.5137cafe@kernel.org>
In-Reply-To: <aHRJiGLQkLKfaEc8@xps>
References: <20250710100942.1274194-1-xmei5@asu.edu>
	<aHAwoPHQQJvxSiNB@pop-os.localdomain>
	<aHBA6kAmizjIL1B5@xps>
	<aHQltvH5c6+z7DpF@pop-os.localdomain>
	<aHRJiGLQkLKfaEc8@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 17:04:24 -0700 Xiang Mei wrote:
> Please let me know if I made any mistake while testing:
> 1) Apply the patch to an lts version ( I used 6.6.97)

Please test net/main, rather than LTS:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/

