Return-Path: <netdev+bounces-230619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E72BEBF48
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C748E4E1596
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0E9311C1F;
	Fri, 17 Oct 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3/kbx6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28673BB5A;
	Fri, 17 Oct 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741643; cv=none; b=jnhYhjiLnA0k51tKRz/q6NgmFllc86Hd3/ihOkDADQkx1HSlBIxApoxR295yRoaPXSG8CsswLurFAGfst6HzwRqyBTWd9rhFtQfk4JZL9DG59QIOfiHKrvdiaw3KBu1UWshD9VloBq2rMEvU97Dm3FewFBgJGozu9/XRA72oVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741643; c=relaxed/simple;
	bh=V10sQz9aYxYJxJYcb3C0Ry2ooh+vDe2FqE/6aRoHYK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mICVeRNc8NkFJu5jNwbkkUqjGsrThac4G3b9moODlnJTs9ve25buk1wuT+yGJgwpcsJiVsvS+NMz4Xxs2jAe+LgDgNNHfKOSgY4lwhSIibwgzaWy6npLpZwEU/zaQ1C1OrWRm4G2fBCd9T6EWJu9yN0yMXHZIA4covsHmPOqLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3/kbx6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3E5C4CEE7;
	Fri, 17 Oct 2025 22:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760741643;
	bh=V10sQz9aYxYJxJYcb3C0Ry2ooh+vDe2FqE/6aRoHYK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S3/kbx6gg7kKhcifJTJaqr5fMd6vjhxHX85nzs805tsiM22tdhtk/eRhkwFH+aRtL
	 /4hjUD6Sa6v1cPp1kPn/vLD3oADXFGzzvo1zDeIrrCBJlQtlrDX9tTqty6wGLBTGh6
	 DQBnU6C8EKWUT/4MBACr71nyZ4ZXkdQTS8t/l6K5wAVpl34Eoge5vnymjcdTHhdVNx
	 ErVgb63Ve/9Spj3WbjVp+alAMdKqaeEmDEI+FSEgbT2nQqv6izXgy07/xwn+OjR2YI
	 0bhJWxanM2HU8vd1BCo+8eQaqpzcWSPlc0snYBVwY+5lBNK0tN+JXWbTt5w2pn56bR
	 1MO8w9rr8mm+g==
Date: Fri, 17 Oct 2025 15:54:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <davthompson@nvidia.com>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2] mlxbf_gige: report unknown speed and duplex
 when link is down
Message-ID: <20251017155402.35750413@kernel.org>
In-Reply-To: <20251014161631.769596-1-cbabroski@nvidia.com>
References: <20251014161631.769596-1-cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 12:16:31 -0400 Chris Babroski wrote:
> The "Speed" and "Duplex" fields displayed by ethtool for the OOB
> interface should report "Unknown" when the link is down to match the
> behavior of other network interfaces on BlueField (implemented by the
> mlx5 driver). Currently, the mlxbf_gige driver always reports the
> initially configured link speed and duplex, regardless of the actual
> link state.
> 
> The link speed and duplex are not updated for two reasons:
>   1. On BlueField the OOB phy is internally hardwired to a three port
>      switch. This means the physical link between the phy and link
>      partner is always up, regardless of the administrative link state
>      configured with ifconfig.
>   2. phy_ethtool_get_link_ksettings() reads cached values that are only
>      updated when phy_read_status() is called by the phy state machine.
>      Doing "ifconfig down" will trigger phy_stop() in the
>      ndo_stop() handler. This halts the phy state machine and sets
>      phydev->link without calling phy_read_status() or explicitly
>      updating other values, so the speed and duplex returned by
>      future phy_ethtool_get_link_ksettings() calls will be stale.
> 
> While #2 could potentially be fixed (assuming this is even an issue for
> other devices), #1 is unique to BlueField.
> 
> Implement a custom get_link_ksettings() handler in mlxbf_gige that calls
> phy_ethtool_get_link_ksettings() and updates the speed and duplex based
> on the link state. When the link is brought down with ifconfig, the
> driver now reports unknown speed and duplex to ethtool as expected.

Are you sure you still need this now that 60f887b1290b has been applied?

