Return-Path: <netdev+bounces-143943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5B9C4CE1
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819DA2854D3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CC204F7A;
	Tue, 12 Nov 2024 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s29lKrxo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEE1C303A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380016; cv=none; b=BM6YeKPbKWMzKjemXjVwVXZmDuVnqJDy2ZcMXiXhUm+OkoGc9BpZ/5dc/RXHCJgCthN3X9eyzLEqTotHbXUwlkUeEP9he72uRThb+JpS1gljH0kOhGaI0cpJyyjd6goHDFewe9kQSr7YCSSmL6rOBMeZc0ZiLPbD3M15Nj1G78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380016; c=relaxed/simple;
	bh=qTAg3KvKVI7n+UA+pnf1KTcD4LcbvrpdtlNHA15/EZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPs0q3Ig4dOmpKBTp/Osh8epNhaIKwgm/rgzXhyeT5WsOiLTtuZFJGO9cBFSCdIZKyzZ9lH8TokMzB3MsZoCjKI+XvfjI+0NtETlPmHaA2t/2T71xpJERnuf/rY2PJQjlF+qcfScZKC39ENQB121yRmESWxfQNLtqkhwLdYk1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s29lKrxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A5C4CECF;
	Tue, 12 Nov 2024 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731380015;
	bh=qTAg3KvKVI7n+UA+pnf1KTcD4LcbvrpdtlNHA15/EZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s29lKrxo/w8eD/maGOTTh/zEVCgXayilVoCQtOzN9mV3Mfh9qZGG69hDw0XCLI5Nh
	 LWTgzA04Ssb8Zx2tV9ilDQOU8pMBN7nhy7v6FU1fL8e8L4bCVObBRaR98LkNg8Qrqf
	 38GgwSRubTa3t+6W6+b8QfLYvboG5diirDxdYMZCWR9H8eBMnSspfDu5RkQmmmO8fE
	 CHl+YgDPeIknxV8OpDDHjagpBsg29baq8OIoLdUxPfpXRuqWbjVCa2fx1Q8t6cW798
	 HggrjMqZCE20ai2iU0yHh0I8hHUAkxnUz6pMBYlQMpHdN5954CG0bjt6aL88FAJAoQ
	 HAu/MK98GWhew==
Date: Mon, 11 Nov 2024 18:53:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Sudheer
 Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: Re: [PATCH iwl-net 1/2] idpf: preserve IRQ affinity settings across
 resets
Message-ID: <20241111185334.447a5253@kernel.org>
In-Reply-To: <20241109001206.213581-2-ahmed.zaki@intel.com>
References: <20241109001206.213581-1-ahmed.zaki@intel.com>
	<20241109001206.213581-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 17:12:05 -0700 Ahmed Zaki wrote:
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> Currently the IRQ affinity settings are getting lost when interface
> goes through a soft reset (due to MTU configuration, changing number
> of queues etc). Use irq_set_affinity_notifier() callbacks to keep
> the IRQ affinity info in sync between driver and kernel.

Could you try doing this in the core? Store the mask in napi_struct 
if it has IRQ associated with it?

Barely any drivers get this right.

