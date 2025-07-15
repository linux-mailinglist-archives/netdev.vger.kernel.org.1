Return-Path: <netdev+bounces-207163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D566B06180
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F9E586827
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C827FB28;
	Tue, 15 Jul 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLb4Bozo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E721F4CB3;
	Tue, 15 Jul 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589261; cv=none; b=FMiSIP/ikb09tRicPbQkW6Q/WUAU49bXS6TdTg20wbHhM7tzrN0KPMLzjMBudwGkbwrqsdAoKVkJS+xv49bVA82T2efvO+rfC3hRmcwe8079AnO/8WITZEbnLB9za+Z6glTvVG9ARegGiK3V/izvxvi6KnIXyuuLIDS2Kl3sLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589261; c=relaxed/simple;
	bh=eQjJgR/oDtaOs2MPo8Pk+9oLfpcTrrBiHSBrMOvYofQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4QMHoFjKWG5x36YS3dixnTfhIO8josyEB0182Ke0LC4he4tANMhsApkeAdfZt4djH81GwtVdv5IX2Sged6HjhxGo4iasd0zSMSzafwLQlpahBBQzWLRaXTpxDDR/8tVG2plZhZ8ODI6FofsMqACO2BtD5AbO2/1qK4YECjnPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLb4Bozo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE18C4CEE3;
	Tue, 15 Jul 2025 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589260;
	bh=eQjJgR/oDtaOs2MPo8Pk+9oLfpcTrrBiHSBrMOvYofQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vLb4BozocjqZxC6gyiYZMIT1bSpxhcHm7i9I4ziyEk/SY3vpfw2H9LPzqFWjLkIae
	 153TurutkmAHcp3rCihii3qe16uZaoqVnQbsemgWp89EQ78qsoiGrQtV3+KC3veEUd
	 9qCJ41XhfXVW+cnHZLLe+J6lINfdqYUJo7mXPdqf9LEoheW5ONZhDbfTpv8Pkk722u
	 QTo/B2F5INao0j6wEDa9dQaZSQPgNM4fjGHBfdAadeqNTogRAuO0cUn54WYxr/SxY4
	 HlAmt8TM5NFAw9yzOldyxMRiMjQzKgHcCP49iY5NB6qsTQ1oy6OcjSAYW6p+cS13sM
	 sTyInBe0yjv9g==
Date: Tue, 15 Jul 2025 07:20:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <fan.yu9@zte.com.cn>
Cc: <edumazet@google.com>, <kuniyu@amazon.com>, <ncardwell@google.com>,
 <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>, <tu.qiang35@zte.com.cn>,
 <jiang.kun2@zte.com.cn>, <pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net-next v4] tcp: extend tcp_retransmit_skb tracepoint
 with failure reasons
Message-ID: <20250715072058.12f343bb@kernel.org>
In-Reply-To: <20250715123532715Qrm78AnS47Fztgj_NXs20@zte.com.cn>
References: <20250714164625.788f7044@kernel.org>
	<20250715123532715Qrm78AnS47Fztgj_NXs20@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 12:35:32 +0800 (CST) fan.yu9@zte.com.cn wrote:
> > -            return -EINVAL;
> > +            result = TCP_RETRANS_END_SEQ_ERROR;  
> 
> I agree that some of the result types (e.g., ENOMEM, END_SEQ_ERROR)
> may be redundant or unlikely in practice. If we focus only on the most
> critical cases, would the following subset be more acceptable?
> - TCP_RETRANS_FAIL_QUEUED (packet stuck in host/driver queue)
> - TCP_RETRANS_FAIL_ZERO_WINDOW (receiver window closed)
> - TCP_RETRANS_FAIL_ROUTE (routing issues)
> - TCP_RETRANS_FAIL_DEFAULT (catch-all for unexpected failures)

Isn't it enough to add the retval to the tracepoint?
All the cases we care about already have meaningful and distinct error
codes.

