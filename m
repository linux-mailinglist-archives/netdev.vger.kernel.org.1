Return-Path: <netdev+bounces-67410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BD8433FA
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 03:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6332904D9
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9F923A3;
	Wed, 31 Jan 2024 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K02wmjEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E8D292
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668499; cv=none; b=K49I7CdNI7PhSsKOwdMNWGqCVk971ItA4xKkvQKxYJdVrerusi/hyh9rrFBrQbn4IgMA3yUetpsXN472s8Hp0CNMcDfDtAX6IJXK8CDSKXyu/dMkMTULZZy4YTRCSl9lXahBuEreBcnvIEJ1LhIPxyMVBIRdKk+APxEmuhNX+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668499; c=relaxed/simple;
	bh=tajxnTE2oIe1t4zsc3T4ESLzcWY1bZLKahYby4g9nfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCAkBhHHeK8PfLtn7d+3ikNDLvIVIdM0T1gQ8zLNgAYZRHANf0Hqt2bg2XdApHtjQgzsNP4LdTKiJvCyjFo9iFjDpZsLSyE93nTxA4SNy1aiWK0JZxn5dOEN77aJT1Mk9Te6ooABdSU/rSXWTWPIly6CPTSHxqk4OxH2ggwLhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K02wmjEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F57C433C7;
	Wed, 31 Jan 2024 02:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706668499;
	bh=tajxnTE2oIe1t4zsc3T4ESLzcWY1bZLKahYby4g9nfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K02wmjEyRtVllyLFgwC522iKxFdoV5pABk62gOF5SHiAewu0SP7C2LWPdHMIqu/4D
	 odgS93KLSyOhz6rMsrTcTx784lOkxx2kI+aBkCY3tXMR6vUrYDUMygz3ZB6kszPIVh
	 wguR+Wx5pk6Q+f/8e0t/xxkNr7iZALBHGDCdEA5KmUDDv5mxlqVK8Pcpg6uRqls0Cp
	 utd4+tPbYFwFGBe5YM1iECPtwjyLJrgq5jN1z8QjRzO2XbeE2gzFQVdsRgtqMkfk0X
	 mhOTpN2TjAaCGHGFc3JhwcrIyoAnWpwMGwVE5R/55QV0YGRxyLZTWISxr9DB8Y19mI
	 +JWmDhesyMGcw==
Date: Tue, 30 Jan 2024 18:34:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 willemb@google.com, David.Laight@ACULAB.COM, kernel test robot
 <lkp@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Paul
 Menzel <pmenzel@molgen.mpg.de>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] idpf: avoid compiler padding in virtchnl2_ptype
 struct
Message-ID: <20240130183454.5c6f4bea@kernel.org>
In-Reply-To: <20240129184116.627648-1-anthony.l.nguyen@intel.com>
References: <20240129184116.627648-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 10:41:14 -0800 Tony Nguyen wrote:
> While at it, swap the static_assert conditional statement
> variables.

Sorry but there should be no "while at it"s in a fix.
There's hardly any relation between the two changes.
-- 
pw-bot: cr

