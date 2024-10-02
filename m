Return-Path: <netdev+bounces-131207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B898D386
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AD41F224A7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4D31CFEB7;
	Wed,  2 Oct 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6dQrt/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577331CF7D3
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873001; cv=none; b=lLvVus2iu5rD9hMnEHsFGOJDLDWKfri+5ysgotCfXyUpxz+sQw2a95ANLBEZ3bnITCKU+KRF/qwY5ikbE2blMGjRBKmuVa7QDoFEX6DZyPKsWhrljlpbqsSFL/JGc0GQBoPHqFFiaZEFV6q4/wi9yykGFGrN81jJtYzeGLxPqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873001; c=relaxed/simple;
	bh=4zzR5h724bVmGaF2gQoW9T5egTu0pcpbpoAa2lumnKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlhzekXeDBEW6p0mKBGxOWw6/i2aD8mXbiUNtNShaEluaZWnH+NXwoqBBeDg6oOi4Efg43sZdU0vPaide57u1GrczYtCzUjwMEzNDiZDJ7iGuLABBBlSHOL1I7YhUPC3WBt9ngTo2pNgq55suAH1himb1EII5n/vVcNhE48C7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6dQrt/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01821C4CEC5;
	Wed,  2 Oct 2024 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727873001;
	bh=4zzR5h724bVmGaF2gQoW9T5egTu0pcpbpoAa2lumnKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j6dQrt/yutflDP9RuKNbvnVMom8/OZXhKrQ2DHFPRLPI0/baIM7zjyzbF+JF4fxUI
	 Qg8wdkSQjMPcrpY7GVRRkhuOqc+ntTw5yeqP4u1A2LKHTLz3corpTcDAPcJvKznlr6
	 s2xomd04IsRbVRQcWyW6h2Xt0ORdNJ0HgV3hyspsaw/IeoG+8lhW6rc++qExSxnqXT
	 C56yK8pmx/jLom2r1ic+cB+BKiTIgLaAR5X/+LGRYKj5QuDCSJxhOT3WsTWALQPgzN
	 x5KyOkNPuOFacB86IyMTdq4JIbXc1nlFQvAAIgUQ4WuGJ6761S24K73f2tyMFjPtnW
	 80ZhWRj3923Gg==
Date: Wed, 2 Oct 2024 05:43:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Budimir Markovic <markovicbudimir@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: Use-after-free from netem/hfsc interaction
Message-ID: <20241002054320.75caf96b@kernel.org>
In-Reply-To: <CALk3=6u+PTcc2xhCx3YgWrx3_SzazpXTk1ndDmik+AOi==oq9Q@mail.gmail.com>
References: <CALk3=6u+PTcc2xhCx3YgWrx3_SzazpXTk1ndDmik+AOi==oq9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 16:53:15 +0200 Budimir Markovic wrote:
> Commands to trigger KASAN UaF detection on a drr_class:

Just to be sure - does it repro on latest Linus's tree? there had been
a couple of fixes recently for similar issues.

