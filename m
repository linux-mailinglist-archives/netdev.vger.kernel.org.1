Return-Path: <netdev+bounces-229823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09995BE113D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECE584E2297
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B9366;
	Thu, 16 Oct 2025 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK/VVQL+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC031114
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573246; cv=none; b=om723LBJ+NdHDx5mrdBNCn3rVE1yvNRtnB20gndJu1kxvYUlAcZ2qhMNSXYEAzkFxxnoqKW1zl/0xQeXmd3rmKDzxoM5w1uiFOKj9lamhmWpt3X8LNb0rNxjgOU0526A/I86c4aes4LzdCaVMfxhGejcdxYYjsDOa+YNEYrplUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573246; c=relaxed/simple;
	bh=b6jazeUYZp6lhxpnYKhiLXoYaxCNq2X5YQ7RE3wvG5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRHi8y/dZ7XK/AupAuPA9C256kFloOwD7fp/WwlQduZCkgBX675qKK8vSZ/aQC9CxzLQ4UdECyex1pEaGJdeeg/xCtS3QVI0whmCMfAKMCkGkiAjQ8pYI+yA12d86dZXiTnLAviXVQ7vZu4k0kOVjrJq+naVdOtxTUmNyf9qm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK/VVQL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C630C4CEF8;
	Thu, 16 Oct 2025 00:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760573245;
	bh=b6jazeUYZp6lhxpnYKhiLXoYaxCNq2X5YQ7RE3wvG5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DK/VVQL+N87OPiurwV2DCXUb0pCltlnggD+hF/lIvbozZQKS1LroEBXgw5PXMOTDU
	 X0BDNJQ9aKX9puRRINZkBvtkfm+MAaK5uNrvuxsZN/Q+akKTYf3u8rgX/sUpzNYqHF
	 tIippMC9yGfNMKIY8nWkWx2Fn6xZtY4GD8+dTU+2ttUiOwR3eicH/WxcxjECZOH9q5
	 pCvrz2fvhFsUaediQ0wbLJtBJobhRnf+l7o+pTCWNMNzLS400tibePLsughzYm4M8U
	 41iAKZRWtvhrL3KevyV2JQqxnfcGdA+WA3ePjyM6YVrlh/fHg2RrGjCYAgyliW3K/d
	 USch2Riq00KwA==
Date: Wed, 15 Oct 2025 17:07:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [Bug 220649] New: A bug is happening at
 __dev_change_net_namespace when runnning LXC/Incus service in 6.17
Message-ID: <20251015170724.7bd269f5@kernel.org>
In-Reply-To: <20251015150238.6849de11@hermes.local>
References: <20251015150238.6849de11@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 15:02:38 -0700 Stephen Hemminger wrote:
> Begin forwarded message:
> 
> Date: Thu, 09 Oct 2025 13:08:57 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 220649] New: A bug is happening at __dev_change_net_namespace when runnning LXC/Incus service in 6.17
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220649
> 
>             Bug ID: 220649
>            Summary: A bug is happening at __dev_change_net_namespace when
>                     runnning LXC/Incus service in 6.17
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: kosmx.mc@gmail.com
>         Regression: No
> 
> Created attachment 308780
>   --> https://bugzilla.kernel.org/attachment.cgi?id=308780&action=edit    
> Archive containing the dmesg slice with stack trace, and the git bisect log

To avoid splintering discussion - this duplicates:

https://lore.kernel.org/all/01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com/

