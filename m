Return-Path: <netdev+bounces-212512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E80B2113C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83C5687DAF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4D2D4802;
	Mon, 11 Aug 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih7lqkDM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21A2C21F1;
	Mon, 11 Aug 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927810; cv=none; b=TMl5heUZGgsgDbeIiUXVCagt9Q3qHgqspwMHRsDYuhllEU09HJMJlQ8D8C9Sak58K2kTw8sXW3181fpXo9jxTXySSw7443KdsbgnhLYWFMRftzE5j14AEgPWrsxlt6V1p8r74DLFMppFbAtjnRJkad2XAm4hm3IHkCs0JZiI0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927810; c=relaxed/simple;
	bh=5qdoi84GVHX4Ea94f7sd+zFnFKBjAi1T20bX4KR1Sus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT0C33OG3KkoRN1TpNS4CUBRk7WyQECaXjAFxOW8ZVwejv8bKB1umR0D9Frv02AXow2Y5/10TtClw01viSv3XBpscFcuq68ywL5s3toj10pGofn2krQi56AgxKm09F4bWmrJaQ2mF2tXqLAP9LWLavu86rCJM27zWIrEAZSkO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih7lqkDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918A1C4CEED;
	Mon, 11 Aug 2025 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927810;
	bh=5qdoi84GVHX4Ea94f7sd+zFnFKBjAi1T20bX4KR1Sus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ih7lqkDMf8GSKoTaeZ61CQQn37cc8+kTMwgqq1ZIXqEMvSrNsN9/6O9hUmtVs8Rst
	 YxoAeEngUfx7QfZ1ntggcHborHuHqLXhhj/8SBXC1ESe0GL98zOTpoOJUO+5rGBXQX
	 KToQ0M/uDwyErc8RAb19pU1o9gyBuuej/fuqWPkdhzNwenmUXRIkqzYuEcJGvk3uzD
	 rl3zZ6axIxm5wVIk+OccG87EAYRvL5K6NGaIu6iaWkr44LgOGTAaqnLJ0rmqnC8AcW
	 BV+M7fxQnAiQWGE4bRjfhASiQ8LoqRsrx5KnM0OJz2NqHCRfLqzAj20yLE3ZnaQnq1
	 iXS741w0xA71g==
Date: Mon, 11 Aug 2025 08:56:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 neescoba@cisco.com, johndale@cisco.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] enic: use string choice helpers to simplify dev_info
 arguments
Message-ID: <20250811085648.449a605a@kernel.org>
In-Reply-To: <aJjzFb6c6OCGib2F@bhairav-test.ee.iitb.ac.in>
References: <aJjzFb6c6OCGib2F@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 00:59:25 +0530 Akhilesh Patil wrote:
> Use standard string choices helper str_yes_no() to simplify
> arguments of dev_info() in enic_get_vnic_config().
> Avoid hardcoded multiple use of same string constants by using
> helper function achieving the same functionality.

This is unnecessary noise..
-- 
pw-bot: reject

