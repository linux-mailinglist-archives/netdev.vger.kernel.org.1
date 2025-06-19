Return-Path: <netdev+bounces-199500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A0AE08D6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A1E16925B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F917E0;
	Thu, 19 Jun 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywt737IG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F71EE7D5
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343613; cv=none; b=nJ99NlOMyTJh5FAfb4U7MRO0vTdbVDmEKTWbVx20DE59zAnstHddnMpl8zkn8A2WofPQFbvdutMPGRNcU+r5lILzHltxn8cToXgIGXSvCeQf75BWJpmeNAZRc7wEHo5fK4yYXxZCXskMyH3OERZviRApjiQeIRkSxxk0/lgPU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343613; c=relaxed/simple;
	bh=3+tfJQYQzy718nuf9SV9iezYQVpUkYexamn8JxA65LM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTFBpSJmmjXFTHJGx+v1zisV2KVLA3TW2UuMklhY2PMPEt3NSl9p/5F71tCHIHMgmWlNLTOMlDs525ufIzHwA6qk4RZEIcSJRr6COXXJgwpFbU5AKn3feVbnlCBrg1fBPVCvLIHrpbxKWUokdHKWtbKMau0+g2vo+LAjRpi6OBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywt737IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317B0C4CEEF;
	Thu, 19 Jun 2025 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750343612;
	bh=3+tfJQYQzy718nuf9SV9iezYQVpUkYexamn8JxA65LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ywt737IGNlUq01p2asBz7rtRWB07P44AsrePKiMJnLn2E41if2KYonn32XeNfFjQK
	 HqFdn01F9JfThMCmv2v2d+wMWaAMrvNHKBEBUm5FHi86WFA+XZlkB8N8dap4NAn5/E
	 QDAR+DXF/ppFmbroU7iHIygRg01KVaU2xIEJi1X9KpTuW3rHh7qqBFqpgN7dOEYC1n
	 q5i17XoEgDNY8RfQdGjL2s0ELaBbnJDn0dnJwYJldIEl3Ur1dL5FsJg8ZLs3Ry3HSf
	 4lb0sXSYgA+1HyQ/vxz2oAgsLamotRRK3SpSZK5xPcisWyj9mOwS4eT9iHJvXffNWW
	 hkkHfQmvpXrZA==
Date: Thu, 19 Jun 2025 07:33:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net] tools: ynl: fix mixing ops and notifications on one
 socket
Message-ID: <20250619073331.354a270a@kernel.org>
In-Reply-To: <m234bwgmss.fsf@gmail.com>
References: <20250618171746.1201403-1-kuba@kernel.org>
	<m234bwgmss.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 09:25:55 +0100 Donald Hunter wrote:
> Good catch, fix LGTM. It looks like a followup refactor could combine
> annotate_extack and _decode_extack and get rid of the attr_space
> parameter to NlMsg(). WDYT?

Indeed, sounds like a step in the right direction!
extack is a tricky thing to fit into an object model :(

